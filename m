Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFFB41F453
	for <e@80x24.org>; Wed, 23 Jan 2019 06:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfAWGfn (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 01:35:43 -0500
Received: from mout.web.de ([212.227.17.11]:47369 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfAWGfn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 01:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548225331;
        bh=fdi2pMngUk/NtA13TRI3E2yRKSuU2YdPJ9QySzvEjHs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nK/Vrc8uYp16tLoRrx+xhf+mA5YFfDPz8fcbuPXYRFveBdKeMATmWL+SZJwWuHqxZ
         +RITgS12f7WSIyxO1D5O89NM9mgQwU8gbN7+QDOa9GLh4SW123Y3MXyP2DWn4p/sr/
         eOfdWU8BnGblbV3nG26jfwvkDeZ0lcVUxvaQ4ZY4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.209.21] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxwiW-1hIM5v0hU4-015KB9; Wed, 23
 Jan 2019 07:35:31 +0100
Subject: Re: [PATCH/RFC v2 1/1] test-lint: Only use only sed [-n] [-e command]
 [-f command_file]
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        zhiyou.jx@alibaba-inc.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20190110115704.GL4673@szeder.dev>
 <20190120075350.5950-1-tboegi@web.de>
 <xmqqo988fpag.fsf@gitster-ct.c.googlers.com>
 <799c5063-b0a7-df6b-6f86-a92b8b6d679b@web.de>
 <CAPig+cSDnhvVCDE15koO9M1A8TBg+Mbn2OBsfXVvshmRyybApw@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f7871d8b-a19b-5816-120b-ce583debc4ca@web.de>
Date:   Wed, 23 Jan 2019 07:35:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSDnhvVCDE15koO9M1A8TBg+Mbn2OBsfXVvshmRyybApw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:emE0Lr29hWmBt3fEkUB5Q5zTIbVLe+h2roJIuFjK/UZrPPz8Nio
 qQ1QsH+kG7qqOsKjHAgwlQ4lFFz6a+cJuCpUBGevcnv2LmustR5E1xYzNdrt0eQWLok9T3c
 yGNglekjdBja/PKSnkNaJtrxP/ImTkdPUUOVq6uldsFmrzRFgsN1y8tRDg3rcXyLeBMt5/X
 uxxn2jieoGcvgsRbnlT4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TuWj6dhFK74=:B7d9QyOV0FAZFjv/6BElbk
 vnWvyk0mxxcZ4BlYTBLST7u4dcoGOxY90CR651eaCvQNaCnICreW4/RCY+Hd1AL4K5/k5riBi
 WCeOjqxfCuXgUudXDrAK28DCX8aqTqQL6iRzckuOzzofAnCbHcKlFvse8ntEwwrEXbleCG+Ek
 fi2t1hmUVIqvFMPUo33rDjTqaDfcPlTuOhyF4ixVpQS5hxeNI1un4XT3moPkEkGzidiQmt9G6
 CAyNwm06Z9LDBX0H07TwiDxtJZKahqriaftLuARgCvjZwgSO/+ITKTaM/mdQ11BD4TmAJ2gNc
 JCyVQk9INUkSWuu3yGrWvtiYs7D2wq7Apc5edYFY6EnkwOkFVquo//yz4HqP3xbZ0Cc3hEBd1
 YgQIJerkyCDE6SiNzHuEvVsZBiEuNO209gWra71tm9EThVUnEQnP9NE5Z9URN4KCQLe4mpjWG
 9yyWnvmafc2KHu79aKb9fP4UtHCBe5ksbM5kZWUQ9wA79CQLzqM7B9iSmITz8OAxDzpVfTHR4
 hqUEGjDjysQyJcVLW6AS9jo8suhqI27Bz2M13y7rA5anTVCgv84sOABx57RU1sKS9zYCBW3QA
 JeQ3ApkrJY5rlgEmbBOoNeAnO37k0yinauBIU6RTtIcBcf902eAB12VHHGrz2Aepz8VSQ0q9A
 1QTbHdTySpeRzQsGjcmb8o/h5n8O+UvGq/JOXkTXzviD45/SX/4X5IE5PARPuo9ydPAi0oGe+
 lz8iLMwsyTpk2WlOBqOCIyDSdaVan17iqzh5qNwXqq1A7uYOE2j+Em9emCPLEOY5yXr+no8eU
 Iz23Rj3eSE8LdrTmkRYhmcTSDNMYUt4rwh76CEhhFnntzWuFRAfiR9OdsfNFlfUuwdsz81QfD
 mizEU1AFi4yyK9VjdZSeMO8/LBcUwaAap1Bt2TFdGOcgLWKHBYKZAJKn1S3FuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.01.19 22:15, Eric Sunshine wrote:
> On Tue, Jan 22, 2019 at 3:00 PM Torsten B=C3=B6gershausen <tboegi@web.de=
> wrote:
>> On 22.01.19 20:47, Junio C Hamano wrote:
>>> tboegi@web.de writes:
>>>> -    /\bsed\s+-i/ and err 'sed -i is not portable';
>>>> +    /\bsed\s+-[^efn]\s+/ and err 'Not portable option with sed (use =
only [-n] [-e command] [-f command_file])';
>>>
>>> "sed -n -i -E -e 's/foo/bar/p'" won't be caught with this as an
>>> error, but that's OK ;-).
>>> Is this still an RFC patch?
>>
>> It seems as if everybody is happy with it,
>> so it may be ready for for pu.
>
> I'd still prefer to see a more terse[1] (and not capitalized) message
> to be consistent with existing error messages and to keep the reported
> errors more compact overall to make them easier to digest[2,3]:
>
>     err 'sed option not portable (use only -n, -e, -f)'
>

That's OK for me - lets see if there are more comments.


> But that's just a very minor nit.
>
> [1]: http://public-inbox.org/git/CAPig+cSeDNYFGYC2WznjW3zYMJCWZbZFY1KM5H=
5ir2L=3DJxwy7w@mail.gmail.com/
> [2]: http://public-inbox.org/git/20180713055205.32351-3-sunshine@sunshin=
eco.com/
> [3]: http://public-inbox.org/git/20180713055205.32351-4-sunshine@sunshin=
eco.com/
>

