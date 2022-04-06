Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEACC433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiDFMEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiDFMDU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:03:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87FF53011E
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 01:03:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so1608435edu.10
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bgDzhvK5+4UFtcPQd5C1DbkcJPknN0COSWU8ixWI7Pg=;
        b=OIQx4LMfq/1qKiL7j/nCA6zYFNojdMVD7JrljaYLpSZqkLlcCA9Q9cUeimESTVzp7t
         xvC/z6ibpN3CYuydy31N8xnlhILCI9h0KiuuHxCEUIyMMNKNWoF4CratcmqDlL4QgBmM
         wqyIcXPzCA38BPFMZPJpi+DqIuVmGku/6B2QjbGK1T3wrh9mIA5zJX3Uvkv0dKgbRul9
         /kPRmaiZL0QnobP+kXh4keeCRQ5mn9P4gOoO4ByAr38nQeGosgIi6O6z9YNa2Ewi8olB
         mG3SyzTEGqxw1lCV5uroTlPhqoFAf/FxxUE9nW/asPaFnluc/B84KwSPpV5qZ8Rz1+6o
         wHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bgDzhvK5+4UFtcPQd5C1DbkcJPknN0COSWU8ixWI7Pg=;
        b=kR49/U/I1x8+2A/fiTipO7YfNe9DAOSzN1Z0XI33tA32k7jFmnAm8dyY6xk6388rob
         A7E1tcrRRz8zSmsAvBncjqvHrRzaoUDwYzDTOWEiJdn8vAGyl0Kl/6GgJy+N227rc1w7
         D9A5G3z45FusKORJLOvAfX/DGHPcrUhcj4VvB8NIAmPyBHpDfp3XtvUdmuUbMQpqaez0
         n5xAV1Whbms0E2n0k1vIMmwwxMhmvnAldLQZ0vxhuRAk3AOioJ2oQio8fVOScVDRFzFG
         prvaSQWxRg66kOa5Q4jw13A8O8kEhWWcFP9eo5bgwEdjGvTyxbbJOhjuQaWZVkNsKDhp
         hG8Q==
X-Gm-Message-State: AOAM531mwrZqsNHQeP+BjGJh5i7omgSwb8IUVKLXVQ/5l2KQUJL9iDIQ
        DiiOIGwT38p9MRwOXzEPMVgOwYRPk6gCxA==
X-Google-Smtp-Source: ABdhPJxdLjp+23ZE9hdKUdCSGHPFyybq/uAGvUtOXVeFrznnmgafpihoHCmviVb9icZ69L1Z7Ml7fw==
X-Received: by 2002:a05:6402:358c:b0:419:809b:93cd with SMTP id y12-20020a056402358c00b00419809b93cdmr7587684edc.387.1649232230589;
        Wed, 06 Apr 2022 01:03:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o15-20020a50d80f000000b0041cc1f4f5e0sm4840998edj.62.2022.04.06.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:03:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc0dp-000Z6S-6u;
        Wed, 06 Apr 2022 10:03:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] various: use iwyu (include-what-you-use) to
 analyze includes
Date:   Wed, 06 Apr 2022 09:54:15 +0200
References: <20220331194436.58005-1-garrit@slashdev.space>
 <20220405114505.24389-1-garrit@slashdev.space>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220405114505.24389-1-garrit@slashdev.space>
Message-ID: <220406.865ynmfxju.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Garrit Franke wrote:

> On 01.04.22 10:07, =C3=83=C6=92=C3=A2=E2=82=AC var Arnfj=C3=83=C6=92=C3=
=82=C2=B6r=C3=83=C6=92=C3=82=C2=B0 Bjarmason wrote:

Aside: I don't think I've ever seen encoded quoted-printable go quite so
bad so fast. That went from =3DC3=3D86var to =3DC3=3D83=3DC6=3D92=3DC3=3DA2=
=3DE2=3D82=3DAC in
one reply. Whatever your E-Mail is doing with encodings seems to be
taking multiple passes through misencodings :)

Don't worry about getting the name "right" or whatever, I'm amused by
the encoding issue...

>> ... For anyone interested in pursuing this, I think using the excellent
>> include-what-you-use tool would be a nice start.
>>
>> We could even eventually add it to our CI if the false positive rate
>> isn't bad (I haven't checked much):
>> https://github.com/include-what-you-use/include-what-you-use
>
> This seems to be a really nice tool indeed. I wouldn't be comfortable
> adding it to the CI just yet, but it did make it considerably easier to
> spot includes that could safely be removed.

Re the reply I had on 1/4 I think it's probably best to drop that in its
current form, but the fixes themselves (perhaps with a re-roll for nits
I posted in reply) seem good.

I was really hoping though that if someone wanted to pursue this a bit
more we'd get to the point of being able to run "make all test" on a
source tree that iwyu would munge with all its suggestions, and then see
if it outright failed to compile, or whether it would e.g. have faster
compilation speed (or not..).

> I think we could try battle-testing this tool in the codebase to get a
> sense of how it behaves. To start, I added your reference-command to a
> script under "contrib/iwyu" and ran it against the files you noted.
> Before breaking a bulk of the files, I wanted to make sure that this
> undertaking is headed in the right direction.

Even if the patches aren't sent in making the actual changes a one-off
script to e.g. wrap the fix_includes.py script I mentioned would be very
interesting.

We could then even run that in CI with relatively little setup,
i.e. checkout <rev>, do munging, then compile.
