Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0B50E58B
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677534; cv=none; b=MM9u2ZmdIf3HtNLZ/tLoQVwGRLwtrUc3A0UVyfz7z2JyeGd7CuXhAz7iS8av4yzPrjuLphERnMsbgWFBE8jltaP95/333hFZtJisEsJLPoAN5Uq1HrTDk8dBiFKnERLiWfnylZeRBHNRtfYyjJuv7JmnUWIoL/0iouweQQmvoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677534; c=relaxed/simple;
	bh=KwlAnjPYK85BSyoGP2wnOJjV9hprg0/PfFGlcTrAkEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7qRuG9BDvlygwjy+qFXtVtPRlhockxS8bodl+n1jqDyIIYk9XLVXC7cliqg5rwR8jhvinF03x2T72OAInIMCFXJC8nPmOQZjxbCkpp8OExL3X6JLCgqZZ8cKzvpp8f2k9/k6jHes0PmKnoxn3cprKa7C/e3nnbFd1K9E61C4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFWewqJX; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFWewqJX"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-1438cb9b3a3so2720940c88.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790677525; x=1791282325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JaPO2JD6MgtggBvFlHKLsZK9Oj6ABQMU0UFbV4H2PVc=;
        b=FFWewqJXDE0frApGTaGKj8gwhaGSeuXZPZX/fRv16PK0oaCVB7oNulZVWnpmMhqXx6
         /HzSB8CsiCV0ovvILlm+vaj6FTrNp8NhYWcveUJdqkqPfVQyaw9I/BmfVRiFTj2umla+
         GQvEPmm56WsZ7hjCs35SvB1CpeSA3rUM6f3pwAFZmWZPODqfD0kYIEAbdpF6+zx+QEtH
         b4i2g7oKsp77RkGHUgHrr4jcROQIO27HJMww23jETBR8tihWXcpJmhzN14fz7hagO3tf
         zhyvkCC9CJ99u/YffroyJ0WTHl/lPwcR6CZtnC3WBKbQ3VbZXHKGeKcfXl1jVxIWFWEW
         5+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677525; x=1791282325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JaPO2JD6MgtggBvFlHKLsZK9Oj6ABQMU0UFbV4H2PVc=;
        b=yMd9338mmQfZaLRJPBzflbYevzTG0Btn9LGzVpRmsLOr4Smq5uI21nRl/eHHBFmvkf
         WQ8QNlVeYGe0jWqMH8MDzlqWIspYDRLoxBn+J+XB4c91c4c/48nUxYOP/JTUKa4Ibj/4
         mPIhLH5Pa12GYDZayEWanrFU5M+28QnmHtwZvZOvgGZrFlsF3sRSp4GDsT0/zFaqHO9I
         1M3ePH5e3+x+9lrwBoyy0vLBUDEzY3uHgVSjldQSupfyxmXZwDePt/El96aBcr9cHuQo
         cOTWsrVuMrs0y5ARem6gOqEouv0A6W3EyCjY7kRGehJ8E040bS/Ux0H+UI+Pq77PhbVy
         Z/8g==
X-Gm-Message-State: AFuF++kauRScpE2vxjPRF7eRPCkhqjraxwB72ytQp7ToXLMSoaklOSsT
	Act2GFR2bTRn/GBBg1Yeoq8Je32ZweGWOUmCsW8ycIGyXa+720FqKGgSi6Z5Kw==
X-Gm-Gg: AYBFou2Y73Wnysg8AkDBsmeHuH4YmlXoI/WgxWHnaYiDZwSHoBoKLT+JdfzGcbBNf7y
	8vJzf9svLVxofG6PTrJZPPnWbrRY657bvKwR97aWTxXYvxzGkc7yF9YU14KHrMVw0wEDqQuBJQ6
	XvwyRwmEUs/u16KuD2vUq/HYqx23IxjxCrIfimuJwTsicjesyBf2khUZXyOtjiculZMdsLfdwBf
	n3RN95raWJXLTq0Z4V/OYzXbzK4tV6MiWbsg8iFH9xe9it3YawAoDI3uTWGlZdALL13NwWcLND/
	hc5gi4Xx82B1b+busxmqJ63rLWpNasO5J/wZDEufgu3ZrbUpPXsgSrF3jDENVQlOTQBAHSqtZ6G
	bAmuxXjPKhDPaG/+XCv2XHgk8SxVRYDwC2Bk42X7mGunQCq4HS6cmYUBTkFrXmI0xxBNl2I4F8s
	6TjY/GiH5A/EfS7D+yLOwCNolzRq/iI0+02Fw8pOwYkgFDJJqe6ewNMiVaja4f+VB/0vQlsRB5F
	iPjSstLKwtzlH/NWgrGEPZWysslj03cDrUBv1K4
X-Received: by 2002:a05:701b:2310:b0:149:cad3:302b with SMTP id a92af1059eb24-149cad33531mr5815963c88.34.1790677524799;
        Tue, 29 Sep 2026 03:25:24 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2401:4900:884c:d167:a737:cb55:b3cc:523e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm30417589c88.7.2026.09.29.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:25:24 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 3/4] setup: introduce new helper 'is_git_directory_verbose'
Date: Tue, 29 Sep 2026 15:55:09 +0530
Message-ID: <20260929102513.712181-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
In-Reply-To: <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new helper is_git_directory_verbose() as a
counterpart to the existing is_git_directory().

is_git_directory_verbose() also populates an optional
string strbuf with reasoning around why the given suspect
is not a valid git directory. This strbuf in turn can be
used to improve the error reporting which is currently blunt:

  fatal: not a git repository

