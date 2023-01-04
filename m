Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6309EC4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 16:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbjADQgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjADQgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 11:36:40 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB57CE1B
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 08:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672850182; bh=pbZlEkxuBe9O7Vf+7pjcv0UJ0iJ+/fp26j6RR/2n/BY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Y7GwiJMjN8l5RL+MRROntQ5Rb1EVOBw07Rn16R20UqmSfJCMpHXLEIgaO85+Pak1N
         gr+eX27mzk/PDnNXoFAB4kU5giFe5qRBbD/0ixB0s2BXS7o/uxteG0RgRnzd9Nr9Ep
         ad0HUjPT+IY7iXWz1fNlbw9/gTibJ2tbX35ZaTlt7Xk0jlQ+fcEiTCi2WhHTTh8dh9
         39XoqIF+KHGhbI+0SmWcXK9vDn84kP5HLRcFpbodOlOUZanglNQfJzrEJnQosagGDa
         zgt7bWMVR3sm5bxCuPfgimKlEQgr0DZKBfDKdoYeBPDaBeo/T1eOLRHodABeTFat7i
         jDnpZEYinK7bw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1pGjg10IkB-00WbTD; Wed, 04
 Jan 2023 17:36:22 +0100
Message-ID: <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
Date:   Wed, 4 Jan 2023 17:36:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yM4+itkIU+POua1PlfsUGHsB4nkxfIj0eDH2p8mQZs0SYWTmuq6
 zzdXK+keN/J7i5AwcDXGuSpkjYH+uWW4TWGtIbK7A3ow7Naz5NG1ZHW9PJGYGkggNlUj1yZ
 wfl4ocNLJkH1yw4eMyzEK2D0OiT8FmqGl8IEs+b1OJjEMJviyUZFl8sl9TPPeehZDuNwBnx
 X62tidof+07ihks1rmXjQ==
UI-OutboundReport: notjunk:1;M01:P0:HaOvTMiIVI0=;RTemWaGO8FwvdW6LxAJbABXCH79
 mPqTffgcOF+eCAgok6ODGnkx25l+tNEvDtCH3ePsQ4qD+KJqpl6BrwR5+/jZjEwfNI35cM1ew
 hCHGQ3cm2KAV6YNWnDWpVTzmP+IVINSFrEF044r3kSCr1n6oUJcoq9Gd+aNoOnLUoftwNUZU5
 BxzCFPQoYyZ2jD8fqsFJAzvuNKoUbKJPptnA3WjcbYaNabu+twM+Q+TfxX5sa30K0KV+Nol78
 wmmT89XclE/XZn2h/7ogmqKdDv5vAbP+ev6EFfgslKTsnG55RYXh+bBoJE6Cmj3UxI8hjgE6E
 p6JpHptaFOIWEXeaArPo60EZ3rc3DGFD+i5vnxlK8mcb8zjHQU0t5xs8jp7ojhfmhjSLKu14T
 V/O25+bRJvzoTMDMKBmCgsm8dOw9RX5+i9yfiBtT87Zq5LUPZdWjMqIZ3nD3bm6ZPGJ8b/fK9
 5wPX5eujWHR3gk+f6QXIr+Hgdi2wz9X0iSl3eUW3skAv7ejQOA8G65PM7amlxfK0PSIq+BgTL
 7mYpi56P0PRnmfcBW5qAbhkaMCkmthdZ62yRIfsntio6SOCZKw1skCzmxz2k5YIm6OrmbvoBe
 HFcELaddHQ2V6WGxxkG13EWEXG257KgDuN3iHcEW6iFLbtbG7FewciieztdIMgNMOLQGILLZb
 JPdneV+peNQCOQ5RANYnZz6sK0cY+R4cnh339KgyKqjUK1LoX/h4HjV+yqCZP1n97gtO5l+uv
 kgpxf98JxahHVNh1sYwjJcjNjiNWuoyPbMZkFrFJgsN9tbo1ls7fkqPpnY3ENoNR7SPrZGAF4
 wot/G3goXmo5pNsiTTlS2woPHHIupPSyVwSckcVlbkgIjOFp1ckrLc83q4VnWlhl0QvvfqlfH
 qsXai8gCqhs/t4fxD/PYzxY0/Yq7yMA4ZYL8AmilmWbxsUeTMVSHJK1LvjBljkzBwyMm5Mltt
 fvZ1iw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.01.23 um 08:46 schrieb Jeff King:
> On Tue, Jan 03, 2023 at 09:52:27PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/Makefile b/Makefile
>> index db447d0738..15e7edc9d2 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -289,6 +289,10 @@ include shared.mak
>>  # Define NO_REGEX if your C library lacks regex support with REG_START=
END
>>  # feature.
>>  #
>> +# Define GIT_GREP_USES_REG_ENHANCED if your C library provides the fla=
g
>> +# REG_ENHANCED to enable enhanced basic regular expressions and you'd
>> +# like to use it in git grep.
>
> I didn't test, but just from looking at the patch I'd expect this to
> affect other parts of Git besides git-grep. E.g., "git log --grep".
> Which raises two questions:
>
>  - would a more generalized name be better? USE_REG_ENHANCED or
>    something? That might be _too_ general, but see below.
>
>  - should this cover other cases? Grepping for "regcomp", would people
>    want this to behave consistently for "git config --get-regexp", or
>    diff funcnames, and so on?
>
> If so, then I could envision a USE_REG_ENHANCED which just wraps the
> system regcomp and adds the REG_ENHANCED flag when REG_EXTENDED is not
> set?

Good point.  I don't know what people want, though.  re_format(7) on
macOS/BSD and regex(7) on Linux call basic REs "obsolete" and extended
REs "modern", so they seem to push people away from the old kind,
enhanced or not.

But making a consistent choice for all regex use makes sense --
platforms that use compat/regex/ get the same enhanced flavor
everywhere.

Ren=C3=A9
