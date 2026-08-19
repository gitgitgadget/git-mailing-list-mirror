Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379CE30C156
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143866; cv=none; b=sbQ9uqujyynWvthOEShydxTDXRlx+psFjwnug2S/CtcRECfRRdMvbW5eI361lkzjQyEN7COqxIwJu9eKhmcYh+jAOfP1yYS3L7XmSySjnaw1W3XFsRi7HDod0T3ITyT2Smp0xcdde5yVatAVAJ2bJwpej+hMSR+ZvJ6fXFwuLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143866; c=relaxed/simple;
	bh=duQoe4NX01DOqY4EQm9Sgec86tUDPx7OkfK8J1jpYHA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pHH/BGhzjVhIngDv96UnBWgynEUWVZI5f78GoA0QtRGmRZddXovJee7vlZ1gTDkHWJMVQIQPc6NY+QZ6y5e0QMQbbBh1kSK+I0oIyZPFGbJKFoRZXxcXZ6z+hvHcNG0JMaDiWToHhWpkRdxxn1lwHNMv+dzWVpecJB7v8qN7sxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdq2kQLf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdq2kQLf"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38101f85591so1827324a91.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787143864; x=1787748664; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xt4jA428RYXsC20Vcxig7CynYfwxhGzUV/GQH8dAMZg=;
        b=kdq2kQLf7p/G01deSDBuJzFVnBGIi98LtuaXxQuedABVdZhWZy6tJ07Rknb9LxshFd
         tZ5+y0v+FYYO0vZQk0UzwZGJJ5qTVUtLooELyKeYX2scKGZOt0DyNqbmjLd8n/FGqhlX
         ERZqsxOa1c1QZLHisG70jxoOB/YYvhhNLn+JsgSvW1yDDmmGhBvbDr0I7/tMJohNlOnz
         KQ7DlGkWe9Z2qvjqXxiQNO4Vkhf8ojlSUBHKCx17ZNVBcRb1yYncw/kkuq0tTgtEjofC
         MjaI2cn7CxGY5cG/CWVdBcP7ofMfmwDXYKwfZdWhC5KzwGgpRmC6iq9UGAFUlihLbUua
         NKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143864; x=1787748664;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xt4jA428RYXsC20Vcxig7CynYfwxhGzUV/GQH8dAMZg=;
        b=b0p9i1gAsGnpkfe7nNPBKD7BoRtWKiZV2qo5xlonGhtBgqxCBk/pMoM9vSQ3TWLbGp
         3bkx+MmCf3Bqn2hBrWYTVZL6EqPitu4rkrnRwGIlgGOpqhWo1SyiRECNqBWTbPbah2XL
         AbHLNh1SB3gE5oGiGVskUc3DQg/Yn1hvD2caTciA6ErM2xqg8fOWt/d+n5caSGAb2M+M
         dJy8gnQmcyxv1+8LvnWm5D+b9Su89ToV8ruwInwPLgGWZTWxscm6I12vrkPC48LR+DAF
         +9Vwp8CeWqea9BiDyqoFt0n6OL48hKGTxwBRVPd7vtvQB/phUHXjcPqUPvV1QgHy0VMn
         pI6w==
X-Gm-Message-State: AFuF++mRXQbqtNg2KffocIos6eBRqUrHt/vkhgsk1h+GlAdMY91re+pc
	+2rye/IsMfAB/m59RJaMFMu5rqn1hGPnwaTZ1+b1sRPVLv9s3naQBJr6yoWZhQ==
X-Gm-Gg: AR+sD100Vyz/z+P/bRS/rxxiVikJHAdkThNUUrIagyOSO9ubBwdPG7uNL/l3AWMLSh6
	QnCXOVi6ZXOhwmlj64mRgO6nePwjUcSYI/8/RMZltKcQRmdUwV7vJqbMZGBCmQgeKcj+7r6+CZQ
	CDAYDpLjIHbcbHpHkvQF4LDyx9Pm0TZ29HkoMtzDFLwbmHjiuzZ7JwFRQIpzyQ7i4OW0+Ja4RGs
	IFwTlBsapUXN6/+t71LW9uBcn2cdtWfGOSi1Ackqmq+PdyYrcalPeDZ3j2DeeFibB4iTNmB69nI
	zW+ygFa9xcqj6qxKdLdLGaqeaTLdE1KDO7xJL12d8V1qZJ3CvsirIZ8k7GI3NZXjZsER9qhb4Dz
	MH4CB5/yB02Ss+JPYzN/2rTMufZFfFkhaWRvDNytPdfpMi3iWq9hU6DEixTrfvVNwyv/CEZUBuL
	gAnWqtrkOAn1X1FL6XvHFp0l/jxKCjS7VKf5qUIfubg8KxL6TxjBxID3JTXfs=
X-Received: by 2002:a17:90b:1c8f:b0:38e:7e9b:5fbc with SMTP id 98e67ed59e1d1-3957f8af758mr5854143a91.7.1787143864219;
        Wed, 19 Aug 2026 05:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.76.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad6060asm13096787c88.6.2026.08.19.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:51:03 -0700 (PDT)
Message-Id: <777862235e884f4fa704c4feb99df17b1da83038.1787143859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v5.git.1787143859.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v5.git.1787143859.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Aug 2026 12:50:58 +0000
Subject: [PATCH v5 2/2] worktree add: improve message for ambiguous remote
 branch name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When the user runs 'git worktree add ../foo-dir bar-topic' command
that does not exactly say which remote they want to work with, and
there is no local branch named bar-topic, we try to guess which remote
by passing bar-topic then create a new branch named bar-topic which
tracks the remote branch.

If there are multiple remotes that have branch named bar-topic, we
silently gave up, leaving the variable 'branch' intact.  Then we
entered the conditional clause 'if (!opts.orphan &&
!lookup_commit_reference_by_name(branch))' and triggered "invalid
reference" error.  This error message did not contain enough
information to resolve the issue where the remote could not be
guessed.

To improve the situation, we display a hint and a descriptive error
message and die immediately when multiple matching branches are found.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/worktree.c      | 34 ++++++++++++++++++++++++++++++++--
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 22c8e5e131..30d7a8c340 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -788,6 +788,25 @@ static char *dwim_branch(const char *path, char **new_branch)
 	return NULL;
 }
 
+static void advise_ambiguous_remote(const char *path, const char *branch,
+				    const struct string_list *matched_remote_names)
+{
+	struct string_list_item *item;
+
+	advise(_("Branches with the same name appears in multiple remotes:"));
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
+		 "<remote>, you can do so by:\n"
+		 "\n"
+		 "    git worktree add -b %s %s <remote>/%s\n"
+		 "\n"
+		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
+		 "consider setting checkout.defaultRemote=origin in your config."),
+	       branch, path, branch);
+}
+
 static int add(int ac, const char **av, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -900,15 +919,26 @@ static int add(int ac, const char **av, const char *prefix,
 	} else if (ac == 2) {
 		struct object_id oid;
 		struct commit *commit;
-		char *remote;
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL, NULL);
+			char *remote;
+			int num_matches = 0;
+			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+			remote = unique_tracking_name(branch, &oid, &num_matches,
+						      &matched_remote_names);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet &&
+				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+					advise_ambiguous_remote(path, branch, &matched_remote_names);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
+			string_list_clear(&matched_remote_names, 0);
 		}
 
 		if (!strcmp(branch, "HEAD"))
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual
-- 
gitgitgadget
