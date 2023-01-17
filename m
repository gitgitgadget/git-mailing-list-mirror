Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B791C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 15:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjAQPZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 10:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjAQPY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 10:24:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405541B4E
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:24:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vw16so13016613ejc.12
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 07:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFf8zElL5F5+VHAdyVtZr96KnpSgaCTXXs3zJzo/K2w=;
        b=W/on3CwJe+qwvv2DtngSp5+xd34NZ279vB4mcwEh/K5kuKos5R9hCC224Uzft4NcuB
         gzb3RKd21CqsNW3nsTRaErq3SLgbL9Nx1hUuSP0AOnFCc2q0FitlJjsCMrHRu+4oRZCo
         hHnCI1hxRklbaeCtbOtWqZprgITQaeNqruG+qm/y+bNUbPg4rlf2YGlPWI1COk0ow57A
         jOZ/Kz8rQnuxLbcsNtNrJUT7g562lm6uzaNzOyYSYFE/puqeml2lAfuGHVk3nlx1yi1Y
         VabXVJVLl2OFvrw3AfExE2UlYFucwoIVFCRqTIUO3IDbCOFVXfUexZsV0WT5w00iR84P
         TOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFf8zElL5F5+VHAdyVtZr96KnpSgaCTXXs3zJzo/K2w=;
        b=jP5gSvKamnWIiTENh2QCeq134yNPYmHAnimm4ByxmeZdeyW54Ov5iAAZbP97/xOgsr
         egsTe9SjXqor8Qt22AKpIOhobOLk9L96i4GrAaP8UT+xZ8FMHUTukcG0G1qgVsDEm39J
         L1VJdBDIC5+SEj0V9UvV6qGWg4UuMoU9rZlFTZZJ1o3fFnM2oeTcX77c1L3u0oQ05QGc
         bHjpt52RvsK/M+VrhTQ6IAtZy2CrB0DY+9f24Psul8V8QjBIZ5WpYdy3cbY3Poze80l7
         xphtFuGCccNAMHUo7qUJz0KIUSTjBiK8/jXZBVi5dayvXxixS5Cy9USG0bFrRiaO3GC1
         HsZQ==
X-Gm-Message-State: AFqh2koDA256v3FOLbAQ4/8lOXaCwQeZCy+EOaJkgvT39BgJGbkMO0GN
        azi9PoFhcsKTbrTgcbFf33W5RBtdpEc=
X-Google-Smtp-Source: AMrXdXtms2lHcwACO6jdhtBXmBOoU/IChmHsUyB0WHKaSATW8XM5y4JWpOVgX5dUn+iA7JPb/vfydw==
X-Received: by 2002:a17:907:62a8:b0:86a:d385:81df with SMTP id nd40-20020a17090762a800b0086ad38581dfmr5130718ejc.3.1673969051320;
        Tue, 17 Jan 2023 07:24:11 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id ba6-20020a0564021ac600b0045cf4f72b04sm12842500edb.94.2023.01.17.07.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 07:24:10 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <2a2a46f0-a9bc-06a6-72e1-28800518777c@dunelm.org.uk>
Date:   Tue, 17 Jan 2023 15:24:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/1] cat-file: quote-format name in error when using -z
Content-Language: en-US
To:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>
References: <20230105062447.2943709-1-toon@iotcl.com>
 <20230116190749.4141516-1-toon@iotcl.com>
 <20230116190749.4141516-2-toon@iotcl.com>
In-Reply-To: <20230116190749.4141516-2-toon@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Toon

On 16/01/2023 19:07, Toon Claes wrote:
> Since it's supported to have NUL-delimited input, introduced in
> db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with `-z`,
> 2022-07-22), it's possible to pass paths that contain newlines. This
> works great when the object is found, but when it's not, the input path
> is returned in the error message. Because this can contain newlines, the
> error message might get spread over multiple lines, making it harder to
> machine-parse this error message.
> 
> With this change, the input is quote-formatted in the error message, if
> needed. This ensures the error message is always on a single line and
> makes parsing the error more straightforward.

This looks good but it would be nice to have test coverage for 
batch_one_object() as well as batch_object_write()

Best Wishes

Phillip

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>   builtin/cat-file.c  | 19 +++++++++++++++++++
>   t/t1006-cat-file.sh |  8 ++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index cc17635e76..b678f69773 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -14,6 +14,7 @@
>   #include "tree-walk.h"
>   #include "oid-array.h"
>   #include "packfile.h"
> +#include "quote.h"
>   #include "object-store.h"
>   #include "promisor-remote.h"
>   #include "mailmap.h"
> @@ -455,8 +456,17 @@ static void batch_object_write(const char *obj_name,
>   						       &data->oid, &data->info,
>   						       OBJECT_INFO_LOOKUP_REPLACE);
>   		if (ret < 0) {
> +			struct strbuf quoted = STRBUF_INIT;
> +
> +			if (opt->nul_terminated &&
> +			    obj_name) {
> +				quote_c_style(obj_name, &quoted, NULL, 0);
> +				obj_name = quoted.buf;
> +			}
> +
>   			printf("%s missing\n",
>   			       obj_name ? obj_name : oid_to_hex(&data->oid));
> +			strbuf_release(&quoted);
>   			fflush(stdout);
>   			return;
>   		}
> @@ -503,6 +513,13 @@ static void batch_one_object(const char *obj_name,
>   	result = get_oid_with_context(the_repository, obj_name,
>   				      flags, &data->oid, &ctx);
>   	if (result != FOUND) {
> +		struct strbuf quoted = STRBUF_INIT;
> +
> +		if (opt->nul_terminated) {
> +			quote_c_style(obj_name, &quoted, NULL, 0);
> +			obj_name = quoted.buf;
> +		}
> +
>   		switch (result) {
>   		case MISSING_OBJECT:
>   			printf("%s missing\n", obj_name);
> @@ -527,6 +544,8 @@ static void batch_one_object(const char *obj_name,
>   			       result);
>   			break;
>   		}
> +
> +		strbuf_release(&quoted);
>   		fflush(stdout);
>   		return;
>   	}
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 23b8942edb..e8ce20e739 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -447,6 +447,14 @@ test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
>   	test_cmp expect actual
>   '
> 
> +test_expect_success '--batch-check, -z with newline in non-existent named object' '
> +	printf "HEAD:newline${LF}missing" >in &&
> +	git cat-file --batch-check -z <in >actual &&
> +
> +	printf "\"HEAD:newline\\\\nmissing\" missing\n" >expect &&
> +	test_cmp expect actual
> +'
> +
>   batch_command_multiple_info="info $hello_sha1
>   info $tree_sha1
>   info $commit_sha1
> --
> 2.39.0.rc0.57.g2e71cbbddd.dirty
