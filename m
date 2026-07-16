Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7331716D
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195789; cv=none; b=H5TGo8jMEQRyhBPYFjlKkEUbvhrXl0KDVwhyuGCt2wRGAXbwPBAWx5BFmBv/kWn09xc9iGDe+7P1UWmCqAogVXbUOIaCb40+5S24iGIOoyPFr5+yoDWTzWLCbvHJFeICqiXEGBkv7ilogH9T9Tm8NFfxjmsYgcOcRA6QEPRu6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195789; c=relaxed/simple;
	bh=t6wPY0aLwjDlIUeiP9yTG9jc6mZ2lqbfcXJi0R8EsS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Aj3qVunlo+6pFyL/4IEFRlciLCkifbDUTsXdqc+lUHmc3k1sSu+sJ9mZ6Gvdbd2r0jDtEGzhBlg8daXFTFgTwCQbaGU5WJFdBBdGkKOXagvVmYg781oF2h/sXUFZQad5WTCEZHv/yd/6avDdn8YT2AKyoUn7UOVRDwnad/daMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W5yOm7Yt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJ+dNpHD; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W5yOm7Yt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJ+dNpHD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECB397A015B
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:56:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 05:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1784195785; x=1784282185; bh=gUtryXMQsO
	f654FC0S8Y8m7X6uC3/hB01DMpp3NzCA0=; b=W5yOm7YtJ1FaJriywgrI0EGDN+
	dqe0iXDnFajZ6HjaFHOfotYDGfPVtmkjyzkRrne3Vh9OYqXDbqB8pspBUMXuVGra
	S3hr1l3opSugWtvOSanjnqNGBxE1NX/rMnstU+t6G+Dz+2t17CTpR86MCdGATrI4
	c6e6FrJDYtKrQf30Vrf4ldFxfwVo1ReVYSgJqLxv7dFygT2EyIYUtB/CWg0iVo/5
	0M7/ER2WnJmfeDz/hdmGZXbOb40Zyznx3VNTvjza4wLZKtKAWoqReLo2zdBnG9HV
	zT7NSLw0yN4FPYpgVx1952wvZGa2XJpQO/XeGaV/4BSrM3OoLkkgOHSr1E4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784195785; x=1784282185; bh=gUtryXMQsOf654FC0S8Y8m7X6uC3
	/hB01DMpp3NzCA0=; b=RJ+dNpHD1Br6n+JSbbHRoVl7wf4xK6ONqzzgTWngMR+q
	RzDghlDpv023uiIzx9WS1yuIw8v1Q0J7MRjpuF/zmThfh+C9ioZ6tKhChBIzTbIu
	C4y9t8U4sFEHK6qQ7mbumsbouNIYu0fVLHeQDlSjkMlmeIVv0EpNWkO63WCUN0Zb
	A4x3nDSPaJYoy2eoPs7nuZ0d0bhtRpZzcW2CDTTPbYZGVxkiPViiRsRfGHy2YLkQ
	KTvByn4yVvtn4osxaoHke7AQqBM86Wtv3/lodr8+DjEv0ZyDAXFLT06Jz2UnRdN5
	GHVG3EVwsDGNiY8gV/qcmOI0ks7wyYCjhmdusfxcYQ==
X-ME-Sender: <xms:yapYag7IOkSu7D_c_2Dl6Juoz3uWaZDVs9lt_pBGrbDny_htWpDcpg>
    <xme:yapYao3WSxRmcWBE5nKtMVOGHIqrtNw9KCmp3zlQatHehhjqIkloKNBU_22OlXYws
    KXJct8iRVyG3100U_YNITTtIVIQJr53--6iHOEluXkLspmb4JAhpsc>
