Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16400C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 21:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F128C61027
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFVVYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVVYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 17:24:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8CC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 14:22:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d16so607406lfn.3
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90H8gH4KPJ9+/ZHU0vdqyKCVypvQkgDZOjofQC4nKEk=;
        b=e/AY2Ol1vQ1GpHxPxVdB0R4FiDgBYy4k9xil7UPl1/2F33RaNzu60sRneUcZ1jQ3Jp
         htDHUNgi7T0faFFshL0SBFAPjLPQC9ywX21m1dIFrVoP13ZIS+QCFTWIP4SN8uR4mb4j
         GrDlZphaygIb58qRJweLk1+SPRaOej7XdRxiSG7FXifNvUElgvYR+Sgv5SIlAP2UvHnn
         7Ka1PDWc4yEaABamueH13qnBlYDUiuUvpcI+ovxB9tqdib6HcmBMo76s5DIYaUdzoB94
         1G9fYGeOZT5LX+zH6i0EplTO/CtUalzFTJyZOakaM/DLlEE4gqMHFSIVflvmbE0d8PDi
         r9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90H8gH4KPJ9+/ZHU0vdqyKCVypvQkgDZOjofQC4nKEk=;
        b=LS0GO+XndoDvGFDwquDli6LK7neTF8hOtSz9oH6C5znzFj4KAevkQFF3DJ7dLooqhp
         p1RcupFpyjZjdQobeI15xKUD39WSm8hWEr14ERU40M3kmADYS/C8eenI9GbIgLD59Whf
         NtU5hUz7P3qaAYo3S1j/fY6M22KhVHSaHg2lQOgC6Y1ju82ocDmXwFQGCaIpa7L5eZfy
         zWZ/d9rOBA45/M7pYXGZlfrWVEdLAlMzvKc2LOHwZ99lTZ/Wk0QIjymzerIEk6KDTlbO
         DVads0C3K5F7Aoqae8FQCx6XBHeU6J2oQLtbsgsj6blTyEZ+73mUeJdSm/BjOr8RUx8n
         Kbrw==
X-Gm-Message-State: AOAM532cLCHvUxoUxwNvqEMCwM2157H954sU9esRCNcKfEyvKAJtBJfz
        u4oPjvIyomVnsbYuZU2+aG2Ul5lKU6Z/sNE1OJE=
X-Google-Smtp-Source: ABdhPJyIpEpw5Dwf1ZmhmQp6tAzhtpKz1N8Cy2b/6+GcMJ/77f+pHAEEbg5n2QBXi7J4/S9Xyw0Rd8tyG5Bg0ujGCs8=
X-Received: by 2002:a19:7414:: with SMTP id v20mr4299483lfe.203.1624396943412;
 Tue, 22 Jun 2021 14:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch> <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch> <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
In-Reply-To: <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 22 Jun 2021 15:22:12 -0600
Message-ID: <CAMMLpeTmYcJHf1t7VpOBakMZ_vtk+9bmLRTMA9ueghG6WwCRtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 9:06 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jun 21, 2021 at 8:15 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> >
> > My only serious objection to this patch is the instruction to merge if
> > you don't know what to do instead of asking the repository maintainer
> > what to do or reading the Git documentation. I don't have a strong
> > opinion on the rest of the patch.
>
> You're not alone, Alex; I objected to that part as well.  (See e.g.
> https://lore.kernel.org/git/CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com/
> and various other emails in that thread, ending with "agree to
> disagree" later).  I still object to it as I did then.

Thanks for the link, and sorry for not having followed this
conversation closely enough to have seen your previous replies. While
we're on the subject, do you have any thoughts on what (if anything)
more should be done before making the switch to aborting instead of
merging with a warning in `git pull`?

-Alex
