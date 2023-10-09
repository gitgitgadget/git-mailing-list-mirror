Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726F3E95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 10:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbjJIKzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346077AbjJIKzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 06:55:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540AA3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 03:55:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so7494384a12.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696848944; x=1697453744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oShj0GWwwQtFp2tY5URs9CfnWxZ+8O3OPL0Zr+7YEks=;
        b=dBc1Pd39UPneI4qJoBydfEDmmRVT1Jlw2yQR5/QgheMJMQMrBPvdg1Kz4kr/Vg5+Kp
         MvUHXNQ1C3RmADtT2cFxiqpNNuW/nr7xd4DpuZtmy7YryuEB3AVJwmn+LXvx8yV5Upbv
         uDFYMWobJCDng1vxvSTdvsd40b3Yn9h2qjkKldZERRHG48Z0adzNyLcUT6UYo9vvW352
         sh8/LmktzKOwR+dpo3Tsv6ycNjuQqQdXpYlN36b2Y/AgmustdN4BiDlMLsNQU67W7Oke
         dnNi6Drb6OwEo1ziDvPGBkRQjIO3t0I8thDVdzfNJ27Ain66r03FPM2PwvHK0CIrKgvj
         AcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696848944; x=1697453744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oShj0GWwwQtFp2tY5URs9CfnWxZ+8O3OPL0Zr+7YEks=;
        b=fihJoYzTqqM89ENQehaT911YD+lckS/sBQqCcpIqO+bX7gVQGsqpFT40Btf63fOxmp
         HTskkjcMqEYtLBDHwVqoAm56mj4IInvEMMByHQunSsK1LJrRy0fMPYSRakePldfcDzV9
         rHBIsAbf++zxmUWSMMLev7Ro8Ksm/MvfwAUlBIej1eUgrFbhd7uY9Pmy2Bvu+EMCsOsZ
         MkPQuvy0UiJbioBr7V8by3Ql/plKSRzqWkFcBWKAKXjvSYG6NaPImjQm+CtUBbv3vm2z
         Zadwnk4LbbRRDiwOjjB+an/T++hMHjMQuXEZ0YrEIG9J/B33FBDz5x5cfGulFHpQ2LEO
         OlwA==
X-Gm-Message-State: AOJu0Yw8HCBBj3OFkL612bFDbro7GGScFh7sTH+nJJ5QLrTMNDnfRMDj
        XRjqX1K7fN0ZTXBP/k+OCLUO5xQht0N6lQ==
X-Google-Smtp-Source: AGHT+IHm/TkGNojqiSGxzE2yvN7qRQ7kKO2MF2fiZ0qIto/NR1LCNrGk4gs4PK0VQwMZ1OYQTweYaw==
X-Received: by 2002:a05:6402:785:b0:523:ae0a:a446 with SMTP id d5-20020a056402078500b00523ae0aa446mr15552725edy.24.1696848943550;
        Mon, 09 Oct 2023 03:55:43 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:47bc:9393:72b0:bdf2])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b005331f6d4a30sm5906800edb.56.2023.10.09.03.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:55:43 -0700 (PDT)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 3/3] rev-list: add commit object support in `--missing` option
