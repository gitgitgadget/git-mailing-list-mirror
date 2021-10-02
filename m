Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76755C4332F
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3804B61B00
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhJBUOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUOi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:14:38 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7ACC061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 13:12:52 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id g10so769732vsb.8
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqA4XO3K7cNliIYUt/k8j9C/NhE1iFiUxxwDSl8+7fk=;
        b=NvUrXGP1BKWk+IrEYkVtXjRVCjG4ybtztfS9veNrG6Fpy/n04cWo7YjbX5b+Kv/WdQ
         XuzCPsnAOJ2ws7jd185rKsyAd8d9U+SCWNC79FmB4xw1pzD7o7gB0E9N7dOeF0Y7VgEm
         axxCv9MufTJMrVFD6VHkFpmcgp0eLIF9JWryigPMWTA5k+Yk1rcozksYkbsWx5eN+11O
         v2qNmM4UM1wjbTiDYN9bWpO73bsB2+ICtPowvpJm0N4SM0ZA1GQZK/XPYWspFkkDLLFH
         wb4JjTowaRGAvkMGrfCDs+y5FfxOqC+cPPZWV2zYr/xFnEc4gtt7fB9c7EhAkGzTMfmu
         lwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqA4XO3K7cNliIYUt/k8j9C/NhE1iFiUxxwDSl8+7fk=;
        b=f5tKfLjfTd4+GdsVZS12gsGEfNCaksYTBZTOW7GUBvsG4CdVW/EUgBEnYWUi7w6pm+
         oZ303C3+Mg0pJh8+jwplbdouaeAiF78xDMFhrdHfUo5FjB2lnw3RznqrwxvsvQd+DtCH
         0YVcw+axf0coWk4BgVQjxDjC+83IIsXOvDjNue3aWmOwZNnYGlq6OieZtgRYhPM4z4je
         43qrK3FR5ko/Si0OCB4s543GcJ5kZlPvZuUME08IFtH7Xmx2UNDeH2ASwrFfZK1Eel7k
         P4BKzZUp6eLoQTFrFWRuJ0cjacRgUAm+5SWqDSNA0DUiMcEAoiK+YjPjBwVGhO9qN6PY
         UERg==
X-Gm-Message-State: AOAM5300+nk+hqYmjQcAietZi9mNUHSYy708f5zoF8GIqJUBSb86C0sl
        Y48cgimWV/KuCBqwfgx1fZUVIgxlUdro83oX6vM=
X-Google-Smtp-Source: ABdhPJz4tk1QLvNbK4XUT8M9iP7drLrBsQ4o7QiXXKr0wyArtELUvRHRjEwfIqI/0gkvQxhmonNRkczUAcceqagZOyk=
X-Received: by 2002:a05:6102:518:: with SMTP id l24mr8895451vsa.57.1633205568783;
 Sat, 02 Oct 2021 13:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211002184407.117282-1-rybak.a.v@gmail.com> <20211002184407.117282-4-rybak.a.v@gmail.com>
 <CABPp-BGq27kdugX5JivX7uFLmCmHXCsRjqfaA1Q2PXHZ4hCznw@mail.gmail.com>
In-Reply-To: <CABPp-BGq27kdugX5JivX7uFLmCmHXCsRjqfaA1Q2PXHZ4hCznw@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 2 Oct 2021 13:12:38 -0700
Message-ID: <CAPUEspgC80_jMJ6Vy8G7YW0v9NXusGCSLzpeBgVZFXpPKJ7a7w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] difftool: add space after full stop in comments
To:     Elijah Newren <newren@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 12:38 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Sat, Oct 2, 2021 at 11:49 AM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> >
> > These punctuation typos were found using:
> >
> >     git grep -P ' [a-z0-9A-Z-]+[.][A-Z][A-Za-z-]+ '
>
> While Junio has commented that two spaces after the full stop in
> fixed-width source code viewing looks better, and I personally prefer
> that style as well, I don't think these are worth "fixing".

FWIW those are not adding a second space, but adding ANY space between
a "." and beginning of the next sentence.

> you separated this from the other changes, but I'd rather see this
> patch dropped.

While I don't think encouraging this kind of "fixes" might make sense,
the work was already done and the "churn" is very small (only 2 places
out of ~2K), where we have in the codebase: ".<space><space>"

Carlo
