Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD08C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3804206B7
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbhAUXq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:46:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52829 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbhAUXqy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:46:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 284A4B45C0;
        Thu, 21 Jan 2021 18:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fq8VNVoLDjXn1zzLlfzBkmKSfrA=; b=SiS/cc
        7+tAzJLTN5Ae9CntYx95huPr/EEc5MrKzetPBkkEG2WxgWwMQ933UeFFqecad+Ir
        ZisLfT9zeBHb8ulIWt2xW86W4/e63knQwRr0PYHX6ly35G7jInXLtKH+gsL+6jqK
        mMqwOJ8WMYniDNchbxFAfoY+hHrP98x9GO9bA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fAlRH0plazBFm34BCc7iWcFlB/4XSDgb
        fJlgs/IbpOUWqunQ6VI8Mi/BPfbHHlg4QLv79Ellr/omqqT7Bj2ZfUFV5iK1CZ05
        JHzymxCEuUZDqjMSsmaRaQ24STFUjwOHnpxgI+5MmzonIQazOY13ABnDSIp4ypBB
        XQ22lJX9c/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 209D5B45BF;
        Thu, 21 Jan 2021 18:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA49EB45BD;
        Thu, 21 Jan 2021 18:46:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] range-diff(docs): explain how to specify commit ranges
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 15:46:11 -0800
In-Reply-To: <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 21 Jan 2021
        22:20:38 +0000")
Message-ID: <xmqqwnw5am64.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D772A354-5C42-11EB-BB4C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> There are three forms, depending whether the user specifies one, two or
> three non-option arguments. We've never actually explained how this
> works in the manual, so let's explain it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-range-diff.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> index 9701c1e5fdd..76359baf26d 100644
> --- a/Documentation/git-range-diff.txt
> +++ b/Documentation/git-range-diff.txt
> @@ -28,6 +28,19 @@ Finally, the list of matching commits is shown in the order of the
>  second commit range, with unmatched commits being inserted just after
>  all of their ancestors have been shown.
>  
> +There are three ways to specify the commit ranges:
> +
> +- `<range1> <range2>`: Either commit range can be of the form
> +  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
> +  in linkgit:gitrevisions[7] for more details.

Good.

> +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
> +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
> +  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is the
> +  merge base as obtained via `git merge-base <rev1> <rev2>`.

Does this merely resemble?  Isn't it exactly what a symmetric range is?

> +- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
> +  <base>..<rev2>`.

Nice to see this documented.

Thanks.
