Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F821FF5B
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602512; cv=none; b=Oz32OI3xcCLf8hwpsHhu8byFqx/2G8e1xy9mWlq1D+pKH2sJbwMP7rUlhAl/+hgTispuC8lGyF8aLu27GbBWFuQ/VCiv4Zx6JqJc5TgOVtvh2cBjIPVCms4SPjgUMy35nkAZA+bIU/mk0fAXV4VZmO77rdiSVN8dsKkuqWbkSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602512; c=relaxed/simple;
	bh=xyTZHqarkF6qyU2v/n5i0t7HgG3qYdpDxyyzk3hyO/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoOBGno1LEHICHitLZSArpFG9thRFHIewIdAJ0pzmJ1N1rgOkskBDIfYIAymCJoaxyS6nQ7c6kbqBYE8axRn656QUf0NMNZzRxDu/JQa21HTARH9zu2PWvV2fu2kaGpt+xZokv68sObfTw3AsvJl8y2pwjkk7oHi6vAMUehmY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M3guxbMD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p7v1MnzZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M3guxbMD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7v1MnzZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 00342114011E;
	Wed,  7 May 2025 03:21:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 07 May 2025 03:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746602509;
	 x=1746688909; bh=i7gT8wUcCd0bvthri0u1gqtIquJHLOtjo0GDLMD3p88=; b=
	M3guxbMDKzs4sDkH6ME8nnJ3jsjCss/BJrA7blEbH1tIV/sDK2C9Ef+Dra1Bqwdl
	J0akVDMGgP44asLaG1FndRUXr6uPOk96bukfMwwuP8lFyRky5dLLIYO4WVuWIkXl
	jPHcvnc1/VY9TljuhLvCWAXhMqJsvWeIT/xYnCZVrcQfgzLyd3g5kP11yHeL5FHw
	ltZl++oXlfG5RmvonkHN7ceIQ8pw/6tVXXEWLhu67qNMQhxUmMXkrg/j6WTM2Mgh
	A12WiCVyniZn1hlXGlNHOriia81NGnD5nV9gxC2XN9gChDgBvaw+oDE2HoOHBkig
	phcJ6azPOd2Udu+qYN7nmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746602509; x=
	1746688909; bh=i7gT8wUcCd0bvthri0u1gqtIquJHLOtjo0GDLMD3p88=; b=p
	7v1MnzZVEgnozE9EJo8ipA8SQxdvqkObsiH1irGIMheF4MdwdLCw79NUGaV5UHLl
	ZTGHOniikyQN/tTHVVwapwGnMdIYiHaVhIU1+2A/+9QGwYYEEBZYuMaVlO+Cfi49
	jWyKzkVzmF6G2kQjEhV1kJIaS+5fScRJ1jLssBp39wWvO6sCl1KuMc4Besm/jy7e
	tuec+MpKOBRQJA+jePRJqzT9gnJrxMRhXZ1GbmuDM3SS9Xf9sClVBCEWXJjfhFY9
	hCrB1duicEK0E0i/JtrpUYO6w0vpB2Ox7SUizUvVhtlzCGc8ZRluIu7H4ipxwtAk
	hzDzz/aWN8jUSGqE8D70w==
X-ME-Sender: <xms:DQobaCIbHQr8NU_mI2alz1i2XbkjWyaG44wzYnIVHC76i08pIKDhFA>
    <xme:DQobaKI1EzxQu7kzRvMSvVpPEyqqcyns0-yYA0TX7rI2Isa9EJO0lBppUA7cQqti1
    _t6py1ff-T0tUHXrA>
X-ME-Received: <xmr:DQobaCu6FbvHl6hyOektKhaZhNA2IfCj7psu0d0VPAqydF8IgmhKMo1nZDWj95IP2xoM69flvQybRXtGLs_J_1xsR2by0uUcIVRG4-sd9WlzCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedtheeiteetfefgfeehkedujedugefhffettdff
    feeigfeihfeiffegfefhieetueenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtohdpfihorhhkthhrvggvqdhp
    rhhunhgvrdgruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:DQobaHZSClwAgAFh7ktdyq8_3zFhBBojV3YgsmrE0hmOvt8zlwsYHw>
    <xmx:DQobaJbkhgsOoCqITMoqGUAHX0Nj-X0A4yDTYY9VPxFzT6hlt3J6VA>
    <xmx:DQobaDC0_Gh6J5NItM-s7_A8DeYrSARQ9U01cBO6GK3qeXdL5wfXJw>
    <xmx:DQobaPZpWexTJ86kIaXT4G2qw1R4rkZu8NyNUmNDXk1oqOY3Dj-oJQ>
    <xmx:DQobaHPEfZgNh7mdH2dYHhFCMix1YwwA6t4tVLWJ7SPVPro5CwP9Hvrx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:21:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab8e3b94 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:21:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 May 2025 09:21:40 +0200
Subject: [PATCH v5 4/6] builtin/maintenance: introduce "worktree-prune"
 task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pks-maintenance-missing-tasks-v5-4-aa5fdfb82891@pks.im>
References: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
In-Reply-To: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

While git-gc(1) knows to prune stale worktrees, git-maintenance(1) does
not yet have a task for this cleanup. Introduce a new "worktree-prune"
task to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  8 ++++
 Documentation/git-maintenance.adoc    |  4 ++
 builtin/gc.c                          | 45 ++++++++++++++++++++++
 t/t7900-maintenance.sh                | 71 +++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)

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
index 005ecc3f192..e85e313d78f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -44,6 +44,7 @@
 #include "hook.h"
 #include "setup.h"
 #include "trace2.h"
+#include "worktree.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -346,6 +347,44 @@ static int maintenance_task_worktree_prune(struct maintenance_run_opts *opts UNU
 	return run_command(&prune_worktrees_cmd);
 }
 
+static int worktree_prune_condition(struct gc_config *cfg)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int should_prune = 0, limit = 1;
+	timestamp_t expiry_date;
+	struct dirent *d;
+	DIR *dir = NULL;
+
+	git_config_get_int("maintenance.worktree-prune.auto", &limit);
+	if (limit <= 0) {
+		should_prune = limit < 0;
+		goto out;
+	}
+
+	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date))
+		goto out;
+
+	dir = opendir(repo_git_path_replace(the_repository, &buf, "worktrees"));
+	if (!dir)
+		goto out;
+
+	while (limit && (d = readdir_skip_dot_and_dotdot(dir))) {
+		char *wtpath;
+		strbuf_reset(&buf);
+		if (should_prune_worktree(d->d_name, &buf, &wtpath, expiry_date))
+			limit--;
+		free(wtpath);
+	}
+
+	should_prune = !limit;
+
+out:
+	if (dir)
+		closedir(dir);
+	strbuf_release(&buf);
+	return should_prune;
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -1455,6 +1494,7 @@ enum maintenance_task_label {
 	TASK_COMMIT_GRAPH,
 	TASK_PACK_REFS,
 	TASK_REFLOG_EXPIRE,
+	TASK_WORKTREE_PRUNE,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1496,6 +1536,11 @@ static struct maintenance_task tasks[] = {
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
index 9b82e11c100..8f4120a0351 100755
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
+	# A positive value should require at least this many prunable worktrees.
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
2.49.0.1045.g170613ef41.dirty

