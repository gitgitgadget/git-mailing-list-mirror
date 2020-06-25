Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0707C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCD420724
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZsHkdMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404755AbgFYMsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404125AbgFYMsy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:48:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70969C061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:48:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so5443521wmj.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ehfE815IBEpAx1moyrDX8v7+InrqFLgsWlaU694vpSI=;
        b=gZsHkdMGS/NhpKmrYtOozjPT9ifJlnYMYW6o6+u98HlnjyaNbOcBAbAg76sqZz7oXE
         13OJXRDkZg0wLJQ5t4Q6WFY5ts58HlQskGj1r4pAhxq28t9TUcHzIHZ+sCTPlGOf2aND
         /hkQK7yEbmFOW2U74rTEliWq+ruE2Mye9IU1XSUz+5iT1CJmAmg41gXGNbfy+IlPkCpl
         OuYKlWwqCxilx6wBqWBdE2IYxB/hNFSHQa02rJm393t1Mmm+bOusVfcshaW4xpCmQoGn
         yN3pIaTDaJga0OdBKkXJw6aYnHdjDXoFRQgVKFWSyB9BSwxsjrsWTQ0A83MhIhWTXD2+
         8EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ehfE815IBEpAx1moyrDX8v7+InrqFLgsWlaU694vpSI=;
        b=n5Xtfx0F/0KtPE8279yuYyGBgjkBwZbOX+JGwwCAG3bfkx/OAtBogKBbtgL20sPR4f
         rSFkzaVcPelW8nvGDpBI3feobFsyLO/HOji4fvANPuLwVUH841kiWUtJAFFqjXblWXQW
         KvgmQJurM+bNs8wAyZvCgxLwj4qydVXlqHRLWUBEUcR+HVOil0qyndifSu9cylCGMwkb
         4Ea2vtfQ5OTCcCTrYejN+36itly/Pg/6WR8EFQJZiwJj3ihOmsBHpGTPKWTW0cm32wao
         wxqlHAVVYyMJc+g6YnduDOet9i/sfFSIphl2Kz6KpIQJiiI4eJUDFgPOTUmnWa4Yz6vx
         3z6Q==
X-Gm-Message-State: AOAM531Vc7n4evRbSf9sybpsPXrjCo3aEP/FOREeiNHawRUdrWI2a+tZ
        MXSHbEiL5t3NgWMldEK0GifN0K48
X-Google-Smtp-Source: ABdhPJwofXLAOw/oAjurTHUQcgaIrHWDDGKdORoMzRoF4YYyRx2iIo9v22XAEVDE+Z2qEPE78jB08A==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr3008377wmc.146.1593089332716;
        Thu, 25 Jun 2020 05:48:52 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:48:52 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 00/17] Rewrite the remaining merge strategies from shell to C
Date:   Thu, 25 Jun 2020 14:19:36 +0200
Message-Id: <20200625121953.16991-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an effort to reduce the number of shell scripts part of git, I
propose this patch converting the two remaining merge strategies,
resolve and octopus, from shell to C.  This will enable slightly better
performance, better integration with git itself (no more forking to
perform these operations), better portability (Windows and shell scripts
don't mix well).

Three scripts are actually converted: first git-merge-one-file.sh, then
git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
are converted, but they also are modified to operate without forking,
and then libified so they can be used by git without spawning another
process.

The first patch is not important to make the whole series work, but I
made this patch while working on this series.

Patches 2-5 rewrite, clean, and libify `git merge-one-file', used by the
resolve and octopus strategies.

Patch 6 libifies `git merge-index', so the rewritten `git
merge-one-file' can be called without forking.

Patch 7-8-9 rewrite, clean, and libify `git merge-resolve'.

Patch 10 moves a function, better_branch_name(), that will prove itself
useful in the C version of `git merge-octopus', but that is not part of
libgit.a.

Patches 11-12-13 rewrite, clean, and libify `git merge-octopus'.

Patches 14-15-16-17 teach `git merge' and the sequencer to call the
strategies without forking.

This series keeps the commands `git merge-one-file', `git merge-resolve'
and `git merge-octopus', so any script depending on them should keep
working without any changes.

This series is based on c9c318d6bf (The fourth batch, 2020-06-22).  The
tip is tagged as "rewrite-and-cleanup-merge-strategies-v1" at
https://github.com/agrn/git.

Alban Gruin (17):
  t6027: modernise tests
  merge-one-file: rewrite in C
  merge-one-file: remove calls to external processes
  merge-one-file: use error() instead of fprintf(stderr, ...)
  merge-one-file: libify merge_one_file()
  merge-index: libify merge_one_path() and merge_all()
  merge-resolve: rewrite in C
  merge-resolve: remove calls to external processes
  merge-resolve: libify merge_resolve()
  merge-recursive: move better_branch_name() to merge.c
  merge-octopus: rewrite in C
  merge-octopus: remove calls to external processes
  merge-octopus: libify merge_octopus()
  merge: use the "resolve" strategy without forking
  merge: use the "octopus" strategy without forking
  sequencer: use the "resolve" strategy without forking
  sequencer: use the "octopus" merge strategy without forking

 Makefile                        |   7 +-
 builtin.h                       |   3 +
 builtin/merge-index.c           |  77 +----
 builtin/merge-octopus.c         |  65 ++++
 builtin/merge-one-file.c        |  74 ++++
 builtin/merge-recursive.c       |  16 +-
 builtin/merge-resolve.c         |  69 ++++
 builtin/merge.c                 |   9 +-
 cache.h                         |   2 +-
 git-merge-octopus.sh            | 112 -------
 git-merge-one-file.sh           | 167 ---------
 git-merge-resolve.sh            |  54 ---
 git.c                           |   3 +
 merge-strategies.c              | 577 ++++++++++++++++++++++++++++++++
 merge-strategies.h              |  44 +++
 merge.c                         |  12 +
 sequencer.c                     |  16 +-
 t/t6027-merge-binary.sh         |  27 +-
 t/t6035-merge-dir-to-symlink.sh |   2 +-
 19 files changed, 889 insertions(+), 447 deletions(-)
 create mode 100644 builtin/merge-octopus.c
 create mode 100644 builtin/merge-one-file.c
 create mode 100644 builtin/merge-resolve.c
 delete mode 100755 git-merge-octopus.sh
 delete mode 100755 git-merge-one-file.sh
 delete mode 100755 git-merge-resolve.sh
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

-- 
2.27.0.139.gc9c318d6bf

