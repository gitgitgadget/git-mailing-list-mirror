Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F83822B1
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222360; cv=none; b=V1AncwDXgq4X7CsNUV4UuH9mxQKDnnJoKKmbfoSSQkVAVahvLzkQHDVNm6gQAE7gSNfaVM+iNAwl2OXODbYG0GLCuNiwNwVnT4MENKQRPvG02/AlnW9V2wPul2WB0I5FO0tvd9GWykV7g8FhrgzC5IjCr8laVh3fEIo2/8Sbxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222360; c=relaxed/simple;
	bh=7qkGVwzsJWcmZouMQFjVJMIPcM0pEOnJ6OOwObENGKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0IKPnuMnAxW35e1UXM4uTDs3Q/5rM/U2AasK1LcU9tpQ6ul4xqEHp+YcazyNCry5EwS2zfGaRSHgIb/ABDLbAKhXyf9FTsY7RjDPcjd63+s6UW1v23hQmrf+Eec/fLF+603OrPbkURP2o5KuZMRE0eOQMHkz6iIBWJ4X746Vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDO572h0; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDO572h0"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso383956137.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792222358; x=1792827158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWwKSGi9sInR+eq9BaaPcfVotsOm6364jA+qZgZPCFM=;
        b=GDO572h0hSWLDqy+HP0qMvvI1j6H4sU1pNu3Ya32ZZL1wVHAIjC2bicX6UABZRZF9V
         UOC+mmXazluIiFtcTfwDxx2FmvFdjPcASci4BpuLcsLrZ0ttCnaJgyIhL9NnJSYYiqwM
         pwTficiNkI7vKM04F3srUE88HYWkIIt6he9jqDc2+Adz3pQ4lLH5CR3imh/3UgVdzHV7
         hFj8ty7sM7beweqGun1qi4HNwfzi+SxKc8KZzQisaCYO5bBT5ma89bCaGu3ozOu9odgC
         xC2N3S9qudOUzUWN2BzW49mGYb0RcDieH2buWTItzjmZn2jr/Ax/4ihYIOiUsPLMidiV
         7wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792222358; x=1792827158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWwKSGi9sInR+eq9BaaPcfVotsOm6364jA+qZgZPCFM=;
        b=RS6Xv1YrbVacXLz2EVTra44G9JO+MeCT9sI6k+NoJmtsBlLmqDJ3pWfeRdZtI4eOOV
         U1jqcg7H9Ndy0Gtc06YVURVk14m2ebUIakFimiJW+tEmVFSFkFytoiqX4FrL9iG/6JDa
         /8Wo0kF23Hd2gDczSto/DZym05HNp3qIuS9WjMlOEWRXCNwqkvRsxPRNlXeR38X6NSl7
         taHW38rA8ePAqMvxmhtLGRalV8lufuNxdOkEUGZXZGsWsN9zcsZ0bKw6MfWnHnYbw6WR
         uABtH13b3rPFVWD6qOn7miVlg9NeFOw/bNBiPiKqDKn+WD9YByPeSs1UkbzhGyKT98x3
         ytfw==
X-Gm-Message-State: AFq9FYJNo3i0xnRA0dclw4x2qdYTTXi32ohqL1mk/D+qNcx/kI+7H3jY
	gS4Ab8DXb3l8u6gU+AyuCIEKcJNFFp0TOmW5gt0IaWmv6+HSc+C976EATvm41w==
X-Gm-Gg: AYBFou1Yl0tl8OUD9IO6RamcWSQHbZmGJnvXju/zBLNmYqY1zYWMANA4oPYjAIACh8K
	MV6eKyYbpvfqW0MCLgxbXmcrDZePqwuW5supMJbBJmosyxuoaP0MIojz6yb+SexYmrs29odu6EQ
	b1apMeHc2j1/y4LW61uwA6wwF9pTZmXFk/IZHj1KKmhmKLVv7nPNkJZuOIoXZ4XlVHSDgnxp2so
	l9OtgKFGqs06JjaBuNsxN82huBmBk/TMZFVxCvs5kix9paMIkiVMWK5ZQ4+WNB/e9lmnqbrrpFu
	AszgkbZEj4PesVaeYcwb1J0LQSXRWbwQm4sA3DRPBSMkfy34np/fRV8moVeidHhArQzJuo5IAkY
	WQzBhWqgpH9QDMsCsemxRhR4lXlRgA2b7AXauH8OdrvzvkNli1FqfO5Zokq88wvw/CzoC61KAm2
	aHD7WEFauyvWOMwjHUk38L50w8fNduTe61RVe13iPZxnITXV5whHQsCakK1bp52abwSQhaxLEA9
	wWg/86Baxuxsvmhx53wOXiJcHMrYJVJ5lsI6Ob1/O7OR0zjwvtQk8sDbGTsTy3Lwi4=
X-Received: by 2002:a05:6102:548e:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7cc36b18a4dmr682392137.33.1792222357568;
        Sat, 17 Oct 2026 00:32:37 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990835c2180sm3379305241.3.2026.10.17.00.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 00:32:37 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: [PATCH v2 1/4] repository: add repo_try_hold_locked_index()
Date: Sat, 17 Oct 2026 00:32:28 -0700
Message-ID: <20261017073231.3357477-2-quark.zju@gmail.com>
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

Refactoring to make the next commit easier to reason about.

repo_hold_locked_index() has 2 categories of users:
1. Lock is required, or fail - they might want to wait for the lock,
   with the intention to not fail.
