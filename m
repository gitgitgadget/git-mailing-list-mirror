Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA5C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD29C2075F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TLVx+IBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbgI3WVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:21:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53783 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgI3WVK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:21:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2ED53102A12;
        Wed, 30 Sep 2020 18:21:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+5K6FxhXGVx2UNU1l1MCjf451yI=; b=TLVx+I
        BfUmOSHzkC4VoodinDk7u7qJnfivbBCKpGkPKczABM97WZEDM9UmjxbBb1CevhE+
        ljI/59aV6Ghk5eENZecgxewvDALPg97phV7h641+/81NQijmBMuAgSOBIgje4B4R
        flzDtTgs9H/mrqv6NeloynN0j6tlsZmTtwEMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fGaXPuVojoC8cN8+hw+l/mE0AYhYuQfe
        y+0qCxE0GQJEahnICryEPobI5BzEcS7aa9WJTXeJFXWaRNpEh5X4onoDGAoXBO/O
        cbBFBYklwmuiDRztuuid74QJ18fFk54Vd50TOhP6gkgmG0An6YzeHFgxxBXc7zir
        /W0m6IcCaiY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 275E9102A11;
        Wed, 30 Sep 2020 18:21:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C22A102A10;
        Wed, 30 Sep 2020 18:21:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/5] Inclusive naming, part II
References: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
        <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:21:02 -0700
In-Reply-To: <pull.734.v3.git.1601154262.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sat, 26 Sep 2020 21:04:17
        +0000")
Message-ID: <xmqqimbugb3l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A9AED46-036B-11EB-B363-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series represents the logical next step on the journey begun with
> introducing init.defaultBranch: in these patches, we avoid a couple
> unnecessary mentions of the branch name "master".
>
> This patch series does not try to change the default branch name, although I
> have that patch series ready to go. You can see the overall idea here: 
> https://github.com/gitgitgadget/git/pull/655. Concretely, I plan on
> submitting three more patch series after this one:
>
>  1. a relatively small patch series to avoid using the branch name main in
>     the test suite. This is necessary because my plan is to change the
>     default branch name to that name, therefore it cannot be used as the
>     name of a topic branch any longer.
>  2. a relatively large patch series (currently consisting of 18 patches) to
>     change the default branch name to main. Most of the patches provide
>     non-trivial (read: non-scriptable) adjustments to the test suite in an
>     incremental fashion, with a big patch toward the end that reflects a
>     fully-automated search-and-replace of all the trivial cases.
>  3. a very small patch series with fall-out patches that are not necessary
>     to pass the test suite, but are still required to complete the rename
>     (adjusted code comment, file rename).
>
> (Note: I am still debating whether I should move one or two patches from the
> second to the third patch series)
>
> Changes since v2:
>
>  * Extended the idea of using topic instead of main to patch 4/5.
>  * Explained in the commit message of patch 5/5 why we cannot use topic 
>    instead of main here.

This round hasn't seen any new comments.  I quickly scanned them one
more time, and it seems to be in good shape.

Shall we merge it down to 'next'?

Thanks.

