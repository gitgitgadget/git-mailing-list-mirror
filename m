Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F73B777B
	for <git@vger.kernel.org>; Wed, 13 May 2026 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700891; cv=none; b=H/bCynj8nztNeAsmZ1XgdUaPEsiY0jj9YFy1bJZHJIlPjVrxqCrYE1kHOhnePBowxMksF5gFwK7/ALZxsc1ZwiiTvXnqIh4vTco0CrFAjaaahgnmGP+66nprolLC+8Y+eymkZCQm2yaLA6byVQGvAyWo6/knZZXwOpy0gOXxHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700891; c=relaxed/simple;
	bh=RYY9+wAbtbSqSRN8iOFWrua1wOVrbvw6POOK/6fA6SY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HgajDPKfxdH16b5z9qm8DCjOgP5aFIkmiI4FVqgzVO5k/zkTpiUjLyfoywwJrOI6D3xlCpStDgNXniXr9NcdN0fhGhUfMepIXaY3Pq79vjKsgAbMMOKpRvyeXGEzP7MfwVEr8FXZ4akUdlqDaipqb0O2xgIe76AO2qxEFKV/kAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1nixpsw; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1nixpsw"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso80903936d6.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700889; x=1779305689; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqemEY57vTXRMBl9NNgiWqrsTG38YCfxmHa5O8Q8u4k=;
        b=U1nixpswx2xO4sOFrgAmaOfgi/k/skl7vVXJmVm8LFUcC/Ktz4YUdJy8nJKZ4e0ryS
         O6dPUlM+m/mmP5BRmy3dJHjFbzaPkjKrCdv0NYsykxfK0xE67bg6GO0l5g8++SPVST73
         dnf22jLk+JOXZ2ahtvp4QMKR4NJe3CbqvxtjouJcriWJgLy43mxDaIWrlKVXS468u1TL
         QtX6vLOI7KR85Ga9cFxb6Y+h+HYT33mazBA1CqOtkVr12RVRbxXxRKoGXS2aLIUmmSo4
         TdIu4ixCizf2a9XgKQgvUBIBMoLgz3jw+xagglAaT2WP0oJ4KZCYnKQtLJ6SubmH9vj/
         X8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700889; x=1779305689;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dqemEY57vTXRMBl9NNgiWqrsTG38YCfxmHa5O8Q8u4k=;
        b=pDeSm0+bDCKmzGy3G4/8xMDAdZHzBKEwhANYaUbG2ycpqRSMbMTx4wt0KC8nRJd3g/
         7T2pFcwrzoACbi3wsI+tPGKWO/aztAwqkebBT5EXMSbQm0G0RMNSe7pVltWsrSHQYbzD
         p1P706MGd25UoA6/UNmHBzWSCi6Qs/GRfZpzx44yichYRuxmVAxTbqcJu2nSr7gYNE2Y
         mlUrsGaKcNyeqgNgB7pmYIkZykBdrdnTtsmkzOOi/5i3bPflKmC0CmG9KI94mv0pzfDZ
         16Pm4VmHZ6WP29BIf3nAJ8A4ebSrTRsXddKV0zijEpgP7/XyTOe1vNmhLVw3gSogx6HF
         8yhg==
X-Gm-Message-State: AOJu0YySigPlSkKgqSkJds3H+nFsxbU20q3g0HhKQAEwCMNPE86kSYRK
	y9OXqb/BHxEdjTowkSzZKEswHTGeO8jj1tuE6Pl7Eoz8J+mkE2g9NiC9WHb6uQ==
X-Gm-Gg: Acq92OH/UXCkErMzVnSISgL/3JJzNBdw9CtTcv7XGrnTnVXX8m7bWAK1MB5/Fem2Nb+
	EX9MKfsYMVjtc+HTp27aa4JZZzWmnpIX5p6HFf9Rc5hQmjgtsSnUHYZ6inxxN6gmD87o5WSFPYc
	cjN9Kalf9E7Szab1v1MRaXu1ERH4NSmHNC+pAT/+885IfezlzahaY8CwM4nq2TntQAdRryeR6kp
	mEv2RFf8gQmuNHmodx05/gWhXAVUNXoMV5mCc8s9nM1/g/5OA1+A0FZrtl8jAREJtIdZi13x1Dm
	UbD315AvL/ZnMDY2sJlaHvf2Erexi5G8rgDXKUp++UEbDMYHi1bNxNYDJU9KmyYq1tFMN2hyzQg
	OOaRhDnuoabTrZD09FxrGrZMapdZ8At/gqDkrYvWz9hw3p1ilAfYyxZZKnv1rWIcP94U69pGvfr
	AhcwgNt9rP88Pb3PB0y/k5yHw/