X-ME-Received: <xmr:yapYalFzK1N5FQlypWW6PNjtuJigG2Q20FynT6n4KwbTAlZTNDa98us-5sG06PxMagEuFhlMYA64_zgtkvI9S12jqZE1rJhXRoswOqDc>
X-ME-Proxy-Cause: dmFkZTEaxeqDCxnjnSs/ETk5r/3SMLHPoylPthb3JUZpbk4llJQVXhWqNdlcn45MVnlOkV
    MpXtKH8opo1aMX1WFGouHa3fha7wnk8+sXzxIFciBxTpRacpiUHtKj7wmdGfyBVv8RWqsp
    cLG3tDefF59mXGZ2SN4ASoNs4v89i8tVknAITL7inAv4tQ+DBnxIcspHdyodYbMhOZ9ORe
    mLURy+9zd/u9rPoMZjSzy4R/j6SrBwOCLe/ronpbS0gsc+lFgXyHR05gtqbT64Q10hE4y0
    iOuvM6gWq1g7SR8ITqJn7mEhlY4Bev+Q4aPNWoiRkyW3FkM6AZPFbjqv4mn1C6WhG+3sCf
    iE9u/b1QLq+64LFLGcF6gBA24uAeBsHRQ5jAI37/goGNQelKwkmM7HqHemkFvybNcVaAmK
    MmJ0mq3cs56wc66YvXm0Ip3EOracqq/VRObLBDyTXVUrEDrbakbQnI7uixVts8P3DIXZEq
    bl+icgNJ46MAPbayKV9hPe/6EGQ1qwddkIWbDQyUjkuFk2tp1RstSmGeyTRfE2SDKhS6rP
    yzstzYpoio7z2fE5dVjjVagYfFcZxAHeHOx+tQIK1dMzndUyzhZVcB2SL7C3rH84JIgfui
    RlfwQ+AwDiqv7jpjDAafYgrTqSC+bY8zxcGH0QgGCDnSPfJKuU/1JcEJiORQ
X-ME-Proxy: <xmx:yapYaqRgPGgwannvzhembEGogjVM-CoFjDzH6TizYF7jR9jMFOvFLA>
    <xmx:yapYakBz3ZB9pLuQqaoUOWS5adhoSVlQn9ooV-MZ-svbx5NyQuqJ_Q>
    <xmx:yapYai1_gCS-s9zzX2fpQ21n-ZgYLaZgS9CXBHvHtPYHJzjcN4-_-Q>
    <xmx:yapYaqWdc09H0o0TXMnt8HCLkHE0VW_hReR1Jryz2XOQrhz2Befj8A>
    <xmx:yapYahYhWpwJ7NarSmn3Dg3b3Xi4nxibM9M_SjwzuCWMk41C-_2hAGoe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jul 2026 05:56:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef51ae48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jul 2026 09:56:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 11:56:13 +0200
Subject: [PATCH] copy: drop dependency on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-copy-wo-the-repository-v1-1-8f1e078bb82f@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMOwrDMAwA0KsEzRXYGRzoVUoHR1YTtRAbyf2Ek
 LvXbca3vA2MVdjg3G2g/BKTvDT4Uwc0x2VilNQMveuDG3zA8jCkXFZ8Z6wzo3LJJjXrijE6T5R
 GTkOAFhTlm3z++eV62J7jnan+Rtj3L7da1aR+AAAA
X-Change-ID: 20260716-pks-copy-wo-the-repository-aa01ccdbed76
To: git@vger.kernel.org
Cc: 
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
index 1355a99a09..c9ede9c02d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2419,7 +2419,7 @@ static int do_pick_commit(struct repository *r,
 		} else {
 			const char *dest = git_path_squash_msg(r);
 			unlink(dest);
-			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
+			if (copy_file(the_repository, dest, rebase_path_squash_msg(), 0666)) {
 				res = error(_("could not copy '%s' to '%s'"),
 					    rebase_path_squash_msg(), dest);
 				goto leave;
@@ -3864,11 +3864,11 @@ static int error_failed_squash(struct repository *r,
 			       int subject_len,
 			       const char *subject)
 {
-	if (copy_file(rebase_path_message(), rebase_path_squash_msg(), 0666))
+	if (copy_file(the_repository, rebase_path_message(), rebase_path_squash_msg(), 0666))
 		return error(_("could not copy '%s' to '%s'"),
 			rebase_path_squash_msg(), rebase_path_message());
 	unlink(git_path_merge_msg(r));
-	if (copy_file(git_path_merge_msg(r), rebase_path_message(), 0666))
+	if (copy_file(the_repository, git_path_merge_msg(r), rebase_path_message(), 0666))
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

