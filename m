Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0591F463E
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435118; cv=none; b=Llujxc9VNnXSZvZGgnbDHjh6Q6ZUSyzLvhuEf1JspVKSwMx/GcQS37XJ8pwUClqDsZRFjXdImVLGXb370jPvFdH+KYaLCRR9H2hbyJEbMsXJVlyqSTXP0o91a3wcD+9HVt6pJLgZqvrtVYiUygMPmRq9+3wvT7BP5lLEoWOtnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435118; c=relaxed/simple;
	bh=PIKkFBJvRaTzAYK78CP50a71GEzxfevoKZHLAEukEbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNLfwhWjZglV6g7BVOfWrxqeLlIX+gHk4fi0Aczm1WsuEZQW1Q8DKhU36j3KAt9IVBxG26eT5ygw9qu8PIjhnNfOEAadr3fiCtJpZHZrQ+fUXCaA7YY50dgSvlI+v63lrmrOSVE9M9WpPdljQ968/IW8NZ9RrL5VU27ULFFB8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UuyfDyMd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KdFcNziJ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UuyfDyMd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KdFcNziJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1A772540235;
	Mon,  5 May 2025 04:51:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 04:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746435113;
	 x=1746521513; bh=/5ooFaVYCzL1iwoMDMNM4Hhl+MhUcxZqePWu1zAx6EI=; b=
	UuyfDyMdWtUuxgVa/SXyph31S+2YYYPg3Y7S7oEGtmbiLrNpuiWI6rVOyKrBetUY
	3f98+47WNIyBHWXBKKfYd8pUqLmS8qYvWMJla/GULC0NOuCIHuBqVzvH1FIYYewo
	faJta004a4q7kB8Qnl9ne7reMYZGG+VBBXrTs/OaIVYXeIiI/swbfFr5KYc9msPY
	nqtQscHI+uBtsODn1DfP+iUSVBh2//buLvBnd+7ykSXKV2sKZ+hwH3nZlgGOGdw6
	zfu7BDFMbht7iEvqp3VKyCtjBGk8k0SU2ds5t5I6lKHSlMuN4Kh0T6klE/5Zyqkb
	nU0+sL6YosZTk5MQoRkkmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746435113; x=
	1746521513; bh=/5ooFaVYCzL1iwoMDMNM4Hhl+MhUcxZqePWu1zAx6EI=; b=K
	dFcNziJ9q2LebTrab8e6AXBkPsdx+xmV7qxePvGGWUo/12StKRWqU2DTAwu+2URb
	KEe3W1ge4rtWyu1j3V+1LmRxpP9Q70pZLoF5qIsSZVDy16Xe8VQkk4pL3qWwKlaB
	SzAC2/3F5lZRZCz0beQHR/dvHnHr6+5Gy7uJxdeOyZ/8t1jKC2dSkreuVy6zWyh2
	tJCEfhZeFHXLjvUFE+uicIsi23sVdcXYQKxZILbCEx8h5KUi4PM6j1cnrMorHA/v
	8bEiQoD0wNNwEfsgAjFtHgdJFN1E8WTLuAPzHFJc5mE55vsme0e4uPLr4Y8jVTjo
	tnZ3Sb2FrME/l6YIz2fFw==
X-ME-Sender: <xms:KXwYaPOmd9jOe1U_8wTYWgZ2zPiX5ByXM8MAcZEKh8jBShiWF9dvFw>
    <xme:KXwYaJ-D6pTIeS5wJc6k4TwJ_2hj8tSRoiTIbvmbKD0jz5daHrnvmAMOVrDfeTlXC
    ChPGCondoIynHTuyw>
X-ME-Received: <xmr:KXwYaOQ8D0ra211sakeeHl7cT-bxO1iUV3sLZzgXsp2hWEfIweQ78j8dG0d1Ok1NVeKEgv9_kms6VT_RynZxiELoCfyxzqN7Dj25Wnsa-fz66w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedtheeiteetfefgfeehkedujedugefhffettdff
    feeigfeihfeiffegfefhieetueenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtohdpfihorhhkthhrvggvqdhp
    rhhunhgvrdgruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KXwYaDsxRVh7Ptd1Ust7qROTJAWmjOmwnq5x37dFXwA-aP9-B5f9ZQ>
    <xmx:KXwYaHe8WIhyZRuRvlI40oiu9LAAE8ug7eOL4tCn-EnY0U6CAPauCg>
    <xmx:KXwYaP3EtTdWGkFkDaThcqKAtDbVJALIXEUlMV48IJeNTeezGcIonQ>
    <xmx:KXwYaD-_OXlhn5qPLatIzB4d0JNWTCxBa5KvrrbEKMl8KOFnBYI47g>
    <xmx:KXwYaBoMpMpyYJ1E6TqTUxNpeOsw6w-nYQbjhg1e6ZZXmS2xeTTymE11>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 04:51:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 338b9d3a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 08:51:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 May 2025 10:51:45 +0200
Subject: [PATCH v4 5/7] builtin/maintenance: introduce "worktree-prune"
 task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pks-maintenance-missing-tasks-v4-5-141f4df906a1@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

