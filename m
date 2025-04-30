Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34852472A4
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008721; cv=none; b=T/qKC6IByH9Rvm71F011AXjO7YOHFZ8ircE9Yfh46U2RC8pM/QLzwwckSSuCI0uw5CK/aaDU4g1ENGIqCpqBz5148WWNWWvJ6SwtrHaiRIFY8b+h/8xOQv4xTZEYz95AGrKBpEdbtAZ/cXZC07CW+6vlrw9++M0OqPGQX0aIwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008721; c=relaxed/simple;
	bh=GA5EslmZHx5pekTKOaMbVJVS5nTAOSun17GAPJvwhAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pl5CRUxqsTbRl07K3fhPaOAQ6vdV3WwBS1ORxbahdHMB26GSUm3Xq+WL8Y521tDmhhrsTGnY2flZAKOQI6N9sD/TYBPrHkTnsn0c6IOS0yWSqUIL6BK4XygOj2s4lDAG3wy1uW+3xwvkic1RAaULyFOsPjM/13Y4SlGzZLh3jXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GkOqo9CN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EkYc0rae; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GkOqo9CN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EkYc0rae"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DE045114022E;
	Wed, 30 Apr 2025 06:25:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 30 Apr 2025 06:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746008718;
	 x=1746095118; bh=7d73YkuSDtJLPY8afVsHU8rLdn0WWNQnUrOZbRJvxWw=; b=
	GkOqo9CNApjXDnR/G0jBPjInVTIaqZ9r9eK3OQcVDyxCk9X58iZEIaKYZSWpi1Pt
	svelLbid7Jn513fOZJG0E4qYNdkR/5ZFelUy5Ka8MIdxkzWl3R8s3Y6Vbunv9WKQ
	s5NvLai4w0gefkhc0pfQ37NKgtnFUZFXbS3UXw2POgmrdFmi5p72DoQGKqAtx55d
	knqdB55oH5hhim9Fwuw13hFdzeag6RQBq/C0+/7XXcz6SzGnD7PT2t/3IP4FltHF
	8oGmhtuYZEWCReMfBtrBUlrKdZvPrKtaOY7u0Z5vRQ+je6hCTHqh/hu2C3XJpeRv
	Sew/KDmxHg/34QskRsyxLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746008718; x=
	1746095118; bh=7d73YkuSDtJLPY8afVsHU8rLdn0WWNQnUrOZbRJvxWw=; b=E
	kYc0raeDsJyqxF9qX2NG7MRFEVPQ3kHW0IMjnZ8hI/3VCjzVbRRCwDoWkr4rCVri
	fkrkgQubPJKEXqpMgWgUiLUvgwnQv5vY4xNhBrNcPbQ1RueGIumx8SuCuZdI3Fek
	QiOYutsuvt1WqfT+rZAc9IDmebq9K2mSCRv7P5O+s7vJLKxNGr9Bgr83p+osMaQU
	OD1SlNAJaz48fdgG2goUDt85ylRwys/aU5pIvCvS5F0Uup2SQSNTXznlBpWhtLGm
	blD/MsDfkTl4cD0sIIuCvwb0DpO3AaI9CEEvUwgBq7oLG/ClA00vyZdijdRHZSmc
	qtBgvHBoFBH3+5YolU87Q==
X-ME-Sender: <xms:jvoRaGI4t6XaerrGbrtQJy7qkF0XUPs46U9m9G60kvqKDbVqacgcHQ>
    <xme:jvoRaOIp-WnHeSuPt_RDvYPNtQf1jqfnIsHoUiG0BNaXbgobFMax_HSvC1x1jBZq5
    e-Z_flQKU-phOUXYw>
X-ME-Received: <xmr:jvoRaGs5cIpU44AdAJDWokMtsRzJVq008PIbXvTItmhINow0s8Cc3F-hRZaQrXvGswLznmHNrad64gQn8UrLeLHwLPbiVZFWZsa3ZsS7KzJFcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeekueegieejheehueeftddugfevgeeuhffhgfeh
    fffhhedtkeevveetkedvudeugfenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtohdprhgvrhgvrhgvqdhgtgdr
    rghuthhopdifohhrkhhtrhgvvgdqphhruhhnvgdrrghuthhonecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:jvoRaLYA5sJTYn0BmlNBPmFWWnChdnMXbTqZtwfHHxQcRFFenV860w>
    <xmx:jvoRaNaVnVgIq1_qCwLIK0ScFXq-WWzfRXB4plC92N8sk7wbLHkWGg>
    <xmx:jvoRaHCs5YVy1KCvh41BNmV5A_vRQOAEPcXKF-7woGoHyMRjL0u4HQ>
    <xmx:jvoRaDadlOUyZxepBCtdT7kTp1v_6DodlRvb6_HXlYM3jp0m_2_O4g>
    <xmx:jvoRaE1Evi-PiWgc0DW9192_zBn893J8nLuP1R6qpQvTEhFE0zLKMjHs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 06:25:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a11f704 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 10:25:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 12:25:12 +0200
