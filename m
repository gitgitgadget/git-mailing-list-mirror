Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD705C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2D82082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1Z6t+lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBDUWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:22:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50927 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBDUWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:22:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so37625wmb.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Av6P0ZDfXRFjapcrsTF8dIv2tAw9sWy+glZKrXtPZ64=;
        b=P1Z6t+lgjY/L6tonGuYb3c8XnBd8Gyjh9iVYMbapha3QwVE87Zfp9GZlRUu8wQHJK9
         DRZgyTnkpXZCdOF4Ih/QjLpqd/idHQVSJk6hZmTS08NPehftF4lWAoZF/IZ/9rrLO0vC
         7Zc1FP4dCqQKrQy8qZhAt6fOAUhYbUu2z2R6HXF2VbYHO4GBtdaCkq/897QGKgFhjU1A
         vAG3WzbNkUqfSqSrDDqEW3o8OML6Q4uDbkU7bIO73CgyVbOgA0u/JGSk1CWhrJAG4++r
         CYQ6NoGTZDTftjecrLZsRUXHrboJXdbZyTb3lZ3n04xlddwnOI8wEE5dqvICE8N+oeK6
         fEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Av6P0ZDfXRFjapcrsTF8dIv2tAw9sWy+glZKrXtPZ64=;
        b=IKxCbLTW8InLiDdpNUwpebYRWzEqEW8Jm/9CMRkcHpEQV3qXD7MQTEOhuTKp4NHCco
         1VEjCt+pMXg9D0uMmzDVQSwwwBMBuZBZqH88ESTC2XpP0u6oVQg1gb+3doa2rrTQiteu
         SFgFArwpzI/FbBzRTZzFPq/DGu740nzZy1blj0lXbnv6+Dyu6CZsOlOaW20v9S70XZvc
         fr3sej879WtOONrHVT1PTbOl9ecOXfCTu856C8jPVg3LSO7UguhpqWaVVT4ScOzNBLqL
         prJgkukjAmbTx7n0Cj5/YVz+YjLAoDyVwANKkYG9harLE426ctBfyKFVRT7BfxIGG7IX
         734g==
X-Gm-Message-State: APjAAAXvUg+PdGWrZpVGCucfPJKw6QeFoiSpifzE3dmbIQhRt65AqXIN
        vQtjgV36MjJ75y67SLvOvKxVFZgQocX+iW/rfiVYcw==
X-Google-Smtp-Source: APXvYqyrxvv3ljjIrfjc5HpjAItCXmkvkFhJ4N0Lk6UqdEhvDuq741G1BQtSUQdTuP3qjsa/SX+M84TimN/5k3wpf80=
X-Received: by 2002:a1c:610a:: with SMTP id v10mr762780wmb.44.1580847769635;
 Tue, 04 Feb 2020 12:22:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com> <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net>
In-Reply-To: <20200128073100.GA563058@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 4 Feb 2020 21:22:36 +0100
Message-ID: <CAFQ2z_MZcYEDkyKENE+eRLAQCXObqqaypHvL_coHrecoxp655g@mail.gmail.com>
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

On Tue, Jan 28, 2020 at 8:31 AM Jeff King <peff@peff.net> wrote:
>
> >  {
> > -     const char *be_name =3D "files";
> > -     struct ref_storage_be *be =3D find_ref_storage_backend(be_name);
> > +     struct strbuf refs_path =3D STRBUF_INIT;
> > +
> > +        /* XXX this should probably come from a git config setting and=
 not
> > +           default to reftable. */
> > +     const char *be_name =3D "reftable";
>
> I think the scheme here needs to be something like:
>
>   - "struct repository" gets a new "ref_format" field
>
>   - setup.c:check_repo_format() learns about an extensions.refFormat
>     config key, which we use to set repo->ref_format
>
>   - init/clone should take a command-line option for the ref format of
>     the new repository. Anybody choosing reftables would want to set
>     core.repositoryformatversion to "1" and set the extensions.refFormat
>     key.

I did this, but are you sure this works? Where would the
repo->ref_storage_format get set? I tried adding it to repo_init(),
but this doesn't get called in a normal startup sequence.

Breakpoint 3, ref_store_init (gitdir=3D0x555555884b70 ".git",
be_name=3D0x5555557942ca "reftable", flags=3D15) at refs.c:1841
warning: Source file is more recent than executable.
1841 {
(gdb) up
#1  0x00005555556de2c8 in get_main_ref_store (r=3D0x555555871d40
<the_repo>) at refs.c:1862
(gdb) p r->ref_storage_format
$1 =3D 0x0
}


I'm sending the revised patch series now.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
