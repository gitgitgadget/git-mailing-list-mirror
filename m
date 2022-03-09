Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E0EC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiCJAA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbiCJAA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:00:56 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC92122F46
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:59:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g20so4894592edw.6
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 15:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tXvvyTmCj1FfveadtXYca4yggrYebRKYZgrpknaXtfs=;
        b=jILXAUHuZlPjJeBckB6+hkOdcqxZ1o4VuyTa6zRAFvPvU5BE/7avzMK4QPmZDJh8z/
         SLzBtZsq5o5t/D14XWOVMrhJ9anlIsaB5wBKXy4BJxfp08TzeqTWoihIPEzzZw/JBBtB
         2aZTtAW/VsWjzA+61XCWC7ihS+54Gq87L3NUIbcrnEUedVNklzv3iCOs1B6OKePgYVWo
         Uf7S4iRPbkTrL5p57RvzPmQsgTRWAL/SQNBlFAPsF1QjGsUE28Kda6IJ+cp8BTWIWHWy
         vntDt31G7sY/s5tai5MHR73XDhFJJVkF0DuZp2j5FBYBdpLlNS0cOa2UBXQaO7DzQOkt
         EePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tXvvyTmCj1FfveadtXYca4yggrYebRKYZgrpknaXtfs=;
        b=HYUhKhIoihPDZhnN2AiMuLo8PU+LVZA+K88aVYbQdSpmG3dHjgBZth54hPZBPl/GoV
         +ygBwgcLka+60zIGbw2n5NRJUJTfEvyZgcbf3WAKh4022woQqdhQChjeuy5r+HQhBPov
         EMdMwJidbxr/vTleLV8by7z9ExnvSDXgDdVTAFWyuryd2o3rY1nGOlIqrQVXP+YmZ0kH
         nQznFYUpPwEqhMumMBGUvYl4HTeuq06SPGP6GAYuSds7Q3K7mc/wMxYVa+/DI4rAvwUn
         pIGWplDnghfCjdPlZZUR1oLNg0dXmnlgyf1Eyl6WmR4YOFfh8EHhQKEadZ+GWEPtLs5E
         PZhA==
X-Gm-Message-State: AOAM530+IwirNEhw3I2AVcU4mHvwEjCrtGsZc9D8v05ZOcsP9cr/Yoao
        WcV0Y4+UZhLRqYyb3ufmnVAdcGUKnJliVA==
X-Google-Smtp-Source: ABdhPJxxmRfC1LFm1p8x4Bx+TXl2xtcBsL44R9sn+CupYF9Jyo37di0XWbnxpd22UKKSRKYq69/ImQ==
X-Received: by 2002:a05:6402:8d5:b0:416:1b20:5090 with SMTP id d21-20020a05640208d500b004161b205090mr1784811edz.393.1646870394706;
        Wed, 09 Mar 2022 15:59:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709064b1300b006dabe44a6edsm1232501eju.141.2022.03.09.15.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 15:59:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS6Dh-000MmU-H4;
        Thu, 10 Mar 2022 00:59:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] block-sha1: remove use of assembly
Date:   Thu, 10 Mar 2022 00:52:31 +0100
References: <20220307232552.2799122-1-sandals@crustytoothpaste.net>
 <20220308022240.2809483-1-sandals@crustytoothpaste.net>
 <220308.864k48y35f.gmgdl@evledraar.gmail.com>
 <Yikl2eGbc8sPsy5G@camp.crustytoothpaste.net> <Yikq7POhuxeN1UPQ@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yikq7POhuxeN1UPQ@nand.local>
Message-ID: <220310.86cziulls6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Taylor Blau wrote:

> On Wed, Mar 09, 2022 at 10:10:33PM +0000, brian m. carlson wrote:
>> On 2022-03-08 at 13:38:06, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >
>> > On Tue, Mar 08 2022, brian m. carlson wrote:
>> >
>> > I think the $subject of the patch needs updating. It's not removing all
>> > the assemply from the file, after this patch we still have the
>> > ARM-specific assembly.
>> >
>> > I don't have a box to test that on, but I wonder if that also triggers
>> > the pedantic mode?
>> >
>> > Perhaps:
>> >
>> >     block-sha1: remove superfluous i386 and x86-64 assembly
>>
>> I suspect it has the same problem.  My inclination is to just remove it,
>> because my guess is that the compiler has gotten smarter between 2009
>> and now.
>
> Almost certainly. I don't have a machine to test it on, either, but I
> would be shocked if `make BLK_SHA=3DYesPlease DEVELOPER=3D1` worked on
> master today on an arm machine.

Why is that? The -pedantic error is specifically about
"gnu-statement-expression", i.e. the bracket syntax, not the inline
assembly per-se.

The ARM assembly isn't using that, and we have other code __asm__ code
compiled with -pedantic. E.g. I get the __asm__ in "compat/bswap.h" by
default, and it passes -pedantic (the code starting around line 38).

>> I honestly intend to just remove this code in a future version because
>> everyone not using SHA1DC has a security problem and we shouldn't offer
>> insecure options.
>>
>> However, I think for now, I'm just going to reroll this with the new
>> title and then I can remove it in a future version unless somebody with
>> an ARM system can relatively quickly tell me whether it's necessary.
>
> I wonder if a good stop-gap for arm systems might be to do something
> like:
>
> --- 8< ---
>
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index 1bb6e7c069..7402d02875 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -57,7 +57,7 @@
>  #if defined(__i386__) || defined(__x86_64__)
>    #define setW(x, val) (*(volatile unsigned int *)&W(x) =3D (val))
>  #elif defined(__GNUC__) && defined(__arm__)
> -  #define setW(x, val) do { W(x) =3D (val); __asm__("":::"memory"); } wh=
ile (0)
> +  #define setW(x, val) do { W(x) =3D (val); __extension__ __asm__("":::"=
memory"); } while (0)
>  #else
>    #define setW(x, val) (W(x) =3D (val))
>  #endif
>
> --- >8 ---

Isn't that __extension__ only needed *if* it warns under -pedantic,
which AFAICT doesn't apply to all uses of __asm__ (but your compiler
version etc. may be different...).
