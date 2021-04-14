Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02861C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 13:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBF661132
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 13:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbhDNN1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 09:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhDNN1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 09:27:40 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F173C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 06:27:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id w3so9541810ioc.12
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqmJwZKdzEB0IzeeHyVx9r7ZJvxAjGxLjnVVZup2bKM=;
        b=jV/AB2lThnoCspNGCCUla8OuqQ346jKDNL7N0HNTkSxOgW5/nL4d1kMfOsPGw7mMFU
         5vVxLxQ8Ri5upkr8mfRv1lzXZZZFHE0VNOmHaT2HNOSNMAFf5yi6OuD5EPyom5rQ2hmc
         3nknZ9AU5BtvcljRvTR1NjUzW7paoR2lmUzEQA1vxfVgQGEhLQoYuWJbQ+YHgvB6fftL
         kM8j3TZxDEeo98+UCDMcWzh8O9hx5OnjoVMTdLFhVbGJ1/qB5M+uHxy0sZjL4WEtuYJB
         U7JAbQrX+zakkmZ6arxK8+sL9E5azeQgSpqRL8J3J14fxymPes0mkU6cljWc0l2s3i7g
         uGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqmJwZKdzEB0IzeeHyVx9r7ZJvxAjGxLjnVVZup2bKM=;
        b=ot1q7ZD5cXUNmTojRC4aaDTM3ZekR1+Ni5LB3DbqwfBcPFW1uMXvdtekkMk2PsSBLx
         dNwGqxi+IXyHicsbj72iFMSCaZ9wxl04vRPigz3M5/ZPIkeqMSgQQ3jogRtW5ZPtRhXD
         AkNT5YDK0pkuRjBZVEktV5ifNlmumAuifgFdtMuKZQodHEPBwNrPHOh5m5wQkLCwTvyH
         5Hk7dS4m1J7uqV+5oPh/BockgtYKpqxTc0lWcHe7inpnT/E1C775IMAP/Whe3Wc61BYI
         MkPSpeeZOJDL/6H73F3kkdKnDfGj+bjr66565n1O2QWebOVFyvw7J62r1XtVJacHdr2E
         ns/w==
X-Gm-Message-State: AOAM531WfbILuRzZXTv2YTtCphHK49+dWQl437Io4tiwzw0lqfwhgLwq
        1E0ZyePnEeYK1sTWq/Jdah0fzjxfIjQxqzBTmF4YEl5iUdcdhCCT
X-Google-Smtp-Source: ABdhPJzyYXXNln3n2gYCnbVl173Ax0DRTZThNwTSEwogSFl3rD5Q9BgB25H6edpor2p0ptcQ6NOZ12l9SmlYKl9frsQ=
X-Received: by 2002:a02:b619:: with SMTP id h25mr11578103jam.130.1618406839068;
 Wed, 14 Apr 2021 06:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
 <pull.913.v9.git.1618245568.gitgitgadget@gmail.com> <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
 <xmqqsg3vb51n.fsf@gitster.g> <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
 <CAOLTT8TB9UF5z-51pLxdkRUxo5-w2+_U_e1wpDAdzBBmT3Og7w@mail.gmail.com> <xmqq35vum1rn.fsf@gitster.g>
In-Reply-To: <xmqq35vum1rn.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 14 Apr 2021 21:27:05 +0800
Message-ID: <CAOLTT8TNK55AprX2tezoX4YjWV31RRyLWc9NJOvidRqqSgBpQQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=883:18=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> It might be desirable to make it easier for people to migrate from
> >> ".command" to ".cmd". I agree this is debatable, but I don't see a big
> >> downside in it. Maybe, if no argument was passed at all the first time
> >> the command is called instead of the empty string, the command could
> >> then know that it's called for the first time. I am not sure this
> >> would be very helpful in practice though.
> >>
> >
> > If i'm not wrong, Christan meant that this command must run so it's
> > "consistency", and Junio thinks this "consistency" is not needed.
>
> My stance actually is a bit stronger than that.  I suspect that
> running the command without argument once even when no --trailer on
> the command line asks for that <key> is a misfeature, if not a bug
> (only because it is now documented by 1/2 as such---before that, at
> least I did not read the document that way).  And unless it is shown
> that it is not a misfeature but is a useful behaviour with an example
> use case that benefits from it, I would prefer not to replicate it
> in the ".cmd".
>
> > It is true that there is not much harm in keeping `.cmd` at the behavio=
r
> > of `.command` now.
>
> It is far from "there is not much harm".  It misses the whole point
> of the exercise.
>
> Only replacing the first occurrence and not the second and
> subsequent occurrence is not what we are keeping in ".cmd".
>
> Replacing in an unsafe way with respect to the command line syntax
> is not what we are keeping in ".cmd".
>
> That is because these two are misfeatures if not bugs (only because
> they are documented).
>
> In fact, the only reason why we are introducing .cmd is so that we
> can deprecate .command and get rid of its misfeatures while keeping
> only good bits.
>
> So I am waiting to hear why it is not a misfeature.  If it is not,
> then surely I am fine to keep it for now and add a workaround later,
> but until that happens, I do not think "commit --trailer" can be
> used as a way to allow end-users emulate "-s" for their favorite
> trailer like helped-by, acked-by, etc.
>

If it is really necessary to solve this "empty execution" in .cmd,
Maybe we need to consider two points:
* Do we need a new config flag as you said `[implicitExecution =3D false]`
or just drop it? Has anyone been relying on the "empty execution" of
.command before? This may be worthy of concern.
*  Do we need `trailer.<token>.runMode` as Christan said before?
I rejected his this suggestion before, and now I regret it a bit.

--
ZheNing Hu
