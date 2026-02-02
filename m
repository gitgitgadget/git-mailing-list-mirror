Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A937E30C
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049929; cv=none; b=Yflyygr8k0iNqxIwdam6Kh4L7/mVcldLpuxTjUsVKPM/6i9xe23+lv4lcdkyNeO+cKb8ROEACL+SU4JHaSDPpEQzopmENH/Iu6+cuhZDgKKHykXP7zfKEc10KfKagvFBWNO9i5xqbNGiLbU4VG24SI+ywM+0VQXLfVYHzFVtO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049929; c=relaxed/simple;
	bh=NZhhOKNjbNGBYFMhCBbW3lB/WXbjXWhJarRZPhLVmFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAd9hX2KNttejX9+fgIaue2M/2ppST45iJrAUP9i9Cp/XhAz2QMGr30tml8GKpaxuwDXBhOoZjWT6FIsELNGG+ipJFLnmSp2IgKdG7HVRhJScAY21ze511Edb277zne0GxtwWt4irhn30wO1jNTKam9zlxrinJVl9YU27F/w9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIBn+kjc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIBn+kjc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so50255165ad.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770049927; x=1770654727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxm0u7VQJ14SDRoXEJ6UvTv+RCW1rpjkg68hNaHF3nw=;
        b=KIBn+kjc7SE2cl1/48Nj1jEz3MPxti8HmWK9LDMy5Nr9q/A0MUaJBlTRLQHjBi63UW
         wGH7ZPuhtqUm+YtlkhTBM5OG5eMgadPg9v2Mt7x+yBta4XqeA2R3JVWhkdKF3RddMRpL
         FiZaS6WABpZSnL0w1KJHtlWnGmIXASUWUkDT6yvuibUXh6t4PdwEvGCir+9Zd5yl4pH7
         3YTu/wsIZIFL51+7pIv82VuwI7JtnZ5x2krY1upJmXFv9pk7Lx4LOge3PhR7HSVgU4gh
         qP12PqS1lfRT6hQC+50M6HkuPXWMdlzkxHfU0U8hNDy9sBu5wgYu2QrgZoh+TBhVu9Hi
         q3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049927; x=1770654727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxm0u7VQJ14SDRoXEJ6UvTv+RCW1rpjkg68hNaHF3nw=;
        b=rQHkb2aNUGh1HFpkE7izhdue6iCpaISbxtwy35/li2tgtQIbFHoOK9q2Nb0z4D2HJh
         O7PpPF3PfT1eAKRuyIuFCc4ZkIUPS8+GznJmGItcwMgjxOXMjZIDe1rsmyQ2Qh0UTeWJ
         Yewf6P8MIjwgw/WT+TK4cXpwxUy/Ceq6T5n61nCd6t6qiCBy/iQzEtzKPjYHVMsGDzRQ
         rzlDibTfUGDgpKemi/aKmgtp6SkmFyaTAWRYJsKPNfpt8DfbapvyahD/JLBjoFUnIe8H
         Ao5Ctr+evgefLzWhVtRyS2fO4Pj2VNBS0wJ4EWPIuanDhhIqRYq6xHPphyVTz+j0pxdm
         z4PA==
X-Gm-Message-State: AOJu0Yy9cohJymcI2V7qnUHnUVTPC8KpYigQHaoNWzd6z7RdTTZvGeD8
	be4Z9QTshifF5IYqKW0dtivAJk4pgx+e9FbRotrVH5l9IvWoJVh4uxICw+kvEObe
X-Gm-Gg: AZuq6aK50dlJJz1Xq7p1Za8EqbQlcxloi7qrVzeZJCGLCBVqc82BG57DciOITSUxqQa
	i89zIBK4rbNuZV3J47djO2QXr6BhdHswgL7ZrosWtnjydGbNcDZom+Nshwxq3VLJBW6BLwbXY4f
	yqFLGrnwVIZF1PMsds+bC72VPd789Gtg55Uxyn60LLvpLxPkmmNAhjU0DIag8/Oj99ahJNnu6U1
	N8cK9UyaPyQ+I0rccMHCNw7atFiDsPML+NQz+Axamin3oGFrLwtMu2PuiEsdRrqQa2b5GOv7JtH
	W0PIVGxSYMH+fPoU51QelRNK24rGUmH9bFHNtdD2DPtNX/zsAn+TLsWPsWYX6UrCuwDK5rbhbLl
	9iyAVjednZUUF+XGvEeRZhhFh2GjKPzvKHhNqOm/LL33BSudbytasYV4YvIH0nyqg9x09stk4go
	fBWLpktZ7Rw+gzcM/hleKWumD2LN2DXrAy
