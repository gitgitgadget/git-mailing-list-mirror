Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C1FC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BB561A11
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhGFSjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhGFSjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:39:18 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C979C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:36:38 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id m12so145844vst.8
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WqA0yzkeI/81syfoXcDAAH1brK8k3ELtYcUrhNr15Mg=;
        b=V/CNlyrK9lUIpfNJhf827qa9R3sPaUyRBJBzmJSBOjEL8kjQQpJqlasGCnXVapuXE2
         DlwxS2KdP7zOHGVNrRipNguvbZNs8n46ux+71HiwZ3yZwggQ7jgBpn6dtw3lEzOhl9c7
         yjP1F6+R+p3Z6kdQuDcdmbmUayTLN5S36YHoghWfVLRUsgLtsRmVNilRpfbxFq/NLDlp
         Iqsn+GF4bC2CMCpR6OCTCstcWBrYs8UB9qrresxPpqA0Ejm8948yF7dH4joEKIasdL0j
         mgnIFpb+kQSJf4QE+SpE5+XemTaV1SGiTy+BKVL6q4UUWEl5aaMw/EwZwrRr0YAiRIHJ
         EaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WqA0yzkeI/81syfoXcDAAH1brK8k3ELtYcUrhNr15Mg=;
        b=FayjHJSurrUk+wLXIbZjluzhRA8B74an3i3aqfiZF+C7IzKoIHvE8qfaM8mreE+E5a
         Ck1uMjquJgHJGYiHqSkhb0g6REjXZmDxkyylj3TLNJlkGgcnHxdAvLJghbAj1LeTgQ7o
         TOycCfEZMrRuEiC8M+j7sEWOdEcbOy2xL9H7IFSuNKptO3tuR09RotTRmDncxPSKieHT
         o8FJmX2ZEaPDu1QfQguqZ4qITMmG7uPdnl/xx8Us6hzRHsQdtbvjdcxnrmY/+uvSXBkx
         XjZOCa7DY2m16wZNcERFTrAhpCeP0FcfEqtIbGN2gYaJIZuD7uKdHBVyNZY2JFaIKHVh
         DkvA==
X-Gm-Message-State: AOAM531fKrF0u8XU3hzCMsgjBYrAl578OGZ1tYXizRRG6SASe15VnNbL
        346iB1k/3sfzVWbg8CmFtmCj66z7Dq4XOikO7qtuew==
X-Google-Smtp-Source: ABdhPJyiua/ksje/aYFT7Ao++/wllpVyIdJMPoUxp9Co1RwrnY7fOulHx8S6e1hdDi6Z0akLXI6Yf8APr3hb/Lgh5+I=
X-Received: by 2002:a67:6992:: with SMTP id e140mr17315343vsc.2.1625596596020;
 Tue, 06 Jul 2021 11:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
 <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com> <87v95o5ku8.fsf@evledraar.gmail.com>
 <CAFQ2z_N_J499X_wd4RGR7jobs3O3NvQuobJ9UcQijkNYN712dw@mail.gmail.com> <87sg0r5x0m.fsf@evledraar.gmail.com>
In-Reply-To: <87sg0r5x0m.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 6 Jul 2021 20:36:24 +0200
Message-ID: <CAFQ2z_PXjiUNxgC5W=+BB4yRanHtNO+AtPq4u0k6S+t4zcj5FQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] refs: cleanup errno sideband ref related functions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 6, 2021 at 4:37 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

> > I've added a failure_errno argument parse_loose_ref_contents now.
>
> Great, it's not clear if you picked up the full diff-on-top but I think
> consistently using *failure_errno in files_read_raw_ref() instead of
> "errno" and the "*failure_errno =3D errno" at the end also makes the code
> much more readable (and allows for the removal of the "saved_errno" we
> don't want).

It's hard to get right: there are many system calls, and in most cases
EISDIR/ENOTDIR have to be propagated to the caller. I tried doing
this, and promptly got a failing test related to dir/file conflicts.
By doing

  *failure_errno =3D errno

near the exit of files_read_raw_ref(), we can be sure there are no
changes in behavior.  If anyone wants to understand the files backend
in more depth, they're welcome to disentangle this in a follow-up
patch.

> By using "errno" itself for the body of the function it needs to be
> really carefully read to assure oneself that one of the functions it
> calls doesn't make a syscall, and even if we're assured of that now if
> one of them has a new syscall added in the future it might be clobbered
> at a distance.

Yes, anyone adding a syscall to files_read_raw_ref has to be very careful.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
