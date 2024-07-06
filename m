Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B412B9B9
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720300454; cv=none; b=Y0et21Raz9GTQlVOMGSabIPOXVSNHFSNcRFuyTss8I1gp/L5xsUp045bwE1AEQWAoOQbIQs0L3GxqNy76tDiU1kXLs3Evicdu4kZBpGmYvDQz4lGmP3ATdRU0nBrrneVrCkHnaAz6xr8LzFE68/udAJa+7PVqmM6hZj1SPsOMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720300454; c=relaxed/simple;
	bh=PNSzVKEuRZc6xkl4r+TZSrEPYBeP+MCEuF1kPAAp7uI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gu+sF/xKI55YegR0BFWcYMdEvZjoUQg2WcaOxfvqEYjrzBeo1BcLKJ7yyaMBUA8ApGedxegoyoEHS7cnQjET+H3eFwlrAodANMlwe+EJ+w7aIHpqQwmIo1vjeW1Jbq5rlATGRinK9ckaL/NTXAIpdCwl4xAqcLtOKZW7xHOxAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sf.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpdvRVg5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sf.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpdvRVg5"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b5cf1b8b94so14542796d6.0
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720300451; x=1720905251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SD2dyHht33a0wPVPwu5q3Yp1FvqYwpDuwLCfjxYEGwc=;
        b=QpdvRVg53V2oH2G3JaC5KiFAggUYKhCzFSgvqvkWvFnCNo3q4jFlE9xzLWuEdGXzNk
         Bt57/TcGk7sfejM4+XbvoXcBCkeC5esueMEU1l4yyvFOq1ORCyjXeONUskPyU2gYsilo
         k7T4KeBt2+GxKxyEY0ikuRuwxnxtMnp4tXrEp07py1lW8afXl2KKe/DJ9CZhn8pyu2lm
         7VeH6gj0d3beVWFQfi63xfiGT1OTytn3d13KulLbYksyyvmx7bCh/AhL1v8SxJUNSiW+
         1Au8rp7PlmSNbXzUQ/0LpW4TDM3RbIrht1wy/iP/Wz89j6/nMMp23BQz+6CvzXFI+obY
         qJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720300451; x=1720905251;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SD2dyHht33a0wPVPwu5q3Yp1FvqYwpDuwLCfjxYEGwc=;
        b=rEj0+HsBdeywwFB20mfVTMSn7+5rwcryXN/aP26mHVLNq6LaV2GqVuSNWlpM6w2of8
         lC+nmZaVrf0/i7KFvAPBbRBVeQ0fQ9S7jM6bP33Kee41Tjez9ZrVGN7xILCQHeKq/rJQ
         83UhZsMPPTd0mK9rxpFtr+3ILy1SGNVWeK7x86HvS9KjPNXilngX/MiAXac0KeMmqiX+
         0atmtEJXSeJ08d77u5JyEynIgMLS2KyJ95mEGzzRcYKnuqDQhKCBOhsIWPWuqXYT2tFZ
         qCgxquvzl69TLAkd8pdOg7ETILtU6Qz4szyLOEthjxZZ/jlKPermUb/AAZx34wW8LgUh
         MYGw==
X-Gm-Message-State: AOJu0Yz86Hzh7kHyCEYF+x/oDcLZz4lTG+QXoEWkOugycg/I3X5xexbc
	83/pAxwOriXlS+6Nymr/7SxmE1rbvXRro9Cwy7Qzd5xzsF1gU6VQu9b6fQ==
X-Google-Smtp-Source: AGHT+IG/5kAjPM9hQbSNHkmBhhtCNGXkAuZvJEFB+jPczPmVKdQG+4+K41W1X/hyufZxneVLv+sNpA==
X-Received: by 2002:a05:6214:20ce:b0:6b5:9fac:6d41 with SMTP id 6a1803df08f44-6b5ecfab582mr127653096d6.16.1720300450629;
        Sat, 06 Jul 2024 14:14:10 -0700 (PDT)
