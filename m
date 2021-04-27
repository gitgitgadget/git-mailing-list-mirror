Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36DBC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B4661090
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhD0JSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhD0JSH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:18:07 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7149CC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:17:23 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id s2so18451310uap.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aMtcHIJZVmqbg4YaVLn32vIw5yEky1296zTgTbgr45c=;
        b=Ma1cZneWHyffY2LKGrPwAR5UiPP0OKCIqIiRd9vXyQn7V/edno4CxCyGebINEAq+E0
         Lb8mrN/LES/RiYA4Uc/A/Gu2FnRlqx5wXts8vFLhbq2+f4VdSM+91MiJo+ooqJsLwkD5
         USwLcs510WkXHyTGaHn2RMYH0Ic/BbSPJH9d832ZiXTBSjq/qvjbDNXLz2hUoKU62kOr
         bLFwtWezJagAoLONKKCxAYoHm2OHJ9aWsFsqYg3sL3nBy18XQtnlvWvMX4vp/jMZrDhp
         vXsP2eDBMude0ylnQn3CBDfCTCltYdUW2HYC6WMyVLq+12pxp7+NXcD5X/jHqQz4v9dM
         UZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aMtcHIJZVmqbg4YaVLn32vIw5yEky1296zTgTbgr45c=;
        b=POHTp6SBAHRKevfw9x1d0mwAYQTMuuZAgagZnpzNxX2nnF5OgwTSGJI3/41u2jy8uN
         y5F5DKg9pke9Zov0i0ZvtkBoFMgGjfy5FtM+fnBhk+fFBlxcA3S9wdBmmUT1B+p1dXp4
         K0pQuejtUJasNF1CznWzu7Tj3JFWEnQhfz5nAgH5Fl1Gg2gGFISD0vy89mGRIYOLyAQm
         fBihCFHg22Q00Uc+CrFBjGEzKplLfL7i1o8gsoJhJRju2TGh3KB0CVqezbROqdL2e4Q1
         gmOCCALH/1yqyKPN3gZnulxURTr+/7AGTAL/Txu/ZBJdOd5E++3RhmknJJXIV+TGRU1L
         Ov5A==
X-Gm-Message-State: AOAM531lVBp9Cst+9VV0esrHgzDXuqcamdxAtXa8RJIAF2uk3r9RuOP5
        IJ1/bZ0cz/V9HrBuAOs7EnlBmjvRUZRu2hQy7Zeh9Q==
X-Google-Smtp-Source: ABdhPJyRWCYGxYtGk4pUT0NkMgpbQwPBBZbjD4OmpK9skSBxkJ5mV8HjG7HuSI53zpmo+QgXYL3Tghi1mp0WgsDOQAk=
X-Received: by 2002:ab0:2b01:: with SMTP id e1mr16217749uar.85.1619515042379;
 Tue, 27 Apr 2021 02:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <a5b9439192db3ad3c01db0e67cc1f60bad9109e8.1618829583.git.gitgitgadget@gmail.com>
 <xmqq5z0g36m9.fsf@gitster.g>
In-Reply-To: <xmqq5z0g36m9.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:17:11 +0200
Message-ID: <CAFQ2z_NohJhKFXnivWCMOU8KYW4mQ-vgTZhdchJadcCuMe=e+w@mail.gmail.com>
Subject: Re: [PATCH 16/18] t7003: check reflog existence only for REFFILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 12:59 AM Junio C Hamano <gitster@pobox.com> wrote:
> > diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> > index cf30055c88dd..380bdf934317 100755
> > --- a/t/t7003-filter-branch.sh
> > +++ b/t/t7003-filter-branch.sh
> > @@ -396,7 +396,9 @@ test_expect_success '--prune-empty is able to prune=
 entire branch' '
> >       git branch prune-entire B &&
> >       git filter-branch -f --prune-empty --index-filter "git update-ind=
ex --remove A.t B.t" prune-entire &&
> >       test_must_fail git rev-parse refs/heads/prune-entire &&
> > -     test_must_fail git reflog exists refs/heads/prune-entire
> > +     if test_have_prereq REFFILES ; then
> > +             test_must_fail git reflog exists refs/heads/prune-entire
> > +     fi
>
> Style.  Replace " ; " with a LF and necessary number of tabs.

Don.e

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
