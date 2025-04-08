Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FA268FCB
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107860; cv=none; b=aIzCQGqhZhNgu1IS3o7n9HjBujlgCbSpyG+T92K5cWrUCOe3LZTbKaq300rvx7fiQXTpLjN/Pxni3VoXSFILF6oObs3EzQEprhbWMPM8KjZWzSRnYBksaCzTgvIkuo9QTz1RkYUy8LpFiFwjd82297e25cUEEU5rGZ8ojLeE4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107860; c=relaxed/simple;
	bh=9QSEZWNmpalTG5h0R1RyIUqGKDFcyXogNOi8gPmlsoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5h2zecNmMkI9KPSoyli2tNmnO13eQPbuddR8EqPRbHuPL/Pd1LCix3VXfgYt7/Rp91RyM6tuMAjPDZiuTJDNENoOexSDKSMJslY8WWMWbMc0ckcOjc9qCep4+nb9vzn7DYpT4l/0D2QxOMJmC4NMakXkePV4sXtKKhPuLJAR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rJuTHzoi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bRzQugGK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rJuTHzoi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bRzQugGK"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 33D1D1380140
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:24:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 08 Apr 2025 06:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744107856;
	 x=1744194256; bh=LuszaVirLVoOqFSELgrKLswbiermHa0uQlpCascoWug=; b=
	rJuTHzoie1ChIlb4KEdRIcddVHVXg0qpBZrezGdcgxcPVJJN2NYBSKT/2jm7xCtY
	U+s6ibHvcqM4c9ysGZkDYjWdI+PW1yY33sg6Q9R2DYBJa+IpTcyW7NnkhnmRHN6u
	oDakI3XoRbXOjOmu4Zhpjh1p1gZKWqlIIUapVKIFSXnI8V+jUDD6xrEC4lvlGjD8
	wvNgVLG8ee+P++JGJ62LSDR3YXZ81LT1rO7sXi5Hj70ckS2mnLmwR58NVHXvZBja
	L/NNgBt1FsUvj/uf50xGNq9jWnbTjDAglHDAdGAkyoXAD+Rv8eF9Mx9fnILOTjd1
	PWNSjJvXnO1WMt4kDDO/2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744107856; x=
	1744194256; bh=LuszaVirLVoOqFSELgrKLswbiermHa0uQlpCascoWug=; b=b
	RzQugGKL/d46XzzkJ4UeqAgWGCEI4ItviwFxt9FnlCEdn0wyHhvdufw35Jfd4tQV
	gxvz8z2GUwPPtpjKZ4gvgT9ntJH6FTQhbbtzlBItOEemMv0FVsIm8kNOVQ2p+Dq2
	i4Yq0HsmdYm6ofvFZdWWoJZRWxR7jpoM6JnzjTF6hH7a17yeDcKf+Ia3EYZLnvG/
	kVkz/XiByCAw5q7Xy+ITbKQCLNgFfbw+6dK7r5d2OJMe/YJ+iUfKZwFq06VzJ2h2
	Ce/U75EYoR4r+GANEmrUAG1uhY5kFWmuvFWGjJwUhjsORQDileLFxFi9m8+R01Y5
	vWYqS9E1/aTrOGKbaVVLw==
X-ME-Sender: <xms:T_n0Z0JpisKgoP0I87XD49LeSJN75JagepLhj_NuUaau0oFwGi0IJA>
    <xme:T_n0Z0I5Try6o5xupPbKTkq3ZQWBiUsFMDTbZD6rahPb0e3fboeq_Z7EaSOCSGpEY
    fhWMjKSbzJGjSL2Zg>
