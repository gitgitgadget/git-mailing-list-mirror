Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BBFC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2726191C
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGCM7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 08:59:48 -0400
Received: from mout.web.de ([212.227.17.11]:43421 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhGCM7s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 08:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625317021;
        bh=Laly+Q0DLWNXSJE+zup/p1pvxtAMYGysJAWOETQv0JI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RLxf18rvfd6iFm4m2MGfyet36mSWpWQjJPwSEsAgfhjq5/OVL/9PXsg9WBhx5fqgw
         39w/yJCHkaXsHCQyjd6hMXmVjd7U4t2mAQ/Lc8L8VMM9AarhJ1VBPVwux14EVKQFKC
         lRC/AB2YcSZ54ZufUnPiiXKYYgQ8C1gajF22Rtz4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MK20H-1m12FM0gkv-001Rr8; Sat, 03 Jul 2021 14:57:01 +0200
Subject: Re: [PATCH] khash: clarify that allocations never fail
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c25f0c5a-ccb7-a490-bd7d-90704478a896@web.de>
Date:   Sat, 3 Jul 2021 14:57:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LdGQ2ybNJxvYEiHuhmrCRzid0ohX9BhesxLJzHI2RbZEqMXGtWo
 D4aF4o+7XeX6gh7nlXYo29NFfW3ElUQYoxb5xxqyyh52rm8htBTQ4LJ45ONODRcjOwlMXkf
 4ez36/1szrbphS+zWXyclQyBNVKPQEWHw2R8Wq1GQ6QKG4HM7u8X4OqSMahsac5aoXoA3pO
 Og+4utKd0cuQAJdDlNhMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WG1JEoySQPU=:AgrvIwA3PKJOsWOs76IjqK
 OnAnIYd7/xw5kIlmAIpv3x+o9PLtTEnXwky7F225fIHL/f5vyhB5lQIKSJgj51WtzQ/0WOSd1
 eSOSF2rM0W+oRZlATQrq1YOa++Bxh8W/dYjId2aYzePHLzfzqA/OzfiMg6t2CMHCwvdVK1lcv
 BhqqHkfQeQU50oAS3CkRlAejFTSq9Fikh09mGVG+hafQW4+WUzrKo/7e3TdnckaKbguiXVJWN
 i5ZZDIcxw3yPZ9h/w7Ve0B9/HNJgbRsJvrz0QWlu6xn+8d4utjFRl8Oz7JC4Cgm8eQTGxG+xL
 0hv57yFa27cYZZXXl7fHo1r3umpef3HrARPhyDPhEBnR952+ZT5pGy+PIk8W5j48Tk1Uu2h+8
 0ZFA7eJ1/Dvgk9/+v7c3Kfc6GcUa2Ow9ivd30sTc5ViP/wlEbV/l1mdJXP8fks5aplZXQ6f7Y
 e2ieWoMiAqdiU+Mgj844tlWNtv2JTrL2qvwGUrgp5t/5alnJiKibrewnJbTDr12gddgjFbVT8
 eaVNBgZTnGgnUuhKOPaYOYR71z3luWs8H8+WQB+1FVvmEeF7kvKAZU9UDH4iF/izsIEQDezwq
 7kSRcZznVnouY8nELuZ/NTmMmQYEiOmSyR9H91t1j1hmIuIl/ahbkKJYVXuP7umGFujKV4/SF
 AVc3eOVgYLZWJEmClon6BummvUIlffBtcmkdnkgCun3C2M+wQ3FQPP+YpkI/UWfcX+CKtr3ty
 dNc4EqI2agUMHiI0jyeywEQeCqlsNrQl05iVVLFXeXE7Q4OS0TR2NjO2bLkvwDzPqYpz4NaWR
 SqqVbzi/yYqPM54jIKticQ5MfGKlel5oM76AzA81Wz3wN5QfgHh9SrvMhdIsw5hKlKHvuk6kP
 khS5UAEWese4umy3kBE9iwd9j/0wA+I1Q2hEubwUKTEB5XTbo1/1nmZ0JbRgl8Vnep6lxduBz
 DYvevhOCwBuzJo6X30/tjh9ixfkuLxvjWVnmTaPcbgnNNDGU8jBwNU0NWmQ5FJQFIpXGQUsC2
 gHUkpE22YYwFuCrJ8VLwdxWW2EvMP7lY1Wtc/VOrw/BuN2ee3w9xqLw7zEibAL1HjP8SuUxdk
 L35XSiHTi55kfrJhNIghcQlxR+AXdFArWk8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.07.21 um 12:38 schrieb Jeff King:
> On Sat, Jul 03, 2021 at 12:05:46PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> We use our standard allocation functions and macros (xcalloc,
>> ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
>> the program on error, so code that's using them doesn't have to handle
>> allocation failures.  Make this behavior explicit by replacing the code
>> that handles allocation errors in kh_resize_ and kh_put_ with BUG calls=
.
>
> Seems like a good idea.
>
> We're very sloppy about checking the "ret" field from kh_put_* for
> errors (it's a tri-state for "already existed", "newly added", or
> "error"). I think that's not a problem because as you show here, we
> can't actually hit the error case. This makes that much more obvious.
>
> Two nits if we wanted to go further:
>
>> diff --git a/khash.h b/khash.h
>> index 21c2095216..84ff7230b6 100644
>> --- a/khash.h
>> +++ b/khash.h
>> @@ -126,7 +126,7 @@ static const double __ac_HASH_UPPER =3D 0.77;
>>  			if (h->size >=3D (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) =
j =3D 0;	/* requested size is too small */ \
>>  			else { /* hash table size to be changed (shrink or expand); rehash =
*/ \
>>  				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
>> -				if (!new_flags) return -1;								\
>> +				if (!new_flags) BUG("ALLOC_ARRAY failed");				\
>
> I converted this in b32fa95fd8 (convert trivial cases to ALLOC_ARRAY,
> 2016-02-22), but left the now-obsolete error-check.
>
> But a few lines below...
>
>>  				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32=
_t)); \
>>  				if (h->n_buckets < new_n_buckets) {	/* expand */		\
>>  					REALLOC_ARRAY(h->keys, new_n_buckets); \
>
> These REALLOC_ARRAY() calls are in the same boat. You dropped the error
> check in 2756ca4347 (use REALLOC_ARRAY for changing the allocation size
> of arrays, 2014-09-16).
>
> Should we make the two match? I'd probably do so by making the former
> match the latter, and just drop the conditional and BUG entirely.

Yeah, makes sense, thank you.

>
>> @@ -181,10 +181,10 @@ static const double __ac_HASH_UPPER =3D 0.77;
>>  		if (h->n_occupied >=3D h->upper_bound) { /* update the hash table */=
 \
>>  			if (h->n_buckets > (h->size<<1)) {							\
>>  				if (kh_resize_##name(h, h->n_buckets - 1) < 0) { /* clear "deleted=
" elements */ \
>> -					*ret =3D -1; return h->n_buckets;						\
>> +					BUG("kh_resize_" #name " failed");					\
>>  				}														\
>>  			} else if (kh_resize_##name(h, h->n_buckets + 1) < 0) { /* expand t=
he hash table */ \
>> -				*ret =3D -1; return h->n_buckets;							\
>> +				BUG("kh_resize_" #name " failed");						\
>
> After the first hunk, does kh_resize_*() ever return anything but 0? If
> not, can we drop its return entirely, making it more clear that it's not
> expected to fail? Both for human readers, but also for the compiler
> (which could then alert us at compile-time if we missed any error
> cases).

Good idea.  Both type of changes make syncing with upstream a bit
harder, but even though the return type change bleeds into the caller,
the overall change affects only a small area.

Ren=C3=A9
