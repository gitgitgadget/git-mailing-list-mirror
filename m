Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ECACE79AD
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 08:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjITISg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjITIS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 04:18:29 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1042B92
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695197892; x=1695802692; i=l.s.r@web.de;
 bh=0kygrHdBsdLxGBG93ykAzPu5PHXbOjjGwlKMya/cI7M=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Z2xvaClmKAdl0ab9s6mOfWEqqiTgEtTKGRfc7jHCb4gLyLkz7YESmo4jf/BJ33Dga4iubrlnnOI
 FxB7p0o++eLI9/uaH//QVHqDtL5K5YZfbEq+hVCJimYu0TMuOfhWURgqw8hQQ2CoKPHkIpkkzAUSk
 GiMlulRpSSjE9wr4OtefhFwyLpyqGIWl16LYj75Uy4AN6OmXFsvmiKTT1y62s2+2jl9O4RLtNe+5X
 0/gvaMU5CJuEWek4HPa9rczqqjbfvUQ5LfYSMIml9NEh8wM5R7QMejtzkYMjdEOoVUbL8SYXtNM4Y
 DX2KMmMfwXVQk6upckBPSAoCOiZXbIwjhPng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjIb-1rEYQW3Og3-00WqTe; Wed, 20
 Sep 2023 10:18:11 +0200
Message-ID: <f778bc6f-dbe1-4df6-95ff-c9e9f36a3cc9@web.de>
Date:   Wed, 20 Sep 2023 10:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZQlspgfu7yDW0oTN@ugly>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZQlspgfu7yDW0oTN@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pw9U0CNsnzbvaNXdSIiHalqaIMHWbZjWsbXGkwTEqMF+VmPm+7f
 ke3Ayn2y+ivNmbij/Ljr+M+b+66RJDpjfFFQyjXk2c50zo3465n7qAxdP6dUhupkLPsUCom
 g1317pT7ubKZ+63oJ5UEXK4X79Yu8/YGMUsWoVwHVdyW3N93rnRI7jxOSjh2F2/vR7mYGxx
 0H7NnK1hId7rs2KG8kZBw==
UI-OutboundReport: notjunk:1;M01:P0:vPz2nP6laTo=;2WMVLecBxYkjIGirkbfrIhBbWyM
 FWQOJdCft4PhRBcKS8q+bwfPGJ6wQP736zrbg4vXrPKwBjFV9m6XhBU0IrPT1uhbr0iirGRl/
 veiBTvFLosnKcm4c8dA+KK9LV1ncrAGzWXdxbtudGYij9FNVolqhEQQZ3RjtfXj0S8bz4svGd
 iGRk+FrNmBSHgARs+INc78h/go7iXy2Tdd6PwopUEsfJ5TGWUZziKyhQHF8oZ/v1pabfkm0b+
 NVRXKLXeupGfAf4GT2gB6fssD76R5JXBxP35Wo+gkZoRf2IadsRxgHsYpWH6vIjEeAbrWIQQv
 0ZxrG02VUQNMopVsdo8aedaNQa/z6o2/uqbordZqQ4n5eTrkKfuEtT+vN5tEoQCj4Egw9VokX
 53V7abQ4qAfSgKH7vKvYqXTzkZ3aabB/CnKmidt+C//ougZ4fHQ0sPPUTxIZbU9S/f6lW/t1N
 YfhE3kqqf8AWOqUik0nqzQ0Dl5TIpde91WT3qgG0V7Jx0tAsPsY1EByPr/3JkOkTeC9XwYoMA
 COryxRXfQKtdqo/QTuEzO0ArKJy936KzMkaVHRc0EZ8xfIJHgO1Am5/1rXfJ28CDZJpBSlB2i
 lkJxliqGyTF8BFyY6ucn4ABamglI16ntuRXb7b9mfS1PIHqKVcAjLKR2v2B1mSHc0j/IK/Owr
 OsWBDKfARfOSnMAKF1Ea089xQjf2U66cAX/YbE6MmZWZxT8lBhJLIuzVbi87gQ+0TzUdJV+yJ
 qrEQidpEkmusqBVRMOuD/EfM9JUvxwHglQSLh9aeNdvSJxskDhslZLthaRHmoIKFYgeGSvaTw
 D6447Clqu72Rb3WS8o8YAScRuD6BWFENxaDozlTvpOthal+63IzPDaMTuLFXOxzHRrEJsaU9/
 v44wyaBKsS+x2XMM6umsEfp8ImQBNeLCmGr8S55AKHYZJYcu9hS/T3P0Fw9iXjNGM3Xi+X7/L
 e+5+LA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.23 um 11:40 schrieb Oswald Buddenhagen:
> On Sat, Sep 09, 2023 at 11:14:20PM +0200, Ren=C3=A9 Scharfe wrote:
>> Some uses of OPT_CMDMODE provide a pointer to an enum.=C2=A0 It is
>> dereferenced as an int pointer in parse-options.c::get_value().=C2=A0 T=
hese
>> two types are incompatible, though
>>
> s/are/may be/ - c.f. https://en.cppreference.com/w/c/language/enum

You're right.  Citing the relevant part: "Each enumerated type [...] is
compatible with one of: char, a signed integer type, or an unsigned
integer type [...]. It is implementation-defined which type is
compatible with any given enumerated type [...]."  So there's a chance
that the underlying type would be compatible by accident.

When we try a few combinations (https://godbolt.org/z/KvKcndY4Y),
Clang warns about incompatible pointers if we use a pointer to an enum
with only positive values as int pointer and about different signs if
use a pointer to an enum with negative values as in unsigned int
pointer and accepts the rest.  GCC accepts the same cases, but all its
warnings are about incompatible pointers.  This seems to be dependent
on the optimization level, though.  MSVC warns about all combinations.

>> -- the storage size of an enum can vary between platforms.
>>
> here's a completely different perspective:
> this is merely a theoretical problem, right? gcc for example won't
> actually use non-ints unless -fshort-enums is supplied. so how about
> simply adding a (configure) test to ensure that there is actually no
> problem, and calling it a day?

That would be an easy, but complex solution.  If the check is done
using -Wincompatible-pointer-types or equivalent then MSVC is out.  If
we base it on type size then we're making assumptions that I find hard
to justify.  Using the same type at both ends of the void and avoiding
compiler warnings that would have been issued if we'd cut out the
middle part is simpler overall.

Ren=C3=A9
