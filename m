Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A618050
	for <git@vger.kernel.org>; Mon, 25 May 2026 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738067; cv=none; b=Y4ZYCNnN2n88C4MiaZj8L1Tpm43+l2/Z58O5+hWmgmfPNecUCtWP/oYYVYPIzZO1RSwn3JfdZzh+dWFYGPShH8Ux8OvwsZ39CkeFvd7Be4y5cl/h31ZrxO6ebOtS0wNQ1HLj+3UI4G2s5zZe2nvF71eGtHeXLF8505CY9n7mS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738067; c=relaxed/simple;
	bh=Zn3vu4jeo7fC0OG3ZJ50GmPJlEGvxlRRJsg1LFomKjU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gHFZ6/XoKaN8MhXSMUXg8s+RowMObdAq9eiahvqHgJMN2Oos11SRofhc38kverPjq1QjTSgKDu9AxBphbKQJptX34nZLK6KcOTBXHJ5Jd7nXDaiNxPOjyO7aHhn3b82A9m7mj4Z21FBAYVBJMzNCiPtQBVAeAgPTQNGoTGrte20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quYJA+MJ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quYJA+MJ"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso9107327a34.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738064; x=1780342864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0gTTw/vKr2kyzUTLqAiTHEF/5vp4hw5HIvdl8TsoHw=;
        b=quYJA+MJ/u1v6Dc1LfppFlN0BxJmLS7Q7Ept+t2jQz65277XsySCJhBpHAd79XZ/Cz
         DBy51+Ll3WPvKba+WzG38/Tc9TkWHV0pSbWPs+HbVRTC0HmpzywdglfiMEXU9LgJoTyL
         CHvur2J7Y6vlHEVmZXALTMRqWR0sy1jWQatP3Rr4PYUoC6kkp0s/b8yICJDnIz3MrY9k
         aXJL6Cgliwx7FAx6rX9FjsNlGSY7tjkIhwR7HO4B11EV3hAbSzixmauPhrgB9SgAnUaV
         XnaVTN0lbU5X6h/xFNokX/YQM1blgAG/UmdB/7Yw4RDH7DOR2SPw90Wf7n4ANhBineC1
         uNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738064; x=1780342864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0gTTw/vKr2kyzUTLqAiTHEF/5vp4hw5HIvdl8TsoHw=;
        b=G4UmdYHjKWEepC8fyDyLRxh0cDBPnMKaQ+FlB9homftOJw0hdgD0XP8tBx1ClfOOF8
         C4AESHr6c6Xxn23vop3DlWAv4PZraOkfptancSsYboK8eB152fbhcxxj2ysHUdm6+B8p
         qdliqFSS4ETN3NENj9q4wU6lboRv4pnJ/zNm6r/lRLxRgYDHhjqiCYHnSEdtoTnMuMVU
         MV4urUlXjDZggh3UD5Dbif7Egtv/Ib+9UbjVgLq2rgjMt1onCyUV2vXBTsN5Fx15rw8v
         m4jKzwDL/03WaFfgbNOdPjbo9hhax7zirH8KBcowSZBEeyKK+46vQH545l8Wjejq+4nc
         8kOQ==
X-Gm-Message-State: AOJu0YwqEr4wrw2sKE6wu2IY26arm2XAbFWFtrf9VH0eCx+OOEXZhvE7
	F5dbUADMQGncKb9OpEHZVZEoEx5M+JZFdXgEDNAboRmHvs6weW2+6eV9gHqOJA==
X-Gm-Gg: Acq92OGOFVfsvS8m2lBKy/pNfW/ExQCcQob+koZaCsWQsgAlrJPU3K2v75aVLCgFHh3
	zPgsnSOqYrjPywA59FOOBPMEf5LXeAIok15s/NoIPUd5FUS29Gx3/RDhJuw7qqSs2kTrmVF6+aL
	qB7LNTVqmQ8o71HTFFDZ+BNR4pfnX9d9XIMTfEO+EMsnEs9Ml60/ZPAnpJfvj8Bk509yhDF54w4
	Vy4hQ+Spg8IwmQTH9aYiG6DPaPNdghw9I8LhupgG5P0tUax6pvJsCNl6DRfenp2Q1uPCq4nJlMD
	I1gyLnDBNMAtXy6ebIV95PA8qUPKxQaMX1NJV8uT5hmtH6tVoyeVp0dfD6fxcycHa8yYGjfytlR
	4VOfziSXkTF1AYCfh6CmkSLJhmffRycmXCDHreMqszZIejMg0RwordQyDkF+rjMQXISL1WRxHzc
	2OAIVnivKp6Bkq+7qfGZorcdAwSKM=
