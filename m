Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1297332EC8
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439658; cv=none; b=EPaIYJQ90pLzQ4VWGGnwLsJJdQRh5Dla1ajXhFlpw2Xb3y6pfoQd9t+ClZ7pPh16SS5eTgbym/90znxtQqWu7z0UiN26bQMZh/ti01o+Fnp0bTACkmU/CYCdGRLyFtzvEqGDh3SWnA+nBgHbv0x2b1zjeTPIQ6pIpc1QsUpbkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439658; c=relaxed/simple;
	bh=OmVXC4TTq0hAKxBMwRWMo/hdAqRkH6tlzQsGDe512Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql3t6KByFvzVWT/cPW1cYfoKcmCSdIvZ/ejIQn8KSRaRwuGL40BivNy4suIf8KasnKP8nEMqyeZf8XT0JneFTtHMY9qUytNIsuzID8CiOC9ngUJPnGxH+gCmBCJ/wLNti6v6Z2NEVHTwTmEkCtnCJS8bmH4ho5+/6/UPk4IXKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP8AzwRP; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP8AzwRP"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5a837375so30644085a.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790439654; x=1791044454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O5HHDNV8PcvWtXu7z8J+5TmmraUQCkXYKrKeXiWKxdg=;
        b=HP8AzwRPqehWeAxWp+f4zaOw6Gj1FeHsc8xpMMig6rZnYZxuxF4290/D9SjEE4mnnH
         NtNCMLliKJid7OqWlp6J4ZWWsvquMF9pPbB77Kd1V+sDZBORSKHPqObpdLnBVirJKc82
         rJ89AexTtvkw51K+2nQrOjJ5NXlIU9CUpZKaCoZvC6FZ9x5z8ZNKZoKCqrORSIOz/Zx/
         d3xrP7dvBioOsSbEBfdq3zFu3XZPqy7ifynyytQszmvSa7tz7C63GX0UfUCyVxa0wmAd
         /ZNiDHX8ZfE13NT37j6q0VDdKkoXxvdtU/12VWyMvBovGc4dEGJGF+w/sd5+cw7DfGGI
         O6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790439654; x=1791044454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O5HHDNV8PcvWtXu7z8J+5TmmraUQCkXYKrKeXiWKxdg=;
        b=u4Cn9PK/TySI/RSb2utijcHDFZI7wj+sDkgse5jJ0vvYS/f4hUzbQurgH0dP7Ir843
         zK7VhAHo60JNy+X3skwezZnM3NIlVGvQR0ix3RQzM2oL4IUPemadRV/K5muwaOUGCj3U
         MfBFBk4khynLKjTxcwJmKBNFs0ZtF2ZQINJogUC9ILTwSlS0UrRjf3SVsixjAPZtNwIp
         OG/3yzSXlewcKEVGs+Y8c9xs7wEqGjItXYeFSJ3n3/kBpHYng5AB19ZhCgTmHdn9unJi
         8nQ55sfusER3QyaQhppd/FRRjw0ZBKfGEciYPqXRgzVIaRAJOE3VL7um3GStcEBgrREC
         R4nQ==
X-Gm-Message-State: AFuF++lK0hfYzhlYvrKYtVU2NL6MkzC4a/AYbrqUsdppp50lkZyMpUlN
	A9bl+c4RJ7MzbOluEN3rPZStJ+/h+t17FcksLFyDQyWX6vzXOWsB4KsjlD1ggqmP98RN1A==
X-Gm-Gg: AYBFou1pMWZEzI7fL17AG2+HajNQ7pxv4UNhQsOY5RW6lfwgOXGU4G9QHEVylIAkSKM
	QmYpzn7hehCURRasgPr+frZyZ+Ry+7XtmjvUyXPArnZTuxw3vpom7AbjLM6rLIe9c7EecbVMpxO
	wxcZJSn/VYghxlIUDgxDj+Z4qMeuTFwAbwo64ulupF6XG/q90CjdzvJsIdSJBvzu1xy6ogcrx4w
	ZBswz0sH/0NeIdD4hoBpe4d1HX1XmLaqNBsXY8xotciSJ7GwtHdxDkX234LB4cKj0MqycD0fZb7
	LIrx5+zxnwS0lpTTNbQVH6gk6/0zvXbci8KAqbQ21t/uzRzmvVCqjOF91dlh9/Lcak+18bymOIf
	Mcx8UME5M7kMA/pteFeDmp/XSe6PpX0CF2wdA1zWa/rKiiBKKGeoGBPF7i4NTSV277BwqO/WbM3
	YHMiKL1w5nNoNgTP9mc/JCKA75apfYK5r0RKcHrygjBpFoQe0pq8UVJwo6BC4CiJTeTdGlbNs4o
	jIO+RZSfml6hniuoU+FWqJng/oSMOCrOqx/dMtGgKy3bLzsrtQZ1wKJZ8D4P3nCOqIxgAPnVpjg
	G7fzfaKN1k3cTlpiG1bnavlOE1hk43us0m4b3McaAH1aEVsrnJ4l5kLWnwO/KFk=
