Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918E49738F
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670541; cv=none; b=oETdht24UqfP4WITmCj+nl8Aa6+VuIGsS1DT8Fkz9RRn3CU5rutcYkJZ5ou6UrFlBeHHusQ4k5pstfoLwMN+Ko15GaW4r4+K4aJ3ntmFfOqGRToieC/tBTECFQyVRe12RrOceeIx/EHhIvHoPHiF6XEr/s9NKzkagtkM5RFEDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670541; c=relaxed/simple;
	bh=sY6IevPKv2O3x43jbE3GmVJirLyOlqjbSGv06Gvjnc0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GGC8fkpSDk822KeDGrme+vjUYuypCJT0Kd5e1ZGJ4Hd4jHpYPwtBE/kwwlzPKy34i94qI28YnI53Yqi7Qp9WoGtiau1J0mzwnFG0A0qaoWaotqzLn0uIO4pKC5/QE6QOJ2y/xUJ7i6kA4MWaBmQBp3kiWJXtHO3j5BgsdE04gB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNMrOFyv; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNMrOFyv"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f38so12220285ad.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789670538; x=1790275338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bj7X2cdejqdOVKONvPGhCKHb7jOSPI0IJzXXov5Keuw=;
        b=KNMrOFyv353ZhbqfDh0GDn8uySxjTzE1Jt/BOzkwgOzn8+Zm3UFWiqWLFA8rYp2IWq
         BWUj/MaW3I7UGg/U4+OYr+Lyk8+0h7IK+5j4yN3tNCWpJSPICbvYommnBUWwPn2FhfGi
         zWaanAjxAKhCUror6te67bUmBuslSZqjKd5hqoGVYt48f5YNjcHaR85QIavYIUHWiQUc
         X03EM5VqbODN19ylvnTRrk31hJtWW4sWcZckve1XGUIDCfk8+DhnEbpi/U1yOrzIUgkL
         pICZZC3zOo56KfGnv4Uy/wrgTgPKhQ9gtP/bHGEZHgwSKHZL4jTnqtQG96eqKcqr3Z5F
         PYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789670538; x=1790275338;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bj7X2cdejqdOVKONvPGhCKHb7jOSPI0IJzXXov5Keuw=;
        b=RuwpUbW8eRHgTsEMwBuzPEX/iJ5K0AfVNJQ2wccISEKCq3CnF8Q+2fZgeVE80lQ/er
         PYnPTX3WHIEWk5C8kH8aXirKwoEyqwmFgoquxnqRtlPFy4JpHsyB+Dt/WDHz18MPktU3
         crNmnkuVtwPSKOybGEIOE2RZSogFzkuL1naLMiSD0G1Prms2qw+u3Zi2U8IJopdaY8Ex
         xQWf4Fj+5sUUA1JW44/N2W/DYR9mrWNIcxjKiTm+J4RLdN6ToG9at2vkYBLnNQKztENw
         tR4vf1CSyF+rTyiS3sNXHwb+Za78h7+c+ECvqVOYw35oUaAlQfQdNesVkzMomrAwTXhM
         6KTA==
X-Gm-Message-State: AFuF++ml6uprgoocrZpAJnm6+iJmU5ngzWld6ALiCcCJQtW8q3ols00L
	BUT+HxoT/Z/N4yaAuFziV2maK514A2HXNn2KUAA+YclVaqdkXHLVW9wykaSRdg==
X-Gm-Gg: AYBFou2mf+7QL1x/Xu4CRRgO28VqYoOppgKdVRq0wASJZulxhNo01IUumk3cz+q11cO
	zY3jXSd7wkZPhylShrFV3BdnQ5k2Y1v+wtrMVunqC5p9JtRUH8paP4xbjZQl5VUXPyhLffbOWTt
	3bWYdG3zIN5wOGQ3el1n0ZhVH9R8eXszUlGzN6/FQ/HYEBXqklnI0JIDspivc3NdpEcDNuqCV2x
	bSb0GseU51uB0IG15fM7V5QdG+Ow1dKt/FrlrvJJePRxAN7ZDeMxXOy1ZmqJaZfGT3McHDNLg9z
	evFQnC3CWbpm7aVOvatYCh0V85N8OYsTzPx9DoWrHiH/8bEzkOD4Aoz8CTp/ndjtrjnrLi8KMMW
	aMmsCRLb1HNVJJZ8HEenrvId8+l3XKN/r5TWJO6hqVX2/aRHM2Giez6rnCHAgDHmckZXjTyE72y
	XZy+biQsTyC3imIj45A8KPUaHYr/uMYNbtnL6m7ZbypBFW8jiCfRQo+8oU+SlC3x1Ky0FsrAN6
X-Received: by 2002:a17:90b:380b:b0:39e:4fec:d6e5 with SMTP id 98e67ed59e1d1-39e550707e6mr134556a91.16.1789670538291;
        Thu, 17 Sep 2026 11:42:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.125.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a182sm18165410eec.8.2026.09.17.11.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:42:17 -0700 (PDT)
Message-Id: <f0ec8f1f41dc2c516193dc99cc2e70c3cba25bea.1789670534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v5.git.1789670534.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v5.git.1789670534.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 18:42:13 +0000
Subject: [PATCH v5 2/3] rebase, cherry-pick, revert: run auto maintenance when
 done
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

