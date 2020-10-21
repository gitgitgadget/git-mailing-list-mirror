Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C0AC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F123324198
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SxNbKNoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505579AbgJUWAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:00:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59072 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505531AbgJUWAC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:00:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD43390D9C;
        Wed, 21 Oct 2020 18:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dNGGDcJDNx4EeayuA8AUYeaEnms=; b=SxNbKN
        oUWkOgxxRqbaXMV3eLKQW5QgdFZg4jQgWuwJBWHtpjRk0/u5cfbXrrOg+Ceps8yr
        mqNvPNFu1piXD42PDRg+CRY/bY1RKoXb+BRL6/gnRZzt1BuGS5dKmOTBtMVB8pEr
        Wf63rHaFQD+BaPCMJG9jlyew99HMaStkEl++Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C8rlHRkOW4IzUdvQibFf8Ovze2SlPFiC
        /yBmpL8C6AjOiUudpEZ/62Sts1SzsiMpHvCOFI/8+YPKc5ls7L7FzCXQJPbnXW31
        cLbBJw1B2itWrV7kere55K2siodSq7Hq+XDkBRQRwjJ6ftO7q+gAI/uj83PBUmQJ
        hRW7jaKwu5g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8474390D96;
        Wed, 21 Oct 2020 18:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C034090D85;
        Wed, 21 Oct 2020 17:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/10] Prepare for changing the default branch name main
 (last manual part)
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 14:59:59 -0700
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020 19:31:31
        +0000")
Message-ID: <xmqqblgv5jfk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C37D4932-13E8-11EB-812E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In preparation for changing the default of init.defaultBranch to main, here
> are a couple of manual adjustments that cannot be automated (i.e., these
> adjustments are not mere search-and-replaces).
>
> This patch series is based on js/default-branch-name-part-3, and is part of
> the larger effort tracked at https://github.com/gitgitgadget/git/pull/655.
>
> The next patch series will be largely automated search-and-replaces;
> Obviously, the search-and-replace was the easy part, the manual inspection
> whether the changes are actually correct was much more involved.

Yes.  That's always the pain-point of a tree-wide change like this.

> What to expect next, after this patch series? Essentially, there is the
> large patch series that adjusts the entire test suite, with two patch series
> extracted from that effort: t5411 and t5515 simply require too large
> patches, and will therefore be presented as the next patch series after this
> one.

This one is already a bit too ambitious in that it collides with
stuff in flight, by the way.

