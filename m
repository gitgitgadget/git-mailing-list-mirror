Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556023A9BF
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008720; cv=none; b=WUcTVwXIvrTCxRtZKZiP01JpJb9OqdHvWrh762Txok4qmH2pf/BAD6RFxbKmGeAK3I2SbkGgOS4hFFJCe8OCaykouPEO6M1KDZJdeSUKuim9sv6A34lG5zSJ1JZZ2E0D7EPVRw5wM6x1uVuCmgOPhwF0P7f1s1vz9HX457fGHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008720; c=relaxed/simple;
	bh=PIKkFBJvRaTzAYK78CP50a71GEzxfevoKZHLAEukEbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFPUeq9BdnBufa3JXwsa1KzzOUOqiP2M1MxbVCH8eFRzGeoNGd4S9zxJcS3MpWCyXrW9h/Sg59PL9kK0T3XHk0HuCLLP/yt0zU1BGx9ydtKHdFBzS0tK2jI7wO9R2+trufzFfnzn3Ftw3yTVG34VGATx/sQEDO+os10nKXCo8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZFX/0Occ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZyQFcujm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZFX/0Occ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZyQFcujm"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2509C2540207;
	Wed, 30 Apr 2025 06:25:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 30 Apr 2025 06:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008716;
	 x=1746095116; bh=/5ooFaVYCzL1iwoMDMNM4Hhl+MhUcxZqePWu1zAx6EI=; b=
	ZFX/0Occ3nfkA11ZljlyiBE4gZ3gEkM5zv14yUmrH5++NOP4Mxr44ylfO82dZAMm
	5h8PAYdWhfYR/hL0KcxAy13npBt0LVYLVN4/4CxZvd9VHK/puhOXzAD5EVNRM2aD
	ZkQNL5aF5M8NdrsQNuZ2//wdRCv1Sw90Sbi/81cs6MOa7moUr6KvW3zjtAjv9Da4
	aZXMMO4nsYfrSzV36n4erFt2veDa0hX3xtN76mK2SbcvQFih5WdKeAmjXi1I7tBS
	PeOq2NWm5pFBN6w8anxM1gAMzhVxQqDiSyveZOCA+OQTM06yHJQ3ZJ+WqmdUtBXQ
	WqrO1TBJci5YaSnZoUrzRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008716; x=
	1746095116; bh=/5ooFaVYCzL1iwoMDMNM4Hhl+MhUcxZqePWu1zAx6EI=; b=Z
	yQFcujmRF4/hKVY2gma31z6mY1tYaDVj50kUpU0j6QLuS5nWtlrDH/gksFjXlVzG
	ZSgnPtJTZBYFdJo3utumYSYBpIuVW6atwD3ODIp1ipCL2lOUAyuFO1wXszAxnHLw
	wtTGwOBH3VxEPIcMJmjxB68RVYgH6pPvR2XyU53y4crc5b+DkoRfe5v2JfoZUZUf
	ILwOxy5nR0Jsv220YU7C1iAUggwdjjuO752g+2moN1guNzXDmwomq25daybPyRj2
	lfqOUJIdBXfgPggLbRlW3ViIL9QpPRNtpQsIOZZ2F7dzheZrWIY7QW6HA3wXTtLR
	Io8YSQImXua//8Xfw6SHg==
X-ME-Sender: <xms:jPoRaMDqbh9UlbillQqnuJHzelbK7x3UFmFXOalRcaTmcyOvG_RVFg>
    <xme:jPoRaOiPGDq9ji7N5KsQEBVuVio4Fl74QiV74LnVGDclLK7FGrpngmDUHsIlrvyXD
    sEWb0kW0M_iZB2zeA>
X-ME-Received: <xmr:jPoRaPkNAJ_50lARtExZck8cX7n2RD68uUhQIWcx1eARCfT0RBxv5SRy4m4P99IbEqfqwNCkP2KVAQz_BFDyEKsQaiJ6uNdO5zwIo-tzniensA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedtheeiteetfefgfeehkedujedugefhffettdff
    feeigfeihfeiffegfefhieetueenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtohdpfihorhhkthhrvggvqdhp
    rhhunhgvrdgruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jPoRaCwVA9SXYtuKJ-jCxhHclHki-OhBDD_DTz5ukLtYpquNKCZP3A>
    <xmx:jPoRaBRQKfP7f6RuvFoozuYRWHecvMMOd6VMreGqCUgxy9OfB2vc_Q>
    <xmx:jPoRaNas31E7QkogLVCesz9x5ClKWUXiV9HaHj8kEt1UsONQqMMMLQ>
    <xmx:jPoRaKRsai221beR5-KDSAXHrsz1MshRfqGuU_Viml6zhxK3UDbrIw>
    <xmx:jPoRaItsMawjty7Drj9bFCkssF5E44maLSHzKbUag20Qy1qJ8OYZt6EM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9fffddf5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 12:25:09 +0200
Subject: [PATCH v2 5/8] builtin/maintenance: introduce "worktree-prune"
 task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-5-2580b7b8ca3a@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

While git-gc(1) knows to prune stale worktrees, git-maintenance(1) does
not yet have a task for this cleanup. Introduce a new "worktree-prune"
task to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  8 ++++
 Documentation/git-maintenance.adoc    |  4 ++
 builtin/gc.c                          | 46 +++++++++++++++++++++++
 t/t7900-maintenance.sh                | 71 +++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 41536162a77..b36b62c1c47 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -83,3 +83,11 @@ maintenance.reflog-expire.auto::
 	positive value implies the command should run when the number of
 	expired reflog entries in the "HEAD" reflog is at least the value of
 	`maintenance.loose-objects.auto`. The default value is 100.
