Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FB325724
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538663; cv=none; b=dx9+7iVQhyCChCmprsUu2JJW7mjvH+O9Prhos8CRK5xPe+badyIEP4kekDAVqJW7BNfigICRQpOA59G36buqJ4wK3Vw8yOcZTMd5t5kSXzftiDlgxcW3ZeIEDK/xRUYl1G+TL6WKG0mLM0FR7g96P4PhZIGCpIYIeTg16+rqCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538663; c=relaxed/simple;
	bh=ScS2WlU1skaXuQUnOJmH12X23DOCapN8TAdunGnIbv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZgkTj6I39H1psf13DYvJ3RwM9H2tAa7CWJrumliaeS949XQN2smKESgKJHqR5BfqJPUX2EIH5RwsQmhDDAZB4MH3jgwlNnaLVNrXDmE/P7OJPmGX+7gpFzT7mF+Bnvb98pFgixFlxsOGPTTVcvER8TZHUlqYIxB8kK9sNuFm8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JIOv2xdl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s1jud5DL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JIOv2xdl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1jud5DL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F670140021D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 02:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538661;
	 x=1763625061; bh=zIoCk9CPXJJ7/qPjj6/BdltWIiEzjoWS6SyGXZsYl5I=; b=
	JIOv2xdlyfyk7ceneLkFYpw6+yVflb8sfZLirzM3UKT8QAMM75wImmJ3FctidQSH
	gInkajZBvv/4H5mqcp5K7Rs1+73FAYc6riu38WKY2nQR+XSMJwi56PAXRI5kxsO8
	rIsV1fbaWpJDZyM3DbG6V6XmoVkdWm4g73nU/tnyTy+kiHKDg2WJeqqnwiZWqbvP
	jfmRxxn7fcpYrP1HnQBDrekq3wzC2HlUTMvA09n5OjdgSrsSllx8B+H4D4E+AUtO
	dgKpjt18OKInqlgFAAZkUWu5ZgCLiTiOGhpSPDVphXmImSX8YIcM7GWWlVaHwOUo
	tDxE2njKNzY5ZZnngfH2KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538661; x=
	1763625061; bh=zIoCk9CPXJJ7/qPjj6/BdltWIiEzjoWS6SyGXZsYl5I=; b=s
	1jud5DLg0TTz/MEtgWAFO3vN3mZISj5BspnrbXqtgBpu8frxBKXqdBZX7lHSM5BB
	vXbdxWby9NuqUb5kAZ3PpQi3TtpfMSlqvDp22RPkswurCnbk4YbEAvAUimfChw4H
	6e7Gjvj+O3qTQ+7o0ubHcXQUnt+7QBkiB8UEe7pIFijUW31o9KNJLVydi4R5lR5t
	3gXuJGS+rTO9Agv02s9NOwRBgLeZFnY0/0Z63HK1OdJ+8zem22XJrKK+0+DXDxX1
	4uDTjV2xe/r2SljwlvGl4Xdlkoxwko5EOQoWTTmVFaFIg6wU8lTzIxMG4F5YJlp1
	JB/biKXuj2nG6TvHbnlGA==
X-ME-Sender: <xms:5XYdaVS8ervhTt-mPtFzgFaCEwFgaBkBeq0xp8uZdMEcHwM0-DWMbQ>
    <xme:5XYdaVu8hTQ_a_y6eNei5crj8rjKUmoAznsugF_C6miljtoFlOeT4Bafag8P5Amt2
    C7rlWOLAg2CtHVKT56cx6S0bRp2O6-Mp-cjlckXIXSOdlNzDHZS>
