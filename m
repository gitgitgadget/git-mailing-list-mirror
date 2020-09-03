Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C11C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519A820767
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 10:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VybpYRlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgICKK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICKKt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 06:10:49 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC2C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 03:10:47 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id t189so655921vka.10
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=h4WiY/AamGf1XASyNbDKNH3IBey4Uom+a7+TQM98w4o=;
        b=VybpYRlLtLldkZcwP1CBRBbqi+LOKUczsRtM6OeMqe47l3pCEfbQAxKvJRfi3h9P/l
         OCYZsuY6Uu1/G1DSRvtWJF5R6EF+RptQFTKvaZvqv93WcbRLNM8OkUidTRuNKsoI3ahP
         WOFV8NXTcQMGH2+kR/WX5PaCQUPCt0GC9rzWvdgPVfxLuabu3KcdzFWp6kafBwAv9PBT
         8gfjy3MhcPR23bzXNcubrR3wwPEUPvdKI2Lgvw1asAdSFsh1XMg4ho+s/8muEmruRhWS
         J2ceTl7FV9P5SXHWP4JmxWzXyAGEScax+eRJDZ/sq4IdoCWg8cuXC9FGlwxb2D/DC56l
         mUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=h4WiY/AamGf1XASyNbDKNH3IBey4Uom+a7+TQM98w4o=;
        b=ZGjZOmXjcMqhPnIL2EPs6DpefswoYT174COQzc8sCMtZ4S0m4mZuQde5XsuKTTC8JK
         e5XLyqSf1DRSZNOJuSc1eU9+bkbvJJ662jDIOOBuLh30oEWPxjXRHd76xWy+s9eK8nZV
         4qUP8kmWU8qrxAvoiwHEfPzDlNNeesDgnQM8y8V1xmTmO5CATZzK1xApo0wSnP+wQ1KX
         7dr5XSi9tlMuYIOIYJrU1ivpfjq83wcVin/9N3wCjOCYW/eW2VwGe/g3NGvTjvziDXjl
         wftBwNGlRC0ZenBHzqzrDVrhXdvP/JpS9sHnY2xl71JumnYzserLWGV95oZm6BCt+FCW
         CI8g==
X-Gm-Message-State: AOAM530HWfq8jdS0qifz1vJ44SMX6GlcHbHNbr3wZVVa1f14L2LnMr+e
        bR7+1CSS4ljbXlajAmJdAnV8NMTovpLye15NVd1vXcsr2Bc=
X-Google-Smtp-Source: ABdhPJzbxwQZ/nEQM+IjCZhRPwIgCvW971Z0tbbFtURVizBdxNmKqx/eKjp3ZZYMAH6HGRUOKja2P/kS3yPYNs9hhNA=
X-Received: by 2002:a05:6122:10ca:: with SMTP id l10mr1056046vko.15.1599127843851;
 Thu, 03 Sep 2020 03:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.713.git.1598628529512.gitgitgadget@gmail.com>
 <20200902174939.3391882-1-jonathantanmy@google.com> <20200903054422.GG4035286@google.com>
 <20200903061931.GA2055118@coredump.intra.peff.net> <CAFQ2z_M_2mmL1LXcgR5cv3Ac1AJ363jaejZz3p6AcV6b3DftTQ@mail.gmail.com>
In-Reply-To: <CAFQ2z_M_2mmL1LXcgR5cv3Ac1AJ363jaejZz3p6AcV6b3DftTQ@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Sep 2020 12:10:32 +0200
Message-ID: <CAFQ2z_P9dRKX-O3MGFWj1TaYciCLHBboP0jAvROYyn5QaPngYw@mail.gmail.com>
Subject: Fwd: [PATCH] RFC: refs: add GIT_DEBUG_REFS debugging mechanism
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 3, 2020 at 8:19 AM Jeff King <peff@peff.net> wrote:
>
> > - if this is only going to be used for tests and for ad hoc debugging,
> >   I'd suggest sticking to the simple trace_key based unstructured
> >   tracing API
>
> Yeah, from my look at the debug patch, this seems sensible.


thanks, I'll rework it to use the traditional trace API.

> As clever as the "debug" ref-backend wrapper object is, I also wonder if
> it might be simpler to just add trace calls to all of the outer
> functions (e.g., ref_transaction_prepare(), etc). Unlike a "real" OO
> system, we're not typically passing around the polymorphic ref_store
> type, but always access it through those type-agnostic wrappers. But
> maybe that would end up just as long. I dunno.

The ref backend supports callbacks, so it will always require some
amount of wrapping. The advantage of this approach is that the debug
support stays very neatly separate from the actual logic, and that the
compiler enforces that we add debug support if a new ref backend
method is added.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado



--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