+
+maintenance.worktree-prune.auto::
+	This integer config option controls how often the `worktree-prune` task
+	should be run as part of `git maintenance run --auto`. If zero, then
+	the `worktree-prune` task will not run with the `--auto` option. A
+	negative value will force the task to run every time. Otherwise, a
+	positive value implies the command should run when the number of
+	prunable worktrees exceeds the value. The default value is 1.
diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 3a1e2a69b6b..6f085a9cf8c 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -166,6 +166,10 @@ reflog-expire::
 	The `reflog-expire` task deletes any entries in the reflog older than the
 	expiry threshold. See linkgit:git-reflog[1] for more information.
 
+worktree-prune::
+	The `worktree-prune` task deletes stale or broken worktrees. See
+	linkit:git-worktree[1] for more information.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 005ecc3f192..93a8c856dbc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -44,6 +44,7 @@
 #include "hook.h"
 #include "setup.h"
 #include "trace2.h"
+#include "worktree.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -346,6 +347,45 @@ static int maintenance_task_worktree_prune(struct maintenance_run_opts *opts UNU
 	return run_command(&prune_worktrees_cmd);
 }
 
+static int worktree_prune_condition(struct gc_config *cfg)
+{
+	struct strvec worktrees = STRVEC_INIT;
+	struct strbuf reason = STRBUF_INIT;
+	timestamp_t expiry_date;
+	int should_prune = 0;
+	int limit = 1;
+
+	git_config_get_int("maintenance.worktree-prune.auto", &limit);
+	if (limit <= 0) {
+		should_prune = limit < 0;
+		goto out;
+	}
+
+	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) ||
+	    get_worktree_names(the_repository, &worktrees) < 0)
+		goto out;
+
+	for (size_t i = 0; i < worktrees.nr; i++) {
+		char *wtpath;
+
+		strbuf_reset(&reason);
+		if (should_prune_worktree(worktrees.v[i], &reason, &wtpath, expiry_date)) {
+			limit--;
+
+			if (!limit) {
+				should_prune = 1;
+				goto out;
+			}
+		}
+		free(wtpath);
+	}
+
+out:
+	strvec_clear(&worktrees);
+	strbuf_release(&reason);
+	return should_prune;
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -1455,6 +1495,7 @@ enum maintenance_task_label {
 	TASK_COMMIT_GRAPH,
 	TASK_PACK_REFS,
 	TASK_REFLOG_EXPIRE,
+	TASK_WORKTREE_PRUNE,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1496,6 +1537,11 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_reflog_expire,
 		reflog_expire_condition,
 	},
+	[TASK_WORKTREE_PRUNE] = {
+		"worktree-prune",
+		maintenance_task_worktree_prune,
+		worktree_prune_condition,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 9b82e11c100..530c56ae91e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -493,6 +493,77 @@ test_expect_success 'reflog-expire task --auto only packs when exceeding limits'
 	test_subcommand git reflog expire --all <reflog-expire-auto.txt
 '
 
+test_expect_worktree_prune () {
+	negate=
+	if test "$1" = "!"
+	then
+		negate="!"
+		shift
+	fi
+
+	rm -f "worktree-prune.txt" &&
+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" "$@" &&
+	test_subcommand $negate git worktree prune --expire 3.months.ago <worktree-prune.txt
+}
+
+test_expect_success 'worktree-prune task without --auto always prunes' '
+	test_expect_worktree_prune git maintenance run --task=worktree-prune
+'
+
+test_expect_success 'worktree-prune task --auto only prunes with prunable worktree' '
+	test_expect_worktree_prune ! git maintenance run --auto --task=worktree-prune &&
+	mkdir .git/worktrees &&
+	: >.git/worktrees/abc &&
+	test_expect_worktree_prune git maintenance run --auto --task=worktree-prune
+'
+
+test_expect_success 'worktree-prune task with --auto honors maintenance.worktree-prune.auto' '
+	# A negative value should always prune.
+	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=-1 maintenance run --auto --task=worktree-prune &&
+
+	mkdir .git/worktrees &&
+	: >.git/worktrees/first &&
+	: >.git/worktrees/second &&
+	: >.git/worktrees/third &&
+
+	# Zero should never prune.
+	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
+	# A positive value should require at least this man prunable worktrees.
+	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
+	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
+'
+
+test_expect_success 'worktree-prune task with --auto honors maintenance.worktree-prune.auto' '
+	# A negative value should always prune.
+	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=-1 maintenance run --auto --task=worktree-prune &&
+
+	mkdir .git/worktrees &&
+	: >.git/worktrees/first &&
+	: >.git/worktrees/second &&
+	: >.git/worktrees/third &&
+
+	# Zero should never prune.
+	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
+	# A positive value should require at least this many prunable worktrees.
+	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
+	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
+'
+
+test_expect_success 'worktree-prune task honors gc.worktreePruneExpire' '
+	git worktree add worktree &&
+	rm -rf worktree &&
+
+	rm -f worktree-prune.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" git -c gc.worktreePruneExpire=1.week.ago maintenance run --auto --task=worktree-prune &&
+	test_subcommand ! git worktree prune --expire 1.week.ago <worktree-prune.txt &&
+	test_path_is_dir .git/worktrees/worktree &&
+
+	rm -f worktree-prune.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" git -c gc.worktreePruneExpire=now maintenance run --auto --task=worktree-prune &&
+	test_subcommand git worktree prune --expire now <worktree-prune.txt &&
+	test_path_is_missing .git/worktrees/worktree
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

-- 
2.49.0.987.g0cc8ee98dc.dirty