X-Received: by 2002:a05:6830:6a88:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7e5fee82afamr9647886a34.17.1779738064147;
        Mon, 25 May 2026 12:41:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.164.19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6065e5ed1sm8482209a34.14.2026.05.25.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:41:03 -0700 (PDT)
Message-Id: <7acfc5376e14fb3d69e06ab8a5ba68973bfe808f.1779738059.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com>
	<pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 19:40:57 +0000
Subject: [PATCH v2 2/3] line-log: integrate -L output with the standard
 log-tree pipeline
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

`git log -L` has bypassed log_tree_diff() and log_tree_diff_flush()
since the feature was introduced, short-circuiting from
log_tree_commit() directly into line_log_print().  This skips the
no_free save/restore (noted in a NEEDSWORK comment added by
f8781bfda3), the always_show_header fallback, show_diff_of_diff(),
and diff_free() cleanup.

Restructure so that -L flows through log_tree_diff() ->
log_tree_diff_flush(), the same path used by the normal
single-parent and merge diff codepaths:

 - Rename line_log_print() to line_log_queue_pairs() and strip it
   down to just queuing pre-computed filepairs.  The show_log(),
   separator, diffcore_std(), and diff_flush() calls are removed
   since log_tree_diff_flush() handles all of those.

 - In log_tree_diff(), call line_log_queue_pairs() then
   log_tree_diff_flush(), mirroring the diff_tree_oid() + flush
   pattern used by the single-parent and merge codepaths.

 - Remove the early return in log_tree_commit() that is no longer
   needed now that -L output flows through log_tree_diff() and
   log_tree_diff_flush(); this restores no_free save/restore,
   always_show_header, and diff_free() cleanup.

Because show_log() is now deferred until after diffcore_std() inside
log_tree_diff_flush(), pickaxe (-S, -G, --find-object) and
--diff-filter now properly suppress commits when all pairs are
filtered out.

The blank-line separator between commit header and diff changes
slightly: the old code printed one unconditionally, while
log_tree_diff_flush() only emits one for verbose headers.  This
matches the rest of log output.

Also reject --full-diff, which is not yet supported with -L: the
filepairs are pre-computed during the history walk and scoped to
tracked line ranges, so there is currently no full-tree diff to
fall back to for display.

Update tests accordingly.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 line-log.c                                    | 30 ++++-------
 line-log.h                                    |  2 +-
 log-tree.c                                    | 10 ++--
 revision.c                                    |  6 ++-
 t/t4211-line-log.sh                           | 53 ++++++++++++++-----
 t/t4211/sha1/expect.parallel-change-f-to-main |  1 -
 .../sha256/expect.parallel-change-f-to-main   |  1 -
 7 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/line-log.c b/line-log.c
index 858a899cd2..7ee55b05cc 100644
--- a/line-log.c
+++ b/line-log.c
@@ -13,7 +13,6 @@
 #include "revision.h"
 #include "xdiff-interface.h"
 #include "strbuf.h"
-#include "log-tree.h"
 #include "line-log.h"
 #include "setup.h"
 #include "strvec.h"
@@ -1004,29 +1003,18 @@ static int process_all_files(struct line_log_data **range_out,
 	return changed;
 }
 
