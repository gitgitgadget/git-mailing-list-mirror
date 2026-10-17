Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0F430794
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222362; cv=none; b=AcdARcflbbEVsUX5HuznqYdKnPBCc5GL+Hdhms2G+C0s1gcWG/YDdCCLwQIAFkEYa/dubNLO4Cw695qYbUiz8oe+NRjWexUsLPzD2VmUQmTSf5DmAjUixYzTD9Yi2qv/f033SghSGB1XDiC2aJjctEdVeWZ9/5Z+QAQXZUTikP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222362; c=relaxed/simple;
	bh=vo02FORFLZciaRoFCYm98fYhN3japEJttfKGvhavfa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxCVU/tWhsVVSpXmGVv4eOjhBvmzkxfTRZzOhA+2Clml2bzW/1GL43PqNoEzkavMdcXD/e/GYesx09leT21AVo+bAV4kZID+YD/uU6dINqTCNhTfpHXy7sSbwaLzlL4hQxNyFEjPD8pGDlGR/QSHyKhcrkmPyLpLd53PZK3Ew3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htNm1lfM; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htNm1lfM"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c6e6822b11so160964137.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792222360; x=1792827160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fr1CFEn2Vkk5hV42aQ3ZSpRmSRPIU2ioyx66YcHpQIQ=;
        b=htNm1lfMPLMEC3ixSoK2wuqbALve4K08Y07iLUNlnQR6MzYt9W0/0gp/TGE2Bf0uAb
         37D3JSFUPoNohM8iidQuZ4BWSdlgbWQCePG+6IZW/6VEv2eNr+Z23EKS8Le4krDczKxm
         488jGICnJdIKmJzW8n2HovgIjKRh2m074jIDLqUVptv3RGdnEZQ0w4X5j1S9na+tbQWF
         brzWPEC3X3wUHkK7qtBXPSHo+V2AosorOlC2813h0PlXeBChYjdIZSoLdnakw9QMR3Dy
         CIcuTOKwQCexPnUSl0P3PU9iPG7ow4nqq9PhBvnXk5he66DqpKvckafmt0NTG/VJ5Bnv
         BsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792222360; x=1792827160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fr1CFEn2Vkk5hV42aQ3ZSpRmSRPIU2ioyx66YcHpQIQ=;
        b=VKzxp8pz3TP+F32ZQdgDq0vvFEDmMd8zwUWXKTRa1nblmU5Bs61oQgTK1RWKdNeTv4
         rmDWoTiBKUzdom6nxejHmG/Qe/uConSy+MiyARyjRSLGQqHXS+Fn+3fKwGJiY3KlDYe9
         1FZQGl7aQPxuYiD7oZ+vuN182Q6ms9v2jR7rrSkM1dZ+gTGjJlMDimUPKcT4fLlIB3Ta
         FECaWIvy4wgCA95QejJgQqjt+1ZC5Vbj+WiVHgXUR3A/YFXPL/+nyJL29bLYpTy/r5MG
         1L+0lPbYtLxQbvv1AB2YVWzWlKCcyk0mqk4Z06KfDJ0BIEm2NVQ13IxJe0ZrlmEW8tv3
         YTXA==
X-Gm-Message-State: AFq9FYKesbxTQ2cESvBowMchGkKNOq3M+yB0kKT25r+wahrDy37YALQI
	/N70KKdoPBJT4xE0Y7E1M8NlZFzsBUwQvIkhdCjTnvtEdVN/5QoPtfGk0gUhdg==
X-Gm-Gg: AYBFou2+cskvpa6KWwThg+QOWlQ5XyufX/cmZQJmxLqzNOG2ekevYamD+uiV23FP3DJ
	HzJgXNtFJEsUyeslla8gJt3vaXmDiVKHu5y6GKu0bFrAsxt59YH6I7ZUiUHj0RO3AztmQRhFIM2
	XwdV/JbAv1gKyX6a+qUihwFwc/IZvB8lhdI51NtAAVxnRfILe9B/QAKu6Vub8KrRqsSBxKGmkhT
	O69hz+8KVIv/SkG3xd8sWaYdcQxnkMqIh7A05AGKtXHZTqwsiMUHI/8+tan/CaDzPJHy/bpbC56
	YUt5wklGdIBZ6SdsSEs79Hv4qjZXNnkbG09QIH4EZlWpWScIGqZIoeTc+UAoFgKn3T4tV1DhAAu
	Bfiiomdyp0X9YlrB58sgvAvh5unpTp+n3+KjIinqH8KjoQYWXQiHBMpVaqcAgFLhxlB4hHVIDTq
	w3LDPQ56zwC+eIE6cyg/cVFMrr2PSTu/9EMx4xDjbfFgiyQUHaK89tSuE0YokLSWqk6CVy80DdX
	Kn7ohIrZTEskaPE5fOYyFu7pVpEDcu74DOLhTOYz/ZQVD7Sn5jU7ss8tMSSOg1i5g==
