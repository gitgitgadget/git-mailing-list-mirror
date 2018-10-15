Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3200A1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 16:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeJPAM5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 20:12:57 -0400
Received: from mout.web.de ([217.72.192.78]:48563 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbeJPAM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 20:12:57 -0400
Received: from [192.168.178.36] ([91.20.55.243]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLgZ5-1gCueN27KV-000vOp; Mon, 15
 Oct 2018 18:26:44 +0200
Received: from [192.168.178.36] ([91.20.55.243]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLgZ5-1gCueN27KV-000vOp; Mon, 15
 Oct 2018 18:26:44 +0200
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
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
 <0cd89b69-4b65-f961-a025-c74851f8c999@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cd1b0e5f-94b0-4905-aee8-edec00dc0a49@web.de>
Date:   Mon, 15 Oct 2018 18:26:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0cd89b69-4b65-f961-a025-c74851f8c999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aSSZuuVhoCjz8yYA9pz3rwoFiM7Nyuq7ZSN4uWhvYxuOaatgpLO
 UkIgxV4gzD8LV/WNNXqcoYkN++MmKaXfOnHBX6hjdOm7pUTQTkBAfGZhc+JjMuaSf/DGMM8
 EEsPeFAAvvTxmZ3qIaJMP54HQDC3Olc3P7Xy3jW3CziNRpybtYl9ibTFczuiqQWKYvJnSoj
 giR+N8a8Tg8zH1cle3gHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gkKzyOZP3H0=:sMk3zEK73zdlJ9sKrqAs0Q
 pYKImR2GA7nG8nMXHJeJkL3w06QWr4d62ao4hp90FJ1eqTaSTPElCU7U7fmWPSJXTOyHYBWyc
 sA2ESq1vyM75x/YfxIbxHZkKz6KutUS4r6Ec6kbAC8o/PiEGmaRn2VQ3m7OOpLivYxd6Ut6zy
 mgVBFsioP37ODvyBa0FdTFD16DdvU7YXtgk9C0MtYVaVcvoIuruSCAt6M9KoOvG5Qw1anuHAu
 feu+99x5mZDtYczFWEqQLGs4l2Qz8RXDrbszFJ4AnfFBEq9FTf7mE5QJvmgPom8xs4i4ZbKkL
 +Bb8syNeiIDmMtMtRIQxbwIWG3XUWS2Go8PejBPbxYjCocOzLs8wka+Z7KFZl8Qt8PxaRWjn9
 TmKVGo+7XoUSSDcWdOtvbGYArO6XLwRjT35rgJB7MRHj3FnIOLt4nW45Ii5BaMt88S1JuKCsd
 EjruEQNyYbYjoY/idohXgiSGgHUkCvpgusdiJ10wUSo6J6Ddl2MI9ZLXaT8O6ZD9gCmo6OdbG
 HURDUG37iHweKTNG6J9eDZ2c8RORsSWP3VHNaYGAbnDv2M8dszlvg8LbDJFbucaYgqpsrx4O9
 LYKzO2INZ1WbJok9P4lkNgRIaKGTIJ48M8zGHsT7HFb52NzNWs9GFPkiNm5SrGKIOZ6o0k6YH
 18LaPwE8z9aVLXpJRXri8c/qihxst4XB59Q+WOr1Wjbsi6cBBJbc+XY1roviOUssvCGIjIz2d
 rkBaEivCnv1TnZlh50V/qdB/C8jKu02Qm7d0V5X1lfHXQWwUoV29pPv9ZbbO7C4VsFQwB+ZMb
 ZK7tscuEOxkSZidNI3dnpmmTA9WgodF+XR436grDNTvaioUhfg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.10.2018 um 17:31 schrieb Derrick Stolee:
> On 10/14/2018 10:29 AM, René Scharfe wrote:
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 5f2e90932f..491230fc57 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -1066,6 +1066,21 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
>>   		qsort(base, nmemb, size, compar);
>>   }
>>   
>> +#define DECLARE_SORT(scope, name, elemtype) \
>> +scope void name(elemtype, size_t)
>> +
>> +#define DEFINE_SORT(scope, name, elemtype, one, two)			\
>> +static int name##_compare(const elemtype, const elemtype);		\
>> +static int name##_compare_void(const void *a, const void *b)		\
>> +{									\
>> +	return name##_compare(a, b);					\
>> +}									\
>> +scope void name(elemtype base, size_t nmemb)				\
>> +{									\
>> +	QSORT(base, nmemb, name##_compare_void);			\
>> +}									\
>> +static int name##_compare(const elemtype one, const elemtype two)
>> +
> 
> Since you were worried about the "private" name of the compare function, 
> maybe split this macro into two: DEFINE_COMPARE and DEFINE_SORT. Then, 
> if someone wants direct access to the compare function, they could use 
> the DEFINE_COMPARE to ensure the typing is correct, and use QSORT as 
> normal with name##_compare_void.

The pointers are converted to const void * somewhere along the way from
qsort() to compare function.  Splitting the macro would require type
check tricks to make sure the types of the compare function matches the
array to be sorted.  Letting a single macro bake it all into a layer
cake of generated functions is a lot simpler.

> As I think about this, I think this is less of a problem than is worth 
> this split. The commit-slab definitions generate a lot of methods using 
> the "name##" convention, so perhaps we should just trust developers 
> using the macros to look up the macro definition or similar examples. In 
> that sense, including a conversion that consumes the compare function 
> directly can be a signpost for future callers.

Using the generated compare function name directly is a bit awkward; e.g.
in the two example cases it would be sort_by_score_compare() and
sort_packed_ref_records_compare().  Defining the real compare function
the usual way (with a proper name) and having the DEFINE_SORT block call
it is a bit more repetitive, but clean and understandable IMHO.

We also could just leave complicated cases alone..

> I would say that maybe the times where you need to do something special 
> should be pulled out into their own patches, so we can call attention to 
> them directly.

Right; this patch was just a sketch.

> I like this "sort_by_" convention..
> 
>>   
>>   	for (i = 0; i < nr_packs; i++) {
>>   		pack_names[i] = pairs[i].pack_name;
>> @@ -455,10 +453,8 @@ struct pack_midx_entry {
>>   	uint64_t offset;
>>   };
>>   
>> -static int midx_oid_compare(const void *_a, const void *_b)
>> +DEFINE_SORT(static, sort_midx, struct pack_midx_entry *, a, b)
>>   {
>> -	const struct pack_midx_entry *a = (const struct pack_midx_entry *)_a;
>> -	const struct pack_midx_entry *b = (const struct pack_midx_entry *)_b;
>>   	int cmp = oidcmp(&a->oid, &b->oid);
>>   
>>   	if (cmp)
>> @@ -573,7 +569,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
>>   			}
>>   		}
>>   
>> -		QSORT(entries_by_fanout, nr_fanout, midx_oid_compare);
>> +		sort_midx(entries_by_fanout, nr_fanout);
> 
> ...but it isn't followed here. Perhaps "sort_by_oid"?

That function sorts by oid, pack_mtime, and pack_int_id, but including
all these fields in the name is a bit unwieldy.  Being unspecific by
calling it sort_midx() was the lazy way out.  Mentioning only oid is a
bit misleading.  Perhaps sort_by_oid_etc()?

René

