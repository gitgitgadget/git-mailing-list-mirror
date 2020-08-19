Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA6C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AD220882
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiiDkmVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgHSPE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgHSPEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:04:36 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BA6C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:04:36 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n12so959544vkk.11
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+8tae5ZEkPPegdgQ5hVTgy97Fd/SIsAR5QegOG+Wyj4=;
        b=CiiDkmVaGImuRwRF7OWczhDNGtc0Mozidg9c2sGPJJyK1KnHG2i4PHAKZx9CyDmBKy
         aZZbogJLYhdYU2z1XujsMJlvW6Uelu8BUYpXavnZaTmTGpsjHjhQvm9sNKz9JGHu8vmz
         L9B/4ZGBticnhZPVPPfxo6/0AQ2/v6RzO6lqiO/pL6/tnUa2DyJN0kOTdfmT2JuUoCxz
         UDSEtWuYcveJexozOODy2TMD0lT7WWaju9nzyVOZ/0kUi1ah+oSzJ+dMoUG/MCRSig7y
         Rs8SP5T2cAfEwIrrIZxIq94mS3g8/V/Z7ZMQfWShA8btGj6wc4O9R89kSzI4P3MD3AKZ
         ZCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+8tae5ZEkPPegdgQ5hVTgy97Fd/SIsAR5QegOG+Wyj4=;
        b=XHimHaHoTanjr00YJXHqJInMCC3BPycWwWPcdCni0EnDW/XzdYwBHiS1/l2tBD/eH8
         Rk4WcINh29xqWiqTr7m57EYGUuQirTznj/SzBGhyt9JF1Cc83P9u/YvQTpUgNplXqx7e
         0SU/b+wpfCB+2u4fUwi2IWPqMMOdDAaaAwx+CNFvi1G1AwR62PD1L81PCIWYj3tt6X0R
         vIjA6q908yPslSOX0UU5aCANnNcS0ukZDT2K3WIcsj8VpsFwludlir7RlGm6tasiQE9w
         yo1vPXMbwwd/gWvO8LMIuLHkrmqyePuK49ijyjLx43I6stbpOTTRLTJvXRqKHkO0bVyM
         S7zQ==
X-Gm-Message-State: AOAM532UhwyI+MOTmB37nLHxf1cf53s0pW1J4wqwj1MDDfitNOFqmOc1
        sKjj0mVjP7cp/kzyRzXIyT48PYq9fijlwOsGAJeKFtIBY2k=
X-Google-Smtp-Source: ABdhPJx7m+ilOa0vbJdTr0IKFWlzrj3o/pTeOu/qL6Vy4fJl0+zvR3WKZ4ZsX0ob5AaLDtpa8z4apPuEfpjzw9QuBEg=
X-Received: by 2002:a1f:3045:: with SMTP id w66mr15308222vkw.35.1597849474952;
 Wed, 19 Aug 2020 08:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
 <06a8e8cbd1370ba3d4ea8a0a9f1e69d27b1d62c4.1597753075.git.gitgitgadget@gmail.com>
 <xmqqsgcjwtpv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgcjwtpv.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 19 Aug 2020 17:04:22 +0200
Message-ID: <CAFQ2z_PYpP4WdUaaG4=fOQ_7RLLmGLjuBQaE2yQVA9=7j9XcuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Treat CHERRY_PICK_HEAD as a pseudo ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 18, 2020 at 11:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Check for existence and delete CHERRY_PICK_HEAD through ref functions.
> > This will help cherry-pick work with alternate ref storage backends.
>
> These two sentences are true, but this patch does another thing that
> is not advertised here.  It stops recommending removal of
> CHERRY_PICK_HEAD from the filesystem with "rm" (or using "git
> update-ref -d" for that matter) as a way to avoid recording the
> current commit as a cherry-pick.
..
> Does "git cherry-pick --abort" only remove CHERRY_PICK_HEAD without
> doing any other damage to the working tree files and to the index?

Good catch. I just added cherry-pick --abort without much thinking. I
reverted to update-ref -d which should be equivalent to what is
currently recommended.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