Received: from opti.lan (pool-108-29-69-175.nycmny.fios.verizon.net. [108.29.69.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5e1ed94e5sm38356696d6.17.2024.07.06.14.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 14:14:10 -0700 (PDT)
Sender: j j <gonch.dmitry@gmail.com>
From: dgoncharov@users.sf.net
To: git@vger.kernel.org
Cc: newren@gmail.com,
	Dmitry Goncharov <dgoncharov@users.sf.net>
Subject: [PATCH] merge-ort: fix a crash in process_renames
Date: Sat,  6 Jul 2024 17:14:07 -0400
Message-Id: <20240706211407.512652-1-dgoncharov@users.sf.net>
X-Mailer: git-send-email 2.34.1
Reply-To: dgoncharov@users.sf.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Goncharov <dgoncharov@users.sf.net>

cherry-pick --strategy=ort (the default at the moment) crashes in the following
scenario

$ ls -a
.  ..
$ mkdir tools
$ git init -q -b side2
$ echo hello>tools/hello
$ git add  tools/hello
$ git commit -q tools/hello -m'Add tools/hello.'
$ git branch side1
$ echo world>world
$ git add world
$ git commit -q world -m'Add world.'
$ git mv  world tools/world
$ git commit -q -m'mv world tools/world.'
$ git checkout -q side1
$ git mv tools/hello hello
$ git commit -q -m'mv tools/hello hello.'
$ git cherry-pick --strategy=ort side2
git: merge-ort.c:3006: process_renames: Assertion `source_deleted || oldinfo->filemask & old_sidemask' failed.
Aborted (core dumped)

While cherry picking the top commit from side2 to side1 collect_renames is
confused by the preceding move from "tools/hello" to "hello" that took place on
side1. This move from "tools/hello" to "hello" causes the logic in
check_for_directory_rename to incorrectly conclude that "tools/world" should be
renamed to "world".  detect_and_process_renames proceeds with "world" instead
of "tools/world" and ends up tripping on an assertion in process_renames.

In the same scenario cherry-pick --strategy=recursive detects a merge conflict.

$ rm .git/index.lock
$ git reset -q --hard
$ git cherry-pick --strategy=recursive side2
CONFLICT (file location): world renamed to tools/world in fead592 (mv world tools/world.), inside a directory that was renamed in HEAD, suggesting it should perhaps be moved to world.
CONFLICT (content): Merge conflict in world
error: cache entry has null sha1: world
error: cherry-pick: Unable to write new index file
fatal: cherry-pick failed

There really is a merge conflict and the goal of this commit is to have
cherry-pick --strategy=ort detect the conflict.  This commit modifies
collect_renames to ignore an implicit directory rename that suggests moving a
file to itself.

Also, see test t3515-cherry-pick-move.sh.

Signed-off-by: Dmitry Goncharov <dgoncharov@users.sf.net>
---
 merge-ort.c                 |  9 +++++++
 t/t3515-cherry-pick-move.sh | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100755 t/t3515-cherry-pick-move.sh

diff --git a/merge-ort.c b/merge-ort.c
index 691db9050e..e58fb7a7fa 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3369,6 +3369,15 @@ static int collect_renames(struct merge_options *opt,
 						      collisions,
 						      &clean);
 
+		if (new_path && !strcmp(new_path, p->one->path)) {
+			/* Ignore an implicit directory rename that suggests replacing a move
+			 * from one->path to two->path with a move
+			 * from one->path to one->path.
+			 */
+			free(new_path);
+			new_path = NULL;
+		}
+
 		possibly_cache_new_pair(renames, p, side_index, new_path);
 		if (p->status != 'R' && !new_path) {
 			pool_diff_free_filepair(&opt->priv->pool, p);
diff --git a/t/t3515-cherry-pick-move.sh b/t/t3515-cherry-pick-move.sh
new file mode 100755
index 0000000000..20af478d4e
--- /dev/null
+++ b/t/t3515-cherry-pick-move.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='Test cherry-picking a move commit.'
+
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=side2
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir tools &&
+
+	echo hello >tools/hello &&
+
+	git add tools/hello &&
+	git commit -m"Add tools/hello." tools/hello &&
+
+	git branch side1 &&
+
+	# This commit is the base of the fatal cherry-pick merge.
+	echo world >world &&
+	git add world &&
+	git commit -m"Add world." &&
+
+	# Cherry picking this commit crashes git.
+	# This commit is side 2 of the fatal cherry-pick merge.
+	git mv -v world tools/world &&
+	git commit -m"mv world tools/world." &&
+
+	git checkout side1 &&
+	# This commit is side 1 of the fatal cherry-pick merge.
+	git mv -v tools/hello hello &&
+	git commit -m"mv tools/hello hello"
+'
+
+test_expect_success 'recursive cherry-pick of a move commit' '
+	test_must_fail git cherry-pick --strategy=recursive side2
+'
+
+test_expect_success 'ort cherry-pick of a move commit' '
+	rm -f world &&
+	git reset --hard &&
+	test_must_fail git cherry-pick --strategy=ort side2
+'
+
+test_done
-- 
2.34.1

