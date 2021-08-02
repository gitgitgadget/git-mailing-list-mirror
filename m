Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77472C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5583F60EE8
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhHBQyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhHBQyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:54:09 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC26C0617B0
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:55 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id 105so7209565uac.7
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=02OquQ4glEqI2zzRAY9MpuIyTCSlIyswVG8LaLAV2R0=;
        b=f9f66t2eF44iboBE3FtihzTm78we2ApijUi5z9TGJMXfzVCQxs1fSlG62uFt9Fnp6f
         yxfYCbgM1oIzVebYriQQiLcuD1DKETPze2SpZWdSyhpp3vKUsbOmtr2ZuXK242sR63ao
         UajicbtOxPQRzSGX74/QzrmZgjkEqwvlOL8pf6dRjJsNUiBahOArtihjyMZ8elvBq6lB
         wNBa1p3JDAguRq7H1XA41CYFebyhJfox1prF+Cutm3GiqsOiVF7iHXc2JrdKz5xF+K47
         zDzXFmSxn2HgM77lHtdtclecPrwH2WL/JDKEM7KuzEJza5y2908EwIFEOMVWF7vQtvnN
         4Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=02OquQ4glEqI2zzRAY9MpuIyTCSlIyswVG8LaLAV2R0=;
        b=PjctdegIo2pW8GtXRF08SJuSmCn1XLnVnnyv6DZRthAdwnJqEvy4A6i9FlZ/K8VYty
         rh/WcKUmmK0XumfHA3fUnZRU1/3ubps37Mk5T26HPakwHbfRKO6cUiZlMXk1SYjCdF96
         mHuO1ZYVboDG+ClGj6F+kuwlJrg1PqC0SNdEN5HDwPU6FdMxrR4Pmqn/V4zoJdVeXjpM
         yYjMNSVE2CYXgDuTb7UPT4Zpy3JoLaFSbI4e0f7AruTfMclg4oFHQNgWBq3GjPTl61MC
         coJ23zDBfKI/w9dxuYd935K8UFA7jKEVXtC3znKw+ujFc62Bq3FpDEWofEKZtSecUfn6
         4BCQ==
X-Gm-Message-State: AOAM530i63FccT5Ap6KjGksC8/omoaCRNcpA6clYsJPu/woALbkQlxAD
        g+W6CxWEesux8qtJOAWLT9WJ7xVCNO2yaF1GE2ryjA==
X-Google-Smtp-Source: ABdhPJzuuzr9N17iEUIly9CtCtDHZFNHALUMIzGWnC5fAhliuZOii/wuabCgMlnYwlaMdTSQjT/KHAFmTY3fRFdKt98=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr11765278uaq.15.1627923234701;
 Mon, 02 Aug 2021 09:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
 <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com> <xmqqbl6tncw7.fsf@gitster.g>
 <CAFQ2z_PjEuy2Ngr_i7c8rT6xb4w2HBEUARqwR7azZO4zor-w7g@mail.gmail.com> <xmqqr1fbx13k.fsf@gitster.g>
In-Reply-To: <xmqqr1fbx13k.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 2 Aug 2021 18:53:43 +0200
Message-ID: <CAFQ2z_P=54uk-9r8rTcSvXd5g5Mj8S1GjziszanC6iNdTp4q8w@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Fix direct filesystem access in various test files.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 2, 2021 at 6:28 PM Junio C Hamano <gitster@pobox.com> wrote:
> > By listing the files before and after, we can make sure that the ref
> > storage wasn't changed.
>
> Meaning that we rely on the fact that we never append to an existing
> file?  A comment here would have helped.

Added some more explanation.

I addressed your comments for the other changes (but forgot to update
the cover letter :-/ )

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
