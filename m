Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49780C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 11:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281EB613AE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 11:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhFILbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 07:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhFILbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 07:31:40 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A30FC061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 04:29:46 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id c1so6217721vsh.8
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+tL1aYRQ1hQiSOGPPKB3+zvTJ4oqAfmphEMQ0tLZjTs=;
        b=pyGNV5FsMpTESPbPOO6lQg/+JGvfgAOQ3qhGAhQDwo85EqmxWDK0VWVM6S4a8vXEag
         WWXJCiORoyc9DhTAjMWfgkrNPCQAh/eBQvee+D/EIrM1mjsxNk9ZfiD2t469eEigDs/f
         2cbrW55kQ+4nHGPOSNZrbKZDX4svkxW3wbXuqKfWpmtKd30OFnMBcuMZR1lkaXDBsLyL
         8LJkY1WfB9AlzazpN/isdhHpJTMEREFvxjvno1et39iTrkgTgrJuOi6Hj0jHhG/JhQlH
         MM5rHHPHL3d279EuONUHE/ealhWnrhN0Mi7ISFUk/1WZAQicdy4vRpypRYwyTEgQp7qA
         +sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+tL1aYRQ1hQiSOGPPKB3+zvTJ4oqAfmphEMQ0tLZjTs=;
        b=CqwIcriaZuzESg/5U5BCjKOgKyIpC2sfQTUrJ5bxJA3TY/imPM+unKkJ85dNgHSx5Z
         ffVAST1RmmlrGplwdYRARJzsX5B9+sWExKjDG4tXXVf3bb9hunBEs9yVUKmiTAy31ocm
         OCRPMRCfCPaEKa0BD0pSVgiT4BPHQY4PghLe13ZtRIyBx6A9CPcvn6n6KElKKc7D8lx8
         as76o+XJOCPH979NW2fBLVN4amMV2wygHRcGbxIrwX7JjRJkKvOh/aYlYdv1guoV1BMC
         0pvrnpRP+de/wJ5jSUOSSwbm/kMdgtF4yLvNEf16TmrZxOhWZ1SFL6J6u0arvkzlWCit
         56Hg==
X-Gm-Message-State: AOAM532yTNg4c/LEByFEluNSWI4yIWMPqRQC1CbFydfPq0OqMXnupVIH
        +Xkg+MGDU5x+/zLJ8Ip5ZjrDc5XHglv3YYGoFgCY7Bgocq/RCQ==
X-Google-Smtp-Source: ABdhPJyohqbmAcyxVtBr9jGWFH5UUNb/DGoGZn1Drzeggu/zDki1lPYqJMKIK24Ci53Cz/klT3xukcHALmbkaHmnAik=
X-Received: by 2002:a67:f5c5:: with SMTP id t5mr4306403vso.50.1623238183592;
 Wed, 09 Jun 2021 04:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com> <20210603021356.342665-1-jonathantanmy@google.com>
In-Reply-To: <20210603021356.342665-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 9 Jun 2021 13:29:32 +0200
Message-ID: <CAFQ2z_NQSbshLSstkBM9OZ7XWvydSQ=x0GCHj0a8mf1OC4t2jw@mail.gmail.com>
Subject: Re: [PATCH 0/8] refs: cleanup errno sideband ref related functions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 4:14 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
>
> > v3
> >
> >  * remove errno as an implicit communication mechanism from refs suppor=
t
> >    completely.
>
> Looking at all the patches, it seems that this patch set is about
> functions in Git code that set errno themselves to indicate the category
> of failure encountered, and instead of setting errno, we want them to
> transmit that information through an out param instead. I notice that
> the cover letter talks about "cleanup" and "remove errno", but that
> could have been explained in greater detail, I think.

What is the right place to document these considerations? The data in
the cover letter doesn't end up in the project history, so it seems
like the wrong place.

> As for whether it is a good idea overall, it could be said that errno is
> idiomatic in C and writing "if (myfunc()) { store_errno =3D errno; ..." i=
s
> not much more difficult than "int store_errno; if (myfunc(&store_errno))
> { ...". But presumably Han-Wen thinks the opposite, since he wrote this
> patch set, and I'll defer to his opinion on this since he's working on
> the ref code and I'm not. Besides that, having the out param is more
> explicit (which might be better) and permits chaining of such functions
> (e.g. "if (myfunc(&store_errno) || myotherfunc(&store_errno))"). I'll
> review this patch set as if this is the approach we want to take.


it's certainly idiomatic and easy for writing. The problem is that it
makes reading code much more difficult: since all of the code has
access to errno, it's hard to tell which code depends on certain
writes to errno. One signal of this are the extensive discussions in
this series about how to argue (in the commit message) that a certain
code change is safe.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
