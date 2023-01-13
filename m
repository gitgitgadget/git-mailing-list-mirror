Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB1C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjAMRHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjAMRHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 12:07:21 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD511559D9
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:07:19 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p188so23132456yba.5
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4klZ7BEZ6xHulW5o1awiaoRLqOyAotva0ulgHirzSI=;
        b=I/GVB+ZGEx2pYnnBu9uio9v+zA4WpLuR2Th1/qzQf4FTb2yMXXcn1kc+ElKPeg+9Z3
         wnToeVLl32P669raS9SZvcFIaslDpmL9CdxKMeDVYO+eBwumAn4aMXv2psvy11V2/R8x
         zNx3jB3mzHkC/MpfjLlpCXescTmN9l8/4R6f6cnDNpfU5lDGdZQWVxJAqIbDJSRhUcM6
         BPvH5oYvjIdxumGRUIkPqCUpYHsJWiehxOASI4iHYzxUMECQRZwuqc3ake41AyRDFlB3
         TMpJQYOv/UiJLLhNx80FlXNO6eJkqOqhJJPvN8h/6zTV1UjmF/sZRdp1Z+Co9ywa7awz
         4dGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4klZ7BEZ6xHulW5o1awiaoRLqOyAotva0ulgHirzSI=;
        b=OIJY7Je/GPCKiH2U7pKZ2mxp6jD8lG7xUIMmEIdXPiY0D/dEt4hJG7srWsVoaylspt
         4UrmGs96bcmgYG1DgT+Qxb2dRc0Sq0ro1IXHCudQ9wR/aHryNAJe5GGc5tlzb7V0MA/S
         gA3x5gcKHQJowxPeTdZTS3ZPUCXsKqHYtCDR2tH+pTJnxGO0AAmtrbdIZVf0XdNeTXIM
         d4rcR5SGTEn1PvopdinfL9UonBvfr7TZirObqTMkSKn4HM6ZL7loxXbHQkSZtTNWI8jm
         X0pCNORtLivj2lsZeMVBA9tfcc8jQDaRX2tjYHd7LhOjw+3F4HIXttOFynpX1OEmGs85
         t6WQ==
X-Gm-Message-State: AFqh2kp0VxiUVYg61cZLJLV7C46Ejz21/8uXPWCLAwde1icNuC79cbuW
        fJuostoU46SEzRgaYDjN1ixvVKlcswNo743viJXSCxq8V0w=
X-Google-Smtp-Source: AMrXdXvnBXObaiH9uGZKBcvJx+9hVCwAQuul3Z7mSWM2R3+T/u7YHEIq0Ghp2OZtqKhLqfc7GLub0EV+hkrcLhnG+x0=
X-Received: by 2002:a25:5189:0:b0:7bf:d201:60cb with SMTP id
 f131-20020a255189000000b007bfd20160cbmr1329981ybb.365.1673629639094; Fri, 13
 Jan 2023 09:07:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <CABPp-BGsD=6PiJtnsuYPsiZJ1rm2X8yTeu-YeP4q5uu5UDw2og@mail.gmail.com>
 <xmqqwn5rseyd.fsf@gitster.g> <CABPp-BEvK7MFws9=XMfghjo8PgHL6nkiFKmYBiG+218809T2Pw@mail.gmail.com>
In-Reply-To: <CABPp-BEvK7MFws9=XMfghjo8PgHL6nkiFKmYBiG+218809T2Pw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 14 Jan 2023 01:07:08 +0800
Message-ID: <CAOLTT8ScnRqhfRgUXS7qyqA63GdWpZ2DtC=NWhuDEnMYhQqEtA@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add %(skipworktree) atom to format option
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=94 12:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jan 12, 2023 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > Given my above comments, I personally don't buy this as justification
> > > for adding a new way of reporting on the skip-worktree bit.  It may
> > > still make sense to add this feature or something like it, but I
> > > personally think it deserves separate justification from "`ls-files
> > > -t` is semi-deprecated".
> > > ...
> > > To be honest, I don't yet see any compelling reason to use this new
> > > option.  Even if this patch is accepted, I'd just continue using "git
> > > ls-files -t" (both directly and in scripts) in preference to this.
> > > However, you have inspired me to try to fix up the ls-files
> > > documentation and remove the "semi-deprecated" label for the -t
> > > option.
> >
> > Thanks.  I think that would be the better way forward between the
> > two (i.e. adding this one-shot new feature vs resurrecting -t).
>
> Submitted over here:
> https://lore.kernel.org/git/pull.1463.git.1673584914.gitgitgadget@gmail.c=
om/

Thanks, I will check them later.