X-ME-Received: <xmr:5XYdaQdgMY40GnezGM_jJ8nprf0sYT13TQ8YAzUBmcyQUHd0TpaSTEiTppKmG9ik5sTQJDbrCsdziZtacgBUiZb98I7pxevvXKZ1P9O7hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:5XYdaSKuNehHqLmmG8J2QHCdHq5rE9q08SscLTVkwdNuCjy7_k3vBQ>
    <xmx:5XYdaealyr0p9l5zx0jRHskssSbApJfKkpGPmcU2yW2_lwGuSQTqBQ>
    <xmx:5XYdadszCAYvlT87NgIZWaTbRvDzEjyHpAZXMVCSf8eMAiWI__cLlA>
    <xmx:5XYdabvf97agoF7zx9cSSncdEj9M5E4ePLgqVLyd_KSIoVaen8CZGA>
    <xmx:5XYdaRTKWWrbnu7kPhtjolvDt9LUufBNeoyS_r0H2ACvCIVpRf3vVj-E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebf25672 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:49 +0100
Subject: [PATCH 01/13] path: move `enter_repo()` into "setup.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-1-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `enter_repo()` is used to enter a repository at a given
path. As such it sits way closer to setting up a repository than it does
with handling paths, but regardless of that it's located in "path.c"
instead of in "setup.c".

Move the function into "setup.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c   |   2 +-
 builtin/upload-archive.c |   2 +-
 builtin/upload-pack.c    |   2 +-
 http-backend.c           |   1 +
 path.c                   | 100 -----------------------------------------------
 path.h                   |  15 -------
 setup.c                  |  81 ++++++++++++++++++++++++++++++++++++++
 setup.h                  |  38 ++++++++++++++++++
 8 files changed, 123 insertions(+), 118 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c9288a9c7e..79a0fd4756 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -34,7 +34,6 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
-#include "path.h"
 #include "protocol.h"
 #include "commit-reach.h"
 #include "server-info.h"
@@ -42,6 +41,7 @@
 #include "trace2.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "setup.h"
 #include "parse-options.h"
 
 static const char * const receive_pack_usage[] = {
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 97d7c9522f..25312bb2a5 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -4,8 +4,8 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
-#include "path.h"
 #include "pkt-line.h"
+#include "setup.h"
 #include "sideband.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index c2bbc035ab..30498fafea 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -5,11 +5,11 @@
 #include "gettext.h"
 #include "pkt-line.h"
 #include "parse-options.h"
-#include "path.h"
 #include "protocol.h"
 #include "replace-object.h"
 #include "upload-pack.h"
 #include "serve.h"
+#include "setup.h"
 #include "commit.h"
 #include "environment.h"
 
diff --git a/http-backend.c b/http-backend.c
index 52f0483dd3..e9d1ef92bd 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -16,6 +16,7 @@
 #include "run-command.h"
 #include "string-list.h"
 #include "url.h"
+#include "setup.h"
 #include "strvec.h"
 #include "packfile.h"
 #include "odb.h"
diff --git a/path.c b/path.c
index 7f56eaf993..d726537622 100644
--- a/path.c
+++ b/path.c
@@ -738,106 +738,6 @@ char *interpolate_path(const char *path, int real_home)
 	return NULL;
 }
 