X-Received: by 2002:a17:903:244f:b0:2a5:8c95:d823 with SMTP id d9443c01a7336-2a8d96a6a6bmr133061405ad.10.1770049927025;
        Mon, 02 Feb 2026 08:32:07 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d88f0sm159972335ad.67.2026.02.02.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:32:06 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	karthiknayak@gmail.com,
	ps@pks.im,
	kh@pks.im,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v2] stash: honor --no-overwrite-ignore with --all
Date: Mon,  2 Feb 2026 16:22:27 +0000
Message-ID: <20260202162225.35206-3-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
References: <20260202131921.15175-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach stash push/save to avoid -a cleanup when --no-overwrite-ignore
is given by downgrading INCLUDE_ALL_FILES to include-untracked.

This fixes ignored files being incorrectly removed despite
--no-overwrite-ignore, and removes the stash FIXME by plumbing
overwrite_ignore into unpack_trees().

Add regression tests covering both overwrite and no-overwrite cases.

Changes since v1:
- Use OPT_BOOL correctly for overwrite-ignore.
- Fix stash -a cleanup when --no-overwrite-ignore is given by downgrading
  INCLUDE_ALL_FILES to include-untracked.
- Add regression test for --overwrite-ignore.
- Adjust no-overwrite-ignore test to explicitly use -a.
- Add Signed-off-by.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/stash.c                    | 14 ++++++++------
 t/t3905-stash-include-untracked.sh | 16 ++++++++++++++--
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 82d10520fe..c3ee33cce1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1858,9 +1858,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		OPT_SET_INT('a', "all", &include_untracked,
 			    N_("include ignore files"), 2),
 		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
-			N_("update ignored files (default)")),
-		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
-			N_("do not update ignored files")),
+			 N_("update ignored files")),
 		OPT_STRING('m', "message", &stash_msg, N_("message"),
 			   N_("stash message")),
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
@@ -1894,6 +1892,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 		       prefix, argv);
 
+	if (!overwrite_ignore && include_untracked == INCLUDE_ALL_FILES)
+		include_untracked = 1;
+
 	if (pathspec_from_file) {
 		if (patch_mode)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
@@ -1965,9 +1966,7 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 		OPT_SET_INT('a', "all", &include_untracked,
 			    N_("include ignore files"), 2),
 		OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore,
-				N_("update ignored files (default)")),
-		OPT_BOOL(0, "no-overwrite-ignore", &overwrite_ignore,
-				N_("do not update ignored files")),
+			 N_("update ignored files")),
 		OPT_STRING('m', "message", &stash_msg, "message",
 			   N_("stash message")),
 		OPT_END()
@@ -1994,6 +1993,9 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
 	}
 
+	if (!overwrite_ignore && include_untracked == INCLUDE_ALL_FILES)
+		include_untracked = 1;
+
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
 			    patch_mode, &add_p_opt, include_untracked,
 			    only_staged);
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 9c5421cd76..a979831a64 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -427,17 +427,29 @@ test_expect_success 'stash -u ignores sub-repository' '
 	git stash -u
 '
 
-test_expect_success 'stash push --no-overwrite-ignore preserves ignored files' '
+test_expect_success 'stash push -a --no-overwrite-ignore preserves ignored files' '
 	echo ignored.txt >>.gitignore &&
 	echo before >ignored.txt &&
 	git add .gitignore &&
 	git commit -m "add ignore" &&
 
 	echo after >ignored.txt &&
-	git stash push --no-overwrite-ignore &&
+	git stash push -a --no-overwrite-ignore &&
 
 	test_path_is_file ignored.txt &&
 	grep after ignored.txt
 '
 
+test_expect_success 'stash push -a --overwrite-ignore overwrites ignored files' '
+	echo ignored.txt >>.gitignore &&
+	echo before >ignored.txt &&
+	git add .gitignore &&
+	git commit -m "add ignore" &&
+
+	echo after >ignored.txt &&
+	git stash push -a --overwrite-ignore &&
+
+	! grep after ignored.txt
+'
+
 test_done
-- 
2.43.0

