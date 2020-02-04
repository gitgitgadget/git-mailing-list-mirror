Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B331C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DC72082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mi2z5GnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgBDU0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:26:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37865 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgBDU0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:26:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so46243wmf.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 12:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8exA8dOS6b+ohdn5/oalvF97uUw4oPMgb0fT0cqLGHo=;
        b=mi2z5GnMxlRk5Rvy7fgPRTvrq/EQwJrftki4SxmPcrc+Bi+pkAgoXsHUZ3YawADj1M
         8rVVrGcwvGZjydmiubux5djAkXYZ+cSWpq0U02juPNUC/GsC3aqdRxlgLnYYI60hWdn+
         XdHKedBXnj/p2d7TSdYTJT17QNSwDOsbCt+LfzobuU45ZmlywuIefYkAyvkDuGcplypr
         sV82Dpj2VPwcbABItw66IgWso/y2qYT9+AwUN/zcrmNr+Kd1iZh9RyO9Gs6wXFZfzNDM
         +2Rin6NiJTPZKng1FczYiS0fZHUnfDxZyYMKImuLlbC4rp5tuBNr0LnN02bB4M/k9cT7
         1rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8exA8dOS6b+ohdn5/oalvF97uUw4oPMgb0fT0cqLGHo=;
        b=rjgGd1+8q/nPPWVZufS810oXZlHBuSqP1YEa0VpFd4N395mRM6H6YuZ6581OC1N27Z
         C7cz+l6HIyIMpDPL+nUYchT5Zn0QADMO8cFSPdc2RifBBr+IDlQ5QhJTRVqqgm0FQ8ZY
         QZQkTbRto18nj/i3TIBMr3f4xYWMxCaOWtuiypC65DKzYVUCZfhhQiqAOF8OnwmIVNdK
         uOoCgZ4JGayTqgt7gupiopoYgv8yJPh68L9yicIMrB9mkFXsA7d+W6am1RD6oDRCC4I7
         1gg+F/n5+qkG0fbaLLsJ9zbcucSzwQlCCurkB+yGEdaeIeVzNzvV2yckhFmm6lCWNB1O
         Dkzw==
X-Gm-Message-State: APjAAAWEsSUSzUMAawBNNeqq4jBOY+Co04wx5yy3eSKmZMn0KCZXOmv5
        LI38s+hTByBtTsEPrRpEzBGA6WM8lLJOMiUnFXVBjA==
X-Google-Smtp-Source: APXvYqyGb2be4/2OBPO2mDe0/SXnxOhikvZ0ZmBnWHtOvDmCkGs9TPatFUsEWTTpPl4j2KB2sM+CWKXMtIulBkgjyYk=
X-Received: by 2002:a1c:660a:: with SMTP id a10mr777847wmc.122.1580848010229;
 Tue, 04 Feb 2020 12:26:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <9138554.c73hJVQVja@mfick-lnx> <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
 <2165647.H0RpPiDeFZ@mfick-lnx> <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
 <20200130072122.GC2189233@coredump.intra.peff.net> <CAFQ2z_PvKiz==GyS6J1H1uG0FRPL86JvDj+LjX1We4-yCSVQ+g@mail.gmail.com>
 <20200203170555.GB3525@coredump.intra.peff.net> <CAFQ2z_P0X87bdCTSCXLHrV-M7vb+3BBjVmG+3CzYVY0RUHdKXg@mail.gmail.com>
 <20200204200617.GD12705@coredump.intra.peff.net>
In-Reply-To: <20200204200617.GD12705@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 4 Feb 2020 21:26:37 +0100
Message-ID: <CAFQ2z_P0g0+8DRNkT7xp8kOKO1rYhtaTB5=gEE4nPnue-BDn4w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrn@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 9:06 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 04, 2020 at 07:54:12PM +0100, Han-Wen Nienhuys wrote:
>
> > > PS I don't know if it's set in stone yet, but if we're changing thing=
s
> > >    around, is it an option to put reftable-list inside the reftable
> > >    directory, just to keep the top-level uncluttered?
> >
> > I put up https://git.eclipse.org/r/c/157167/ to update the spec inside
> > JGit. Please review.
>
> That looks quite reasonable. The one change I'd make is to put
> "refs/heads/.invalid" into HEAD (instead of "refs/.invalid"). In my
> experiments, existing Git is happy to write into an invalid refname via
> "git update-ref HEAD". But by putting it past the non-directory "heads",
> such a write would always fail.

thanks, incorporated.

> It's also supposed to be a requirement that HEAD only puts to
> refs/heads/, though our validate_headref() does not enforce that. I
> don't know if any other implementations might, though.
>
> I did compare earlier your "make refs/heads a file" versus "make refs/ a
> file and just give it an executable bit". And I think the "refs/heads"
> solution does behave slightly better in a few cases. But if I understand
> correctly, just giving "refs/" an executable bit would mean we retain
> compatibility with the existing JGit implementation.

I hadn't looked at the JGit discovery in detail, but it looks like the
currently proposed approach works with JGit. (I haven't adapted JGit
for the new path setup yet.)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
