Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7D383C77
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028859; cv=none; b=t0zplzHDWRdyyJjIemZPbUQwAsh2Ppq5JrL4I2rODklRE9dDzLSVA24E1gJbfA//2NxSAiT06zzPAxxAqlHaHNPltGTZx72SOTC3gKN0wu9Z0zNwWDYSGXJvx+hHMD5fW2szc7cm4Si/BcyYiEdGi6Z0glpmh5EfPRdllvH/hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028859; c=relaxed/simple;
	bh=pl58WQx9dpqcFL9WHFRBq6fGx9uSgGzDKE9QVsc5TSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/9Tzq31FfdWLyqCZxr7EpkqgT8K6VDwnIX0Yxy6jHNffu7owf/UROqbF6r+kbxhabBuRH2e0mXm4x+flW4v8QrsmfEG0XALCr/2UCifhU6ofJGJ7bSn8SYuHbskPEMs8a9BK0xbofw6qUMxDUybIYD0zPBraciwOhiAcIhGiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hunzkLl9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hunzkLl9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C228C19423;
	Wed,  1 Apr 2026 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775028859;
	bh=pl58WQx9dpqcFL9WHFRBq6fGx9uSgGzDKE9QVsc5TSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hunzkLl9NbpPsvYE4W5liIUIVw//gW7mjkBabrMWAY/ktLrMpKuf88+t1R8NWCtDN
	 IAZbf04TO86mzA3cy+aOGo4c9sFNNPPOmNw5TFbTGDmdqXlC5iHcyvxPb2ijG2bpj5
	 zOQQDH/DkoIZOsu9YgV4Zm2cHVOgUVbsXZKaM3Uz70O5tlViMPQEWOM4ObF7XLtqYE
	 u7BAhLLTCUNbty28/NCBFgOlBWXXlMpj4fz/+o4GyALEllsKn2nLmv9a+7d6GMDFwj
	 J0OL8YShuJqCFMtSk/pGsmtvvnk/cXxuDFVv4KJubYhdve4je7eXkl4xoGMxHe70ve
	 7Hk03CMbJtkrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC457D35153;
	Wed,  1 Apr 2026 07:34:18 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Wed, 01 Apr 2026 15:33:43 +0800
Subject: [PATCH 3/3] t1305: add tests for includeIf "worktree"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-includeif-worktree-v1-3-906db69f2c79@black-desk.cn>
References: <20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn>
In-Reply-To: <20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn>
To: git@vger.kernel.org
Cc: Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3334; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=vkzlFuHSi6641zT6zd8IknfSDTILs3Ce3ujOUx+yxws=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpzMp4LF6zNfSELniObOUo61h0uTs6lgwU9WsUA
 SN9DlT14cCJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaczKeAAKCRB2HuYUOZmu
 i71rEADo0J4hDiOpqElLkPvo9EN4IQi3vBA9NpGxpKr9EE9YXLFxx4NcOszva1sRBDL/DiajjLm
 8SkirT2I9hlJ6phrtP7jGWlZA25zaqGKBEbX+wgY57j0095mVFTiDQqalp4esTPxSi2wGxlQocJ
 r/iOHsCn+FX5EvBDFn2Z8Ur60XWcuDeOT/MujzBoRhYc6RCa8PAt4N6ZLgOiKtM9ae7Dl0ETH36
 3uJ6MmMXf+2CNoxw9q4HRs2g1WI65tYcr4MFpVIu8Sh8nWfF4IZDn8BitI59DHp3Wxap50EhZs4
 TLvW8GbkD9hLtfL5zROUjBBF6WRW5IdYww/Qv5Sy+fymlZlR5fADu1SvQBhkuf3nQY3MN4A0vZm
 eGN58Fh6JALTf8Xv8bDR2C8rkAuXDxa6fSprDZtABpu768lY3cGHa1y69GsoWm4ucZabJZe8AQA
 A1spAIHdX7NnLiwbkAHiXniVLqdOVzP6Y7K9Ew9qquYEAeFbgsuiKxn6TTjer6qjR9y/SkGi9bh
 DVdcQMLtKW0F4ALfSzI46A6uC7Z0m80/8rZaS5ZQKURhZPYBVJsteXzUHbzkHpd+Ww1MLu9bS53
 8JN+0meLGkK5P83R5qjL3RMLLpwDF1M0cYv1C1gIAI96/cjMSbSMxkHdErOFNM8YpjKefqRHP6X
 0Au4n5LgfXH7WdA==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

Cover the following scenarios unique to the "worktree" condition
(path matching features such as glob, tilde, icase are already
exercised by the gitdir tests):

  - bare repository (condition must not match)
  - multiple worktrees: main and linked worktrees each match their
    own path-based condition while sharing a single config file;
    a third linked worktree verifies directory-prefix matching with
    a trailing slash
  - symlinked worktree: the path is resolved before matching
---
 t/t1305-config-include.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 6e51f892f320..8a5ba4b884d3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -396,4 +396,70 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
 	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
 '
 
+# worktree: conditional include tests
+
+test_expect_success 'conditional include, worktree bare repo' '
+	git init --bare wt-bare &&
+	(
+		cd wt-bare &&
+		echo "[includeIf \"worktree:/\"]path=bar-bare" >>config &&
+		echo "[test]wtbare=1" >bar-bare &&
+		test_must_fail git config test.wtbare
+	)
+'
+
+test_expect_success 'conditional include, worktree multiple worktrees' '
+	git init wt-multi &&
+	(
+		cd wt-multi &&
+		test_commit initial &&
+		git worktree add -b linked-branch ../wt-linked HEAD &&
+		git worktree add -b prefix-branch ../wt-prefix/linked HEAD
+	) &&
+	wt_main="$(cd wt-multi && pwd)" &&
+	wt_linked="$(cd wt-linked && pwd)" &&
+	wt_prefix_parent="$(cd wt-prefix && pwd)" &&
+	cat >>wt-multi/.git/config <<-EOF &&
+	[includeIf "worktree:$wt_main"]
+		path = main-config
+	[includeIf "worktree:$wt_linked"]
+		path = linked-config
+	[includeIf "worktree:$wt_prefix_parent/"]
+		path = prefix-config
+	EOF
+	echo "[test]mainvar=main" >wt-multi/.git/main-config &&
+	echo "[test]linkedvar=linked" >wt-multi/.git/linked-config &&
+	echo "[test]prefixvar=prefix" >wt-multi/.git/prefix-config &&
+	echo main >expect &&
+	git -C wt-multi config test.mainvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-multi config test.linkedvar &&
+	test_must_fail git -C wt-multi config test.prefixvar &&
+	echo linked >expect &&
+	git -C wt-linked config test.linkedvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-linked config test.mainvar &&
+	test_must_fail git -C wt-linked config test.prefixvar &&
+	echo prefix >expect &&
+	git -C wt-prefix/linked config test.prefixvar >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C wt-prefix/linked config test.mainvar &&
+	test_must_fail git -C wt-prefix/linked config test.linkedvar
+'
+
+test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
+	mkdir real-wt &&
+	ln -s real-wt link-wt &&
+	git init link-wt/repo &&
+	(
+		cd link-wt/repo &&
+		# repo->worktree resolves symlinks, so use real path in pattern
+		echo "[includeIf \"worktree:**/real-wt/repo\"]path=bar-link" >>.git/config &&
+		echo "[test]wtlink=2" >.git/bar-link &&
+		echo 2 >expect &&
+		git config test.wtlink >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

-- 
2.53.0


