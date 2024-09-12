Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F903185B5D
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140619; cv=none; b=Qsi/M0iXj+qdB9MMOV5wZkH6sE0+7NfPCnfKjCuDBFXpuY9o/p4z1X/fXKzTJlOyi3U4sLbb23UxF/xO5x2RgA/WojCLCaoSDve4M6TYPyebf+2ii8+f8wtXcElhc5z7j0BePA5i31Wczy1V+BCVZ+eWn8Ri+0bx4RK8BHLrH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140619; c=relaxed/simple;
	bh=NWi7Url5UdCx44xk2Ev9nujaX9i3QOFDs87Nl0Jdqmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa10/FRHxhfHCxDV2KHZBAxf/Pah8sdEg3iDxyAwm39pS3Kn5Azj3z1zN3ZBNJAEDhUiwjNF5aFhh9yr3YId0ArfzHi/uq0E3e7+pr1TAbdpP6Yl4ElPstD2EOTn9n8DHXq9X6sPnKoVfu3YgUGWhhX+FbaE1/oToW4BKb0DmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GP1zpF72; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ogxXbWO+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GP1zpF72";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ogxXbWO+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F65D1380626;
	Thu, 12 Sep 2024 07:30:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 07:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140617; x=1726227017; bh=s9YK7NvqFd
	OufgpzTSQfb8F8vwynH41O728d4FJIGzQ=; b=GP1zpF72gldZVetf6OXlw2iX8k
	I+a10Q9Fzx1ge5OMRB82AzgCaZ+wVjNpE5Fzok6ul8oHaoVld/qkB8C/OURZ37Ls
	tvD0muHPesE+7NEJ0mNwjiN+kwy3TaO4DtxzpWFmdkpEendTCcv2XwmUGQ3pb6Qv
	5AYwBZZ4pEdpk2Br+WiiyVrGw9qe79sSrgzlX5+qa8LV+3Ryh06+QWUPf67G9gvY
	dbyP4i88z91NnSmB2tsSjdGNhfRrez2zH5i3jNvYP/Pytq/fB4BzBP/ff29266sw
	IGGPQg885K2KJaYpdVvMACeGyDraj/H8SZ/q4V5AsSWa1zEi4bwnNki5SQYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140617; x=1726227017; bh=s9YK7NvqFdOufgpzTSQfb8F8vwyn
	H41O728d4FJIGzQ=; b=ogxXbWO+twwSn9sfDHtvtjQvjok5c3uIPuWKlXznUep3
	B2Zm7J0lTMbK34do4ZE+UKexzSsZ+d/yN7u26TssWyVablD5h5ALkhSaZ9dUe2gs
	BK16zj+eQLf3ENxjjOYVHGhY9NXJalEf0aYmJjFizNyN/J2B7qxOZ/bkFgWfy3+H
	ki1BlBBClj46ybtm8b7Ty/i0LpBIRse78nLXaBW7Db9+C8l6xiOPhkWjfWXkoVAK
	gcMPXEIA7yl7RkZyJjfYTiMIQQd/Xmjr/jtkJEygQLeC91QuUdYKTrgLgIhC9tHy
	hjI4J/pVvNro4Zjzdy5cuYZYJk+8Ja6XiAiIM5IIMA==
X-ME-Sender: <xms:ydDiZlbls6ADrgpImqHCxezCIXHkPG85IDXSgfwSvdoDKIadcYdhEA>
    <xme:ydDiZsYF4lOQpvuxK5ZpuqQikJCqzqJMA9aWQd2rYttgQd7tArfKJRNrAjakbtzNG
    dRgxbKZLRJoYheCMg>
X-ME-Received: <xmr:ydDiZn-xVMbiPffc7AhPJheFRLX_E1A62ydz7gTGz_7z4dUWhpKdf0Sh6S3i2NKn3lMd9kw8b_Wv_1cafj4Vgo6RAzy3fbJ9bWiUuowru0qj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggr
    lhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:ydDiZjoZf5Hw9j5o8WRmEzf28hm8-Wlu0OHnipZHIa8AcLVfIH40gg>
    <xmx:ydDiZgqeg-1-cSJzh9MMusJfbS4dNfXE7OCvz8BbdBkc9ALAB_IcOA>
    <xmx:ydDiZpTiJT-a67KyZwWlc9GCe1HfGpHPy8wE5YRPW1KitMEFsctyjw>
    <xmx:ydDiZooCwJfabp6OxiD0m5B5B48o84-oCh8n8uXo9E-FNOSXYFgDiw>
    <xmx:ydDiZlBlGkz2EfCLFuFKsTAXOm4n-1rPltadH8aqpGUPxHsFVGvL7jSQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:30:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2736f7b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:30:07 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:30:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 17/21] refs: stop modifying global `log_all_ref_updates`
 variable
