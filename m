Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06128C28CBC
	for <git@archiver.kernel.org>; Thu,  7 May 2020 01:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECFB2068E
	for <git@archiver.kernel.org>; Thu,  7 May 2020 01:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBt7jMWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEGBhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 21:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbgEGBhQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 21:37:16 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46E3C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 18:37:15 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id f5so2066350ybo.4
        for <git@vger.kernel.org>; Wed, 06 May 2020 18:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PFB2habt6LGThflQ2asv5E7XBERPvDlZquTCKAP+mxw=;
        b=NBt7jMWUCohg7qNIQdNPQLPlo8X8PhxeG16EUiZoL/xNEWNAXi/+qw2IQuSmL4dE6W
         IpsT7DJpFRTxfJzLOnn7zHMXMJ/I7wDQfagEj6YZgl+zFUHswu7bvWfQ1PR7AilhkKDx
         v5tlO4TCTfoFEoaXZxGWBLWSPO4Ep6v1hJFU/R8Hnt3uxaCOZ4fdCqJ39R4sAtj6KI0M
         GwZS+E91y8woIVskZIOow4Pq+or7WAAqpw2xKX2ms8lqmPqxY/TYqxJef4C0ahDIZQh0
         /hVDMrSU3bNrfT8DJJNxyEv9M26LbmsFNlIYMDdYju5Lk8SwCcocccjOfQOov7QExvqj
         nohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PFB2habt6LGThflQ2asv5E7XBERPvDlZquTCKAP+mxw=;
        b=VV+zhnUUHjnTRAcgOFrs+YCJZZ9GEmVZ5RVfVWmUJ7Ym+njiweY28G1jrqczCpgPAA
         oCOABeodDjAqngbMXGZ0bE1aPqSM+44PvCEyUfQGZO2ph+MGw0/sceF4g/2BySCZ0HBe
         aorMLJrmC1+iLjp20aN1gklYbu27aOGMmhl20r2vlXLjYcFjANsbpHJzViBwGYu2k2Y3
         fKYXKsrkT/uz9fR/8Kgc58EK6nzj9ellJJll9Zxa+aOxWpQ5VJh2ufh56mOEdqi5EPVz
         5rn/pDgSBtVS9VRPGFOdq2Cc3i53A6n0g6wmsfCSE2Mu9Mn9rXiyB0QiYnwC0xOy9xPT
         HKGQ==
X-Gm-Message-State: AGi0PuYhTW7tMOL31CVe+TTqQbbsDKWedxQuF234W3qptKSpi1lux+mf
        XGZrk84ZdKBS7Lp0V7YiWqPNTpr0rir7gf+MkII=
X-Google-Smtp-Source: APiQypKjvXRr9+dvZjkZNDDsSKFMeYyJ+oN21/wga+7kbnjCgAHTCTJilfFEOfcTr6wgpaTTc9ypq5BXVAvjjrMX5Ec=
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr13548258ybc.403.1588815435021;
 Wed, 06 May 2020 18:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
 <20200505144131.30048-1-worldhello.net@gmail.com> <xmqq4kss64h7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kss64h7.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 7 May 2020 09:37:04 +0800
Message-ID: <CANYiYbGf-szLeBP_JVpCYaWczeg1rNavDCXtEuwXUqiLNoUFtQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/7] New proc-receive hook for centralized workflow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=887=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > This topic introduces a new hook named "proc-receive" for
> > "receive-pack".  We can use this hook to implement a Gerrit-like
> > centralized workflow.
>
> https://github.com/git/git/runs/651179641 shows us that osx-clang
> job ends like so:
>
> Thanks.
>
>
> Test Summary Report
> -------------------
> t5411-proc-receive-hook.sh                       (Wstat: 256 Tests: 273 F=
ailed: 0)
>   Non-zero exit status: 1
>   Parse errors: Tests out of sequence.  Found (27) but expected (26)
>                 Tests out of sequence.  Found (28) but expected (27)
>                 Tests out of sequence.  Found (29) but expected (28)
>                 Tests out of sequence.  Found (30) but expected (29)
>                 Tests out of sequence.  Found (31) but expected (30)

It seems that the status report for git-push ("ok <refname>") confuses
the test. Will fix it in next reroll.
