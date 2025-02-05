Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAB38F82
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738737020; cv=none; b=bvxzvXxsE1cf919rzeotB8jMEDFTxAunEuBW/CDL/QI5qdXkkh53jcd29lsw6OEIBYA8uUAAz8AvQ2YK9/TH6FYcFQ0yHLjbdpZzG2bBSLb3QGfEVXU+1K/NUrGS27ExWeR0cUYrGoEgTMRiqW621ix2XZOyAcrUqZ6kAl0QYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738737020; c=relaxed/simple;
	bh=SaweVBl6Y5ctPk4yaJcqeJXuO0ZoiZEWmtfCa6Ce1uA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cytEC5CCVbkXpaZsgtr02rlpwodWqTwNheSfwBspeRztNvLTF7A68Xw04araF5b6Symw0m+efWnX41t8xj9v0KcnwH1jglONuBtbYNmbsL90exr553gC1paHE85WjPYrIv/npe1C4e69IYEndXOT5btlRnfDDt56MXVpTGw+o00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F70zdAcz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F70zdAcz"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1140979366b.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 22:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738737016; x=1739341816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hwzwMIJv5uo7l/67ngFp5uf/Hc29b1FdaZN1/QgVCM=;
        b=F70zdAcz39w1pj9rX7L+IckQOnaDe/DidrkEY/91KsezPSpU42JP+gj4QpNWoEiHiS
         VBVdDDzTxDfqsZ1fBgHu4jsW6mU1xeC6d1LZ9/adIz8OFelaAWXzIca+QlZrn7Ms3JH/
         xj6Rx2SM78k8TGZJxdAW+60jf2DSfx3u7S63H04BB9VoSFN6ZB+5nt/Lw9/zw0Nz8ud4
         OUsxwm/i6L2DJf4GrN4eVinVnAayYsjELDW98AdClr8ia/rJM1PmEQrH0tUlSZAdqRyo
         8HW7Q83cQ+VIv+xLzdwEBCV46FpUtEzkFjx5pOa5vcrh+gb2Wp91r55F9tHPFGeMAdEp
         1L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738737016; x=1739341816;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hwzwMIJv5uo7l/67ngFp5uf/Hc29b1FdaZN1/QgVCM=;
        b=Cz5oT+euUnr6qtFkXfkEM5geKm3CVFfeytThuVhkEb6DzYkNs2NX1fqiyw4CDiCbGl
         fLeUpRGr3s2d38InloCeiS9/noWyJ9j3bLAKbJYIJkTXS2GXkJzvwD8Z5XR5YqaRPCBQ
         zS7P73p78bnMY9H0X77/zoolwD4X1FhA49LoVyusLJLL+en1SpXA/5nuwjm3dVJCJ8ar
         PidKvUxCNt1rke9te9i6hSG3flbYVt6ZllAE0DkWyDfzhZX18N9xcKeFptvGFgj/GKM5
         R/46fTWMHO+SbDZ/0se5Q43RAvV6Xjxc3kHwbDw+351jUYUjOXT0JxG59QoRDMt5MXM/
         qqeQ==
X-Gm-Message-State: AOJu0Yw1ndqFJTiBnTql4PrA8PrCA1UUpWeWUN63y+FQaai6rXxWAI2i
	xBxArgECN+CPvx5Mzmmp++TapOddq0FN8W9wWyrRFb9WY7N52/OZ6s8y7A==
X-Gm-Gg: ASbGnctKYyy4PICYWeoKzhYSQaSIwagSu8SZ4vDUIsQWibkbLGP4kyrZd3M4oaYw9sa
	c5Chovz7v5yjxN7Y1Vbg4vMP8N7sr6LhABemHjrjB+z7ozDjm62vC0oTAVlXxPuVKBa91yjkSRq
	5O1FBrWA3Ah6JpQCqE7uQVOhFTwttElQRjgPBKVWWZgcSXRM2X4zdsx7Kvwc99EzG/FBJDzrBeJ
	1ZJO1GDbzSjW9gJKG1dAMPbZW+2v5SqlLFdp2+5UBx2MxTW4IGOF8FTifPO0Ve2j0Zkq3aQw4LO
	UMvvisvKKtn0NILl
X-Google-Smtp-Source: AGHT+IG8UWKw6MtGl0Sk6WuP8+cl0tUCds6lT0Uzgd7TPbVDKK5XZFdns7k9r6qJgowgHX2sdLwsqA==
X-Received: by 2002:a17:907:1c0a:b0:ab6:d575:3c4c with SMTP id a640c23a62f3a-ab75e27eec5mr128703366b.17.1738737015997;
        Tue, 04 Feb 2025 22:30:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a818csm1043207766b.6.2025.02.04.22.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 22:30:15 -0800 (PST)
Message-Id: <pull.1829.v4.git.1738737014194.gitgitgadget@gmail.com>
In-Reply-To: <pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com>
References: <pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com>
From: "Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Feb 2025 06:30:13 +0000
Subject: [PATCH v4] worktree: detect from secondary worktree if main worktree
 is bare
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Junio C Hamano <gitster@pobox.com>,
    Olga Pilipenco <olga.pilipenco@shopify.com>,
    Olga Pilipenco <olga.pilipenco@shopify.com>

From: Olga Pilipenco <olga.pilipenco@shopify.com>

