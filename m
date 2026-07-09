Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C383E8343
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585779; cv=none; b=YRM9BRUrz5MFIVgG9Yr3FVgnNxU83HPrqXOLuEplYLTrAC973PADSkz+zo3fC8faOn4VFjG3h2tBerGOOXOXhIG5a0cGGF7t0feYSmv+eGUImKLeTEdN7WPZDnQ5UkCq/aKnIwTTTBP2P3WYUO4vBWsueHkZsGJVKXelJ4+5oL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585779; c=relaxed/simple;
	bh=0D9fd11EzvfWbgi9xEby/LLmgNOeuCMM2VWzTlEPLSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkbdyQR6meCcrN8icc176RdH8qsmLVANtrFm0NvHgwQ0cc54F7N4pXaK8BqYdj/wi7+KCgxyfyn4yPwjM1ItXqgKykgQC5WCmssYYI5y7hUTPq64sdA+hJ9PLX8z//zu+OxB8je6gx48+ZaXm5suJuGnSLIBgWB/pVudtbqrjSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fRLoNBx0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjow6oiq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fRLoNBx0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjow6oiq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 969537A013C
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:29:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 09 Jul 2026 04:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783585777;
	 x=1783672177; bh=KKyD4J2tR3GbHcJ+hj+qubKHX0W3XoTr3deRSl7TFKY=; b=
	fRLoNBx0ewcdtvuRyX+5r9GgMxRnCAjgQ8abF0FlCU4OwFeZFhHuEzPLG8iGFr/P
	q6hFx/HAG4QLUjq/2DyRMEgMmS7U/0gFhkJdc1QbtCRaK5KztfBtosV0ozo2eDyi
	6ivP9cmiw4nRrtvYaMcWB7aKyfprH3P7epnWbyp29mH+oBNW5hNcnJyEgJ/oB7Ef
	WOHZTuUeRlnkV6m3WHFDXeIw+wG6+IZ8PkvU9peHVhp5OVMISbQuBHSsl429oGT4
	E9xr4QaJW6GTJVAmHEmXyPzjYbr1gl8QVEkukrI4QufXtWMHGu3fCXqha2v1Pwk1
	zhIsQAinJcT9LgaUZU1nSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783585777; x=
	1783672177; bh=KKyD4J2tR3GbHcJ+hj+qubKHX0W3XoTr3deRSl7TFKY=; b=m
	jow6oiqFyAbdHzF4kw1Ja0Ae1/OBZ7HTAOKmmnKb9+yQnIytn6q92eqxnTjrYeKf
	QqHdSAa8qKvKRwTLnZHcNNokFBrBCJIKN5/x7PbOUzv+dp1HeoVq0krRY9KWhWLW
	gxop4Qnt4YjQh9CTlTfNxBr8FvMIcp7JnEAbowCDpdL+WdVO/4YpwHQBa5EI+dzd
	F8A7nlZK4OHOY1G8wvRQyoj9MXCquXGcYdCLdnw8vpX5FgL4Vq5RjdBt4o5uhzAX
	0jxG0nMS8YO9XeuvoUP0Gy2Ux718bzHb4mF+SHrMze4LuX+54tm8F2hvkQ8DgLJS
	CHfNiQUHSTSzLCLcct1gg==
X-ME-Sender: <xms:8VtPag_jjSVe6ZfFL-MjGcZVrCYqCIaWwhrcZZsrDb3KiO-jZSo9tQ>
    <xme:8VtPavo73XGuQA8UyxMGkldaPtRxAFA9Dkyx-GslSPgTcdUmWtnaoGkwzSUA-PBzB
    KyCzo42hG0uNwUlPu_eAt8ZnqkqhhZnr4q5Z3thWpbopaXGT9jEQC8>