X-Received: by 2002:a05:620a:3726:b0:939:bb9c:e43a with SMTP id af79cd13be357-93c43bf1134mr1062279085a.3.1790439653543;
        Sat, 26 Sep 2026 09:20:53 -0700 (PDT)
Received: from localhost.localdomain ([2603:7002:a00:5733:58df:3319:3c13:321f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c448ae8ecsm440919985a.9.2026.09.26.09.20.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:20:53 -0700 (PDT)
From: Andrew Pleeter <andrewpleeter@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	ben.knoble@gmail.com,
	peff@peff.net,
	sandals@crustytoothpaste.net
Subject: [PATCH v9 4/4] var: add broken-out identity variables
Date: Sat, 26 Sep 2026 12:20:48 -0400
Message-ID: <20260926162048.30853-5-andrewpleeter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqq33va1lcg.fsf@gitster.g>
References: <xmqq33va1lcg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A script that wants only the author's name has to ask for
GIT_AUTHOR_IDENT and take the result apart itself, which means
reimplementing the rules split_ident_line() already knows, and getting
them subtly wrong for names that contain an e-mail address or other
awkward characters.

Add GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE, together
with their GIT_COMMITTER_* counterparts, which give the individual
pieces of the corresponding *_IDENT variable.  They are derived from
the same ident string, so they are strict in the same way: asking for
one of them fails if the identity cannot be determined.

Signed-off-by: Andrew Pleeter <andrewpleeter@gmail.com>
---
 Documentation/git-var.adoc | 36 +++++++++++++--
 builtin/var.c              | 90 ++++++++++++++++++++++++++++++++++++++
 t/t0007-git-var.sh         | 56 ++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index d0772d9743..6982228f97 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -43,17 +43,45 @@ OPTIONS
 
 EXAMPLES
 --------
-	$ git var GIT_AUTHOR_IDENT
-	Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
+* Get the author identity:
++
+------------
+$ git var GIT_AUTHOR_IDENT
+Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
+------------
+
+* Get the author name and email:
++
+------------
+$ git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+GIT_AUTHOR_NAME=Eric W. Biederman
+GIT_AUTHOR_EMAIL=ebiederm@lnxi.com
+------------
 
 
 VARIABLES
 ---------
 `GIT_AUTHOR_IDENT`::
-    The author of a piece of code.
+`GIT_AUTHOR_NAME`::
+`GIT_AUTHOR_EMAIL`::
+`GIT_AUTHOR_DATE`::
+    The authorship information that would be recorded in the
+    resulting commit object if you ran `git commit` right now.
+    `GIT_AUTHOR_IDENT` consists of the author's name, e-mail
+    address, and timestamp+timezone. These three pieces of
+    information are available separately as `GIT_AUTHOR_NAME`,
+    `GIT_AUTHOR_EMAIL`, and `GIT_AUTHOR_DATE`.
 
 `GIT_COMMITTER_IDENT`::
-    The person who put a piece of code into Git.
+`GIT_COMMITTER_NAME`::
+`GIT_COMMITTER_EMAIL`::
+`GIT_COMMITTER_DATE`::
+    The committer information that would be recorded in the
+    resulting commit object if you ran `git commit` right now.
+    `GIT_COMMITTER_IDENT` consists of the committer's name, e-mail
+    address, and timestamp+timezone. These three pieces of
+    information are available separately as `GIT_COMMITTER_NAME`,
+    `GIT_COMMITTER_EMAIL`, and `GIT_COMMITTER_DATE`.
 
 `GIT_EDITOR`::
     Text editor for use by Git commands.  The value is meant to be
diff --git a/builtin/var.c b/builtin/var.c
index 5fbebc62e2..dd4325e5b5 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -27,16 +27,82 @@ static const char * const var_usage[] = {
 	NULL
 };
 
+enum ident_part {
+	IDENT_NAME,
+	IDENT_MAIL,
+	IDENT_DATE,
+};
+
+static char *ident_part(const char *ident, enum ident_part part)
+{
+	struct ident_split split;
+
+	if (!ident)
+		return NULL;
+	if (split_ident_line(&split, ident, strlen(ident)))
+		return NULL;
+
+	switch (part) {
+	case IDENT_NAME:
+		if (!split.name_begin || !split.name_end)
+			BUG("split_ident_line() gave NULL names???");
+		return xmemdupz(split.name_begin,
+				split.name_end - split.name_begin);
+	case IDENT_MAIL:
+		if (!split.mail_begin || !split.mail_end)
+			BUG("split_ident_line() gave NULL mail???");
+		return xmemdupz(split.mail_begin,
+				split.mail_end - split.mail_begin);
+	case IDENT_DATE:
+		if (!split.date_begin || !split.tz_end)
+			BUG("split_ident_line() gave NULL date/tz???");
+		return xmemdupz(split.date_begin,
+				split.tz_end - split.date_begin);
+	default:
+		BUG("unknown ident_part %d", part);
+	}
+}
+
 static char *committer(int ident_flag)
 {
 	return xstrdup_or_null(git_committer_info(ident_flag));
 }
 
+static char *committer_name(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_NAME);
+}
+
+static char *committer_email(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_MAIL);
+}
+
+static char *committer_date(int ident_flag)
+{
+	return ident_part(git_committer_info(ident_flag), IDENT_DATE);
+}
+
 static char *author(int ident_flag)
 {
 	return xstrdup_or_null(git_author_info(ident_flag));
 }
 
