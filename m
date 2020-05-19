Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E3CC433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 13:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2162620829
	for <git@archiver.kernel.org>; Tue, 19 May 2020 13:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkuorjT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgESNy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESNy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 09:54:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063CC08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 06:54:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n18so3674400wmj.5
        for <git@vger.kernel.org>; Tue, 19 May 2020 06:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wes/rhbyQ1C9gNeX/5+sbDobHZBtEm/tK8R8+oL/7ms=;
        b=rkuorjT0BJPvibEtBIiN/+BMLvEYFRvJRpvfcGxL/0kAP7+fF1UEV/SIPDDlqJKGaR
         G/sAIAjxm+xeAlu5Qgu6cxpZkgQUc2A+50uTEXG5jxPWabSul3x+kGAOWzrOYeshdEAL
         j+4biS3UQoZ0fRSw+xiwKv74P2Vn0U8AegBIiY+EncKVOiK4vSckQSnJBJgCO8J98Je+
         fuEI3iYH6/JYYkxpSma+1z9xDag/j7FIXVw5W5kPKwIE23C7NyFYzQYzsbbIIJE/mC4n
         D3nI3peVu3DGfKYE44Cnj3RmRR8JX3ozjZKHvhpDj2E0RkF7jIqfn9ArmwDmPV9lNNUo
         C8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wes/rhbyQ1C9gNeX/5+sbDobHZBtEm/tK8R8+oL/7ms=;
        b=eGUeIGlQ2W2bNOCKq2NEChZBM7RRlbKfhcDKfr5CpM/kwwMF6DWbPzM3Pj/mI/EHjw
         syQLQOeMb7JM9W5TipcDP8Opa7b4EkNg1qWX2wR3Atl+Ef6FM1nyu6NHOcrxScI+/fwo
         vuGJVLKc30UURMXyuBpYTkoXLG/sczwLRBdjfEmaYvPRXhlCiQAMSdB+73lGUf+I9vbh
         i0MFCU33ZDrwcy5lue3KRJUonG2evkcu7WHErfHYuVx1Mtwr27KNWzK9NYsXHMl7xKff
         mbyfQd2UO2cUj1QhpXAGOwUnxvnxZySejUM2LaJz/4zm5f+qDWdjQQL1asZ0fpk8u3iX
         1j1g==
X-Gm-Message-State: AOAM533Z6ba/5x1qvaEDncLXi8xf/cC8DrpjR8X7vn48B3MciwrqZIcd
        +a2eOB7vRCNRA6TKVknNVtR26Ib3ob0gGKjt9mfCiw==
X-Google-Smtp-Source: ABdhPJwCK9ObELTKUkzZwYBQn6Lz+4/9VPJFR2d1HyVrhUgB1SYtlVsLvrfYsC5vQ8qfIedxwZI0F8IPWNhCv5ABHiM=
X-Received: by 2002:a05:600c:22c2:: with SMTP id 2mr5390593wmg.44.1589896466020;
 Tue, 19 May 2020 06:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com> <0e732d30b516855a7e91240a9055712b26905b2e.1589226388.git.gitgitgadget@gmail.com>
 <xmqq8shvtxpm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8shvtxpm.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 19 May 2020 15:54:14 +0200
Message-ID: <CAFQ2z_O3hWEfdyQgH9PrkZcoQUQuaLZWRf0=LY2y93N8aOmEJg@mail.gmail.com>
Subject: Re: [PATCH v13 13/13] Add some reftable testing infrastructure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 9:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index b7053b9e370..da5b4670c84 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -545,7 +545,7 @@ static const char *const init_db_usage[] =3D {
> >  int cmd_init_db(int argc, const char **argv, const char *prefix)
> >  {
> >       const char *git_dir;
> > -     const char *ref_storage_format =3D DEFAULT_REF_STORAGE;
> > +     const char *ref_storage_format =3D default_ref_storage();
> >       const char *real_git_dir =3D NULL;
> >       const char *work_tree;
> >       const char *template_dir =3D NULL;
> > diff --git a/refs.c b/refs.c
> > index e8751415a9e..70c11b05391 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1742,7 +1742,7 @@ struct ref_store *get_main_ref_store(struct repos=
itory *r)
> >       r->refs_private =3D ref_store_init(r->gitdir,
> >                                        r->ref_storage_format ?
> >                                                r->ref_storage_format :
> > -                                              DEFAULT_REF_STORAGE,
> > +                                              default_ref_storage(),
> >                                        REF_STORE_ALL_CAPS);
> >       return r->refs_private;
> >  }
>
> Would it make sense to let NULL stand for "we use the default,
> whatever it is" so that anybody outside the implementation of the
> refs API does not have to care what the default is, and make
> ref_store_init() function the only thing that knows what it is?

Is this your strong recommendation in the form of a question? :)

If it is just a question: maybe. I don't know enough of Git to say for sure=
.

How do submodules decide on other settings, such as the hash ID?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
