Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3526400DE8
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215717; cv=none; b=SwPlmofBwDyGmRPrd2UxiVXGrPhPZpXfGzl24YPnh0UtSKQGYNqbhyiWKxqB6YNJOCeCfpSjxp84wyv4FzLY1pBCb8RUklxSlnVcNOUp0L8S7qW7t1jIcxwZSHbL5r5Ymkk7cyAMH7ec4Ru5XP4UvLmQtnuWFX6NUlT+RsSQ1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215717; c=relaxed/simple;
	bh=hU94oADhph2t/WR0cxUk0D973qpI9Kirlx31P/Jr1ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=DvhOokXtlggN2q0btVsjRo16o8uULa4WTHDhyXY2d+otzp3Ge/cA+DjjnigDmj7RieEv4nRZ3GmhyV3Lk1G6SjqoOf8JVcIMelntS/WMtrJ3Hln5Zf6VcD8TeA4QXOk5W0817F0C8jVwT0Rm5vJnH0bpNoJT4pWNNSr1lWSOWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n6dWxVzZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1qIMPRY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n6dWxVzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1qIMPRY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C12BF14000E6;
	Thu, 16 Jul 2026 11:28:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 11:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784215714;
	 x=1784302114; bh=xrMlGt+D2KH6hXL/bjTrggzFeLnmVY/Wr85FRgY7UOo=; b=
	n6dWxVzZtXGmA0l49tLJxWgm/x5lq22d7PAYmvNaI93Qm7PONe/3ArkJWn5jHjMl
	SKGzy+8DdKTuRvj1J6mN3ynOPIlGrFd9On4BdX2McYZ0XLi29lJq6/cQENEIgxZF
	MFCNL5OfOEEAbb7lI7Ze1sJ1JctoYMGjlhSQyMdm92hz7l4zRZyNvLJFHs/bRpAR
	V+iEJbudW8798TBBi9HRsSmg8aWO2+MbvYdQDmktlYfCAVg4JuW6GIYy6Lpz8Xa2
	ywOZPhz90nY/bSjVWh7nU0GFeE3fBH6Zgm1MZwr49axI1pfFhOsAFt+Raborb1Vb
	htuEyfXHy/XNZmCrCK+5gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784215714; x=
	1784302114; bh=xrMlGt+D2KH6hXL/bjTrggzFeLnmVY/Wr85FRgY7UOo=; b=K
	1qIMPRYuYssHaGme09uO0Gmlsz7QgwyaBKVtP9o6hxu/JF+nmnsL7uI+RS+AFZv7
	FVEhEEV9IBX4zPRHia4gZjaTKy21gvUq558h4pFBqtKdQiOGRMixrcIqYmGGvWZs
	QfeKWJUTDkhEzXWQmUpgSX05lgNJq94radwwxeTnS/tq74yfIji6L2jWlkbAdCe7
	R6S9jvBGDwfEsFnqpaJB50qoH0PQOx6kIsdEpGaCqs0xTQoPyQbMK9yA265CMBQu
	dZckmDsz6vGvmU4/8eyGcMNMrHpsBhlgkNZQi7aRhNFvyIMJRqbrA8v4Ry43zI76
	efy+zljlzRULLK5ZyCSzQ==
X-ME-Sender: <xms:ovhYakfUf0m4mSqqAd4uP3gTZElzP3nYtyIQuD5lQ0UiENDDJiE9ug>
    <xme:ovhYakJ1c486g7V6a1K7DTLN39y4BWb1qPHxtsqQleTmerSzZSI-v05vz8XNZAd6j
    k5StgQsw4cB_p2uIvXasyqW0kz6Xjcfwh8L2dPAuDPDlreEj4BJSw>
