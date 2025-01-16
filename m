Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7D1862
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063341; cv=none; b=RJ/Y6t7G3EyO4du7NoTeaJ4ARcTMYYIaxyOHxRetjknIYGp9Uq48lBpxqXSlY7gSHXUWy64v1KxruhCNeqUCCcAtZCR4fgN44WUt7GPChCl1FtYl1/TnvrcLcYe4Cnctg27qWzQd778m+d1YNnS8ffzsGqJIyOaZLPGZGsxAOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063341; c=relaxed/simple;
	bh=ygZ+Ngzw2vO7wQ2WaTiUg5f09isTLowax4ZaohnqeMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DnCel/qTjSQkzFilBqP7PVKYw2m9bwuKTqeiXj9qBnPDSb/jf91XRPJYP+KD/wFb3vgE+kfRaHUlldpBFDWCaplNOvyqDfh4UARWqmo+OiZ1HwG5Up5t0KYnrldYqhR7hX9vsL3NzY87PB6sFqSOqQkB9/Z0Z0kmbkoSRLrIEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAMlnmCQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAMlnmCQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361815b96cso9208705e9.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737063337; x=1737668137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10PrkPN+8DCLckzxC4pdQv323Oo9O/2B+P11klFe4Hg=;
        b=bAMlnmCQpe1sD9mBERxD2kGsUC7UO9CuTPMwc3P/bXydMDaObMu12vvbLZRxGsFqlI
         pRzcy/nICD/y2n4yhGT0sszrin172dxWaOo/IFBApyi0HNuFZfh0xMjuf39iLJDF3Hae
         m0hdjM+1GbY/RL+4QDkkah+dtfnKppC8eP9ZHHvkABkEEVu4VOEth9ycCBaH6BreWipt
         elVfF4O5nuAjQHU30Chn5VI67KX65nFyGWzy7rLfykmJciBES4FgylAxy4eP14fghtOp
         /fL0MM9mF52HFssFOyaDgJCdwRUeGTaicxDUfTjVl114vDb+nxwv+W0mhNyP8IKl6ZFS
         GHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737063337; x=1737668137;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10PrkPN+8DCLckzxC4pdQv323Oo9O/2B+P11klFe4Hg=;
        b=jBGGKaDL8KzpwzdNSGMAamO3k2VFWRRZaaffXajqTZ4feT6P/o3Vznxai65lE8Mt7H
         Fy39jOw/1l3VF/AF4vdFFYS3cR69ovWO21L0r1PbZq2rl2hCY/PG7iMwRqABi3Zuo2DZ
         jnaV/1i+gOZHWYYLOFCcmeAhctKJ0mQKLQdkVf8VFiOyMuS9Lp0V2ym+rWJiTjNRkS1y
         jyTdTzaJF0vhLvTX5lPA4c0swsrm5njmGAXn102rv5nBGcbjE6I9BbWTcV0LQWrgjuF7
         i36QZJPfN36FQZEs18IqASjJQeAuMgPSpOROCE4QqrDzv1MglZ6pgNsv1Rx85/dTxk4C
         oBNw==
X-Gm-Message-State: AOJu0YxraAQ/g+bd+wH2Y1+meFuimivKXeIOXgpkIEysbUBgn25skqm3
	Qvy0Jw+sP263OZdZfbHStxZRzYHOOHetPqUtXWT2ve5GdywjXjyxd4G61g==
X-Gm-Gg: ASbGnct7iVY1DxOxIo8PMVas1vbaCP/RyP4l4Tgq986BXEoCOX7TtEM3As+0F3ZYC8V
	NoSio9CyPe8MrUOvJnWAX7WrYo3wDLqbFVct1kxMc19AoSL07dpDbRCcrhiyM83N9PiKiWDwn3o
	d1QbfJkO7MeQkW+36tMqoxbPYOXG13fZ9VFm6sfrv0Zcrw+GvXP3WCvRf5VDe7CysyyU9cBJCHt
	9YVdehGp7h9Bqz3e04vQrx669dkYxG/3dEfM2uC9F6ZV4N/SL4JeU4QfA==
X-Google-Smtp-Source: AGHT+IEK3AzkBmaBbU9IsXKSiZTG+2CkyF1bMV5L21E5jaCzCFxnN86t1ig1EWXUuChHWgHNK1sJPA==
X-Received: by 2002:a05:600c:5486:b0:436:51bb:7a52 with SMTP id 5b1f17b1804b1-438913c9c93mr2342455e9.7.1737063336997;
        Thu, 16 Jan 2025 13:35:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322ab42sm805519f8f.44.2025.01.16.13.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 13:35:36 -0800 (PST)
