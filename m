Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59D1F5423
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435118; cv=none; b=hbcdjVXSdMidCsOdzOHuCxPlnkHZKVgvrJHQmkancpZKj4UuYcgEI/h+F6XyVNzM1X0EUeLvlKMFQOdYyin/FVu/paDCldxPLmIg1Tpu3MW1SNdVmJjkQPKwevLxMJPJ9jfRsoxDVazqkbAjEavaWg7EW6HEuXtjUU5PW4Lr6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435118; c=relaxed/simple;
	bh=oCDeI0vGC9uz7ML7WAU7hf1lsCdFQkgMJ0fzP22ZLxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSe96DgJM/VzQo0cQZvewZXaFIUKCpl880r0DzogNKG9r9Exlsb1ykVffQnEO/aRXwEzQTl7GUnJOvas2iHBfpF4fZ33PB/SV6CsVIMGxQp2b1b5XLLF9LEhaf/ATx3KsIWv+EuX9NsJO+nnZkGegZD+qmXCt+nyXVl5bi8XZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NWU4mz5f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgPZHWG6; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NWU4mz5f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgPZHWG6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3ADCD11401BD;
	Mon,  5 May 2025 04:51:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 04:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746435115;
	 x=1746521515; bh=ALDOYBevnVAOWfQJyc83oI1S2s4i0ZnL08dcLU5sMxo=; b=
	NWU4mz5f4eFXKBW2+R72z5gfTK3T7xGRoTgIJ2CdhIykt0JQY67TIJwfwvILFl2H
	Z6vPfptmC1CZMghKgliCG4c9+rBbP/xUE12skS4lCGWrVd8pjOuzkBN+tmKAengD
	VkiHp0G05CLC0cFbMTZkR+HnAfPSkLA0hmj9f3QA/al7PIGVhUuxPRHubY4loh0S
	UYnL1CvOnodjYOM68rKC7HrNuy1OhzSGjGLrJDb8qNy2dTT/0MvuKiE89rVNSh7/
	1mKYkXK6EULVUmNbl0C65sF+DlHVNvYgemOWxaKdxs2N9aqhQmd3+uisNlsystGi
	Ln5/SG42Yw8jV7OEr3d9Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746435115; x=
	1746521515; bh=ALDOYBevnVAOWfQJyc83oI1S2s4i0ZnL08dcLU5sMxo=; b=O
	gPZHWG6g7y6Y016km8EBpSDJILdLVBYKOKs8mp1ZbCRTXO4X9hh0Memi1RqFlDKV
	isYbUjC2JIhgUzVn2scaNy0q7TmwGlYIKBqL/5IEkZFI1fHtk5vPSwoCz8Fy4bOy
	pxA08sOsuTxyC9QgRup+D0ya5xUENMYiE7fvICqAahea4w/eSw/1jmZLdOh1w/JO
	RbweikT0upis42qc0qZ5hNH2RXQhLTu9xdWw8K6rSAOBUoyaDUFFr4Xw2iHy1s0E
	pbZFbaLmbymR6z7TkPSG3ld/pq7p8HpqULTc4UGBtOoAr0YuZ1jx+rFio2jiFWHR
	JPcf76ae9v/BYr9x9ZV7Q==
X-ME-Sender: <xms:KnwYaORQTFzRKjw4X94CEbDpEUKexgS3MYopmEbsv-oE1n1IrCojdQ>
    <xme:KnwYaDxlUW8wewW_m8OWsgM9ARBH0_kO8cZn3sUqNAJn5TBc7KINsZZNxVMviCMPU
    C4nQLD_Z0CKln0Snw>
X-ME-Received: <xmr:KnwYaL1aTNmUG7A2O0DYKRVvLRZw8g0JW6IGTyFh7DLSP49lY4CGIrPaAhLi5RpCfl-IUDCTc745sHfB8znqgLtQFDjYq0ubmNDqki0GC7RG5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeekueegieejheehueeftddugfevgeeuhffhgfeh
    fffhhedtkeevveetkedvudeugfenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtohdprhgvrhgvrhgvqdhgtgdr
    rghuthhopdifohhrkhhtrhgvvgdqphhruhhnvgdrrghuthhonecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:K3wYaKDcJ_BttY081lmOsrmTYaHKpZjrLisux6pRhxMuEaNp728HoA>
    <xmx:K3wYaHh09HBbYs7hHT5ILlLBM4imG8aWfzUi4g3YAA34iQrni35lvQ>
    <xmx:K3wYaGoDQKjnfctGAhg0G75ZauuQwVFrP6quBgV6Nps9Vw8y-48Snw>
    <xmx:K3wYaKhBqKpHnYTHR1PKghwJ5nEgLmPPTe4F8ce4Pu1vgNi0J_aXXw>
    <xmx:K3wYaPczHRjZPPnwl9ObkEbZdNyvK2-MbeLlxUOpHCNQN1IBWC2MwHJW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 04:51:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efc6a60f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 08:51:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 May 2025 10:51:47 +0200
Subject: [PATCH v4 7/7] builtin/maintenance: introduce "rerere-gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pks-maintenance-missing-tasks-v4-7-141f4df906a1@pks.im>
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

