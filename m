Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7500BC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2353861A38
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 08:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZIPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCZIOa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 04:14:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7AC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 01:14:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so5250323pjb.0
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=15G1qlANBptKJQsp3qziLxopOsN7ShecQI7zEswJq4k=;
        b=L74M9Iq9U+AZBozVG66ZtlyVXmJhx3TPPATWMjGvWh7pTkO8E1/lkch9cayZEfBtRO
         miSNA3U9D9VPoR5m/B0/B4VZr3Tnsfn0wV8Ee0hy3X2V/YtB+EtLFA30s+QaebDg5hHI
         zCMfh+1AqTns8wB3Sm+EbgdFyMhDrPegCA2uphoQbcRVV5KZfBL07Cr0ps7iKcfdGpq3
         Ahol3yadjdE1RZuUvC61JGfE4WexZvsK7C0GAZtmM8OVqo+x/rIeHaJPGSPQ9Sw9WLgi
         IpPR+mB7VseUEi6MGg8FYqQOGPTu1IG2+Spb+fBcZKyL7vn2YKwY7q4rJ71yjYy3CoXA
         YHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=15G1qlANBptKJQsp3qziLxopOsN7ShecQI7zEswJq4k=;
        b=T+cOScKQO/t3UmDHvtkkAw7NbsPoKYhlNcJbc0UVl1AEwMPK1JsUkWU8Tmr4vyqUwi
         3rv9El+4BrkmQmcQDKry4H51OtskSSSlOACLdFlSxjhV64LvvRFvLL5SlEdPVMRJSNeK
         aXMef1YnQbmqoJLpty4AzDrmPgwL5u0Mo8LWOD6btnQYAVtmFGxKVc0fv4Y2+QmV+/SP
         GHThO6LrAhKIYfc3o700VtPfhHp3py8FUVVpBXIw7f6J7/htveROaXpmdBIJDxmAfnRG
         t54xspQYqo+PHSSugfixCNZ04YgJNJzxfHd6OXeuQ0ZbgRtabIzDq6OMICu/dHzWwMul
         ctLw==
X-Gm-Message-State: AOAM5327IL5bsl4wZtGdoHgZcbu8vQ5zegRsDw1qyw/BVsvbdUbYzGCz
        7Lp3CIXCz6pW9flMWM7EE1x+Pz5Zy6IQQA==
X-Google-Smtp-Source: ABdhPJzxglv/LApgmGdQo6SAHXxTBPZPCjXMX1ow6ou3OaB3HRmww/ZNrUpaqSrVDbwbzsSGvpJdDg==
X-Received: by 2002:a17:903:18a:b029:e6:7fc1:1c2a with SMTP id z10-20020a170903018ab02900e67fc11c2amr13727188plg.5.1616746467682;
        Fri, 26 Mar 2021 01:14:27 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id l4sm8351413pgn.77.2021.03.26.01.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 01:14:27 -0700 (PDT)
Subject: Re: [RFC PATCH v1 2/2] fixup! pathspec: warn: long and short forms
 are incompatible
To:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqqft1iquka.fsf@gitster.g>
 <20210326024005.26962-1-stdedos+git@gmail.com>
 <20210326024005.26962-3-stdedos+git@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f4d7c771-f35c-2a62-f655-5b6469d76ee1@gmail.com>
Date:   Fri, 26 Mar 2021 15:14:24 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210326024005.26962-3-stdedos+git@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/03/21 09.40, Σταύρος Ντέντος wrote:
> From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
> 
> malloc and stuff
> ---
>   pathspec.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
What does this fixup patch try to accomplish? Give more details.
> diff --git a/pathspec.c b/pathspec.c
> index 374c529569..4ac8bfdc06 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -7,6 +7,7 @@
>   #include "attr.h"
>   #include "strvec.h"
>   #include "quote.h"
> +#include "git-compat-util.h"
>   
>   /*
>    * Finds which of the given pathspecs match items in the index.
> @@ -745,16 +746,20 @@ int match_pathspec_attrs(const struct index_state *istate,
>   }
>   
>   void check_mishandled_exclude(const char *entry) {
> +	char *flags, *path;
>   	size_t entry_len = strlen(entry);
> -	char flags[entry_len];
> -	char path[entry_len];
>   
> -	if (sscanf(entry, ":!(%4096[^)])%4096s", &flags, &path) != 2) {
> -		return;
> -	}
> -	if (count_slashes(flags) > 0) {
> -		return;
> +	flags = xstrdup(entry);
> +	memset(flags, '\0', entry_len);
> +	path = xstrdup(entry);
> +	memset(path, '\0', entry_len);
> +
> +	if (sscanf(entry, ":!(%4096[^)])%4096s", flags, path) == 2) {
> +		if (count_slashes(flags) == 0) {
> +			warning(_("Pathspec provided matches `:!(...)`\n\tDid you mean `:(exclude,...)`?"));
> +		}
>   	}
>   
> -	warning(_("Pathspec provided matches `:!(...)`\n\tDid you mean `:(exclude,...)`?"));
Message looks ok.
> +	FREE_AND_NULL(flags);
> +	FREE_AND_NULL(path);
>   }
> 

-- 
An old man doll... just what I always wanted! - Clara
