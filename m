Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC7C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41B561CAA
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 23:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGFXWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 19:22:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57548 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGFXWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 19:22:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5ACDE14A690;
        Tue,  6 Jul 2021 19:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uElEJ/wAHtZv+FClnZk0oPupWmEOHhcbvGF/lq
        9qJ/Y=; b=o1VkNJueVqsY6nt5l3FmaZLm/WVRyU6DJ7e6D2piZE2Wyde/OV0RcH
        vv+MopWnzBEV7IfQDZKGzl4U+IVwlGv9tvVE1cjzkv2EkXSTRWCVEurFJLcyw4Rq
        kryy/CpzoQhNphWPT6yL6y6NNENfo3vHhRe4C93ZF9Bstskr1jQlI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5334214A68F;
        Tue,  6 Jul 2021 19:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C713014A688;
        Tue,  6 Jul 2021 19:20:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/7] ci: speed-up the Windows parts of our GitHub
 workflow
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 16:20:06 -0700
In-Reply-To: <pull.878.v3.git.1625439315.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sun, 04 Jul 2021 22:55:07
        +0000")
Message-ID: <xmqqv95nf2s9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3DFAFFE-DEB0-11EB-9FD8-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series upgrades to newer versions of a couple GitHub Actions we
> use, and also streamlines the Windows jobs using the relatively new
> setup-git-for-windows-sdk Action
> [https://github.com/marketplace/actions/setup-git-for-windows-sdk] (Git for
> Windows is running with this Action for a while now, getting all the kinks
> out).
>
> This patch series should also address the problem where seen was pushed so
> rapidly that the windows-test jobs failed because they no longer checked out
> the identical revision as the windows-build job.
>
> Changes since v2:
>
>  * Made the handwaving make [...] NO_GETTEXT comment in the commit message
>    of the patch "artifacts-tar: respect NO_GETTEXT" more explicit, by
>    setting NO_GETTEXT to a bogus value as required by make.
>  * Added an explicit NO_GETTEXT=YesPlease to the make artifacts-tar
>    invocation in the vs-build job, as well as an explanation in the
>    corresponding commit message why this explicit mention is technically not
>    required.

The above indeed helps the CI at GitHub.  The last run with 'seen'
can be seen at https://github.com/git/git/actions/runs/1005977569

Thanks.
