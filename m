Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E862231A23
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566173; cv=none; b=sgVw+eAkB0XjIXdCqUCNZJFcsOoT6MytTs58/P4+a7pU5fKiZDXLCPrayh0mVms0QICTyQvleaLzm7xta975xENHqX2CV8VMcze19JszplPd69vjZFLG8v0oTt9HNU110yTl56A0SQhFaWaIbV9gTRINHCqJPpGqo31zeFtb2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566173; c=relaxed/simple;
	bh=PfLWjNVjqt8cR3d7KwIG/+X2Bzvlb3hVJOTfKwu6ooU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSL79ehXa7J9aPjJN5BFLa78IWVotIPZUMWvftdXQcYs0MGO17RP6YCrFq/FMORxH6dl9r/bMip7CFrkcUh9aDQZKz8w1kko9o0mG55V0m4h45OYaf6EYhT0RMIBzxl3XRhhQMBb+fzvwOsOsIV5EbqSpcjhzB2cftX1TMieGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fz05wsHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bpxc5LTh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fz05wsHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bpxc5LTh"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A794911401FF
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 03:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566170;
	 x=1745652570; bh=SAsoC40dG95dOyENmCxxItcI2Q/KK9Ex7sUsY3quEac=; b=
	fz05wsHAEZP0zSa0JLG8Wp/C/IvlcHahrFZP783oszfMWcGPDrmylX08oF1j6d+v
	9KLunhUf+thEQ09N7Ku2VT2uH1fZbf2y48AoA4UeVf5l+X1tYpSaorTmcKzwoMrm
	GAlCHtSy7hDE+E/jqfDKozg8aGcfqoU0AusAsDlaUMPPg9DHEExrCDknuVpca/Wv
	z13LXStrgDIlEgFDli61jnxpqGHfbfmbFLpTBj9zqiAKjmbOFc7s/W5EzO3v/AVv
	/WEqGgVshnhCa4vZv1a5+3dm9xrhcBVulF0yoHLA1xjVYIOPDIXJka2usVml3x5/
	AMpAc5e5BRb9Ywt0lbEo4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566170; x=
	1745652570; bh=SAsoC40dG95dOyENmCxxItcI2Q/KK9Ex7sUsY3quEac=; b=B
	pxc5LThMrX6kzxdpjUWMBjlZibmCNmCxJ+1uvCz6oNwkvPoUo3Li9eZmVZJRRvq2
	BJpWiONOQ9yFDO7dFWoeQmj4TI/xWBi+hVwMjfx9ZZx3qmzEueD7TQ3DxqQ1QbiF
	ZZdC5l1X0RIGdVMiZyXNm3Up6Qp+0uVPKizTRiaeo9+TLGRmRY9YLxj7fsdZbW28
	4j77l7XpBiFKJv5bP+IQFUsAx9sotrhRE5s1XNjQ5vNUfzPWKV1klt6CBvXW5JcS
	NYnW/Y4OaXb7iojvsoqxRhY9E/8D6yPDn4uHwEzstrTaH2AmGILKlMRY6I/Jpvt3
	yagNNXdAtl47BjEWauZQQ==
X-ME-Sender: <xms:2jkLaJMWO3mNv52O24uPpOfJvTdgRQqZXAWq9XZDEEVNqLiVbpBMyw>
    <xme:2jkLaL_K6kWhN9efsPMp29clR6mMjOlz_fBqtEdNGrb0ZUkmRGxG1I2Mzp3sIlhVw
    v2hpBquCX_WVLRFWw>
X-ME-Received: <xmr:2jkLaIRFlDigL5x88ccMPJDKkuaE7k-z8Elrrn6RiHY5sFKhMY7RAVSc3UTWopthDEKLTtrS0PLNIQIvmFSoFvThQuCZiHoT-N8FqzUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2jkLaFudKSARyzcQpM-oADCQdt2akqLKuPB7YkWmOmPomXKdgFLWLg>
    <xmx:2jkLaBeGP0vKO0pzl9UWIImkMsZEQkuC3lhmnI2wAix5teHZlLFkbA>
    <xmx:2jkLaB1enyxCscFQMcGhoO4q-EcxcLkOoRI6l_hXbm9EUkk-9_YuoQ>
    <xmx:2jkLaN-xwokM8mxmtxBbg93_NARwrNwgxv_nTkdsWSg1RD6-5j7nKA>
    <xmx:2jkLaN7KHAh2GiYxfzoJIa-1q7-AEKgBSKWCgVpsdvFkmAL-6U_cY4v8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35659e8a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 25 Apr 2025 07:29:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:29:23 +0200
Subject: [PATCH 7/7] builtin/maintenance: introduce "rerere-gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-maintenance-missing-tasks-v1-7-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While git-gc(1) knows to garbage collect the rerere cache,
git-maintenance(1) does not yet have a task for this cleanup. Introduce
a new "rerere-gc" task to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-maintenance.adoc |  4 ++++
 builtin/gc.c                       | 27 +++++++++++++++++++++++++++
 t/t7900-maintenance.sh             | 17 +++++++++++++++++
 3 files changed, 48 insertions(+)

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
index a0816bcf302..d19449b33d4 100644
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
@@ -384,6 +385,26 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
 	return run_command(&rerere_cmd);
 }
 
+static int rerere_gc_condition(struct gc_config *cfg UNUSED)
+{
+	struct strbuf path = STRBUF_INIT;
+	int should_gc = 0;
+	DIR *dir;
+
+	/* Skip garbage collecting the rerere cache in case rerere is disabled. */
+	repo_git_path_replace(the_repository, &path, "rr-cache");
+
+	dir = opendir(path.buf);
+	if (!dir)
+		goto out;
+	should_gc = !!readdir_skip_dot_and_dotdot(dir);
+
+out:
+	strbuf_release(&path);
+	closedir(dir);
+	return should_gc;
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -1491,6 +1512,7 @@ enum maintenance_task_label {
 	TASK_PACK_REFS,
 	TASK_REFLOG_EXPIRE,
 	TASK_WORKTREE_PRUNE,
+	TASK_RERERE_GC,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1537,6 +1559,11 @@ static struct maintenance_task tasks[] = {
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
index d21feda271f..9cc52f28ca4 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -510,6 +510,23 @@ test_expect_success 'worktree-prune task --auto only prunes with prunable worktr
 	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune-auto.txt
 '
 
+test_expect_success 'rerere-gc task' '
+	GIT_TRACE2_EVENT="$(pwd)/rerere-gc.txt" \
+		git maintenance run --task=rerere-gc &&
+	test_subcommand git rerere gc <rerere-gc.txt
+'
+
+test_expect_success 'rerere-gc task --auto only prunes with existing rr-cache dir' '
+	mkdir .git/rr-cache &&
+	GIT_TRACE2_EVENT="$(pwd)/rerere-gc-auto.txt" \
+		git maintenance run --auto --task=rerere-gc &&
+	test_subcommand ! git rerere gc <rerere-gc-auto.txt &&
+	: >.git/rr-cache/entry &&
+	GIT_TRACE2_EVENT="$(pwd)/rerere-gc-auto.txt" \
+		git maintenance run --auto --task=rerere-gc &&
+	test_subcommand git rerere gc <rerere-gc-auto.txt
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

-- 
2.49.0.901.g37484f566f.dirty

