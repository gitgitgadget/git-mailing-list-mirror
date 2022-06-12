Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E9C433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 08:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiFLIyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 04:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiFLIyb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 04:54:31 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D6A517D9
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 01:54:27 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id f7so2321989ilr.5
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2h5FxndKSQwm14fS/7BxcP9BlB4J1P7yxEMGx7zwJU=;
        b=nDHbDA+1PhS2xFnD6EFblYxoUwC4c7M1KBg5KIjbk3qn4Us+DvK1mrh6qGOUadQ2a5
         X0d9JiQ/GdxPKtVXeeBiXM4CNREiAx0fc7aoyuDrfafHiLD8C1EW8QVkJFDAoApYLdqT
         m0BMGNWthNBsdcdVXc2ZDnMS4Jy08td6I4dRDnyHJtxy9TWBYy2/q0HgcHjiruPuaxHL
         vXhthPBsSF77rV2s1Hl0v4twZ7Q/L3nzUmPYoYB77FyhOZi8IPkbr+HUEET61DlQBlIJ
         ChJNCST7XRjrBkwcZQwI9XNHd9+OXmHHx+zC/ASY8kSBjOBarIkPETdpFC5UY6DaH/d7
         tGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2h5FxndKSQwm14fS/7BxcP9BlB4J1P7yxEMGx7zwJU=;
        b=niy8F8khVXRJRyA358r6a9VhBHohTxv2R7pUqJUVMBdlOS4mpcpBknzcjb/SyLl30t
         FsTkwD15ytTp5Qfvr6x7RiQUgBiSgY5w0crdsV+SjyczyTdOPsaktyAcN3bpRr00DFCJ
         q3vaGv3C5P9Y6BRsk+kztCeVnkifDSVNw3cCjwIyBE+8oZBkydB/a/UsXUEK9O5cZGzv
         EEFsMu8zqUIQEN74/ih0PIL0QBAXPdUhEMXoLpW9+dJj88ebd61RNbpvAmam7/Yyvdil
         WjVXqw81lA+Oueh/Zq2OXxEXYCP/iDwnkVuBhylBTZqaBrWHYIIEerxCYwUyTkqV9THk
         ZjQQ==
X-Gm-Message-State: AOAM530FA4fnOH4KMxbc+I4NLKhqw72hN24Qwdk07qqktDJxFMU9msFV
        xmeTGU49+j1z5RGYBEs1uj5vghYp1Y2tOv4L2wg=
X-Google-Smtp-Source: ABdhPJydX79w5Y9l5rFgVuogq8aVaT26WjvH9gVppY/fzdNtelThC/GjyKNYj18lD4qhGkjuu6rWyieH8PCdX8KMNmo=
X-Received: by 2002:a05:6e02:1bc8:b0:2d4:342:9c68 with SMTP id
 x8-20020a056e021bc800b002d403429c68mr26637348ilv.254.1655024066426; Sun, 12
 Jun 2022 01:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com> <CABPp-BHfdo_JK-NyhMv=_7FpAGNj_vxGwGRoSYXRK==ARzh1Cw@mail.gmail.com>
In-Reply-To: <CABPp-BHfdo_JK-NyhMv=_7FpAGNj_vxGwGRoSYXRK==ARzh1Cw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 12 Jun 2022 16:54:15 +0800
Message-ID: <CAOLTT8RpGGioOyaMw5tkeWXmHpOaBW9UH8JghUvBRQ50ZcDdYQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix merge restore state
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8812=E6=97=
=A5=E5=91=A8=E6=97=A5 14:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, May 19, 2022 at 9:26 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > A simple series to fix restore_state() in builtin/merge.c, fixing the i=
ssue
> > reported by ZheNing Hu over here:
> > https://lore.kernel.org/git/CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-J=
Oo9Y+SqA@mail.gmail.com/
>
> I updated this series a few weeks ago, I believe addressing all the
> feedback.  But I hesitated to type "/submit" over at
> https://github.com/gitgitgadget/git/pull/1231.  I've done virtually no
> development on "interesting" (to me) projects for quite some time; I'm
> only responding to email questions and review requests on the list.
> And the review process takes quite a bit of work at times, and on the
> chance there was more feedback to address, I just didn't have it in me
> to submit a new round even though it _might_ be complete and certainly
> fixes some known issues.  I haven't even gotten to review Dscho's
> updates of my patches this whole week (spent the time I had mostly on
> the merge-ort issue reported).
>

Sorry for missing this patch before. I have tried this patch, which
can perfectly
solve my origin problem. Now it can reset to origin state (Even when there =
are
some files in the work-tree here that have changed)

> Does anyone else want to take this topic over?  There are updated
> patches and even an updated cover letter over at
> https://github.com/gitgitgadget/git/pull/1231.  It might involve
> nothing more than submitting those patches; they might be good enough
> already.  (Alternatively, I can type "/submit" to send them in...if
> someone else agrees to respond to any feedback.)

Yes, I think you can submit it, thanks very much!

--
ZheNing Hu
