Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3C320248
	for <e@80x24.org>; Wed, 10 Apr 2019 05:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDJFc4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 01:32:56 -0400
Received: from mout.web.de ([217.72.192.78]:36467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfDJFc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 01:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554874358;
        bh=2IARMnStGdD0U3B7YwcsbBq9FN5iRHdmVvJT+7x6xbg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EiIhaW0eKpMEROAv0Mx6IXAIWkWweQC0tu18hhvSZplOKMXtzngeLuOpbagLQ167K
         IQN1EwgAD8nZHmt0FaKkpqYJRPEWs0KL+kiEeceROOoiOqomRf79XXL0nPjkKvQqay
         zyzuu/OQ8lqwMjmsOhCyjgiCym0kcgKxVua7kP1g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from macce.local ([134.30.197.86]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LnB1F-1gfpIB2wJh-00hLSz; Wed, 10
 Apr 2019 07:32:38 +0200
Subject: Re: [PATCH] Unbreak real_path on Windows for already absolute paths
 (with Visual Studio)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sven Strickroth <sven@cs-ware.de>, git@vger.kernel.org,
        peff@peff.net, johannes.schindelin@gmx.de
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
 <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
 <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
 <af640e82-ca1a-9c96-da47-62aaea1cc18e@web.de>
 <xmqqv9zn2kjs.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d1cf10ec-ca57-09e3-cf00-3be87dec06ee@web.de>
Date:   Wed, 10 Apr 2019 07:32:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqv9zn2kjs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iIIylzBfH4E15Wj8kWGwE8S6s0q3tjEs2zx8JbAE8NEOl2lL0Fv
 zVm5lXw2p8Vt4tBD8ku3NqgD+L/wCpqAgJG3mNm3YtK54L7IwxCqwA6JAlPpCuQHN4+vIjc
 CWHr+FechddHJr2L35L2hKJsbh8W1pA2wj4IZ3/IQ/q4aTW5eQISyyoNVgXdyQsl914I3G7
 7vlp5FJp8aD1cbBh1+7LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qt+bSr0yWhQ=:LOYYgoIlJaKSN3NGSeX7cy
 D8Mn34DJirtaCXtV5Mrng+o/s504hTmrZz6aTe8b/rzBW8OmrVlzdSZZlAfh6OWh5gBQSCOqW
 0W0euihEZ5xwVR4wIZ9Jz6Hp2oJHnCFX8020MTIQ04gFlmJfs80TVhQLfQYa59p9cIKp5Z+c9
 S2tFXmC/R4ZfPYCCmoy7Wdx0F11BNipb1mnt8y8irMJ6x6X6+A66PLmor6RN2WbvrBnURaJGY
 o9nV208+tlV8kQ4fJCHdVqWaaZE/V7Ot2xhKms9c+n/ZVainTfw1oVIQBoQWCAnnRHu2QZcOD
 RoaEdS4v6uAGMSr/B4gBbBxhbZEnbM7XOw0Qz7ATUJDRqquBycZDHdcEayNr2W8ribrAEVJMM
 sPn/cFN6DcgzfnNBYnqjp/UQM/Q5GChZM07fr47rI+fMsIBGKHp6yHNWF6cXNndO4i9TVB9j7
 gC/1c3cOcCrPG+Qt1swfwJJM6TqSwsWny1+6+mWuObAULMP5Z+8KuZ1+BHOjjuFdCqBY07Dm6
 p9HDKObOtUrujVUw+ppjXoYdbYOa11JBXqB5FD20MsiS+XwGdh/fCbftX36m3/MYCDFjz8kMx
 wnJy40Cw+YOOFGcseqQZTQIhib2o9asIGkHsE4AryPFBP27Daksv8/wFTIvurqU0YRmrzzDvZ
 fzA/rew+CKsCFs2O3iRSOZYE739bXHaJ8oQYtgB5/hRZRMnpg7aMjxmjNNEGzi3IZ+wnbaAby
 5EBe958/M8x/4eni0X582jkxJ5uWTcUd7HHw/HdZqfeD2+ariwQT6jAtt5yWGFLIvHJCjuEMP
 2Vht306XNu0mXsjiDv0NNbWdz+EaAgncVDjPJSsuIpR6vAsm02lzxEoKq5tK30GXmB7tSWeL0
 WSEr/awhvg/hiYz6FqrU5ThrG9eLjTWA+s0DVvhAnlN0ZHScpoPYVUwZF275ul
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-04-09 18:46, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>>> 1cadad6f6 removes mingw_offset_1st_component from mingw.c which is
>>> included by msvc.c. Then the in git-compat.h the new file
>>> "compat/win32/path-utils.h" is only included for __CYGWIN__ and
>>> __MINGW32__, here _MSC_VER is missing -> that's the regression.
>>>
>>
>> OK, good.
>> If possible, I would like to see this kind of information
>> in the commit message.
>> Thanks for cleaning up my mess.
>
> Thanks, both.  Should I wait for an update that fixes the proposed
> log message?
>

It seems that I haven't read all messages in my mailbox (or messages cross=
ed).

The V2 patch describes the problem well and looks OK for me.

