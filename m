Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CC6EEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 21:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbjIHVxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbjIHVxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 17:53:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFD0E46
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 14:53:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EC361A7FA7;
        Fri,  8 Sep 2023 17:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=O8MRry99leG6Af2qOdJ1V814Qs2PcFaZvojCKr
        DvzTw=; b=Ese+4a/XcDmIyORj1kdsTLQSRvhgi8fEqDnewPojYxcYTBeWywBufW
        9kATjZWyGLMpl6ZXnQOsIbUXpB6423d3MIbolpzxT9E7nBLCdA8griCmnIx7HkEy
        O5RbkKZOVoyQ2Z4k7amYgAJgDw8I92OqZsVi0gU7eLLI20gX+5Arc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 168A11A7FA5;
        Fri,  8 Sep 2023 17:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BE641A7FA4;
        Fri,  8 Sep 2023 17:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 06/13] trailer --no-divider help: describe usual
 "---" meaning
In-Reply-To: <3e58b6f5ea264a2c42ffbd008405b46626e0f864.1694125210.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Thu, 07 Sep 2023 22:20:02
        +0000")
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
        <3e58b6f5ea264a2c42ffbd008405b46626e0f864.1694125210.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Sep 2023 14:53:46 -0700
Message-ID: <xmqqbkecs55h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3028C6A6-4E92-11EE-9FB7-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> It's unclear what treating something "specially" means.

Good.

>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  builtin/interpret-trailers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index cf4f703c4e2..a7623dbfb2e 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -109,7 +109,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
>  		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("set parsing options"),
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
> -		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat --- specially")),
> +		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat \"---\" as the end of input")),
>  		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
>  				N_("trailer(s) to add"), option_parse_trailer),
>  		OPT_END()
