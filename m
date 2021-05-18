Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A48AC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385CC611BF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349627AbhERNbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349621AbhERNbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:31:38 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80800C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:30:19 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id n1so3450907vsr.10
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PwdYW21jleDxiJoE6JxUEzLkMkie+SiDl8a2BJQTZaA=;
        b=RF36NbSlbwsYwu9vBv1XXrRoGjHQrxvgEH8K5CvlZP1D1EEGk+v0qI3SNd3tOmD3lQ
         ZNs4wqleQAnvg1ug8xYy2ylVnSytzSiHfEi5rv6eXMGWZTI6L6cj6BkUcjnIuNLOLm4p
         eVO0wUnOZS3rEtpOgRi3+n9nKEj6eWzAQKFOiMJz8mnxWby47gzFFS17LwtWkd8gm425
         4VVm/XuRYeY+Melnmg1cTbXm0hnmMg+I2ZXhXhydFrPnRZCbO7vmSq+IDjQKjyO/7rss
         DvhW3gjBt9eyO4DRvfopFKO8ugxwwQdvetk1LxbvJOHtikouZYICe1SGeAu7URZXI7ej
         gAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PwdYW21jleDxiJoE6JxUEzLkMkie+SiDl8a2BJQTZaA=;
        b=eeUziXXIxAQgpOApaEsiuaZqrTRP3GX7cdVxI5rca1tJZjVzEXJpDwRgXGz7FYSbMG
         1skpmVE1v2qeVPUKpdkqlUo/ccqpRwhhKmc4Rvl/lOi0AI9IH4q0qH9rtZqU9obOzE2I
         AjUeihPzjGqWMxj2gxrdptlTjXSTwcY5TDb9N2zNhWIjoQ81H6/Qz5T4Q1X2vo3VK1A7
         1UE8hhqYImfAuy8i9OuuOlJNurptmU/0HYSkEbwEbmJ0Z7IWQSzi/QN47CXP9PT8CkNe
         KwwxVWfkwWA/XwRI9Kgt+6KSFX0lkk9HReErk5oYu9Dvz9spFL16suTbma2jQvoXAJ1U
         YA5A==
X-Gm-Message-State: AOAM533b8y/rI6+AGibx8F5rcLO7TMO2A4O9PlJA2kQGdaHr72b2HGi3
        QZVKEK0mRz3B1E3DXU/mtuUf+7QGil80izN9wITapA==
X-Google-Smtp-Source: ABdhPJwOeHEnm6yQeUgQYdDbcf5CCP3iyHgjqlnyV9X7FpanL/KpwmACJprSVosWg21Trm9qsLAbqo+B79Q6fMvd2x8=
X-Received: by 2002:a67:ebd7:: with SMTP id y23mr2778707vso.54.1621344616350;
 Tue, 18 May 2021 06:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com>
 <f5711aa9-e70f-8bb1-09d9-4f283b010d46@ahunt.org> <CAFQ2z_Os02GHCcPX0Hcin7+va232Di5wFBbdbOBqEehJvTFbFA@mail.gmail.com>
In-Reply-To: <CAFQ2z_Os02GHCcPX0Hcin7+va232Di5wFBbdbOBqEehJvTFbFA@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 18 May 2021 15:30:04 +0200
Message-ID: <CAFQ2z_Mz65QsFEsdAEKrRkA8LpOcf+i_Yq-_Rb5sRj4GT=5h5A@mail.gmail.com>
Subject: Re: [PATCH v7 23/28] Reftable support for git-core
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 3:18 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> > This seems to assume that 'ref.value_type =3D=3D REFTABLE_REF_VAL1' - b=
ut do
> > we expect to have to handle the other types
> > (REFTABLE_REF_VAL2/REFTABLE_REF_SYMREF)? When I run tests in seen
> > against ASAN I see the following errors in t0031, which suggests we're
> > running this code against REFTABLE_REF_SYMREF too - but I don't know if
> > that means that this code should be able to handle the other ref types
> > or if there's a bug higher up the stack. (AFAIUI REFTABLE_REF_DELETION
> > is already handled because reftable_table_read_ref() already returns 1
> > for deletion, but the other cases seem valid?)
>
> Curious.  I didn't know it was supported to create symrefs in a
> transaction, but I've added an assert to make sure this doesn't
> trigger any sanitizers.

This happens on repo initialization, where we create HEAD and its
referents at the same time.

I've fixed this provisionally for now in my series.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