Message-ID: <128fefd33a86e9b3d80203e891dc383643d6dec0.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

In refs-related code we modify the global `log_all_ref_updates`
variable, which is done because `should_autocreate_reflog()` does not
accept passing an `enum log_refs_config` but instead accesses the global
variable. Adapt its interface such that the value is provided by the
caller, which allows us to compute the proper value locally without
having to modify global state.

This change requires us to move the enum to "repo-settings.h", or
otherwise we get compilation errors due to include cycles. We're about
to fully move this setting into the repo-settings subsystem anyway, so
this is fine.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c      |  3 ++-
 environment.h           |  8 ++------
 refs.c                  |  5 +++--
 refs.h                  |  4 +++-
 refs/files-backend.c    | 23 ++++++++++++-----------
 refs/reftable-backend.c | 12 +++++++-----
 repo-settings.h         |  7 +++++++
 7 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4cfe6fab505..6db7f39492e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -23,6 +23,7 @@
 #include "read-cache.h"
 #include "refs.h"
 #include "remote.h"
+#include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
 #include "setup.h"
@@ -954,7 +955,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
 			if (opts->new_branch_log &&
-			    !should_autocreate_reflog(refname)) {
+			    !should_autocreate_reflog(log_all_ref_updates, refname)) {
 				int ret;
 				struct strbuf err = STRBUF_INIT;
 
diff --git a/environment.h b/environment.h
index 934859e1c59..0b4e5afc36d 100644
--- a/environment.h
+++ b/environment.h
@@ -1,6 +1,8 @@
 #ifndef ENVIRONMENT_H
 #define ENVIRONMENT_H
 
+#include "repo-settings.h"
+
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define GIT_COMMON_DIR_ENVIRONMENT "GIT_COMMON_DIR"
@@ -179,12 +181,6 @@ extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
-enum log_refs_config {
-	LOG_REFS_UNSET = -1,
-	LOG_REFS_NONE = 0,
-	LOG_REFS_NORMAL,
-	LOG_REFS_ALWAYS
-};
 extern enum log_refs_config log_all_ref_updates;
 
 enum rebase_setup_type {
diff --git a/refs.c b/refs.c
index ceb72d4bd74..d7402bcd196 100644
--- a/refs.c
+++ b/refs.c
@@ -24,7 +24,7 @@
 #include "submodule.h"
 #include "worktree.h"
 #include "strvec.h"
-#include "repository.h"
+#include "repo-settings.h"
 #include "setup.h"
 #include "sigchain.h"
 #include "date.h"
@@ -958,7 +958,8 @@ static char *normalize_reflog_message(const char *msg)
 	return strbuf_detach(&sb, NULL);
 }
 
-int should_autocreate_reflog(const char *refname)
+int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
+			     const char *refname)
 {
 	switch (log_all_ref_updates) {
 	case LOG_REFS_ALWAYS:
diff --git a/refs.h b/refs.h
index f8b919a1388..f2c4ccde611 100644
--- a/refs.h
+++ b/refs.h
@@ -3,6 +3,7 @@
 
 #include "commit.h"
 #include "repository.h"
+#include "repo-settings.h"
 
 struct fsck_options;
 struct object_id;
@@ -111,7 +112,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
-int should_autocreate_reflog(const char *refname);
+int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,
+			     const char *refname);
 
 int is_branch(const char *refname);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1bbb550f3af..f5871abcf75 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -8,6 +8,7 @@
 #include "../hex.h"
 #include "../fsck.h"
 #include "../refs.h"
+#include "../repo-settings.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "packed-backend.h"
@@ -1443,6 +1444,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
+			     int flags,
 			     struct strbuf *err);
 
 /*
@@ -1586,7 +1588,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	oidcpy(&lock->old_oid, &orig_oid);
 
 	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
+	    commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -1603,14 +1605,11 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto rollbacklog;
 	}
 
-	flag = log_all_ref_updates;
-	log_all_ref_updates = LOG_REFS_NONE;
 	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
+	    commit_ref_update(refs, lock, &orig_oid, NULL, REF_SKIP_CREATE_REFLOG, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
-	log_all_ref_updates = flag;
 
  rollbacklog:
 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
@@ -1705,13 +1704,17 @@ static int log_ref_setup(struct files_ref_store *refs,
 			 const char *refname, int force_create,
 			 int *logfd, struct strbuf *err)
 {
+	enum log_refs_config log_refs_cfg = log_all_ref_updates;
 	struct strbuf logfile_sb = STRBUF_INIT;
 	char *logfile;
 
+	if (log_refs_cfg == LOG_REFS_UNSET)
+		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+
 	files_reflog_path(refs, &logfile_sb, refname);
 	logfile = strbuf_detach(&logfile_sb, NULL);
 
-	if (force_create || should_autocreate_reflog(refname)) {
+	if (force_create || should_autocreate_reflog(log_refs_cfg, refname)) {
 		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
 			if (errno == ENOENT)
 				strbuf_addf(err, "unable to create directory for '%s': "
@@ -1800,9 +1803,6 @@ static int files_log_ref_write(struct files_ref_store *refs,
 	if (flags & REF_SKIP_CREATE_REFLOG)
 		return 0;
 
-	if (log_all_ref_updates == LOG_REFS_UNSET)
-		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
-
 	result = log_ref_setup(refs, refname,
 			       flags & REF_FORCE_CREATE_REFLOG,
 			       &logfd, err);
@@ -1891,6 +1891,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
+			     int flags,
 			     struct strbuf *err)
 {
 	files_assert_main_repository(refs, "commit_ref_update");
@@ -1898,7 +1899,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 	clear_loose_ref_cache(refs);
 	if (files_log_ref_write(refs, lock->ref_name,
 				&lock->old_oid, oid,
-				logmsg, 0, err)) {
+				logmsg, flags, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -1931,7 +1932,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 			struct strbuf log_err = STRBUF_INIT;
 			if (files_log_ref_write(refs, "HEAD",
 						&lock->old_oid, oid,
-						logmsg, 0, &log_err)) {
+						logmsg, flags, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
 			}
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1c4b19e737f..c78186423a1 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -19,6 +19,7 @@
 #include "../reftable/reftable-record.h"
 #include "../reftable/reftable-error.h"
 #include "../reftable/reftable-iterator.h"
+#include "../repo-settings.h"
 #include "../setup.h"
 #include "../strmap.h"
 #include "parse.h"
@@ -158,20 +159,21 @@ static struct reftable_stack *stack_for(struct reftable_ref_store *store,
 
 static int should_write_log(struct ref_store *refs, const char *refname)
 {
-	if (log_all_ref_updates == LOG_REFS_UNSET)
-		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+	enum log_refs_config log_refs_cfg = log_all_ref_updates;
+	if (log_refs_cfg == LOG_REFS_UNSET)
+		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
-	switch (log_all_ref_updates) {
+	switch (log_refs_cfg) {
 	case LOG_REFS_NONE:
 		return refs_reflog_exists(refs, refname);
 	case LOG_REFS_ALWAYS:
 		return 1;
 	case LOG_REFS_NORMAL:
-		if (should_autocreate_reflog(refname))
+		if (should_autocreate_reflog(log_refs_cfg, refname))
 			return 1;
 		return refs_reflog_exists(refs, refname);
 	default:
-		BUG("unhandled core.logAllRefUpdates value %d", log_all_ref_updates);
+		BUG("unhandled core.logAllRefUpdates value %d", log_refs_cfg);
 	}
 }
 
diff --git a/repo-settings.h b/repo-settings.h
index 28f95695b3a..d03b6e57f0c 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -16,6 +16,13 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP,
 };
 
+enum log_refs_config {
+	LOG_REFS_UNSET = -1,
+	LOG_REFS_NONE = 0,
+	LOG_REFS_NORMAL,
+	LOG_REFS_ALWAYS
+};
+
 struct repo_settings {
 	int initialized;
 
-- 
2.46.0.551.gc5ee8f2d1c.dirty

