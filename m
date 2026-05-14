Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9E40FD93
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769250; cv=none; b=mEbLUbWiC6L2ktPkuXk1V+HyYCEKino99ds2Zx9pAbSWHu/QbUhxUYJRM+P0GvBZJ1usCTNyGLrbbre9LwuwZz4b3X/d9dkkMRnYQ0kJJmOHCKOCAhsiS/KG67PDwMb21BPGD77Uwr3HCGEr24U89KnMl0RHRP5h9xV2WNbyYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769250; c=relaxed/simple;
	bh=mf5NBirXBTwtNQYGWfHyA+j5d8+t2xexHfpFBPNGLtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwCOG6onkMJG3ujVYXVjhOlGlkbwBZynaNFDxQFRDMNO89IRnC7i7kAeohGZiI08UahC/067vMTYfQUWS3lqyceA+A6zqOp8VCfDAC/YEh/kNCFm0zki/75LW+/XSZN0JuY9NL4ks5JXup0/wMGMAlI21rap5TE0YG81fURk1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzdwscSV; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzdwscSV"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90ca6f20872so367752485a.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769248; x=1779374048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Orma8XyrqZP3V2QAyYrQxdxu7IhsmLTX7+JDpBAfYz0=;
        b=qzdwscSVNwBYfb8IYU22KbYGz0e+D7YQblA9fte5J/diys7m4jDeTlZXe4/MrLLpkg
         uNyl26fjRWAtydfGno84B+DNWoILRUEkZjmK8FzvpK4rNjOlNN2E51QjaWz7xM5SfmQS
         LhQbBh3VlE6n1y9o1MN6soEzNo6tnBNgvJBVkRdvGWzdJyz2mG+B8jNCpW/ic1ZJwha5
         CJHSTtGzUS7m3kM38CXM/aEziG63iJ9+6thdWI/jTQJR55h1fBaARnrJDRI60BzbmdUj
         uWLH5tPC/hF1DtV90l5t/XwxYNSBdy1T8EjRka3eEcQyQg2qX6QcCjSaKS60i+KaYmXJ
         oICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769248; x=1779374048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Orma8XyrqZP3V2QAyYrQxdxu7IhsmLTX7+JDpBAfYz0=;
        b=mplmE/5BVlCkTFO7h8AXe7A3YOArLMtscl8bW/eVu7+58JICW/9K0nF4d7TEm9VB74
         Owyx2h3Ad1xZ9bfIvcB5DfkDY3NYZWT56MyXZFx5xWZoD1JAmHxJNG0gqzlvU4plDUDM
         GlDCmR7yxIJ9biPWXzeR2C0dlakASZgCGB0y2kv5Hc7DtUommwR/nWT3ahXbOW5krL7T
         mnu0SVCkVEKmKO92hmwcBbGlxbAvYJx+2D6KQt2/tAbi/HGETCiqNGBFYBOirmMgSciQ
         B9Ge5OOawqO/vwzdZ8IYd/p6CmLBd4LUEwDyr+S13RSon5pnN/Wx2FrgJeWMsTeDFiym
         x1Bw==
X-Gm-Message-State: AOJu0YzBfqxfPvMVcOjfPfIPPk2sXxCgZ29kWmRnky+IYNnO5BFpPFIR
	aLuVTiyO+tJm3b4hPCPuFmTUr5atYxKRtrYfGz/CI2NzB3kGbkPwK4qhHi6HBA2U
X-Gm-Gg: Acq92OGuS7cIptKLQtnMWuazCiVkaOxD1h5t3JV4oEHa6yUmQnNWHj2uXwDNSX0SOqS
	1KgmC9Qr2c5xeBjQkqdsIIZyB0b5KYLV4v4nD5hiqlYwvXF0m0xl5A8cTuFJ8dm3ZW3jLZz8ev5
	bP1zf/C38PmLedLP967UHhPKSrt6E8bRIW7N3wHPA8Gh/Fsdk4N93NIhS0CURAYFdsZ5D65YKWd
	YIW/NuWoswSuSf4QA9JKD1Ghl9zOVisagLl1QaJpfSdScT3gQvodlObXUbiiqAnCF/me1lITCQd
	9fswMa05PoDAo9JT7tXa4a6eIkjMyyvRTLq/9w8TrGoQgkWqhH8n56sfqOXxxd2E42xcL1wYhM7
	l8rhbsa0rAAXO5Q5G9mWlZDdvps/c6fhxHrVi2ewvfrhB/tJLv8e/YS60NJHgJmZhcWLU9A5zwQ
	s19AjzCyc=
X-Received: by 2002:a05:620a:17a6:b0:911:4885:9112 with SMTP id af79cd13be357-91148859a45mr240842185a.2.1778769246918;
        Thu, 14 May 2026 07:34:06 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:06 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 04/11] git-gui: put choose_repository::pick in a proc
Date: Thu, 14 May 2026 10:33:15 -0400
Message-ID: <20260514143322.865587-5-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui includes a 'repository picker', which allows creating a new
repository + worktree, or selecting a worktree from a recent list.
git-gui runs the picker when a valid git repository is not found. All of
the code for this is embedded in the discovery process block, making the
latter more difficult to read, and also making things more difficult if
we want to have an explicit 'pick' subcommand to force this to run.

Let's move this invocation and supporting code to a separate proc,
aiding in subsequent refactoring. Assure GIT_DIR and GIT_WORK_TREE are
unset, configuration is loaded, ant that _gitdir is correctly set
afterwards. As this is invoked before worktree discovery, later code
will set that anyway so need not be included here.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 387cad6..0b73c35 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1139,6 +1139,16 @@ proc unset_gitdir_vars {} {
 }
 
 set picked 0
+proc pick_repo {} {
+	unset_gitdir_vars
+	load_config 1
+	apply_config
+	choose_repository::pick
+	set _gitdir [git rev-parse --absolute-git-dir]
+	set _prefix {}
+	set picked 1
+}
+
 if {[catch {
 		set _gitdir $env(GIT_DIR)
 		set _prefix {}
@@ -1149,13 +1159,7 @@ if {[catch {
 		set _gitdir [git rev-parse --git-dir]
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
-	load_config 1
-	apply_config
-	choose_repository::pick
-	if {![file isdirectory $_gitdir]} {
-		exit 1
-	}
-	set picked 1
+		pick_repo
 }
 
 # Use object format as hash algorithm (either "sha1" or "sha256")
-- 
2.54.0.99.14

