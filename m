Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E6BC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D713206D4
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 18:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E652p5ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgA2Sxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:53:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44069 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgA2Sxl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 13:53:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so677960wrx.11
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 10:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M903c7OX6+j5nnrrSV1iw2YyJjDgw0n24MljT5EyxjA=;
        b=E652p5ewHWurF+QBxkD613j/TvPPRI/lTGb05WUQeQKtEB0EG8aslUIweoE/AjSj0I
         YmRucX2tiD4tCjDD6IKqRjt6dIPk3ToAWEVsuZyvUe9O2xpY2N356DF4jS/1c9ZjRkp7
         DPmO6XrBPjDM0WwHUGW5UbOfol9tCwhqNpFBDrNxoIf73GSWkAHuMHaoBc9mAIOE6Oso
         RlcgFX8O61p43l7KI8yFJbX5Sb85pZZRUugn76xfC3lkHgEeGc0jTrEUY9uuM/G9BoqO
         GrRbUY9wRXh2elMCBaTQMppGA/WwRbqXq9JRil0Gx6a0BGwMgnIIhDn0ljfU2BkD0H7H
         ropw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M903c7OX6+j5nnrrSV1iw2YyJjDgw0n24MljT5EyxjA=;
        b=PPURrBVVO1AbIyaeSsd8TbJCINCVga8kYcHCra0A2BaywttgMq1jFXUNioEP7o3awQ
         kKNGqCMx19TcXlhzHGISXi1vVeaFqW6QkYGO/4wkvVJzvrfaQy9kHn8OlTmzqCU/JOJw
         nCd/i4kEINCL9HQGhOvOHpJEXL9FeC1H43ZoOOGrthSeyIpcDxGNa6jK/CCNu/Jjlteu
         u1vXcCTJcPsoAdBEMmnUA5u2mVI/BIVsb9BHmVvEVPUe2ydV7hzBJjjn9ni+muzZt2hi
         dZwpw+ohtpTdMeSr6YeLhrjbBwD/GGgRZZcGVvCh9fxRYWKQcQtyXGPaRxu182leS6kO
         XbEw==
X-Gm-Message-State: APjAAAXzU4OLOpCZG/gDSHYoqbjf1lIZTg4SG4VllMCwJ0oVUdeo8urd
        FRo6YtYXRMvPn6zKOprMrWsIRYPDdABu3lrSjDWs8A==
X-Google-Smtp-Source: APXvYqx19I252XSpPfOM/8MxzxUfmGZrV8pzu1xMxs3iDInRvDBu9KFEjvfeqYN31Q232Y5kjZf9XosQX3NbkERctGA=
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr278766wru.6.1580324018601;
 Wed, 29 Jan 2020 10:53:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com> <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net> <CAFQ2z_MXDODBmsCVPdvNQzhFSYchq77mJCxw9P0kPSmSnsTZqQ@mail.gmail.com>
 <20200129104754.GE4218@coredump.intra.peff.net> <xmqqh80e5cjk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh80e5cjk.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 29 Jan 2020 19:53:26 +0100
Message-ID: <CAFQ2z_P2Xu5iEj0ixnM=ZjrH2++dJHWu9znJj0g8csEj2COpeA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 7:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Making "refs" a file instead of a directory does work nicely, as any
> > attempts to read or write would get ENOTDIR. And we can fool
> > is_git_directory() as long as it's marked executable. That's OK on POSI=
X
> > systems, but I'm not sure how it would work on Windows (or maybe it
> > would work just fine, since we presumably just say "yep, everything is
> > executable").
> >
> > So perhaps that's enough, and what we put in HEAD won't matter (since
> > nobody will be able to write into refs/ anyway).
>
> I wonder if it would help to take the "looser repository detection"
> code alone and have it in a release, way before the rest of the
> reftable topic is ready.  Then by the time a repository created by a
> reftable-enabled Git appears on people's disks, all the older
> versions of Git that are still in people's hands would at least know
> that it is a repository supported by future Git that they themselves
> do not know how to handle, stop repository discovery correctly and
> refrain from damaging the repository with an extension unknown to
> them?

Sure. I suspect that the reftable topic will take some time to get fully re=
ady.

However, it would be good to have a definite plan for the layout now,
because JGit (if you tell it to) is already creating repositories with
the layout we're moving away from.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