This is not helpful as the user does not get any hint about "why"
the repository is not considered valid.

Call-site(s) will be made to use this helper in a follow-up commit.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 setup.c | 122 +++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 40 deletions(-)

diff --git a/setup.c b/setup.c
index e9a9ecda19..a0fb68f7f6 100644
--- a/setup.c
+++ b/setup.c
@@ -347,7 +347,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 	return ret;
 }
 
-static int validate_headref(const char *path)
+static int validate_headref(const char *path, struct strbuf *err)
 {
 	struct stat st;
 	char buffer[256];
@@ -356,14 +356,23 @@ static int validate_headref(const char *path)
 	int fd;
 	ssize_t len;
 
-	if (lstat(path, &st) < 0)
+	if (lstat(path, &st) < 0) {
+		if (err)
+			strbuf_addf(err, _("could not stat HEAD at '%s'"), path);
 		return -1;
+	}
 
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
 		len = readlink(path, buffer, sizeof(buffer)-1);
 		if (len >= 5 && !memcmp("refs/", buffer, 5))
 			return 0;
+		if (len == -1 && err)
+			strbuf_addf(err, _("could not read the symlink HEAD at '%s'"),
+				    path);
+		else if (err)
+			strbuf_addf(err, _("HEAD is a symlink ('%s') but target lives"
+					   " outside refs/"), path);
 		return -1;
 	}
 
@@ -371,13 +380,19 @@ static int validate_headref(const char *path)
 	 * Anything else, just open it and try to see if it is a symbolic ref.
 	 */
 	fd = open(path, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		if (err)
+			strbuf_addf(err, _("could not open HEAD at '%s'"), path);
 		return -1;
+	}
 	len = read_in_full(fd, buffer, sizeof(buffer)-1);
 	close(fd);
 
-	if (len < 0)
+	if (len < 0) {
+		if (err)
+			strbuf_addf(err, _("could not read HEAD at '%s'"), path);
 		return -1;
+	}
 	buffer[len] = '\0';
 
 	/*
@@ -396,9 +411,71 @@ static int validate_headref(const char *path)
 	if (get_oid_hex_any(buffer, &oid) != GIT_HASH_UNKNOWN)
 		return 0;
 
+	if (err)
+		strbuf_addf(err, _("HEAD at '%s' does not point to a valid symbolic"
+				   " link or an object ID"), path);
+
 	return -1;
 }
 
+/*
+ * A variant of is_git_directory that gives additional
+ * context via 'err' about why a given suspect is not
+ * a valid git repository.
+ */
+static int is_git_directory_verbose(const char *suspect, struct strbuf *err)
+{
+	struct strbuf path = STRBUF_INIT;
+	char *objdir;
+	int ret = 0;
+	size_t len;
+
+	/* Check worktree-related signatures */
+	strbuf_addstr(&path, suspect);
+	strbuf_complete(&path, '/');
+	strbuf_addstr(&path, "HEAD");
+	if (validate_headref(path.buf, err))
+		goto done;
+
+	strbuf_reset(&path);
+	get_common_dir(&path, suspect);
+	len = path.len;
+
+	/* Check non-worktree-related signatures */
+	objdir = getenv(DB_ENVIRONMENT);
+	if (objdir) {
+		if (access(objdir, X_OK)) {
+			if (err)
+				strbuf_addf(err, _("cannot access object directory '%s'"
+						   " set via $%s\n"), objdir, DB_ENVIRONMENT);
+			goto done;
+		}
+	} else {
+		strbuf_setlen(&path, len);
+		strbuf_addstr(&path, "/objects");
+		if (access(path.buf, X_OK)) {
+			if (err)
+				strbuf_addf(err, _("cannot access object directory '%s'"),
+					    path.buf);
+			goto done;
+		}
+	}
+
+	strbuf_setlen(&path, len);
+	strbuf_addstr(&path, "/refs");
+	if (access(path.buf, X_OK)) {
+		if (err)
+			strbuf_addf(err, _("cannot access refs directory '%s'"), path.buf);
+		goto done;
+	}
+
+	ret = 1;
+done:
+	strbuf_release(&path);
+	return ret;
+
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
@@ -412,42 +489,7 @@ static int validate_headref(const char *path)
  */
 int is_git_directory(const char *suspect)
 {
-	struct strbuf path = STRBUF_INIT;
-	int ret = 0;
-	size_t len;
-
-	/* Check worktree-related signatures */
-	strbuf_addstr(&path, suspect);
-	strbuf_complete(&path, '/');
-	strbuf_addstr(&path, "HEAD");
-	if (validate_headref(path.buf))
-		goto done;
-
-	strbuf_reset(&path);
-	get_common_dir(&path, suspect);
-	len = path.len;
-
-	/* Check non-worktree-related signatures */
-	if (getenv(DB_ENVIRONMENT)) {
-		if (access(getenv(DB_ENVIRONMENT), X_OK))
-			goto done;
-	}
-	else {
-		strbuf_setlen(&path, len);
-		strbuf_addstr(&path, "/objects");
-		if (access(path.buf, X_OK))
-			goto done;
-	}
-
-	strbuf_setlen(&path, len);
-	strbuf_addstr(&path, "/refs");
-	if (access(path.buf, X_OK))
-		goto done;
-
-	ret = 1;
-done:
-	strbuf_release(&path);
-	return ret;
+	return is_git_directory_verbose(suspect, NULL);
 }
 
 int is_nonbare_repository_dir(struct strbuf *path)
-- 
2.56.0.rc1.12.g2c9c8d64bb

