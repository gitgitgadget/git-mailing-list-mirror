Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50327E1D5
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709905; cv=none; b=dhNoEhlLjyGq5klQfNonPgyzFs9T8MmxmmaqwCnAQsYLRvRTpGy5QduyteEbB64MaZ8AF9UYFd4AHTRUwaqZv0ErDosQocrzcAzQVIFwtlHTng0oeGOCkqJh+q6+qbk7BdvJ44PyuuXwkuNI8hKW8/uCsoO4hxBupuNkT9bAFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709905; c=relaxed/simple;
	bh=ZFgn30OYZuaMNNWhb1hFCFn84Pr+YQUOmQBCJcV14lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dwTZ2tgs2H3uVgOBInyTguAH/D508R6J9ht4aQ8IEkP3W+2BOOZWLhR9Bhjm6vqBK1xe8Z8G8FJnaYWnNsIyS4ecWL85fQhBNATqrHU+n/UJCkxPNlLuw7JzRIcp3rA8CQkqkj67lSuR8umgnkpzgujj81f+N/V8Pc9vlt9tVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TJnRG0JN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SCB6szKe; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TJnRG0JN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SCB6szKe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5AC7E114018F;
	Tue, 15 Apr 2025 05:38:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 05:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709902;
	 x=1744796302; bh=rwiPGq1ijPHf4XmOSO2g5OR1aXT+A9pi9n1TB3n31UI=; b=
	TJnRG0JNgrJUauQ6aCX/oKDKHFRZdbAQzW0yhl0WILcPrXkl5xAxzocnB0BS/TMp
	o1VhUQn6e9WxtbRAiLmkLHPNUYPd20sKYUEC4bHN1hobfb0yRmBgePpZU2kS4sT3
	7oeGAPbx2uPRNOok9K9fA7450J/im1nA3pNiZ8haNIvi9dpkb1qXzbYniq+KI0lX
	9SfNsAx6LGS6tRQx7AlRICrpGFUPBnhAkCwTWwo/9negXhNRUm2tHlRuNrjHvjrS
	GyN3IEpJ8ioz7t7T8Kjw+NgY7LtDWk3ytY2kDQjmTn82YW5q8+bueaRdlLt/Q98B
	HTxCN6eGfDx2HCYGnnbVQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709902; x=
	1744796302; bh=rwiPGq1ijPHf4XmOSO2g5OR1aXT+A9pi9n1TB3n31UI=; b=S
	CB6szKe6j/yNKl5W1Odk8U0IGLks7ChF+goVUNXQt9t0yKfgoE1v5Uu+1wK1YWgy
	kN9Z+Ie8t8yAgMU9oVDjGeoS/r22l3lNZEfFtPcff5S2Ymyrs7HBU7MqGkb8KKnz
	Cby1ChIan2eIg0JUCZZZ6fs0l+ZMB0QOdPs0frSCuFQ5//umkVFNPN0Y2R45qOB/
	A+0P7gOVkRerNNzIsSg0wkksnoXZOXI+V/20kcMc2HLpFpxaU0RJ5L7Ihz/m7ljd
	Jvtcq5taLDaxsZHuFD2DS1WLg1yoZZ0CqXkopO4cUkmx+JaI5w934/4d00pXdxow
	V7JgDZuXeUsyI5kIVRtAg==
X-ME-Sender: <xms:DSn-Z3EgBU6UL_zsFSsXy6FClOJPwBegVOghzcqGr-SNYh3rKxRlQg>
    <xme:DSn-Z0VydgE66TUizB3B_F1LyVi4AA3wZv9Pq5ADNtkrinTEjQj49GAZ1yG1GvmPp
    fXckfquHxhsBEOmMg>
X-ME-Received: <xmr:DSn-Z5L9FC-9MrSwoPbJdS_2a9XQ6GrgMuC3bxopI3VAekt4fFvjWJFcYTKRd6tq-alT-H0E4VCswl-mug_Qdw0GDdJqOdMc4MKbmNkWElKmCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:DSn-Z1GPPIvzF7PQ0bAT6UxXEFg8fxkMWvmHPI4PNpMoJUnG4yJnog>
    <xmx:DSn-Z9WPe0riGZKnie-cqOspeefrpxUaJuKbQkfCvdbFtIiAwYo-Kw>
    <xmx:DSn-ZwM4GInFeypC1eLOhYFh1mHAjrqNSkcg5pHo2Pksyb94x0TfIQ>
    <xmx:DSn-Z80cBNEQQSRL47HEs4CbCzNpz8A7zLotcPcTl4m_IuMgOUzg8g>
    <xmx:Din-Z-fswskdmJNvNu1IJO6MDJrIPjr5AQjVWGKEupLBA7Vc2Ld22-7B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8641a3eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:38:14 +0200
Subject: [PATCH v3 01/10] object-file: move `mkdir_in_gitdir()` into
 "path.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-pks-split-object-file-v3-1-6aa7db7ad7b0@pks.im>
References: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `mkdir_in_gitdir()` function is similar to `safe_create_dir()`, but
the former is hosted in "object-file.c" whereas the latter is hosted in
"path.c". The latter code unit makes way more sense though as the logic
has nothing to do with object files in particular.

Move the file into "path.c". While at it, we:

  - Rename the function to `safe_create_dir_in_gitdir()` so that the
    function names are similar to one another.

  - Remove the dependency on `the_repository` by making the callers pass
    the repository instead.

