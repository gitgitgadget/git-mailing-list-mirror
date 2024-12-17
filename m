Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7EC1DEFDC
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417868; cv=none; b=gT7A51D0oObukNLxBbx09GYaMfY3WFprq+f8GlFhQC044/EakFjJnkuM8yWOp4UrOmWHOyzzYQB7PkA5ZodKAtkyEBcSvATTLsR9P+JXsgpqSZTODy3Ek6kuXGH6/Q309PE3XQb1RMf7Ss6q0sCGqUrdyzCkPL54pW6tYIM1LQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417868; c=relaxed/simple;
	bh=KGwX0ALeETe9SPpgpQW7++oekf/43FZs+iTh3V2ox2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFaABiDM6YJ7r3QQ7jpgfhaAk8wWohSpfYzwLezt8MG0GvS/E5rC49i6C2sZKl8dTxOAnLywvQoWpA0zg/O1xTbgZqZ4U5j93k8gU97D/BcD0e61gowUGAuEjx9ovm6jn7KIoyegLLN4i/07cEhqv8elf5YQRfIAE1GWW8prPtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CqtUnDyD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=29BKakP4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CqtUnDyD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="29BKakP4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 408C31140225
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 17 Dec 2024 01:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417864;
	 x=1734504264; bh=D7yWs8Fzg397jz1pWNluAN+73cxzMlrsBKdZRA/V1AM=; b=
	CqtUnDyDaf7mvMrOzTG9FZyAdH1zspfyajz+L0/ei0dwkqFYBpCPkmCVljxUIadu
	x9bpLGSb6s3GBzPV6mqan1b+luHvK4Zyl3jR+Kv3GeqXgJMOAFunZfoRKzPqG+2n
	Rmq8OGRNUFh2wGj3JSijiZy+GgO1D4tFlxnWMuu5B/ckJPxH7lUZGf2SKsiQFMm5
	65jYf6FwWlHsNMHL1GTI6trRy34IvNbC8xFysAb/pyI+pkN9hmD2sORf36ZnzEzv
	Iba3NxBQBmKufksvV/wsWv6m0kc+BGnL1qMekPa7ZW+l17Xs1libY7uVpANytrGm
	9Na3JYJKlji9R9Ce982QDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417864; x=
	1734504264; bh=D7yWs8Fzg397jz1pWNluAN+73cxzMlrsBKdZRA/V1AM=; b=2
	9BKakP4glja00OoTPfcTk/YnpMUdjRVyj0Br/b5zxbjNHfuw/FSOwttA6Y0Sd+mL
	OX5r6wFzqA/zdtYrla1/XCOIVCCsCTQJnnSVgtyJvFaIchceLGlXr6bVzncQaru0
	PUSHtSY63ladqzd6uLs0grt6l6WtvmxRLXqAJX2n7cYkIPW2LOzVe+7UlAzfuXeX
	FLhV5amjDCPMjg3KYV3+W1luO4PhN+P5snn1tXWY/C2EmuUOsthZrl7uuNAI7tPf
	Dt+qNbv/zEJXPY9768KiElM0JOMfc/Sz/+ZwE8ZVrQ/Mru+Z81kIIcnitrGUrCCv
	cM77PkOpBGc0IFfvV+7NA==
X-ME-Sender: <xms:yB1hZ6YJZSDf_l6WDVkLlI71CIHKj6vhbv2t3I5MoeCVNa3RST8w-Q>
    <xme:yB1hZ9ZbrrIzL9wSoSUK_xRHK9SMZDbIKGJNQF1fosvW2FRn4JR0sh9j4LGakiWfR
    oU_WNbIyfW1MEL5lQ>
X-ME-Received: <xmr:yB1hZ0-2Z-9FNfZEpAsAlIHmsOssn6ZZV1I_1GZzo9SP9dQp0ivFsU42uPqXDm1bARnvkIXvhgwmduWI50ujzf24BuAbj1j7INE3deiKLTIu7Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yB1hZ8oFq_RFiamc-NM2ynEbfVNJ7ZlXevzWx4NTdIj9r069zHM5_g>
    <xmx:yB1hZ1q3gJJuQeSu-U4xFrjqTcduFc7Zz8nhj3qEc14jInWD8T8J-Q>
    <xmx:yB1hZ6SJZ5kXiSgB69wrDAezPE6iEWYLFxpejLJyTrlcCvY3nnSkBQ>
    <xmx:yB1hZ1qEjOR-EHVLxcUJIE3cGZITGhFk2cMg6ozNTaa_hfGFfK6Jyw>
    <xmx:yB1hZ2BALSrqgDJwCL-4zuIPv3QQmAP_aFEXLv9h8rOU1ytpd1twnFWW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a95dec4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:58 +0100
Subject: [PATCH 11/14] tmp-objdir: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-11-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "tmp-objdir" subsystem by passing
in the repostiroy when creating a new temporary object directory.

While we could trivially update the caller to pass in the hash algorithm
used by the index itself, we instead pass in `the_hash_algo`. This is
mostly done to stay consistent with the rest of the code in that file,
which isn't prepared to handle arbitrary repositories, either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c |  2 +-
 bulk-checkin.c         |  2 +-
 log-tree.c             |  2 +-
 tmp-objdir.c           | 15 ++++++++-------
 tmp-objdir.h           |  5 +++--
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 191b5eeb34e6791776f93a3a9509efa887e4e087..56347a79633505efe8dc05acf1583b4c9995eefe 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2239,7 +2239,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		strvec_push(&child.args, alt_shallow_file);
 	}
 