X-ME-Received: <xmr:8VtParqQr9G6Vxk4NeWEX4B3SBPc6XQPSMB8qSjOnveWpcrGKaTL3QIzezxzxZlc-M2p8EpuyP-wRy02Fk9oRXmMDWwiN2VXc8JWRlzXgg>
X-ME-Proxy-Cause: dmFkZTG0KSrVQrMerlpl69jNs503QS7WCYNXlJZX7bgXqFIFuwSflj3Wy3kcnrEj3Meeo6
    RASWfb1B5FMJ/3ZIBzD0Hq2dcMUslsCfXnyjsq6FgtPBqp/IAB7DBjel9+UgXXwFBKyF1g
    66s02lJxrILdZyCoatwx81OcDowT5yBU3s+0MyQEzjF5JVbaW/wZumVCoDdncw3sRzw7Kz
    0EpWsPSVCSz6ZGVBabQ/+bEf+9slNUgr6Ht3cF7vIvEDV2gi9r1IWMsqaOjsA4mOEfXY8o
    Mcno1leo9vI8O9zlRLYc4ZDs7xJ0FFq+9NmuEZYnI4yyM2R9naSS2gI0SJt/92cN/to0Fz
    ER1OhdUzGUyuekEF0rp0FaCk3Ff/1tqKn2We/7dQuNzR5Zpn7cXdPFGLwrYPJhdqN4xdbV
    7Lyp08iw0JJWfFRK72QE0RGRO1KvAirOVQqBbdtj2HePFuub9U3stDcDmdnG8E+Kihgt9G
    ANjb69H/jmaekvM9eld+QP4UzhWsJ7eJO+S/mwUCqd57hPpO6DtGSLW67NjNdQHnujJZqG
    +QVTudt77wfnEQyyTKl+a/KGIVOyWiJv4aeYdGgTwYftq0VuQSu3oAWjMU/PVSkGgVta1y
    VGw5jCdBmimjxt7lr4Lqvdb2kjb7KqIM5f7xvv+cWfLD4HwfPZeYDzEiIgZw
X-ME-Proxy: <xmx:8VtPalk8tSPcWZw_6WT_XCA_8h2HLfpIEEnCqL8wOF5j7GetonB6sw>
    <xmx:8VtPalGdk3mfAc4WhaKolTBuuSXAf5ehC7f1xwEZ3BtjQ1YlWv2rVQ>
    <xmx:8VtPamquh2lkjTAWOWG-yu01nEH58k62zRuh5sq4Om3ljHbfshCIrQ>
    <xmx:8VtPap6IL5qnrhxKjZdQVpJz5kbGp16mlwa3O_b0l8CkZmGYFJVRbg>
    <xmx:8VtPagtUxZVdKDQrZwnlSLHcucOdQvoZyap5PrKBrVCOkGUXNLVXEgFX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:29:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 178a834d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:29:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:29:14 +0200
Subject: [PATCH 3/7] refs/files: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-refs-wo-the-repository-v1-3-1ad6f27529c9@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have a bunch of users of `the_repository` in the "files" backend, all
of which are trivial to convert to instead use the backend's own repo.
Do so.

There is one more dependency on global state though via `ignore_case`,
and thus we can't trivially remove `USE_THE_REPOSITORY_VARIABLE`. But
this is the only use of global state, and we want to ensure that we
don't unwittingly reintroduce a dependency on `the_repository` going
forward.

Add an extern declaration for `ignore_case` so that it becomes
accessible even without `USE_THE_REPOSITORY_VARIABLE` and drop the
define itself.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3df56c25c8..09e1be838a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "../git-compat-util.h"
@@ -29,6 +28,9 @@
 #include "../revision.h"
 #include <wildmatch.h>
 
+/* So that we can drop `USE_THE_REPOSITORY_VARIABLE`. */
+extern int ignore_case;
+
 /*
  * This backend uses the following flags in `ref_update::flags` for
  * internal bookkeeping purposes. Their numerical values must not
@@ -788,7 +790,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 	files_ref_path(refs, &ref_file, refname);
 
 retry:
-	switch (safe_create_leading_directories(the_repository, ref_file.buf)) {
+	switch (safe_create_leading_directories(refs->base.repo, ref_file.buf)) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_EXISTS:
@@ -1164,7 +1166,8 @@ typedef int create_file_fn(const char *path, void *cb);
  * recent call of fn. fn is always called at least once, and will be
  * called more than once if it returns ENOENT or EISDIR.
  */
