Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE92DC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 10:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA44720776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 10:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyajc2ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgE2KpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 06:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2KpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 06:45:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC9EC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 03:45:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d66so1176182pfd.6
        for <git@vger.kernel.org>; Fri, 29 May 2020 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Q4oEaQZ9pw/MJIYBdWqk5inYhc1l9JBN2ekyrPjMuiI=;
        b=cyajc2ueFx9rqp2agU0BQv68CxeiEinShDT6lMVYKyFUKyzNduu1HT5LgmnYcYkPgs
         Q5x8OL24YdikiObrRgTK2jGG+WzTk5DDlIwzZs2apaOwAhOaRtDXbsSpbxqpElJubhc0
         O5VuE4ZkPGs+H+uKrawvifKf7Lm7utsUI86z3h/rIQx3zPqqBUX5ljFAzn1ahoslj70a
         Hvc3N4xI4eC8jv4Fwwvz2qrwYG4t4yKadQY3Ev15f9f2QvfgZ4ICcKHNIdROJ0JOArpE
         iZaAnpixAdeiGIX4Qwp4xoNmvno6m/RNqMCCY0fdBVEGkmc+I+zAlex//62gRoSPg/Zs
         1AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Q4oEaQZ9pw/MJIYBdWqk5inYhc1l9JBN2ekyrPjMuiI=;
        b=Xp3F50Qo3V+ALanrgOyeFKnpLENWeC9Acul3xf8gcJChJ5wNIPHETCtOittnYZyOEg
         6gmtvOo//rgeSJUVohf8XdCjaBWKQfaR036FEJ0wyQwPbfVPokcqsCZY7C8E/fv/eU9O
         e+OHhtWfiFp50Lgkn0uD++1bHkIK3/pVagHJZUOB25/b3qauxuOfB28GMqcR1VpZTGP4
         9acoD+eFW4MBqVELKL9rAgIosE/IvsuOCSEuDr27Mr6Pu3Lm38yl3uIGOXcmZsSTaBET
         fZeKTlV65CY+w0qmeaQv8dJodKSpNQ7MvWNWTV8ZY3UJO09JPSFdHrh/yVgtEXFOTAbA
         5n6w==
X-Gm-Message-State: AOAM5335NFgdghXP5ira7tyUmn1cQSsTubUsZbzNRDsxp4DwUqwOeDJs
        IApBGJRO3Z+yL3kxkk2O9ZD4YYO9taGlHTVn8meNL5yeTbH4Pg==
X-Google-Smtp-Source: ABdhPJyu9PuQX5MBDfN0G6a2e2AstNXlXFc03Bt4odNz9B1I1XuhmByNge6LIWAn2Iq7dX6sqNJrfHarlf3tDzI53rE=
X-Received: by 2002:a62:1792:: with SMTP id 140mr80578pfx.36.1590749122019;
 Fri, 29 May 2020 03:45:22 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 May 2020 13:45:10 +0300
Message-ID: <CAHp75Ves8x9_1=fVo_+dB92GpAGLcbGVqeo2gjRbBnzTzM0uzg@mail.gmail.com>
Subject: Git fetches whole repository and not just latest
To:     git@vger.kernel.org
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A bit of description what I have on my side.
So, I have a local repository which has many remotes added (~20 or
so). Most of them are from the same Git server, but few are from
different servers.

To refresh the state of my local repository I run `git remote update
-p`. One note that I'm behind the proxy. This schema works for few
years until out of a sudden (approximately  month ago) I have noticed
that Git started fetching whole repository instead of only latest
stuff. Note, that the repositories in question are from the main
server. Yes, sometimes it goes well, sometimes some random repository
gets downloaded in full.

Example:

(few days ago)

Fetching spi
remote: Enumerating objects: 18064, done.
remote: Counting objects: 100% (18064/18064), done.
remote: Compressing objects: 100% (2784/2784), done.
remote: Total 7343589 (delta 16227), reused 15523 (delta 15266),
pack-reused 7325525
Receiving objects: 100% (7343589/7343589), 1.21 GiB | 2.36 MiB/s, done.

(today)

Fetching spi
remote: Enumerating objects: 822, done.
remote: Counting objects: 100% (686/686), done.
remote: Compressing objects: 100% (323/323), done.
remote: Total 602 (delta 485), reused 358 (delta 279), pack-reused 0
Receiving objects: 100% (602/602), 160.25 KiB | 896.00 KiB/s, done.

(also today)
Fetching origin
remote: Enumerating objects: 17806, done.
remote: Counting objects: 100% (17806/17806), done.
remote: Compressing objects: 100% (2681/2681), done.
remote: Total 7343331 (delta 15992), reused 15321 (delta 15106),
pack-reused 7325525
Receiving objects: 100% (7343331/7343331), 1.21 GiB | 7.59 MiB/s, done.

origin, for example, almost everyday now gets in full (1.21 GiB!),
while others have no pattern.

I would like to know if it's problem of proxy, or that specific Git
server or is it (new) bug in Git?

-- 
With Best Regards,
Andy Shevchenko
