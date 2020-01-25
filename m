Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E977C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 08:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B46C2071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 08:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MR60bJBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgAYIXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 03:23:54 -0500
Received: from mout.web.de ([212.227.15.4]:57789 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgAYIXy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 03:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1579940624;
        bh=LkXpLZKlItoYheutwUOFXMZ2B9FP7CPiBPFn0zHa+q0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=MR60bJBNNAC66bzoEL7sM2l+d6B4PJrCI6fGXRL5aXIvsXuSVKr5waKm9Qfi8L90n
         dH3isKXhIeXKl4J2GuXS72LouPhTkFOJgw8GAULBk3LvIhEbj0BG2MGPVtlkEP308A
         Hp2Ane+OCM0qYHSzOajO9kn32zpqj130QZMlTFgM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.167.128]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M4Zlk-1jp8dY0TpE-00yic4; Sat, 25
 Jan 2020 09:23:44 +0100
Subject: Re: coccinelle: improve array.cocci
From:   Markus Elfring <Markus.Elfring@web.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <df8abb18-ed59-aed2-82a2-e410a181233b@web.de>
Date:   Sat, 25 Jan 2020 09:23:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:jZwSVV1czJ4VDKOOpzhbFhyFUnAVdVZffKsfl78UDkYDPcdKWim
 rrAXdtR6NtmJz6zwMAq/s+RC/7zqs91IkIS9UKMP9qy1jpGg2mrFH9Uc9KLjZCtw911xOOM
 a/BObjystklhwAiu3WiN768CmAKWsxXVHRgnuE/npQTfc2bIShnSHfBf6bG8AtE72WJ+bBU
 G5euZu0B9gFXVXCQIe0kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/fxisFjxGZk=:VNKr2LFv0tXEqbqEz4C3hz
 G1+RkmPGgIrqk7EiSnA1HmOdL+O5pyPb5spwDMJlxfkGbUH1KbXibXX6usnGBUeDZM0zVeTEk
 cI/RHSlfA9cYvEU1gv+IAeC3McwJVhBefVUkTn97lcxUwJHX4c9mewe7ysaUC4iNsBVx3q8RY
 28FPsIvjAvZOc1hcm+TKpm8daUWZcDvZgAitcn3zSgBnZ4XfocizE6exaM4ZvwB++N5SCEREf
 YD2Vct2lE1dO5JKWPtOkbC0/UpPkgN+NwOSKiOElvkoZvj5cCy2OEGJbO+AJutBXOdDr15vhT
 ld1HYDSVDZrrfIFhJV6NqsQqJR+vEy73YP44KYjEpta4VWkm7vW2yKLl0fEBt/yo4R027qp83
 6pf8n6S3f0MRvukcgHB+IQj5uYmOEs17FPqXOwqvBjGFSZmdk1/Y8OqqrcdkpGU385iQlbujz
 8ZET8MvNQ3DWDFlHBwj8HdKVzqo793qY+ysTl1FHx3l3kFa1xcJskGPOGJRX1ENZgp7jH4oti
 kNe59HuRjHLtGRQnwZt2hewuG1o40KF+byGA58cMoV0Lf9zfRtRAIFQAM22H66J+u2knUXGDc
 ZGuNaanW1IMTejnEvzBx+uFjKVXLRrJPvr9aHfzM9GdPUzvL+Z0UOb2aEPk+DmrbAXP/yOfF2
 uqD6v/f2NeDJY4sks0Ad3m48wundR4YGeRKKewD3Jbp1GfXBL5dyNtjEQGXLciGiRMkmnaeOw
 NoXHueHQMSD8QQ/LKTazxgPVkOqLOfQwTlQTHjE9AZB6m6MbHUtQnuAI9fAMlzQaHfrzXAHgZ
 85b5286qzfVfbJybNMIJpXBY8prSFAvbb11UEgkAtfJY3DANgvTSAZ5cffZEVyZX9uphV6ehF
 Id/yEEioGerHe+8Cg0oZ/RUZ4pGLrAbTpH3XQDaflsDqJ4cDRteDykHDwIpWYq+ftvC85l6sH
 mSDLAFj1KPCeenUT9d9Z39wWdYjJtZ5nM8xydUhtFVOlUZ3IPFLRrPG2yOFbKY2iAVc0IrH8u
 sJH4k/xIvQSm2Se9NUfhQubKo2P0PyxNNovGlpOlFTVOKlf7GD8zbwO9ne8XeQh5Hs67yVbS+
 ZdMFeIqPYYdZ82HEauNnZf1S5M8ynu22ZlAuNiF3Rd5a4GZoHX5y3fWDV9DMD+bRwe9SJpaxg
 O/Ias0b4MgN4vfrC/ipBigKNLbFdffCp5kLe1hGPwNEXIVEFxMN7pMDpfHDksHiquhSWUqrob
 TCvw2oUDFygoDoN7T
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This script contained transformation rules for the semantic patch language
> which used similar code.

How do you think about to adjust any implementation details according to
the shown proposal?

Would you like to continue corresponding code review?

Regards,
Markus
