Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBEEC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C611A61C5B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhGFSMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhGFSMb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:12:31 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F6C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:09:52 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id y20so5029399uap.10
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xkFvoGYQBIposGnscENVj4dVV8j5UCJ9exSwbGvOwng=;
        b=ggm+uPTcjYCJXot++uLiyeG4IcDDMEpNeBdvBESTWqh2O57cKq5kwCWrevVKuE4Jcs
         2StX46yy0IMQCOq+I1ZfqWAJWtoqYxtH+1fLb01xIT06m+zOjAZ23KL+tYiO4Bli6r4c
         jYfuQcqp7okzZcSnUCgKryAy5Qrc7DRJNXg7H7f4Rw3Yskit2Qqoz/P/37Cq0uHQEMT6
         EHNxD2TyK1a5M90tf0eFovXVo9L7hj1ft88oIodCLZ/AQvHlq2/3KkHgazXFqqYVzWSA
         IBCdTD0HbdFHyUM6/vO25kGBEqR/2JVZQnZaR2jRAyGNMfEvlnVP4bTlIJ9z99SU90dM
         lCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xkFvoGYQBIposGnscENVj4dVV8j5UCJ9exSwbGvOwng=;
        b=VxfF/gCV7+d5LZ+/kP1u/LYIxWGNDns9ItfYgku9lHOJbbnuhxlAeC9FUaeOsZ34VM
         mPN3bXeylBzsEc3Jc3m89GcDLfxE8rh2FlXwZ255xw5T8fMyFMnhffKfKLIzRB/Gimm8
         /24WtBLw2rqc33DL1mW9gp4Yf7oE9jk6u3EX0J9saH2XsHqGktFLxg2JNa2cQ8vI8nUY
         D6wlndRAbepoBcrdeM0vqBPLj+RfpH0oS7zv8zSm7UqEfXDWmoptOoE6OxQUMxhbEm9q
         O6mln+eLdzndz3H4DOVpA7JSOoaVeyCoe5mgWJG+GqgKraEoTzzQEHaF13kzhSkZs3kM
         ec9w==
X-Gm-Message-State: AOAM530TDwNhF+E4BW8N05Y+nyvUb1dl06aZEu41l52RUpne71yUMQCN
        L+bEiBcsdQ81tou/ThZwifsUqaJH6RO09hhRpMPynA==
X-Google-Smtp-Source: ABdhPJwCtsa3FahoZ9R0jHb5CiMInQuJj3x35imOMeLSJR8nZuTgcOhozqENkUg50Tg8e2de42Qr9ExGE6Bs+Kkb8ks=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr8884218uaq.15.1625594991734;
 Tue, 06 Jul 2021 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1006.git.git.1618484566164.gitgitgadget@gmail.com>
 <pull.1006.v2.git.git.1621438289354.gitgitgadget@gmail.com>
 <xmqqzgwqwcu1.fsf@gitster.g> <CAFQ2z_OUxrW_m5H_y62=Q_i0Kj3c4=2Kzf4hRwVwp-wGPcGayw@mail.gmail.com>
In-Reply-To: <CAFQ2z_OUxrW_m5H_y62=Q_i0Kj3c4=2Kzf4hRwVwp-wGPcGayw@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 6 Jul 2021 20:09:40 +0200
Message-ID: <CAFQ2z_M-NmN2xVjoudzEqpAvugyRBQkKh+N4r_s_W=U99Uvwpg@mail.gmail.com>
Subject: Re: [PATCH v2] refs: make explicit that ref_iterator_peel returns boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 11:04 AM Han-Wen Nienhuys <hanwen@google.com> wrote=
:
> > So this corresponds to the bottommost step in the series that is
> > queued as hn/reftable, with the difference at the end of this
> > message.
> >
> > Do you want me to replace that single step with this version and
> > rebuild the remainder of the topic on top?
>
> Yes.
>
> I'm hoping this can graduate soon, so the hn/reftable topic becomes
> smaller (I don't know what that means for your organization of the
> seen branch).

Any update on this? This wasn't queued for next, but I believe it should be=
.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
