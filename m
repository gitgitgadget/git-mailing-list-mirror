Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCE32F757
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180002; cv=none; b=BYZyyeBfUcIAEVmLoCtQDOHriBcOIe7B77ZKYvs0JxLYp0PUmOLkkFoa5/ei7RizfFm/pKPWfbb83lau9zJREd2JytNdBeYxry8ajjvBc+xdF6AdghSkriXU8uGQC/m7AELm+3nhDWHWlEFGRs0IWBFdnjUe248VF9oMFC+bq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180002; c=relaxed/simple;
	bh=5n4lvk57bdBw4z0nVz7VcHlKczhryq5yTWSd9Shj57g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/6XhJ6WZ1zyW6vyZBpYyaNIbisH7YE9vndNUtyqZFFH3WbsnqJ3BL9xxEcBnNd4Bsghrm9s9DE5yayFqghSUPX837gs2AXbFNCmsIlp/VurajQGXhe/JPZgwr7nVd3W7zhnfjc6HuXlhOVfju4IfPdx79eevTvqhrcKqKOaYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QCX5DJa4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R14US3fj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QCX5DJa4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R14US3fj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FD487A0010;
	Thu, 16 Jul 2026 01:33:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 01:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784179999;
	 x=1784266399; bh=mg4ttO/8p8OVV8gDdvbXsPZIf3Ney2brnz1yGEwjGKE=; b=
	QCX5DJa4V3f9JYf4d0amaTj+JhOTQyh17asKIJkgpGMotCYYn9UeQXq+iNuy7Oo9
	kSetuIfJH0aEUFwADSJSZdUXa9IBUCF94Y9ouRm+jBRqAxq5bnPp+4ySi7/VQl9o
	P83xwsvUHvbgPInbKHDBE879W2Y0x4hXxO5wLXhtK/NVj489eCukBRy92ZhlP+Vk
	LcCas1rs/UFE5dSebbovgjMna1ZgbSADEMO5XNBu4TBR+0b+FinybcNhlO2O2A85
	LRUTLMb0A9SXVxZioxA+L697P4+Ve+WpUZgBbxo3bHutT6Q3TVmXc1JpFhRGabSI
	Nx5qerI16Qg282RXQBAQ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784179999; x=
	1784266399; bh=mg4ttO/8p8OVV8gDdvbXsPZIf3Ney2brnz1yGEwjGKE=; b=R
	14US3fj6F12CvqSiTvlTM8CMu+o7n5Kz9Ky2GhQAcc1JEWm7HN90FuBt2WwtUZxa
	El4NLGYS0RRVtGcXI1h0Xv/x3eY/8U3E09MJnGE65d1srFyP6ygfx0Alfy8SJghD
	7SKX9zc/aLqC3vvZyXKw9OBpObfsapYlnPAMQ9unEUljPDAMJgUc3SF/dCDMWxv/
	hvlbaKrtE/HRTkkp0Bdc2FN63kWi9eaJD36M1isqoO/aVoJnX5s0H6QylJQqaVLl
	ESE2glSoPW1uuyhHxWY+lmZRZ3kgozltrOXMg985uSK47Hsy5JaRQTmnmK3vedgV
	G7kuvk3W5O41p9+rPJtUA==
X-ME-Sender: <xms:H21YatEwnS9LY0kY7aUwgpUBhwlOoLtwxQScBkJNqEjQCf1z-7n82A>
    <xme:H21YapyGR3AVlp5a4vT-CDy8sjRTi4Yb5AV-G9rVcP5T-KT_6XH05yNIfts6NTlwf
    v5n97sw_AvZ5JjglC-1aFmowWTNLmvEYMc3UvGh9kH8HsNd7qWAnA>
X-ME-Received: <xmr:H21YasiAsqXV08WBumzr93pKR31UVaxwa8Zep9JkLFrBzFNGc_QRFVdTsAKqA-6IdQCfBQtoWxj5jeYH1OojaA7Y7pMH0_FowzAq5k0R>
X-ME-Proxy-Cause: dmFkZTF/nOZMhQgUkg9G1MLY4kq5azmscwMLtZjOrrS14Tk3AsRc1pPUnqc8E78hcFINR8
    ji8v8mmxeUSCJI/mG7IrTUQemUJlSwXqowYfdaf1y+xFPM8XCPLNbNWNnw/I68ut4t1I1c
    rfiA4Lhhtw/2BHU763a7pjeWeGSL6erYwbSGxYCmRZJgwYJH9VfDD+EwWEt/lXqpIa4xQ0
    4n3xputboOqY/h6Eks+/0qvn1SKu2BLrhe9A3ShwF56R+kPnjeegXWLCNGCa8tvr0cYYcN
    tQSOGU+/Hfs/06ImYOEX1MHeAHv/fD9kx7F9OOgj2FYiApBbRdacDL9eBYBB60ODZmTFcP
    HLz90b84J9mEYshgPsCSgvX6kHBkHQlHpPAn1ZbQCNudeKXkjJgw7cnLeb9LZ5pHupw5xU
    wHlgc2l+YZinQc+nDGR8XX+BkHDc+6TcfJnRycyJyP1M5xDHuJHTzOzVL9XjBqM2r8We6L
    XWxqB45E1fq+r9npxUnBQbe5O721RB3A3zaCy0TcY1nU2/71uKxe9KTifFfteEgpqMvUX4
    sIgf0eddz3vg7HwCXbZ0TkdrLuUdv9btsdctY5BGjdp9T2XMLucTsyFshamDkU6rwjcfcI
    foKFnzWL1Jct7Dr+6jNleuEUZKmfxj7qpDADMwi8XOct6kcfySukf4x2dflg
X-ME-Proxy: <xmx:H21YaswI3_2ExC2Su7_G3Z_R9YIcTslp6ocbyw61vShqxr7sdBqQKw>
    <xmx:H21YanKCT-gtiKo_vB4hvUnfObVdPifbHvnkCZJ1wxZ--02x2mC_GA>
    <xmx:H21YarR3toD4YvOO9-PTQf3PrgIVER9vgMWs0HeYUtSXcSOzpx9-UQ>
    <xmx:H21Yanq5_5wsDRblR3isp7pOOLACYVIB2sVRNq4mt4Y-kEALptpjcg>
    <xmx:H21YarYH-AKbnXp_FB_3lAukZAJiaI67O-gg-LD7ZsOndPGIn6egUHFl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:33:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2683fd69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 05:33:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 07:33:03 +0200
Subject: [PATCH v3 2/6] refs/files: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-refs-wo-the-repository-v3-2-db0a804e0224@pks.im>
References: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
In-Reply-To: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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
2.55.0.313.g8d093f411d.dirty

