Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD00C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9FC61185
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhDZRm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhDZRm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:42:58 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AE9C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:42:15 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id z7so2046444uav.4
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jA8pSmWh/uE5VQn3e02sKf0ozeLgnAmtXvRnYEqRyME=;
        b=RYJw/DF/Li1fL3xwPek4CRfA6JI2e4ViJbNo70zBEZlj3CEIesgiIB8wlmIWDY6gTr
         hLTJA4dwfUjdxjQv6YjVHQWvzDrG7M15ksnY/kXIuoaRWN12kacIl9WyfQB79Uthg3Z8
         QfF5RjZQikXeJXMHjDw5kB15RBznij5J3Zyr/KriVVa5eKQe07avW+z1OHti4QY645zV
         nqXrr6uV2f6pJElbYiSyx7Ulb1V69AAnrJYNhyLurhe5+Re8OP+lLKKkCgN/GfTJiRyr
         teVUn2lBpFbE5L5+HmW2+czZtXAUBC/BmhzpYZP/SgndnNP4Sdyxa+QgKV0RKqUqCVxH
         K3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jA8pSmWh/uE5VQn3e02sKf0ozeLgnAmtXvRnYEqRyME=;
        b=AZYAGMEG1m8HsbJJddgDxQNkGmWbxnR3Xj4i/wXqyfozO06QPSzJgCQf+wDkj+19MC
         RzlmYwGlkSuWFGQmrbAyE8JK382uyAdvxOiQtTmFjPShz9rHp91h0+O81OXyEYa2704T
         VThAHfmFDhvOl5fFirVD+9c7s+RAtD7y0XCbP3SeY9FH79z2EJVGi7Ky5rWreY0Xv75y
         1PrjaQjpp/eUd5yj2UXjttyoqg22+yBySV5pgc63bUv+YNzAD2E7l3ducmurDR6OAx/w
         7bnmd4XGa9aWjWl5ai0tmrGl6egq5QRV7skIEqYlkIpTjmsM5YePluL15YGQeOlaC7Iz
         urtA==
X-Gm-Message-State: AOAM531QKAM5Cw7eJpwd50S09Ua+KgrB52VcsdqIc212WpQkTTXbz9gb
        BBdqxdO14mzQuP+EFWmQbu53Bzpwac11EXz1hgxLAg==
X-Google-Smtp-Source: ABdhPJzSszHXsRx0Ymv0HIx/9VP3i92dhYKXJPSZN10TI5UAZQiE6gAFGkFpv503Ln0ZhPGFhGCrO/a8NgJtKlNiIUU=
X-Received: by 2002:ab0:2b01:: with SMTP id e1mr13468422uar.85.1619458933997;
 Mon, 26 Apr 2021 10:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <a5b9439192db3ad3c01db0e67cc1f60bad9109e8.1618829583.git.gitgitgadget@gmail.com>
 <xmqq5z0g36m9.fsf@gitster.g>
In-Reply-To: <xmqq5z0g36m9.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 19:42:03 +0200
Message-ID: <CAFQ2z_PhxR+mhfAwvW1jMUSNeF=gQ3Xg-qsX0yK+7YPc7XQNYg@mail.gmail.com>
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

Done.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
