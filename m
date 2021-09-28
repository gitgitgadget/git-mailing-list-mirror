Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A32C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF62611CB
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbhI1MiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbhI1MiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 08:38:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8B5C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:36:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m70so31395564ybm.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aZiNoBLmCbT0ReV0qp74FUDV8h8JnQfyq23ZvyhFbAo=;
        b=P6mp7CI+PsfX4mUnaCPrbXmpJrP3QQ3edk6JW6pwMfHPuvHJ9Lu9fuZuU14ONpxcOI
         xkHcZPIRYCBZPox3B89wr2FbCMoSF3MGGKlOYW4sC7xWFk8AZcjy+jsbXfTq8YxPKezv
         TJkuhB1abkoi4+BNJLzyYMZHGb9OUSGb8taZBxj0BNblBu/OnDB8r4222l8Tzx1+tqlN
         AoU5bURBHlMTraKTacZA5/1hf70hkXvlBNBkSb7d80a7IyMZCFE7NI8G+Q/HFes4v//3
         +4y5H4MxOZFt5wOd3WbBVElEMWsi/QZvAzLasnNwlUT2yI3Eed0cT4sdJJ+dBSsxXT7e
         J7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aZiNoBLmCbT0ReV0qp74FUDV8h8JnQfyq23ZvyhFbAo=;
        b=fRb0oW3c9SIhp09n7kuGvQRogAhi3/pP+mj8TefsaGvJHnVkL8Wt3JQNqKSI+GK4mZ
         9hxms81jf1zFdF1OdDk5X3Y1h542/13+4Q3aL1Dketp2rlaH2JB17rjHBsNvnoFZLsrl
         gt44sDbqiirRbLlTud70+ThG6PLlBCmPbikjuZ5eiTEAGh8SybmmF3qf/rNaHf5M4Afz
         r9yySu6YC6Hsv4XSqrqhF/m82Wxh/9YOO4R2nqjooxBHwKprKlnUFj7TVJ4lo05wpHzF
         qfYaJyirTErLdon2dbwQ6nhbfpahSqjP/zxBvqbxFmGiXnkBtdc86T38rN2zfSdoftLk
         2s8g==
X-Gm-Message-State: AOAM531camoX6yty2FjI4JilJlibM6f8yVc5uSL7DKqptChx6/AAk382
        qRuCvkwrSMfSbXX/DLSDVMFyPI2oIyxVOj/6Suyhst+1axs=
X-Google-Smtp-Source: ABdhPJz7TE1Y2oPag0ulDALuQKN/bcTXUPvdEiJrLkk79A86bJRD36NmavdnldgMUTDcdsxLhfadG1CL1imtMxOFSTc=
X-Received: by 2002:a25:2255:: with SMTP id i82mr6049360ybi.203.1632832587693;
 Tue, 28 Sep 2021 05:36:27 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Sep 2021 14:36:16 +0200
Message-ID: <CAP8UFD1necFT_wSzuu3Ua+d7zxeBuurys=ubp0ocbNR+4H0Q6w@mail.gmail.com>
Subject: Draft of Git Rev News edition 79
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-79.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/520

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
September 30th.

Thanks,
Christian.