2. Lock is optional, won't fail if lock cannot be obtained - they
   don't need to wait for the lock.

Migrate the 2nd category, identified by repo_update_index_if_able(),
to a separate repo_try_hold_locked_index() to clarify intention.
For now, the two functions are the same. The next commit changes
repo_hold_locked_index().

Alternative approach considered: a LOCK_NO_RETRY flag could express
this, but hold_lock_file_for_update_timeout() already takes
timeout_ms, so the flag would duplicate or conflict with it.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jun Wu <quark@meta.com>
---
 builtin/commit.c   | 2 +-
 builtin/describe.c | 4 ++--
 builtin/diff.c     | 2 +-
 builtin/merge.c    | 2 +-
 builtin/rebase.c   | 2 +-
 repository.c       | 9 +++++++++
 repository.h       | 7 +++++++
 sequencer.c        | 2 +-
 wt-status.c        | 2 +-
 9 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 840b6b4083..a808c0ba39 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1632,7 +1632,7 @@ struct repository *repo UNUSED)
 		      &s.pathspec, NULL, NULL);
 
 	if (use_optional_locks())
-		fd = repo_hold_locked_index(the_repository, &index_lock, 0);
+		fd = repo_try_hold_locked_index(the_repository, &index_lock, 0);
 	else
 		fd = -1;
 
diff --git a/builtin/describe.c b/builtin/describe.c
index c0abc931a5..f28030e970 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -764,8 +764,8 @@ int cmd_describe(int argc,
 			repo_read_index(the_repository);
 			refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
-			fd = repo_hold_locked_index(the_repository,
-						    &index_lock, 0);
+			fd = repo_try_hold_locked_index(the_repository,
+							&index_lock, 0);
 			if (0 <= fd)
 				repo_update_index_if_able(the_repository, &index_lock);
 
diff --git a/builtin/diff.c b/builtin/diff.c
index 18b1083e98..c6c6de629a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -239,7 +239,7 @@ static void refresh_index_quietly(void)
 	struct lock_file lock_file = LOCK_INIT;
 	int fd;
 
-	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
+	fd = repo_try_hold_locked_index(the_repository, &lock_file, 0);
 	if (fd < 0)
 		return;
 	discard_index(the_repository->index);
diff --git a/builtin/merge.c b/builtin/merge.c
index 5b4eb23a83..1e9ede5bb5 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -347,7 +347,7 @@ static int save_state(struct object_id *stash)
 	int fd;
 	int rc = -1;
 
-	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
+	fd = repo_try_hold_locked_index(the_repository, &lock_file, 0);
 	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		repo_update_index_if_able(the_repository, &lock_file);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 535db60181..6df9e5b058 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1371,7 +1371,7 @@ int cmd_rebase(int argc,
 		if (repo_get_oid(the_repository, "HEAD", &head))
 			die(_("Cannot read HEAD"));
 
-		fd = repo_hold_locked_index(the_repository, &lock_file, 0);
+		fd = repo_try_hold_locked_index(the_repository, &lock_file, 0);
 		if (repo_read_index(the_repository) < 0)
 			die(_("could not read index"));
 		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL,
diff --git a/repository.c b/repository.c
index b857e1c580..a74b1118cb 100644
--- a/repository.c
+++ b/repository.c
@@ -477,3 +477,12 @@ int repo_hold_locked_index(struct repository *repo,
 		BUG("the repo hasn't been setup");
 	return repo_hold_lock_file_for_update(repo, lf, repo->index_file, flags);
 }
+
+int repo_try_hold_locked_index(struct repository *repo,
+			       struct lock_file *lf,
+			       int flags)
+{
+	if (!repo->index_file)
+		BUG("the repo hasn't been setup");
+	return repo_hold_lock_file_for_update(repo, lf, repo->index_file, flags);
+}
diff --git a/repository.h b/repository.h
index 11f5c2ed10..253a5f1d3f 100644
--- a/repository.h
+++ b/repository.h
@@ -288,6 +288,13 @@ int repo_hold_locked_index(struct repository *repo,
 			   struct lock_file *lf,
 			   int flags);
 
+/*
+ * Try to obtain the index lock in a non-blocking way.
+ */
+int repo_try_hold_locked_index(struct repository *repo,
+			       struct lock_file *lf,
+			       int flags);
+
 int repo_read_index_unmerged(struct repository *);
 /*
  * Opportunistically update the index but do not complain if we can't.
diff --git a/sequencer.c b/sequencer.c
index efbfd1315b..889807ba45 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4772,7 +4772,7 @@ static void create_autostash_internal(struct repository *r,
 	if (path && refname)
 		BUG("can only pass path or refname");
 
-	fd = repo_hold_locked_index(r, &lock_file, 0);
+	fd = repo_try_hold_locked_index(r, &lock_file, 0);
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		repo_update_index_if_able(r, &lock_file);
diff --git a/wt-status.c b/wt-status.c
index 57772c7501..0b19161de8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2791,7 +2791,7 @@ int require_clean_work_tree(struct repository *r,
 	struct lock_file lock_file = LOCK_INIT;
 	int err = 0, fd;
 
-	fd = repo_hold_locked_index(r, &lock_file, 0);
+	fd = repo_try_hold_locked_index(r, &lock_file, 0);
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		repo_update_index_if_able(r, &lock_file);
-- 
2.56.0