-	tmp_objdir = tmp_objdir_create("incoming");
+	tmp_objdir = tmp_objdir_create(the_repository, "incoming");
 	if (!tmp_objdir) {
 		if (err_fd > 0)
 			close(err_fd);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 4a70a70a951cfd1a488339a33bf3a76b5152a344..f7b15e3999f2c7e3fdb0d7bde01975ae4449bda3 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -333,7 +333,7 @@ void prepare_loose_object_bulk_checkin(void)
 	if (!odb_transaction_nesting || bulk_fsync_objdir)
 		return;
 
-	bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
+	bulk_fsync_objdir = tmp_objdir_create(the_repository, "bulk-fsync");
 	if (bulk_fsync_objdir)
 		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
 }
diff --git a/log-tree.c b/log-tree.c
index d08eb672a933900558b305b31860f6753a470bf0..8b184d6776344bbc2ba4c00a9d50b44db17f2ede 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1042,7 +1042,7 @@ static int do_remerge_diff(struct rev_info *opt,
 	 * into the alternative object store list as the primary.
 	 */
 	if (opt->remerge_diff && !opt->remerge_objdir) {
-		opt->remerge_objdir = tmp_objdir_create("remerge-diff");
+		opt->remerge_objdir = tmp_objdir_create(the_repository, "remerge-diff");
 		if (!opt->remerge_objdir)
 			return error(_("unable to create temporary object directory"));
 		tmp_objdir_replace_primary_odb(opt->remerge_objdir, 1);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 659fcdcc2954ed392f9e241667ea6a7d2c79b828..0ea078a5c5f4eb1ff465aa64ae962a0ccd44fb8b 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "tmp-objdir.h"
 #include "abspath.h"
@@ -16,6 +14,7 @@
 #include "repository.h"
 
 struct tmp_objdir {
+	struct repository *repo;
 	struct strbuf path;
 	struct strvec env;
 	struct object_directory *prev_odb;
@@ -116,7 +115,8 @@ static int setup_tmp_objdir(const char *root)
 	return ret;
 }
 
-struct tmp_objdir *tmp_objdir_create(const char *prefix)
+struct tmp_objdir *tmp_objdir_create(struct repository *r,
+				     const char *prefix)
 {
 	static int installed_handlers;
 	struct tmp_objdir *t;
@@ -125,6 +125,7 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 		BUG("only one tmp_objdir can be used at a time");
 
 	t = xcalloc(1, sizeof(*t));
+	t->repo = r;
 	strbuf_init(&t->path, 0);
 	strvec_init(&t->env);
 
@@ -134,7 +135,7 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	 * them.
 	 */
 	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX",
-		    repo_get_object_directory(the_repository), prefix);
+		    repo_get_object_directory(r), prefix);
 
 	if (!mkdtemp(t->path.buf)) {
 		/* free, not destroy, as we never touched the filesystem */
@@ -154,7 +155,7 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	}
 
 	env_append(&t->env, ALTERNATE_DB_ENVIRONMENT,
-		   absolute_path(repo_get_object_directory(the_repository)));
+		   absolute_path(repo_get_object_directory(r)));
 	env_replace(&t->env, DB_ENVIRONMENT, absolute_path(t->path.buf));
 	env_replace(&t->env, GIT_QUARANTINE_ENVIRONMENT,
 		    absolute_path(t->path.buf));
@@ -273,14 +274,14 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 		return 0;
 
 	if (t->prev_odb) {
-		if (the_repository->objects->odb->will_destroy)
+		if (t->repo->objects->odb->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
 		restore_primary_odb(t->prev_odb, t->path.buf);
 		t->prev_odb = NULL;
 	}
 
 	strbuf_addbuf(&src, &t->path);
-	strbuf_addstr(&dst, repo_get_object_directory(the_repository));
+	strbuf_addstr(&dst, repo_get_object_directory(t->repo));
 
 	ret = migrate_paths(&src, &dst, 0);
 
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 237d96b66050c82340af3c18b531bd5c877c15ab..fceda14979648f50bb28b6c527889b12d334b098 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -11,7 +11,7 @@
  * Example:
  *
  *	struct child_process child = CHILD_PROCESS_INIT;
- *	struct tmp_objdir *t = tmp_objdir_create("incoming");
+ *	struct tmp_objdir *t = tmp_objdir_create(repo, "incoming");
  *	strvec_push(&child.args, cmd);
  *	strvec_pushv(&child.env, tmp_objdir_env(t));
  *	if (!run_command(&child)) && !tmp_objdir_migrate(t))
@@ -21,13 +21,14 @@
  *
  */
 
+struct repository;
 struct tmp_objdir;
 
 /*
  * Create a new temporary object directory with the specified prefix;
  * returns NULL on failure.
  */
-struct tmp_objdir *tmp_objdir_create(const char *prefix);
+struct tmp_objdir *tmp_objdir_create(struct repository *r, const char *prefix);
 
 /*
  * Return a list of environment strings, suitable for use with

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