X-ME-Received: <xmr:T_n0Z0sF-HDq-5YSBW-ycjyixeivRTLjd5HJbeC8kJIAvtgDfirpgneIivvaHVgVcoYEwB3QXwRiRmuAD-3ENZb3txcSoqPt4yfcE-_xQXa-Gftppg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:T_n0ZxYPYx5FOQXp11j19OhV1ymNDdqEiEoL_DB4MMBlAC2Qx7sC3g>
    <xmx:T_n0Z7b0Rij4oZ-scCpLFeXYi0BS4AaBETL5d4qU_XvgHAzoWmoM-w>
    <xmx:T_n0Z9BRwNKEbrpIGG8XpNNgLm-6Q_BYGs4Zpo70lwpN9b2NeHdbqQ>
    <xmx:T_n0ZxZHwcOQBF-WgPjp4YjhitCeBUm4-Y5N94TPyMV137lurcZBdw>
    <xmx:UPn0Z1khUrDLbzQxeR130OaWIZbHgcT07lvOSv2u_g7Kh2xX3GJtOBX1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 8 Apr 2025 06:24:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92251c74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 8 Apr 2025 10:24:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 12:24:09 +0200
Subject: [PATCH 1/9] object-file: move `safe_create_leading_directories()`
 into "dir.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-split-object-file-v1-1-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `safe_create_leading_directories()` function and its relatives are
located in "object-file.c", which is not a good fit as they provide
generic functionality not related to objects at all. Move them into
"dir.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bugreport.c                |   2 +-
 builtin/credential-cache--daemon.c |   2 +-
 builtin/diagnose.c                 |   2 +-
 builtin/fsck.c                     |   1 +
 builtin/gc.c                       |   2 +-
 builtin/init-db.c                  |   2 +-
 builtin/log.c                      |   2 +-
 commit-graph.c                     |   1 +
 dir.c                              | 107 ++++++++++++++++++++++++++++++++++++-
 dir.h                              |  35 ++++++++++++
 midx-write.c                       |   1 +
 object-file.c                      | 106 ------------------------------------
 object-file.h                      |  35 ------------
 13 files changed, 150 insertions(+), 148 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 66d64bfd5ae..d07fa91c247 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
+#include "dir.h"
 #include "editor.h"
 #include "gettext.h"
 #include "parse-options.h"
@@ -10,7 +11,6 @@
 #include "hook.h"
 #include "hook-list.h"
 #include "diagnose.h"
-#include "object-file.h"
 #include "setup.h"
 #include "version.h"
 
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index e707618e743..80d29b4f5c0 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -1,8 +1,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
+#include "dir.h"
 #include "gettext.h"
-#include "object-file.h"
 #include "parse-options.h"
 
 #ifndef NO_UNIX_SOCKETS
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 33c39bd5981..d5dadd6a48b 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -2,8 +2,8 @@
 
 #include "builtin.h"
 #include "abspath.h"
+#include "dir.h"
 #include "gettext.h"
-#include "object-file.h"
 #include "parse-options.h"
 #include "diagnose.h"
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9c8a6d6a8df..32d40d8f9fc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,6 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "dir.h"
 #include "gettext.h"
 #include "hex.h"
 #include "config.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 99431fd4674..b069629676c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -16,6 +16,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "date.h"
+#include "dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "config.h"
@@ -28,7 +29,6 @@
 #include "commit.h"
 #include "commit-graph.h"
 #include "packfile.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "pack.h"
 #include "pack-objects.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 196dccdd77a..39730c1b0ce 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -6,9 +6,9 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-file.h"
 #include "parse-options.h"
 #include "path.h"
 #include "refs.h"
diff --git a/builtin/log.c b/builtin/log.c
index 0d4c579dad7..06ffaa93e86 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -10,11 +10,11 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
-#include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "pager.h"
diff --git a/commit-graph.c b/commit-graph.c
index 8286d5dda24..3fae20dc21b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "csum-file.h"
+#include "dir.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/dir.c b/dir.c
index 28b0e03feb4..16ae3b5169d 100644
--- a/dir.c
+++ b/dir.c
@@ -17,7 +17,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "path.h"
 #include "refs.h"
@@ -4132,3 +4131,109 @@ int path_match_flags(const char *const str, const enum path_match_flags flags)
 		return is_xplatform_dir_sep(*p);
 	BUG("unreachable");
 }
