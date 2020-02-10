Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28519C352A5
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9B52070A
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 13:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJBHz2qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgBJNSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:18:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50596 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgBJNSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 08:18:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so279658wmb.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 05:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3Q6RsgiOZp+RJ/e6qpkszgHKSvHpyCsbVnJ7qCmn06I=;
        b=lJBHz2qS2613IGhn5kDShwpGWe2E2vGoRemlNbV1gC3FUfyYlofF1lurdqBW3IsFaW
         gVHifCTzfTC81aEl1V+limjBZSSCJlpghcLm4w+poWFhJnu9gNCNxdzHHQo9mRwB3Co7
         bOHwPSx44mk+HW0PlPrhrZiPNHtitSWHa99U+a7+YEuUKsPCyR4PDB2UcAyGRknCAHoo
         2Zr0ZYl+kCeUrrBSKWOeSM9eno2AV9Vl4+4JxF1oCf6zMXpPE+GWFItsv7KylV1oouR2
         RLY36lAExj6bxzllXQubErhFDMjrAZQv0ymzmgTdvp3Wh/Eroc5MWVu1srIt8LjMdS6R
         ouXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3Q6RsgiOZp+RJ/e6qpkszgHKSvHpyCsbVnJ7qCmn06I=;
        b=XC8I27DaIFUE2TqYesvbpjH/OTa7xVtdLGZRNUmw0uRzSymB2GarNXTEmXkXb2TmEh
         WWN4T4hMamX1ZYZ5oVwFbQCQZHVSX2zIruVLmvdruBSEKs1JOEIhTZgRxf29aNjtzYZ6
         85JbfnDYeFKQWxHfAhkGEsbrO2YDlhFCNByhR7HbY5VjX7dIgd9SKbQmdvpIMDDYp35D
         d2OfuhFMEhvX+6zwg1lcgHob++Y3Ts31Leb/S0NKuV4/Gf7eerodsBbFB4i3/+VfWx+0
         J7Ln3I4bv2FP/n2Y5kD02zkAZztiva8ILBxsT5xo1FX4Q4iDiiRjT23o2JBPKaqwyB3F
         lawA==
X-Gm-Message-State: APjAAAU0H8tZo/Qi7LwoBOiH6W/CBgrlv/zQmRY6q28Ugdh6A9GcdhQs
        1HN3ddnp9TtQJANUmcfVWqM072niWQL8uOHpt4s6pQ==
X-Google-Smtp-Source: APXvYqyaFpwCvR69VYC8/ykUdCcsiY0n/Wl+3VXRvyGeSsvNK7tiB2LFHcEJ1pC1YTFo2DrJ2RorDquj9/VONxHhZQo=
X-Received: by 2002:a1c:660a:: with SMTP id a10mr15433416wmc.122.1581340702065;
 Mon, 10 Feb 2020 05:18:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com> <2786a6bf61d732570335f181540b0d1f7dd47b13.1581029756.git.gitgitgadget@gmail.com>
 <20200206234921.GE6573@camp.crustytoothpaste.net>
In-Reply-To: <20200206234921.GE6573@camp.crustytoothpaste.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 10 Feb 2020 14:18:09 +0100
Message-ID: <CAFQ2z_MuEeAp9p=sP+59jVN6LOrv1+BpMk5YYYnVrf8iACeGgg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] Reftable support for git-core
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 7, 2020 at 12:49 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-02-06 at 22:55:56, Han-Wen Nienhuys via GitGitGadget wrote:
> > @@ -403,6 +417,10 @@ int init_db(const char *git_dir, const char *real_=
git_dir,
> >               git_config_set("receive.denyNonFastforwards", "true");
> >       }
> >
> > +     if (flags & INIT_DB_REFTABLE) {
> > +             git_config_set("extensions.refStorage", "reftable");
> > +     }
>
> This does seem like the best way to do this.  Can we get an addition to
> Documentation/technical/repository-version.txt that documents this
> extension and the values it takes?  I presume "reftable" and "files" are
> options, but it would be nice it folks didn't have to dig through the
> code to find that out.

done.

> I wonder if this might be better as --refs-backend=3D{files|reftable}.  I=
f
> reftable becomes the default at some point in the future, it would be
> easier to let people explicitly specify that they want a non-reftable
> version.  If we learn support for a hypothetical reftable v2 in the
> future, maybe we'd want to let folks specify that instead.

done.

> > -static struct ref_storage_be *refs_backends =3D &refs_be_files;
> > +static struct ref_storage_be *refs_backends =3D &refs_be_reftable;
>
> I'm not sure why we're making this change.  It doesn't look like the
> default is changing.

This is adding the reftable backend to the ref_storage_be linked list.

>
> > @@ -1913,7 +1916,7 @@ struct ref_store *get_submodule_ref_store(const c=
har *submodule)
> >               goto done;
> >
> >       /* assume that add_submodule_odb() has been called */
> > -     refs =3D ref_store_init(submodule_sb.buf,
> > +     refs =3D ref_store_init(submodule_sb.buf, "files", /* XXX */
> >                             REF_STORE_READ | REF_STORE_ODB);
> >       register_ref_store_map(&submodule_ref_stores, "submodule",
> >                              refs, submodule);
> > @@ -1927,6 +1930,7 @@ struct ref_store *get_submodule_ref_store(const c=
har *submodule)
> >
> >  struct ref_store *get_worktree_ref_store(const struct worktree *wt)
> >  {
> > +     const char *format =3D "files"; /* XXX */
>
> If the question is whether we still want to default to "files" as the
> default, then yes, I think we do.  Suddenly changing things would be a
> problem if for some reason someone needed to downgrade Git versions.
>
> Since we have two instances of "files" above, it might be better to
> create a #define like DEFAULT_REF_BACKEND or some such.

I did this. I stuck it in refs.h which is probably the wrong place.
Suggestions welcome.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
