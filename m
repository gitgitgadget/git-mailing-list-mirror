Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7047CA73
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251520; cv=none; b=j4tWUyW9J4ngQdi7yEa4W92sAm3BDqipmnOHb2p30VKNYBi68wDAnZC7SModipkQDLpVRPLlwGrzcRTT38gla3KJjOg2r7gkCd330aZvbs3VRAYWlUUhLVtKYm+5cjst8MsH25wrUPZOnpT84d1Y/d87Vn93vIcqcOR3NyjFaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251520; c=relaxed/simple;
	bh=KoZWrNefNDrSXNijjRy5CbvhR4k86sklkVAQDNmYwjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bro0UrmjW8ryNJDYAVp/+0nwtsNvqCwAmA+VwlTz27tXYiM27N6XBV457kP0bPmoCgxExBTcw9wLxSAGk2uytLFPjOscBrIREoUbFjGjibSam2IFu0moTbKORR/7isztVaxgtrG8IhAGG1EUyEKIS8IXfWDS34b/Vl6TFGp/pVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdSzQ9PX; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdSzQ9PX"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so2027522eec.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790251518; x=1790856318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MG8lAAnOlxAYTJOnlAPnjJgbiU1TeO+P+Qm0IvAuqPk=;
        b=PdSzQ9PXAzzcJ3ZgLlX+vVZ9lp39jzkIhPinKNrjqVv8ThZGKH9Gzc+VmhRz80FjHw
         iyvlTgcidWDUSycCXZXjqlwtFBYmDDGZMulj2Ff6f6a0DxB4KPF8JhfxzBDN75kIlD80
         oGH2hwxDTjkZ+S8nizxoPIxutIFDV8hI1ETsNu0K1ggEncN8RD/NdgO19RhEpj5aOPtS
         eOlUujIF8P5wkfIZpDyIc8EpGmZ49m50BbSiEBDR0vy+r79KEFM2DGT1/EdfIlsCQEFy
         XZxxW5AImcwmvpXE8KPuqYVm4kchsVS7MlCb/PlTlhEAEHBpDNnZ3ihjVOkEu6okzIDq
         lTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790251518; x=1790856318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MG8lAAnOlxAYTJOnlAPnjJgbiU1TeO+P+Qm0IvAuqPk=;
        b=bEysl8+RvF8YnejXY+zNobd4u/wgs0JijGTusiYeDya+YLhDZkLCrkBSG+83kIbd3N
         M15O3Ss8gliyBSubrFXhfNvr0KHR7F+TI8R6HNSFs+aNpzhbTrxgRbz3i0DJqrIyNoZd
         U0wz8r6BGE7kg9AoYkuhEjJlVhEvnumwxRrwrsPhSEhy0H3pheXUR9Gn1V+9bawhkyAr
         O64zgQ92YypDHFLKlZZYZdPCzvXyYjvMsICdl/spbY5GV2YgVJDW9tujr2dyYctLJE90
         P4lt7muQ9k6z6r9Byynt4cwTcXX9O5z4+mH+HiEnEN9F78hUeb3la8EX+wBQSKDVOii6
         kNTg==
X-Gm-Message-State: AFuF++nye4zun9q79e46q7twhzSiedRnlKZeYdMVM+J//3FmSwxzSbJo
	0H8K7EWaQoBzQqNz0dHrjKHIY1m7smGKnwglVhTNxVhRk2M/Ob4ZEC8nLKgYNX3UOto=
X-Gm-Gg: AYBFou1W57+Z93Bx7jFk/oLmj+c/n8cBKd/dqu7ZNDFIrw7tPTI7r9lwoI0vKgkEPec
	KZeA68259qXNAshBg8HPa96JJ0LaLSvPwl7j8m2DQ/RdTGmwNTmP2F/h8o9APHFAm1qteoNJolf
	RABnFVt7WjM+BTPoIqwSZmAjRL9p86mwWs2/fUO4FMHmd8xJTTZC4vSyxZJSW024uZJVJ78EBQf
	rWMPZZGOd5w7fM7gSAVFRaWJErQXHNo29zmeX3nQ8L/zJ7tlCHQqFv4C4M+nBzI9znpa3EUURgh
	JtUKLg2wN6GCwkxDhalHXq43W5s81q0VQgkf9aOeuYHxO55mY74xrTWJ2++ZVPjDRdwQT18jikn
	rYEvRGGB5KukFPXsxPGoY8h6I3iAX9K8LT56PrNBQwbhmYaMFUrsYFU/WUEy+ghGX/LtSG6Jq1i
	m3eDVKCxmuRI+BG2Gmtai3ZT6qlnZVfaHPrPz/r+331+fjpeaQ9e+o4LlenSAYof7wiOTm9O/Ue
	mz83PM3JvVgzhKTjAwnnt1Bdg==
