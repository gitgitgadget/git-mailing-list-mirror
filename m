Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4909F1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404109AbfAPKcO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44269 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKcN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so2644016pgr.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmN7GHeCWf5QdQx61eymU4pBBvsEd0XAQQjG08lothA=;
        b=L/i3Uwrf77v4WcwZDsDLff9uRebqD49pRW48OGVdd+kdXJyXirrfOD37OWXfG0Eg5J
         fBiJKJ3f+nWjsHJMvToeFQ5oA4LXObTZ2CAVE7gtsiv8hVxry3GabQV0OWR9TUdhZg+2
         CqsPol76IGBg4HQT99VXSuCbylHscgZICJ99UWqvBJ2VaVgqm1eSWafl4ko5xbk30Ou5
         ePHzoL9her5ZCKCgaahNpdzFMdzu5UGQY00GSnRu0va6S5mW043yZQaHKgriHetQI+0r
         p2UScHNoZbdqXTrKyuAtxzBZ1hb5hakatNJHghtCOxsgD+t99Dgzyc9o1gOA/OYwx4wg
         +jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmN7GHeCWf5QdQx61eymU4pBBvsEd0XAQQjG08lothA=;
        b=EE1ZZc0wd/C1PRrs71OUeUpMMI3IQVNEFPYmo0Pj4q30MANf+klyzTZ4xIwORODv4G
         JKYMSY2igo58ByGK7QMgGdJ6haO6nhKZfAObwhY8qgfIotB/JILcUSFtPIcC5dGwmYqY
         vAwp7SPzz7Dm6V+2Op4/jf+UI1gAzmKREv8MDCK1hAHl6/zS2TNcQNYfhysMrhn+m0F0
         fYMkHpWAVEcMzYLiyViI9IrC1BMHZc0q12YFBQ0vfQP8FrfasK4OAUDoPPn3s1TMLavB
         /lvqBr73VirC8gdFKrTWhbJHGLI4FaR5+5BcRkDF34r5fyVAlsM2FVT5TEyLPYUFT2aG
         IF4g==
X-Gm-Message-State: AJcUukdwk1XWOsM71nm1lAd0S/7o0SXr8QChpgMsCVTFmoaftrnERhy2
        TwFgy5VYFViBHygk6/qRDeHv5qAh
X-Google-Smtp-Source: ALg8bN7hs3A6PPFTDPXIU0a1MZBzzf2OJRljxwXFnZFWvPPfnXvGbJRPrFOcuUGWy21UIb81Icua1w==
X-Received: by 2002:a63:8f45:: with SMTP id r5mr8121959pgn.222.1547634731974;
        Wed, 16 Jan 2019 02:32:11 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d129sm9580844pfc.31.2019.01.16.02.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/10] doc: about submodule support with multiple worktrees
Date:   Wed, 16 Jan 2019 17:31:50 +0700
Message-Id: <20190116103159.9305-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190116103159.9305-1-pclouds@gmail.com>
References: <20190116103159.9305-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lays out the very first step of making multiple worktrees and
submodules work together.

The first problem is git-submodule keeps per-worktree config in
$GIT_DIR/config, which is shared for all worktrees. This series makes
git-submodule use extensions.worktreeConfig and write submodule.* to
config.worktree instead.

The rest goes on and on about the remaining problems. But let's talk a
bit more about solving the first problem. Since it relies on the
experimental extensions.worktreeConfig, this support is of course also
experimental. On the other hand, submodules have never really worked
with multi worktrees before, this change can't bite anybody.

Second problem. That is about multiple worktrees at superproject
level. At submodule level, we still can't have multiple worktrees
because git-submodule writes to submodule's "config" file
(again). Fixing this is not particularly hard. Absorbing submodule's
git dir takes some work but is feasible. This could be addressed soon
in the future.

The third problem is a big and complicaed one. Submodule clones
(inside the superproject) are per-worktree. So if you have two
worktrees, and these have one submodule, you need space for _two_
clones. This is definitely not elegant. The tenative plan is to move
clones from $GIT_COMMON_DIR/worktrees/X/modules to
$GIT_COMMON_DIR/common/modules.

The latter directory is shared across all worktrees. Once we keep the
clone in a common place, the submodule's worktree can be created and
managed with git-worktree[1].

Another good point about this approach is we could finally safely
allow "git worktree remove" to work with submodules. With current
solution, removing $GIT_COMMON_DIR/worktrees/X directory means also
removing potentially precious clones inside the "modules" subdir.

But whether we can do this depends on:

- if we need separate ref namespace for submodule on each worktree

- how does submodule's worktrees (remember the second problem)
  interact these worktrees

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt  |  8 ++++++++
 Documentation/gitsubmodules.txt | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index aae8e1d8b2..3510fd5331 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -267,6 +267,14 @@ configuration that you do not want to share to all working trees:
  - `core.sparseCheckout` is recommended per working tree, unless you
    are sure you always use sparse checkout for all working trees.
 
+ - Most configuration variables under `submodule` group in superproject
+   should not be shared.
++
+------------
+$ git config --local --move-to --worktree submodule.active
+$ git config --local --move-to-regexp --worktree 'submodule\..*\..*'
+------------
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 57999e9f36..d91817b45d 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -222,6 +222,23 @@ submodule active pathspec, which specifies that any submodule
 starting with 'b' except 'baz' are also active, regardless of the
 presence of the .url field.
 
+MULTIPLE WORKING TREE SUPPORT
+-----------------------------
+When you have more than one working tree, created by
+linkgit:git-worktree[1], submodules will not work on any working tree
+until `extensions.worktreeConfig` is enabled. Since this config
+affects more than just submodules, please see "CONFIGURATION FILE"
+section for more information before turning it on.
+
+Once on, submodules can be added in any working tree. The submodule
+itself though cannot have more than one working tree.
+
+When submodules are created in a working tree, their git directory is
+also per-worktree, e.g. inside
+'$GIT_COMMON_DIR/worktrees/<worktree>/modules' and not shared with
+other working trees. This means if you have the same submodule on
+different working trees, you need disk space for multiple clones.
+
 Workflow for a third party library
 ----------------------------------
 
-- 
2.20.0.482.g66447595a7

