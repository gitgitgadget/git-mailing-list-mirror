Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA591E75455
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 17:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240697AbjJCRym (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjJCRyl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 13:54:41 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5C8E
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696355669; x=1696960469; i=l.s.r@web.de;
 bh=YWtenAT+qzdIMv25YpPvgKqpzl4e8BlH8gLJcNX2rdE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=u0v3Mqvqr1UxCKCmCr5Xu6uKzxplWwi38HKvp9Hwt0ZCLzBaKLC/VISdCpUTuSFnIoSQbBkgc4q
 Sshw/YV2myZWaxSSq1hjQJSSv8+N2R2yKqD5HlvkjhhPvv2eMlXaVEzwQklz4jQBEYHVEJ97gi9pY
 hoNylbj6XI8M3WCgwYWOFwEOJ95GgimgTCBd7ssi1o/icBx9HdvhmB6vvP279T2zCq5+sg25t6bUo
 z0T0ZB7fql4VudLOW/bjWLIXhIcstWkJCI46/aYLKyd2qCnBizCAWJH6SWce1HDbzimszb0HJ8OKF
 ss8odVOGx2RRg3eUbg6U4ad6o0OT9e+gew7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Ij-1rYom60I6V-00y72w; Tue, 03
 Oct 2023 19:54:29 +0200
Message-ID: <88cb2db8-e5cb-470a-8060-7a1b898c91f9@web.de>
Date:   Tue, 3 Oct 2023 19:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZQlspgfu7yDW0oTN@ugly>
 <f778bc6f-dbe1-4df6-95ff-c9e9f36a3cc9@web.de> <ZQwdsfh1GQX0IOQs@ugly>
 <d9defed8-4e7e-4b84-be3d-57155d973320@web.de> <ZRvhEWHWn4nDynD0@ugly>
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZRvhEWHWn4nDynD0@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3AZtLjLqmqEFbV86fwF/iqeWM09LVJHa5pz6qJvZJiZl/EJHpx5
 2ST+dGc8Ti+RrdG74nkn8Mlc0v2CDvKKlix3YDAkS8T4KHYeIidZ6Ds2rdnwP0sd6NOn1o3
 i2MOc22tLnNcJLEDWo4g7ry3VdjoRF3sAdyHtAmV3awzf4gezGazMlnO4No2XGqEFD4k/rx
 Lb2T6J+O5cS8GXyjlijiw==
UI-OutboundReport: notjunk:1;M01:P0:ZUEiCECpw1I=;o8bQyAVKd9o3CSfQQDxHXT2GkPt
 fVrsdvTboQrb02+85i6VQt798e+g+UwelemdDxrZku5/MtlkI9ua1rHzkgkO+PYCrwRvmxray
 eP+tzfmSYOHqXuLgbs1azo/7gcwkW0ki5jTzexX6/F8BoI0AUdLD4T06D72CbyO9FZbqGaggZ
 rSb/o+FutbakV86bYS1us3Mr/zHEZuxhpoNAZoRO+jsa/QijHBw7Xgh8ml4jDM5tSQZwELzW9
 uI5GAmlHTatx2FKiFJQHTB42KJ9GgQbhHpmkPFH0QorIbNFd8ucrvEvhB2kZ+2/+igX5LvJyd
 DWGGss2C7xupsZ9Jar2scG9eF0cw4uuSCAtuR774KhJ+D8rwfJ1yARINH75DJAMCDB0qV7Iw4
 DkG05n96ONk+4fNA+kBcfr98Iz8HJ7Sr7ECTtOXCiXhdGS9S/o4pEATT0Xu7i9FbKJz87xELg
 ldClZSrBNlPOoDOR3iPIP/QBJ3EI4VBdKjIhbhsTlWcTqtfTt/vVHrXQJRyt0pWlpkxLMtEjS
 ZXQuC17UiB1fezbrdRTDhttBnj6hFYMnKWTj+rLKQx0ie+dvw1p5sCf1ZjL9wVQPZfSQYMVAg
 XbWOXWdKckvbfDim4jnLNYXkA/SH9vYaPjtpjhwB+K1HSqkR0j7fKrzRl6FMRulEcU27al8lI
 LoivirAC/z701YP/EGT0WxNyAodfvInjcZOwaNEe4Z3i43EmU3AuA7D11bTC4BgTFjw/okIij
 pssnbQ0VauQYE05jI/FTl9pAbifpaiPrTeIYRFnmDOtE2UzEvB2l16optmznXWIOy1mc2u6tH
 0nowkj1woaLXAjbaUzGCS4eZfzMlpprachYb1CA9o5Hk49kIvYQJ05Gn8MsaYQtkqfrE7l++z
 tEVq7SUyBwf5WKnGArXQ3IujXs7srfP5m9j4k8qhTI95MIwWoB159AjCrBiv93q3+Gl0CnuAm
 HNQdow==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.23 um 11:38 schrieb Oswald Buddenhagen:
> On Tue, Oct 03, 2023 at 10:49:12AM +0200, Ren=C3=A9 Scharfe wrote:
>> Am 21.09.23 um 12:40 schrieb Oswald Buddenhagen:
>>> On Wed, Sep 20, 2023 at 10:18:10AM +0200, Ren=C3=A9 Scharfe wrote:
>>>> If we base it on type size then we're making assumptions that
>>>> I find hard to justify.
>>>>
>>> the only one i can think of is signedness. i think this can be
>>> safely ignored as long as we use only small positive integers.
>>
>> I don't fully understand the pointer-sign warning, so I'm not
>> confident enough to silence it.
>>
> in theory, differently signed integers may have completely different
> binary representations. but afaik, that only ever mattered for
> negative numbers. and c++20 actually codifies two's complement, which
> was the de-facto standard for decades already. so in practice it just
> means that we may be assigning a value that is outside the range of
> the actual type. but small positive values are compatible between
> signed and unsiged types.

C++ is not relevant for Git, but C23 is going to to stop supporting
binary representations other than two's complement as well.

Still I don't feel comfortable overriding compiler warnings for
something pedestrian as a command line parser.  No idea what other
assumptions are made in compilers around enums.  I'd rather honor
the warnings and avoid any forcing or trickery if possible.  Or at
least leave that to more capable hands.

Ren=C3=A9