Subject: [PATCH v2 8/8] builtin/maintenance: introduce "rerere-gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-maintenance-missing-tasks-v2-8-2580b7b8ca3a@pks.im>
References: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

While git-gc(1) knows to garbage collect the rerere cache,
git-maintenance(1) does not yet have a task for this cleanup. Introduce
a new "rerere-gc" task to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  8 ++++++
 Documentation/git-maintenance.adoc    |  4 +++
 builtin/gc.c                          | 41 ++++++++++++++++++++++++++
 t/t7900-maintenance.sh                | 54 +++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b36b62c1c47..9c333d42b19 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -84,6 +84,14 @@ maintenance.reflog-expire.auto::
 	expired reflog entries in the "HEAD" reflog is at least the value of
 	`maintenance.loose-objects.auto`. The default value is 100.
 
+maintenance.rerere-gc.auto::
+	This integer config option controls how often the `rerere-gc` task
+	should be run as part of `git maintenance run --auto`. If zero, then
+	the `rerere-gc` task will not run with the `--auto` option. A negative
+	value will force the task to run every time. Otherwise, a positive
+	value implies the command should run when the number of prunable rerere
+	entries exceeds the value. The default value is 20.
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
index 3dd1d07cca4..e56d85ea3bc 100644
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
@@ -395,6 +397,39 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
 	return run_command(&rerere_cmd);
 }
 
+static int rerere_gc_condition(struct gc_config *cfg UNUSED)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct string_list prunable_dirs = STRING_LIST_INIT_DUP;
+	struct rerere_id *prunable_entries = NULL;
+	size_t prunable_entries_nr;
+	int should_gc = 0;
+	int limit = 20;
+
+	git_config_get_int("maintenance.rerere-gc.auto", &limit);
+	if (limit <= 0) {
+		should_gc = limit < 0;
+		goto out;
+	}
+
+	/* Skip garbage collecting the rerere cache in case rerere is disabled. */
+	repo_git_path_replace(the_repository, &path, "rr-cache");
+	if (!is_directory(path.buf))
+		goto out;
+
+	if (rerere_collect_stale_entries(the_repository, &prunable_dirs,
+					 &prunable_entries, &prunable_entries_nr) < 0)
+		goto out;
+
+	should_gc = prunable_entries_nr >= limit;
+
+out:
+	string_list_clear(&prunable_dirs, 0);
+	free(prunable_entries);
+	strbuf_release(&path);
+	return should_gc;
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -1502,6 +1537,7 @@ enum maintenance_task_label {
 	TASK_PACK_REFS,
 	TASK_REFLOG_EXPIRE,
 	TASK_WORKTREE_PRUNE,
+	TASK_RERERE_GC,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1548,6 +1584,11 @@ static struct maintenance_task tasks[] = {
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
index 530c56ae91e..78da81eeb24 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -564,6 +564,60 @@ test_expect_success 'worktree-prune task honors gc.worktreePruneExpire' '
 	test_path_is_missing .git/worktrees/worktree
 '
 
+setup_stale_rerere_entry () {
+	rr=.git/rr-cache/"$(printf "%0$(test_oid hexsz)d" "$1")" &&
+	mkdir -p "$rr" &&
+	>"$rr/preimage" &&
+	>"$rr/postimage" &&
+
+	test-tool chmtime ="$((-61 * 86400))" "$rr/preimage" &&
+	test-tool chmtime ="$((-61 * 86400))" "$rr/postimage"
+}
+
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
+	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
+	for i in $(test_seq 19)
+	do
+		setup_stale_rerere_entry $i || return 1
+	done &&
+	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
+	setup_stale_rerere_entry 20 &&
+	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc
+'
+
+test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.auto' '
+	# A negative value should always prune.
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
+
+	for i in $(test_seq 20)
+	do
+		setup_stale_rerere_entry $i || return 1
+	done &&
+
+	# Zero should never prune.
+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc &&
+	# A positive value should require at least this many stale rerere entries.
+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=21 maintenance run --auto --task=rerere-gc &&
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=10 maintenance run --auto --task=rerere-gc
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

-- 
2.49.0.987.g0cc8ee98dc.dirty