Message-Id: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
In-Reply-To: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
From: "Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jan 2025 21:35:35 +0000
Subject: [PATCH v2] worktree: detect from secondary worktree if main worktree
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

Setup:
1. Have a bare repo with core.bare = true in config.worktree
2. Create a new worktree

Behavior:
From the secondary worktree the main worktree appears as non-bare.

Expected:
From the secondary worktree the main worktree should appear as bare.

Why current behavior is not good?
If the main worktree is detected as not bare it doesn't allow
checking out the branch of the main worktree. There are possibly
other problems associated with that behavior.

Why is it happening?
While we're inside the secondary worktree we don't initialize the main
worktree's repository with its configuration.

How is it fixed?
Load actual configs of the main worktree. Also, skip the config loading
step if we're already inside the current worktree because in that case we
rely on is_bare_repository() to return the correct result.

Other solutions considered:
Alternatively, instead of incorrectly always using
`the_repository` as the main worktree's repository, we can detect
and load the actual repository of the main worktree and then use
that repository's `is_bare` value extracted from correct configs.
However, this approach is a bit riskier and could also affect
performance. Since we had the assignment `worktree->repo =
the_repository` for a long time already, I decided it's safe to
keep it as it is for now; it can be still fixed separately from
this change.

Real life use case:
1. Have a bare repo
2. Create a worktree from the bare repo
3. In the secondary worktree enable sparse-checkout - this enables
extensions.worktreeConfig and keeps core.bare=true setting in
config.worktree of the bare worktree
4. The secondary worktree or any other non-bare worktree created
won't be able to use branch main (not even once), but it should be
able to.

Signed-off-by: Olga Pilipenco <olga.pilipenco@shopify.com>
---
    worktree: detect from secondary worktree if main worktree is bare
    
    Changes since v1:
    
     * no code changes
     * rebased with maint
     * CC added
    
    Existing broken functionality forces our project to use hacks on bare
    repo that we'd like to avoid. I would really appreciate reviews of this
    patch to move closer towards fixing the issue. This is my first
    contribution to git/git, I apologize if I got lost in the instructions,
    but I tried my best to follow the rules.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1829%2Folga-mcbfe%2Ffix-bare-repo-detection-with-worktree-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1829/olga-mcbfe/fix-bare-repo-detection-with-worktree-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1829

Range-diff vs v1:

 1:  9e7170f07fc = 1:  17f4b24d1da worktree: detect from secondary worktree if main worktree is bare


 t/t3200-branch.sh | 14 ++++++++++++++
 worktree.c        | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a3a21c54cf6..7ca50c9a78d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -410,6 +410,20 @@ test_expect_success 'bare main worktree has HEAD at branch deleted by secondary
 	git -C secondary branch -D main
 '
 
+test_expect_success 'secondary worktree can switch to main if common dir is bare worktree' '
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
index 248bbb39d43..a7726c67747 100644
--- a/worktree.c
+++ b/worktree.c
@@ -65,6 +65,28 @@ static int is_current_worktree(struct worktree *wt)
 	return is_current;
 }
 
+static int is_bare_git_dir(const char *git_dir)
+{
+	int bare = 0;
+	struct config_set cs = { { 0 } };
+	char *config_file;
+	char *worktree_config_file;
+
+	config_file = xstrfmt("%s/config", git_dir);
+	worktree_config_file = xstrfmt("%s/config.worktree",  git_dir);
+
+	git_configset_init(&cs);
+	git_configset_add_file(&cs, config_file);
+	git_configset_add_file(&cs, worktree_config_file);
+
+	git_configset_get_bool(&cs, "core.bare", &bare);
+
+	git_configset_clear(&cs);
+	free(config_file);
+	free(worktree_config_file);
+	return bare;
+}
+
 /**
  * get the main worktree
  */
@@ -77,18 +99,16 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	strbuf_strip_suffix(&worktree_path, "/.git");
 
 	CALLOC_ARRAY(worktree, 1);
+	/*
+	 * NEEDSWORK: the_repository is not always main worktree's repository
+	*/
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
+		(!worktree->is_current && is_bare_git_dir(repo_get_common_dir(the_repository)));
+
 	if (!skip_reading_head)
 		add_head_info(worktree);
 	return worktree;

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
gitgitgadget
