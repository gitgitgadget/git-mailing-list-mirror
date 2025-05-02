Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683622B5B5
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175459; cv=none; b=Sr5HHYCXGKoNHFv/dD8ftxqt+4j7sG5gRPmLPQZOXPIB1dAG0XpcFztu4F775FdmwbXcL3+QplcSmkOtUHK08qe13DtZS8tSuvDGQp7aAI5OsrKyK36IXqjbuvVkduv0NJ6nCOkqO+cR9Qus7bzD/AkhrAyfOrG8PCB4EOoy5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175459; c=relaxed/simple;
	bh=PIKkFBJvRaTzAYK78CP50a71GEzxfevoKZHLAEukEbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlJzNgp6MdKc22IxR0cRSCp3Q93baD0F09PQg1IdVkSusDwj7T44nPq3b1WeABwZ3hdpQIqRs7q/NGl72TM1U4JnjXaEI8qWjY8EMC5VlfdF9RlNIIZt6vHjScvE3VoZwGBnenyQJQryF4pUTg3xCUiIC47kBv4ZX+6DWnVahE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ynsvq8R0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DgdNh+l3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ynsvq8R0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DgdNh+l3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 946461380F6A;
	Fri,  2 May 2025 04:44:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 04:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746175455;
	 x=1746261855; bh=/5ooFaVYCzL1iwoMDMNM4Hhl+MhUcxZqePWu1zAx6EI=; b=
	Ynsvq8R0nkh6v0H8f3Bx38fy3XnzYOh4A5iT6MnQf2dRPs/yZe0Gq3fBtHXa787i
	dFWXux4Gutdon6aFciNSM6L0/ZmQP/UM3gEqoSSCzVG0eVfv4WXI7QOOb6W7UP1Z
	FOSe75wUwRwKgmjk94IY7nEsqEc5cjXPw5eDo3Nsw9ktJPv9v+7vpCynlBlQ+//b
	yBQmigPJwhX2S2OabKCn5GCQ8/XKSe9g71L9PoVnkBJJmJYhehVntsIQul02n7uH
	2eKOPflrtcxYTibGCEoMZv0r/4FhLow1l7q8CsPRjT4hH5ZLXL2y1byr4T+rywkd
	LfyhryJnd8KwucNYp5vAtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746175455; x=
	1746261855; bh=/5ooFaVYCzL1iwoMDMNM4Hhl+MhUcxZqePWu1zAx6EI=; b=D
	gdNh+l3VK8ohZPrNTUa0jSWDdHA5L9p4kEMQR7R9b+u9d4hXqk31LvIQhC1rNWBi
	Lw2ARoZ03hgHvHZiIdqTO9NFNIw7j9qXa3t2owKW3aeAPTW+PqoJRh+kXpC7f6tW
	/D7QoRa46IW+fOgTKpLiJMYXqeRyu0E8g4KixhnA1aR23qiLZMTjfeblvdJ+O87v
	AMhWH/f4IjWxR51P0tWm2J7QhyAflAkGuRe6bxM0v2lTeP1gMRVt/YUoBg8Qu2qv
	QAClW9qjwU8jbpT50z0JTU/LUO58tsyy53YT/Jf0NygN1/wt7UCGFcgN4tfqBW8n
	flGrV6YoAA+giTlOCx3TA==
X-ME-Sender: <xms:34UUaOI4YXTvmUoimiP6vwU8AinL7lO8kP72ngTgB33PH9t5GmwkZQ>
    <xme:34UUaGJgzprMKZU10ze--aXiP0vb9ed_NshtcPstvC_vujgX6SsN8S9QoREMSNVty
    oJ1bWqHJcAlSQrdwQ>
X-ME-Received: <xmr:34UUaOttLyJkLpGbGAiK2SV3mMo9UOO7JlNMfC5YI4NqlGW3Ow-2mM7h3HRYhmD-oQaukuV3IbsSEymhpXjRvabETYsXPxNmYUjx7UPWvos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedtheeiteetfefgfeehkedujedugefhffettdff
    feeigfeihfeiffegfefhieetueenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtohdpfihorhhkthhrvggvqdhp
    rhhunhgvrdgruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgv
    vgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:34UUaDZbeo4idwG8qAdsikYcq1znUoD4y7pI-5zqKlGpxd1Nz-_kvw>
    <xmx:34UUaFYeF76sIBlwVfx-6iWF3bZQTljjNYsv0nCtwwRyLlMG5_JS_Q>
    <xmx:34UUaPDKR8FNN_PftoZi1_2Cn_kAl7fMtcdPWuMOQwx5eJ4_Dava4g>
    <xmx:34UUaLaZwnPufEesB4Zd7C795I7GNIq5Q3J2CP6epn7Y0gEw8-PFzA>
    <xmx:34UUaJ1ajyQnja8vVDr5vSoXihFgmNOugbprjFZBVtVbYwTwQRfGslHL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:44:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d21c7152 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:44:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 May 2025 10:44:02 +0200
Subject: [PATCH v3 5/7] builtin/maintenance: introduce "worktree-prune"
 task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pks-maintenance-missing-tasks-v3-5-13e130d36640@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
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

