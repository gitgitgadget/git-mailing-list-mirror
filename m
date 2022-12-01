Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770FBC3A5A7
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 22:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiLAWpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiLAWpo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 17:45:44 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE3F5B1
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669934729; bh=Q/1cNzCvkcmmG3YmV/Ov4YhUcGygCXjwVBNXY2hwDb0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CmOiP9VA2Su7ZDTkmeusKo9/3Gr3kmaxfjbk4TMBHJ5t7AWehDRaLpKSlKSdSboGQ
         kBPEwHxafcn/ofSGW3H8FzsZjfrz7PFUJjTJMVcGn1qTlsijIgKfmdWsUmqWaVzT0U
         S4hn4tBDk2IM+g1X/8BmXIpjKYj4RqbqeklvUtfBxJPEGQDBYYoHc/HQmrMwZvDSiG
         XeJtk96mUCDcmZSXlPCcuEmbUjgzI91JwIGHj4fZod9Fx5Pa3Ul2IUBW6KLzB/ptiH
         VDs5heL11B3nRr238ovZpAOvWp0jhVSqHwUy+gSA/x2rLXDZjBA+No54bfTeejvfiE
         X7mDD5m66J4Og==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14tM-1oqaQc438E-012Tth; Thu, 01
 Dec 2022 23:45:29 +0100
Message-ID: <fd51f518-0d74-2077-3e6b-4c796489503b@web.de>
Date:   Thu, 1 Dec 2022 23:45:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] diff: remove parseopts member of struct diff_options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <d226d3bc-fb15-58a4-f516-bda51a912228@web.de> <xmqqcz93ud8o.fsf@gitster.g>
 <20b5d6d1-ec09-e09f-4f92-5925fb9c96f8@web.de> <xmqqiliuss8k.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqiliuss8k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8qQqHxR1bPWvpoHX2LaMqf07etiDGNr8zu2HJzSInSI9AVa2zbF
 3nH6BggjfHpHlj26b9qZ5grlFX9/iWsi7EmXBzSHSKnIzOHRvz+ySzyfne+9iQAtQaYnj26
 lqv/Ro9o1GH8fokS+9NM3g7qaNpYjVs+O/aRgqsW+QpvUR2KcUX1h7l8SHvg3tw3761+Ejg
 P/enNWSFluBPOyYKPOYag==
UI-OutboundReport: notjunk:1;M01:P0:JfMJiZohhGE=;SwYPMevgdgt63lXiXNWpTZKuLvR
 70FBLvXGoWPHovvYUfVhc+7zX5GX50PDtl3s6PSyVfi3T+clFJyekMeBFDM4W+D7pg6CmuSs6
 4u7OqotII4TxIqrpYcqIHaqAcEKFujabedE1FfNECs36ee0pbF/bc0/rNKxahzJdmzOI05Gvi
 tXPfvLmyq/QRbebeDP5Mbjf0rLY8JX3oZ7boSCGwRFh14Wx7Ge4JqnvQDJ/o64/iHFd4U4DCT
 uLljnhBIHCf+I74dxAXTyd+sGe31S0Q4JEoSuxhZkLoTVZSbK18Y0PYF2Ew7lfs+beD6WlGvQ
 WDhNUWkbCcRXgQhjkVGdLvj3jJR3ClJoDB9+rUXYOsJlrUIaiFuWwUKvkGZHH5A2p4X9wA35m
 KoPYGrPHW4w6CbrMqXrdXZDCTof1Q9U4fhuxxKmhAA9Gqt4W5l8CF3kLzHBqlU7Zxurt0mmzk
 iyFuN1fBpCZQfrPGDIgQLKKElnT6WrcP9ImctZrD/7S3NgauhRQv/DfH3qmFl2cde6OrvCapb
 DB+lm5aVmGivwfj7vzKeTQGqnhgtLCfFKSfmidXnxVbW5iT135+CQuzXPpFsDUyRtp72a0a0Z
 AsCxYRUEQlPprQmLXyXCBfhPlVooM0Ur2g2HO03psIfC1IgnIDk9Nfc/eFnP+4iCvS0qv33bw
 0lGrH2/YGBTNFZhxWPY1CXID3XPbQQXQQcy8nEeBCPnoXDyYGRvP1FdnWU0UZ5k0/EDru5/PH
 V8CV1F/2QgL7eCvMhphgb2INgWzLed21bYwvV4HtPxy5mydn6jOCS6E0GaOK4pJNemwf0DtFS
 8VWnuIktVAL4L/T5zV8AbldFoicmcDj4t/BfwaU2s/thVF+8AifpT+0IXttaQTsQ+SM5btVRc
 0dunh0XF2nIzay5VgysqkA6iKVi0cH7NfUPFqCezGcrR19sQlQwkL39G8imforU1v9D5BtnwW
 8RUMpA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2022 um 22:56 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 01.12.22 um 02:25 schrieb Junio C Hamano:
>>>
>>> I think this hunk is missing?
>>
>> Yes. O_o
>
> I did not see any other issue in the series, so if no further tweaks
> are needed, I could just squash it in.

Thank you, but I'm about to send a version 3.

Ren=C3=A9