When extensions.worktreeConfig is true and the main worktree is
bare -- that is, its config.worktree file contains core.bare=true
-- commands run from secondary worktrees incorrectly see the main
worktree as not bare. As such, those commands incorrectly think
that the repository's default branch (typically "main" or
"master") is checked out in the bare repository even though it's
not. This makes it impossible, for instance, to checkout or delete
the default branch from a secondary worktree, among other
shortcomings.

This problem occurs because, when extensions.worktreeConfig is
true, commands run in secondary worktrees only consult
$commondir/config and $commondir/worktrees/<id>/config.worktree,
thus they never see the main worktree's core.bare=true setting in
$commondir/config.worktree.

Fix this problem by consulting the main worktree's config.worktree
file when checking whether it is bare. (This extra work is
performed only when running from a secondary worktree.)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Olga Pilipenco <olga.pilipenco@shopify.com>
---
    worktree: detect from secondary worktree if main worktree is bare
    
    Changes since v3:
    
     * added a comment to explain why extra check is needed to detect if
       main worktree bare

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1829%2Folga-mcbfe%2Ffix-bare-repo-detection-with-worktree-config-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1829/olga-mcbfe/fix-bare-repo-detection-with-worktree-config-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1829

Range-diff vs v3:

 1:  f9207746b38 ! 1:  a34459b5681 worktree: detect from secondary worktree if main worktree is bare
     @@ worktree.c: static struct worktree *get_main_worktree(int skip_reading_head)
       	worktree->is_current = is_current_worktree(worktree);
      +	worktree->is_bare = (is_bare_repository_cfg == 1) ||
      +		is_bare_repository() ||
     ++		/*
     ++		 * When in a secondary worktree we have to also verify if the main
     ++		 * worktree is bare in $commondir/config.worktree.
     ++		 * This check is unnecessary if we're currently in the main worktree,
     ++		 * as prior checks already consulted all configs of the current worktree.
     ++		 */
      +		(!worktree->is_current && is_main_worktree_bare(the_repository));
      +
       	if (!skip_reading_head)


 t/t3200-branch.sh | 14 ++++++++++++++
 worktree.c        | 41 ++++++++++++++++++++++++++++++++---------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a3a21c54cf6..f3e720dc10d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -410,6 +410,20 @@ test_expect_success 'bare main worktree has HEAD at branch deleted by secondary
 	git -C secondary branch -D main
 '
 
+test_expect_success 'secondary worktrees recognize core.bare=true in main config.worktree' '
+	test_when_finished "rm -rf bare_repo non_bare_repo secondary_worktree" &&
+	git init -b main non_bare_repo &&
+	test_commit -C non_bare_repo x &&
+
+	git clone --bare non_bare_repo bare_repo &&
+	git -C bare_repo config extensions.worktreeConfig true &&
+	git -C bare_repo config unset core.bare &&
+	git -C bare_repo config --worktree core.bare true &&
+
+	git -C bare_repo worktree add ../secondary_worktree &&
+	git -C secondary_worktree checkout main
+'
+
 test_expect_success 'git branch --list -v with --abbrev' '
 	test_when_finished "git branch -D t" &&
 	git branch t &&
diff --git a/worktree.c b/worktree.c
index 248bbb39d43..d4a68c9c235 100644
--- a/worktree.c
+++ b/worktree.c
@@ -65,6 +65,28 @@ static int is_current_worktree(struct worktree *wt)
 	return is_current;
 }
 
+/*
+* When in a secondary worktree, and when extensions.worktreeConfig
+* is true, only $commondir/config and $commondir/worktrees/<id>/
+* config.worktree are consulted, hence any core.bare=true setting in
+* $commondir/config.worktree gets overlooked. Thus, check it manually
+* to determine if the repository is bare.
+*/
+static int is_main_worktree_bare(struct repository *repo)
+{
+	int bare = 0;
+	struct config_set cs = {0};
+	char *worktree_config = xstrfmt("%s/config.worktree", repo_get_common_dir(repo));
+
+	git_configset_init(&cs);
+	git_configset_add_file(&cs, worktree_config);
+	git_configset_get_bool(&cs, "core.bare", &bare);
+
+	git_configset_clear(&cs);
+	free(worktree_config);
+	return bare;
+}
+
 /**
  * get the main worktree
  */
@@ -79,16 +101,17 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	CALLOC_ARRAY(worktree, 1);
 	worktree->repo = the_repository;
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-	/*
-	 * NEEDSWORK: If this function is called from a secondary worktree and
-	 * config.worktree is present, is_bare_repository_cfg will reflect the
-	 * contents of config.worktree, not the contents of the main worktree.
-	 * This means that worktree->is_bare may be set to 0 even if the main
-	 * worktree is configured to be bare.
-	 */
-	worktree->is_bare = (is_bare_repository_cfg == 1) ||
-		is_bare_repository();
 	worktree->is_current = is_current_worktree(worktree);
+	worktree->is_bare = (is_bare_repository_cfg == 1) ||
+		is_bare_repository() ||
+		/*
+		 * When in a secondary worktree we have to also verify if the main
+		 * worktree is bare in $commondir/config.worktree.
+		 * This check is unnecessary if we're currently in the main worktree,
+		 * as prior checks already consulted all configs of the current worktree.
+		 */
+		(!worktree->is_current && is_main_worktree_bare(the_repository));
+
 	if (!skip_reading_head)
 		add_head_info(worktree);
 	return worktree;

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
gitgitgadget
