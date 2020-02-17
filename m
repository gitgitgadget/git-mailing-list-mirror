Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA35C35242
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEF720725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 04:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEmsIH1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBQExR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:53:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35427 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgBQExN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 23:53:13 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so17983889wrt.2
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 20:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fNHHYop37NoayjUMF4vkw/ZhMKFfXENYfUyVkavDQhE=;
        b=OEmsIH1w94mSFBE2jzKNNJ6ethd8dzx3qDoSeGxKLQeJm/kC1hiRllXwYyEFy4hW4U
         4QwL0VRFjk8LqcnA01RPXbWTtoMUXyObJWhK5XOZcdwGR9htCHmr6QvMaiSle4akFeeo
         h4ARCOH2BL4Sm70HWnr5a435enp657x0sF7xiHTB5paHfm3Slbs8HJgPPRvWb5pyVcAS
         LCDlIeVrfoQUt6YW9HhVfZsQhrPk60BLjDo7jdlRj2FYqUFBOjekJq+9tqdO7wQFIViC
         TKAm7iKkCbuOLb18ZRGm8sXSe2tlXMM9w/W2SvCmmk9hDuY5IalVmmtbaL+jE/T/rXYt
         PXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fNHHYop37NoayjUMF4vkw/ZhMKFfXENYfUyVkavDQhE=;
        b=tc30zFcfv0RgO2GPDO4hYSQxkpkISuLE31xG9sw4Ewwj/rLlH1LgKZ5LQ0ZwwrSTyW
         kcmie08jWgZverJ6pJzkyw9CdbxCQT8ZR3HBguECCQ+KgTXUjAmiBKq0tAFc2grhZbFO
         jjUTtbl3gYzQOWv2kYKDI7/w+EX1Vg1kmxN2OZERYJSH/Qu8vGmx3SA5cTTl1gkeP7z4
         uoBgZozkkUfqZNMkIAqGwOej3+9doPeSkuy3jPJdDLotCWVEZiMk2v6Fdslf5FkN/jKQ
         kyz+obb0DO64YqKZbrdUtNWvi9EEv4DqljQlo0kSgc4MiTD7WuF6IoYlKimaNUc/sgSe
         DQXA==
X-Gm-Message-State: APjAAAXEalqvAgAbT38glQYzdysWhg1GhIR/pCyz+Y5Q+Q2V08GVAaiC
        gaUYTP8kJE/gBKdBvX2sMOKvx1is
X-Google-Smtp-Source: APXvYqy95ECmrSy3X4AAlD8kIBsUNG7T8zSS/ZxBAKQHmxab164ceIJ+4sxnPKCy2ieqx9wcZqmHug==
X-Received: by 2002:adf:a285:: with SMTP id s5mr20560877wra.118.1581915191523;
        Sun, 16 Feb 2020 20:53:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm19751836wrs.53.2020.02.16.20.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 20:53:11 -0800 (PST)
Message-Id: <70b2a20b4ebb09ccb85b576c212075ab1ca75601.1581915186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.555.git.1581915186.gitgitgadget@gmail.com>
References: <pull.555.git.1581915186.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 04:53:06 +0000
Subject: [PATCH 6/6] t/lib-submodule-update: add test removing nested
 submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The previous commit fixed a bug with the (no submodule) -> (nested
submodules) transition for commands in the unpack-trees machinery.

Let's add a test for the reverse transition (going from nested
submodules to no submodule), as it is not being tested currently.

While at it, uniformize the capitalization in the list of tests.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/lib-submodule-update.sh | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index ab30b2da24f..64fc6487dd9 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -297,7 +297,7 @@ test_submodule_content () {
 # - Directory containing tracked files replaced by submodule
 # - Submodule replaced by tracked files in directory
 # - Submodule replaced by tracked file with the same name
-# - tracked file replaced by submodule
+# - Tracked file replaced by submodule
 #
 # The default is that submodule contents aren't changed until "git submodule
 # update" is run. And even then that command doesn't delete the work tree of
@@ -621,12 +621,13 @@ test_submodule_forced_switch () {
 # - Directory containing tracked files replaced by submodule
 # - Submodule replaced by tracked files in directory
 # - Submodule replaced by tracked file with the same name
-# - tracked file replaced by submodule
+# - Tracked file replaced by submodule
 #
 # New test cases
 # - Removing a submodule with a git directory absorbs the submodules
 #   git directory first into the superproject.
 # - Switching from no submodule to nested submodules
+# - Switching from nested submodules to no submodule
 
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
@@ -760,6 +761,21 @@ test_submodule_recursing_with_args_common() {
 		)
 	'
 
+	# Switching to a commit without nested submodules removes their worktrees
+	test_expect_success "$command: worktrees of nested submodules are removed" '
+		prolog &&
+		reset_work_tree_to_interested add_nested_sub &&
+		(
+			cd submodule_update &&
+			git branch -t no_submodule origin/no_submodule &&
+			$command no_submodule &&
+			test_superproject_content origin/no_submodule &&
+			! test_path_is_dir sub1 &&
+			test_must_fail git config -f .git/modules/sub1/config core.worktree &&
+			test_must_fail git config -f .git/modules/sub1/modules/sub2/config core.worktree
+		)
+	'
+
 	########################## Modified submodule #########################
 	# Updating a submodule sha1 updates the submodule's work tree
 	test_expect_success "$command: modified submodule updates submodule work tree" '
-- 
gitgitgadget
