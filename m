Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D73B14C7
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102893; cv=none; b=s/HuLDeUt2YsayS0D3lDdfuSoF+g72Rld7F3JvdaRGQgvSe8djbhEDx3Ka2C1nae7IXvVjyY0s6CdJgHRsWo1xE2JlESd8wQxmiZnK/kfg8ZBp9O98GylAATRaegdIX+fxvNftqKALLmqXTbuK/1QTO5RK2R4xwrXXCbdjwNzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102893; c=relaxed/simple;
	bh=DVaRUIf3bS8xK3OMvm09YI5tGWeIiKGyMmW0+W9giJM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j0UxDn6fhnmxyLIPc88/4iWAO98NYNxe89EOVMAoXGU/2LF2cX321rKH4VxvYMyLlgvZH9xVreUUqDEEdDmmc8MEvar3zMIcrW+IGAm9SGc1W24E/g2PVIFs/jYVrPL4zqWr3Ha4EfLn4hWYONSUVABlbcHEZLPoTPPSWdrsykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBq2OuQY; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBq2OuQY"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-824e6e6ed71so591814a34.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791102890; x=1791707690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hM3FQhCle8xEohq9GLnJZweyAnudT9wikXH6iLT2X0Y=;
        b=kBq2OuQYhpP9DuvmHn+oJepZNkj73qzJ5J5i9Pv7RQLJjZO4Gc/5DOHfo4X/LET4Mr
         3FKDBIhkG2rRgvt9O2puGhqfIuOgbmUm3vMHuL/yrqf8O4g+Dl+LdzX/ts8nXK0dTBCZ
         ARmRKtZikLLV9zJK0JIyo+lYMWlWJX0UH9Ge5pBq+aafXE+qfmnACJUCs7DeNQC+1FYi
         xXKF1oOtu9vQZcTK0kO/3IruX1PxKX3VhPSObn0/GZx+0zYHNJcYrl+A94+i4TVx8fMh
         OsfwU6KJp0jyXlKcG0d6d/Cqcbhr29cOW29aG3ifUwZ8AeMsrg6+HWeSiMCnr7wlchbL
         G0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791102890; x=1791707690;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hM3FQhCle8xEohq9GLnJZweyAnudT9wikXH6iLT2X0Y=;
        b=2DxhvwqJV1kvFQEaAXtCE2nB9W8rl1BCPS2Yq282wF/z1+4FdNyAwcjd3ozGOFzFsk
         +40poxcPIn+9/CJlbbjHHZ9ooGQpo+6w+XpgGohFpIu0u/B/d7P6EsOL26zXCGN6iVz3
         LNyadtBlxtGoH8uBioXIQ/45JwksBxBTMQdoMYf3aL3eymaS5RO9LNgIq9d5aiCN8VD8
         y3MPsUIE5+31Hcw0/j5YlGewGaJX9uequPtPbVdlnDyh/xMz3dq794wL27nMJed6PBpm
         ZYHQ8al3aea7ly7Rl5BFwO+oRXGQzVAbtgQFuIh+OPUQk5UPO8okzYwPCm+iMWuLM3b+
         QS5A==
X-Gm-Message-State: AFuF++npQPNT+XoSbsK71ZfCfgYt4DArC7UMfo8+YgphwBsWoAGJTEXw
	PLdk0nwNDK2by0V8UzxT13gkL/0hFwzV7xS1Ud8DHK6PFNJWae1t34VUFujPFxoo
X-Gm-Gg: AYBFou3vc191JAlX4vK30PkgRBknQu+d7zSUAuAFwACaDE2RCLX3FQcIX9Rs26QEujT
	iYpWIxvVXmjyNvLcmttqZhGa8elf5Bf/SPrPjfIL+ClKkPYzg7MeLPritSPfCvTwzwsIuwXr2br
	/CuXuo5B27aXOuzHqs1lWeN02fQ+GSMLZ/bI2TXWU/MMXXM1u2tK62Dq2uIdI3FB58H4Ld638zX
	C6xhyKOsNxUp1y14r1NDkl7J6gW4R6GA6CQl9IUKjYnzxyjkXzjt2SsXBQrGrKm8UQS8kYItCxo
	LFmDLgCVUb2dUwWuFmaIAmtdHYNK+aWhUcDUTe4FRJyiFhcYpLpogQRX6wRQbNwI2o+kkwkuvLd
	L+sZfUxqd8WNhE2Y9bmdYJyecl3OEHQF8q68QD8m8s+LThaMahv1j4lgZeoenlGwFzQU2N8ufDC
	SWF/sG+ti/VlvMaDmcfbn18dvGXupLgOoN86Tg2W7uGkIiU6E72We7HUCp5Q5OuDTovf7UEVZpv
	A==