+
+int mkdir_in_gitdir(const char *path)
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
+	return adjust_shared_perm(the_repository, path);
+}
+
+static enum scld_error safe_create_leading_directories_1(char *path, int share)
+{
+	char *next_component = path + offset_1st_component(path);
+	enum scld_error ret = SCLD_OK;
+
+	while (ret == SCLD_OK && next_component) {
+		struct stat st;
+		char *slash = next_component, slash_character;
+
+		while (*slash && !is_dir_sep(*slash))
+			slash++;
+
+		if (!*slash)
+			break;
+
+		next_component = slash + 1;
+		while (is_dir_sep(*next_component))
+			next_component++;
+		if (!*next_component)
+			break;
+
+		slash_character = *slash;
+		*slash = '\0';
+		if (!stat(path, &st)) {
+			/* path exists */
+			if (!S_ISDIR(st.st_mode)) {
+				errno = ENOTDIR;
+				ret = SCLD_EXISTS;
+			}
+		} else if (mkdir(path, 0777)) {
+			if (errno == EEXIST &&
+			    !stat(path, &st) && S_ISDIR(st.st_mode))
+				; /* somebody created it since we checked */
+			else if (errno == ENOENT)
+				/*
+				 * Either mkdir() failed because
+				 * somebody just pruned the containing
+				 * directory, or stat() failed because
+				 * the file that was in our way was
+				 * just removed.  Either way, inform
+				 * the caller that it might be worth
+				 * trying again:
+				 */
+				ret = SCLD_VANISHED;
+			else
+				ret = SCLD_FAILED;
+		} else if (share && adjust_shared_perm(the_repository, path)) {
+			ret = SCLD_PERMS;
+		}
+		*slash = slash_character;
+	}
+	return ret;
+}
+
+enum scld_error safe_create_leading_directories(char *path)
+{
+	return safe_create_leading_directories_1(path, 1);
+}
+
+enum scld_error safe_create_leading_directories_no_share(char *path)
+{
+	return safe_create_leading_directories_1(path, 0);
+}
+
+enum scld_error safe_create_leading_directories_const(const char *path)
+{
+	int save_errno;
+	/* path points to cache entries, so xstrdup before messing with it */
+	char *buf = xstrdup(path);
+	enum scld_error result = safe_create_leading_directories(buf);
+
+	save_errno = errno;
+	free(buf);
+	errno = save_errno;
+	return result;
+}
diff --git a/dir.h b/dir.h
index d7e71aa8daa..02c1f9420b0 100644
--- a/dir.h
+++ b/dir.h
@@ -676,4 +676,39 @@ static inline int starts_with_dot_dot_slash_native(const char *const path)
 	return path_match_flags(path, what | PATH_MATCH_NATIVE);
 }
 
+/*
+ * Create the directory containing the named path, using care to be
+ * somewhat safe against races. Return one of the scld_error values to
+ * indicate success/failure. On error, set errno to describe the
+ * problem.
+ *
+ * SCLD_VANISHED indicates that one of the ancestor directories of the
+ * path existed at one point during the function call and then
+ * suddenly vanished, probably because another process pruned the
+ * directory while we were working.  To be robust against this kind of
+ * race, callers might want to try invoking the function again when it
+ * returns SCLD_VANISHED.
+ *
+ * safe_create_leading_directories() temporarily changes path while it
+ * is working but restores it before returning.
+ * safe_create_leading_directories_const() doesn't modify path, even
+ * temporarily. Both these variants adjust the permissions of the
+ * created directories to honor core.sharedRepository, so they are best
+ * suited for files inside the git dir. For working tree files, use
+ * safe_create_leading_directories_no_share() instead, as it ignores
+ * the core.sharedRepository setting.
+ */
+enum scld_error {
+	SCLD_OK = 0,
+	SCLD_FAILED = -1,
+	SCLD_PERMS = -2,
+	SCLD_EXISTS = -3,
+	SCLD_VANISHED = -4
+};
+enum scld_error safe_create_leading_directories(char *path);
+enum scld_error safe_create_leading_directories_const(const char *path);
+enum scld_error safe_create_leading_directories_no_share(char *path);
+
+int mkdir_in_gitdir(const char *path);
+
 #endif
diff --git a/midx-write.c b/midx-write.c
index a628ac24dcb..e01a867c583 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
+#include "dir.h"
 #include "hex.h"
 #include "lockfile.h"
 #include "packfile.h"