While git-gc(1) knows to garbage collect the rerere cache,
git-maintenance(1) does not yet have a task for this cleanup. Introduce
a new "rerere-gc" task to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  9 +++++++
 Documentation/git-maintenance.adoc    |  4 ++++
 builtin/gc.c                          | 37 +++++++++++++++++++++++++++++
 t/t7900-maintenance.sh                | 44 +++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b36b62c1c47..2f719342183 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -84,6 +84,15 @@ maintenance.reflog-expire.auto::
 	expired reflog entries in the "HEAD" reflog is at least the value of
 	`maintenance.loose-objects.auto`. The default value is 100.
 
+maintenance.rerere-gc.auto::
+	This integer config option controls how often the `rerere-gc` task
+	should be run as part of `git maintenance run --auto`. If zero, then
+	the `rerere-gc` task will not run with the `--auto` option. A negative
+	value will force the task to run every time. Otherwise, any positive
+	value implies the command will run when the "rr-cache" directory exists
+	and has at least one entry, regardless of whether it is stale or not.
+	This heuristic may be refined in the future. The default value is 1.
+
 maintenance.worktree-prune.auto::
 	This integer config option controls how often the `worktree-prune` task
 	should be run as part of `git maintenance run --auto`. If zero, then
diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 6f085a9cf8c..931f3e02e85 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -166,6 +166,10 @@ reflog-expire::
 	The `reflog-expire` task deletes any entries in the reflog older than the
 	expiry threshold. See linkgit:git-reflog[1] for more information.
 
+rerere-gc::
+	The `rerere-gc` task invokes garbage collection for stale entries in
+	the rerere cache. See linkgit:git-rerere[1] for more information.
+
 worktree-prune::
 	The `worktree-prune` task deletes stale or broken worktrees. See
 	linkit:git-worktree[1] for more information.
diff --git a/builtin/gc.c b/builtin/gc.c
index 3dd1d07cca4..0d4a70c7804 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -16,6 +16,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "date.h"
+#include "dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "config.h"
@@ -34,6 +35,7 @@
 #include "pack-objects.h"
 #include "path.h"
 #include "reflog.h"
+#include "rerere.h"
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
@@ -395,6 +397,35 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
 	return run_command(&rerere_cmd);
 }
 
+static int rerere_gc_condition(struct gc_config *cfg UNUSED)
+{
+	struct strbuf path = STRBUF_INIT;
+	int should_gc = 0, limit = 1;
+	DIR *dir = NULL;
+
+	git_config_get_int("maintenance.rerere-gc.auto", &limit);
+	if (limit <= 0) {
+		should_gc = limit < 0;
+		goto out;
+	}
+
+	/*
+	 * We skip garbage collection in case we either have no "rr-cache"
+	 * directory or when it doesn't contain at least one entry.
+	 */
+	repo_git_path_replace(the_repository, &path, "rr-cache");
+	dir = opendir(path.buf);
+	if (!dir)
+		goto out;
+	should_gc = !!readdir_skip_dot_and_dotdot(dir);
+
+out:
+	strbuf_release(&path);
+	if (dir)
+		closedir(dir);
+	return should_gc;
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -1502,6 +1533,7 @@ enum maintenance_task_label {
 	TASK_PACK_REFS,
 	TASK_REFLOG_EXPIRE,
 	TASK_WORKTREE_PRUNE,
+	TASK_RERERE_GC,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1548,6 +1580,11 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_worktree_prune,
 		worktree_prune_condition,
 	},
+	[TASK_RERERE_GC] = {
+		"rerere-gc",
+		maintenance_task_rerere_gc,
+		rerere_gc_condition,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 530c56ae91e..af02a551869 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -564,6 +564,50 @@ test_expect_success 'worktree-prune task honors gc.worktreePruneExpire' '
 	test_path_is_missing .git/worktrees/worktree
 '
 
+test_expect_rerere_gc () {
+	negate=
+	if test "$1" = "!"
+	then
+		negate="!"
+		shift
+	fi
+
+	rm -f "rerere-gc.txt" &&
+	GIT_TRACE2_EVENT="$(pwd)/rerere-gc.txt" "$@" &&
+	test_subcommand $negate git rerere gc <rerere-gc.txt
+}
+
+test_expect_success 'rerere-gc task without --auto always collects garbage' '
+	test_expect_rerere_gc git maintenance run --task=rerere-gc
+'
+
+test_expect_success 'rerere-gc task with --auto only prunes with prunable entries' '
+	test_when_finished "rm -rf .git/rr-cache" &&
+	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
+	mkdir .git/rr-cache &&
+	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
+	: >.git/rr-cache/entry &&
+	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc
+'
+
+test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.auto' '
+	test_when_finished "rm -rf .git/rr-cache" &&
+
+	# A negative value should always prune.
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
+
+	# A positive value prunes when there is at least one entry.
+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
+	mkdir .git/rr-cache &&
+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
+	: >.git/rr-cache/entry-1 &&
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
+
+	# Zero should never prune.
+	: >.git/rr-cache/entry-1 &&
+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

-- 
2.49.0.987.g0cc8ee98dc.dirty