X-Received: by 2002:a05:6808:5094:b0:4b5:5bfd:518f with SMTP id 5614622812f47-4f679fe0439mr5464353b6e.21.1791102889543;
        Sun, 04 Oct 2026 01:34:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.15.229.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5251e3956sm6696010b6e.15.2026.10.04.01.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:34:48 -0700 (PDT)
Message-Id: <pull.2428.v2.git.git.1791102886740.gitgitgadget@gmail.com>
In-Reply-To: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
References: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 08:34:46 +0000
Subject: [PATCH v2] branch: let --delete-merged default to every upstream
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
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Cleaning up every branch whose work has landed upstream required
typing '**' as the pattern.

Let a bare "git branch --delete-merged" consider every upstream. This
applies only when the option comes last, so
"git branch --dry-run --delete-merged" previews the cleanup.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    branch: let --delete-merged default to every upstream
    
    A bare git branch --delete-merged now considers every upstream.
    
    Changes in v2:
    
     * Name the default pattern ** instead of */*. Drop reference to
       --merged.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2428%2FHaraldNordgren%2Fbranch-delete-merged-default-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2428/HaraldNordgren/branch-delete-merged-default-v2
Pull-Request: https://github.com/git/git/pull/2428

Range-diff vs v1:

 1:  9a576d941c ! 1:  c496777c0b branch: let --delete-merged default to every upstream
     @@ Commit message
          branch: let --delete-merged default to every upstream
      
          Cleaning up every branch whose work has landed upstream required
     -    typing '*/*' as the pattern.
     +    typing '**' as the pattern.
      
     -    Let a bare "git branch --delete-merged" consider every upstream. As
     -    with "--merged" without a commit, this applies only when the option
     -    comes last, so "git branch --dry-run --delete-merged" previews the
     -    cleanup.
     +    Let a bare "git branch --delete-merged" consider every upstream. This
     +    applies only when the option comes last, so
     +    "git branch --dry-run --delete-merged" previews the cleanup.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      


 Documentation/git-branch.adoc |  6 ++++--
 builtin/branch.c              | 14 +++++++++++---
 t/t3200-branch.sh             | 25 ++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..4a91ae6879 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch [--dry-run] --delete-merged
 git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
 
 DESCRIPTION
@@ -202,14 +203,15 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
-`--delete-merged <pattern>`::
+`--delete-merged [<pattern>]`::
 	Delete local branches whose configured upstream matches
 	_<pattern>_, but only when their tip is reachable from that
 	upstream. In other words, the work on the branch has already
 	landed on the upstream it tracks, so the local copy is no longer
 	needed. _<pattern>_ may name a ref, a remote (using the branch its
 	`HEAD` points at), or a shell-style glob. The option can be
-	repeated to widen the upstream match.
+	repeated to widen the upstream match. Without _<pattern>_, every
+	upstream matches.
 	Optional _<branch-pattern>_ arguments limit which local branches
 	are considered, e.g. `git branch --delete-merged 'origin/*'
 	'topic-*'`.
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..f2a4e117dc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -39,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] --delete-merged"),
 	N_("git branch [<options>] (--delete-merged <pattern>)... "
 	   "[<branch-pattern>...]"),
 	NULL
@@ -1029,9 +1030,16 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
-		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("pattern"),
-			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
-			PARSE_OPT_NONEG, parse_opt_strvec),
+		{
+			.type = OPTION_CALLBACK,
+			.long_name = "delete-merged",
+			.value = &delete_merged,
+			.argh = N_("pattern"),
+			.help = N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
+			.flags = PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
+			.callback = parse_opt_strvec,
+			.defval = (intptr_t) "**",
+		},
 		OPT_BOOL(0, "dry-run", &dry_run,
 			N_("with --delete-merged, only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..e60f4794c8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2133,9 +2133,28 @@ test_expect_success '--delete-merged result is independent of stacked branch nam
 	)
 '
 
-test_expect_success '--delete-merged requires a value' '
-	test_must_fail git -C forked branch --delete-merged 2>err &&
-	test_grep "requires a value" err
+test_expect_success '--delete-merged without a pattern matches every upstream' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch merged &&
+	(
+		cd repo &&
+		git branch --track local-topic main &&
+		git checkout --detach &&
+
+		git branch --dry-run --delete-merged &&
+
+		check_branches <<-\EOF &&
+		local-topic
+		main
+		merged
+		EOF
+
+		git branch --delete-merged &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
 '
 
 test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '

base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
-- 
gitgitgadget
