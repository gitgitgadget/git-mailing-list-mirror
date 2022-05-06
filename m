Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE579C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 20:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442625AbiEFU0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 16:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349908AbiEFU0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 16:26:48 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE1D67D37
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:23:04 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id bc42so4107715vkb.12
        for <git@vger.kernel.org>; Fri, 06 May 2022 13:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yj9ffKwqoxGKBQ1YqjX4Ih7BnjCRm0LnvcyXyvEp9QI=;
        b=pl1o57uiQtk56Nunu8bKKZX2pvktJJFPm1wjzr1IkzUZty03EHiaBGlF+burqxplg2
         dm7O9hvFmMXTaTgBNgPLvavvkAoImn2A9D4GvZVpCr+dn+OVeD9jeHTvbMH8pAEJyVsU
         +4nod30BHKgk0rfAWlYdZbQM1uXYl66wnTVzOqr/hQQlyYOAfkOMGEh7TjNFA1cn9gen
         839gSqCvWe6kSK4RA8PFvAvsez/3ioIQVj/SKX5AninVgwTyyClbbIGDFmFniVEMxRGw
         3lGWgqaBZgGUJBhN0QTjr1jpy8i7Nu+oXeGHqw/W6C6UIgfr9uLnTyYlQ6agk5KJjmV3
         NJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yj9ffKwqoxGKBQ1YqjX4Ih7BnjCRm0LnvcyXyvEp9QI=;
        b=OohQULvTDGihBz/kIT+9xDvhL+cy/RK4Ie0xmadsNxx9YJA6WsxL0h7SpqSnaWHsJF
         +CQRbIhlItdHtzclIv7rR65h8I2ZYvsSSgCCcIfRiSQH3ekOc2FRtma1lxdW5Q0oTuZI
         E5cC1o3esy4ep45iYsQ19XHFoEP+HNkvq/u+08EdNVYxxyOujh2Y15ZbA2Jv3wQn/2PT
         4WfSmgWJGO9kX5F737fJ6rV4ZgcOU3aYEB0ZJQV5kz5vGfWdp/c2DohWMV9yy/MFhYwN
         OnsYbC3ygaYA14i1GPYQoJcHiCUqhGbmwtN4hiXl2s+91/95yhw3EFp4bZXaLiMxIyQX
         l91w==
X-Gm-Message-State: AOAM531CLiFYuDrnXdnxoK0TOWvzpaFLDsQcYmGe74fDxxmPE2ENJpu7
        781QD5KIkmn1q8W1cnZHDNIeCrq+3NAqhTlTeE0=
X-Google-Smtp-Source: ABdhPJyeuFYEYuy49lMOa0edZxOcroYbRtN6d/3es3jh0rZAs0i67m4+Ne0JTAD3gMcTWkPG9TqlgAlBsK2R5hPX2bw=
X-Received: by 2002:ac5:c856:0:b0:34e:d0b4:7a10 with SMTP id
 g22-20020ac5c856000000b0034ed0b47a10mr1867584vkm.39.1651868583701; Fri, 06
 May 2022 13:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-3-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
 <c9fc0fc6-c688-022d-9476-aaa87c66d295@gmail.com> <CAPUEspiMsvNhQF-RjW5eu3Xco9gU7TFt4w9dOOcF1PGM4Z+ceQ@mail.gmail.com>
 <xmqq35hml9cs.fsf@gitster.g>
In-Reply-To: <xmqq35hml9cs.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 13:22:49 -0700
Message-ID: <CAPUEspj98i9oTECSvSp4c-sDQ=hrxJHCY3Nn6QwqdAf9Ntnahw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2022 at 1:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > which is also why we can't use it, any possibly bogus or suspicious
> > value we get from SUDO_UID MUST be ignored.
>
> I do not think I agree.  If we have a strange value in SUDO_UID, it
> would be much better and safer to err on the safe side.

ignoring it is the safe side; for example if we replace the current
function with the proposed one then some user lucky enough to have
access to the latest linux supercomputer that has been patched to have
a 64-bit uid_t (because who makes 32-bit supercomputers nowadays)
would get root[1] access by simply faking his SUDO_UID to be UINT_MAX
+ 1.

We will also honour probably SUDO_UID=0M as root instead of the
current action which is to ignore that nonsense and most likely die by
telling the pranker that he still can't run `git status` on that root
owned repository he got access to even after he managed to get sudo to
generate that as a SUDO_UID.

> Instead of ignoring, in the situation where we care about the value
> we read from SUDO_UID (i.e. when euid==0), we should die loudly when
> it has a strange value.

that is fair, but then it would then make this feature into a denial
of service attack target ;)

The current implementation instead keeps git running under the UID it
was started as, which should be root if it gets to use this code under
the current implementation.

I am still open to changing it if you would rather let git be the last
line of defense, I just think that the current implementation of
ignoring it is more user friendly and better at punking would be
attackers.

Carlo

[1] https://lwn.net/Articles/727490/
