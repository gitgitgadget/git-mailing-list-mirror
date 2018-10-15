Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78CD01F453
	for <e@80x24.org>; Mon, 15 Oct 2018 15:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeJOXRB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 19:17:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46446 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOXRA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 19:17:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id d8-v6so21876020qtk.13
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dmBVufTyXSG04l2jlPchlF7euLd6D5iZKv2ZMGLPU4A=;
        b=ECzTVYlfUnkRJQyIi+rXAjesCzM3RwgPj5BqiafI9FKZdBMCs8elz3TvzYJMhS9X9G
         XrS/JZE12RfCuRkrkinvEjCdd+829BBs5Rh13+b9eR2gMklaUe8YC9VGFwie+3IaVomP
         NWh/b+k1J30x2nzSWY6tYBxd5vMkq+3NsfjWUcDonHcaxEq/LrTM0e96YxUC30lk6rgC
         wyAtYwD7hDh7Zk+elb4Aiqz8tK5XnLB1hmZ6rxe9Tc73gxhwkpAZFU3EMm3+CkaMUu2E
         4PD3B1K9tkR0Kpas3weAt7u/K0KVP8+XCV6YRaxZnFfV0Tk96bUVzSqZMHN9K8Djya+8
         tCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dmBVufTyXSG04l2jlPchlF7euLd6D5iZKv2ZMGLPU4A=;
        b=YuO9WPOu4aaxllbSGWtaDAveYpVk24GkG3PbpBHyBCfXRKCpjMxoLZsI0j2Kls8b4e
         zPyFyhjYVrmHQwiIdZ/uBXugpqKOJYwW33qO4+UGWXSe35x2R6Bn/A8TcUH8sxrA2vUq
         4zClvFisdffss9sA1/VAxOxwqZomh2E0uWP/iyou3WF7kAekmMRYu2fC+Voe0HLxwUjB
         53ioJBB3WO7qXCv2v6UsKgDkMySoLc5YopJEiPmoBs6uIXzUtRw8HbZ16prlp9jeoX/M
         DeQ1Rk81WAdxeb67S1rV0vWTvMCuQmU3u80cB8jiBfPwc5rwaouWrXmEA/mrNTxxjoRm
         vJcg==
X-Gm-Message-State: ABuFfogmIngjoD1g0QVTTjQPFQ2qPArrLATJeRhmMvK9FhawFLuCqyMo
        eWEAnoWfgKnnoTqMqo5Zt69LOBae
X-Google-Smtp-Source: ACcGV63X/T+gaxnXwN6+JZ1bF+86HGrr4kt0KmuijurF1rLRb9b7Yjo8vpiDuY8HOtbxuvQtyljdNQ==
X-Received: by 2002:ac8:4804:: with SMTP id g4-v6mr16432550qtq.66.1539617475109;
        Mon, 15 Oct 2018 08:31:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a017:1942:43e1:ced3? ([2001:4898:8010:0:894d:1942:43e1:ced3])
        by smtp.gmail.com with ESMTPSA id y138-v6sm6261313qka.36.2018.10.15.08.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:31:14 -0700 (PDT)
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
 <20181005190847.GC17482@sigill.intra.peff.net>
 <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
 <20181005194223.GA19428@sigill.intra.peff.net>
 <c141fb44-904f-e8b6-119f-7d2d6bcfd81a@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0cd89b69-4b65-f961-a025-c74851f8c999@gmail.com>