Commands that use the sequencer with the "merge" backend, like
git-cherry-pick(1) or git-rebase(1) with "--merge", create their
commits in-process. Consequently, these commands typically don't
execute auto maintenance at all. Only the commands they spawn on the
way run it, like git-commit(1) for a resolved conflict or an edited
message.

In contrast to that, the "apply" backend of git-rebase(1) _does_ run
auto maintenance after it has processed the sequence of commits. And
this is a sensible thing to do: after all, we may just have written
lots of objects, so chances are high that we have something to clean
up now.

Adapt users of the "merge" backend to do the same.

The sequencer has no single exit where a call to run_auto_maintenance()
could go. A sequence ends in pick_commits(), but a single pick never
gets there: it returns from sequencer_pick_revisions() via
single_pick(), its "--continue" from sequencer_continue() via
continue_single_pick(), and its "--skip" from sequencer_skip(). So
call it from the sequencer's two callers instead: run_specific_rebase()
for the merge backend, once its state directory is gone, and
run_sequencer() in builtin/revert.c after a successful pick,
"--continue" or "--skip".

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/rebase.c                | 13 ++++++++++---
 builtin/revert.c                | 19 ++++++++++++-------
 t/t3418-rebase-continue.sh      | 14 ++++++++++++++
 t/t3510-cherry-pick-sequence.sh | 25 +++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 10a306310c..535db60181 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -762,9 +762,16 @@ static int run_specific_rebase(struct rebase_options *opts)
 
 	if (opts->dont_finish_rebase)
 		; /* do nothing */
-	else if (opts->type == REBASE_MERGE)
-		; /* merge backend cleans up after itself */
-	else if (status == 0) {
+	else if (opts->type == REBASE_MERGE) {
+		int quiet = !(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE));
+
+		/*
+		 * The sequencer cleans up after itself. Its state directory
+		 * is gone once it is done, and stays while it is stopped.
+		 */
+		if (status == 0 && !is_directory(opts->state_dir))
+			run_auto_maintenance(the_repository, quiet);
+	} else if (status == 0) {
 		if (!file_exists(state_dir_path("stopped-sha", opts)))
 			finish_rebase(opts);
 	} else if (status == 2) {
diff --git a/builtin/revert.c b/builtin/revert.c
index bedc40f368..52100a20cb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "revision.h"
 #include "rerere.h"
+#include "run-command.h"
 #include "sequencer.h"
 #include "branch.h"
 
@@ -116,7 +117,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char *strategy = &sentinel_value;
 	const char *gpg_sign = &sentinel_value;
 	enum empty_action empty_opt = EMPTY_COMMIT_UNSPECIFIED;
-	int cmd = 0;
+	int cmd = 0, ret;
 	struct option base_options[] = {
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
@@ -264,18 +265,22 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	free(options);
 
 	if (cmd == 'q') {
-		int ret = sequencer_remove_state(opts);
+		ret = sequencer_remove_state(opts);
 		if (!ret)
 			remove_branch_state(the_repository, 0);
 		return ret;
 	}
-	if (cmd == 'c')
-		return sequencer_continue(the_repository, opts);
 	if (cmd == 'a')
 		return sequencer_rollback(the_repository, opts);
-	if (cmd == 's')
-		return sequencer_skip(the_repository, opts);
-	return sequencer_pick_revisions(the_repository, opts);
+	if (cmd == 'c')
+		ret = sequencer_continue(the_repository, opts);
+	else if (cmd == 's')
+		ret = sequencer_skip(the_repository, opts);
+	else
+		ret = sequencer_pick_revisions(the_repository, opts);
+	if (!ret)
+		run_auto_maintenance(the_repository, opts->quiet);
+	return ret;
 }
 
 int cmd_revert(int argc,
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index cb5c3a1cb5..8056b39955 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -395,4 +395,18 @@ test_orig_head () {
 test_orig_head --apply
 test_orig_head --merge
 
+test_expect_success 'rebase runs auto maintenance once it is done' '
+	# topic and main both add F2, so the pick conflicts and the rebase
+	# stops before the exec runs, and once more when the exec fails
+	git checkout -b auto-maintenance topic &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
+		git rebase -x false main &&
+	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
+	echo resolved >F2 &&
+	git add F2 &&
+	test_must_fail git rebase --continue &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
+	test_subcommand_flex git maintenance run --auto <end.txt
+'
+
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 5777dff496..1dbc42e768 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -721,4 +721,29 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
 '
 
+test_expect_success 'cherry-pick runs auto maintenance once it is done' '
+	pristine_detach base &&
+	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
+	test_subcommand_flex git maintenance run --auto <single.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
+		git cherry-pick anotherpick yetanotherpick &&
+	test_subcommand_flex git maintenance run --auto <sequence.txt &&
+	grep "\"child_start\".*\"maintenance\"" sequence.txt >maintenance &&
+	test_line_count = 1 maintenance
+'
+
+test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence is done' '
+	# both picked and anotherpick conflict on foo, so "--continue" stops
+	# once more before "--skip" ends the sequence
+	pristine_detach initial &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
+		git cherry-pick base..anotherpick &&
+	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git cherry-pick --continue &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --skip &&
+	test_subcommand_flex git maintenance run --auto <end.txt
+'
+
 test_done
-- 
gitgitgadget

