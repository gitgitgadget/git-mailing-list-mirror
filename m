Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A4C433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 18:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E642072E
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 18:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGAQ/dhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgGUS2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUS17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 14:27:59 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640DC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 11:27:59 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y17so10436669ybm.12
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4eMGb/3JA7StlD5TuVSo8CGfsuOWeKFBDsHlAcKSxrU=;
        b=VGAQ/dhhaf5QtXWSXs4f1APWMCjXA7W43CzLm2yPerKRKK75ffdgWOH/LoBLu5Igfa
         yaJA+Soj9unYU+eipUKLYlZQTz1jSiaVBfDb4jkUuiQoiLdojkweZpEpm/UFxX4VwvgV
         GB6MeNNVdh8jMRws056mI1JOSFiEWpbjswrpB2UHEwZ82gx3IW7QdtvKs0jcrZSy14v7
         pcL19QpOemaUtiB7I8WXa1duAimskkziCtDxC2E96dOggTeGHsjf58d7GBjUeWixTYiP
         SzTgeNW5RVYWNba6RanArcmQT6GW17qYkVKZ/Dh9khTQcSQDzLElCS97+fOTRt8Mgb1O
         MozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4eMGb/3JA7StlD5TuVSo8CGfsuOWeKFBDsHlAcKSxrU=;
        b=BUyUKkj5H4bHX+U/Gt/JJcHdQj5LnkS7TsdZLwx/HcCgTlwlKHPYE7F7Q0wJxYBZyX
         3QbDx8/4S2z4HunWVNgUVt4S9e3MFSNII7dnpfd58L8/DxPmKhTvyFewWu9XSQXzgz23
         EQI2ZQD/C0TC084d/xyJBwvyQnNFG/JHDKwCSbOp9kRlC3qEX/xeKOy7IMMVtYAdZFAt
         DGVsUR94XMPax2ImWTx4WISivhbi8HVm6eI+uKM3mjKLJLfYy8BmfWy6h/Um0spPPtfl
         BAGUgMKPe1RBR1xxG9csmydqUxetU3BYwtbZM7Wi4YobMbpBJOHbAcvuXopRtKv76aN7
         Xpvg==
X-Gm-Message-State: AOAM533ZgyEeaZIRVNWzfiwzwDAiVMQenRv30onOoDYoU0TcFDej8ss1
        RUebDjLJOTBNFEI6S644ftvQJlDcu3bseCQaEjZMul+Bbow=
X-Google-Smtp-Source: ABdhPJxojqehQ4+fIUtccPOrnYefRnBekWX5702N1jlKTM7cvG3im2SxWWL3+wzp5iKwi1N1KlRbNP5fIPtedBGv/To=
X-Received: by 2002:a25:5105:: with SMTP id f5mr47095616ybb.262.1595356077657;
 Tue, 21 Jul 2020 11:27:57 -0700 (PDT)
MIME-Version: 1.0
From:   bruce <badouglas@gmail.com>
Date:   Tue, 21 Jul 2020 14:27:46 -0400
Message-ID: <CAP16ngo5FRjhz2DwwcMunm4KfjQQDUe-hiigRk_oc1ugwe2xew@mail.gmail.com>
Subject: Trying to push from my local dir to the Github repo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

As a test, I cloned a repo to my local machine.

I then made a few changes to files.

I'm now trying to push the files/repo to the new Github repo

It appears I'm missing something. No matter what I'm doing, the new
repo in Github, is populated with the files from the initial/cloned
repo.

The steps I've used

mkdir foo
cd foo
git clone http:/github.com/foo/cat.git

git remote rename origin upstream
git remote add origin https://github.com/numinds/testapp.git
git remote -v
master    https://github.com/numinds/testapp.git (fetch)
master    https://github.com/numinds/testapp.git (push)
origin    https://github.com/numinds/testapp.git (fetch)
origin    https://github.com/numinds/testapp.git (push)
remote    https://github.com/numinds/testapp.git (fetch)
remote    https://github.com/numinds/testapp.git (push)
upstream    https://github.com/numinds/testapp.git (fetch)
upstream    https://github.com/numinds/testapp.git (push)

git push origin master
Username for 'https://github.com': numinds
Password for 'https://numinds@github.com':
Enumerating objects: 3050, done.
Counting objects: 100% (3050/3050), done.
Compressing objects: 100% (2816/2816), done.
Writing objects: 100% (3050/3050), 6.01 MiB | 15.23 MiB/s, done.
Total 3050 (delta 120), reused 3050 (delta 120)
remote: Resolving deltas: 100% (120/120), done.

To https://github.com/numinds/testapp.git

 * [new branch]      master -> master

Obviously, I'm missing something in the process.

Any pointers/Comments would be welcome.

thanks