Date:   Mon, 15 Oct 2018 11:31:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c141fb44-904f-e8b6-119f-7d2d6bcfd81a@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2018 10:29 AM, René Scharfe wrote:
> It still has some repetition, converted code is a bit longer than the
> current one, and I don't know how to build a Coccinelle rule that would
> do that conversion.
>
> Looked for a possibility to at least leave QSORT call-sites alone by
> enhancing that macro, but didn't find any.  Found a few websites
> showing off mindblowing macros, thouhg, this one in particular:
>
> https://github.com/pfultz2/Cloak/wiki/C-Preprocessor-tricks,-tips,-and-idioms
>
> Anyway, drove the generative approach a bit further, and came up with
> the new DEFINE_SORT below.  I'm unsure about the name; perhaps it should
> be called DEFINE_SORT_BY_COMPARE_FUNCTION_BODY, but that's a bit long.
> It handles casts and const attributes behind the scenes and avoids
> repetition, but looks a bit weird, as it is placed where a function
> signature would go.
>
> Apart from that the macro is simple and doesn't use any tricks or
> added checks.  It just sets up boilerplate functions to offer type-safe
> sorting.
>
> diffcore-rename.c and refs/packed-backend.c receive special treatment in
> the patch because their compare functions are used outside of sorting as
> well.  I made them take typed pointers nevertheless and used them from
> DEFINE_SORT; the wrapper generated by that macro is supposed to be
> private.  Given that such reuse is rare and I think we don't need a way
> to make it public.
>
> What do y'all think about this direction?
>
> ---
[snip]
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5f2e90932f..491230fc57 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1066,6 +1066,21 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
>   		qsort(base, nmemb, size, compar);
>   }
>   
> +#define DECLARE_SORT(scope, name, elemtype) \
> +scope void name(elemtype, size_t)
> +
> +#define DEFINE_SORT(scope, name, elemtype, one, two)			\
> +static int name##_compare(const elemtype, const elemtype);		\
> +static int name##_compare_void(const void *a, const void *b)		\
> +{									\
> +	return name##_compare(a, b);					\
> +}									\
> +scope void name(elemtype base, size_t nmemb)				\
> +{									\
> +	QSORT(base, nmemb, name##_compare_void);			\
> +}									\
> +static int name##_compare(const elemtype one, const elemtype two)
> +

Since you were worried about the "private" name of the compare function, 
maybe split this macro into two: DEFINE_COMPARE and DEFINE_SORT. Then, 
if someone wants direct access to the compare function, they could use 
the DEFINE_COMPARE to ensure the typing is correct, and use QSORT as 
normal with name##_compare_void.

As I think about this, I think this is less of a problem than is worth 
this split. The commit-slab definitions generate a lot of methods using 
the "name##" convention, so perhaps we should just trust developers 
using the macros to look up the macro definition or similar examples. In 
that sense, including a conversion that consumes the compare function 
directly can be a signpost for future callers.

I would say that maybe the times where you need to do something special 
should be pulled out into their own patches, so we can call attention to 
them directly.

[snip]
> diff --git a/midx.c b/midx.c
> index 713d6f9dde..4407db7949 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -419,10 +419,8 @@ struct pack_pair {
>   	char *pack_name;
>   };
>   
> -static int pack_pair_compare(const void *_a, const void *_b)
> +DEFINE_SORT(static, sort_by_pack_name, struct pack_pair *, a, b)
>   {
> -	struct pack_pair *a = (struct pack_pair *)_a;
> -	struct pack_pair *b = (struct pack_pair *)_b;
>   	return strcmp(a->pack_name, b->pack_name);
>   }
>   
> @@ -438,7 +436,7 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
>   		pairs[i].pack_name = pack_names[i];
>   	}
>   
> -	QSORT(pairs, nr_packs, pack_pair_compare);
> +	sort_by_pack_name(pairs, nr_packs);

I like this "sort_by_" convention..

>   
>   	for (i = 0; i < nr_packs; i++) {
>   		pack_names[i] = pairs[i].pack_name;
> @@ -455,10 +453,8 @@ struct pack_midx_entry {
>   	uint64_t offset;
>   };
>   
> -static int midx_oid_compare(const void *_a, const void *_b)
> +DEFINE_SORT(static, sort_midx, struct pack_midx_entry *, a, b)
>   {
> -	const struct pack_midx_entry *a = (const struct pack_midx_entry *)_a;
> -	const struct pack_midx_entry *b = (const struct pack_midx_entry *)_b;
>   	int cmp = oidcmp(&a->oid, &b->oid);
>   
>   	if (cmp)
> @@ -573,7 +569,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
>   			}
>   		}
>   
> -		QSORT(entries_by_fanout, nr_fanout, midx_oid_compare);
> +		sort_midx(entries_by_fanout, nr_fanout);

...but it isn't followed here. Perhaps "sort_by_oid"?

Thanks,
-Stolee