X-Received: by 2002:a05:7301:a10:b0:33c:f22:a4aa with SMTP id 5a478bee46e88-3400162077bmr1820781eec.12.1790251517454;
        Thu, 24 Sep 2026 05:05:17 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm14302671eec.5.2026.09.24.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:05:16 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC PATCH 2/3] setup: introduce new helper 'is_git_directory_verbose'
Date: Thu, 24 Sep 2026 17:32:20 +0530
Message-ID: <20260924120502.2642141-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
In-Reply-To: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
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
 setup.c | 152 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 112 insertions(+), 40 deletions(-)

diff --git a/setup.c b/setup.c
index 0d157ac254..b3b53a1cfc 100644
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
@@ -356,14 +356,32 @@ static int validate_headref(const char *path)
 	int fd;
 	ssize_t len;
 
-	if (lstat(path, &st) < 0)
+	if (lstat(path, &st) < 0) {
+		if (err)
+			strbuf_addf(
+				err, _("could not stat HEAD at '%s'"), path
+			);
 		return -1;
+	}
 
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
 		len = readlink(path, buffer, sizeof(buffer)-1);
 		if (len >= 5 && !memcmp("refs/", buffer, 5))
 			return 0;
+		if (len == -1 && err)
+			strbuf_addf(
+				err,
+				_("could not read the symlink HEAD at '%s'"),
+				path
+			);
+		else if (err)
+			strbuf_addf(
+				err,
+				_("HEAD is a symlink ('%s') but target"
+				  " lives outside refs/"),
+				path
+			);
 		return -1;
 	}
 
@@ -371,13 +389,23 @@ static int validate_headref(const char *path)
 	 * Anything else, just open it and try to see if it is a symbolic ref.
 	 */
 	fd = open(path, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		if (err)
+			strbuf_addf(
+				err, _("could not open HEAD at '%s'"), path
+			);
 		return -1;
+	}
 	len = read_in_full(fd, buffer, sizeof(buffer)-1);
 	close(fd);
 
-	if (len < 0)
+	if (len < 0) {
+		if (err)
+			strbuf_addf(
+				err, _("could not read HEAD at '%s'"), path
+			);
 		return -1;
+	}
 	buffer[len] = '\0';
 
 	/*
@@ -396,9 +424,88 @@ static int validate_headref(const char *path)
 	if (get_oid_hex_any(buffer, &oid) != GIT_HASH_UNKNOWN)
 		return 0;
 
+	if (err)
+		strbuf_addf(
+			err,
+			_("HEAD at '%s' does not point to a valid"
+			  " symbolic link or an object ID"),
+			path
+		);
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
+				strbuf_addf(
+					err,
+					_("cannot access object directory '%s'"
+					  " set via $%s\n"),
+				objdir,
+				DB_ENVIRONMENT
+			);
+			goto done;
+		}
+	}
+	else {
+		strbuf_setlen(&path, len);
+		strbuf_addstr(&path, "/objects");
+		if (access(path.buf, X_OK)) {
+			if (err)
+				strbuf_addf(
+					err,
+					_("cannot access object directory '%s'"),
+					path.buf
+				);
+			goto done;
+		}
+	}
+
+	strbuf_setlen(&path, len);
+	strbuf_addstr(&path, "/refs");
+	if (access(path.buf, X_OK)) {
+		if (err)
+			strbuf_addf(
+				err,
+				_("cannot access refs directory '%s'"),
+				path.buf
+			);
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
@@ -412,42 +519,7 @@ static int validate_headref(const char *path)
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

