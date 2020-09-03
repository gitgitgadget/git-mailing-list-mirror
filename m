Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE35AC433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 18:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF9B2098B
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 18:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZptPYVrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgICSzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgICSzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 14:55:17 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEC4C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 11:55:16 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id s127so1074140vkg.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zky3UlKt2M74mx8gU9WFpgGBg/sbYiOzcVs5AnM06E=;
        b=ZptPYVrUm/lcQEIkKJkWdlxZ2dq0HXZdJwFdUarb8dROBD9G5ib5AQLayrURkV0F6S
         4ERW9Gr97ltTAcSP0M3oOYBVlSP/CLrroVCPHibesVQwv/s73Ym+c/GZnHfg0UO2gI+n
         C+qKcuAJUSPoFV4MZsPOsR8In+CmpLBcrF1TR982d4/e8wqRWBJqSjRO+GFUUgWXPN+g
         ytURzB+IL5TgSQ01q7PHWZ9JA6WK5h3hSsSFDKpvrxEmblwuClkAoKDLZvC2k9LkK5A2
         sZHG40biR1E9kXFkTh5bkTRGlAvE2bmzDNTJY8uGgrY34vdBUzcQs4XPPePSuGHp84Zo
         5OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zky3UlKt2M74mx8gU9WFpgGBg/sbYiOzcVs5AnM06E=;
        b=X51reGhX57/o3n6RCaMukP/vykmXe9UYSKl5rbBFXLYDka/bDs0s2g7Ftncn/ViR2G
         SBdFhwvd8OySWvzUVqX8U/bm5i90ImlwFNTOztxP5obPpr67s/XFigynNnMmw3tsxwpU
         5hU12b1WaTT2K35xvHjwZ9jdb1H4YOui/lfeHQZIg3ZrwBzraapwA7bsQYeCcqYOue1x
         hBuQTETVkbRYjkzW0nNZy/aKKT7/phPiKQPvDIG9H5o/LJrd6M2U4i1iFwawXuZ7nXMj
         0iHPWzNeXWS9TZ0KLui7BmljoUOTolTOIOSTuW3R0qbXJ2b45f1eKJIrSrsyjvFN6W9z
         lYNw==
X-Gm-Message-State: AOAM532ZvcSJsDDgu7pmaNHgNJV9v+PBtVsk3V5qxlxw2nXCs3xOaNx+
        nxEHyepxb1RkgXa0BXzNEHmbhOt0tI/URv6E48k=
X-Google-Smtp-Source: ABdhPJyB3XEvnv79wIK1qIwAAl5CQrbluWWRR6VyQ0lYfn1Pj7kHJmqlj9B2HrFb3SyU2czjLynHCqzZgTim27LbX0Q=
X-Received: by 2002:a1f:a286:: with SMTP id l128mr2730435vke.1.1599159315090;
 Thu, 03 Sep 2020 11:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
 <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6y6ah8h.fsf@gitster.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 3 Sep 2020 11:55:04 -0700
Message-ID: <CAPUEspjKcQgLvVrJ2GroqYydNPksEziMgyceN-CFBFVgtngMuA@mail.gmail.com>
Subject: Re: Aborting git rebase --edit-todo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victor Toni <victor.toni@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 3, 2020 at 10:47 AM Junio C Hamano <gitster@pobox.com> wrote:

> Now we have the "drop" verb, the latter interpretation becomes
> possible without making it impossible for the user to express the
> former.

and for people that would like to enforce the use of the drop verb
there is configuration that prevents deleted lines to "silently"
dropping commits since 5a5445d878 (rebase-interactive: warn if commit
is dropped with `rebase --edit-todo', 2020-01-28) :

  rebase.missingCommitsCheck

AFAIK the correct "signal" to abort is to instruct your editor to exit
with non zero (ex: in vi using <esc>:cq), but agree it could be
confusing or "inconsistent" and might be worth adding it a message at
the footer

Carlo
