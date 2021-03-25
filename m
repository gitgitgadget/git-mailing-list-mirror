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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4993C433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0EF61A28
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhCYLBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhCYLAe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 07:00:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE9EC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:00:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so2573922pjb.0
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CBtRcZbieH/K8AMB3UtVcE9RaRr8gyIjxydCfXufZRw=;
        b=P+MORVxQI9PQAQPAKUcptCcVD25m18G2V1/9w866KJnJrlItf0FsLf+HWj6ppAgEWV
         bZaIW0gdthjR6OtbT0gQaAWWESX0+zUDuB9Bq/HqfMn9OVuNMRCWdHVTrlfTkQGAsm5E
         Msb3VDC7NTlvRH+J1FIYIGfQB4s6ezEhYm9JT8WxXYidRhFrwLXgS3QvMjyGQKOuVXNf
         iQAlbcWnYKcIWLl735XD4rB3gxhtjcC5zCnXX7CFB6Pdf4JsHHtEfRV78uCBTfDZ2vwv
         uPDi3YPn2mw7m4OnZYuNgoB+7Hp+/SjcDMs8QiJrkocs8sgAEPBx6NeJMQn7w5qEPX17
         7FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBtRcZbieH/K8AMB3UtVcE9RaRr8gyIjxydCfXufZRw=;
        b=jGfJJNKns879U60VjYv313FRdWZH1TIqlVoDvJXiunF0o/VEZtvqZyaFQZDOnpTWlS
         QLb2tjTc56T4JRivD/+C1xRC/7Cs9z7qFGjOn1L0y6lIHym0IVJx0qCN/liNQBjY5vtt
         B/crqfkpgx+GsmtIwU5kiDGLNgaQSwwd4swPvgF4xinoyUEQdZtgYSlBVQAvQRUuEI8I
         KABPuhqjm0LsS3/57RoKAl1t5NQM8xb0v+dx63moZo3t9BzddUINoYcgb6Tj3wXBC94m
         exhs+HnVl4upNkOebRYtMU0EJtHjk2pVa/7f4mf9DgzmJsYWHyJ3u1LSNAmhnkn/iDHm
         DylA==
X-Gm-Message-State: AOAM533ZxwhjLjZlDSd24hBBtP/g5gifJ0HMgxz+yAt05oup5CSsaL9Z
        FaFCfw6V1dCU9wXiD2LFsigcMmfFQuvrXi/A
X-Google-Smtp-Source: ABdhPJyNNMYrvsmq7/F8m6tmoUfcgXsElPQKsUO0YXifR/3BOw2cIOp/i5jqOfsDhtx7DdYH1n19mA==
X-Received: by 2002:a17:90b:4395:: with SMTP id in21mr8229001pjb.201.1616670033291;
        Thu, 25 Mar 2021 04:00:33 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id y193sm5727310pfc.72.2021.03.25.04.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 04:00:33 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] pathspec: warn for a no-glob entry that contains
 `**`
To:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>,
        git@vger.kernel.org
References: <xmqqft1iquka.fsf@gitster.g>
 <20210325102228.14901-1-stdedos@gmail.com>
 <20210325102228.14901-2-stdedos@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <0eeedc6c-cf47-41ac-a1f2-242d33963aa8@gmail.com>
Date:   Thu, 25 Mar 2021 18:00:29 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325102228.14901-2-stdedos@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/03/21 17.22, Σταύρος Ντέντος wrote:
> From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
> 
> If a pathspec is given that contains `**`, chances are that someone is
> naively expecting that it will do what the manual has told him that `**`
> will match (i.e. 0-or-more directories).
> 
> However, without an explicit `:(glob)` magic, that will fall out the sky:
> the two `**` will merge into one star, which surrounded by slashes, will
> match any directory name.
> 
> These changes attempt to bring awareness to this issue.
> 
> Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
> ---
>   pathspec.c                 | 13 +++++++++++++
>   pathspec.h                 |  1 +
>   t/t6130-pathspec-noglob.sh | 13 +++++++++++++
>   3 files changed, 27 insertions(+)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 7a229d8d22..9b5066d9d9 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -1,3 +1,4 @@
> +#include <string.h>
>   #include "cache.h"
>   #include "config.h"
>   #include "dir.h"
> @@ -588,6 +589,8 @@ void parse_pathspec(struct pathspec *pathspec,
>   
>   		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
>   
> +		check_missing_glob(entry, item[i].magic);
> +
>   		if (item[i].magic & PATHSPEC_EXCLUDE)
>   			nr_exclude++;
>   		if (item[i].magic & magic_mask)
> @@ -739,3 +742,13 @@ int match_pathspec_attrs(const struct index_state *istate,
>   
>   	return 1;
>   }
> +
> +void check_missing_glob(const char *entry, int flags) {
> +	if (flags & (PATHSPEC_GLOB | PATHSPEC_LITERAL)) {
> +		return;
> +	}
> +
> +	if (strstr(entry, "**")) {
> +		warning(_("Pathspec provided contains `**`, but no :(glob) magic.\n\tIt will not match 0 or more directories!"));
> +	}
Why did you add an extra \t? I think it is unnecessary indentation.
> +}
> diff --git a/pathspec.h b/pathspec.h
> index 454ce364fa..913518ebd3 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -157,5 +157,6 @@ char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
>   int match_pathspec_attrs(const struct index_state *istate,
>   			 const char *name, int namelen,
>   			 const struct pathspec_item *item);
> +void check_missing_glob(const char* pathspec_entry, int flags);
>   
>   #endif /* PATHSPEC_H */
> diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
> index ba7902c9cd..1cd5efef5a 100755
> --- a/t/t6130-pathspec-noglob.sh
> +++ b/t/t6130-pathspec-noglob.sh
> @@ -157,4 +157,17 @@ test_expect_success '**/ does not work with :(literal) and --glob-pathspecs' '
>   	test_must_be_empty actual
>   '
>   
> +cat > expected <<"EOF"
> +warning: Pathspec provided contains `**`, but no glob magic.
> +EOF
> +test_expect_success '** without :(glob) warns of lacking glob magic' '
> +	test_might_fail git stash -- "**/bar" 2>warns &&
> +	grep -Ff expected warns
> +'
> +
> +test_expect_success '** with    :(literal) does not warn of lacking glob magic' '
Padding maybe?
> +	test_might_fail git stash -- ":(literal)**/bar" 2>warns &&
> +	! grep -Ff expected warns
> +'
> +
>   test_done
> 

-- 
An old man doll... just what I always wanted! - Clara
