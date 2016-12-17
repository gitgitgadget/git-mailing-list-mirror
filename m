Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37FF1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 19:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbcLQTmr (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 14:42:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:63256 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbcLQTmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 14:42:46 -0500
Received: from [192.168.178.43] ([88.71.237.80]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MC7em-1cRAZ82eAa-008rNp; Sat, 17
 Dec 2016 20:42:42 +0100
Subject: Re: [PATCH v15 08/27] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ab6-bda8420e-9a63-47d7-9b99-47465b6333d9-000000@eu-west-1.amazonses.com>
 <a4c7fec8-0e84-eb53-ca22-c369ce3facfa@gmx.net>
 <CAFZEwPOZhO=sXLVwh03C8QN0uVXBUfb=xZ-JS003tgCNLgVOjg@mail.gmail.com>
 <CAFZEwPO2WgBjOnmvu1VOiz3PMYYx2mxircCWk+BWxmuunC=VQA@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <22624028-b22d-5e4f-7101-c97e6e3e853c@gmx.net>
Date:   Sat, 17 Dec 2016 20:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPO2WgBjOnmvu1VOiz3PMYYx2mxircCWk+BWxmuunC=VQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:vCKva+lVUfra+j1Qqc3G7U2zQ/KvBE248AEipTs8jpJwoJ+GJN8
 Fmwl6onGsPjOaaCRcvYZSV2wlJok8L+rItHJdwefEw0BnCmOb4KTJ2X4RBtrA3r9czVTpdd
 kidPhsYJEJIAGmXbSkj2zrfACqabum2scd/PqtbNTkk9tYsDpSmaJfqjuKKRMt1K5g4sJWh
 XboCaArgqU7OArNx8+42A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bOGYREQfK+g=:GFskoWOC26usRW2FreQxBJ
 nxT9XweY8dO5+ZCePNlRoHVXZThwqeGN/yt6B091WHf8R/uHknzHEC9GjfZGU7Nw0b4Sj5ptB
 ozQQK0D2+46DE9YOtdTFhzwoI+WeOC8mAWwvsEv1sYYV/bZg8bOBuJWjVdOu/8fytcdI1d6Wl
 Qp3ZRcmnUgmQVA5RgUNC67aDwwJeydqua22d4SArYqFQBE2O8kIIBHdv996k7v8fnvnejajzW
 aVTnFrLvfe62cWXrPVH2NpzanOW8GFoLURASxNuyxKV3m8zeFrCMxGy4ayFz6LbHVby1qyvAo
 P0x/vRoRt2WUq/q9LXl4MRTBiQy4VYf6tcxpAhSp3TD7gH9vhkNLFw91Q2D06+s5Pyv0vKjk6
 JJq34ijA/UugvBq9aXgWlfpBDdAe/DTOO/D6hhVwXxEZ7qqKlC/lLfx68yDEQKX1TeiIkCvvz
 akYI6l9dvun7YYvCaqV2qNxT2eu8am4WQlJEdQJ4ekZPtOilWKf84nBW6z+lckyzXeCLqX3oK
 uvZc4VJ5WUdREjxMsxdz2q5QdBfucALF2bfs13KfL8aamdxs8LqL+/KqEkn2djqQhfdVKoQ3E
 zHEavDXMviHhf/kU/bzZuNw1aRzUb6El9P+F6riv2ezvVCkLs2iXJfr53MoNZGqJZtB1cSt3h
 ESH7F8ksliEQVz1M//2p+JQKd4nEidhjVBvUfAE6k55JSP22XTGpm8EizciGu+skLArWA4ORM
 SHv5joN8xtH0Bt1bIH4az0gCHd25e75ASJ2o5N4WMDNmoMFkbZuzUlF0xZmn65ecLkpsS5Cu8
 TRt6VZ7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 12/16/2016 08:00 PM, Pranit Bauva wrote:
> On Wed, Dec 7, 2016 at 1:03 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> I don't understand why the return value is int and not void. To avoid a
>>> "return 0;" line when calling this function?
>>
>> Initially I thought I would be using the return value but now I
>> realize that it is meaningless to do so. Using void seems better. :)
> 
> I just recollected when I was creating the next iteration of this
> series that I will need that int.
> 
>>>> +     case CHECK_EXPECTED_REVS:
>>>> +             return check_expected_revs(argv, argc);
> 
> See this.

This does not show that you need the "int", it just shows that you use
the return value of the function. But this return value is (in the
original shell code as well as in your v15) always 0. That is a sign
that the "void" return value makes more sense. Of course, then the line
above must be changed to

+     case CHECK_EXPECTED_REVS:
+             check_expected_revs(argv, argc);
+             return 0;

By the way, it also seems that the original function name
"check_expected_revs" was not the best choice (because the function
always returns 0, but the "check" implies that some semantically true or
false is returned).
On the other hand, it might also be useful (I cannot tell) to return
different values in check_expected_revs() — to signal the caller that
something changed or something did not change — but then ignore the
return value.

Best
  Stephan
