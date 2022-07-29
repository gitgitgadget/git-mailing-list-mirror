Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C2C19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiG2I0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiG2I0I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFAF29812
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b26so5126528wrc.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7LImTpMeZre5xONIcSThNBzpaeQWZNQ0EgJusBjmPyY=;
        b=oxZUr95fbHpr1S6Uma6xHbvklkVERx6Kt2kQwa3Gg+lkJg8lsHushtGn5/ITu1dfon
         XjB/fwaX37wfCiVtESV/rfvQfYsYjDf6swR3Wa/+A5c6Zp1B4yvOZA87ARLeURDVrzt+
         qDy+w32XSYeFLfHwY5Ub+P335QYZCFKZztfXa+jT9rocls0E9QHgXcTYR3xIQ5TBRyrv
         jg/V2R/mX6BHZPZxkzuYeFMmhwOgBIQ3t6rbuEIPtsGrwzW5kaNiE66W2zA93zDrLhDR
         7mNkBi6m+vG9IXqp/UVHKBnQ0B+UGptxtf6hNyCeJjC1vqwcpu+HzBFHt8QSa+CQbstC
         5C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7LImTpMeZre5xONIcSThNBzpaeQWZNQ0EgJusBjmPyY=;
        b=262tqDuI39BjrtK/5K0kg3tbbvUDn94FEFsCVgmFJXe5tYVBC0d2lkZPtBlC6FhfBp
         K4t+KCOqWu0udbPWTczQXx1BTBGcXzRNZeHAPsgua/3wWWbbCm/XPVTYqsX8HJ8wtNOX
         tWzJjuFbYmo8H4W2DS0QqWyNVx0UMN9q+TnWTx5kruKEyPAZhe9dtTfaHTdjIds3y87F
         hmFZCusint9GWsGvmNGxqW2y/HJ6Q82IpLDPfVPIrEFo27wKHJWuePoX2bAAq1bsf1TB
         vNLcus7yp8URTQA5BOUVadKc4YeHSXsXNv/GnW4/UdZ0orievEQ6x7M10fAjH676tfyu
         h4/Q==
X-Gm-Message-State: ACgBeo2l8LaGWenM8plVBXceUCVMcEsbdZhxEHwewM8wzlKaocFWKw+e
        Oo/9eFMrzds/y9lNFhpEp9oxOSz5NGXhtA==
X-Google-Smtp-Source: AA6agR6wALlGLAd03bjDVitsMhHzI/0g//nmBh05TTFU6g0DkMzW50AwaYF9aWLChiu6v+uZdfXTPg==
X-Received: by 2002:a05:6000:1b85:b0:21f:93d:a23d with SMTP id r5-20020a0560001b8500b0021f093da23dmr1628585wru.286.1659083164109;
        Fri, 29 Jul 2022 01:26:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:26:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] docs: add CONFIGURATION sections that map to a built-in
Date:   Fri, 29 Jul 2022 10:25:54 +0200
Message-Id: <patch-v2-8.9-5c379ab1476-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
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
index 11eb70f16c7..36da8bf9b51 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -431,6 +431,13 @@ they will make the patch impossible to apply:
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
index 09107fb1067..7ccb46b660c 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -261,6 +261,13 @@ This command can run `applypatch-msg`, `pre-applypatch`,
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
index 632bd1348ea..b9ee8a87238 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -363,6 +363,13 @@ $ cd my-linux
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
index e1f48c95b3c..5225f674546 100644
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
 
 GIT
 ---
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
index 8463fe9cf75..700f937f60a 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -145,6 +145,13 @@ EXAMPLES
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
2.37.1.1196.g8af3636bc64

