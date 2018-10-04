Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7021F453
	for <e@80x24.org>; Thu,  4 Oct 2018 15:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJDV7K (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 17:59:10 -0400
Received: from mout.web.de ([212.227.15.3]:51393 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJDV7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 17:59:10 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxO2c-1ff7Mv22CQ-016ttr; Thu, 04
 Oct 2018 17:05:15 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxO2c-1ff7Mv22CQ-016ttr; Thu, 04
 Oct 2018 17:05:15 +0200
Subject: Re: [PATCH v2 2/2] oidset: use khash
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <5efe6695-2e82-786c-1170-7874978cb534@web.de>
 <20181003194051.GB20709@sigill.intra.peff.net>
 <d17f104e-7cc2-5e73-78c9-6c268f9ec5b2@web.de>
 <20181004064833.GA9051@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <413fc698-87f8-f1ee-810a-ec9b143db299@web.de>
Date:   Thu, 4 Oct 2018 17:05:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181004064833.GA9051@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DlcA9omP215CEAI+2oaw+Vba9TDHyravgvGq2Z9FU6d22tMY6if
 uRDideJVFyPZ16TG/9LHGzbtKgQvEYWVHVE3bk7RRWovImWXx2qNhRjzssNISzNxzZdfw+J
 fscg9RzvZ9IAT4ISKYauzVKrPfi1dTyMyJNW9wdJjy+SXVaJTEcPAnzYG33dDGFDU3P9Yh6
 NBmV947yQJbY0tSqkmMgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TxuggABjO1M=:0XFHLhmPlLTEinisGAyAMN
 wG/iThWf0v61hxL4b7oy8oFYftSgj3OoZ8E1PFEM2Idb75Yaa7x7NMkjEYHZF/Ey1f0weKO3m
 +C2KPNpr8wuzY99Hx1wn1Kx9GtesSzrUmLYnjVUx5h9iH0ogwyI/4CpyEDxI4Nen7pbDS96px
 tpcXmiv55PGdqsVqRYyB9FrKLTDmU5M6iP5ByO85K0bO9xipEzs97mqXEfM/fQA2idZNu1E7U
 PCaEqhZyxD5Rw0wBxeu/9vWu/owqZUbO1vHZJqjiCxDuN/WCnlw0OL4dF3KIr+smI4VYYxxFW
 PlRGH3QT9SX88L/GE8+mmVBU3Adn0GqwF9syqAZGfjWKZTtxsUfr5tygVeo8W+tIVqI0Y6WCm
 1suU76xfffdORv6uYc1T1eDpQfzsmes/O/AOpwPvQSQMB7/qRoe4/pf81d4kMiwG07JiQem5m
 l/o71Z47K/nLTZr//WfWiwTRAkaTdynGm2k+UQJxzMen4QSC2ku+vRo3XJjl32i0SN8cUKPLR
 VD/uTuuYpDEfpO9lsN0xJYfC0FtfLJcv0T0mbcIuQ79x/ttC9eyeLEtlV41GAFtn0luukwKI+
 O4OJ0vAbHXvOTXEE+8v8RXv09a/agSJgLPxCR3xyY/OiNoaligsQWS5+O2xcHoONEmD8zldq0
 AS4LvLNCo7cb5op96sqqFTgYuRkU4+EAslfNxYIIVU12MoD/6eF/7mULMRIUQVHy9CcLkcE48
 uck9moYq83nxVuQnvE/l6K2XQn/fb/DCmMghYPJeJ4uOjfNYhxgURnRyYFo/2egiHbioLXe49
 95IY9EYQiSR7rfD/yfBqXB8nNat+sPuEZc3W4E/RobpmZanGP4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.2018 um 08:48 schrieb Jeff King:
> On Thu, Oct 04, 2018 at 07:56:44AM +0200, René Scharfe wrote:
> 
>>> As the comment above notes, I think we're really looking at the case
>>> where this gets populated on the first call, but not subsequent ones. It
>>> might be less hacky to use a "static int initialized" here. Or if we
>>> want to avoid hidden globals, put the logic into filter_refs() to decide
>>> when to populate.
>>
>> Right.  I'd prefer the latter, but was unable to find a nice way that
>> still populates the oidset lazily.  It's certainly worth another look,
>> and a separate series.
> 
> It's a little awkward because the lazy load happens in a conditional.
> You can fully encapsulate it like the patch below, but I actually don't
> think it's really helping readability.

*Shudder*

>>> It might be nice if these functions could hide inside oidset.c (and just
>>> declare the struct here). It looks like we might be able to do that with
>>> __KHASH_TYPE(), but the double-underscore implies that we're not
>>> supposed to. ;)
>>>
>>> I guess we also use a few of them in our inlines here. I'm not 100% sure
>>> that oidset_* needs to be inlined either, but this is at least a pretty
>>> faithful conversion of the original.
>>
>> We could inline all of the oidset functions, following the spirit of
>> klib/khash.h.
>>
>> Or we could uninline all of them and then may be able to clean up
>> oidset.h by using KHASH_DECLARE.  Perhaps we'd need to guard with an
>> "#ifndef THIS_IS_OIDSET_C" or similar to avoid a clash with KHASH_INIT.
>>
>> Not sure if any of that would be a worthwhile improvement..
> 
> Unless we know something is a performance win to inline, I'd generally
> prefer not to.

Agreed.

> For a case like this with auto-generated functions, I'm mostly worried
> about bloating the compiled code. Either with a bunch of inlined
> non-trivial functions, or cases where the compiler says "this is too big
> to inline" and generates an anonymous file-scope function, but we end up
> with a bunch of duplicates, because we're generating the same functions
> in a bunch of C files.

The _iter_ functions look harmless in this regard, as the only use small
functions that are not even type-specific.

oidset_init() would better be moved to oidset.c, as the code for resizing
is quite big.

René
