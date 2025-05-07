Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C05221DB1
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602514; cv=none; b=bRIUXBUobFZ42eIi3LtrmoTKorBIeAcC/1jlMkF9CYN2Iygy8iTklaw2QI1wjdbivoViiVfWK6ENble4sUR0iIyc2XZEk45szbTKuzucscGwNU06NthTRGNUon33aom5khjabugNAyWuhq/RS5n8PzaI1PNlIEAvScvmaBO3UH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602514; c=relaxed/simple;
	bh=5vNLUv5Unw53yFi3bvPJlSnpj8uUo1emxUJZRCMfdAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhFqUsM0PguetaCeJk7tGVSnPb2REbl7U/L4YBIQlCUdGuV2T9Y/YFkLwA/oRjFlbcJwn/p8Rj5vyh9NfpzhZbWyjeYjxy0y7MxXUEMyH3Fv99m9ySssPx3/8YjQD0YILpanLSgQ8PsBeijdRVKeF2mN+aB/8Y5ykjkPeXUxdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ic0Q/7BY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YC6PhGfW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ic0Q/7BY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YC6PhGfW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 74D2811400AE;
	Wed,  7 May 2025 03:21:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 07 May 2025 03:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746602511;
	 x=1746688911; bh=8s8NCFIp1/1rFLLIXu7l8rXtrYnzlLa25Z32F+4O0+Q=; b=
	ic0Q/7BYYyPkj8eKpZLd+1mKwgDsJRyFU42WQv2vnGT9TlzMb0hutcDszPK2irxh
	Cl0qimsc/HpyW6DrBIdzOKb+8rqLW4EXA8MK5gVp4WHsK4NB6fpFn3ZKqQJMNgQP
	fYRKK58rOPeijNzYUmre8KTHEy6JpFY4unXbkoc18W5BRu7PQkunbSV3gRXE1443
	ZwWfeDALQA7Y+7UArHZ4bjAdhZKIE5RMf92Dvt7720dysPeS2M2KNLby58jhJ0Xq
	nrorSrJDOu3MgJJZYJKy6quzOmm8elEO2+o1i/jG4/PR81o9UQunI/whqCO4i+Uj
	tAf8cjnavL5kzfKVnkL1JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746602511; x=
	1746688911; bh=8s8NCFIp1/1rFLLIXu7l8rXtrYnzlLa25Z32F+4O0+Q=; b=Y
	C6PhGfWL6zTnvkNZqO1LFPp+GO9o3yMIOg1YaMLIVv8aOzH7PkvsUxchvMBkdgpS
	HXN5FLY62BYDHFINGyDANEb34iQEf/G2ZRIX7b1MXhjs2NhsUGt9o4/NhelouSZt
	aCB6AgQaz1NmZy81/QFQNmL1JMEBCZ7xDwiw9419+VmBaYslTTpxUWpUglNQ3qge
	ep0XHjCIT6eKv7/DSVIjPGxNINjNcCiuOAGBNDXZ5QfX0pwYbA+MVyJdSbGNbk5R
	U1Z6yBh+N2qNFGijVWrcybIWB3V16ILo9RgqDBIWlQa2i3KH398rMhEMvOmxgHwZ
	r2RtP0/QmbSqG8sF9d4hg==
X-ME-Sender: <xms:DwobaPaC_n16YkFsf2UkbisfmLoLmSOkelHiTNZdxVGnUBmsf8l0JQ>
    <xme:DwobaObixKV9lgekQNeIV61pgt85cZDYQAwri_epGaqTOEsDMLdvZbhXfBuPE21hg
    nEfA1xMloAgz9VXYw>
X-ME-Received: <xmr:DwobaB-YFxCvfRGN0aW-6hz5mFVUgpC1NfIsrWNS7BZcw9Ry9Buq_pfXS3oM4z_zsSAl8O6WQWkhD8MWO9mvVa2zB0Chfc9bKWYaIV_CUJma2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeekueegieejheehueeftddugfevgeeuhffhgfeh
    fffhhedtkeevveetkedvudeugfenucffohhmrghinheprhgvfhhlohhgqdgvgihpihhrvg
    drrghuthhopdhlohhoshgvqdhosghjvggtthhsrdgruhhtohdprhgvrhgvrhgvqdhgtgdr
    rghuthhopdifohhrkhhtrhgvvgdqphhruhhnvgdrrghuthhonecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DwobaFoLL3Bh75NgNBeT7x7zfZq497Cqdf3iRSJL2i3nHnFQnB8edg>
    <xmx:DwobaKp1dsc5Hr3gyyVFaQf16Z9s2w53DInBCVas5HmHj5r_yrPtig>
    <xmx:DwobaLRxxcC9Vj0trTMFraMMr8bDfDDpxzU9K3UAkA3jODWDwzjQmA>
    <xmx:DwobaCqzxtTQNfb8-fwcNrNiSfXZgYDxLo4kqB5BCtITpnT56U1GrA>
    <xmx:DwobaNe7N7p4WEaTmqSOprkJ5hp38Wv69UpruM10VaiwFeECCXF3nHyu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:21:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0dcfddf2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:21:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 May 2025 09:21:42 +0200
Subject: [PATCH v5 6/6] builtin/maintenance: introduce "rerere-gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-pks-maintenance-missing-tasks-v5-6-aa5fdfb82891@pks.im>
References: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
In-Reply-To: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index 0ae3071ec71..e79082f985d 100644
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
@@ -394,6 +396,35 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
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
@@ -1501,6 +1532,7 @@ enum maintenance_task_label {
 	TASK_PACK_REFS,
 	TASK_REFLOG_EXPIRE,
 	TASK_WORKTREE_PRUNE,
+	TASK_RERERE_GC,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1547,6 +1579,11 @@ static struct maintenance_task tasks[] = {
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
index 8f4120a0351..8cf89e285f4 100755
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
2.49.0.1045.g170613ef41.dirty

