Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E97C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99CA20674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 19:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAzUyTCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBDTHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:07:12 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40535 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBDTHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 14:07:11 -0500
Received: by mail-wr1-f45.google.com with SMTP id t3so4552247wru.7
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 11:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8rlUXn+NC4Cr/yka61J6FwRg0DleYt87YbyBlSykjA0=;
        b=kAzUyTCyxmr0T70KKgfluboP0ii1x0rCG2nTdg+jIqOGzC/TMbZFhppHkV7/sdS23B
         ITAaLYjzko1Bwrmb30QoMajmxFzZa67n57v46wvl5SUp5/xFXfuHH7W355k84xdtDCNM
         Uk7q6gdVj3BFmzVSzOLKYTDXcs0NklWhe0sTJxY9ZArWrBbocgxvdyq1c+HyOpAXLSGb
         ZODIFLfrWQThNDpILAYANs5Md0zkbVYGZ7852x3lX0TUZxcArVMFp+PQ6iMeuU8DTabD
         b42hooyKzMkrYKejLGF8fktkqTbw4Z7rkxpaW+qKBddImd/khUc4QkiFlkSrqvuWylnH
         4t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8rlUXn+NC4Cr/yka61J6FwRg0DleYt87YbyBlSykjA0=;
        b=kgNebYRPwjtRBxUqbf+/C3AwHYoVKPwJEkbwOPNiIKZOs07JSRac+3cUAQB2gjMK+z
         X738+kUU7AcKm6H+fiPQvthUqTwmuO6DGxkgRKmzFaLD1tep6bH3T2O+IapcFeheO5fq
         oMYlZKkbT2vkV1jpOj2fy/E+nHVt9fbLyD7mN5YHsWDACqWHLyBfwMK3Szvwl0KZYkHH
         gK2F1eACqy8lZ/yhqnJh73YuYEc/HEZGDroebR07zzSlNDwS8mjdniUdNDKXFQYajisF
         te5rSTdZBzW5gTuK1YqavbIm0OdA3lzWahGNCPzou1C4IlThr5yij53jtiIzac8pquME
         T21w==
X-Gm-Message-State: APjAAAWFTKMowmYQr72MUN2IRikfQqpq9ViSGz15RCTjVdRUtTxl6udG
        ah47WOzWzEjIDHOuEMMuQ5+Eh9v4ZHMttf4Ej8Igxg==
X-Google-Smtp-Source: APXvYqx7RrLvbLccEHzQnZ+o+gtMYxUqixe0VAmm9xpodyGCVcpAwhejYDPaoGmI1D4gbvG+kyR7mdadY097NlTHLP4=
X-Received: by 2002:adf:f80b:: with SMTP id s11mr24939169wrp.12.1580843229550;
 Tue, 04 Feb 2020 11:07:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com> <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net> <CAFQ2z_MXDODBmsCVPdvNQzhFSYchq77mJCxw9P0kPSmSnsTZqQ@mail.gmail.com>
 <20200129104754.GE4218@coredump.intra.peff.net>
In-Reply-To: <20200129104754.GE4218@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 4 Feb 2020 20:06:57 +0100
Message-ID: <CAFQ2z_O3DhLbVtpGBWERnwGawtvE-iZNKRDGg_sfMhOX6g=Wpw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Jeff King <peff@peff.net>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 11:47 AM Jeff King <peff@peff.net> wrote:

> That said, it might make for easier debugging if the reftables file
> declares the size it assumes.

If there is a mismatch in size, the reftable will look completely
corrupted data.  I think this will be a bad experience.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
