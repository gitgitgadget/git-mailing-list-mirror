Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51EE21F404
	for <e@80x24.org>; Sat,  7 Apr 2018 15:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeDGPW4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 11:22:56 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40558 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeDGPW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 11:22:56 -0400
Received: by mail-ot0-f196.google.com with SMTP id j8-v6so4260537ota.7
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dIRu75wWzCPsgK9OyAUdtmNI3u0uGM48lSsGxwpCRIg=;
        b=RBA85QpmKtw+HlHqcPO3mNtC08eMI/7PHN2XBHc9HWlTMoD+3p/qV1WsN0Ya1XTY5G
         iDktVB10Agf7Q4jRls+N5MqlcNw1f5CE9lFLMHHl2LFsRv+sFjGNoV4Yj3r5i/ghRS+b
         613xkw8gMesowmNERRSDDE9XXo6HQkTqE+sDm2zpaCLSJvcxtVUuf2lAS/iL5eee+Zpi
         gr1kvgEBpPfv7EvkkMsW7V+qvLg0jqGynu2N/xzmHHEyTPVXFXtjhHQxjOS/6aXiKB91
         JxvhfwwarVqh9EQYWFhEXfQRNHRv/vaxHeG43u+21znBFKJzvJvB8amf0YuIm9VpV/3N
         BHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dIRu75wWzCPsgK9OyAUdtmNI3u0uGM48lSsGxwpCRIg=;
        b=Q800XEabIZTvEGNvhwgVDR2QNPltgm3g3h+qwZKUSyi7/GJIQ9pMsShF/8hqDIDw4C
         HHGn2B/cKdRYKZiY8wuPs22gxJ1fyeSVxsmrJtoUzhPWZkctuz9qszMm5+6lz95d/wda
         3oiaxbi/V1G5gYTqgKCEh+kxxTuZkvucGfcK8/u3eWm8Lp5h5wiZd9iZXsSMu9SPi5oC
         5P8vnesQNFUNVnNrcYPLjH3IZ3rwZrKDWeVgY/gwst2OwisVQm3TTTv7ZL2bQB98wzNd
         5NDiESmkNoFBZyAp6FWLkAXAozqqF7ChBWZQtvRMcyRNTID0Ko5W9bI2hDO/wtFvNmdf
         M3iQ==
X-Gm-Message-State: ALQs6tDhuRuQT+QlM+s1NEo4qclGdIU6zXJr8jPeupG0+u7HSIStVHXY
        WP7VPny/o3FmUajSiDINvv1TjFlkddo+fGd0/m/JQg==
X-Google-Smtp-Source: AIpwx4/OHTGCckl9Iok1fqpdK1J3IbtRueRjngUFGLRrXwgZoWsVPYZaWbQeyvsU/nray+dKikcVcKjjzNNjxItKGa8=
X-Received: by 2002:a9d:3323:: with SMTP id f32-v6mr20043901otc.221.1523114575266;
 Sat, 07 Apr 2018 08:22:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Sat, 7 Apr 2018 08:22:14 -0700 (PDT)
In-Reply-To: <51135137-97ea-354a-7acd-4e905ee69a80@gmail.com>
References: <20180406185801.GA921@sigill.intra.peff.net> <20180406185945.GC11108@sigill.intra.peff.net>
 <51135137-97ea-354a-7acd-4e905ee69a80@gmail.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Sat, 7 Apr 2018 17:22:14 +0200
Message-ID: <CAHwyqnV5JcW_ffMWDUqyioVS7fwAndixA8Xgjqx7TPq0huUWTQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ref-filter: factor ref_array pushing into its own function
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good to me.

Reviewed-by: Harald Nordgren <haraldnordgren@gmail.com>

On Fri, Apr 6, 2018 at 9:27 PM, Derrick Stolee <stolee@gmail.com> wrote:
> On 4/6/2018 2:59 PM, Jeff King wrote:
>>
>> In preparation for callers constructing their own ref_array
>> structs, let's move our own internal push operation into its
>> own function.
>>
>> While we're at it, we can replace REALLOC_ARRAY() with
>> ALLOC_GROW(), which should give the growth operation
>> amortized linear complexity (as opposed to growing by one,
>> which is potentially quadratic, though in-place realloc
>> growth often makes this faster in practice).
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>   ref-filter.c | 16 +++++++++++++---
>>   ref-filter.h |  8 ++++++++
>>   2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index c1c3cc9480..6e9328b274 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1840,6 +1840,18 @@ static struct ref_array_item
>> *new_ref_array_item(const char *refname,
>>         return ref;
>>   }
>>   +struct ref_array_item *ref_array_push(struct ref_array *array,
>> +                                     const char *refname,
>> +                                     const struct object_id *oid)
>> +{
>> +       struct ref_array_item *ref = new_ref_array_item(refname, oid);
>> +
>> +       ALLOC_GROW(array->items, array->nr + 1, array->alloc);
>> +       array->items[array->nr++] = ref;
>> +
>> +       return ref;
>> +}
>> +
>>   static int ref_kind_from_refname(const char *refname)
>>   {
>>         unsigned int i;
>> @@ -1930,13 +1942,11 @@ static int ref_filter_handler(const char *refname,
>> const struct object_id *oid,
>>          * to do its job and the resulting list may yet to be pruned
>>          * by maxcount logic.
>>          */
>> -       ref = new_ref_array_item(refname, oid);
>> +       ref = ref_array_push(ref_cbdata->array, refname, oid);
>>         ref->commit = commit;
>>         ref->flag = flag;
>>         ref->kind = kind;
>>   -     REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr +
>> 1);
>> -       ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
>>         return 0;
>>   }
>>   diff --git a/ref-filter.h b/ref-filter.h
>> index 68268f9ebc..76cf87cb6c 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -135,4 +135,12 @@ void setup_ref_filter_porcelain_msg(void);
>>   void pretty_print_ref(const char *name, const struct object_id *oid,
>>                       const struct ref_format *format);
>>   +/*
>> + * Push a single ref onto the array; this can be used to construct your
>> own
>> + * ref_array without using filter_refs().
>> + */
>> +struct ref_array_item *ref_array_push(struct ref_array *array,
>> +                                     const char *refname,
>> +                                     const struct object_id *oid);
>> +
>>   #endif /*  REF_FILTER_H  */
>
>
> The three patches in this series look good to me.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