-static int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
+static int raceproof_create_file(struct files_ref_store *refs,
+				 const char *path, create_file_fn fn, void *cb)
 {
 	/*
 	 * The number of times we will try to remove empty directories
@@ -1220,7 +1223,7 @@ static int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
 			strbuf_addstr(&path_copy, path);
 
 		do {
-			scld_result = safe_create_leading_directories(the_repository, path_copy.buf);
+			scld_result = safe_create_leading_directories(refs->base.repo, path_copy.buf);
 			if (scld_result == SCLD_OK)
 				goto retry_fn;
 		} while (scld_result == SCLD_VANISHED && create_directories_remaining-- > 0);
@@ -1289,7 +1292,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	cb_data.lk   = &lock->lk;
 	cb_data.repo = refs->base.repo;
 
-	if (raceproof_create_file(ref_file.buf, create_reflock, &cb_data)) {
+	if (raceproof_create_file(refs, ref_file.buf, create_reflock, &cb_data)) {
 		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
@@ -1383,7 +1386,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(the_hash_algo), &r->oid, NULL, NULL, NULL,
+			null_oid(refs->base.repo->hash_algo), &r->oid, NULL, NULL, NULL,
 			NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
@@ -1629,7 +1632,7 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 	files_reflog_path(refs, &path, newrefname);
 	files_reflog_path(refs, &tmp, TMP_RENAMED_LOG);
 	cb.tmp_renamed_log = tmp.buf;
-	ret = raceproof_create_file(path.buf, rename_tmp_log_callback, &cb);
+	ret = raceproof_create_file(refs, path.buf, rename_tmp_log_callback, &cb);
 	if (ret) {
 		if (errno == EISDIR)
 			error("directory not empty: %s", path.buf);
@@ -1916,13 +1919,13 @@ static int log_ref_setup(struct files_ref_store *refs,
 	char *logfile;
 
 	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository(the_repository) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+		log_refs_cfg = is_bare_repository(refs->base.repo) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	files_reflog_path(refs, &logfile_sb, refname);
 	logfile = strbuf_detach(&logfile_sb, NULL);
 
 	if (force_create || should_autocreate_reflog(log_refs_cfg, refname)) {
-		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
+		if (raceproof_create_file(refs, logfile, open_or_create_logfile, logfd)) {
 			if (errno == ENOENT)
 				strbuf_addf(err, "unable to create directory for '%s': "
 					    "%s", logfile, strerror(errno));
@@ -1955,7 +1958,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 	}
 
 	if (*logfd >= 0)
-		adjust_shared_perm(the_repository, logfile);
+		adjust_shared_perm(refs->base.repo, logfile);
 
 	free(logfile);
 	return 0;
@@ -3672,8 +3675,8 @@ static int files_ref_store_create_on_disk(struct ref_store *ref_store,
 	 *   they do not understand the reference format extension.
 	 */
 	strbuf_addf(&sb, "%s/refs", ref_store->gitdir);
-	safe_create_dir(the_repository, sb.buf, 1);
-	adjust_shared_perm(the_repository, sb.buf);
+	safe_create_dir(refs->base.repo, sb.buf, 1);
+	adjust_shared_perm(refs->base.repo, sb.buf);
 
 	/*
 	 * There is no need to create directories for common refs when creating
@@ -3685,11 +3688,11 @@ static int files_ref_store_create_on_disk(struct ref_store *ref_store,
 		 */
 		strbuf_reset(&sb);
 		files_ref_path(refs, &sb, "refs/heads");
-		safe_create_dir(the_repository, sb.buf, 1);
+		safe_create_dir(refs->base.repo, sb.buf, 1);
 
 		strbuf_reset(&sb);
 		files_ref_path(refs, &sb, "refs/tags");
-		safe_create_dir(the_repository, sb.buf, 1);
+		safe_create_dir(refs->base.repo, sb.buf, 1);
 	}
 
 	strbuf_release(&sb);

-- 
2.55.0.175.ge4962bd3d5.dirty

