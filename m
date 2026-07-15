Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13587197A7D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101188; cv=none; b=ShEh8Pj0LoVIvV20WhLO72P1YMz/omhSyBK9oS3Mjh+lR+26RiVNTELIoRyjI+4LmFgAkflk+/9TjkeE3+iLrZImw1vM46rjvdP0cJ5+l0Du47CHwwV+mhyoW95dcfrULhfYHXCCXHn0CfpOtsHrO6RMaun4xz9M5Iki+V6CkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101188; c=relaxed/simple;
	bh=5n4lvk57bdBw4z0nVz7VcHlKczhryq5yTWSd9Shj57g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6IjZxdxDAIZWIAXKZg/8UfGn+TIXYqP8VW0bEqlCnxdxBdE3jT+bThxM7f+4wJA5TnLZzdZqmTPg8NSx7k3sc9ZgVdrR6llztgxpjTgoQbQ4h3LovPFst3n2ynRuayC19k4+OszvK2Mmeksh7aGZN3/EPS3G/MnpkQIUiMz6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mmrAVqCp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVKTmIdK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mmrAVqCp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVKTmIdK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6264E1D00169;
	Wed, 15 Jul 2026 03:39:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 03:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784101186;
	 x=1784187586; bh=mg4ttO/8p8OVV8gDdvbXsPZIf3Ney2brnz1yGEwjGKE=; b=
	mmrAVqCpXE5osvzJXXewCT7LAM4OdGnVBAGQqz8C9GUumkKzrbV9Sr7gXrlGb7T9
	DQa9ZzR3240fjTnyv1o3Bf58VmGT4gI5VR7xDk5kbyoUhCngFgEKEz73g8/Ws2JO
	hxvWd+XAwTXfhYi9HYES7GLha7TIwWYOGYuV8g+8Ov3kbxuebAThqKCJfpaSHry1
	N6+QLjsg+o5G5poLP4ikU81MIVnvJLoXJIEAaavBdPgXVghrxhTPjmbQ8KRYupsB
	o0ZsFticOedT1wfkoImlb5dBFuw3bBixAmAI4bAj/0ptpmYfOU5VB2HzrjcEiuJc
	khcQSax8As3CCcx0NTD1xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784101186; x=
	1784187586; bh=mg4ttO/8p8OVV8gDdvbXsPZIf3Ney2brnz1yGEwjGKE=; b=J
	VKTmIdKP+1ceY+a91uTpBm5kA7DP7DagTkImngYqZvCIdT87k5/2TwuFFsWrZjQi
	GhDJ56TuLrj2GNNRNyHSNlQy5Gb4rw4Hv93Ksp2cS52X9W7BKsWZoYTjcC0JpkHi
	Bp5HTwjrTesdXqI6LEAHT68Q3ki6XafzsZUH+xRAY9Z8wjucn1Sp0VvJD8Zvmlq/
	kEfgXa1WChYs4TVL9YLp1LZeeof1rIUOQ/Vf9vZ5dR+jPfVYYp3YTAWxk1zcW/Kn
	9FbTI9S8dJjGRrqb+GsRku/CrHa57uEUcUlhUjzd8xobuLx+H3gww1U1ryPiZhJS
	kclZqkgHoo3L8OHr/KnQQ==
X-ME-Sender: <xms:QjlXanzOgp_vLMFSPIdsMs3MksUOc-HNEW_RdE4YRnHn6QKzgSiKZQ>
    <xme:QjlXalTyGCv7LJEEn31VjxBO_pXDjgDvkn4yjHdVvIcZemjuc3xBruz9cRGBO8fjH
    N4RRMfk0Inrw8wEHVKufLQJa6F6f8k4w14Er9AebJt_tb_uulyx-g>
X-ME-Received: <xmr:QjlXau-bDzVHz26sJlfbcD7PPycinrrTc5UqsCt2iqJbtLOYQGHL7Wr2SEeBErqI1giCE1viS5O-2VZ17naHL2QfvXotXmTOOm01ZybtL10>
X-ME-Proxy-Cause: dmFkZTGK3e1xq10g9H+eaI8Qca7IIpa67ANoiOnlBVJnvZo9C1IvtIQiKmonJXHo0c02+G
    5ZqJdeFCWDuNinkqdf9LW+S5rFn/XO0RZb2l4qfJXhxtO/kNxi+MhlQ7Zsr/7hc5EwzrBa
    jZjUayygEG8Bfp9r8u4BA7lQrdE5+2R9wKDRb02dCwg9U4zY3tnxdNdUNBbauIbxmAWco5
    fP//QiR8VIQ1qcx9jsqkMD1IiR0ygxr+NwzVjNVjOtMOrEhKmX7K1H49k3Y0eBfkAGep+X
    OM5JZzWWukbyXy2Ez3SAgW2ZLfjX/RhhSFgM8/c5+aevfNfgNdFSMJ5+O1JeinxMWvOaMY
    p3MIS4ePHfKckRYDA/F2gxhR8TWTR3h0o7iQzhLRfGGlay0yc+32zhE4HKn77DzdrtF+gH
    1jl8PzawsgYJGYwf4ExQ9Ut+9iymphRY9aixq0jllTvO/o0SILK7Iu305DQuE9lWbpbrGj
    IKjgWzf15YXEz7OanKdNfwcBpvoi2OM/7l7wmrsNBxug7rMCkGcHCnLkrLjhaV4hvgVjlY
    c8o14Mbr5sHS/YuzbJU0k/yooBtz7hjvc8S82to6D1XkwsRzK+DMFzkEUFLPrsFJ/hdts/
    fpQ2ZIaC1ouWaWiLuxAHWV3MKJ8lGWtBBTMVZvDvwr5tuyh1dV+bSbSuAq3A
X-ME-Proxy: <xmx:QjlXaspn7McJzWkRU_8lie8XfUa7nqFmGIuR3fO61Uqp0VFZlUPk8Q>
    <xmx:QjlXarkq5kgXd7emeoWocgy4umbw4HhA_MB3TB0fSEgznuedmpdopg>
    <xmx:QjlXajJShkKASBASIB8VNXkL3eoJCQ13zvKNbfig4hfDwnbjMLyncg>
    <xmx:QjlXagyetv6Hf7RmzikLSxhWZnAIEaxQGVpZ8XAeIOlkYnMRCcPp1Q>
    <xmx:QjlXarLKLEDpoagqjlgDGquQXzjffyy3ASTjwcdF73ATwKbF1v6yPv8f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 03:39:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ca2023f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 07:39:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 09:39:36 +0200
Subject: [PATCH v2 3/7] refs/files: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-refs-wo-the-repository-v2-3-d00d364f5a3e@pks.im>
References: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
In-Reply-To: <20260715-pks-refs-wo-the-repository-v2-0-d00d364f5a3e@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

