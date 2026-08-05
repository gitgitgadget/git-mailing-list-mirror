Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD483E1D1A
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934491; cv=none; b=NJPhmzzJJD2eaFUw2ZnMan/Lhzim4PK0izf5bv7whoCo4umCyHiR6d/LpGI27tzHQuDe3mO2P9Iu0VO34PmxG1h8FhXj+l9BcgnlXRLqVELGi7JABtDPTXV4XYgfiWWqwxCc/yKhmK8g5QS5T61ZIlgSt7y7qW0VqC3h7v9bbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934491; c=relaxed/simple;
	bh=DY3cnNmnPknOYOErzqNd/A5QcNZszvn7Cc0BS/u2Rws=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z34NnZ9m0xP2LpAfWfly4Pjb8VW7h1WgoGVAsIMF26mokxnl9egHDnCmCjCe5BORDvt9P+CmtF4fOhvLI9kfwlVdngElr4bABpz+iRl4Zq1QCeiIRxB25nc91qQqdklKUz9DYjY3GCIadwZuItzdcR4qIXY7ZN/CTBt1XkokaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+5Rq9q0; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+5Rq9q0"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4af173320f9so618782b6e.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934488; x=1786539288; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8d3cLnONuX9acgtNbCexdl8ONKRojaojjsTnBGP8kSg=;
        b=K+5Rq9q0NC/zimrTDIx6KmOHsDSpl1CPsayZRgNnJlZtFu5mI7+AReQklIWgiisFCh
         ilm1XX0LRTsibAluA00ULv3vBRtb/5UORmN3yyhj8Z2ERBaXH16OKG8VeIAuwLH7HseI
         v4WD/8yof2BAdSa+VOhiogtAfSvxyMXbBKaxVPyL74PrLjITrblSvaaLA76kXfs+ETS3
         +NGk+W+tY2IKIvM/U+51aKEG85Z2+MAniFI2NghfRy5XfVvOrODDRH8douCcoGUl9xy7
         +JDHbwp7n7hu4JJMrt+Y8mKU561aXRQrEgC9z/xKkdVyeRkwb9h6dSWksY+V7NF9OoQQ
         IMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934488; x=1786539288;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8d3cLnONuX9acgtNbCexdl8ONKRojaojjsTnBGP8kSg=;
        b=MLxWXO6cHc1dxWQOSZfXO+wQcu1F3ERpPVzCIKYLttgjnf0ztlkpSPr45Fk/tPtt+u
         9CeDVkcM+sAp0N66oHwlYBfPWczrcSOn/43eJMX32m1fIhdviB04H0SJVcdebmTMFeX8
         WsajBycmKOgq/LCuwWpWTjRRVXI4GkztpJ5NmvsZmww8ikgyTd/m+G3JCRv+NDdsAXJp
         EEsXMZkjfkn1gAZU2+SzBHj+AHGmCPGOKln0P7r2bCgf+vNRXvdeB3BOtg95S4brOBhb
         J5AUpolal4TjCyat7/xKcBU7In+Jx3defitk5sgSeBEwOKK36QD5e9YOLLcq/jXzZJyt
         8DKQ==
X-Gm-Message-State: AOJu0Yw6wNYETSLz/ua9QAnJW0e3fgt5z04/YM2dtogrpTK5IE/S404a
	sv+aO9HEw3Pyp/rmXSpBRYHE+MrvJrY1nPXh+Vxm3bG+M8IClHr0auHznVQbCg==
