Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11785C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11A520809
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9c8FDAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgLALLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgLALLM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:11:12 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C32C0613D2
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 03:10:26 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id u16so337617vkb.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Aqtwzq5BemVUGNUP5RyBwytY0JIZkCss0EBQtIgx2NQ=;
        b=c9c8FDAP6H92oevgIsqjVoa11gSH4KtBuJDwyHUeNrqoFwv+LJzDxRGmUrX3diY+Xp
         qswNDOPjtIhVqcXIfefK5dMV1ygpWPKBYfZn2hd0+oEvw8kKNtfB7QDMf0MMH8e5+/tI
         8I+lUI+6VTa6EmiliujziA0IvmhS6B4db2bKIEaPhTcdEZSZ2f/4XgWRWnB4hSoHFGLH
         U4hgTkwKdx0B+jR76vSovLS8V3OBVsmT3L/eEpJeFSvOqUSlg8Yb0yLgAuLNjS2OMCA3
         UcqdVmiKMM0GpRjyyzw2rmqUeYORlCYS3HzqAx5XdyauwA5Ogc77mkhw0SfBxs6G0/SJ
         1Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Aqtwzq5BemVUGNUP5RyBwytY0JIZkCss0EBQtIgx2NQ=;
        b=oQK91FomCc/kftYooue+OF8eKV1DIG3JMhP2qImNADquyBXwJxhX80XD5TMP36WP+A
         oieByYniCiXxCY21i8nuOOGV113wnM+pCZi+Cf8ynblPHDlFdIXItiOGKPJeKiUF8dga
         GlnovFXIBJ/UgLwRKKTqfGrhVibL4kOrCkJersG00BHGgqHZfA+9piyXyxMXZAY8RtUa
         gMk1VIP+8kPVf2Wpvd1uQQyCdxXwdKOTZr+R/eWLN8hdTUnWzcO1j+T6IEK8joV3SQiG
         zCgbvS7id0IEjLInHLmDjhjwa/r76hvF0T8h0qWQj7JJRpHFSEt9/FyxRX6ZBvzErZIe
         wl9g==
X-Gm-Message-State: AOAM531AyHZGDdTBb/MzS+InfZoQjenE379deVxHrlUmHbZ+Rx28VTP1
        Ioum7RhXJDzSN2ajgbaEgsJYXbz3cKitlwBuPYGCjQ==
X-Google-Smtp-Source: ABdhPJxf+muedVxxhA5DcTRDJuI68+kPjR+FfUK9AtNP3emfmnjgFOGKtKevwl3qfJ8+7WerIndzL9SGauBsxO2SbUs=
X-Received: by 2002:ac5:c55c:: with SMTP id d28mr1600394vkl.19.1606821025257;
 Tue, 01 Dec 2020 03:10:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <58f2b0394546e8da2922adcbc38bdb6b53f2b313.1606545878.git.gitgitgadget@gmail.com>
 <X8YaWySkyRU3DA87@coredump.intra.peff.net>
In-Reply-To: <X8YaWySkyRU3DA87@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Dec 2020 12:10:14 +0100
Message-ID: <CAFQ2z_M3C=mCkiPxOLhBSrXR-PDQdb7GLPRWM2egV4cO4a-c0w@mail.gmail.com>
Subject: Re: [PATCH 3/6] fixup! reftable: rest of library
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 11:26 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 28, 2020 at 06:44:35AM +0000, Johannes Schindelin via GitGitG=
adget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > 0-sized arrays are actually not portable.
>
> Definitely.
>
> >  static void test_sizes_to_segments_empty(void)
> >  {
> > -     uint64_t sizes[0];
> > +     uint64_t sizes[1];
> >
> >       int seglen =3D 0;
> >       struct segment *segs =3D
> > -             sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
> > +             sizes_to_segments(&seglen, sizes, 0);
> >       EXPECT(seglen =3D=3D 0);
> >       reftable_free(segs);
>
> I think passing:
>
>   sizes_to_segments(&seglen, NULL, 0);
>
> may make the code more obvious. Unlike system functions like memcpy(),
> we can be assured of whether our functions avoid looking at a
> zero-length array (and size_to_segments does follow that rule).
>
>   This function, of course, is nonsense that real code would not do, and

This test was added because 'real' code did this. In particular, if
you initialize a stack of reftables, the stack has zero elements. The
test was for the following bugfix

https://github.com/google/reftable/commit/b2e42ecb54e413e494c1fcc13c21e2442=
2645007

Changing the array size to 1 here also prevents Valgrind to mark a
regression as a OOB write.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
