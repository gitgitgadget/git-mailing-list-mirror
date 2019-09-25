Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476CE1F464
	for <e@80x24.org>; Wed, 25 Sep 2019 12:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405865AbfIYMyi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 08:54:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44634 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405798AbfIYMyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 08:54:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so6362405qth.11
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1x3/ip0brWkFd8mICX65rJgVTsW9dQnzoGipDTkgaU4=;
        b=gE1S7Ty7aDCzuhoPMF+CNClIGmi9ZNU3yXpxE3WMrFkwz2gfRWybySgyTsyfpkkbxY
         ylK3HHaeqKAErWzMDrc8/OdPDYqVsrYGhnNgSAsNQNKNk3xsQS0/yqiFHIbyvIiWdz1W
         GwMrsAPaC2MZHH06Q1RRMqhasVF+XpxGcL7yvSANmvEa+cRlYcCQ8zBHlOihDkeQlxH2
         7y3J8g5V7SKmLI381cwvs0cf8hj7eDWW2o5IFHa2hsBoD4J53xKAwcZ2S1+pa5505jlA
         35kzQ4ZHYgqc/1LO4KoaI+m0o8sXPLVQzrs4cua25cGDTFK+S9iVDfmNr6RIQ51Ahdai
         VG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1x3/ip0brWkFd8mICX65rJgVTsW9dQnzoGipDTkgaU4=;
        b=ZH8GbG3LbDW12AYBLofAA6+fSGsoaR5hVy70BkmJ0z7df+mzL9mmb/mlf+OAoZFVfO
         PaFN6t4wb++tC901W0KxRxJXqvhdG24uVOTlFo26380xS65DUwiMhd+ZuZGcI84XBm/p
         IIQtBCwkMiVmjKlwLBMt3zSsSGqj8/4hTNNvYlHgUdg+sTLnitmn87pDt++MBTehZIwv
         BMVhIa4V8CIfOJ06vMHFNqw+DagQeGHh0g2cLoI4QhZl0mPHFbUmrnfF++OtYJE39xzh
         pkytBBrFg6aABK0yWmgeJPkg6drccQsmLPgpNAN2TGl7gEBkv6qREg7FqTA1l/WR4skT
         9v5g==
X-Gm-Message-State: APjAAAWZNR9gQ1sT2cJN13F87ANCMDt8KfUo9p0hMEfnLTKpa7NPus6l
        HVrKcXvTNhjvCAQDQMVmz/DdDYmonjo=
X-Google-Smtp-Source: APXvYqyxY9j7fQmhW1rss67OJ6tcAM167/fBBgeCpW5YtI/Y265192NxjZJcpDPsidrOPMsCq4ScCQ==
X-Received: by 2002:ac8:3525:: with SMTP id y34mr8723989qtb.140.1569416076332;
        Wed, 25 Sep 2019 05:54:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1012:fdf4:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id f27sm2483414qkh.42.2019.09.25.05.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 05:54:35 -0700 (PDT)
Subject: Re: [PATCH v2 08/19] hashmap_remove takes "const struct hashmap_entry
 *"
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-9-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d80f2000-3788-f422-e51a-9e3f6fff9f41@gmail.com>
Date:   Wed, 25 Sep 2019 08:54:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-9-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> This is less error-prone than "const void *" as the compiler
> now detects invalid types being passed.
[snip]
> diff --git a/hashmap.c b/hashmap.c
> index 092236c09a..bdf33e0381 100644
> --- a/hashmap.c
> +++ b/hashmap.c
> @@ -218,7 +218,8 @@ void hashmap_add(struct hashmap *map, struct hashmap_entry *entry)
>  	}
>  }
>  
> -void *hashmap_remove(struct hashmap *map, const void *key, const void *keydata)
> +void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
> +		const void *keydata)
>  {
>  	struct hashmap_entry *old;
>  	struct hashmap_entry **e = find_entry_ptr(map, key, keydata);
> diff --git a/hashmap.h b/hashmap.h
> index 2a4b4a3954..5e0818c134 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -349,7 +349,7 @@ void *hashmap_put(struct hashmap *map, void *entry);
>   *
>   * Argument explanation is the same as in `hashmap_get`.
>   */
> -void *hashmap_remove(struct hashmap *map, const void *key,
> +void *hashmap_remove(struct hashmap *map, const struct hashmap_entry *key,
>  		const void *keydata);

In my effort to continue being detail-oriented, I'll point out whitespace
alignment again here. But then I'll stop mentioning it for hashmap.[c|h]
and leave it to you for a potential v3.

Thanks,
-Stolee