X-ME-Received: <xmr:ovhYatG2IA4rLgM0pX2RiH-VQ3P0_9qzJrELZZZNK-CQenr8HABt_PonbO4e2JhXNXMQdgMxZeNLGbtRv_0w4k9PrXbDQZCxWU-COzUz>
X-ME-Proxy-Cause: dmFkZTFtT6NWiV7rdZzvUo3ZBiZz7Ba3/wGraprj+JdjcgvO+rKxHarAXx/jlOL5cN7Zz1
    p+IrPXlJKJW1JWvNz5f6VWpjc1yNCNMnr2TQXxaes4+A6Shz6KqDaT81YB56tjZfjBRntf
    N2J4HziJZrPj478ao/GG4iZXtf9OuDEMpqmi5kndPiMQZjAEE/4uMWcoGZK+8VBdh/BmTR
    9Vs9GqUmfTc4s9DVTb7AP0yH99lN+lY+Xa1iFeyGI8H+46FLowD5HC4/JgZpq52ie2yNVT
    +Ez5Y6tQD3xhbETJRqW/YMOqIuUoLkWvbgLch8MdFone2ERxzQt/e/ZiFRz1Xxi5FhvBhQ
    jGumuWgG/TgkfqPDS5OvW++5TUjRA9bD29DFiztx4pRIsMSkxSYN2QmgdHgevsCc0Hw8Iv
    r+RyXktGGt+iyirYEip/M/0rLuKJCWai4fXUcc7gKU57cCPHL8P00XGoJPbdaVmlVVbwr3
    ZPKpbKmvhx/+pTuCSrx8KbVQaWsjP76i3IYvxx7iq8wOSeDxCr/o7fsS69EXDhz1p3FCJQ
    DhYe8bvA8asINfAYI+0I6xKdQua8BLTaEzkZVOPhPiNQpuVEGsDlCpxEKcxIDZ1Ko04VL0
    dDl8DwMdYgLGT+cU1LL7bbfOJ3gpX84XKeDh/xSrRBrmz61Tc6RbojHJQeWQ
X-ME-Proxy: <xmx:ovhYamqIccz9n1Fog_Rxa23ba8NAYBKbGpsGCX8JUKBYp03GFL8A4A>
    <xmx:ovhYauQDM5YuAGetDIUaEpNaC9IVws_NSqzgzLwVBy8sA266xQuxzw>
    <xmx:ovhYarN3OcmaWwvJdd8egocERFLWAzc4b_R9A-tiySvSsMUcr-lIEg>
    <xmx:ovhYapPRhBb4zDUYJqw8hb-9UtXtj4zO2c2akG-qlOKIs67fpS-u9Q>
    <xmx:ovhYakgLUp-cl6bKy2G1zcfsyVr0M5PcfFCBWUR6pYDNjxrxs4WX9mEX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 11:28:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62e22799 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 15:28:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 17:28:23 +0200
Subject: [PATCH v2] copy: drop dependency on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-copy-wo-the-repository-v2-1-8f5e32942929@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7Zi2CyCuvIdhQcsgo5E2HUAJ4
 e62eAGXL3n//Q2EIpPApdgg0sLCfkxgTgW4oR3vhNwlBqNMqSpdYngKOh9WfHucBsJIwQtPPq7
 Ytko711nqqhJSIETq+XPEb82PZbYPclMuZmNgycvjfdHZ++to0aix7jWpqra2Nv01yWd+QbPv+
 xfVjn+v0wAAAA==
X-Change-ID: 20260716-pks-copy-wo-the-repository-aa01ccdbed76
In-Reply-To: <20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im>
References: <20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

When copying a file we need to potentially adapt permissions of the new
file based on whether or not "core.shared" is enabled. Parsing this
configuration makes us implicitly depend on `the_repository`.

