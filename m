Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA92C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CBC2063A
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fAe38uaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKUToV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:44:21 -0500
Received: from mout.web.de ([217.72.192.78]:35453 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUToV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 14:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574365458;
        bh=0MHKIdCwOXXSUsFIcIu068iKoqSw+SOoCnWhndU5FK4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fAe38uaqgUyjaG7RZqZQtPDXgcWRf1k7xXBvPNCls9yL6VD+b4WJDWkEBMRIxf4Nu
         JkTUb9JlhRuSRzQANrFK0b9bJaoiAGvDTQxi/rW94kWP67mZt1i/Rx45oENdRfKkze
         1+0XOKt2is+JNmkxDPykyMh3gzjMCBn0cDb5V8Hw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.172.213]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRU72-1iRAIk3HkO-00SgDD; Thu, 21
 Nov 2019 20:44:18 +0100
Subject: Re: coccinelle: improve array.cocci
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
 <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
 <d053612d-107b-fdb2-b722-6455ef068239@web.de>
 <4f55b06b-35f3-da06-ae86-8a4068f78027@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <06ff24b6-f154-9ec6-7b22-05b0ea664a36@web.de>
Date:   Thu, 21 Nov 2019 20:44:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4f55b06b-35f3-da06-ae86-8a4068f78027@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KiaCvTQzG6oeTQDG3fVPjOPzbHP4gix5//+QQxXp8M51d/niJCS
 VkadxB+DjNZ0bcQt8PQ9AcTVk7amJrq98Y7ZaIm5B/w24/piTDz8H35Ax7M99vi3HsoRAng
 mt+GcxJ6OvUEr0VI3CX8zD6EBEFq5qTzO3/ZtkMySiQHm8rNeuuFXgkLW+Ag6SKf+ryYGTa
 LvoD836FVxi9M5Hjz4KMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gi/NiaX8RBw=:aEzU5VNusvHL3lh5KNTuey
 t6MnOs6OG8euJ4Y0LE4z3V0Bd2kCq5VhuAuyvHVVGuQrT6Bg7lJpcD4aGAhqbTTZwcERYyAY6
 SXUzlVhYe7VjduMqimkg+7nDCqKwQLzVR/QWSdM6uWhN/WcrXdv9fiECILUgpfxqzpgt2ELUy
 6BQIOly9TQZZZyGPCWdTORtVaa7BodafXzKvn3MBWPrWPljtXjl0qCxA+cFKr0+ILq0IyqP+2
 KU6FnxkppJkfSKGI+qO7UrY7Ssu6Znlijj5S6qKj0a+o1dAF7fplvhe984YJbT3tHvoRqiN+9
 vCJ45D7TW1pKsfB0onYNpevjyrJLJ+cpGGY7h5Uv5kNAYPk4WmahfouJQGP1mydzPjkkiUEGM
 bttaKpawkwIKLL7+wndtZvPpCBPRGWMVb7RjuTl5cXPJrls2stjacdu5fLuMnIS5/elrUeeKA
 hYMMQv0Wbip5Q9MhoXXX9a0Mfwr7BZuCJO9LTPhnHwVYUl62itRdAIK7a85su7ARpqmrUCOHF
 vVbxUyauySsQ98roBgZ8l7XSQB3puCDYvVOabYHIpyTzRtTzhmTUngC7hdHk1l+yGwY35MoJp
 4u/rhqNd+68Z7GIKvBhFoCR94jscRu8dkH0tFe5CZgR5nRNL/rop4/E3hVf8keZHmJavr2+U3
 E4l+T62Iq1e5GgK/acG4JNVGJvOb3/XpudyVPT9u7A7/8Jr9Ue5T1MasVT1DA5TUsPpu6fV/2
 XCYaJnsxQUWWN3Thefx7kcDW/nwb6p2c0k7HsEZu5q3RymTpwZpVjP9IqKm6epdk629MDs4IU
 MtpPWyyGJ+NBBH8b6+tZm0xTBOeasy1ZzNHp/8VxA6XVyAUEyGHwwWBTOsufAvTSew3PEd1DD
 LAcWwuxd6/0af1HDKS5MIfpLKFkp3Dq+MmjibQVj0BKHpm4VNa6M5/Fp537iKYL//QOy7YyC3
 ZiEN1PRzGTi8Ya4EF/IAPSf7YeA1GXpNnEgy9zM9sQU2wOW9yRRiXYHt+mHpnbBRUGKnnNNXk
 YRkXbBz9qDLBGhS27GVuU+FTfg5RYUGQxRgDmu5tORDvJQLBxaRKAysqkzNyZJO+WYkhBiam8
 N8X2YZpgQh2e8Skv8fXw9h3zZr7HEeQwv0Ltg/Vneq2n7rxxH0ZIq/8FDBDlQVeDn05E/VJZe
 L7D02DtQSxMNTc2odPD1ptUg9Udir2oZSgkdsLRlmRxe8dr/FHio4aXux7pfp/wpShrJRJNyD
 4BlPCgyXy967Fzi6FeyXgiuFYPpDscFNeEjcd6OBXPl5lYXwelJnW9mEX2zg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> This case distinction can share a few metavariables with the other
>> transformation approach, can't it?
>
> Can it can, but should it?  In my opinion it should not;

I presented a software design in an other direction.
Some data processing approaches can benefit from sharing common informatio=
n.


> separate concerns should get their own rules.

Strict separation triggers corresponding consequences.


> That's easier to manage for developers.

This view can be reasonable.


> I suspect it's also easier for Coccinelle to evaluate, but didn't check.

I find such an assumption questionable.


> I use MAKEFLAGS +=3D -j6, which runs six spatch instances in
> parallel for the coccicheck make target of Git instead.

The program =E2=80=9Cspatch=E2=80=9D supports parallelisation also directl=
y by the parameter =E2=80=9C--jobs=E2=80=9D.
Did you try it out occasionally?


> OK, so --profile allows to analyze in which of its parts Coccinelle
> spends the extra time.

Some information about time distribution will be displayed.


>> I suggest to use a search for (pointer) expressions instead.
>> This approach can trigger other consequences then.
>
> Why don't we need to check the type?

I got the impression that we stumble on a general challenge for generic
source code searches.
How many efforts would we like to invest in solving type safety issues?


>> Would you eventually work with SmPL script variants in parallel accordi=
ng
>> to different confidence settings?
>
> Me?  No.

Such a view can be fine.

But I am also still trying to improve various implementation details
despite of known software limitations.


> If I can't trust automatic transformations then I don't want them.

I need to live with compromises together also with current development too=
ls.


> I can already generate bugs fast enough manually, thank you very much. :=
)

This is usual.

I hope that specific tools can make our lives occasionally a bit easier.

Regards,
Markus