X-Received: by 2002:a05:6214:508e:b0:89c:5a3f:15a4 with SMTP id 6a1803df08f44-8c8fdff1f09mr13080306d6.24.1778700888816;
        Wed, 13 May 2026 12:34:48 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874e490sm4627186d6.1.2026.05.13.12.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:34:48 -0700 (PDT)
Message-Id: <19b6d94fa7ddb1d9907b36d2b6b6d6b44b089870.1778700883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
	<pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 19:34:42 +0000
Subject: [PATCH v9 4/5] branch: add branch.<name>.pruneMerged opt-out
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.pruneMerged=false exempts that branch from
--prune-merged, even with --force. Useful for keeping a topic
branch around between rounds.

Explicit deletion via 'git branch -d' is unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 +++++++
 Documentation/git-branch.adoc    |  3 ++-
 builtin/branch.c                 | 23 +++++++++++++++++++++--
 t/t3200-branch.sh                | 27 +++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..4662ef35c1 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.pruneMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --prune-merged`.
+	Useful for topic branches you intend to develop further after
+	an initial round has been merged upstream. Defaults to true.
+	Explicit deletion via `git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 375a0a68da..7435d38447 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -227,7 +227,8 @@ against whatever the remote-tracking refs say locally.
 A branch whose upstream no longer resolves locally is left alone
 (its disappearance is not, on its own, evidence that the work was
 integrated). The currently checked-out branch in any worktree is
-always preserved, as is the local branch that mirrors _<remote>_'s
+always preserved, as is any branch with `branch.<name>.pruneMerged`
+set to `false`, and the local branch that mirrors _<remote>_'s
 default branch.
 
 `-v`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 6fe2ffd7e8..bc4f4a4a18 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -835,12 +835,15 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
 		struct strbuf full = STRBUF_INIT;
+		struct strbuf key = STRBUF_INIT;
 		struct branch *branch;
 		const char *upstream;
+		int opt_out = 0;
 
 		strbuf_addf(&full, "refs/heads/%s", short_name);
 		if (branch_checked_out(full.buf)) {
 			strbuf_release(&full);
+			strbuf_release(&key);
 			continue;
 		}
 		strbuf_release(&full);
@@ -849,13 +852,29 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
 		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
 		if (!upstream ||
 		    !refs_ref_exists(get_main_ref_store(the_repository),
-				     upstream))
+				     upstream)) {
+			strbuf_release(&key);
 			continue;
+		}
 		if (string_list_has_string(&protected_default_refs, upstream)) {
 			const char *leaf = strrchr(upstream, '/');
-			if (leaf && !strcmp(leaf + 1, short_name))
+			if (leaf && !strcmp(leaf + 1, short_name)) {
+				strbuf_release(&key);
 				continue;
+			}
+		}
+
+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr, _("Skipping '%s' "
+						  "(branch.%s.pruneMerged is false)\n"),
+					short_name, short_name);
+			strbuf_release(&key);
+			continue;
 		}
+		strbuf_release(&key);
 
 		strvec_push(&deletable, short_name);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 94ea493aee..885a275e36 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1854,4 +1854,31 @@ test_expect_success '--prune-merged protects only the default branch by name, no
 	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
 '
 
+test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
+	test_when_finished "rm -rf pm-optout" &&
+	git clone pm-upstream pm-optout &&
+	git -C pm-optout branch one one-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next one &&
+	git -C pm-optout branch two two-commit &&
+	git -C pm-optout branch --set-upstream-to=origin/next two &&
+	git -C pm-optout config branch.one.pruneMerged false &&
+
+	git -C pm-optout branch --prune-merged origin 2>err &&
+
+	git -C pm-optout rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
+	test_grep "Skipping .one." err
+'
+
+test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
+	test_when_finished "rm -rf pm-optout-d" &&
+	git clone pm-upstream pm-optout-d &&
+	git -C pm-optout-d branch one one-commit &&
+	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
+	git -C pm-optout-d config branch.one.pruneMerged false &&
+
+	git -C pm-optout-d branch -d one &&
+	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
+'
+
 test_done
-- 
gitgitgadget

