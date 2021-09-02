Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73256C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FF16101A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245466AbhIBJ1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245455AbhIBJ1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:27:11 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3CC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:26:13 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id u1so879442vsq.10
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fSU1P+b09L3uGS9cCziEMGBliLr4QpZMsnJGkdgzA1k=;
        b=Cir9KIhK7VeTnLXu9cqFnpcSs8M5xKmIBJl4MloVRM9zPd+Wb5w85o7tgx0jTiPs+y
         tnUR1gD2/qFkUF/jpDMnXPQCoWuzhGINfWAS2jcTHYtVDU+DwXy4MnYX9P5S/8w6+3FM
         WjfkArO+bRwdCAYpzJbUMYm8RVjW3STYeOsC1cdf4tOp+VPVFu/Id8TiE5q/FU+sxpuC
         s4QCh53dR1PfA5yppj7lMP3gQ/w/Xs8lSkZy3PksoGiBmgc59izQHvmJ8AAzCJXK+PCx
         WDwqe5Es76wXbJyrA7kJ14HLoL40M7s6vz94xBeAam+dDaYUbmynrXifaNFZsWD6nSXC
         Wgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fSU1P+b09L3uGS9cCziEMGBliLr4QpZMsnJGkdgzA1k=;
        b=U0X9y8p5sFs9DFII7kKWYAIf0wtOHwItqyRTJQYuKCEkrz3yDiAoOMalbpeJFMY0Jf
         98sagpU2TB6+SyUuxB0CMKzr/DBj6ocJiTl/U/m/vlkhvllWC4FqG8A2V1ThBwqWn86x
         P+74Ian2N9cAbRLw0NTwesFUaEnqMTy6b7Cq5iCC1+pAdCP/+tNohXPQ93jmwi7UdkR8
         t1pcznYrCQnaPh5SvnuRv3QrNF/gOaNqmsmPQ+ztdDcMGaY8tpnukyBWuZd/W8cMLhJZ
         T/j1nDWjPXgjWj+vy3NnnvJgO0Z7eE45con/hIBUmK9RHgvB4kvT9hsHenigBKZNZ7s2
         D+PQ==
X-Gm-Message-State: AOAM532KYT+P4vv6br59nT0nIqyZH3b+yJgiyLaNGg7cThgpdjsDSwo7
        U9ctbISXCN8RKFBNMjlGbDBNJ5ygu3YPrS3PR9uogLnPTfk=
X-Google-Smtp-Source: ABdhPJyMKLo9RFMpB1rvF1770eYuGSiNXJCkP/pPrknv0gQG35LzY5CyzGIGVf7UpYyC0tYwOxSa+IhKFE7L3cmkAaU=
X-Received: by 2002:a67:ef51:: with SMTP id k17mr1133397vsr.2.1630574773006;
 Thu, 02 Sep 2021 02:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210902053023.44006-1-carenas@gmail.com> <20210902053023.44006-2-carenas@gmail.com>
 <YTCTyzfIQlme4xee@coredump.intra.peff.net>
In-Reply-To: <YTCTyzfIQlme4xee@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 2 Sep 2021 11:26:01 +0200
Message-ID: <CAFQ2z_PK20PTsHsK8A0-vdmFLNSxRMP3_Kn0rQmZViiGKzGV+w@mail.gmail.com>
Subject: Re: [PATCH 1/3] fixup! refs: RFC: Reftable support for git-core
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 2, 2021 at 11:05 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Sep 01, 2021 at 10:30:21PM -0700, Carlo Marcelo Arenas Bel=C3=B3n=
 wrote:
>
> > need to reorder the variables to hopefully make it easier to see why
> > they might not be used since assert will compile out itself with -DNDEB=
UG.
>
> This should probably lead with the reason for the patch (avoiding errors
> with NDEBUG), and then mention any other bits (like "we also reorder for
> clarity"). That makes the point of the patch easier to see.

Counterpoint: I can see what the problem is (thanks, Carlo!) but would
likely fix it in a different way, so effort spent in polishing commit
messages will be wasted.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
