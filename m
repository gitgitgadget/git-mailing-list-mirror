Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2156BE8FDC1
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 23:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjJCXgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbjJCXgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 19:36:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111FFC4
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 16:36:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-578d0d94986so1030294a12.2
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696376201; x=1696981001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb1ik42IpclNWmMvYZ/6IaGk4hIxN1+G2JsEMFZ7pqw=;
        b=auGh+lrmZ39r+DZdruP/G+NKS1jDEdqnSDQO132rYYNUTs0i/ComCOEUtivHTdcBCF
         n8U7PhgzosQCCVorQQwZudx4qcLYY4/Ab47Ksku6u7Waq4aW5iOMOS/JJvsPP/VIl8Ye
         gISpfrpBzGgS6VFd7jPU5nT7iC8wip7tDrDecrt0WLrKXHE8Q8pfJGkogAREWG8PxCZD
         gu8V6wJIaeii7OjBE6WBxzi6n4be05jnhW0xQS3HfW0/DU9O3mblEyn8yenifRmiTcVf
         NlJl3fEA0TG7EzfDcHh9+QVg+Aha7uDoGnjXlF1HGr1QGCTHfbMvnaocAI06tBNCwkxz
         qt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376201; x=1696981001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb1ik42IpclNWmMvYZ/6IaGk4hIxN1+G2JsEMFZ7pqw=;
        b=GZ3oThroK7UujDUmf7T2YmmsRYKIzgp2Sq4toT1+pCJHWyKkI7h0PFQI0tUFMQWLUF
         xn6CsWbuUp1MZmjJvbZIjLaNy8Bb7Q3gFbHS5t5RzHIkuK5rdWWujHmUQaCZTgYyxtBv
         maWlXHUgdojTVDsTx4A6QRwAtAGLYdGRJw24+3Z6mMrHxCUunxc9hwaaIItxnVd0J2El
         XyTaCnMDHIcuoo/udCn6RiEIgE1rC/UaLs7ON/j/do944OBPQIzEghCRDkuMJ3U9rcnU
         mbaBqJYUK57hdjcv3zhPgB1i6ZCekpKK8x8b8ucKeQLcOe4g/fcZedg14FyYDnAHxNnS
         Vgpg==
X-Gm-Message-State: AOJu0Ywq1Pqse/EXtboz3bZYX7IQiETRdNk+H4bQprvk90s7xoyPDo86
        a1mJwWv6XucyroN2iSLUfJ3X8H6zE8DiKs4pfx4=
X-Google-Smtp-Source: AGHT+IElbrn9qAeEkUVz2sN9s5hqKoGhVPO6XKiQtvG4WwDmf+Bg8fipdb39hgdjbYLp3o9/CanPb98Zvdg6J198Js4=
X-Received: by 2002:a17:90b:157:b0:277:70f5:115d with SMTP id
 em23-20020a17090b015700b0027770f5115dmr809319pjb.0.1696376201427; Tue, 03 Oct
 2023 16:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFR+8DynAJ7eieMYUrezoNii5tzARNbESFxRCcT4w6okS5FZDg@mail.gmail.com>
 <xmqqedibzgi1.fsf@gitster.g>
In-Reply-To: <xmqqedibzgi1.fsf@gitster.g>
From:   Luma <ach.lumap@gmail.com>
Date:   Wed, 4 Oct 2023 00:36:30 +0100
Message-ID: <CAFR+8DyN8vbuvdgZPkSVqS2=sqconwhx3QfcpJ0+Wi_oCA=s0w@mail.gmail.com>
Subject: Re: [Outreachy] Move existing tests to a unit testing framework
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

oh yes, "Move existing tests to a unit testing framework" was the
only listed project for this current Outreachy cohort. So, I used it
to express my intent.
I appreciate the clarification on authorship identity for patches. I
will update subsequent patches with a legal full name to conform to
the community rules.

Regards.

On Tue, Oct 3, 2023 at 7:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Luma <ach.lumap@gmail.com> writes:
>
> > Hi;
> > My name is Luma, and  I wanted to take a moment to introduce myself
> > and share some
> > insights on an essential aspect of  avoiding pipes in git related
> > commands in test scripts.
> >
> > I am an outreachy applicant for the December 2023 cohort and look
> > forward to learning from you.
>
> I notice that the title of the message and the immediate topic you
> discuss in the body of the message do not match.  I presume that the
> topic on the title is what you prefer to work on if the unit testing
> framework is ready by the time Outreachy program starts, and the
> mention about "do not clobber exit code of Git with pipes in the
> tests" is your "dip the tip of a toe in water" microproject?
>
> Welcome to the Git development community.
>
> Do you have a single word name?  If so please disregard the below,
> but in case "Luma" is just a nickname (e.g. like I am introducing
> myself to my Git friends "Hi, I am Gitster!") you use online, please
> read on.
>
> For signing off your patches, we'd prefer to see your real name
> used, as Signed-off-by: is meant to have legal significance.  And
> because we also expect the authorship identity to match the
> name/e-mail of the sign-off, it would mean your patch submissions
> are expected to look like:
>
>         From: Luma <ach.lumap@gmail.com>
>         Subject: ... title of the patch goes here ...
>
>         ... body of the proposed commit log message goes here...
>
>         Signed-off-by: Luma <ach.lumap@gmail.com>
>
> but "Luma" replaced with your full real name.
>
> Thanks.
