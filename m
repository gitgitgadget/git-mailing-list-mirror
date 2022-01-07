Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7C7C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiAGTy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:54:27 -0500
Received: from mout.web.de ([212.227.15.4]:48133 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbiAGTy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641585257;
        bh=qvh+WwCJ/9ttBGbmjRLsGMZZEAo072QN8GMlSIEXOh4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AZgzFxMUN9NFCe5RExoegq1YgS8KtDmFQJh1J2Djia2RX8WHK88zuaapht+ujHLOe
         woGuWA+s9cEg+/yWRdLnTDNnk55Hk0ARoCu/jpLkEStzBMDgf4x1QRLhpM2kFWdv02
         1vYRggFBy3GMikTp0iulZX35hHCrRudB3d4Xhurc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6Jxd-1mHXiC2WhV-016Ewh; Fri, 07
 Jan 2022 20:54:17 +0100
Message-ID: <ec92e2ec-ef0a-8fe3-abcb-5cc6b29de762@web.de>
Date:   Fri, 7 Jan 2022 20:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 0/2] grep: introduce and use grep_and_expr()
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
 <cover.1641498525.git.me@ttaylorr.com>
 <c573cc00-d5b3-9af1-a627-6c2462cae3be@web.de> <YdiVmgJYPzVrIYE1@nand.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YdiVmgJYPzVrIYE1@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OYIpLAeK/vpPY6F192lNjVh2zwOTEyy2cNCHGI1Xyd+cCr3FBBS
 cYTEsOGWkl5jMZDMUvtkrDH0+Vxv+fGwSF6Pgt5Hclp6R5LUg2xdAb82q3aWuzAzpAEHIYc
 ZmseF9O2PHiuwisKUgVU24oav3k1MoRo4nEhDcWQpztGrBvUPAh03NqB8KRsPslGFIp0fTS
 3YqePb5wJRmq5On5CTp7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rvezZ+M9eJA=:uaFdzAyOIzNN4eXm4h/uLt
 WUotXuKktr7y/jJkYGUOmOrMqzILxwWgNHnvWCKJLUUDGEuj3Z9qX8Vuzf1A6vwqm+z9PdsdN
 HT2bN23bP8gHrVMlzmYuq2is0+r47qKOlrMVNzSyszdMuleab5HGkzS75kDAdqbw+hedBuUep
 MmN59hBHCtiYitFhbMxCKY54MrLayBgA2HJjzLdnBqUwJKXlTDbFlZijlF8bdJrP6FZqBxM1s
 1+Kg/N28C1dxZdoCvrJ8qhVJRsNXf+afXoJxIFhz3SobyZWpse2k4CgM+42duzlM7LyJtkumf
 hbVdJqRGfcBLUvAMXraIeYQZMBIT9dlECjhz9uBvvCR05kPLVQbIcNgvf3GVXhvvd5PUphduc
 vzd6ul7Lm3eNTfA6XvoPm/4VadXeuqWY3zSf9giFFQzx71hME6mjj2/h1YqGFj97m12sFAxHG
 kDuhnPD1QJZzw365ponCEKmPqofMMRqWClYJ/po/fChwrHvekxV0o9WDGyAmu627NczTSluVt
 5wEx5mA00chN7NjguXsKyiJ3dTIFECaUT7B6i8Z19JjAFn3JtdC97j8QeMdowAIvg6amq5gaL
 cCjM3Cf1brUfn40bv7wMFmPwbJzrEnFRYZL3EqOAwf1J0N13fwrowCq4Huwp20SlIuQ0wHhn+
 tb/sQMlok/qRQAaBkRCgpWP+jK3smoIjRcYUDcpUkkSOeXeRRIVSeH/OS/pajoZy80OQvZPCL
 CVaHc2k095t9aecnGLCgKE3ySryJYiWeGoT2341uBqj66/HOMsf/rsPVCU2beqrXpMSDGW4zr
 0WyvM0iUvKhXGeZTACO3U5e1H1wsijD0yP4rhNkkGKZyKhGIuXA99h4QoFrCCvtmrgHasPGn1
 ct116ItoM1673DtgkMyqiR0EZxxQRc1akoBEV2t4oPA3MUpAJ9jIJOvkZh07AcmExtdRV3hzL
 WCsZkl78EVFcSAtVtu0U7zTKFSip3aZcffV7eOMlH4vYPu1lXtr/aJjvRWbP058HBOfrxwU9R
 CExi8Ng5HHwi7KTZGwbG1bfHUN7EYga6DowwQYegvVhKsPDjiu/7kFvSscyHQpuMhDnW30yK2
 hUCqV6zL90ax6A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.22 um 20:33 schrieb Taylor Blau:
> On Fri, Jan 07, 2022 at 01:57:17PM +0100, Ren=C3=A9 Scharfe wrote:
>> Am 06.01.22 um 20:50 schrieb Taylor Blau:
>>> Ren=C3=A9,
>>>
>>> Here are a couple of extra patches on top of your series which introdu=
ce
>>> and use a new grep_and_expr() function.
>>>
>>> Like the final patch says, this isn't about reducing code duplication,
>>> but rather about adding visual consistency with the other
>>> `compile_pattern_xyz()` functions.
>>>
>>> Taylor Blau (2):
>>>   grep: extract grep_binexp() from grep_or_expr()
>>
>> I considered extracting such a function as well.  I'd have called it
>> grep_binary_expr(), though, to match the existing names.
>>
>> I decided against it because it can be misused by passing a non-binary
>> kind to it.  (That's a weak objection, but the benefit of such a
>> function was low already in my mind because it doesn't do much.)  You
>> solve this by keeping grep_or_expr() and adding grep_and_expr(), which
>> cannot be misused in this way -- OK.

That "OK" should probably have been a "Good".

>
> That makes sense. If it's keeping you up at night, we could easily add a
> check to ensure that `kind` is one of GREP_NODE_OR or GREP_NODE_AND. But
> I think that any new code that looks like:
>
>     grep_binexp(GREP_NODE_NOT, xyz, NULL);
>
> would probably stick out like a sore thumb. So I doubt that such a check
> would buy us much practically speaking.

Having the wrappers for all the binary node types is good enough.  I'm
not so sure about the sticking out thing -- I managed to miss bigger
mistakes before..

> But I agree that this whole thing probably isn't worth the minimal
> effort required, since the couple of patches I posted on top are purely
> about cosmetics.
>
> All of that is to say that I'd be happy to see these patches picked up,
> and I would also not be sad at all to see them left on the floor.

I think the end result is an improvement.

Ren=C3=A9