X-Received: by 2002:a05:6102:5249:b0:7a7:19aa:f0d8 with SMTP id ada2fe7eead31-7cc36b48339mr422294137.37.1792222360103;
        Sat, 17 Oct 2026 00:32:40 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990835c2180sm3379305241.3.2026.10.17.00.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 00:32:39 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: [PATCH v2 3/4] commit: fix write race
Date: Sat, 17 Oct 2026 00:32:30 -0700
Message-ID: <20261017073231.3357477-4-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017073231.3357477-1-quark.zju@gmail.com>
References: <20261013172315.2997446-1-quark.zju@gmail.com>
 <20261017073231.3357477-1-quark.zju@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Wu <quark@meta.com>

"commit" today does "read (index) -> lock -> write" and it does not verify
index is unchanged after locking, therefore is racy (an update made by another
process between "read" and "lock" gets overwritten). Fix the race by reordering
to "lock -> read -> write". This is more correct, but at the cost of more work
(e.g. lstat() the whole working tree) while holding the index lock.

The other purpose of fixing the write race is to make repo_hold_locked_index()
(see previous commit) believe that "commit" is now race-free, so "commit"
qualifies the new "waiting for index lock" behavior, which could be more
friendly to end-users (that expect "commit" to not fail).

Context checked: history shows no particular reason for reading before locking:
- f5bbc3225c (Port git commit to C., 2007-11-08): lock before reading
- 2888605c64 (builtin-commit: fix partial-commit support, 2007-11-18):
  seems to accidentally move reading to before locking

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jun Wu <quark@meta.com>
---
 builtin/commit.c              | 9 ++-------
 t/t0032-index-lock-timeout.sh | 5 ++---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a808c0ba39..bf41f04da7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -389,13 +389,13 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	    (!amend || (fixup_message && strcmp(fixup_prefix, "amend"))))))
 		die(_("No paths with --include/--only does not make sense."));
 
+	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
+
 	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
 
 	if (interactive) {
 		char *old_index_env = NULL, *old_repo_index_file;
-		repo_hold_locked_index(the_repository, &index_lock,
-				       LOCK_DIE_ON_ERROR);
 
 		refresh_cache_or_die(refresh_flags);
 
@@ -453,8 +453,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		char *ps_matched = xcalloc(pathspec.nr, 1);
-		repo_hold_locked_index(the_repository, &index_lock,
-				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
 				   &pathspec, ps_matched, 0, 0, 0 );
 		if (!all && report_path_error(ps_matched, &pathspec))
@@ -480,8 +478,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 * We still need to refresh the index here.
 	 */
 	if (!only && !pathspec.nr) {
-		repo_hold_locked_index(the_repository, &index_lock,
-				       LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
 		if (the_repository->index->cache_changed
 		    || !cache_tree_fully_valid(the_repository->index))
@@ -531,7 +527,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	if (repo_read_index(the_repository) < 0)
 		die(_("cannot read the index"));
 
-	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
 	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 	cache_tree_update(the_repository->index, WRITE_TREE_SILENT);
diff --git a/t/t0032-index-lock-timeout.sh b/t/t0032-index-lock-timeout.sh
index cde6f1892c..18caa182d7 100755
--- a/t/t0032-index-lock-timeout.sh
+++ b/t/t0032-index-lock-timeout.sh
@@ -29,13 +29,12 @@ test_expect_success 'index locked, add waits with indexLockTimeout>0' '
 	git -c core.indexLockTimeout=5000 add foo
 '
 
-test_expect_success 'index locked, commit fails even with indexLockTimeout>0 (read index before lock)' '
+test_expect_success 'index locked, commit waits with indexLockTimeout>0' '
 	prepare_index_lock &&
-	test_must_fail_with_index_lock git -c core.indexLockTimeout=5000 commit -m init
+	git -c core.indexLockTimeout=5000 commit -m init
 '
 
 test_expect_success 'index locked, checkout waits with indexLockTimeout>0' '
-	git commit -m init &&
 	prepare_index_lock &&
 	git -c core.indexLockTimeout=5000 checkout HEAD
 '
-- 
2.56.0

