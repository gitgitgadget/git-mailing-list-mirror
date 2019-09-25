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
	by dcvr.yhbt.net (Postfix) with ESMTP id CA03C1F464
	for <e@80x24.org>; Wed, 25 Sep 2019 12:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfIYMpD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 08:45:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43437 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIYMpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 08:45:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so6322286qtv.10
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dNbHNaeN6ci2pLQfg7k8QOT5W/1NMI2u6XN49jrsWU4=;
        b=WQ1dLdCXD794HWGQjWQ8qONMXheYVkiC5fUEeiI+HHfuWAvmhGnSynWVGzquBYKL7F
         xOyDPP2j5kQWy6szkMfMEfBQ7JpfyFqBpbgx0Q8cwqODn5HtGnTCIo1Zg5HG2f1C1WqX
         X9vyMm01g31B6P+RyBQeMpoNeeE8+qUYc7MkS6UPuLv0VL4kH6pDH+5IWGaPnYA5ZrYJ
         97dVpS2ppb1pt1kT+2F7iPC/pSVx1U7NYxlZf5LvDxa0EX7XqjW2sI3ERkj/3bRVwY0m
         /uq/vPEo6BljsJfbLgVkF47H/VRxN3vjqHpWc8Pke9A+Id4SglTCf4ZFA8bYQfGNAIEg
         xkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dNbHNaeN6ci2pLQfg7k8QOT5W/1NMI2u6XN49jrsWU4=;
        b=cK8ZREC3M8wjBYOnSWIwz+bNbndrUmOleE1cuGOBfA9xvkTTZXspkEIj7eXeqt4VWr
         VZ6HtQpnwr29QEs4Gz4stGx/9RpDo6QL0lO87Y0ysCgiUwxTT2FqHyN0E2hQ4rMVULT5
         pxRqDvKWs8BwYAv+eocSAlNMySFo+8usKs+0H8L+bO08GpGfdNHe2VuU9S+El+REYb6C
         TFdjaMj7buW2MgmB5xaYlWFEg2OkMGJrK/FijQ4s8UT9nXHnbpeSQuj1gpVVDmrIFFDC
         uTGuIadcELF+NFNPfOpC8/cdKEM4IxVYp4VjNiEX3Lo5Zk+3q6Z4lKFWYBcZum1jzyby
         EZKA==
X-Gm-Message-State: APjAAAXCgdGFHqGASGBO1ZERI/poVNKX/BfqNDKHZjXkShcKX5NHIyo9
        XtKZn66O5kx5pkC/pTHnr8Ukb/4DcZ4=
X-Google-Smtp-Source: APXvYqyrJOCpHURQXAbXdSUrg6KvLFttLa97St3FUMR9CiThztezYtAN9Adax3glx+wQFB89h67Csg==
X-Received: by 2002:ac8:3525:: with SMTP id y34mr8680450qtb.140.1569415501271;
        Wed, 25 Sep 2019 05:45:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1010:fdf6:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id h184sm3057747qkf.89.2019.09.25.05.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 05:44:59 -0700 (PDT)
Subject: Re: [PATCH v2 02/19] coccicheck: detect hashmap_entry.hash assignment
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-3-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fe53e15f-d78a-5b94-9745-43a521cb0f80@gmail.com>
Date:   Wed, 25 Sep 2019 08:44:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-3-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> Assigning hashmap_entry.hash manually leaves hashmap_entry.next
> uninitialized, which can be dangerous once the hashmap_entry is
> inserted into a hashmap.   Detect those assignments and use
> hashmap_entry_init, instead.

I appreciate this future-proofing! Thanks.

> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  contrib/coccinelle/hashmap.cocci | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 contrib/coccinelle/hashmap.cocci
> 
> diff --git a/contrib/coccinelle/hashmap.cocci b/contrib/coccinelle/hashmap.cocci
> new file mode 100644
> index 0000000000..d69e120ccf
> --- /dev/null
> +++ b/contrib/coccinelle/hashmap.cocci
> @@ -0,0 +1,16 @@
> +@ hashmap_entry_init_usage @
> +expression E;
> +struct hashmap_entry HME;
> +@@
> +- HME.hash = E;
> ++ hashmap_entry_init(&HME, E);
> +
> +@@
> +identifier f !~ "^hashmap_entry_init$";
> +expression E;
> +struct hashmap_entry *HMEP;
> +@@
> +  f(...) {<...
> +- HMEP->hash = E;
> ++ hashmap_entry_init(HMEP, E);
> +  ...>}
> 

