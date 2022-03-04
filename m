Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C1C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 07:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiCDHqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 02:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiCDHqP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 02:46:15 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48077192E14
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 23:45:28 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76D8D10BB6B;
        Fri,  4 Mar 2022 02:45:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Huy3Qb7ne81a+lYQoy2R0LOE8VS4rFJ9NCkXhZ
        SISv8=; b=AgoSi63UMBQsN9Fq318WoJKwIp0KCb7QHCNlKoPSil/fePDv6OqSBp
        ZfP6IGk19VDCEZlzUWuDrbqB/45BrQvHulkQ+BIu89HZ12gvMUU3OXXvEHvd1DMK
        NMm8E5opzkO1apHrbtMDLXRgvlRCCYHKneDVOhrbEuUJB0NYy1mFg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DA8E10BB69;
        Fri,  4 Mar 2022 02:45:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA17710BB68;
        Fri,  4 Mar 2022 02:45:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matheus Felipe via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matheus Felipe <matheusfelipeog@protonmail.com>
Subject: Re: [PATCH v2] fix: include the type flag in the cli docs
References: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com>
        <pull.1220.v2.git.git.1646368313714.gitgitgadget@gmail.com>
Date:   Thu, 03 Mar 2022 23:45:25 -0800
In-Reply-To: <pull.1220.v2.git.git.1646368313714.gitgitgadget@gmail.com>
        (Matheus Felipe via GitGitGadget's message of "Fri, 04 Mar 2022
        04:31:53 +0000")
Message-ID: <xmqq8rtq2may.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E97CE9A-9B8F-11EC-9608-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matheus Felipe via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2] fix: include the type flag in the cli docs

One more (hopefully final) nit.  By reading the above alone (which
is what people will see in "git shortlog --no-merges" output), you
can not even guess which subcommand the "fix" is about, or if it is
even a fix to the code, or just a documentation update.

I'd retitle it to

	config: correct "--type" option in "git config -h" output

> From: Matheus Felipe <matheusfelipeog@protonmail.com>
>
> The usage help for --type option of `git config` is missing `type`
> in the argument placeholder (`<>`). Add it.

Good.

> diff --git a/builtin/config.c b/builtin/config.c
> index 542d8d02b2b..2aea465466b 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -151,7 +151,7 @@ static struct option builtin_config_options[] = {
>  	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
>  	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
>  	OPT_GROUP(N_("Type")),
> -	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
> +	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),

Good again.

Thanks.  Will queue.