Date:   Mon,  9 Oct 2023 12:55:28 +0200
Message-ID: <20231009105528.17777-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009105528.17777-1-karthik.188@gmail.com>
References: <20231009105528.17777-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--missing` object option in rev-list currently works only with
missing blobs/trees. For missing commits the revision walker fails with
a fatal error.

Let's extend the functionality of `--missing` option to also support
commit objects. This is done by adding a new `MISSING` flag that the
revision walker sets whenever it encounters a missing tree/commit. The
revision walker will now continue the traversal and call `show_commit()`
even for missing commits. In rev-list we can then check for this flag
and call the existing code for parsing `--missing` objects.

A scenario where this option would be used is to find the boundary
objects between different object directories. Consider a repository with
a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
repository, using the `--missing=print` option while disabling the
alternate object directory allows us to find the boundary objects
between the main and alternate object directory.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/rev-list.c          |  6 +++
 object.h                    |  2 +-
 revision.c                  |  9 ++++-
 revision.h                  |  3 ++
 t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 3 deletions(-)
 create mode 100755 t/t6022-rev-list-missing.sh

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 98542e8b3c..604ae01d0c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -149,6 +149,12 @@ static void show_commit(struct commit *commit, void *data)
 
 	display_progress(progress, ++progress_counter);
 
+	if (revs->do_not_die_on_missing_objects &&
+	    commit->object.flags & MISSING) {
+		finish_object__ma(&commit->object);
+		return;
+	}
+
 	if (show_disk_usage)
 		total_disk_usage += get_object_disk_usage(&commit->object);
 
diff --git a/object.h b/object.h
index 114d45954d..12913e6116 100644
--- a/object.h
+++ b/object.h
@@ -62,7 +62,7 @@ void object_array_init(struct object_array *array);
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------27
+ * revision.h:               0---------10         15             22------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
diff --git a/revision.c b/revision.c
index e789834dd1..615645d3d1 100644
--- a/revision.c
+++ b/revision.c
@@ -1168,7 +1168,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
 		int gently = revs->ignore_missing_links ||
-			     revs->exclude_promisor_objects;
+			     revs->exclude_promisor_objects ||
+			     revs->do_not_die_on_missing_objects;
 		if (repo_parse_commit_gently(revs->repo, p, gently) < 0) {
 			if (revs->exclude_promisor_objects &&
 			    is_promisor_object(&p->object.oid)) {
@@ -1176,7 +1177,11 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 					break;
 				continue;
 			}
-			return -1;
+
+			if (!revs->do_not_die_on_missing_objects)
+				return -1;
+			else
+				p->object.flags |= MISSING;
 		}
 		if (revs->sources) {
 			char **slot = revision_sources_at(revs->sources, p);
diff --git a/revision.h b/revision.h
index c73c92ef40..07906bc3bc 100644
--- a/revision.h
+++ b/revision.h
@@ -41,6 +41,9 @@
 /* WARNING: This is also used as REACHABLE in commit-graph.c. */
 #define PULL_MERGE	(1u<<15)
 
+/* WARNING: This is also used as NEEDS_BITMAP in pack-bitmap.c. */
+#define MISSING         (1u<<22)
+
 #define TOPO_WALK_EXPLORED	(1u<<23)
 #define TOPO_WALK_INDEGREE	(1u<<24)
 
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
new file mode 100755
index 0000000000..bbff66e4fc
--- /dev/null
+++ b/t/t6022-rev-list-missing.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='handling of missing objects in rev-list'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# We setup the repository with two commits, this way HEAD is always
+# available and we can hide commit 1.
+test_expect_success 'create repository and alternate directory' '
+	test_commit 1 &&
+	test_commit 2
+'
+
+for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+do
+	test_expect_success "rev-list --missing=error fails with missing object $obj" '
+		oid="$(git rev-parse $obj)" &&
+		path=".git/objects/$(test_oid_to_path $oid)" &&
+
+		mv "$path" "$path.hidden" &&
+		test_when_finished "mv $path.hidden $path" &&
+
+		test_must_fail git rev-list --missing=error --objects \
+			--no-object-names HEAD
+	'
+done
+
+for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
+do
+	for action in "allow-any" "print"
+	do
+		test_expect_success "rev-list --missing=$action with missing $obj" '
+			oid="$(git rev-parse $obj)" &&
+			path=".git/objects/$(test_oid_to_path $oid)" &&
+
+			# Before the object is made missing, we use rev-list to
+			# get the expected oids.
+			git rev-list --objects --no-object-names \
+				HEAD ^$obj >expect.raw &&
+
+			# Since both the commits have the `1.t` blob, rev-list
+			# will print it since its reachable from either commit. Unless
+			# the blob itself is missing.
+			if [ $obj != "HEAD:1.t" ]; then
+				echo $(git rev-parse HEAD:1.t) >>expect.raw
+			fi &&
+
+			mv "$path" "$path.hidden" &&
+			test_when_finished "mv $path.hidden $path" &&
+
+			git rev-list --missing=$action --objects --no-object-names \
+				HEAD >actual.raw &&
+
+			# When the action is to print, we should also add the missing
+			# oid to the expect list.
+			case $action in
+			allow-any)
+				;;
+			print)
+				grep ?$oid actual.raw &&
+				echo ?$oid >>expect.raw
+				;;
+			esac &&
+
+			sort actual.raw >actual &&
+			sort expect.raw >expect &&
+			test_cmp expect actual
+		'
+	done
+done
+
+
+test_done
-- 
2.41.0

