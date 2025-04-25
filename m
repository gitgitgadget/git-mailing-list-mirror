Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214C22D780
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566171; cv=none; b=oyzAVPVp1eyG003EnV0d5kZoFdJKHKh/nfSGoNF3YsXWB3BntfyUq6A55/+cyk4TR0kuMOILt2j2wRCYqTUWCoY74U1O1IoIj9RL74Zaa6VZjf2wyoNexvkBliXdF8j+N9d2ZTMY7i21KCYLqmc1kXna/3stm9UXuS7/ebZSH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566171; c=relaxed/simple;
	bh=j+1BsLWk4wkOcT6YKPN6B7IOkiORBQy/CgaxIsYqYFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOJ2MZtSV/O1WFCpntdi5fW7/75KgTPK/IO+uGFX23szXbhps4IcYQYalgmggSTHDarwNz26sbzM0GaFUOiIiquL8xkw1yB5tmN1NuFQ5Smua8OrfH2R0PURbP19ng1quuMMf5bzGYwxfP7/KhYpXrlUGOu4BsUNVPiO6xNNrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dJJG1CFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARDH8mc6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dJJG1CFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARDH8mc6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B358114022C
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566168;
	 x=1745652568; bh=YzF3mXuZzdP16+DrNttgs7siPvF03CZr2GNUV0wsf48=; b=
	dJJG1CFNZ6B9qZ50kYJhI5wJWMurFTiVv4t0aVtn3C5WPsVzvtOM6sJeprohqqUc
	29pmUrrJ9kGp3RaMs+jUK85mXUUlO4OISkDADKAQ0wdRlvb2mMPrdHx+P3Tx6ssa
	At+/zrfz/xi8q/0toZxEThLLwfhOgLWLT4zUGvs0lqHu8Z6foo0S4ENMnR7pMweO
	kUejPpbFf3esC5vravFyqTBFvkBk878n3iaGQtKDb+zzKwIXchPwkwKNKi9ijNrH
	scZYIPFN+4cuwiEQK5jmhhGcIJKud7+RSVVpca4WZBXsa8oDdnpPF1TN5h4g83gX
	JYtRe4TdSEX9cfTBWdebqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566168; x=
	1745652568; bh=YzF3mXuZzdP16+DrNttgs7siPvF03CZr2GNUV0wsf48=; b=A
	RDH8mc6klZqEs8v0soQKEkLMM/769u4F4h+2ZTTEqJ3++fJtrdiFLxkMT3UImgCE
	3VOBTmtcU06zZe2YcroksZKofMWIAxA+xrwg4421Cj+ICGirH1r7w/2hCT2LW5vP
	rF4cHboytgjqGRUuE7QJbSRC3HSiMsrWAgBHnohSKaeG9pSej28PTcw5Evz2Mh/6
	9L9i97TgzEhMHExgesB3VH8t8hP02GqkbKIMAQRwTTnuFXlepLpGOoH2xpiwJoUx
	0hUNfxhwbBN4j1Iy809YMBwPKHpyYe/ALBQd6napmfwlnzh5wZcB5YJW29iEHMtr
	YwOG/uCrKhGlbUA15mz8Q==
X-ME-Sender: <xms:2DkLaLW1wL2GE4blBlaKFefT8KJ_YEzYEkJ2EVnw97SNH5f1adAvDw>
    <xme:2DkLaDkYIK97ZWkdYwqeA7SrlCSbe-4Fph8mKk4kPwZWC1koTufnOPKTEi-k48DAU
    vl34CcrWr9hCFWX8Q>
X-ME-Received: <xmr:2DkLaHbeWSCQbK7lhMsa-W1xkzIJhVhm4mNwR5VVw9det_2wcFDb7z2teEokDXIa6QcGB-D_s62Pg24fMmnDZSdbOK0T309FeYqX5R-l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2DkLaGUozTEdrrmS_sTVKO3b836oeIuw69OlBXsAHQZPz2BVmVzLew>
    <xmx:2DkLaFm1BJafS30IXoLbkOwaMsO9Su1k9d3KM6EmqNlhG7_9aPzmNQ>
    <xmx:2DkLaDfJ4fd-nNDiEUZWaCImX2QOL01hmmUxY8S2cQuX80lYx5PZ-g>
    <xmx:2DkLaPGnOwmfttfNLtU1ZwcSP1_NO1DDyLi2W_sRuJEaFC8GUqhi2g>
    <xmx:2DkLaGgsQYqe4IWIoaz4NqWVCQbbhGw8SD2LQ0kfI-T8G_KrAxnAQ1vc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ec605d0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 25 Apr 2025 07:29:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:29:21 +0200
Subject: [PATCH 5/7] builtin/maintenance: introduce "worktree-prune" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-maintenance-missing-tasks-v1-5-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

While git-gc(1) knows to prune stale worktrees, git-maintenance(1) does
not yet have a task for this cleanup. Introduce a new "worktree-prune"
task to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-maintenance.adoc |  4 ++++
 builtin/gc.c                       | 35 +++++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh             | 17 +++++++++++++++++
 3 files changed, 56 insertions(+)

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
index 005ecc3f192..46c64c852dc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -44,6 +44,7 @@
 #include "hook.h"
 #include "setup.h"
 #include "trace2.h"
+#include "worktree.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -346,6 +347,34 @@ static int maintenance_task_worktree_prune(struct maintenance_run_opts *opts UNU
 	return run_command(&prune_worktrees_cmd);
 }
 
+static int worktree_prune_condition(struct gc_config *cfg)
+{
+	struct strvec worktrees = STRVEC_INIT;
+	struct strbuf reason = STRBUF_INIT;
+	timestamp_t expiry_date;
+	int should_prune = 0;
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
+			should_prune = 1;
+			goto out;
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
@@ -1455,6 +1484,7 @@ enum maintenance_task_label {
 	TASK_COMMIT_GRAPH,
 	TASK_PACK_REFS,
 	TASK_REFLOG_EXPIRE,
+	TASK_WORKTREE_PRUNE,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1496,6 +1526,11 @@ static struct maintenance_task tasks[] = {
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
index 9b82e11c100..d21feda271f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -493,6 +493,23 @@ test_expect_success 'reflog-expire task --auto only packs when exceeding limits'
 	test_subcommand git reflog expire --all <reflog-expire-auto.txt
 '
 
+test_expect_success 'worktree-prune task' '
+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" \
+		git maintenance run --task=worktree-prune &&
+	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune.txt
+'
+
+test_expect_success 'worktree-prune task --auto only prunes with prunable worktree' '
+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune-auto.txt" \
+		git maintenance run --auto --task=worktree-prune &&
+	test_subcommand ! git worktree prune --expire 3.months.ago <worktree-prune-auto.txt &&
+	mkdir .git/worktrees &&
+	: >.git/worktrees/abc &&
+	GIT_TRACE2_EVENT="$(pwd)/worktree-prune-auto.txt" \
+		git maintenance run --auto --task=worktree-prune &&
+	test_subcommand git worktree prune --expire 3.months.ago <worktree-prune-auto.txt
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

-- 
2.49.0.901.g37484f566f.dirty