-/*
- * First, one directory to try is determined by the following algorithm.
- *
- * (0) If "strict" is given, the path is used as given and no DWIM is
- *     done. Otherwise:
- * (1) "~/path" to mean path under the running user's home directory;
- * (2) "~user/path" to mean path under named user's home directory;
- * (3) "relative/path" to mean cwd relative directory; or
- * (4) "/absolute/path" to mean absolute directory.
- *
- * Unless "strict" is given, we check "%s/.git", "%s", "%s.git/.git", "%s.git"
- * in this order. We select the first one that is a valid git repository, and
- * chdir() to it. If none match, or we fail to chdir, we return NULL.
- *
- * If all goes well, we return the directory we used to chdir() (but
- * before ~user is expanded), avoiding getcwd() resolving symbolic
- * links.  User relative paths are also returned as they are given,
- * except DWIM suffixing.
- */
-const char *enter_repo(const char *path, unsigned flags)
-{
-	static struct strbuf validated_path = STRBUF_INIT;
-	static struct strbuf used_path = STRBUF_INIT;
-
-	if (!path)
-		return NULL;
-
-	if (!(flags & ENTER_REPO_STRICT)) {
-		static const char *suffix[] = {
-			"/.git", "", ".git/.git", ".git", NULL,
-		};
-		const char *gitfile;
-		int len = strlen(path);
-		int i;
-		while ((1 < len) && (path[len-1] == '/'))
-			len--;
-
-		/*
-		 * We can handle arbitrary-sized buffers, but this remains as a
-		 * sanity check on untrusted input.
-		 */
-		if (PATH_MAX <= len)
-			return NULL;
-
-		strbuf_reset(&used_path);
-		strbuf_reset(&validated_path);
-		strbuf_add(&used_path, path, len);
-		strbuf_add(&validated_path, path, len);
-
-		if (used_path.buf[0] == '~') {
-			char *newpath = interpolate_path(used_path.buf, 0);
-			if (!newpath)
-				return NULL;
-			strbuf_attach(&used_path, newpath, strlen(newpath),
-				      strlen(newpath));
-		}
-		for (i = 0; suffix[i]; i++) {
-			struct stat st;
-			size_t baselen = used_path.len;
-			strbuf_addstr(&used_path, suffix[i]);
-			if (!stat(used_path.buf, &st) &&
-			    (S_ISREG(st.st_mode) ||
-			    (S_ISDIR(st.st_mode) && is_git_directory(used_path.buf)))) {
-				strbuf_addstr(&validated_path, suffix[i]);
-				break;
-			}
-			strbuf_setlen(&used_path, baselen);
-		}
-		if (!suffix[i])
-			return NULL;
-		gitfile = read_gitfile(used_path.buf);
-		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
-			die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
-		if (gitfile) {
-			strbuf_reset(&used_path);
-			strbuf_addstr(&used_path, gitfile);
-		}
-		if (chdir(used_path.buf))
-			return NULL;
-		path = validated_path.buf;
-	}
-	else {
-		const char *gitfile = read_gitfile(path);
-		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
-			die_upon_dubious_ownership(gitfile, NULL, path);
-		if (gitfile)
-			path = gitfile;
-		if (chdir(path))
-			return NULL;
-	}
-
-	if (is_git_directory(".")) {
-		set_git_dir(".", 0);
-		check_repository_format(NULL);
-		return path;
-	}
-
-	return NULL;
-}
-
 int calc_shared_perm(struct repository *repo,
 		     int mode)
 {
diff --git a/path.h b/path.h
index e67348f253..0ec95a0b07 100644
--- a/path.h
+++ b/path.h
@@ -146,21 +146,6 @@ int adjust_shared_perm(struct repository *repo, const char *path);
 
 char *interpolate_path(const char *path, int real_home);
 
-/* The bits are as follows:
- *
- * - ENTER_REPO_STRICT: callers that require exact paths (as opposed
- *   to allowing known suffixes like ".git", ".git/.git" to be
- *   omitted) can set this bit.
- *
- * - ENTER_REPO_ANY_OWNER_OK: callers that are willing to run without
- *   ownership check can set this bit.
- */
-enum {
-	ENTER_REPO_STRICT = (1<<0),
-	ENTER_REPO_ANY_OWNER_OK = (1<<1),
-};
-
-const char *enter_repo(const char *path, unsigned flags);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
diff --git a/setup.c b/setup.c
index 7086741e6c..98c6fd8ee4 100644
--- a/setup.c
+++ b/setup.c
@@ -1703,6 +1703,87 @@ void set_git_dir(const char *path, int make_realpath)
 	strbuf_release(&realpath);
 }
 