X-Gm-Gg: AR+sD11Mv0WONvvhEoT8bQevM1WIJXgj1zVhGKdsxMmrpvTG3eb/pGtTnGcqXtgSP5C
	FRAsEzBS21kPNBGXBhReEDX2XTsavJPahPX7Ciz4MzC9aCClBWdTiOESSwOvXvLzKmvzgM6inBa
	OxhkEwVke+Q8Gi7uGZzuQzn+VEG/JkXPGFOWAjgzcPIObkQNOIArW43B9Ftv87OaKyxfnZJ7/69
	DGD0eR1+lY4GgLt0M9o+jrFPJXVYGxIfu9vgBGVNYZdwIdrHkkxhzmRFobW7xW9lU7niH9Pat0k
	RDXs3gQ3LpzqqeCg6/qPY4W+ZSOR0fDL3LU1uYQSVVFVD8J95Qya+Vq8OhoeLB54lP+b8XPIJAY
	FAT3kz1nvciHI/Oo0O782GIB5w7Qa3adrekp4/ObzSthsl+WTBxtwdxeAAlMljg1Vh/x41asiWs
	tgVyFiGyH1XslMXYJOw1u8vloTndXdFZO4c9TlnA+W40P8OEzKy7QJfRVd5gJK9tk=
X-Received: by 2002:a05:6820:1524:b0:6ac:a175:fe66 with SMTP id 006d021491bc7-6ae96ed3de2mr3584161eaf.21.1785934488371;
        Wed, 05 Aug 2026 05:54:48 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.75.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae940782desm2811365eaf.14.2026.08.05.05.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:54:47 -0700 (PDT)
Message-Id: <pull.2192.v3.git.1785934486496.gitgitgadget@gmail.com>
In-Reply-To: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 12:54:45 +0000
Subject: [PATCH v3] worktree add: shouldn't dwim if -b or -B is given
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
Cc: Jacob Abel <jacobabel@nullpo.dev>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree add <path> <branch>' DWIMs <branch> to a
remote-tracking branch when neither -b, -B, nor --detach
is given.

However, 'git worktree add -b <new-branch> <path> <branch>' can
still DWIM <branch>, causing <new-branch> to be ignored.

This is a regression introduced in v2.42.0
(128e5496b325640f0a09cc1d5b1e346c069b410f).

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree add: shouldn't dwim if -b or -B is given

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2192%2Fyoichi%2Fworktree-add-should-not-dwim-with-b-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2192/yoichi/worktree-add-should-not-dwim-with-b-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2192

Range-diff vs v2:

 1:  b00f6c2fa1 ! 1:  477ea27c8b worktree add: shouldn't dwim if -b or -B is given
     @@ Metadata
       ## Commit message ##
          worktree add: shouldn't dwim if -b or -B is given
      
     -    git worktree add <path> <branch> DWIMs <branch> to a
     +    'git worktree add <path> <branch>' DWIMs <branch> to a
          remote-tracking branch when neither -b, -B, nor --detach
          is given.
      
     -    However, git worktree add -b <new-branch> <path> <branch> can
     +    However, 'git worktree add -b <new-branch> <path> <branch>' can
          still DWIM <branch>, causing <new-branch> to be ignored.
      
          This is a regression introduced in v2.42.0


 builtin/worktree.c      | 22 ++++++++++++----------
 t/t2400-worktree-add.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..cc46c1b415 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -898,16 +898,18 @@ static int add(int ac, const char **av, const char *prefix,
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac == 2) {
-		struct object_id oid;
-		struct commit *commit;
-		char *remote;
-
-		commit = lookup_commit_reference_by_name(branch);
-		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL);
-			if (remote) {
-				new_branch = branch;
-				branch = new_branch_to_free = remote;
+		if (!new_branch) {
+			struct object_id oid;
+			struct commit *commit;
+			char *remote;
+
+			commit = lookup_commit_reference_by_name(branch);
+			if (!commit) {
+				remote = unique_tracking_name(branch, &oid, NULL);
+				if (remote) {
+					new_branch = branch;
+					branch = new_branch_to_free = remote;
+				}
 			}
 		}
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..ba3bec078f 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -621,6 +621,16 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success '"add" <path> <branch> does not dwim with -b' '
+	test_when_finished rm -rf repo_upstream repo_dwim wt &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	(
+		cd repo_dwim &&
+		test_must_fail git worktree add -b branch ../wt foo 2>actual &&
+		test_grep "^fatal: invalid reference: foo" actual
+	)
+'
+
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&

base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
-- 
gitgitgadget
