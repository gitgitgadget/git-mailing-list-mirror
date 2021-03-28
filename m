Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48C8C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 07:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5D861974
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 07:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhC1G4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 02:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhC1G4b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 02:56:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0336C061762
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 23:56:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v8so2894096plz.10
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JelILj+HeP3atK90aSNkhyjsNyHyw77JpjJ0VMs+jLo=;
        b=VRz1RgjGIMQeVdcBWATEYODzbmZ3Faj3N36SIPjn66EX010waZOtk540QWcKNfQOo9
         PFY35ecvlLrgzzBVsHbDoP/GSxti1uY1BOt4zmcFPEn5QlL0JTy5oAgJNkFFKoRqbGZ/
         8UvPXgD1qHfRQCdbKxn6eymls4Lvw30k8SPoc57GGKU/0GmceB6svSDrJyCsiGJj8TGz
         9Y4Ox2LFN0all4G+seX3Dh+m9WzzYJdKJcujTOyaaIdxvClDYZpScAiDW24TxBc11Hrs
         +OutqSdyW/C4bgQOVmPqYXjdZvSbhrtmmcqMMEVkHfJ1AJMLQrTecsM7qDeQU3Qpr07t
         cPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JelILj+HeP3atK90aSNkhyjsNyHyw77JpjJ0VMs+jLo=;
        b=QCkxKBWnLFBxUHu3+5L03+YlSeNTEn80acf9Rn/SZDFw+j2qybClphpJavGzy5o0cm
         R2shvut9O9EfMnB9d3z2uYr7z4wuXVjdcEYODLCLZKUfpYgTGNA6ybWCVGzsI1UtVBCi
         Rl3Xr+goGiwjTP6oFi6igtB85j4stjW22ZIhtR164FhG2uaax0JRefqWjJDje7bjukL9
         uNwA1gOsJ/GXtn5kmnQU8j2tJbstFTO5weIYctKPEmzinlHBN2Xu1YOUCZy3alJVXMiw
         9LApsMrBC6txUNao7/ou+WHkMbblVyTjmJCZC0jYnGQcHl/ggQcdVsCJGzbfhTmJXBjO
         Z1zg==
X-Gm-Message-State: AOAM533HAiWWaCKylLwQcnZllu3kCWPxzA8oG1UQYKguupp0pbqmMi88
        pATjxZLeNFeBx8+7iDswS05IA7HNxTAsJw==
X-Google-Smtp-Source: ABdhPJxYqOYCw8eJ9cfpHS+CG6BbMg7qTlzDFB1A99/gMWZQfvr/Mv8FA8U+tbfRBDOk5NLR/uqTsA==
X-Received: by 2002:a17:902:263:b029:e7:35d8:4554 with SMTP id 90-20020a1709020263b02900e735d84554mr7329543plc.83.1616914567702;
        Sat, 27 Mar 2021 23:56:07 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-8.three.co.id. [116.206.28.8])
        by smtp.gmail.com with ESMTPSA id a29sm10741305pfg.130.2021.03.27.23.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 23:56:07 -0700 (PDT)
Subject: Re: [PATCH] Documentation: amended usages of various (sub)commands
To:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Chinmoy <chinmoy12c@gmail.com>, git@vger.kernel.org
References: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <e85a653c-2650-313d-b5ca-5874559d9528@gmail.com>
Date:   Sun, 28 Mar 2021 13:56:04 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/03/21 13.34, Chinmoy via GitGitGadget wrote:
> From: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> 
> The Git suite option parsing API's Technical Documentation suggests this
> about the option descriptions of a (sub)command:
> 
> `description` is a short string to describe the effect of the option.
> It shall begin with a lower-case letter and a full stop (.) shall be
> omitted at the end.
> 
> Various (sub)commands' option arrays don't follow the guideline provided
> by the parse_options Documentation regarding the descriptions.
> 
> Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
> ---
>      Documentation: amended usages of various (sub)commands
>      
>      The Git suite option parsing API's Technical Documentation suggests this
>      about the option descriptions of a (sub)command:
>      
>      description is a short string to describe the effect of the option. It
>      shall begin with a lower-case letter and a full stop (.) shall be
>      omitted at the end.
>      
>      Various (sub)commands' option arrays don't follow the guideline provided
>      by the parse_options Documentation regarding the descriptions.
>      
>      Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-920%2Fchinmoy12c%2Fissue_636-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-920/chinmoy12c/issue_636-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/920
> 
>   builtin/column.c     | 8 ++++----
>   builtin/range-diff.c | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/column.c b/builtin/column.c
> index e815e148aa18..40d4b3bee2dd 100644
> --- a/builtin/column.c
> +++ b/builtin/column.c
> @@ -27,10 +27,10 @@ int cmd_column(int argc, const char **argv, const char *prefix)
>   		OPT_STRING(0, "command", &real_command, N_("name"), N_("lookup config vars")),
>   		OPT_COLUMN(0, "mode", &colopts, N_("layout to use")),
>   		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
> -		OPT_INTEGER(0, "width", &copts.width, N_("Maximum width")),
> -		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("Padding space on left border")),
> -		OPT_INTEGER(0, "nl", &copts.nl, N_("Padding space on right border")),
> -		OPT_INTEGER(0, "padding", &copts.padding, N_("Padding space between columns")),
> +		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
> +		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding space on left border")),
> +		OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border")),
> +		OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between columns")),
>   		OPT_END()
>   	};
>   
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index 78bc9fa77062..50318849d657 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>   	struct option range_diff_options[] = {
>   		OPT_INTEGER(0, "creation-factor",
>   			    &range_diff_opts.creation_factor,
> -			    N_("Percentage by which creation is weighted")),
> +			    N_("percentage by which creation is weighted")),
>   		OPT_BOOL(0, "no-dual-color", &simple_color,
>   			    N_("use simple diff colors")),
>   		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
> 
> base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860
> 
Wait, I expected that this patch touches Documentation/* (as the title implied),
but it seems like the patch content is something else (not related).

Totally wrong patch submitted here.

-- 
An old man doll... just what I always wanted! - Clara
