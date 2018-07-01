Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204561F516
	for <e@80x24.org>; Sun,  1 Jul 2018 04:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeGAELq (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 00:11:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33875 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeGAELh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 00:11:37 -0400
Received: by mail-oi0-f67.google.com with SMTP id c2-v6so11889341oic.1
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 21:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5e4Lk1ZSdy0g93NIAllZ5DVHT/OBqr9gNiUai/pWDBk=;
        b=CWLHyv2GDwh7GI+OY+njGgYSLprIt0BCS1HEmaLtQ8NBxmRMlC35YbC3WdGgT2jN3v
         ybxx1LBDMWGl4+dAvhOwUM5TmEoBG+9kjXaHBXElvEd5PvRdkDXlY2ZFfeJsus8ppquP
         l8gNrQht2LyGOczuiubaFAazytq1xJ/F2DMtnNBGHfd1VnqftXLE1n9Jsk1kL/Xxt3ub
         W9jd9tXKMwzBtlr9F2Ciix6qPMPPXGKqN8FZ7e9JLOMa+uNisny5/1qRoXkeW0Tdbg/Q
         MmjaWsV8aNzbTZeqx1TPFCMnmd1J0v4MgJJUGywZluuVPyD0UuPN3ML82M2M3kx5gD7k
         /wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5e4Lk1ZSdy0g93NIAllZ5DVHT/OBqr9gNiUai/pWDBk=;
        b=fwwtpZJkwQwf/oxvQT0BgoEqHRXphmMfwSSfO1Ig8ddk9Qy7KHd1BW5p+oa/zQFhD4
         AatWhcZBggy+iLiH6/7bQJmODqF6XIRSScffpF+DZFOkqS98RfswKIQdra8J2Odyryf4
         X8ThJclmC0s/kC8NzRdlNvIt3VDq9oIGkKRhsMISk+16VMTvKOd71iceKd9zoKMLocDv
         4U5sGvpP243VXmmG/niq3t6pFbD0rOUvZVvtCqNMyYfYdtOoDloVE3vqi6DnAmoGx002
         DoqH8GnvBpMIXYe8gH8YPmimJLf5dG3uAJSwYX7pdQxmJ241Y3K8zJ4zHTWyKSFUUgK3
         rwEw==
X-Gm-Message-State: APt69E1i7nr5qeZ3SlwX1ul/m7H7XG1lsJ6pjips6AclJVKerQ/NwuY5
        UAFnBVzwNU3eJyNsSMJhh6TIyg==
X-Google-Smtp-Source: AAOMgpdMbtKQNhIgYEiXdUnIWoMxnZ4PS9Ryo/1Y+8u22VbPsPTfgmPJAwUv0YSFDPJ4oF09w0OkNg==
X-Received: by 2002:aca:52d1:: with SMTP id g200-v6mr2516501oib.134.1530418296318;
        Sat, 30 Jun 2018 21:11:36 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id m3-v6sm6222677oif.26.2018.06.30.21.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 21:11:35 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/6] t6036: add a failed conflict detection case with conflicting types
Date:   Sat, 30 Jun 2018 21:11:21 -0700
Message-Id: <20180701041122.8753-6-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
In-Reply-To: <20180701041122.8753-1-newren@gmail.com>
References: <20180701041122.8753-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 75 +++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index e920c7505..8b997d7e5 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1114,4 +1114,79 @@ test_expect_failure 'check submodule add/add' '
 	)
 '
 
+#
+# criss-cross with conflicting entry types:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: nothing of note
+#   Commit B: introduce submodule 'path'
+#   Commit C: introduce symlink 'path'
+#   Commit D: merge B&C, resolving in favor of B
+#   Commit E: merge B&C, resolving in favor of C
+#
+# This is an obvious add/add conflict for 'path'.  Can git detect it?
+
+test_expect_success 'setup conflicting entry types (submodule vs symlink)' '
+	test_create_repo submodule-symlink-add-add &&
+	(
+		cd submodule-symlink-add-add &&
+
+		test_create_repo path &&
+		(
+			cd path &&
+			touch file-B &&
+			git add file-B &&
+			git commit -m B &&
+			git tag B
+		) &&
+
+		touch irrelevant-file &&
+		git add irrelevant-file &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git -C path reset --hard B &&
+		git add path &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		rm -rf path/ &&
+		test_ln_s_add irrelevant-file path &&
+		git commit -m C &&
+
+		git checkout -q B^0 &&
+		git merge -s ours -m D C^0 &&
+		git tag D &&
+
+		git checkout -q C^0 &&
+		git merge -s ours -m E B^0 &&
+		git tag E
+	)
+'
+
+test_expect_failure 'check conflicting entry types (submodule vs symlink)' '
+	(
+		cd submodule-symlink-add-add &&
+
+		git checkout D^0 &&
+
+		test_must_fail git merge -s recursive E^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out
+	)
+'
+
 test_done
-- 
2.18.0.130.gd703bbb5d

