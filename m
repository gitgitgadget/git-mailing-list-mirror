Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8332C10DAA
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739E421D79
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 09:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rl8H7gn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIIJoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbgIIJnq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 05:43:46 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA2C061755
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 02:43:46 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id e41so666568uad.6
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 02:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+B3Vz7Rc2kdxZa02hHoNRQtf8bNNM7Fmj5fsMr8IIWo=;
        b=rl8H7gn0NXTm3KgYQxvfM8Gbqxbnqfxm/xpHb+1Yyim9fDBQQDtk7cWUCO4BfTise5
         JyO67C1gQJ63TzxACebm6ONxm7zcTesOIkN76mZQZG9LsTwIW2CAjcxobE8c8zDGYOpr
         QmzR23hRHmahL449E2QJZt9gJSho3LkfPJCsHmv4zSQAKsISpXl1M4EQ2F1lknZ0nlAd
         8YYJ3Rno15+hAt/8iUzvcQq76tjPgnVvXArwcAvpp4fgI5wiFsAV8d2S/6k6BbrvZReF
         oGPFCLtpFU9Zt6cHcyHQVo0y/KVsX07EZXyx+zo4vrFL4MkrKx4kAAYFtNhHe1jF4jIw
         gkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+B3Vz7Rc2kdxZa02hHoNRQtf8bNNM7Fmj5fsMr8IIWo=;
        b=f4HBlvJlG3p7rl1IVZ89FXxoijRw/IkCFjemq299wZIPRCJCLO8IhjH/Jr7KDQdN3z
         QVn8q7Bp1Zo69yugqmnAJ3A8bEgk6/elC5LMKvenmrsKwCoaxwxTlNWprxIaJgbdN0fK
         RkSlhZDSGXFsylN5Gfyrcac92NmWwXv+wMdvj2C0IDsoij+lTZNcszV/W7ySswpuk1uY
         f3tpyEXYWLBNCdXF3ZECFIKH3Cq3LVVKUGEWMtCgPovOARjqOUjhCcQEm0Yhzn6TQbkl
         GiwFwM485IVTHMunZewFJG9ZpKJ8AzYIFSVd8R7YpuVblltGm2OOwg/a65DQCNVLozGn
         Tnrw==
X-Gm-Message-State: AOAM533khV86hfxVx2g5Oe6TTyGyLPkvzH+LxLZdgumaSXzG8mRIzQEd
        6FhIOJuU+FhLCkXj+VIvcyfzgBDTem5WGop4ZyrE5A==
X-Google-Smtp-Source: ABdhPJzHW3kH2gGhlb/mG3YS/j0lrx3eqqWHdEybPvrg14KXhg3O9xcWiPWE47oj+CgKFZ+PHhTNbq7DyGRduJWf5DM=
X-Received: by 2002:ab0:455:: with SMTP id 79mr29772uav.83.1599644625463; Wed,
 09 Sep 2020 02:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
 <pull.713.v2.git.1599492274909.gitgitgadget@gmail.com> <xmqq7dt4x957.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dt4x957.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 9 Sep 2020 11:43:34 +0200
Message-ID: <CAFQ2z_OOCvFH-+FNdPWjQ=vGwgeBdVzMjt8avm6AkX=H81kPdQ@mail.gmail.com>
Subject: Re: [PATCH v2] refs: add GIT_TRACE_REFS debugging mechanism
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 8, 2020 at 11:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> Cute.  I like it.

thanks :)

> > +     res =3D malloc(sizeof(struct debug_ref_store));
> > +     be_copy =3D malloc(sizeof(*be_copy));
>
> Not xmalloc() and friends?

done.

>
> > +     *be_copy =3D refs_be_debug;
> > +     be_copy->name =3D store->be->name;
>
> I guess we never destroy the ref-store instances so it is OK to
> assume that it would not cause problems later by sharing pieces of
> memory with underlying "real" thing like this.

correct. But changed to xstrdup to avoid confusion.

> > +     char o[200] =3D "null";
> > +     char n[200] =3D "null";
>
> I thought we had better constant than 200 (later you use 100 in the

done.

> same patch).  I am not sure how I feel about "null"; all places in
> Git, we tend to use 0{length-of-the-hash} for "no object name on
> this side", I think.

Some functions take NULL as a legitimate parameter, eg. a transaction
update with NULL as old OID (don't check old OID) is different from an
update with 0{40} as old OID. (ref must not exist yet).

> > +     for (int i =3D 0; i < transaction->nr; i++) {
>
> We still do not allow variable decl inside the set-up part of a
> for(;;) statement, if I recall Documentation/CodingGuidelines
> correctly.

Fixed.

> > +static int debug_delete_refs(struct ref_store *ref_store, const char *=
msg,
> > +                          struct string_list *refnames, unsigned int f=
lags)
> > +{
> > +     struct debug_ref_store *drefs =3D (struct debug_ref_store *)ref_s=
tore;
> > +     int res =3D
> > +             drefs->refs->be->delete_refs(drefs->refs, msg, refnames, =
flags);
> > +     int i =3D 0;
>
> No need to initialize 'i' here.

Fixed.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