Refactor the code to instead require the caller to pass in a repository
so that we can remove `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

I guess the title says it all: this small patch removes the dependency
on `the_repository` in "copy.c". Thanks!

Changes in v2:
  - Adapt a couple more sites to use a repository from the context.
  - Link to v1: https://patch.msgid.link/20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im

Patrick
---
 builtin/clone.c      |  2 +-
 builtin/difftool.c   |  4 ++--
 builtin/worktree.c   |  4 ++--
 bundle-uri.c         |  2 +-
 copy.c               | 12 ++++++------
 copy.h               |  8 ++++++--
 refs/files-backend.c |  2 +-
 rerere.c             |  2 +-
 sequencer.c          |  6 +++---
 setup.c              |  2 +-
 10 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d60d1b60bc..18603dd4ce 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -335,7 +335,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				die_errno(_("failed to create link '%s'"), dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file_with_time(dest->buf, src->buf, 0666))
+		if (copy_file_with_time(the_repository, dest->buf, src->buf, 0666))
 			die_errno(_("failed to copy file to '%s'"), dest->buf);
 	}
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 26778f8515..5e7777fbe4 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -552,7 +552,7 @@ static int run_dir_diff(struct repository *repo,
 					struct stat st;
 					if (stat(wtdir.buf, &st))
 						st.st_mode = 0644;
-					if (copy_file(rdir.buf, wtdir.buf,
+					if (copy_file(repo, rdir.buf, wtdir.buf,
 						      st.st_mode)) {
 						ret = error("could not copy '%s' to '%s'", wtdir.buf, rdir.buf);
 						goto finish;
@@ -658,7 +658,7 @@ static int run_dir_diff(struct repository *repo,
 				warning("%s", "");
 				err = 1;
 			} else if (unlink(wtdir.buf) ||
-				   copy_file(wtdir.buf, rdir.buf, st.st_mode))
+				   copy_file(repo, wtdir.buf, rdir.buf, st.st_mode))
 				warning_errno(_("could not copy '%s' to '%s'"),
 					      rdir.buf, wtdir.buf);
 		}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d21c43fde3..84b01960fb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -349,7 +349,7 @@ static void copy_sparse_checkout(const char *worktree_git_dir)
 
 	if (file_exists(from_file)) {
 		if (safe_create_leading_directories(the_repository, to_file) ||
-			copy_file(to_file, from_file, 0666))
+			copy_file(the_repository, to_file, from_file, 0666))
 			error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
 				from_file, to_file);
 	}
@@ -368,7 +368,7 @@ static void copy_filtered_worktree_config(const char *worktree_git_dir)
 		int bare;
 
 		if (safe_create_leading_directories(the_repository, to_file) ||
-			copy_file(to_file, from_file, 0666)) {
+			copy_file(the_repository, to_file, from_file, 0666)) {
 			error(_("failed to copy worktree config from '%s' to '%s'"),
 				from_file, to_file);
 			goto worktree_copy_cleanup;
diff --git a/bundle-uri.c b/bundle-uri.c
index 3b2e347288..ef37aebf30 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -396,7 +396,7 @@ static int copy_uri_to_file(const char *filename, const char *uri)
 		uri = out;
 
 	/* Copy as a file */
-	return copy_file(filename, uri, 0);
+	return copy_file(the_repository, filename, uri, 0);
 }
 
 static int unbundle_from_file(struct repository *r, const char *file)
diff --git a/copy.c b/copy.c
index b668209b6c..6074132050 100644
--- a/copy.c
+++ b/copy.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "copy.h"
 #include "path.h"
@@ -35,7 +33,8 @@ static int copy_times(const char *dst, const char *src)
 	return 0;
 }
 
-int copy_file(const char *dst, const char *src, int mode)
+int copy_file(struct repository *repo,
+	      const char *dst, const char *src, int mode)
 {
 	int fdi, fdo, status;
 
@@ -59,15 +58,16 @@ int copy_file(const char *dst, const char *src, int mode)
 	if (close(fdo) != 0)
 		return error_errno("%s: close error", dst);
 
-	if (!status && adjust_shared_perm(the_repository, dst))
+	if (!status && adjust_shared_perm(repo, dst))
 		return -1;
 
 	return status;
 }
 
-int copy_file_with_time(const char *dst, const char *src, int mode)
+int copy_file_with_time(struct repository *repo,
+			const char *dst, const char *src, int mode)
 {
-	int status = copy_file(dst, src, mode);
+	int status = copy_file(repo, dst, src, mode);
 	if (!status)
 		return copy_times(dst, src);
 	return status;
diff --git a/copy.h b/copy.h
index 2af77cba86..1059b118d6 100644
--- a/copy.h
+++ b/copy.h
@@ -1,10 +1,14 @@
 #ifndef COPY_H
 #define COPY_H
 
+struct repository;
+
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
 int copy_fd(int ifd, int ofd);
-int copy_file(const char *dst, const char *src, int mode);
-int copy_file_with_time(const char *dst, const char *src, int mode);
+int copy_file(struct repository *repo,
+	      const char *dst, const char *src, int mode);
+int copy_file_with_time(struct repository *repo,
+			const char *dst, const char *src, int mode);
 
 #endif /* COPY_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3df56c25c8..442c98414e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1736,7 +1736,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (copy && log && copy_file(tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
+	if (copy && log && copy_file(refs->base.repo, tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
 		ret = error("unable to copy logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
 			    oldrefname, strerror(errno));
 		goto out;
diff --git a/rerere.c b/rerere.c
index 8232542585..bf5cfc6e51 100644
--- a/rerere.c
+++ b/rerere.c
@@ -756,7 +756,7 @@ static void do_rerere_one_path(struct index_state *istate,
 	/* Has the user resolved it already? */
 	if (variant >= 0) {
 		if (!handle_file(istate, path, NULL, NULL)) {
-			copy_file(rerere_path(&buf, id, "postimage"), path, 0666);
+			copy_file(the_repository, rerere_path(&buf, id, "postimage"), path, 0666);
 			id->collection->status[variant] |= RR_HAS_POSTIMAGE;
 			fprintf_ln(stderr, _("Recorded resolution for '%s'."), path);
 			free_rerere_id(rr_item);
diff --git a/sequencer.c b/sequencer.c
index 1355a99a09..63bc1ef215 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2419,7 +2419,7 @@ static int do_pick_commit(struct repository *r,
 		} else {
 			const char *dest = git_path_squash_msg(r);
 			unlink(dest);
-			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
+			if (copy_file(r, dest, rebase_path_squash_msg(), 0666)) {
 				res = error(_("could not copy '%s' to '%s'"),
 					    rebase_path_squash_msg(), dest);
 				goto leave;
@@ -3864,11 +3864,11 @@ static int error_failed_squash(struct repository *r,
 			       int subject_len,
 			       const char *subject)
 {
-	if (copy_file(rebase_path_message(), rebase_path_squash_msg(), 0666))
+	if (copy_file(r, rebase_path_message(), rebase_path_squash_msg(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
 	unlink(git_path_merge_msg(r));
-	if (copy_file(git_path_merge_msg(r), rebase_path_message(), 0666))
+	if (copy_file(r, git_path_merge_msg(r), rebase_path_message(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
 			     rebase_path_message(),
 			     git_path_merge_msg(r));
diff --git a/setup.c b/setup.c
index 0de56a074f..91d61a5939 100644
--- a/setup.c
+++ b/setup.c
@@ -2331,7 +2331,7 @@ static void copy_templates_1(struct repository *repo,
 			strbuf_release(&lnk);
 		}
 		else if (S_ISREG(st_template.st_mode)) {
-			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
+			if (copy_file(repo, path->buf, template_path->buf, st_template.st_mode))
 				die_errno(_("cannot copy '%s' to '%s'"),
 					  template_path->buf, path->buf);
 		}

---
base-commit: d35c5399e3e54ac277bb391fc2f6be3e816d312b
change-id: 20260716-pks-copy-wo-the-repository-aa01ccdbed76

