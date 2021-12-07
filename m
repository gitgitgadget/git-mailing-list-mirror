Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF8C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhLGLh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhLGLh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:37:57 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488AC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:34:27 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id t13so25812320uad.9
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EMgrg/4hHks7uondpqx0yiWkbhwTqA9hijhpzwjZExM=;
        b=aO4UYjWyDqWpcEYGT23jTMvvCNQ5mNgaYxnvCtQYxV5IpFnt1uMoEHAvjd2beFOL0t
         JaEsdHXxM/llhtqOsKlOlXk7h0FVxLxE+Hl9QkoFCdnyBvLF08XvHHHZyE2NcrymUw9q
         /e/KyNA2+KJctz2WVDiAbmTScJf8JXnXh/6n1G+ia79KxLdE3lcMmUcvmz6RxGH0e8ey
         YKXh111NArp4kaU9ViYooWIlkOs0ALZLES1khtPd6KwpvYNgtTj3uUTjNCPC5ad0YV4g
         7qWY9e6pIlyEptr9AOvmIRwf1v4IREGpfY4afWtjsE0Jqh+62f30/36C4Gscf5b+HGhB
         wmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EMgrg/4hHks7uondpqx0yiWkbhwTqA9hijhpzwjZExM=;
        b=CWK9/866vV6ka+lwfBWmXhI3Sv6tzwmadq74hzvy1nTPifzabF04I8yWGa2l8rVp/D
         3gjO1KdtrY07YCu+PxMLvtVofHcvAy06mOcrWIm53CO1fBWo8IkrxrlxcQXn++JVvaiI
         tYp1i1Mhj4gHGcglg06TgZ7LJzsjbcAgznFtDsKYfP+mWyTLgaSWijQzICCkJZeLNWpa
         b9beCf2SKfykGKWbPQDLIKcv7CMNjKELC8uidnWwah+H8pd/arOipHzZYHTXwuHy4OZE
         B8N3wDKNHgY11L4FzLTGN7Ynv7sc+pDGuOCsh1JWLa5rsRfTn51+urdnlpLI0XRbFaUw
         92tw==
X-Gm-Message-State: AOAM5305cpsnwVneLTVLs+EwProZ8x5EpMPbJsd0eUg9NzklRDGwyH95
        Ela/imdR4yWj5m9eFPOWEoPQYCKGgdyg+gcysZEKWJ4vrAs=
X-Google-Smtp-Source: ABdhPJx9+6Zf4dLvyjqd+iKRlQzBJ3RL19hCM4lGm3KPLe99cV972ciihN+MBZlKZIeFLENADsGQLplWh6LcCDTvyMA=
X-Received: by 2002:a67:cd19:: with SMTP id u25mr10352732vsl.70.1638876866101;
 Tue, 07 Dec 2021 03:34:26 -0800 (PST)
MIME-Version: 1.0
References: <YarO3nkrutmWF7nb@coredump.intra.peff.net> <CAFQ2z_OK5949p1WfovJ00Katk5hTv_oeLo-ZRCi1XqrtzQqL2g@mail.gmail.com>
In-Reply-To: <CAFQ2z_OK5949p1WfovJ00Katk5hTv_oeLo-ZRCi1XqrtzQqL2g@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 7 Dec 2021 12:34:15 +0100
Message-ID: <CAFQ2z_OrN+RkwnMyrJHdh5xN6ueOP8KKBVQ7-U4kEkA3ApcuNg@mail.gmail.com>
Subject: Fwd: coverity problems in reftable code
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 4, 2021 at 3:13 AM Jeff King <peff@peff.net> wrote:
> We're not doing project-wide analysis with Coverity right now, but I've
> been doing builds of my personal repo, which I usually build off of
> next. And since hn/reftable just hit next, it got included in my latest
> build.
>
> It came up with several complaints. Some of them are dumb and can be
> ignored (e.g., using rand() in a test harness, oh no!) but I poked at a
> few and they look like real issues:

I fixed most of the obvious ones.

>   - A lot of your structs have vtables. Initializing them to NULL, as in
>     reftable_reader_refs_for_indexed(), leaves the risk that we'll try
>     to call a NULL function pointer, even if it's for something simple

I have the impression that coverity doesn't understand enough of the
control flow.  Some of the things it complains of are code paths that
only get executed if err=3D=3D0, in which case, the struct members at hand
should not be null.

> I similarly wondered if these polymorphic types could be using a union
> within reftable_record, rather than pointing to a separate stack
> variable. Then you could initialize the whole thing without worrying
> about intermediate NULLs (and also there's less pointer chasing and it's
> a little bit more type safe than a void pointer). But again, I don't
> know the code well enough to know if that would cover all of your cases.

This is a great idea. I've made a change that does this, which I will
post shortly.

> The summary of issues is below. You can get more details on their site.
> I _think_ I've configured it so that anybody can look at:
>
>   https://scan.coverity.com/projects/peff-git/view_defects

Alas, it says I have no access, even after I logged in.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
