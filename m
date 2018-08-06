Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48187208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbeHFVmc (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:42:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41307 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbeHFVmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:42:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so5730859edr.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=59T0q0Jr3UOQR+MazvYGLtNstEMEKeXO2Tk0Q6lIy4c=;
        b=OTnnfQ70EY9dmwGohKwar5Lv2IHW9Tgqg1XaA9j6phMAmxMWHCfCKzvoGLs+NgHyAT
         J8Hno9WJ1AYOfBHGjTMJwtd5PqVyoJVX5GHA1dsKM8OgvNg96zb33IlsjFzv5mU6za0M
         UTvStgn525mjshwlz0UlFWIMuy2GCoM4b9Pnl3RBD6nNlavuNkRLXn+6JSBV1pFwNx6D
         k7oCDirs1QOduCFlV5OZYGVrqcFEgrxl2+G78b+AzsHxy9RyOkbX7xtJQ1pbz+wKm+wn
         r6/vDDmc3W7iZkpJ6KZhjshRqtoZyqmMMeiWVYE5MjEcPMgA5HmHD2RojUvMlwx/myoB
         jQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=59T0q0Jr3UOQR+MazvYGLtNstEMEKeXO2Tk0Q6lIy4c=;
        b=QtCj/ZX3TEgCzv+jj+E9+O18i2t5tn4WQxCKL38w75vjBLITwMh504D4vgrEYp8YHy
         EFAdGQjBbLWLI3iWIJQ49mnkOKmsnpCvOsoFwrISoMpkcoPLB/hgY2bPUTdbOUStE1ri
         oeMzrMfNJe6tOoUcQMVJPHOWv9gLexFcubkaBvo7j/LmbtLlIwockegRiG2013JSyoVG
         ItGcsPfLEfXWe/rM/CvoxeLFJvzTaE6H0S4JW3w8TZO/J9koH4irhzpjaeSaa1UmFSQ7
         tH14vrAz2yQcOEbZbjyWtcZYibOuWsVfqeBa9HMogFckHV+fjeruChhBnBEcJ40HW3tx
         qXjQ==
X-Gm-Message-State: AOUpUlGgp7lVYhv/9ma6aR8cyIJZDsS64rrzJKbP+/91mLrA6zGjTBih
        xKAkfsQtHQdlHbGrRW5elurqbbRS
X-Google-Smtp-Source: AAOMgpd1G/vxSDXckSZzucfxyc7hFic6DjzYFLqXySc6oxOIRczuSkAQg2a10sOFq78lGWqvUl4Ocg==
X-Received: by 2002:a50:fc0f:: with SMTP id i15-v6mr19215423edr.81.1533583887219;
        Mon, 06 Aug 2018 12:31:27 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.100])
        by smtp.gmail.com with ESMTPSA id x13-v6sm15485811edx.17.2018.08.06.12.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 12:31:26 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH v6 0/3] rebase: rewrite rebase in C
Date:   Tue,  7 Aug 2018 01:16:08 +0545
Message-Id: <20180806193111.12229-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730162920.20318-1-predatoramigo@gmail.com>
References: <20180730162920.20318-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a GSoC project, I have been working on the builtin rebase.

The motivation behind the rewrite of rebase i.e. from shell script to C
are for following reasons:

1.  Writing shell scripts and getting it to production is much faster
    than doing the equivalent in C but lacks in performance and extra
    workarounds are needed for non-POSIX platforms.

2.  Git for Windows is at loss as the installer size increases due to
    addition of extra dependencies for the shell scripts which are usually
    available in POSIX compliant platforms.

This series of patches serves to demonstrate a minimal builtin rebase
which supports running `git rebase <upstream>` and also serves to ask for
reviews.

This is only the first patch series, with  many more to come.
I have finished the conversion, but I want to organize the patches in a neat
patch series to make review process more pleasant, and you can see the progress
at <https://github.com/git/git/pull/505>.

The organization of patches is also almost done. After the follow-up patches,
the rebase operation will be handled completely by this `builtin/rebase.c`.

Changes since v5:

  -  Fix `builtin/rebase: support running "git rebase <upstream>"` as it
     does not need to switch to another branch and only needs to detach the
     `HEAD` for now.

  -  The `reset_head()` function is introduced in
     `builtin/rebase: support running "git rebase <upstream>"`
     which is only used to detach the `HEAD` to `onto` for starting the rebase,
     but upcoming patches will add more functionality like moving or updating to
     original branch.

  -  Lots of changes that fix bugs discovered while getting the test suite to pass
     with the patch series.

Pratik Karki (3):
  rebase: start implementing it as a builtin
  rebase: refactor common shell functions into their own file
  builtin/rebase: support running "git rebase <upstream>"

 .gitignore                            |   2 +
 Makefile                              |   4 +-
 builtin.h                             |   1 +
 builtin/rebase.c                      | 421 ++++++++++++++++++++++++++
 git-rebase.sh => git-legacy-rebase.sh |  69 +----
 git-rebase--common.sh                 |  68 +++++
 git.c                                 |   6 +
 7 files changed, 503 insertions(+), 68 deletions(-)
 create mode 100644 builtin/rebase.c
 rename git-rebase.sh => git-legacy-rebase.sh (90%)
 create mode 100644 git-rebase--common.sh

-- 
2.18.0

