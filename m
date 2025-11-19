Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331D328603
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538668; cv=none; b=XC6DMQQU+ywlytb1JZZrrkge+s3IRSNNoSwlhAS+JE04PFSi4DWIrrDvIwasujav7VExsrhw/BQqK6XllrxrLC2lKSKNE1t+C4r7Wdei2Q91GBpqzkyrQ1khrFfqycOnRXpPvedEQMIQyCLZlq1ZkyxBUKjy1tdcQtw5XoF5Ibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538668; c=relaxed/simple;
	bh=lVPf51n+WiX6G7687egeF1FG+zHyicnAghbQe2iIjCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqcwULgwDag4RMTnVp0me5EE2ODKK90mZVp3ESixmvMxUco6IwPVgafHO1LV5oIg/yr76hmnpnc6NlXUZx3AuNpqRVik2YZasOzdHaWgsDA6nEkrQDVqq2coaKq4392Krez2Ax0mH7dF5w7CMK1u95+mvQNBGK/VbhWrFsYjBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gf265Hsz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zICIYJWa; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gf265Hsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zICIYJWa"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 035F6EC020E
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Nov 2025 02:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538665;
	 x=1763625065; bh=CeOGgSgT0fGnMN/zJ/rIJuPl0whrMa8dZCfo9SgR1jA=; b=
	gf265Hsz7o8GpabQww4yKh5olUMvxlq0cK/C5QnnvH18oc14Q8IvmEhLAy3wZtbv
	tDPszGw6SqQpffAhWzWMJtiLpuIZHoN/q5kGax0PBuyNV6ImMzFsCq0J9ljotsvx
	/8sdIwFjx8HobjOp3FSmKAkYYp8YWeyKdxwmR19SZH2NWto3PzuD9GbMcI1mk+x0
	2WudfvM4Tqf5amWiDGwOQs5f/LUuhuB6oBE1jZ5ENvmnKFjbnfWNH+LI92vnJzBS
	PsDwDheRSxeDUlwyV8lnJi63R6SXMyAGmg72WE4ObUDOGeKXAA32kfkqWAZ2WBKP
	aQtrsmfSfVukWOzoBuHkKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538665; x=
	1763625065; bh=CeOGgSgT0fGnMN/zJ/rIJuPl0whrMa8dZCfo9SgR1jA=; b=z
	ICIYJWatUTixpav2muQZkneF/Ief+NiXpKYh6DZTKIdUvuLaTMkw4+NUEAVmtThL
	+N9MDwjbW/Lbe740QZvM7ClSVvicLe4p9jJnNY/WG7vQGW9ODY9c+fpxB4dwPg3e
	EW9RtTEoSaEu4BJNGt/udo2jxXFHLhtLQReS2VHKLJxVH0QUX1ugFvG2DIRKxXmZ
	iqAxfqJ3w1mBCExWhnbdnRRVJHHiB6pA9rWXoFHEJTxb+ApS+44xbaUcrLtJgUMe
	sg/oO0VGzt06GYRGkjqkVh7YFPioqIDzx9aURRRlvnIHJgXTE/8hjxINJ6ZkoKW1
	xKFdAzQQ2oQVr41UHf/ew==
X-ME-Sender: <xms:6HYdaSw0TKkYypeseUPRmDBXyKA3OsWIvWF60omjIABUgAMFHUOmGg>
    <xme:6HYdaVPTgXMov68_QJMhqTgrfMt88nMixhsUnGWVJgbGK4NP8of-jaGNFf9oxq7SV
    zRaqbhQoMwfnTQdLVfa5s8I3FsKtokj0M590duigOj7w3eokdFTmw>
