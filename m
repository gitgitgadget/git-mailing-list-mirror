Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6218FC93
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924360; cv=none; b=bng4Cvwc5965MgWkNe4MZOeGXoud1pCbZQMAlYVx4xboFUREcXFg/CsSEG3JXmKKQ+tRH4RTflzwESfhdGySKBHx4OyTlE/iYrJCTT6wN5LrCaHqy+egiMZ6Xf+z8U4I3JK4JEVpHvTrc86S01BiDKiqu66gJhUq6oHfgqRdx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924360; c=relaxed/simple;
	bh=GUyIfW6CDxEdHvtnqHtKMLzImLo3kOaGCUgfdjpKoBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmNyiiYvimep9IfMWf8EA5NgxgrTWGD9/SHf8CcKrP+n558diYG21r+BM/1E6L7RXdBAtnK8NfRNydLuGl55C/KO/xJkm0RdYbYy711KpPae7xAMfWn21Gc64eDPjJLmCQCKS6B96PYfCcDYMaZm+7xfqRB52r39bX3qcl04LCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M26m+6jl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=heSAj11S; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M26m+6jl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="heSAj11S"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1BE531390160;
	Thu, 29 Aug 2024 05:39:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 29 Aug 2024 05:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924358; x=1725010758; bh=qH4ofANSUL
	AAJLhYZ5RTn1IbVE0EY6y7lCCY4ViaQYE=; b=M26m+6jlvBLr8g3ernGWtWadrU
	9g98Mv5ETXl0iq07KGFqKWLsDb+FiTXOgBRsWp8rk/L9mTLcCmLfLfJjhQGKcu/0
	IU8zoYSE8sf9Kx/o83PCK2ryu/k8Z0kmCJYZEgwjcXo14nj7kjHxWREKQT/wdXdS
	NNYHtOc4+M27/7yD3bhYB2w/Kh1llTNS5hvc4hjoS9Rqy3qM+zwBOFEW4pycjioH
	uRP6fLeeehp4qE3XFFYU7zXdE6UcAFvbPAl2ta7jklQmUECIgsc4mtbMB9HDc6kh
	+UWBcmWZ3GsUHRgLkwkD7ig0aYBxXD0xcNFZXjHDXNg7Ya6xQfltdAwBU/tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924358; x=1725010758; bh=qH4ofANSULAAJLhYZ5RTn1IbVE0E
	Y6y7lCCY4ViaQYE=; b=heSAj11SLCb6vJPemOjS0t5frAguGH52u17TNEsdg3KI
	tp8huslFd5ITpOvxSIz85XJs+cKLEzW1hUO0N2Gk+I/FNphsityYRVxTJsv+R0U0
	eyoQFCv754qBQiqkyxFjBdQQYYPngM80veLQlLSdoWKlEuY+kvp9MwhkkijVsnZy
	RrEA8VB8IYHAKKUb184JZ2dld5ar9ofs425rdmj+P37cup/gclp6TGVM6DJimQ6k
	PDM4piUaa9zZeQoB1Ruz/aTTtb3yOAf9uC3J9/ImnTNkVj7q7n0Nb9ZzfsVpotKf
	Hsl5DrLxBGfCri+F/3fcuOTBOr3SJ0xiPmqVSRMp7g==
X-ME-Sender: <xms:xUHQZo1gp-YQ5q7_Zugi5X9oxSr4d_wWxKYXTDlX11MMxXqKcenK9A>
    <xme:xUHQZjHm9CVyfy-qXGq516_5psERV5SQ8bQ4j-7pBIeriKwO2_gKOtzf45mB_lxqd
    o7KOgHLMU0Se1BBWw>
X-ME-Received: <xmr:xUHQZg5hotpSR2H6Y_U1dUsdK9U3FW_Xl5Gmz6B5myeKpQePt19cW81Bhm7uLfoVF7jxlspIetqmxXPqeA8W7-dJ1gRdskMJuVVvKYFAAIDQIhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xUHQZh1TIdx3qZRk58_AK3OZZRdapRvSJ6XSJrofzX7Q_7BMlukISQ>
    <xmx:xkHQZrE13KtrsmZNYCXmSbI-6eG0eLpUmMoqAQ-V3RDPxPZMjEtmnQ>
    <xmx:xkHQZq9-EoPVMro5HmCtQqy1WvdYvURDN-FUZl1l2N3vTYLqZuXqrw>
    <xmx:xkHQZgm8omoQnTfvX6KVyMcgQiEJoIY-JXsDBLe6rVmQtdVuGIs52A>
    <xmx:xkHQZgToG1tW6wH2HKglnnQAAk_rXWQ-jr1RNQKI90XYa7PN2AaljDiS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 815fe078 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:39:08 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 16/21] refs: stop modifying global `log_all_ref_updates`
 variable
Message-ID: <626e24aac7a3b38b427f91ea18da107452a5193a.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

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
 builtin/checkout.c      |  2 +-
 environment.h           |  8 ++------
 refs.c                  |  3 ++-
 refs.h                  |  4 +++-
 refs/files-backend.c    | 22 +++++++++++-----------
 refs/reftable-backend.c | 12 +++++++-----
 repo-settings.h         |  7 +++++++
 7 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4cfe6fab505..a0214486471 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -954,7 +954,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
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
index ceb72d4bd74..822e0063ef6 100644
--- a/refs.c
+++ b/refs.c
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
index 1bbb550f3af..c143cde8aa4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1443,6 +1443,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
+			     int flags,
 			     struct strbuf *err);
 
 /*
@@ -1586,7 +1587,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	oidcpy(&lock->old_oid, &orig_oid);
 
 	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
-	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
+	    commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -1603,14 +1604,11 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
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
@@ -1705,13 +1703,17 @@ static int log_ref_setup(struct files_ref_store *refs,
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
@@ -1800,9 +1802,6 @@ static int files_log_ref_write(struct files_ref_store *refs,
 	if (flags & REF_SKIP_CREATE_REFLOG)
 		return 0;
 
-	if (log_all_ref_updates == LOG_REFS_UNSET)
-		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
-
 	result = log_ref_setup(refs, refname,
 			       flags & REF_FORCE_CREATE_REFLOG,
 			       &logfd, err);
@@ -1891,6 +1890,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
+			     int flags,
 			     struct strbuf *err)
 {
 	files_assert_main_repository(refs, "commit_ref_update");
@@ -1898,7 +1898,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 	clear_loose_ref_cache(refs);
 	if (files_log_ref_write(refs, lock->ref_name,
 				&lock->old_oid, oid,
-				logmsg, 0, err)) {
+				logmsg, flags, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -1931,7 +1931,7 @@ static int commit_ref_update(struct files_ref_store *refs,
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
index ff20a965373..736968490a3 100644
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
2.46.0.421.g159f2d50e7.dirty

