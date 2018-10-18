Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F2C1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 19:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeJSDig (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 23:38:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32814 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSDif (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 23:38:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so35726148qte.0
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gFeAiXZuziZ2jxpyPSF9OZ02aLASOnl4NFgc+m/zpwM=;
        b=ekacOf1gxD+fb3pf5pYnDkjHYx1DcBFxkGpp2DXZ/kvg72edgxRMhyV2V/AN87beOi
         DS1nYc7VzOvxlzORbtwLRvWbtAGSMEWfwUlpUmfVFHkb2TH34cyG5rgW80jozxSX7zK8
         XSP4pq/FGoEqYuEDt2yiiuuosp+/ugoWkOeGhySPZDbLjWmnQ2sLO9NICxalDHsuPGk3
         AzfnJ88E0zSS7KpX87+JFJ++wv1IekKd9gkdUzKAQ5Vp61HTX7T5nSr16+j9MMPHB6Gf
         hIOLa/zjSIkx8exlL/4wM9rb+38vgtRd7g3qoPWtXM5hLzDfcTSUWiUynvNrGOqhHg8C
         jtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gFeAiXZuziZ2jxpyPSF9OZ02aLASOnl4NFgc+m/zpwM=;
        b=T6ejjfw3fBOeQL/1Pzhd2ct2x7WS2ty6j2nUUcrQZcU3bej9p3OyMyY7JwjZlZiQZI
         s+83VV6INM2Fm8JOBLS6hZAIGuxFUe+yMS3KPlWzaBojvP4arASzdVj5uONd0N2s354r
         w8pJo/5aM+BM6i7sMTLmU2HMOU0NsM3XdEdzZqFeVVcFmgYwCexGXNsYyNXLFBFxsAvK
         uj3il3PBrQIQaJGWW6qWfU6ZSLZgYz3+X4NzLjmKvMN5k35aRph/XxcHeUAalZcrUdYb
         8VbaUbETewVE3Zo+1LenEHkDYfkdG7KuQ2pMo7K0IubKUKnmlt6eM9qsPUuD3zCcoN9H
         u1ig==
X-Gm-Message-State: ABuFfoiN2No+OhBE2katY8gNpRAAESsHWuZyPg7rn1dH73UrePKgufP2
        XGOZSbyG6a4jntzmYfdwD40=
X-Google-Smtp-Source: ACcGV619FC2bApp5dwzzTYq/VL1RdLwj03nYIIL+g453uQnkx6uKBappzGHZUqwC57pYUjby3Hg65A==
X-Received: by 2002:a0c:88d5:: with SMTP id 21mr31313259qvo.61.1539891365104;
        Thu, 18 Oct 2018 12:36:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e0ed:6621:9414:4d4e? ([2001:4898:8010:0:ca23:6621:9414:4d4e])
        by smtp.gmail.com with ESMTPSA id k185-v6sm13946148qkd.27.2018.10.18.12.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:36:04 -0700 (PDT)
Subject: Re: [PATCH] multi-pack-index: avoid dead store for struct progress
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     dstolee@microsoft.com
References: <20181018185920.22975-1-carenas@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <16e462a7-cdd6-9d5d-d740-d5241485787b@gmail.com>
Date:   Thu, 18 Oct 2018 15:36:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <20181018185920.22975-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2018 2:59 PM, Carlo Marcelo Arenas Belón wrote:
> it is initialized unconditionally by a call to start_progress
> below.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   midx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index ea2f3ffe2e..4fac0cd08a 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -941,7 +941,7 @@ static void midx_report(const char *fmt, ...)
>   int verify_midx_file(const char *object_dir)
>   {
>   	uint32_t i;
> -	struct progress *progress = NULL;
> +	struct progress *progress;
>   	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
>   	verify_midx_error = 0;
>   
This makes sense as a cleanup. Is there a tool that reports a wasted 
initialization that you used to find this?

-Stolee
