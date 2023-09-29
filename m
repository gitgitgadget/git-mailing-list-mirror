Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C7FE743FE
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 09:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjI2JJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjI2JJP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 05:09:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67B11F
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 02:09:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b281a2aa94so1241116866b.2
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695978550; x=1696583350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aEOrw2rKC3Mig0pmnVWIbbQdHL/gN2GBK/vB3koF7aU=;
        b=kmzvdhONIRY7knDGKmShJXRgooyUACPQdcvWQ/qSpDrK1AYW601g02RYfdkSN8RYun
         W2Fk72V2sEMeVp5mfBuE5H1GQ+BxcIVcPCLX5tOvG7JMw9adBQP+aZCWJ0J7geVVJGZk
         U17JGXfJkt+e2mVztF95pPhw/qqA3kAKKLGtMWk8pJEkdlRASJ/XnBo4eNGI6Yw3LLMN
         MGndcIN5aWCmOLGlbnyQOolVZfCIofZofBGGUCnkPUBJ37UUsmoa2DWL8pAMo9402SzY
         XWwKrn3wl+gmGQDM1ucanmLLRSMQf4b0Mah3X54NvnRc0+wDrA+IgSqDInjWtLBNrleX
         Rnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695978550; x=1696583350;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEOrw2rKC3Mig0pmnVWIbbQdHL/gN2GBK/vB3koF7aU=;
        b=XEviTjCONaU7SplcYtMI+lax91Pb1OAz4uZJ/wk0Lfb7AEe53bSrOFlJ4XDv8NFuiC
         VGPV7x8VTRPxeDmboLHj+RwxBtXOUkKFbXrY3JM6xFbCrQ/LWr6sMu7a0YnV+whl9wRV
         DKsxXpPbEBxCgH/HORYlrSAvBw6sEnjMF56y8pjjL/OiiCNxQTR65j5Qpq58Bum/6GsC
         SHR/keeJ9fwNiOJ7qdiDlhvT++sqyuFopUmSX3TxazZ8y9YSFbrHyaTsXDIadAR7TQbM
         aUYaaMCOlkmlGTRiuRIF7174z3ZDE/W0TYd8enaiQbVA5/ShEFGF0LoWaah3vrRZz7ui
         rdzA==
X-Gm-Message-State: AOJu0Yw4NkHQxpZyu38CGXQJQ9jJSJdarXmq54IuxPtYee5WuVlixwtn
        fKyfxPTlk9vrc8+99SMpf9Mtq8xTGyOP3zkKkKKtgDOGtFE=
X-Google-Smtp-Source: AGHT+IFSoaxHHhN6jlEDImyVe+muFGkvjXUqyzJi3HfL9wJU1S/3befqLJrQg0F2HEbv4t7CHtnli7wIH2laU3PqbXQ=
X-Received: by 2002:a17:906:5daa:b0:9b2:b763:8d6b with SMTP id
 n10-20020a1709065daa00b009b2b7638d6bmr3028970ejv.50.1695978549607; Fri, 29
 Sep 2023 02:09:09 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 29 Sep 2023 11:08:57 +0200
Message-ID: <CAP8UFD1qDet8OPKYgk6dgibPT4PW=AeO7T3h=_vz5uYnEOzO3Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 103
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ronan Pigott <ronan@rjp.ie>, Adam Johnson <me@adamj.eu>,
        Bruno Brito <bruno@git-tower.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-103.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/660

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Sunday October 1st.

Thanks,
Christian.