diff --git a/object-file.c b/object-file.c
index 772c311f188..23b2c8560be 100644
--- a/object-file.c
+++ b/object-file.c
@@ -91,112 +91,6 @@ static int get_conv_flags(unsigned flags)
 }
 
 
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
-static enum scld_error safe_create_leading_directories_1(char *path, int share)
-{
-	char *next_component = path + offset_1st_component(path);
-	enum scld_error ret = SCLD_OK;
-
-	while (ret == SCLD_OK && next_component) {
-		struct stat st;
-		char *slash = next_component, slash_character;
-
-		while (*slash && !is_dir_sep(*slash))
-			slash++;
-
-		if (!*slash)
-			break;
-
-		next_component = slash + 1;
-		while (is_dir_sep(*next_component))
-			next_component++;
-		if (!*next_component)
-			break;
-
-		slash_character = *slash;
-		*slash = '\0';
-		if (!stat(path, &st)) {
-			/* path exists */
-			if (!S_ISDIR(st.st_mode)) {
-				errno = ENOTDIR;
-				ret = SCLD_EXISTS;
-			}
-		} else if (mkdir(path, 0777)) {
-			if (errno == EEXIST &&
-			    !stat(path, &st) && S_ISDIR(st.st_mode))
-				; /* somebody created it since we checked */
-			else if (errno == ENOENT)
-				/*
-				 * Either mkdir() failed because
-				 * somebody just pruned the containing
-				 * directory, or stat() failed because
-				 * the file that was in our way was
-				 * just removed.  Either way, inform
-				 * the caller that it might be worth
-				 * trying again:
-				 */
-				ret = SCLD_VANISHED;
-			else
-				ret = SCLD_FAILED;
-		} else if (share && adjust_shared_perm(the_repository, path)) {
-			ret = SCLD_PERMS;
-		}
-		*slash = slash_character;
-	}
-	return ret;
-}
-
-enum scld_error safe_create_leading_directories(char *path)
-{
-	return safe_create_leading_directories_1(path, 1);
-}
-
-enum scld_error safe_create_leading_directories_no_share(char *path)
-{
-	return safe_create_leading_directories_1(path, 0);
-}
-
-enum scld_error safe_create_leading_directories_const(const char *path)
-{
-	int save_errno;
-	/* path points to cache entries, so xstrdup before messing with it */
-	char *buf = xstrdup(path);
-	enum scld_error result = safe_create_leading_directories(buf);
-
-	save_errno = errno;
-	free(buf);
-	errno = save_errno;
-	return result;
-}
-
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
diff --git a/object-file.h b/object-file.h
index 81b30d269c8..922f2bba8c9 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,41 +21,6 @@ extern int fetch_if_missing;
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-/*
- * Create the directory containing the named path, using care to be
- * somewhat safe against races. Return one of the scld_error values to
- * indicate success/failure. On error, set errno to describe the
- * problem.
- *
- * SCLD_VANISHED indicates that one of the ancestor directories of the
- * path existed at one point during the function call and then
- * suddenly vanished, probably because another process pruned the
- * directory while we were working.  To be robust against this kind of
- * race, callers might want to try invoking the function again when it
- * returns SCLD_VANISHED.
- *
- * safe_create_leading_directories() temporarily changes path while it
- * is working but restores it before returning.
- * safe_create_leading_directories_const() doesn't modify path, even
- * temporarily. Both these variants adjust the permissions of the
- * created directories to honor core.sharedRepository, so they are best
- * suited for files inside the git dir. For working tree files, use
- * safe_create_leading_directories_no_share() instead, as it ignores
- * the core.sharedRepository setting.
- */
-enum scld_error {
-	SCLD_OK = 0,
-	SCLD_FAILED = -1,
-	SCLD_PERMS = -2,
-	SCLD_EXISTS = -3,
-	SCLD_VANISHED = -4
-};
-enum scld_error safe_create_leading_directories(char *path);
-enum scld_error safe_create_leading_directories_const(const char *path);
-enum scld_error safe_create_leading_directories_no_share(char *path);
-
-int mkdir_in_gitdir(const char *path);
-
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
 

-- 
2.49.0.682.gc9b6a7b2b0.dirty

