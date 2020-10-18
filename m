Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D65C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 05:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088AA208B8
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 05:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSIb/NKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgJRFsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgJRFsx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 01:48:53 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9481C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 22:48:53 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id m22so7400951ots.4
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 22:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xTiPKjJzBVxNGDqp93my+vyQYD+VhAt4QwuEUIxFo7M=;
        b=WSIb/NKbayliw3OlTxOMK7B2uxAvdds4q7OsRs7mMID5bVnlOJcHsjfH+2vAo6BfRz
         mmiFUHMrZWyxXE5CMcG5VLGpRYP1MNoJF3UgRlTRVgJ/VH3AasflxfbjBA3dmPSCnBX5
         dKfoNvuqZQGzg6iVbrC8TtBffUbE5P4D3kfnryHkSNW8WFAmxgZavM0LkD88FDakmHWS
         C5dZ92qLk+O1tzxbJ2KR4Fmj4/cEmBsT13skYkbRBc1SUAC8CFVAlGrv3P93mBIQuakx
         Q5uuY6okpxuX7C3ZdbxjrpVzQeQHTjp4+2t7jVnYVxZBP50gbxbgvbSm87ZCXyJdo5wJ
         Hg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xTiPKjJzBVxNGDqp93my+vyQYD+VhAt4QwuEUIxFo7M=;
        b=LpQzokVS6dydbHCdFHTPj3u7fuH2HoHlnEyJOjXe8VfL9d2kvZuCDKrLsRzbELX5Yq
         TSwoyPxWqRupsJZaUexa5a1A9vjbmvAS9VFVIpDaHRO1o01t1R5FDxNqvPdSvWWi6jMW
         HJ54h784HsWruzOmP6S9bS+DJTM3DZqi83ZtaxHuDHxrJeQsuRG7NFa9QoZxhBE/8nVS
         uAQbJMFACAmVDT5DyNEJM7S/aNqMuXBiWV6niR6H8G/S2iTHvBt6YwFAFnllFXYIfRo0
         Sx++VMoNntC/Je8D9Xv0VAqM0qeK0NGK9tUXqTwL8wNr1qfZhzL65hyOi2JP1cgfEPN4
         jx8w==
X-Gm-Message-State: AOAM533lLMQE27GvGI85y+erbIe1wm/v53KSykd7FhGKFCohsYydGrAC
        sEXs0VvPPdZl2nSsuOx0mDHA7u/9PlKq10m5/LetNxhi
X-Google-Smtp-Source: ABdhPJwd+G3OTPaxzjPMXxBFFjX7Y4QBHs+38bWgbpWOvH+O2WHsxk4wXlEgB05XYRW7MYKGHfjOcomRIDpI3OzqP9U=
X-Received: by 2002:a9d:292a:: with SMTP id d39mr7928618otb.164.1603000132911;
 Sat, 17 Oct 2020 22:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAFfHKJ7kAJ7030GPywKHEWG0vJjC0hhEGt4MMR=85nSHnu5Q-w@mail.gmail.com>
In-Reply-To: <CAFfHKJ7kAJ7030GPywKHEWG0vJjC0hhEGt4MMR=85nSHnu5Q-w@mail.gmail.com>
From:   Daniel Dinnyes <dinnyesd@gmail.com>
Date:   Sun, 18 Oct 2020 06:48:17 +0100
Message-ID: <CAFfHKJ54smgBZrYTEmgoqmo7gMp+H8AxjL3GxnWVdF9K_MnoFg@mail.gmail.com>
Subject: Issue with staging, unstaging, discarding hunks with no context
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The problem I have is described in more detail in the issue here with magit:
https://github.com/magit/magit/issues/4222

The conclusion there was that this is an upstream problem due to some
recent changes in git.

As it has been mentioned in the issue itself, it is understood that
git had problems with handling hunks without context, so I assume this
upstream change was to eliminate such issues.

Yet my experience was that hunks without context worked fine before
80% of the time, except if they were right next to each other, they
might get mixed/messed up. Even in that case, I found that if I
staged/unstaged hunks in top-down order in magit it didn't cause
problems.

Without handling no-context hunks, I see I will have to stash/redo
entire change-sets, to be able to commit logically separate hunks
separately. This would be a major PITA.

Is there a plan to reintroduce handling of hunks with 0 line context
in the future, or is this something which is technically not going to
be possible ever?

Cheers,
Dan
