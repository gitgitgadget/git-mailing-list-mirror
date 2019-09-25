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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3068E1F464
	for <e@80x24.org>; Wed, 25 Sep 2019 13:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406029AbfIYNFQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 09:05:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43800 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405791AbfIYNFP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 09:05:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id c3so6406902qtv.10
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aPXUJj5gghNqF4+BPFiaWfd3gSopC4zyz1Ri1wdO2IM=;
        b=KuziDIizHDO+PWXl6CDy5NRJqh2IJeHmqet6HGNCYSLCX0ZALlHnY2ioJzkvHk4hMc
         n3RTQQhZRaUkt0YC9yFuVJU3sBs55tG4VCSC/SHGZLO8raQtNntjDUnk7kuAj4tCMxI/
         rqzwXNS2dpSebM3dBAx/WdZPyrrz1oE5YNZNPddvm7RP6h6GjDDVC0zXGfrSwjPRMeE9
         e0Fvplh48DLKuTp8ygBkJyiasZfWJ58PpC1U6XW9iA5/vQ83PfKVOAOfPqewBgalmAwA
         j8I3fXriE7eIJWPwY3YJPAnx1T/sYsmR8ySbFcUpurL/5P3ufAMJhDxkeOHvZktJJwPe
         pXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aPXUJj5gghNqF4+BPFiaWfd3gSopC4zyz1Ri1wdO2IM=;
        b=lmjDzrx8SKSn7+36qv3I8jWtD2OSI/wGf3f5wUzyuZN0rfDfy+fFHuL1RQ9D9NBeY4
         dCA4J53VgtSbaD19GsH/UxhyXOg2gxBqbva96qT94Cj+VDn3EE2M63qkwciEmPFsT31g
         EiZQ2aXrZKuGp5NV6jGMuer9hNivBXHbdtoxXM6bgFHZkDVTTaFULFFIZXBGINDe+tfO
         igoI/KziSqCL+EHGGKN6e6S8nOZdJLTLUnp8hurkPNl+9pSeZ5pG5D4dQyiLkXtGmELD
         yG7CkTtnP5mNX7J/L/fOrtA9/eTIBvuor3Yt3+6guUtvaSEYbnocjqhGtoIXNh9Q3+iB
         JVxQ==
X-Gm-Message-State: APjAAAWfCNr7IC3+qYrCQIuKet30589a/y/fx1kQCgIk5+qCbjNB9+Zo
        mcjOh6fAZp7WIwlTUUBREooikaLOllg=
X-Google-Smtp-Source: APXvYqx3Ogh2iPn4dbWrT8uMzsco8/tiH4dJ3qo56K2aKfe7P0Wg5Trm5AKs7mAQVsPfFznrAZItEQ==
X-Received: by 2002:ac8:5448:: with SMTP id d8mr8546696qtq.287.1569416714470;
        Wed, 25 Sep 2019 06:05:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1012:fdf4:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id a36sm2774353qtk.21.2019.09.25.06.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:05:13 -0700 (PDT)
Subject: Re: [PATCH v2 11/19] hashmap_get_next returns "struct hashmap_entry
 *"
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-12-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <02e90301-9d50-4105-5988-853d1018ba30@gmail.com>
Date:   Wed, 25 Sep 2019 09:05:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-12-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> This is a step towards removing the requirement for
> hashmap_entry being the first field of a struct.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  diff.c                  | 19 ++++++++++++-------
>  diffcore-rename.c       | 11 +++++++----
>  hashmap.c               |  2 +-
>  hashmap.h               | 12 ++++++++----
>  name-hash.c             |  8 +++++---
>  t/helper/test-hashmap.c | 10 ++++++----
>  6 files changed, 39 insertions(+), 23 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 72d3c6aa19..663b5d01f8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1035,8 +1035,10 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
>  {
>  	int i;
>  	char *got_match = xcalloc(1, pmb_nr);
> +	struct hashmap_entry *ent = &match->ent;
>  
> -	for (; match; match = hashmap_get_next(hm, &match->ent)) {
> +	for (; ent; ent = hashmap_get_next(hm, ent)) {

I suppose that the old code had a blank first entry in the for(;;),
but we could move our `ent = &match->ent` into the initializer, right?
That would make the loop look a little better, maybe. This happens
again below.

Thanks,
-Stolee

> @@ -1189,8 +1193,9 @@ static void mark_color_as_moved(struct diff_options *o,
>  			 * The current line is the start of a new block.
>  			 * Setup the set of potential blocks.
>  			 */
> -			for (; match; match = hashmap_get_next(hm,
> -								&match->ent)) {
> +			for (; ent; ent = hashmap_get_next(hm, ent)) {
> +				match = container_of(ent, struct moved_entry,
> +							ent);
