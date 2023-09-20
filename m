Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF48CE79CE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 11:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjITLfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 07:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjITLfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 07:35:20 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11296B0
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695209697; x=1695814497; i=l.s.r@web.de;
 bh=fXYFS9DdYUfCCzC11apJjSV0ksSdS7+z9c2FrJ6MwmY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SA7maeEHyC2z2cVVWPgAMQTRmq9MlCoXL0jtU7mWPs62i4HueUl/miVyNoV7b0YowREPnLa+7Ho
 lxdL0ob9Ze88gGklw2g2EzSk9U73q+hC1fBEaXx5XrbbqvHBoPSe/CuEwxiJCAUQdknj19EIcFDa2
 lH/X2HXFQSY/+e76sjm9p9ogLJkl10A4fykNbQJT5wGFq/hVt9DnfX/YUN39Xgaw5/LAFrQu5vZGI
 h+mcD8Wr3/rzvyBXs4fDziXHTZYEZpt19q9RV1pBgfz8FLG8iOiu+5CDAIGOSHDqkgp18h+1lrDfp
 LqhJ/mQiF5aPX7dpFbKc23nSXMH65k6pjfvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpU1u-1rU68L1iKy-00pl9Q; Wed, 20
 Sep 2023 13:34:57 +0200
Message-ID: <daf41377-95ef-43ff-b4ce-a544a469a246@web.de>
Date:   Wed, 20 Sep 2023 13:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <ZP4NrVeqMtFTLEuf@nand.local> <xmqq7cowv7pm.fsf@gitster.g>
 <2349e897-9e0d-4341-86fc-9da117a1eb48@web.de> <xmqq5y47mp58.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5y47mp58.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ak9st2Sq76YOgCDX7IqYt/euzXT0Of820Xt4mrWdPkt0CXliR9W
 eAv8c1igOK7qu7fzhFKrQiLqD6GqnYsHvfvpI8BpbcujSGYFt9dVjs7Yhd9fxBpV1cGqAmF
 rDAfL2k4HCeQowDjl60y0UVIHNJsCv7AA5XJ3MyOKGD4MxxMmm1iMCKCgGbT0X7luGzfKfY
 1qU9M9FLoVotNau8XN+/Q==
UI-OutboundReport: notjunk:1;M01:P0:VwA1UPAd+0U=;aT5TA7dDlKLFQkkgq0a/3btUX9Y
 SczjwIBMcXNVaZaX1M6Ddg6NynaiVrTksvj8zurmk9hPtrDhO+AwUlaL0g9uRNwsfTWQERCOI
 jnyEi7DA1mOeWJCVzo9OizxQjiQ2UEJsESbQqzfsUQb/5t4L6UIQlBB4kKERetVZnXm4WI/CG
 nzGsnGT+Cqn52bHjZT6OuF8IbbQdYAEHs+mebv5CBVNJ91ddohIqnlr4fcrcMz4T1Ewjjj7Xs
 GnGnVlWKS3HDV5D40e7FJ9x8rtAiO8nLQxrvO3PqksvBHlSHmBo5Qv9hUMooJrUdzqlJqv1FH
 EY5H+Z0Ype8pQUeBFDIz0hUlVBPczKrGbJ/8/KtB6qq6ZWHpO/62iOovvT0HnvhRlzldbKBAV
 2aBWS0Y889xcDYkwl57sK4ROvtldMlwrc56TSv0ExmfGv1gpBgd7fVbXRu1Z7bu2eCDAyyp4b
 d5lwG4EcgOFD1U3hHGTS6uiMr/HURzR3SWsQEZ2uzd+78mDHOcWy4/Xh42Tj9KGOHL276HBhH
 YQKo7fC9B8ql0aOptatfZFIqKNjYc+LygHOxNLSq//YyCnPTgLaqT1lNrHK9WHic1LfnU77JG
 P1+p02u4Quv8RJPN4cBww+QaTAsXzTuYt3+g4BKcmCAHEfBi1hScyHlfWotfnh3nhtiRoRQT4
 T4+7IDRyqP9ftCWfQw9lOGerpJcCeQDa6EpeHWlM+J/PnTzj4WItKqw1NwM8f7QtN+pO2tMtC
 L3j2VESyqeK+8nMh/ai8aGUS0g30SsB7uO08o2Spn3fIZOkYc1iP0tqib3/BR6RjpD7TCHE8i
 DZiDEwJJcuKHO+EPZEXjfllNhT21E7PX+McAxOOni3m/ziRKAdxR50zGa2K0fL2yxOAJki4RU
 ca/al0ZjGtNXqU8yJ2ahDKt25YSCm8802HI7uAt+suI8V0bNmE42RT6FCoaKHkiURqhi+AK8C
 kKhGONA2awXUncreMjv0lRzP9d8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.09.23 um 18:17 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> It reduces the memory footprint, but only slightly.  Saving a few bytes
>> for objects with less than a hundred instances total doesn't seem worth
>> the downsides.
>
> It makes it impossible to use the both at the same time, which is a
> bigger (than reduced memory) advantage.  Otherwise, we would be
> tempted to consider that having "void *value" and "int value_int"
> next to each other and allow them to coexist may be a good solution
> for a narrow corner case (please see at the end of the message you
> are responding to).

Good point.  The patch adds a check to parse_options_check() to prevent
double use, which adds some runtime overhead and doesn't fully remove
the temptation.

Ren=C3=A9