X-ME-Received: <xmr:6HYdaZ_3yRiRO_D3uL9jELkAMV_wTn1jEz3W2Bx5La-g5ZaQtABya4YLTQHnBJDDXkW1yDilEWsl39Jomvbg-4JgW9jnFwmduNT15gP6vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:6HYdadrJgJOZSEqHN8lA7eAsJfmyL0sPl-6_qnw6VOHkz8Kk-nX2dw>
    <xmx:6HYdaT7DTEXavJHkajAmkrYDZhCC70u4GJ52eh8lPXjQklTw2TIxqg>
    <xmx:6HYdaVPC6_tshl6PEO__r9o6ht7MaEItixleqaIdUngSr3Virq3rzA>
    <xmx:6HYdadNYe0Hnc7uVmzqrzg1MjUAMnnDfEbMT6gddWNfyGpUuoRealQ>
    <xmx:6HYdacxDAw5oLeFG7tJSlQo-X3aucwL6JzoM-F5lqAKPJFUd_T8wduTz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4a9ed88 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:50 +0100
Subject: [PATCH 02/13] setup: convert `set_git_dir()` to have file scope
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-2-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We don't have any external callers of `set_git_dir()` anymore now that
`enter_repo()` has been moved into "setup.c". Remove the declaration and
mark the function as static.

Note that this change requires us to move the implementation around so
that we can avoid adding any new forward declarations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 80 ++++++++++++++++++++++++++++++++---------------------------------
 setup.h |  1 -
 2 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/setup.c b/setup.c
index 98c6fd8ee4..8bf52df716 100644
--- a/setup.c
+++ b/setup.c
@@ -1002,6 +1002,46 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	return error_code ? NULL : path;
 }
 
+static void set_git_dir_1(const char *path)
+{
+	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
+	setup_git_env(path);
+}
+
+static void update_relative_gitdir(const char *name UNUSED,
+				   const char *old_cwd,
+				   const char *new_cwd,
+				   void *data UNUSED)
+{
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    repo_get_git_dir(the_repository));
+	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
+
+	trace_printf_key(&trace_setup_key,
+			 "setup: move $GIT_DIR to '%s'",
+			 path);
+	set_git_dir_1(path);
+	if (tmp_objdir)
+		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
+	free(path);
+}
+
+static void set_git_dir(const char *path, int make_realpath)
+{
+	struct strbuf realpath = STRBUF_INIT;
+
+	if (make_realpath) {
+		strbuf_realpath(&realpath, path, 1);
+		path = realpath.buf;
+	}
+
+	set_git_dir_1(path);
+	if (!is_absolute_path(path))
+		chdir_notify_register(NULL, update_relative_gitdir, NULL);
+
+	strbuf_release(&realpath);
+}
+
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  struct strbuf *cwd,
 					  struct repository_format *repo_fmt,
@@ -1663,46 +1703,6 @@ void setup_git_env(const char *git_dir)
 		fetch_if_missing = 0;
 }
 
-static void set_git_dir_1(const char *path)
-{
-	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
-	setup_git_env(path);
-}
-
-static void update_relative_gitdir(const char *name UNUSED,
-				   const char *old_cwd,
-				   const char *new_cwd,
-				   void *data UNUSED)
-{
-	char *path = reparent_relative_path(old_cwd, new_cwd,
-					    repo_get_git_dir(the_repository));
-	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
-
-	trace_printf_key(&trace_setup_key,
-			 "setup: move $GIT_DIR to '%s'",
-			 path);
-	set_git_dir_1(path);
-	if (tmp_objdir)
-		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
-	free(path);
-}
-
-void set_git_dir(const char *path, int make_realpath)
-{
-	struct strbuf realpath = STRBUF_INIT;
-
-	if (make_realpath) {
-		strbuf_realpath(&realpath, path, 1);
-		path = realpath.buf;
-	}
-
-	set_git_dir_1(path);
-	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, update_relative_gitdir, NULL);
-
-	strbuf_release(&realpath);
-}
-
 const char *enter_repo(const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
diff --git a/setup.h b/setup.h
index bfea199bcd..d55dcc6608 100644
--- a/setup.h
+++ b/setup.h
@@ -94,7 +94,6 @@ static inline int discover_git_directory(struct strbuf *commondir,
 	return 0;
 }
 
-void set_git_dir(const char *path, int make_realpath);
 void set_git_work_tree(const char *tree);
 
 /* Flags that can be passed to `enter_repo()`. */

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