Adjust callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c |  3 ++-
 object-file.c    | 33 ++-------------------------------
 object-file.h    |  2 --
 path.c           | 29 +++++++++++++++++++++++++++++
 path.h           | 11 +++++++++++
 rerere.c         |  5 +++--
 6 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1cd802dd92a..cd9371536f8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -267,7 +267,8 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 {
 	FILE *interactive;
 
-	if (!is_directory(merge_dir()) && mkdir_in_gitdir(merge_dir()))
+	if (!is_directory(merge_dir()) &&
+	    safe_create_dir_in_gitdir(the_repository, merge_dir()))
 		return error_errno(_("could not create temporary %s"), merge_dir());
 
 	refs_delete_reflog(get_main_ref_store(the_repository), "REBASE_HEAD");
diff --git a/object-file.c b/object-file.c
index 772c311f188..00451876bd0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -90,36 +90,6 @@ static int get_conv_flags(unsigned flags)
 		return 0;
 }
 
-
-int mkdir_in_gitdir(const char *path)
-{
-	if (mkdir(path, 0777)) {
-		int saved_errno = errno;
-		struct stat st;
-		struct strbuf sb = STRBUF_INIT;
-
-		if (errno != EEXIST)
-			return -1;
-		/*
-		 * Are we looking at a path in a symlinked worktree
-		 * whose original repository does not yet have it?
-		 * e.g. .git/rr-cache pointing at its original
-		 * repository in which the user hasn't performed any
-		 * conflict resolution yet?
-		 */
-		if (lstat(path, &st) || !S_ISLNK(st.st_mode) ||
-		    strbuf_readlink(&sb, path, st.st_size) ||
-		    !is_absolute_path(sb.buf) ||
-		    mkdir(sb.buf, 0777)) {
-			strbuf_release(&sb);
-			errno = saved_errno;
-			return -1;
-		}
-		strbuf_release(&sb);
-	}
-	return adjust_shared_perm(the_repository, path);
-}
-
 static enum scld_error safe_create_leading_directories_1(char *path, int share)
 {
 	char *next_component = path + offset_1st_component(path);
@@ -2196,7 +2166,8 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		struct strbuf dir = STRBUF_INIT;
 		strbuf_add(&dir, filename.buf, dirlen);
 
-		if (mkdir_in_gitdir(dir.buf) && errno != EEXIST) {
+		if (safe_create_dir_in_gitdir(the_repository, dir.buf) &&
+		    errno != EEXIST) {
 			err = error_errno(_("unable to create directory %s"), dir.buf);
 			strbuf_release(&dir);
 			goto cleanup;
diff --git a/object-file.h b/object-file.h
index 81b30d269c8..4649a3f37d4 100644
--- a/object-file.h
+++ b/object-file.h
@@ -54,8 +54,6 @@ enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
 enum scld_error safe_create_leading_directories_no_share(char *path);
 
-int mkdir_in_gitdir(const char *path);
-
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 
diff --git a/path.c b/path.c
index 910756c8b32..c688f874580 100644
--- a/path.c
+++ b/path.c
@@ -902,6 +902,35 @@ void safe_create_dir(struct repository *repo, const char *dir, int share)
 		die(_("Could not make %s writable by group"), dir);
 }
 
+int safe_create_dir_in_gitdir(struct repository *repo, const char *path)
+{
+	if (mkdir(path, 0777)) {
+		int saved_errno = errno;
+		struct stat st;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (errno != EEXIST)
+			return -1;
+		/*
+		 * Are we looking at a path in a symlinked worktree
+		 * whose original repository does not yet have it?
+		 * e.g. .git/rr-cache pointing at its original
+		 * repository in which the user hasn't performed any
+		 * conflict resolution yet?
+		 */
+		if (lstat(path, &st) || !S_ISLNK(st.st_mode) ||
+		    strbuf_readlink(&sb, path, st.st_size) ||
+		    !is_absolute_path(sb.buf) ||
+		    mkdir(sb.buf, 0777)) {
+			strbuf_release(&sb);
+			errno = saved_errno;
+			return -1;
+		}
+		strbuf_release(&sb);
+	}
+	return adjust_shared_perm(repo, path);
+}
+
 static int have_same_root(const char *path1, const char *path2)
 {
 	int is_abs1, is_abs2;
diff --git a/path.h b/path.h
index 65fe968a13a..a427516d818 100644
--- a/path.h
+++ b/path.h
@@ -221,6 +221,17 @@ char *xdg_cache_home(const char *filename);
  */
 void safe_create_dir(struct repository *repo, const char *dir, int share);
 
+/*
+ * Similar to `safe_create_dir()`, but with two differences:
+ *
+ *   - It knows to resolve gitlink files for symlinked worktrees.
+ *
+ *   - It always adjusts shared permissions.
+ *
+ * Returns a negative erorr code on error, 0 on success.
+ */
+int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
diff --git a/rerere.c b/rerere.c
index 740e8ad1a0b..0832cc54840 100644
--- a/rerere.c
+++ b/rerere.c
@@ -860,7 +860,7 @@ static int do_plain_rerere(struct repository *r,
 		string_list_insert(rr, path)->util = id;
 
 		/* Ensure that the directory exists. */
-		mkdir_in_gitdir(rerere_path(&buf, id, NULL));
+		safe_create_dir_in_gitdir(the_repository, rerere_path(&buf, id, NULL));
 	}
 
 	for (i = 0; i < rr->nr; i++)
@@ -895,7 +895,8 @@ static int is_rerere_enabled(void)
 	if (rerere_enabled < 0)
 		return rr_cache_exists;
 
-	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
+	if (!rr_cache_exists &&
+	    safe_create_dir_in_gitdir(the_repository, git_path_rr_cache()))
 		die(_("could not create directory '%s'"), git_path_rr_cache());
 	return 1;
 }

-- 
2.49.0.805.g082f7c87e0.dirty

