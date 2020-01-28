Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31811C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0180924681
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ay0AUrs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgA1P6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:58:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34278 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgA1P6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 10:58:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so2103834wme.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 07:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N6yqPjUCgxRb5j7hknxMp+FUuMP9YsXPfqqnOAxciAM=;
        b=Ay0AUrs1Kl1fnf5amOciq9rXJg8nkQzKQMxs+nAIZZAwJPci2+oFDmw91KYlOWIDCr
         V0YAnk4R23Fxuw0c/Ytqbc8aXzOsPgC6j9U/CjVKpK+xUnlTmJTNXFfavtQFm2yG9gYo
         SINwTEcGZ3+4it4bZLyywwEam3rRykavG4CiTNr2wmTmDr5yMvB5fW4SXGJvOnf94J8E
         OZMW8d3RjhWW9dlWD2844wX2lcXIsCQN2xgKdS70Q+Y2DHzkbZghW5SzZSTFWDwajkep
         ylQffl1zPwMOyP45quvIFoiH/2FgvNqPugVxvN7L00ncVk7aIKoNA6QcXu6EX1LsNrPM
         HvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N6yqPjUCgxRb5j7hknxMp+FUuMP9YsXPfqqnOAxciAM=;
        b=RpB5NKHdZA9y8XDKSpNuqd8dauKX//CE8nse4fvWerAo0PKSoUztlQMRMHev6Mje9s
         9SV/Rz5uQQg2YV+HBmCDLY0uHZgVIy35qbjJ9qAXWN1Nr9AlPL8vLT96scOEABdBZ6Sk
         zfRZhCcyPJg3Xl3LYvgilE5CGbUO61HrLWVjSwVqSs0Yea1jiOKHne6r1nf4SpV+cyyq
         q6PB5E3jPNoB3jgP8mwcQ5ztu46xQU2CZwn/LMLMPa1VEUx5AdYPDtOI948NWqDxd1wc
         YazXLUBIW3Nbyz/koROffM3xJH2sodEP1IKTiSdVvYdqIT0l0/HZJOBElLjeUwChrOcY
         LRhg==
X-Gm-Message-State: APjAAAWJJGEeimEWEVOv+r0wY+ikXusUYU7EJ9ctN68AeN4DUHZnVmvD
        hoN656Toxc0Ott8IeTDS7j27B/IHJViO63cMCKJbQw==
X-Google-Smtp-Source: APXvYqxhHBk4etxboUBsWtW7iilwe8DLFzPDGx/ApMScWb8V7R+cQTme3m12udHYjy+kQbYmyqs4rReuzy+Rvge0vqk=
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr5581452wmm.157.1580227096854;
 Tue, 28 Jan 2020 07:58:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com> <d7d642dcf6f3c661c51302d02c69e781e201cc6e.1580134944.git.gitgitgadget@gmail.com>
 <xmqqr1zka616.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr1zka616.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 28 Jan 2020 16:58:05 +0100
Message-ID: <CAFQ2z_PY3y4sL=W6Q3EKkB5Vc4PjfeaL0HyybfPUVA0AKxm1=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] create .git/refs in files-backend.c
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 11:28 PM Junio C Hamano <gitster@pobox.com> wrote:

> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>
>
> > Change-Id: I2fc47c89f5ec605734007ceff90321c02474aa92
>
> Do we need to keep this, which is pretty much private name for the
> patch that is not valid for most of the people on the list?

No, I can make do with like gitgitgadget.

> > -     safe_create_dir(git_path("refs"), 1);
> > -     adjust_shared_perm(git_path("refs"));
> >
> >       if (refs_init_db(&err))
> >               die("failed to set up refs db: %s", err.buf);
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 0ea66a28b6..f49b6f2ab6 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -3158,6 +3158,10 @@ static int files_init_db(struct ref_store *ref_s=
tore, struct strbuf *err)
> >               files_downcast(ref_store, REF_STORE_WRITE, "init_db");
> >       struct strbuf sb =3D STRBUF_INIT;
> >
> > +     files_ref_path(refs, &sb, "refs");
> > +     safe_create_dir(sb.buf, 1);
> > +     // XXX adjust_shared_perm ?
>
> I am not sure what's there to wonder about with the question mark.

I forgot why I put the XXX, but note that safe_create_dirs runs
adjust_shared_perms implicitly.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