-int line_log_print(struct rev_info *rev, struct commit *commit)
+void line_log_queue_pairs(struct rev_info *rev, struct commit *commit)
 {
-	show_log(rev);
-	if (!(rev->diffopt.output_format & DIFF_FORMAT_NO_OUTPUT)) {
-		struct line_log_data *range = lookup_line_range(rev, commit);
-		struct line_log_data *r;
-		const char *prefix = diff_line_prefix(&rev->diffopt);
-
-		fprintf(rev->diffopt.file, "%s\n", prefix);
-
-		for (r = range; r; r = r->next) {
-			if (r->pair) {
-				struct diff_filepair *p =
-					diff_filepair_dup(r->pair);
-				p->line_ranges = &r->ranges;
-				diff_q(&diff_queued_diff, p);
-			}
-		}
+	struct line_log_data *range = lookup_line_range(rev, commit);
+	struct line_log_data *r;
 
-		diffcore_std(&rev->diffopt);
-		diff_flush(&rev->diffopt);
+	for (r = range; r; r = r->next) {
+		if (r->pair) {
+			struct diff_filepair *p = diff_filepair_dup(r->pair);
+			p->line_ranges = &r->ranges;
+			diff_q(&diff_queued_diff, p);
+		}
 	}
-	return 1;
 }
 
 static int bloom_filter_check(struct rev_info *rev,
diff --git a/line-log.h b/line-log.h
index 04a6ea64d3..99e1755ce3 100644
--- a/line-log.h
+++ b/line-log.h
@@ -46,7 +46,7 @@ int line_log_filter(struct rev_info *rev);
 int line_log_process_ranges_arbitrary_commit(struct rev_info *rev,
 						    struct commit *commit);
 
-int line_log_print(struct rev_info *rev, struct commit *commit);
+void line_log_queue_pairs(struct rev_info *rev, struct commit *commit);
 
 void line_log_free(struct rev_info *rev);
 
diff --git a/log-tree.c b/log-tree.c
index 7e048701d0..88b3019293 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1105,6 +1105,12 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
 
+	if (opt->line_level_traverse) {
+		line_log_queue_pairs(opt, commit);
+		log_tree_diff_flush(opt);
+		return !opt->loginfo;
+	}
+
 	parse_commit_or_die(commit);
 	oid = get_commit_tree_oid(commit);
 
@@ -1179,10 +1185,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	opt->loginfo = &log;
 	opt->diffopt.no_free = 1;
 
-	/* NEEDSWORK: no restoring of no_free?  Why? */
-	if (opt->line_level_traverse)
-		return line_log_print(opt, commit);
-
 	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	shown = log_tree_diff(opt, commit, &log);
diff --git a/revision.c b/revision.c
index 4a8e24bc38..c903f7a1b4 100644
--- a/revision.c
+++ b/revision.c
@@ -3179,8 +3179,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
 
 	if (revs->line_level_traverse &&
-	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
-		die(_("-L does not yet support diff formats besides -p and -s"));
+	    (revs->full_diff ||
+	     (revs->diffopt.output_format &
+	      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT))))
+		die(_("-L does not yet support the requested diff format"));
 
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index aaf197d2ed..e3937138a9 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -368,7 +368,6 @@ test_expect_success '-L diff output includes index and new file mode' '
 
 test_expect_success '-L with --word-diff' '
 	cat >expect <<-\EOF &&
-
 	diff --git a/file.c b/file.c
 	--- a/file.c
 	+++ b/file.c
@@ -377,7 +376,6 @@ test_expect_success '-L with --word-diff' '
 	{
 	    return [-F2;-]{+F2 + 2;+}
 	}
-
 	diff --git a/file.c b/file.c
 	new file mode 100644
 	--- /dev/null
@@ -433,7 +431,6 @@ test_expect_success 'show line-log with graph' '
 	null_blob=$(test_oid zero | cut -c1-7) &&
 	qz_to_tab_space >expect <<-EOF &&
 	* $head_oid Modify func2() in file.c
-	|Z
 	| diff --git a/file.c b/file.c
 	| index $head_blob_old..$head_blob_new 100644
 	| --- a/file.c
@@ -445,7 +442,6 @@ test_expect_success 'show line-log with graph' '
 	| +    return F2 + 2;
 	|  }
 	* $root_oid Add func1() and func2() in file.c
-	ZZ
 	  diff --git a/file.c b/file.c
 	  new file mode 100644
 	  index $null_blob..$root_blob
