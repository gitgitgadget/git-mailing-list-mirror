Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E67FC32772
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 07:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiHPHZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 03:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHPHYj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 03:24:39 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CA0172B87
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 20:36:45 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id cd25so3577621uab.8
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 20:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9BTD3xQ0jncVp7KLCbbNugLkb+arMQz57nG7Mkz0PzY=;
        b=qvAL40lFgspFdnAE1r7Wsn2gLuenPNnSSu7aCZiyYCd52/K/RXpd7pYlJjTy5rJv3e
         8+AqQZWSsDtticPumhRvoAXdIHdYpXQPU89v4uAAlyOIWwH9UKUK+Gi51boYXZDpbS2d
         izCVqn/CbzwJnUctuEkfxF8oDd0tKOWDrhzgXXFytWEpz+otlf8rdDWungdktoYm3ivA
         daEi6X6h7mD9bxRAoaLc+yfNfk2NizbbIpfmP58IBRtbyodlSY0rOZTl5sKYQCxzd5Ct
         ELWgKOQeQq4LlngtuLTqmZWbgmHJWp4zIQBE1Yh2nYV+87fcW1fYgtAUFNADOQlGDPDg
         vRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9BTD3xQ0jncVp7KLCbbNugLkb+arMQz57nG7Mkz0PzY=;
        b=pmyAzV1OyYRmrG772JNsGCLVuStRS4dwf0c+3jMHFaBTlX1qMfphmhBEe7YceLuvKk
         +zVVoSoNrpTwCppsRGf8ByTPGZ+ylmDMmsG01CI7k0T1hOyrdCoJ2ZOJMchaTAfFPBuj
         BCe96QeD2k2FAhRDTrBjos+1Jn8JEhpqPDYpYYwTu4dYWogowVKnR3Hwt3972GLOcE9i
         sZfReR6p6hX4aCYwRKAgKQMI+4Vo0kc1Pk1pvkndznhA/u+oa5UnPd2gM44G8pM0jUge
         SlgTL2OHAgLZtrvoEdmnslEAmi48G/zHpD42dI9j5nqeWJqQYLMtFiwZAMKXRWyosk1q
         1Wyw==
X-Gm-Message-State: ACgBeo0juS1/jaBbZDheUsUy6fCYKx8afs0ywLjZ/d55Ls+ow9tSr7AZ
        kCrjE+SSwRNy5mgDIHUibJTbcIPYk59k1BEDHKN/Zl25CwU=
X-Google-Smtp-Source: AA6agR6diVKPMp6K46o9GeS7BZdSJ9qZHvDf2yw3HEfZeODZTZmtZulv2nTj3u8mr9WQkDQC2cdGk1OmFpqw4XNDXEI=
X-Received: by 2002:ab0:76d6:0:b0:38e:c357:6ecb with SMTP id
 w22-20020ab076d6000000b0038ec3576ecbmr7748392uaq.2.1660621004427; Mon, 15 Aug
 2022 20:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
 <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com> <CAGTqyRw-SYDbQy9aktq5s3ZhoDhUOCf-pEopjH9m7v5+PH7Qqg@mail.gmail.com>
 <xmqqy1vq3zm3.fsf@gitster.g> <r980s5q6-7714-8r0q-4sp1-3qs1458r17qs@tzk.qr>
In-Reply-To: <r980s5q6-7714-8r0q-4sp1-3qs1458r17qs@tzk.qr>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Mon, 15 Aug 2022 23:36:08 -0400
Message-ID: <CAGTqyRyBAR1SCpKwU2mTTKz0-nOPgJ1Es6aGVBgJqrnZ9Z_P1w@mail.gmail.com>
Subject: Re: [PATCH v2] git-prompt: show presence of unresolved conflicts at
 command prompt
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        newren@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2022 at 8:50 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Sun, 14 Aug 2022, Junio C Hamano wrote:
>
> > Justin Donnelly <justinrdonnelly@gmail.com> writes:
> >
> > > I hope this is against protocol/etiquette, but after some initial
> > > feedback from Junio, I haven't gotten any more. I wasn't sure if
> > > nobody had seen the patch, or if there just wasn't any interest.
> >
> > It probably is a bit of both.  I personally did not see much point
> > in adding the long "conflicts" marker to the shell prompt (I did
> > worry about possible complaints by end users triggered by seeing
> > them suddenly without asking, which was why I commented on the
> > patch) and I was waiting for interested folks to speak out.
>
> Speaking for myself, I was too busy elsewhere. But now that I looked over
> the patch, I think it is fine. My only feedback is that it would be wise
> to only add a single test case because that is plenty enough (after all,
> it validates the `ls-files --unmerged` call and not the `cherry-pick`
> code) and it is unnecessary to waste the electricity on additional tests
> cases (even if somebody else foots the bill, it would do well for all of
> us to start being more mindful about energy consumption).

That makes sense. I'll get started on a re-roll to just have a single
test that focuses specifically on the conflict indicator.

>
> Ciao,
> Dscho

Thanks,
Justin
