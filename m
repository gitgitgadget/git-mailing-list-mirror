Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71B4E75433
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjJCItg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJCItf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:49:35 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81723AB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696322954; x=1696927754; i=l.s.r@web.de;
 bh=90g+p/HJF08b+dtEXs+D97AnYXJQ3gMkLtQMCxYfqDM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gWe47LhmOJiLMSMqRM0aqC9rdmOwRR7G66VIDP75cocpT8WU/AGIKINZdLERLpcLCDbWqRXqZJi
 dQpVoC7p0rXwPN5S1Npyb6ZUq+l/HbV6alsM5hf2nz48nAZBWXqO8576QUWPhQiqVu1DR33phe6Ye
 L4VSk8tvWkLOWXtgouK6tv4E7One9Q3ivvsdInVPQ99IvwXzABL222mAMnqjsA1vZVQcjZShVyPL0
 iP3abk1a/2NGiK8kdywMGphiXuq0SEgKnoB9t47Sf4TgumANIHl5yH9BGxTjYjTMXhiCK03fiPbH6
 zMV3fc42LurPFmuXj3z6cCj87zhdNuzUVNhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1rhmSQ3e1j-0150VE; Tue, 03
 Oct 2023 10:49:13 +0200
Message-ID: <d9defed8-4e7e-4b84-be3d-57155d973320@web.de>
Date:   Tue, 3 Oct 2023 10:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZQlspgfu7yDW0oTN@ugly>
 <f778bc6f-dbe1-4df6-95ff-c9e9f36a3cc9@web.de> <ZQwdsfh1GQX0IOQs@ugly>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZQwdsfh1GQX0IOQs@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FfmPFjHTD2JbeQDqptzVkXUkptlT9HKIVdBjtFkYxaWQznTmJiI
 ahgIUQVitWSTnhJP0MZevj4vChLuKUvs9+eAlACKjPFgeGQF6aSrNDBbBwAQUBdMJABTwa8
 8nJukAykY5xVW4optVfxrysRBMg6jVIygx51MfGVtRgDmlD1A0HCG1oisAfZfAcqeTx6Ta/
 wZq9pE8V3LDqnPgPI+tBw==
UI-OutboundReport: notjunk:1;M01:P0:osa0AeTzxnI=;WOptgo1OLAn2by6xudb3mafVs5Q
 KXBDWXFyONt+GRRGgMqOSmzkWX9eBbPYQV3ebe0FpCh7VrPfKD4FcI0zUZObXfuKPbEQew66j
 n5PtPw62f4fUww4jjxkDNFMZRxHrPaBCTLmRM7WMF8TkawoTAf7l4+dpmXDsV9vfvqjgLoiAm
 NttCO84EbDT6ThSBD0GDHZiW5ysZfgTos7ao7n+Y3n+mL0AWi2HlWiZVGLdHDX5KRatDXDMnE
 OaTNDWVaqQmBxvFu2nM5eYywcz+w7VWYs3MQsIy9/WzkL1jhdNkGAEE0QQDP9I8ete0+Pwa83
 EpeE0bv4+smrsKRPzPpfhEnGBU9lEB3+Kjy9tgQMjYP6oDt6no04C7HetLLg+GsRERCakNrIQ
 mFyJc4/lHzLFCrFBu4ncvRq39pPU53IGtjOw9nWrmR2ziDNcn5dqEeB2pJK0bzNhPe8A1eY6A
 RrcITap71f69Y/9ne7msa+HUKEk9uOPISMRz4SELOM0bqDTfp6JP4ujUxEqF6nx7O8r3WkCzb
 MAsTUF46Kv9yrx1am+BPqF+ZtgmroEdlk94vC9P5A8U7AzTZg4eOGyFGGiO7iHzq220slTWiq
 mK2IlCVDOoOQlNzx56UZ4Sc01mBY411U6opzc7t1QSGm+oFe8tnkIE6aW3HyVRqtpaMeIFmqj
 E3kr7pQWL9d0YOHE/ou5Vce/rM4CdWyUGfGuWpSfnFo8jmS9zsuznrP4JQCIAi/HII2OLQWue
 mPPAwHpOV8hUgI+WEVPujCd3Bv9GZYON9Z8ETnB2AASBkDc2tm0jfIvEYcHK/Jw1va/3mpPZN
 WEYg5D7lvcgz19BznjbEMJaWSruBrzjGejH5YW7n0jxJjEjUGL0eAmP0nkJXBlY+i1/U3Wn3u
 eP6KcB9EizcXMNf+ZqGcV2gE1dgZxX57xD8+RgortizqLEyYn+2XjCTNSaJJCX9SiqHcJgefo
 d+T8eyWXTOjpPDTlTUgjd4oz+iw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.23 um 12:40 schrieb Oswald Buddenhagen:
> On Wed, Sep 20, 2023 at 10:18:10AM +0200, Ren=C3=A9 Scharfe wrote:
>> MSVC warns about all combinations.
>>
> yes, though that's not a problem: after we established that the
> underlying type is int, we can just have a cast in the initializer
> macro.

MSVC does some weird things in general; it's tempting to ignore it.

>>> so how about simply adding a (configure) test to ensure that
>>> there is actually no problem, and calling it a day?
>
>> If we base it on type size then we're making assumptions that I
>> find hard to justify.
>>
> the only one i can think of is signedness. i think this can be safely
> ignored as long as we use only small positive integers.

I don't fully understand the pointer-sign warning, so I'm not
confident enough to silence it.

Ren=C3=A9
