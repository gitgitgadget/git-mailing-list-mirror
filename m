Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AB6C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB4864FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBDVN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhBDVNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:13:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFFEC0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:13:12 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s11so6079185edd.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0Vk43bV6ty6ggZCJEyoygd5EES5Lx2Tig6u83jpexdk=;
        b=B8J+d/GMKxxU86euFEPwY4vxzaxA1zYSq8D5GDAKuGFhM+nrPZwBquORmqYgJm20hV
         dWdUEB21W3Q1+ceWOi2owvo97KibBTH7o2YRRjO9P4wiHkowu8+0SrH5UZuicbtybHxP
         9fxgntt+ipQr8vNde8VoFk2JzneO3DOJGnRI7aDFzKkznYWsibA2GbGVjJDxOHyTvNeX
         Bkcgv4LmHkp+604K1JYv1dFkbJOd0bj6H+95X2wv8DfMydakr+d+ETzDEL5JVnE9E/pt
         JtKjun3v1Sr71NRzOfTOtpE6ghYhGhcCNAXzJ4JKIeZxyCD1H4d70oU+0+dP5ig6qQTx
         /TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0Vk43bV6ty6ggZCJEyoygd5EES5Lx2Tig6u83jpexdk=;
        b=SUv5xsd+rIvNoVG7HJ52j0dJZvZ4CyMvbaavVJHGBfu8Df31DXKbFqNoZK3lPIBUkQ
         fMHT+/M3SUPJsSKevZQ6+5TdNQOezXIGT2OCUFGql82evvO/cXL2PdW+IC7/11ZRjvWx
         ajuLrRIJnCe/GFL+LCrClYExFY47Wuc7VawlRQ0L128ggSAW0Xk+Qeauwh+cQX+vfbao
         nRr4mIZ5Jsp4ZbQdk+aw3iDqF+1z2S4tlLaQZHA1r5aS/mzC/Wv3fF7AbyYUS8D+bIsH
         M48X3VzBDyDpyaNSkVL+S3lytekuAKS1qLMjI1DeLsCBpMZg/Ea/N8XUzN4w0VNP8wmQ
         ma4A==
X-Gm-Message-State: AOAM5310/qCJrpKSx1vXc0xSyZAqB3HxjhHTFgiG6AWEjxJtfovlHh4u
        0RdBpbOdiPAbWvuUAaCTfBc=
X-Google-Smtp-Source: ABdhPJzN0S80fsFvMznX5ZsEtcysQqp8ShNZIBsFtKao9f6MkWrSIlrPOgKbfPvhKcKCayFs4G80qw==
X-Received: by 2002:a50:9310:: with SMTP id m16mr522556eda.94.1612473191251;
        Thu, 04 Feb 2021 13:13:11 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id i4sm2957882eje.90.2021.02.04.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:13:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        "Jeff King" <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 14/25] pickaxe -S: remove redundant "sz" check in
 while-loop
References: <20210203032811.14979-1-avarab@gmail.com>
 <20210203032811.14979-15-avarab@gmail.com>
 <4ef09db7-34f2-2fb5-b9e9-be69c7102787@web.de>
 <xmqqh7mr90ou.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqh7mr90ou.fsf@gitster.c.googlers.com>
