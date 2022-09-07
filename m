Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4127BC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 08:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIGI1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIGI13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 04:27:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE815AB431
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 01:27:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h1so8295977wmd.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WNUJeWwSoOrE/4m5pccXfSLDKCodvBiAErFRIS+lx0M=;
        b=oUhO2h6zNV7INQHeK3hmbfZ8/K9iNyKcdTUQjs9qcxXDimMhOw8D47QHKKIhut36uw
         2utXIvlo2os4mdtihAh5KAi/V1m8iVebj/DjsQWW0JPzggaoveOJcLluWi/GTTPESAR/
         5vJndTtrDd9H9NPUhIaj5JWw2d9qhD+9KNB3712N+zTuBRoaez0NlhiXnoQxRtH7Fekf
         q44hef4NkNSfJj+Rhdf2fBm5IZE/zYQboBV53LOrzgLvn2UfZTRbSj2m2LK+0gpoZKxn
         KJfTss0+LHXs1c5Euqe2AyJ6kTe3RI3LLZ4koo8Cjh8B50qHGlZLw6XZEz3zmp8ZWS38
         bHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WNUJeWwSoOrE/4m5pccXfSLDKCodvBiAErFRIS+lx0M=;
        b=wxYLiILL/7UCXXaNorXFVuNUIg3OGBHjAZo9awGD+Mu26ze+MCD27l8RuBYIZCHEss
         PC4g5JaOaDBGEBWTbEzxH3HyXV9AYV+9LuneADu6hJ46OLF0ZvDlwwnq9cp3qH76VT73
         pthwW4BSd4ZgieBmwixJd9ycPx+KrjbrlsFB+XcEgF9XnvXQmGvUp1q1Hc1QA9Z3I1ao
         uzYii4PMagTlj+HYpepUP3IyrlZ0xTaZNhUeJP9xvJPbC8HIvUx5yjs/SCHre8hxx9+u
         uHp6GcD6lJZedDbmniyfbvlob839g6X6inoVuBnYbhGtpdOo/Z1/eNZpQPTngz1lsIV8
         75dA==
X-Gm-Message-State: ACgBeo2p/lN5mDxkrYkd3QIT6wCSwPH7EfOwjjH4DK6Ul7cB7na06TjD
        9Q4Ve18fWKMyjt/BXCxkf8duPCW4WNjcBg==
X-Google-Smtp-Source: AA6agR4M+YSqUGqKWCsV7mvhlgYl4LwCZ6QwkYAuY1IeIVZGYNk9hQ4GKmr232U728XZHDCFkignuA==
X-Received: by 2002:a05:600c:22c7:b0:3a6:68e4:1e5f with SMTP id 7-20020a05600c22c700b003a668e41e5fmr1283928wmg.46.1662539239701;
        Wed, 07 Sep 2022 01:27:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a3170a7af9sm19532096wmq.4.2022.09.07.01.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:27:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 8/9] docs: add CONFIGURATION sections that map to a built-in
Date:   Wed,  7 Sep 2022 10:27:04 +0200
Message-Id: <patch-v4-8.9-929fd693bdf-20220907T082419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1490.g9adf4224da0
In-Reply-To: <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220907T082419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a CONFIGURATION section to the documentation of various built-ins,
for those cases where the relevant config/NAME.txt describes
configuration that is only used by the relevant built-in documented in
git-NAME.txt. Subsequent commits will handle more complex cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-add.txt          | 7 +++++++
 Documentation/git-am.txt           | 7 +++++++
 Documentation/git-clean.txt        | 7 +++++++
 Documentation/git-clone.txt        | 7 +++++++
 Documentation/git-commit-graph.txt | 7 +++++++
 Documentation/git-commit.txt       | 4 ++++
 Documentation/git-fast-import.txt  | 7 +++++++
 Documentation/git-mailinfo.txt     | 7 +++++++
 Documentation/git-maintenance.txt  | 7 +++++++
 Documentation/git-push.txt         | 7 +++++++
 Documentation/git-revert.txt       | 7 +++++++
 Documentation/git-show-branch.txt  | 7 +++++++
 Documentation/git-stash.txt        | 7 +++++++
 13 files changed, 88 insertions(+)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 9b37f356542..a030d33c6e7 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -433,6 +433,13 @@ they will make the patch impossible to apply:
 * deleting context or removal lines
 * modifying the contents of context or removal lines
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/add.txt[]
+
 SEE ALSO
 --------
 linkgit:git-status[1]
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 320da6c4f76..326276e51ce 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -258,6 +258,13 @@ This command can run `applypatch-msg`, `pre-applypatch`,
 and `post-applypatch` hooks.  See linkgit:githooks[5] for more
 information.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/am.txt[]
+
 SEE ALSO
 --------
 linkgit:git-apply[1].
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index a7f309dff5a..91742633fa8 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -133,6 +133,13 @@ help::
 
   Show brief usage of interactive git-clean.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/clean.txt[]
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index d032d971dd7..1c3d7017646 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -370,6 +370,13 @@ $ cd my-linux
 $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
 ------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/clone.txt[]
+
 
 GIT
 ---
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 047decdb65b..36fe56c2c71 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -142,6 +142,13 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 ------------------------------------------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/commitgraph.txt[]
+
 
 FILE FORMAT
 -----------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6c60bf98f9f..225c6c9f2e5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -557,6 +557,10 @@ The editor used to edit the commit log message will be chosen from the
 `VISUAL` environment variable, or the `EDITOR` environment variable (in that
 order).  See linkgit:git-var[1] for details.
 
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/commit.txt[]
+
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 39cfa05b28b..8b5dd6add00 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1564,6 +1564,13 @@ operator can use this facility to peek at the objects and refs from an
 import in progress, at the cost of some added running time and worse
 compression.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/fastimport.txt[]
+
 SEE ALSO
 --------
 linkgit:git-fast-export[1]
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3fcfd965fde..28060283c70 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -115,6 +115,13 @@ If no such configuration option has been set, `warn` will be used.
 <patch>::
 	The patch extracted from e-mail.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/mailinfo.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index e56bad28c65..9c630efe19c 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -397,6 +397,13 @@ If you want to customize the background tasks, please rename the tasks
 so future calls to `git maintenance (start|stop)` do not overwrite your
 custom tasks.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/maintenance.txt[]
+
 
 GIT
 ---
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2f25aa3a291..def7657ef9c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -692,6 +692,13 @@ a `git gc` command on the origin repository.
 
 include::transfer-data-leaks.txt[]
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/push.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 0105a54c1a5..5016755efb6 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -142,6 +142,13 @@ EXAMPLES
 	changes. The revert only modifies the working tree and the
 	index.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/revert.txt[]
+
 SEE ALSO
 --------
 linkgit:git-cherry-pick[1]
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 5cc2fcefbab..e5ec6b467f9 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -199,6 +199,13 @@ shows 10 reflog entries going back from the tip as of 1 hour ago.
 Without `--list`, the output also shows how these tips are
 topologically related with each other.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/showbranch.txt[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 6e15f475257..c5d70918283 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -382,6 +382,13 @@ grep commit | cut -d\  -f3 |
 xargs git log --merges --no-walk --grep=WIP
 ----------------------------------------------------------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.txt[]
+
+include::config/stash.txt[]
+
 
 SEE ALSO
 --------
-- 
2.37.3.1490.g9adf4224da0