+static char *author_name(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_NAME);
+}
+
+static char *author_email(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_MAIL);
+}
+
+static char *author_date(int ident_flag)
+{
+	return ident_part(git_author_info(ident_flag), IDENT_DATE);
+}
+
 static char *editor(int ident_flag UNUSED)
 {
 	return xstrdup_or_null(git_editor());
@@ -123,10 +189,34 @@ static struct git_var git_vars[] = {
 		.name = "GIT_COMMITTER_IDENT",
 		.read = committer,
 	},
+	{
+		.name = "GIT_COMMITTER_NAME",
+		.read = committer_name,
+	},
+	{
+		.name = "GIT_COMMITTER_EMAIL",
+		.read = committer_email,
+	},
+	{
+		.name = "GIT_COMMITTER_DATE",
+		.read = committer_date,
+	},
 	{
 		.name = "GIT_AUTHOR_IDENT",
 		.read = author,
 	},
+	{
+		.name = "GIT_AUTHOR_NAME",
+		.read = author_name,
+	},
+	{
+		.name = "GIT_AUTHOR_EMAIL",
+		.read = author_email,
+	},
+	{
+		.name = "GIT_AUTHOR_DATE",
+		.read = author_date,
+	},
 	{
 		.name = "GIT_EDITOR",
 		.read = editor,
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 593610300a..e43becff1c 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -373,4 +373,60 @@ test_expect_success 'unknown variable is a usage error' '
 	test_grep usage err
 '
 
+test_expect_success 'get author identity components' '
+	test_tick &&
+	echo "$GIT_AUTHOR_NAME" >expect.name &&
+	echo "$GIT_AUTHOR_EMAIL" >expect.email &&
+	echo "$GIT_AUTHOR_DATE" >expect.date &&
+	git var GIT_AUTHOR_NAME >actual.name &&
+	git var GIT_AUTHOR_EMAIL >actual.email &&
+	git var GIT_AUTHOR_DATE >actual.date &&
+	test_cmp expect.name actual.name &&
+	test_cmp expect.email actual.email &&
+	test_cmp expect.date actual.date
+'
+
+test_expect_success 'get committer identity components' '
+	test_tick &&
+	echo "$GIT_COMMITTER_NAME" >expect.name &&
+	echo "$GIT_COMMITTER_EMAIL" >expect.email &&
+	echo "$GIT_COMMITTER_DATE" >expect.date &&
+	git var GIT_COMMITTER_NAME >actual.name &&
+	git var GIT_COMMITTER_EMAIL >actual.email &&
+	git var GIT_COMMITTER_DATE >actual.date &&
+	test_cmp expect.name actual.name &&
+	test_cmp expect.email actual.email &&
+	test_cmp expect.date actual.date
+'
+
+test_expect_success !FAIL_PREREQS,!AUTOIDENT 'identity components are strict' '
+	(
+		sane_unset GIT_COMMITTER_NAME &&
+		sane_unset GIT_COMMITTER_EMAIL &&
+		test_must_fail git var GIT_COMMITTER_NAME
+	)
+'
+
+test_expect_success 'get several identity components at once' '
+	test_tick &&
+	cat >expect <<-EOF &&
+	GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME
+	GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL
+	GIT_COMMITTER_NAME=$GIT_COMMITTER_NAME
+	GIT_COMMITTER_EMAIL=$GIT_COMMITTER_EMAIL
+	EOF
+	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git var -l lists the identity components' '
+	git var -l >actual &&
+	test_grep "^GIT_AUTHOR_NAME=" actual &&
+	test_grep "^GIT_AUTHOR_EMAIL=" actual &&
+	test_grep "^GIT_AUTHOR_DATE=" actual &&
+	test_grep "^GIT_COMMITTER_NAME=" actual &&
+	test_grep "^GIT_COMMITTER_EMAIL=" actual &&
+	test_grep "^GIT_COMMITTER_DATE=" actual
+'
+
 test_done
-- 
2.54.0 (Apple Git-157)

