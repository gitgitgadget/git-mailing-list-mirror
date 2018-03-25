Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15D81F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeCYSdU (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:33:20 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43080 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753472AbeCYSdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:33:19 -0400
Received: by mail-qk0-f194.google.com with SMTP id g184so17943425qkd.10
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9WNnW31CeCKfYIdGd2x3Mh+zBTycgBaGxNA9WmbpanE=;
        b=DRdIjW83C7x+EfJ4fCgN6AvvXu1u/oWrQMKXWG9viTfIeaEPHQmc9SOSiL25bNc11K
         2Ygvvj6FuMpAmMO2D141UvCbWMzAnZE0jBSP/+kjnLZQRfAxvYjjMKyXruoRarGGpt/Q
         GGItYOhXTqlm0a/TN3Ge0J/9f6Cz+DG0on6PKujcBnS3yVW1jRKnc12v/BiKDBWy7l3q
         L9D6+M6FW9zXSuQjxxNE5wbTKCy0jm6HIVsnO3h/Fe+HhsB+AQcXWilsSv/iAK5z65tD
         zoknxr2FkVNBZTFqgEdOlQ7WGWIZ1iJ9D2B+zhGIX8LLjhmUkfSMICoiWGmojCsS/mMs
         G13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9WNnW31CeCKfYIdGd2x3Mh+zBTycgBaGxNA9WmbpanE=;
        b=F5p6JKn43zbCFM/NMnCFsQ/04IwvzRoelhn8GgkEwBZHfno1uPe1B7nDvQmi/+Oy0e
         fX5fR/1fwbmgx42ZhKKUN8G8anA2rcQieSUf8jbGd7QMqWSMLzbKLNP4dSHzw2BqJZeH
         K7qobOWtnMOikp3wdn+K6p2du+FG+JEYBviszJkEsoFuii2qDFE36BsfwZJG2AwmU19q
         lnuB3AfVcECxIr66LigSAyZPV9pKCwSjf0LAI6uVd3xFTgFeZL8JpmpI6Pboohbese5a
         29fOubzjmM96wmrfGB/tmyxTNJYe+17zD/ZjEhWgsoAJcSCOZ64Ltocn96suKgUh0ao6
         lSuw==
X-Gm-Message-State: AElRT7GVthueYSTJkCfvbXXc1EKQnLIwLi87SsgaZdl516mw8j3pmrlS
        TtpMODWkqdsatHb8//W+ZJdyQgzd
X-Google-Smtp-Source: AG47ELtJJtEW1DfR2/Biq1rTidWdvIK2I30AGM2qXTc/qe3fj8OqLmfic+wucebf1bpt5Xl36upfmA==
X-Received: by 10.55.20.135 with SMTP id 7mr50808251qku.286.1522002799126;
        Sun, 25 Mar 2018 11:33:19 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id k29sm10257409qtc.45.2018.03.25.11.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 11:33:18 -0700 (PDT)
Subject: Re: [PATCH] unpack-trees: release oid_array after use in
 check_updates()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <b2380d1e-1d45-22cf-ba22-cf4cb02e1134@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c46f189d-7825-4d60-be71-a4d339c4fa43@gmail.com>
Date:   Sun, 25 Mar 2018 14:33:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b2380d1e-1d45-22cf-ba22-cf4cb02e1134@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2018 12:31 PM, René Scharfe wrote:
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> That leak was introduced by c0c578b33c (unpack-trees: batch fetching of
> missing blobs).
>
>   unpack-trees.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index d5685891a5..e73745051e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -379,30 +379,31 @@ static int check_updates(struct unpack_trees_options *o)
>   		struct oid_array to_fetch = OID_ARRAY_INIT;
>   		int fetch_if_missing_store = fetch_if_missing;
>   		fetch_if_missing = 0;
>   		for (i = 0; i < index->cache_nr; i++) {
>   			struct cache_entry *ce = index->cache[i];
>   			if ((ce->ce_flags & CE_UPDATE) &&
>   			    !S_ISGITLINK(ce->ce_mode)) {
>   				if (!has_object_file(&ce->oid))
>   					oid_array_append(&to_fetch, &ce->oid);
>   			}
>   		}
>   		if (to_fetch.nr)
>   			fetch_objects(repository_format_partial_clone,
>   				      &to_fetch);
>   		fetch_if_missing = fetch_if_missing_store;
> +		oid_array_clear(&to_fetch);
>   	}
>   	for (i = 0; i < index->cache_nr; i++) {
>   		struct cache_entry *ce = index->cache[i];
>   
>   		if (ce->ce_flags & CE_UPDATE) {
>   			if (ce->ce_flags & CE_WT_REMOVE)
>   				die("BUG: both update and delete flags are set on %s",
>   				    ce->name);
>   			display_progress(progress, ++cnt);
>   			ce->ce_flags &= ~CE_UPDATE;
>   			if (o->update && !o->dry_run) {
>   				errs |= checkout_entry(ce, &state, NULL);
>   			}
>   		}
>   	}

Ack. Looks correct.

-Stolee
