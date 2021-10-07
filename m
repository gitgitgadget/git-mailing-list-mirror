Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A543C43217
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2EA61037
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbhJGLBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhJGLBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34668C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t8so17907051wri.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=FuFUjrih1uom7nc1pblDQqKxyO1yn3Vu6nJGoImkmTUMaxpN8Woanadly83tqm09yH
         XTIXiG2c56v2NLkLxr8Pe//DUYqtsug6TnLCT2evGeE66X2dVZoJIR+6R7lvFety+ENI
         xfkkFpuXAgsOf//3uYtIbxG1GOUaZZStPkrTi8l40hRxVJvzgcNmav/gAH4jpqMCH4Wi
         dcDp98eX8sQwg3LG+xaTCfN/VxGYERQ9JhdcVn/5oICTrx7GhD6N2CfRE8qgKGq3UKJw
         2BHRsOK6bdBttU5nwTX+n3Xhc1WxDsJcvqfYs30Jk5n0U1O0WdjkfL4Pvj3AeN4cPKE+
         BV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=dcMckdvRgaGVtUp4BS+nJAJH0cG77WfEUMi+bWRdLcwiXVe7YU6cRjBes3niqk2M4r
         RYERM7xixO3O6vhjtNfDX8ha8q2VP7c219rbvsUk/tFaj46JiQzbJKgeWAE9R4NQ2h42
         vVdzVCbC3HJ80m1Qk1gk3aIXIMR1FF6Uh1UvJjOoG6ItcjGx/SH5rVPiId2Uw9rNyEqY
         KMu1Wqo/8+omnm2FFVjASSUSyPtgxfY1ENrBv4u5k/vYUbdnDj14rG322ureuN/vWVNQ
         DR1lnGD7UR0BG3DCa6lYH/aNklEDt4DDbVTodFtoKPAQ101O7NyhAuu7B0mt1b7qAGDO
         sCng==
X-Gm-Message-State: AOAM531pD4KXOPSyw6sEk6JETj0B5c0zb8v+DGxARDaGFjmFhXD5HiXm
        Rro7gQfiBC6icrBdE0bxZTwe7bBWuPs=
X-Google-Smtp-Source: ABdhPJxdQbJMGKVerE29Z7aaO+2ItEd+9oBKSJ+InavbfJTC5dBAGRw4/TxEHw/aKJRr0rNAQwYRLQ==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr3892321wmc.15.1633604351797;
        Thu, 07 Oct 2021 03:59:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm23360256wra.87.2021.10.07.03.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:11 -0700 (PDT)
Message-Id: <edc1e5f73bd852478f82873c3039388dee652683.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:58:56 +0000
Subject: [PATCH v5 02/15] scalar: start documenting the command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This commit establishes the infrastructure to build the manual page for
the `scalar` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/.gitignore |  3 +++
 contrib/scalar/Makefile   | 14 +++++++++++++-
 contrib/scalar/scalar.txt | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 contrib/scalar/scalar.txt

diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
index ff3d47e84d0..00441073f59 100644
--- a/contrib/scalar/.gitignore
+++ b/contrib/scalar/.gitignore
@@ -1,2 +1,5 @@
+/*.xml
+/*.1
+/*.html
 /*.exe
 /scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 40c03ad10e1..85c186634e9 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -6,6 +6,7 @@ ifndef V
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
+	QUIET          = @
 else
 	export V
 endif
@@ -30,5 +31,16 @@ $(TARGETS): $(GITLIBS) scalar.c
 
 clean:
 	$(RM) $(TARGETS)
+	$(RM) scalar.1 scalar.html scalar.xml
 
-.PHONY: all clean FORCE
+docs: scalar.html scalar.1
+
+scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
+
+scalar.html scalar.1: scalar.txt
+	$(QUIET_SUBDIR0)../../Documentation$(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/scalar/scalar.txt \
+		../contrib/scalar/$@
+	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
+
+.PHONY: all clean docs FORCE
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
new file mode 100644
index 00000000000..5f7131861a5
--- /dev/null
+++ b/contrib/scalar/scalar.txt
@@ -0,0 +1,38 @@
+scalar(1)
+=========
+
+NAME
+----
+scalar - an opinionated repository management tool
+
+SYNOPSIS
+--------
+[verse]
+scalar <command> [<options>]
+
+DESCRIPTION
+-----------
+
+Scalar is an opinionated repository management tool. By creating new
+repositories or registering existing repositories with Scalar, your Git
+experience will speed up. Scalar sets advanced Git config settings,
+maintains your repositories in the background, and helps reduce data sent
+across the network.
+
+An important Scalar concept is the enlistment: this is the top-level directory
+of the project. It usually contains the subdirectory `src/` which is a Git
+worktree. This encourages the separation between tracked files (inside `src/`)
+and untracked files, such as build artifacts (outside `src/`). When registering
+an existing Git worktree with Scalar whose name is not `src`, the enlistment
+will be identical to the worktree.
+
+The `scalar` command implements various subcommands, and different options
+depending on the subcommand.
+
+SEE ALSO
+--------
+linkgit:git-maintenance[1].
+
+Scalar
+---
+Associated with the linkgit:git[1] suite
-- 
gitgitgadget

