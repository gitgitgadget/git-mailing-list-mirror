Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B953FA3741
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 14:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJ1OXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJ1OXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 10:23:47 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7197F088
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666967007; bh=JKPbEDN6XPCr6BdV20GJIVEo6t57uLeLHvkFR7iC+HA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZJ+hbwtW1WVj2k6Zwlw1hTXNH8Jtb6MdDWbSVH7ih89W/oh6xP+vfwqLFoEm1tlM9
         +Reov/ieDHH9vzIAxUqN5Yg/DcWV77CGgTsaM3CvT4oCG6z6PWtnssuI4q6Q/ARbdL
         Oirfx3bXd9aiji/t9roKlWyr/ZTcWW6NY6J7R3naRwl1eZ2Ze+PlMkRGKwAImVEXqG
         dAEcaQOZ83eIdfC/R2IvQKYHlFB8GC400/0frBlzMfpDY3NYatzQQuhsRWITv+xcQS
         kQuD/nX/MIP6wAWix/GnMZo4ObYIRqQF0lmFFBnwzL2yrqy0KA+7nghg3XavO2GTDu
         TnFlU7tnXrXiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoYS-1oa2eB1e3g-00Y7qT; Fri, 28
 Oct 2022 16:23:27 +0200
Message-ID: <f443f3ee-95e6-edec-178a-9a06421e24f6@web.de>
Date:   Fri, 28 Oct 2022 16:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 7/8] replace and remove run_command_v_opt_cd_env_tr2()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <f26f7974-3e87-2ddf-6eeb-5d97f80a4e0d@web.de>
 <221028.86ilk4ano3.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221028.86ilk4ano3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FE0PznIxybiTITH8T+HLzgXDdDnSgjFmUKy3GzxKQP8hSw7wDgq
 8eCAlpzMvnhWCyMhpdXdX53rnW6ZkmX2EQsoHl5eVqxU/OCu59+9gTYWixmYd3UsQnaB9Av
 +nECEN7RMdeB5sOrekldZ7WP7eOLGxdqgvf8d73/SC3h/U4h8iycJpv/S+gxZNUabeacAYf
 5gcDOmFvc9gmt2JheNz7w==
UI-OutboundReport: notjunk:1;M01:P0:KuibcraO86A=;Ypn0IAeThKeOSZihYPMSJRITX5v
 rxhj5oQmalGqIEHg26iMpksrJEiQG3BJc8LfWQRBUkLmd8Ur8G6Fj4yeBzwzIGkLsm5CxtH4q
 mAefbMuUv36VkYBU8NDkneeYUYt2xO4MWpvjqIL4T1+42vNUaN1p0TobWMHgBLt8c+jbLyHyb
 0BGMFBpIBO/tQoB5oyU3Qyu9PlgJNohuifaNe2cu4XZHZRL9qlwMOBc1CFqzSUL8OnGS499hL
 GR+lR7FcZ3tim/ngBFtoOf1u6/yRu497xm5fWjfqejy/ayWy0r9qXK7f9kyygvNNtcp+iB8vh
 IzB11RwhKCbqYaGoYWfgBltBntGXhAz3ef+bodIANEycFk9CWtFOtmS2ghPPB7DjC9WGhiwJi
 Y4+dVANW/4Cvj0GavdczLL1fSC9Gkx/DJTCKdQHixsDTEdo3wwYV/TLepyt2J3aGlixLHdEav
 PS19WOAw+AACNjcrmMFkp7VwPuuG+Higj1R3hIVz+YV9260SHi2Wk64BYJYqvU8pjipoA9GOj
 dTAU8GdwvlMh+7gYR2gloHKC/RgX5TnHsh/3W9sEY4GZI9aaRtiwUUEDyX74IycPK/XtYReDU
 NbLa0zz6OkLhXhYCHa1sjvh03uOX/gvzx7fBccQgKXJC7pxQdY3WhsXYAokfdLUFMDgncDaNW
 fEk3hnoXhGYZvGrqBHM6B1r0MAia3n1eyuWFV0VZ7Nk+wBlAceTVeO3lDsNKEnnKbc0FHtJXb
 +xgmASv/zET+03eNUxZdAIV2ZVSzflm6ZG8TUUjOMX+a+h1LTxqw4x40JMt0+LLRoeaFYzZf0
 3mcPlCliVa9bWH4EJVR/YExEl35QnqBuLnIEoW78u3dK4tutc6Ld2Hvk9Omv5EXbqw/VHUeHC
 X5SsweQ0IsqAFEachkcPxF3kUjcRov1kpJO5FidDbDdv3H+Np+2ws4h9HB2I1XY66uyiVMw2F
 yDrmynlMC1B29PHj7Ae91Q+0cl0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.22 um 00:46 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/run-command.h b/run-command.h
>> index 482da7f60c..04bd07dc7a 100644
>> --- a/run-command.h
>> +++ b/run-command.h
>> @@ -233,23 +233,15 @@ int run_auto_maintenance(int quiet);
>>  #define RUN_CLOSE_OBJECT_STORE		(1<<7)
>>
>>  /**
>> - * Convenience functions that encapsulate a sequence of
>> + * Convenience function that encapsulate a sequence of
>
> Maybe we shouldn't bother, because we remove this altogether in 8/8, but
> this has a grammar error, should be:
>
> 	Convenience function that encapsulates a sequence of
>
> Or:
>
> 	A convenience function that encapsulates a sequence of
>
> Not:
>
> 	Convenience function that encapsulate a sequence of

Ah, good catch.

>
> If you're re-rolling I think just dropping this hunk is better.
>
> It can just go away entirely in 8/8. The pre-image had bad grammar
> anyway, so not worth fixing just to remove it later.
