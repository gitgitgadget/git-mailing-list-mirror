Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CBCC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2D6600D4
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhKLWUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:20:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64884 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhKLWUY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:20:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27B9C1709FA;
        Fri, 12 Nov 2021 17:17:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=daZbyCutCN1DX5hYXtTeLehBq3/Dv9ChodelT6xBlk0=; b=aTwu
        KhMV+hG3agT0ltrQKCwu9MdiAdlgM+AefZIM1kf/60oDnqieEFYq6JUnwnfZJXF1
        ZB/P9FSLxANeBmQcLcHanSZ4mcy6ZBU7PSm18/kOBPIyROlKb7rhtf2xsun+RPBc
        Jngs0raKE6fPKXjVkrUXbBO2UNKgmMK7L/Zt98g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FBC51709F9;
        Fri, 12 Nov 2021 17:17:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 809AE1709F8;
        Fri, 12 Nov 2021 17:17:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v2 1/4] doc: git-format-patch: specify the option --always
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
        <71e6989375c9b8dd00151481e0bb19c991e673f3.1636700040.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 14:17:29 -0800
Message-ID: <xmqqpmr5ow7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53A497E2-4406-11EC-BE59-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aleen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aleen <aleen42@vip.qq.com>
> Subject: Re: [PATCH v2 1/4] doc: git-format-patch: specify the option --always

"specify" -> "describe", perhaps?

> Signed-off-by: Aleen <aleen42@vip.qq.com>
> ---
>  Documentation/git-format-patch.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 113eabc107c..a9f2bf94182 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -30,6 +30,7 @@ SYNOPSIS
>  		   [--range-diff=<previous> [--creation-factor=<percent>]]
>  		   [--filename-max-length=<n>]
>  		   [--progress]
> +		   [--always]
>  		   [<common diff options>]
>  		   [ <since> | <revision range> ]
>  
> @@ -388,6 +389,10 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  --progress::
>  	Show progress reports on stderr as patches are generated.
>  
> +--always::
> +	Patch commits with detailed commit messages,
> +	even if they emit no changes. (see linkgit:git-diff-tree[1])

What does the verb "Patch" mean here?  It cannot be what the command
"patch" does, i.e. apply a diff to working tree files, as
format-patch does not apply any patch.  

Who guarantees that commit messages are detailed?  If I write a
commit that does not change anything with a one-liner message, would
this option make that message more detailed?  I doubt that it would
be the case.

This option may sit much better near the --ignore-if-in-upstream
option.  The primary way the command is told which commits to show
is via its argument (<since> or <revision-range>), and we do not
have many options to affect the selection of commits, but this one
and --ignore-if-in-upstream are such options.  Borrowing from the
way the description of that other option is phrased, perhaps

    Include patches for commits that do not introduce any change,
    which are omitted by default.

Do not refer to 'git-diff-tree'; I do not think the reader who is
learning how to drive format-patch will learn anything new by
reading that page.

I have a feeling that if we were to endorse and promote this option
by documenting (note: it was an accident and a mistake that this
option is understood by underlying revision.c parse machinery, and
not a designed behaviour for format-patch to do anything to empty
commits), we should give users a better synonym to invoke it, but
that can and should be outside of this step.
