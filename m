Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5366EC47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E72120775
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="unsHuKBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD3PMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726419AbgD3PMb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 11:12:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FBEC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 08:12:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e16so2248489wra.7
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y0xkjPjq40qZCuInu2fgjElV58EVxHktYy+nUNS17/Y=;
        b=unsHuKBxLrWP1JCFwU3rzSjpvR3iBU/QCs+BdrekhgmnBXKsAPOpln6mkOkDA6gbzn
         dOdGfqNrJuJuHSxIrU/kQywjEBXragmzriSkzxM7oO7dSvYCHUd7Xu7kt7Y2prX1M09a
         xYwvfb7LAZFutZOzJwMIAfZ1xz7iZSC3Gp8B9Aj2F9sTFDfAwDnN06d+YqxLi4l1qieP
         sh7ut3ItMt7Co4AnpqUZtkvnsetlOk3eKLEe/oHZuvC60rj51ZHfUWEWRQHE/t9ot6Yx
         0QzY1NSuusX+1uCzFB4dVpYdKH2A6mGcteSFXmrEWSmnyob5v/MJ/AjarOfF8CWOeqLo
         zbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y0xkjPjq40qZCuInu2fgjElV58EVxHktYy+nUNS17/Y=;
        b=jNtYIySIyQ8zQ0IuU/Cy9tiRCgk1YtTeRHQQPak+waXtjGMWqst0GWVQseyGTuNHn4
         +0fG5NJS0m66ykXrTYICLkfK3klUOKE4eVOXCli6158H5DtBRgmv0/0hbCrAXRY02awC
         h7UGYYaaL7XBy/+Nx5+MX9YZMojx6Sb/7uTFxOZTnYd7tugTEHnfnm4OEEjoGpd+vRGU
         BmIxqeX4unPNIHS1YU0I7V+gSHl9lZ6jGaO2U7ZNh1hxjHP8BVar++pKQt4TvzGrun8n
         ZrcHFEd5dLYKQztBx5lhAc7LYsqjidPu/T3bSj6lN3dNGKLCcWVCN4RszdkJfmQSvEtF
         rLLw==
X-Gm-Message-State: AGi0PuZOR12ipouB4qdEjaonUMhG+mte7EJBYyRj1MmEx/WUu+5IAHt7
        yJaVROTt3Z+XWO/x0+mU1Qt32onYbpBpydxSMX7Z5w==
X-Google-Smtp-Source: APiQypL4Aww1xt31ZWGL0avC+RaZ5G5xealDcrjr5Ctfx4gTsoSgfVEAsnZTN3l6kTNoT8kEfzsQ7HnC6Ap+sxLD4wk=
X-Received: by 2002:a5d:6a91:: with SMTP id s17mr3193439wru.6.1588259549546;
 Thu, 30 Apr 2020 08:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <fda6d0db-f79e-f44e-7c2b-b60ed1794cd0@gmail.com>
In-Reply-To: <fda6d0db-f79e-f44e-7c2b-b60ed1794cd0@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 30 Apr 2020 17:12:18 +0200
Message-ID: <CAFQ2z_PP9Ld+GDctV-v2CDKFamF6zKdJZ_-jhahj_fcm3wy4Hw@mail.gmail.com>
Subject: Re: Git Test Coverage Report (April 30, 2020)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 1:22 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Hello,
>
> Here is today's test coverage report.
>
> It appears that _all_ of the reftable code shows up in this report as
> untested. Perhaps that is the state of the world right now, or perhaps
> I need to initialize a GIT_TEST_ environment variable to ensure it runs?

> In either way, do we have any test coverage of that massive contribution?
> Please take a look at the online report [1] for that part of the report,
> as I snipped it out of this email.

(again in plain text)

The reftable code is currently exercised in a small way by t0031-reftable.s=
h

The upstream library has unittests, see
https://cs.bazel.build/search?q=3Dr%3Areftable+f%3A_test.c&num=3D0, but I
believe Git doesn't do unittests?

I'll try to generate a coverage report for them.

You can set GIT_TEST_REFTABLE to see coverage for reftable, but I'm
not sure how useful it is given that ~15% of the tests fail.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