@@ -494,23 +490,17 @@ test_expect_success '-L --find-object does not crash with merge and rename' '
 		--find-object=$(git rev-parse HEAD:file) >actual
 '
 
-# Commit-level filtering with pickaxe does not yet work for -L.
-# show_log() prints the commit header before diffcore_std() runs
-# pickaxe, so commits cannot be suppressed even when no diff pairs
-# survive filtering.  Fixing this would require deferring show_log()
-# until after diffcore_std(), which is a larger restructuring of the
-# log-tree output pipeline.
-test_expect_failure '-L -G should filter commits by pattern' '
+test_expect_success '-L -G should filter commits by pattern' '
 	git log --format="%s" --no-patch -L 1,1:file -G "nomatch" >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_failure '-L -S should filter commits by pattern' '
+test_expect_success '-L -S should filter commits by pattern' '
 	git log --format="%s" --no-patch -L 1,1:file -S "nomatch" >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_failure '-L --find-object should filter commits by object' '
+test_expect_success '-L --find-object should filter commits by object' '
 	git log --format="%s" --no-patch -L 1,1:file \
 		--find-object=$ZERO_OID >actual &&
 	test_must_be_empty actual
@@ -711,4 +701,41 @@ test_expect_success '-L with -G filters to diff-text matches' '
 	grep "F2 + 2" actual
 '
 
+test_expect_success '-L with --diff-filter=M excludes root commit' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --diff-filter=M --format=%s --no-patch >actual &&
+	# Root commit is an Add (A), not a Modify (M), so it should
+	# be excluded; only the modification commit remains.
+	echo "Modify func2() in file.c" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '-L with --diff-filter=A shows only root commit' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c --diff-filter=A --format=%s --no-patch >actual &&
+	echo "Add func1() and func2() in file.c" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '-L with -S suppresses non-matching commits' '
+	git checkout parent-oids &&
+	git log -L:func2:file.c -S "F2 + 2" --format=%s --no-patch >actual &&
+	# Only the commit that changes the count of "F2 + 2" should appear.
+	echo "Modify func2() in file.c" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--full-diff is not yet supported with -L' '
+	test_must_fail git log -L1,24:b.c --full-diff 2>err &&
+	test_grep "does not yet support" err
+'
+
+test_expect_success '-L --oneline has no extra blank line before diff' '
+	git checkout parent-oids &&
+	git log --oneline -L:func2:file.c -1 >actual &&
+	# Oneline header on line 1, diff starts immediately on line 2
+	sed -n 2p actual >line2 &&
+	test_grep "^diff --git" line2
+'
+
 test_done
diff --git a/t/t4211/sha1/expect.parallel-change-f-to-main b/t/t4211/sha1/expect.parallel-change-f-to-main
index 65a8cc673a..6d7a201036 100644
--- a/t/t4211/sha1/expect.parallel-change-f-to-main
+++ b/t/t4211/sha1/expect.parallel-change-f-to-main
@@ -5,7 +5,6 @@ Date:   Fri Apr 12 16:16:24 2013 +0200
 
     Merge across the rename
 
-
 commit 6ce3c4ff690136099bb17e1a8766b75764726ea7
 Author: Thomas Rast <trast@student.ethz.ch>
 Date:   Thu Feb 28 10:49:50 2013 +0100
diff --git a/t/t4211/sha256/expect.parallel-change-f-to-main b/t/t4211/sha256/expect.parallel-change-f-to-main
index 3178989253..c93e03bef4 100644
--- a/t/t4211/sha256/expect.parallel-change-f-to-main
+++ b/t/t4211/sha256/expect.parallel-change-f-to-main
@@ -5,7 +5,6 @@ Date:   Fri Apr 12 16:16:24 2013 +0200
 
     Merge across the rename
 
-
 commit 4f7a58195a92c400e28a2354328587f1ff14fb77f5cf894536f17ccbc72931b9
 Author: Thomas Rast <trast@student.ethz.ch>
 Date:   Thu Feb 28 10:49:50 2013 +0100
-- 
gitgitgadget

