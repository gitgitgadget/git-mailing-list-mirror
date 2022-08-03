Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4478DC19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 12:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiHCMeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 08:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiHCMeB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 08:34:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795B91CB0A
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 05:33:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so8535278edd.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=mpbWOXI0DbOG+nA0704I0qnfspqMNITqfzgUWBQDMJg=;
        b=nlVANecqXHkLycrqd+lymplyvkdTegEH1CQElUImY2XlsuDRPMnJOrDDt0+7EOm01c
         QgyFFl3VNWPCL51DJpGsIjDzmFuGR5eozG6Tybgg4R26dm+/5ekxuN+v1boQgvfSr6Xq
         1cVFj3AfC99pgb5FO6Hr8RjP3rrzPBMdZRGBwmcGJ7kNWPeQ8YuO8584RYEoEE02Qq7V
         OIp2CHKyzOweQUpM8mK/+KTAzBhX4xMpKtRl3uWhOeastkFOwNnhzrzewYG+NI39ts6a
         wC4tNwHK/hOaHagPvvGBQCEz/TXKjBSm/LiUg8oMSTuC/TrcZ9+gujEuZ6YRhSZwNp/H
         81ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=mpbWOXI0DbOG+nA0704I0qnfspqMNITqfzgUWBQDMJg=;
        b=aZHGlOaSERE+MBQ/oTelvirPaBrWuCT1jyP6MFADIHuxylNK2xR4BMhIJmwj3GzUmL
         0TBVSVO5LZaYfgdw3nCw/+/k9+KxoJHFNzTR2SMavu7rYvDfjTctLB6fgjhdD5VdvnAM
         JbRzRtazQ5vIM8H7nnoDN/G2pBCOTshL2TF4MWe8Zj/bcEfBrkLjhWccTX9oE5TbDZ6u
         a6/QN5c8yd7k0QbYoYyIKEAv5FjWWqw6YiuKX8T6w8bOtngPUz38krv1IOfU6Z9tFcou
         opyVEx5R8DKJSIReVrmS585v1xC//Lz6XFQbYZpUAGIkt2bJtO4ZMxmKcKnFTQbpdVPH
         B4ng==
X-Gm-Message-State: ACgBeo16F2XAvf43v/VRGO6Vkcnsxe/P+HPlCxQ4VVkjJPckFvXJnyI/
        42EYNG1cVZSPLiJGxPY6SfbFO5vAJpavcA==
X-Google-Smtp-Source: AA6agR5ACIaKe7OG4d+Jg8H0ojIbkguwaajyEPpOVG0daVwdTfWiiMa5nvx2gFYAApTIH9mcCcZHhA==
X-Received: by 2002:a05:6402:f25:b0:43d:e499:e32e with SMTP id i37-20020a0564020f2500b0043de499e32emr9243449eda.2.1659530038025;
        Wed, 03 Aug 2022 05:33:58 -0700 (PDT)
Received: from gmgdl ([2a02:a213:23c2:bf80:c530:8f19:38e6:f393])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072ecef772acsm7177824eja.2.2022.08.03.05.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 05:33:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJDZU-009Ry3-2d;
        Wed, 03 Aug 2022 14:33:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 3/7] builtin/bugreport.c: avoid size_t overflow
Date:   Wed, 03 Aug 2022 14:25:23 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <e8abfdfa892f5670ed411ed6daef26a4ffa1bfe6.1659388498.git.gitgitgadget@gmail.com>
 <220802.86ilnbgzr8.gmgdl@evledraar.gmail.com>
 <9fdac51b-ff8c-9564-d349-a71e42708479@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <9fdac51b-ff8c-9564-d349-a71e42708479@github.com>
Message-ID: <220803.86tu6tfqvf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 02 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Aug 01 2022, Victoria Dye via GitGitGadget wrote:
>>=20
>>> From: Victoria Dye <vdye@github.com>
>>>
>>> Avoid size_t overflow when reporting the available disk space in
>>> 'get_disk_info' by casting the block size and available block count to
>>> 'uint64_t' before multiplying them. Without this change, 'st_mult' would
>>> (correctly) report size_t overflow on 32-bit systems at or exceeding 2^=
32
>>> bytes of available space.
>>>
>>> Signed-off-by: Victoria Dye <vdye@github.com>
>>> ---
>>>  builtin/bugreport.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
>>> index 35b1fc48bf1..720889a37ad 100644
>>> --- a/builtin/bugreport.c
>>> +++ b/builtin/bugreport.c
>>> @@ -258,7 +258,7 @@ static int get_disk_info(struct strbuf *out)
>>>  	}
>>>=20=20
>>>  	strbuf_addf(out, "Available space on '%s': ", buf.buf);
>>> -	strbuf_humanise_bytes(out, st_mult(stat.f_bsize, stat.f_bavail));
>>> +	strbuf_humanise_bytes(out, (uint64_t)stat.f_bsize * (uint64_t)stat.f_=
bavail);
>>=20
>> Doesn't this remove the overflow guard on 64 bit systems to support
>> those 32 bit systems?
>>=20
>
> It does, but the total disk space available on a system should be able to
> fit into a 64-bit integer. I considered adding an explicit
> 'unsigned_mult_overflows', but decided against it because it's almost
> certainly overkill for such an implausible edge case.

Yeah it's probably overkill, and maybe this is good as-is & we don't
need to worry here.

But that's quite different from what the patch says, it's not "avoid
size_t overflow" but e.g.:

	bugreport.c: don't do size_t overflow check before casting to 32bit

	It's a hassle to support the check on 32 bit systems, and we
	don't think this is something we'll run into in practice [...]

Perhaps?

>> I also don't tthink it's correct that this would "correctly
>> report...". Before this we were simply assuming that "size_t" and
>> "unsigned long" & "fsblkcnt_t" would all yield the same thing.
>>=20
>
> The point I was making is that, if your 'size_t' is 32 bits, but you have
> more than ~4GB of disk space available on your system, the result of the
> multiplication will overflow 'size_t'. So, 'st_mult' failing because it
> detects an overflow is "correct", rather than e.g. a false positive.

I think it would be useful to document these assumptions in the commit
message, POSIX just says "blkcnt_t and off_t shall be signed integer
types", and "size_t shall be an unsigned integer type.".

Do other bits of the standard(s) that I've missed say that off_t's
signed type must be double the width of size_t's unsigned, or is it one
of those things that's not standardized but can be relied on in
practice?

We have a related assertion in 37ee680d9b9 (http.postbuffer: allow full
range of ssize_t values, 2017-04-11) (xcurl_off_t()). Perhaps you want
to do something similar to sanity check your assumptions here?

1. https://pubs.opengroup.org/onlinepubs/009604599/basedefs/sys/types.h.html