Date:   Thu, 04 Feb 2021 22:13:09 +0100
Message-ID: <87pn1fcza2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 04 2021, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> -		while (sz &&
>>> -		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
>>> +		while (!regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
>>
>> This will loop forever for regexes that match an empty string.  An
>> example would be /$/.  Silly, perhaps, but still I understand this check
>> less as an optimization and more as a correctness/robustness thing.
>>
>>>  			flags |=3D REG_NOTBOL;
>>>  			data +=3D regmatch.rm_eo;
>>>  			sz -=3D regmatch.rm_eo;
>>> -			if (sz && regmatch.rm_so =3D=3D regmatch.rm_eo) {
>>> +			if (regmatch.rm_so =3D=3D regmatch.rm_eo) {
>>>  				data++;
>>>  				sz--;
>>>  			}
>>
>> Before, if the match was an empty string and there was more data after
>> it, then the code would consume a character anyway, in order to avoid
>> matching the same empty string again.  With the patch, that character
>> is consumed even if there is no more data.  This leaves 'data'
>> pointing beyond the buffer and 'sz' rolls over to ULONG_MAX.  Oops. :(
>
> While I do not care too much about NUL in the haystack, I do not
> mind [13/25] either.  But this is bad.
>
> This whole thing reminds me of f53c5de2 (pickaxe: fix segfault with
> '-S<...> --pickaxe-regex', 2017-03-18), by the way.

Ren=C3=A9: Well spotted, thanks, and Oops.

I've just sent a separate series with 01-10 of this one. I'm sitting on
the diffcore-pickaxe patches for a while. I've got local fixes for a lot
of issues in it, will fix this one too.

I've optimized the PCRE v2 codepath a lot more in my local
version. Current results are:

    4209.1: git log -S'int main' <limit-rev>..                             =
   0.38(0.36+0.01)   0.37(0.33+0.04) -2.6%
    4209.2: git log -S'=C3=A6' <limit-rev>..                               =
        0.51(0.47+0.04)   0.32(0.27+0.05) -37.3%
    4209.3: git log --pickaxe-regex -S'(int|void|null)' <limit-rev>..      =
   0.72(0.68+0.03)   0.57(0.54+0.03) -20.8%
    4209.4: git log --pickaxe-regex -S'if *\([^ ]+ & ' <limit-rev>..       =
   0.60(0.55+0.02)   0.39(0.34+0.05) -35.0%
    4209.5: git log --pickaxe-regex -S'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=
=A5=C3=A6=C3=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..  =
     0.43(0.40+0.03)   0.50(0.44+0.06) +16.3%
    4209.6: git log -G'(int|void|null)' <limit-rev>..                      =
   0.64(0.55+0.09)   0.63(0.56+0.05) -1.6%
    4209.7: git log -G'if *\([^ ]+ & ' <limit-rev>..                       =
   0.64(0.59+0.05)   0.63(0.56+0.06) -1.6%
    4209.8: git log -G'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=A5=C3=A6=C3=B1=C3=
=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..                    =
   0.63(0.54+0.08)   0.62(0.55+0.06) -1.6%
    4209.9: git log -i -S'int main' <limit-rev>..                          =
   0.39(0.35+0.03)   0.38(0.35+0.02) -2.6%
    4209.10: git log -i -S'=C3=A6' <limit-rev>..                           =
        0.39(0.33+0.06)   0.32(0.28+0.04) -17.9%
    4209.11: git log -i --pickaxe-regex -S'(int|void|null)' <limit-rev>..  =
   0.90(0.84+0.05)   0.58(0.53+0.04) -35.6%
    4209.12: git log -i --pickaxe-regex -S'if *\([^ ]+ & ' <limit-rev>..   =
   0.71(0.64+0.06)   0.40(0.37+0.03) -43.7%
    4209.13: git log -i --pickaxe-regex -S'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=
=C3=A5=C3=A6=C3=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>.=
.   0.43(0.40+0.03)   0.50(0.46+0.04) +16.3%
    4209.14: git log -i -G'(int|void|null)' <limit-rev>..                  =
   0.64(0.57+0.06)   0.62(0.56+0.05) -3.1%
    4209.15: git log -i -G'if *\([^ ]+ & ' <limit-rev>..                   =
   0.65(0.59+0.06)   0.63(0.54+0.08) -3.1%
    4209.16: git log -i -G'[=C3=A0=C3=A1=C3=A2=C3=A3=C3=A4=C3=A5=C3=A6=C3=
=B1=C3=B8=C3=B9=C3=BA=C3=BB=C3=BC=C3=BD=C3=BE]' <limit-rev>..              =
     0.63(0.55+0.08)   0.62(0.56+0.05) -1.6%

The main optimization was just moving the compilation of the pattern up
the stack into the diff_options struct, the current version in this
thread re-compiles it every time.
