Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F420CC43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3F621789
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 13:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d134pmNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgIUNNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgIUNNS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 09:13:18 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA54C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:13:18 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id r78so3325109vke.11
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8p3NgRfOPl4joetDFzo7bm1QgUjJmJzmd8iKEU1/YhY=;
        b=d134pmNcQWiG6nm5bvaARXfD377SJu+SbhV+EvHW/ToA4J2sCVdkFjwbgskoZW4mpP
         EujHnLSHhkrXaYF43BK8TJruZJx62a5OHTw7/Oar+909uOD/uy5NZg1qn4V2DFSGpWuw
         1J161L6A0ghXeaSY5Hnaep3Xe9TMH5yxNpBgkujA5cvsaUIpaS2RdzLbefFIplF9otEX
         nT3sKFeT6LCVgegHz2SUeSvpVGcy8uiEJoDw6mIRVmONttCnB+vC1Pj6PKTxh1iisP+F
         QRNbUGeBwv5oWyOGJnD0CNurqJj0HGAJCu0CIuCs9x+CMElqBZvrv3OdDKCXylqe37Y1
         sivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8p3NgRfOPl4joetDFzo7bm1QgUjJmJzmd8iKEU1/YhY=;
        b=RdTIrgJC/nM7PKZ6VFUThgJLpdBKqQcN4hoPprV5NyCzV2reWGH+gbo2Uiph4RrJlQ
         8eLSb2dIVi4O5yh5mObJ0hGGkNxvJzrqhhUE4zaA+VdPinP0c7WX8XuWnQSVnhOvyPET
         qeJMNiRQDb+7/5zTrdDCK30HPgU2qv+oTQ4+BqsTLcqDc8Pm3NHaMdx7Tvu+I2Lq8lZX
         /bTVrS9ibz+EkqRyVRsUJRthricIUgmPCEQSTnS+LuqV5Ukl1k6WipgzZmTR1h4Wy82B
         n3eW48J3f4rx5hVN1fSvaUUbm4ECj0bjTtgzBY6cllJz7AyiO5AWJDPtpywyJrmWM+s8
         Lx5g==
X-Gm-Message-State: AOAM532M9ewN9uAw71KxehAu3qeyfPJYK8fasKTrO0doA9VPNU1yBeMl
        ZMHTY+ve+s8gbPbd5U4inqR/V24Ho9B+aRAFZclCwR5tbzjYJGT8
X-Google-Smtp-Source: ABdhPJy33JdMWx/t+7pW+kDsm2EefyOsKP4SmZ3hLYZ8swyJkQ9QfBOMzFHpabTIN+9CGdPsYrHY1WIPfZj61Yy35ew=
X-Received: by 2002:a1f:fe4f:: with SMTP id l76mr17759186vki.19.1600693996924;
 Mon, 21 Sep 2020 06:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <791f69c000556e93bf5fcfc0ec9304833b12565b.1600283416.git.gitgitgadget@gmail.com>
 <xmqqlfh5i7nk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfh5i7nk.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 21 Sep 2020 15:13:05 +0200
Message-ID: <CAFQ2z_M9uBc+VArOVXg-hwTY8bu-gQQSL9JC6TJ5MuTCtxx=EQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] reftable: (de)serialization for the polymorphic
 record type.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 20, 2020 at 3:00 AM Junio C Hamano <gitster@pobox.com> wrote:
> > +static void reftable_log_record_key(const void *r, struct strbuf *dest=
)
> > +{
> > +     const struct reftable_log_record *rec =3D
> > +             (const struct reftable_log_record *)r;
> > +     int len =3D strlen(rec->refname);
> > +     uint8_t i64[8];
> > +     uint64_t ts =3D 0;
> > +     strbuf_reset(dest);
> > +     strbuf_add(dest, (uint8_t *)rec->refname, len + 1);
> > +
> > +     ts =3D (~ts) - rec->update_index;
> > +     put_be64(&i64[0], ts);
> > +     strbuf_add(dest, i64, sizeof(i64));
> > +}
>
> We seem to be getting
>
> reftable/record.c: In function 'reftable_log_record_key':
> reftable/record.c:578:2: error: dereferencing type-punned pointer will br=
eak strict-aliasing rules [-Werror=3Dstrict-aliasing]
>   put_be64(&i64[0], ts);
>     ^
>         CC reftable/refname.o
>
> when this series is merged to 'seen'.

Thanks for bringing this up. I did see this before, but I've been
unable to reproduce this locally, and I forgot about it.

The problem is actually triggered by the Git-provided put_be64()
(which appears unused in the Git source code). The definition

  #define put_be64(p, v) do { *(uint64_t *)(p) =3D htonll(v); } while (0)

is trying to reinterpret a char* as a uint64_t* , which is illegal in
strict aliasing rules? I originally had

+void put_be64(uint8_t *out, uint64_t v)
+{
+       int i =3D sizeof(uint64_t);
+        while (i--) {
+               out[i] =3D (uint8_t)(v & 0xff);
+               v >>=3D 8;
+       }
+}

in my reftable library, which is portable. Is there a reason for the
magic with htonll and friends?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