+const char *enter_repo(const char *path, unsigned flags)
+{
+	static struct strbuf validated_path = STRBUF_INIT;
+	static struct strbuf used_path = STRBUF_INIT;
+
+	if (!path)
+		return NULL;
+
+	if (!(flags & ENTER_REPO_STRICT)) {
+		static const char *suffix[] = {
+			"/.git", "", ".git/.git", ".git", NULL,
+		};
+		const char *gitfile;
+		int len = strlen(path);
+		int i;
+		while ((1 < len) && (path[len-1] == '/'))
+			len--;
+
+		/*
+		 * We can handle arbitrary-sized buffers, but this remains as a
+		 * sanity check on untrusted input.
+		 */
+		if (PATH_MAX <= len)
+			return NULL;
+
+		strbuf_reset(&used_path);
+		strbuf_reset(&validated_path);
+		strbuf_add(&used_path, path, len);
+		strbuf_add(&validated_path, path, len);
+
+		if (used_path.buf[0] == '~') {
+			char *newpath = interpolate_path(used_path.buf, 0);
+			if (!newpath)
+				return NULL;
+			strbuf_attach(&used_path, newpath, strlen(newpath),
+				      strlen(newpath));
+		}
+		for (i = 0; suffix[i]; i++) {
+			struct stat st;
+			size_t baselen = used_path.len;
+			strbuf_addstr(&used_path, suffix[i]);
+			if (!stat(used_path.buf, &st) &&
+			    (S_ISREG(st.st_mode) ||
+			    (S_ISDIR(st.st_mode) && is_git_directory(used_path.buf)))) {
+				strbuf_addstr(&validated_path, suffix[i]);
+				break;
+			}
+			strbuf_setlen(&used_path, baselen);
+		}
+		if (!suffix[i])
+			return NULL;
+		gitfile = read_gitfile(used_path.buf);
+		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
+			die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
+		if (gitfile) {
+			strbuf_reset(&used_path);
+			strbuf_addstr(&used_path, gitfile);
+		}
+		if (chdir(used_path.buf))
+			return NULL;
+		path = validated_path.buf;
+	}
+	else {
+		const char *gitfile = read_gitfile(path);
+		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
+			die_upon_dubious_ownership(gitfile, NULL, path);
+		if (gitfile)
+			path = gitfile;
+		if (chdir(path))
+			return NULL;
+	}
+
+	if (is_git_directory(".")) {
+		set_git_dir(".", 0);
+		check_repository_format(NULL);
+		return path;
+	}
+
+	return NULL;
+}
+
 static int git_work_tree_initialized;
 
 /*
diff --git a/setup.h b/setup.h
index 8522fa8575..bfea199bcd 100644
--- a/setup.h
+++ b/setup.h
@@ -97,6 +97,44 @@ static inline int discover_git_directory(struct strbuf *commondir,
 void set_git_dir(const char *path, int make_realpath);
 void set_git_work_tree(const char *tree);
 
+/* Flags that can be passed to `enter_repo()`. */
+enum {
+	/*
+	 * Callers that require exact paths (as opposed to allowing known
+	 * suffixes like ".git", ".git/.git" to be omitted) can set this bit.
+	 */
+	ENTER_REPO_STRICT = (1<<0),
+
+	/*
+	 * Callers that are willing to run without ownership check can set this
+	 * bit.
+	 */
+	ENTER_REPO_ANY_OWNER_OK = (1<<1),
+};
+
+/*
+ * Discover and enter a repository.
+ *
+ * First, one directory to try is determined by the following algorithm.
+ *
+ * (0) If "strict" is given, the path is used as given and no DWIM is
+ *     done. Otherwise:
+ * (1) "~/path" to mean path under the running user's home directory;
+ * (2) "~user/path" to mean path under named user's home directory;
+ * (3) "relative/path" to mean cwd relative directory; or
+ * (4) "/absolute/path" to mean absolute directory.
+ *
+ * Unless "strict" is given, we check "%s/.git", "%s", "%s.git/.git", "%s.git"
+ * in this order. We select the first one that is a valid git repository, and
+ * chdir() to it. If none match, or we fail to chdir, we return NULL.
+ *
+ * If all goes well, we return the directory we used to chdir() (but
+ * before ~user is expanded), avoiding getcwd() resolving symbolic
+ * links.  User relative paths are also returned as they are given,
+ * except DWIM suffixing.
+ */
+const char *enter_repo(const char *path, unsigned flags);
+
 const char *setup_git_directory_gently(int *);
 const char *setup_git_directory(void);
 char *prefix_path(const char *prefix, int len, const char *path);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

