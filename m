Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB6C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B1D613CA
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFJJX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJJXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:23:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E43C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:21:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6071971wmh.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MJkNaJ+3OBAnM1GSXfxp1g4imDhoD/iEvK+TCLP151g=;
        b=TDOpOabRMHNcrUP9+Aoo6ww3+Dp9/YB9bkpCNW76D1yFQN3BDaLo5hVx2zZgQF9N9R
         /Pc8k2YuRcmrYCPevnpWESimx6EeNPgTMrC78IMs5Fc93dvHeX2XKwfCnJ1K/jocraLx
         YnWKlGrNefmk5sj9iuiD6qzPtbDS1kncUdxBRz/UG8H3AJe7iG+1DnhEG7gZJG+slPsH
         aAx5CUnKJwThgx0ten2va19vTVVbnWbwwbKUT2W3pNID8tk/fKIADT2L8HVWBHxaQIPK
         YnqmFT7rGAsIno6E03IZjoy2/7bzYPbmZay7CdUBNKmBJSqEJUzx82QvI6IfEUht40t5
         iJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MJkNaJ+3OBAnM1GSXfxp1g4imDhoD/iEvK+TCLP151g=;
        b=FeImsUj0p69CcO8ZlU/86Cb3OiLPAxFDujgvoWAytXWSLP5X9ng1bJlxkLMFsyWnoW
         Hi+gU7cIhhhtoIgfIfRDqjcEXcgETKmrj+WkOyfoNChv60VJIP7ZVqLh17wxnU5PQN4J
         8kPfrTMdg1I/e/t4W+RUBOdtRC4UmjUZ1E8m4EztYxlmoDX54tJlZb1yP35U+2Kt92S8
         9lMkPcxAHdkcCsA82CMXEpb8nAYQfYUPjt2MtAjAqRJ1K4MI3Nr7mG2sLVfdFiVRU/nY
         q5ZG6pkzVytDpEf9fjMXUCwrCbdGUxtI5907TQltJXm6vDcAoU0gDhLSb4jwRbXGXyfZ
         tWbw==
X-Gm-Message-State: AOAM533n6LEX96f6CGg1/pXy38TZkwjQrNhJ/HEWYc62zC9P6FhfX4v0
        ccfO6/ZJtmbBcQFUXaCKexE=
X-Google-Smtp-Source: ABdhPJyuF6x7R7rpAtSf3Cb6XdFzd1mZrnXAYyWCOX4O/WQdNPJmBp1MbztorQK3+RDlMY+T7aIlYA==
X-Received: by 2002:a05:600c:2dd0:: with SMTP id e16mr4110704wmh.180.1623316906143;
        Thu, 10 Jun 2021 02:21:46 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id a3sm2929336wra.4.2021.06.10.02.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 02:21:45 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/7] xdiff: rename XDL_MERGE_STYLE_DIFF3
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-6-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3168eb15-25a6-a3eb-a498-8effa0c79855@gmail.com>
Date:   Thu, 10 Jun 2021 10:21:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609192842.696646-6-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2021 20:28, Felipe Contreras wrote:

The subject would make more sense as 'xdiff: rename XDL_MERGE_DIFF3 to 
XDL_MERGE_STYLE_DIFF3' rather than using the new name of the constant alone.

> If we don't specify we are talking about a style, XDL_MERGE_MINIMAL
> could be confused with a valid value instead of XDL_MERGE_DIFF3, which
> it isn't.

I don't object to the rename but what is the source of the confusion 
with XDL_MERGE_MINIMAL?

Best Wishes

Phillip

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   builtin/merge-file.c | 2 +-
>   xdiff-interface.c    | 2 +-
>   xdiff/xdiff.h        | 2 +-
>   xdiff/xmerge.c       | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 06a2f90c48..a4097a596f 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -33,7 +33,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>   	int quiet = 0;
>   	struct option options[] = {
>   		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
> -		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_DIFF3),
> +		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_STYLE_DIFF3),
>   		OPT_SET_INT(0, "ours", &xmp.favor, N_("for conflicts, use our version"),
>   			    XDL_MERGE_FAVOR_OURS),
>   		OPT_SET_INT(0, "theirs", &xmp.favor, N_("for conflicts, use their version"),
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 609615db2c..64e2c4e301 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -307,7 +307,7 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
>   		if (!value)
>   			die("'%s' is not a boolean", var);
>   		if (!strcmp(value, "diff3"))
> -			git_xmerge_style = XDL_MERGE_DIFF3;
> +			git_xmerge_style = XDL_MERGE_STYLE_DIFF3;
>   		else if (!strcmp(value, "merge"))
>   			git_xmerge_style = 0;
>   		/*
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 7a04605146..45883f5eb3 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -64,7 +64,7 @@ extern "C" {
>   #define XDL_MERGE_FAVOR_UNION 3
>   
>   /* merge output styles */
> -#define XDL_MERGE_DIFF3 1
> +#define XDL_MERGE_STYLE_DIFF3 1
>   
>   typedef struct s_mmfile {
>   	char *ptr;
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 1659edb453..f6916a4ba4 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -230,7 +230,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>   	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
>   			      dest ? dest + size : NULL);
>   
> -	if (style == XDL_MERGE_DIFF3) {
> +	if (style == XDL_MERGE_STYLE_DIFF3) {
>   		/* Shared preimage */
>   		if (!dest) {
>   			size += marker_size + 1 + needs_cr + marker3_size;
> @@ -482,7 +482,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
>   	int style = xmp->style;
>   	int favor = xmp->favor;
>   
> -	if (style == XDL_MERGE_DIFF3) {
> +	if (style == XDL_MERGE_STYLE_DIFF3) {
>   		/*
>   		 * "diff3 -m" output does not make sense for anything
>   		 * more aggressive than XDL_MERGE_EAGER.
> 
