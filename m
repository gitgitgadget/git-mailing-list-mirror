Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5A5C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 07:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B652070A
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 07:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HFne9SOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKVHef (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:34:35 -0500
Received: from mout.web.de ([212.227.15.3]:55077 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfKVHee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 02:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574408068;
        bh=ADriBBUTQVI1gvxJPRyGCsIkovLOrz8cXUsghNM3IdA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HFne9SOnPNggyCAp1POeV7Qrnwm4McXZNw8maaHeeB2U1sCIT4DJhrLykpuLJXR/b
         ZSf7FdK8wqfzeXmPk6VM1CpUwE3UExZnixuJXK8eIj+11+VDiBeolriwLyMILcjhTz
         HcswuHkahp/ey8C9+N3Bkxg7My1LQ+335GSvVs/I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDxFv-1iclVD1Cjn-00HNGu; Fri, 22
 Nov 2019 08:34:28 +0100
Subject: Re: coccinelle: improve array.cocci
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
 <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
 <xmqqsgmg5uck.fsf@gitster-ct.c.googlers.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ac5a0968-734b-6395-c1d3-7267370d2286@web.de>
Date:   Fri, 22 Nov 2019 08:34:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqsgmg5uck.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:nAt7tXuDqF+cFBvdmmcSxX9n5Tb4MvqxrKyTOIdL4S2sUtCMGlL
 mR92LItY0Z17k7Rxwx6cunA6MMLp758XU2QhC7q/QIgCHwC915snjCK6Z8RzQUeiqnw1ASL
 DmCGTOBjDcsSEj2lErZ9H77PRPma8pA8oY0tSE7NpQqsvVyidDkIpwUFjQQHu43p+3SHAyI
 k2a8aDMEH8rYJA4leNnAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0F3z1QFxrFc=:HdmHZkwJpNvOE2DgZy1Yvv
 UxmPI33P5LOuuSqJLVw8nw6x+vbddbHzk77+GP0DSG6M3PGw0PLrGxnfGOaDlKdx5l6bH4AZ7
 0Az24L2+elw4qxlEhXg1MkS3HJmLFetNn6aq2uoONDmlQw0kLb8Olc4oKc9myHEaa8iEsjw7o
 eTzIfH7vlHx6WuPbr+glJpB8mHTpk5Wv4V2n9XFHkO9N+IVG+z6tiC5KvwWo3l7848HaUoLuF
 E/4nzEaKsB/j/wAjIfeGEj/sLyt2NUWRwOl0ODOiawQsPx3qWffGVH0hdPIs3w23hsr8S5Axz
 1UFPH6LeD72hD1MHAj+yrXyColtSnXnqaKd9i3L8w+UzXcrQziIpf++YWGz1WZ+12MRbRJJ7r
 aMuLKj7ibUW6I7Hec4W6mNr23CMfJHkMfyflzHUzoD+V8D2kCxk3VvkDu+vceUZn32G8R4Iu7
 m462UbKybCCjmyK3vEPwDT6bHhs8fZCLqinNnAvTAo8zfEqYnWlAevao6n8LwJpzT/iwItRt5
 8Xh2qrsURAkzqbve7gbaTZ72cx0uzRDWFbv9BhVw5vvEbBfrbtdz/sQrKfRNIvlz4NJ9idkqq
 h1FQSFcRtn9hKL9EC1Oi7+mTse4UrfdIdVJTlR28WI/DEGNUIwjMJ1FQAZkveOUfr0UyI2O9k
 y2WLquN6oHW4henRMOdtofvpza+rDvdBP5FkJ0cykBgZ0SpZ/2Sc4rrioUlQ/b+EOgLxq/uIS
 68DkPpHDcS02/rtYhj/RTZ1uJDRJX8fQ3HGa11P9ozs5PavdiV/PDB7mIJ7lxi2aefJLceTCB
 d6QyT7wUt6NmhuS3zporBYDwaw/kaQ2anWCjfJxqLyvKzb2hJTm+nffBL+wCfDSEmZZfGI0TG
 bZLswRtoodps6EfHtdsrRzWfDZzF3qs11MTeOEDujBz86QkjBHBEFsxQP/opch7xbCxNcaxXB
 BN/AS7qwygpmgaOLK3w501VzBEQgwf+laUniK69z7NK7CM4ftoaabDI95JBcloJfs8AQ98JQG
 ajGwX94Aok+WuO+s6u8V99rP6kQ1cUfNZOmCXULNrllHk8UPbq/GNbHY8aH7FvYuczOjIzzwH
 25P5C94JOvl63TlVsGjSwD5aqR1YCKxE7hhlx8F4X4WQZXnXAZoHwTGrPYih3ngvRnVRKwwAe
 7vH9CemZ7ssYHo09TpZwNrSXyn47CN0z/5xA2X/kPJ5lmRCj4RL9dz0bJ90bT+kauL5WcDRbC
 afrH76JRonyODmXMWiw/Y7EdRYYLmDZRmhAmdZWH6PifjW6trhcvaNNBV48k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Nicely said; I agree 100% with you that the priority of this project
> is to use these *.cocci transformations in such a way that they are
> absolutely safe

Such a goal can be generally desirable.

But I got the impression that there are target conflicts to consider
for the currently discussed SmPL script.
The available transformation approaches show different open issues,
don't they?

Your desire is easier to fulfil for other change patterns.


> ---so that humans do not have to spend time sifting the result through
> to find accidental bad transformations.

Automatic source code analysis contains the usual risk for false positives.
How many efforts would we like to invest in improving corresponding
software solutions?


> And thanks for taking time to very clearly explain why the proposed
> rewrite is not something we want to take.

Would you like to check once more if additional update candidates
will be found in the source files with the presented SmPL script variant?

Regards,
Markus
