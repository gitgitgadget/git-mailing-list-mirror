Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004013644C6
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113403; cv=none; b=u/SqaoIcoeG41+pd12v+V/C1X+6jaR/39ilCpFh1GAI0Wl74CFxuaYQH2ykXoZuz3jHpYBLDQHc/DZ8QWnXH4VPb3rN8LHIgQYcq5TceX87hd38ahVLTW/d6JLx6p83Z2JuRZ+CqlG0N9B3nwgASlaRrJTu06lfDVN/WwA0Nf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113403; c=relaxed/simple;
	bh=jxNTq9z3SJpq0WG8CqH0RGUQZjFC80Xbl4nyUtSHpBM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pf1RraskssLoCWQuEk77dLelwFuXC0RW5sWBtW9Y4eMZ/17YTBXlE8V67yys61UR41s0CIOD6K4V2fxSmWpTlPZ/p2PztR3Iiq7rZZBnX4p/jzEy+gZB2zY/OQe5DBy5y76o6qMDal8r9kLPymPhXOz/BmVbH6SkibUHyrFK5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8CTa/D4; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8CTa/D4"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bf854d5feso7959945eec.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113401; x=1782718201; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ztx3CW6RdIs5KUzEjPoowvDU08eUHyo/s6Tf0I35uVE=;
        b=A8CTa/D4bROcr8XMoDUOylyODEzoy9uxai43AX4Bfur0c01zqyiRurxkbx/Mjim+ga
         h0c8mGE0jPqyctzoSbs7J1xuCo90to0gJhrRZut50DtIJqQH6gYltNklaDoW6dvATiHU
         Qu187LVn9V/tpZDEjnwQA0e9oddfXKfnlrJo5MWxhiSUBQ+O/vsQuuYyn9QKejgwcWCE
         1KwNr3Sj/iesoHM8h2ROebqsAMWr5g48KlG5/0EtejlfkV9OVjFSkUVmtyaKpfUiJGbV
         VathkOuqWZfBm0AfjxymIeqqdhr9UTwEbTHU4/xfn/N20lc4U/mhizqzZTO0FB8Ifxlh
         yl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113401; x=1782718201;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ztx3CW6RdIs5KUzEjPoowvDU08eUHyo/s6Tf0I35uVE=;
        b=f8DoBOBSFkONI0mX04L2Em1oVcKzz1rW3Osf33Ys7yV18oGjEcG7/jXMVWMeloqRQZ
         TI8X0bpdzSr2grh73t862Yd8VpcnHwkIkPKFm/GrIQ/75hjB1y4XqfLCoqzJkSFHRY5V
         OaWr1pFRsQ169iA95nvnbUMe4soaj+13vgCLqFudA0XAFjntuokuN/Z/aHxrwKqcbUy0
         GyoUznP2T41yieVOpNpDUNihyzDb+zOJVg5RUeCYQSaT7fBzc+K4pnKbpbaT12DkxZv3
         5ZISBgTKFzRIcW+YW6BOGtJiKPVrjLWE2mY3oriFaT6Nt19v7DSG2hRHIpLoC4vXJVeS
         rUIw==
X-Gm-Message-State: AOJu0YwwlB/pz5z1njqlq5yqXvERFtMF1j4XJQE5wguGZsYCT9kBybAo
	A3n5zIOSpUnD2/JcD/zQrM2cQWf3ICf49Ujf+d9hL75e994NT1BmJVHrKmEIgw==
X-Gm-Gg: AfdE7clPh+3qZqJcRmYCcCi9VCbwOwpKnhlQEpc7bmXYZNEHT+ys8riFY+fZ2QvzSFr
	8dlj/RCiAZ4LKWrGutrXlmFv86HVqxpYgw0G20m8Q2gPowg+CT57qcySL5bJCRIsyGtdk3LK48f
	zBOQn9dXdPvIjvu/hei+Oo/W+qz5y3vPS+DJFXrW5Sg0+PIPTVHFWDjZR3gPFYmleCc69gW9+38
	vwo5ZT6MW5H2wMTsE2x95DV9CDcDWQcMVaTjUp0TLD4n+FcDK4rO5K0a02irsEHcWrVMlzRqtFD
	TSKGytLikPSHz3qBl3dCCsX3xzEPwPRGsRdJ8aZH4SvimPS7z2X1vVHDf/G5mptUFkxYDx9ZoaJ
	gMhDNlrPGx+CN3lV8v9DySdC6xbTWeWIVXxRgQSDnCb2gFovY/0vob8/yeUQhrUPxigChTYhLOg
	wJIONyTcwVxjEHV7lNhw==
X-Received: by 2002:a05:7300:fd05:b0:304:59cc:aee8 with SMTP id 5a478bee46e88-30c0711f7f7mr9568122eec.18.1782113401021;
        Mon, 22 Jun 2026 00:30:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be3c3f9sm8546528eec.24.2026.06.22.00.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:30:00 -0700 (PDT)
Message-Id: <27903fbb1d4f76da74cc55369b176ffca89f9b28.1782113388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
	<pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 07:29:47 +0000
Subject: [PATCH v17 6/7] branch: add branch.<name>.deleteMerged opt-out
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.deleteMerged=false exempts that branch from
"git branch --delete-merged", which is useful for a topic you want
to keep developing after an early round of it has been merged
upstream. Unless --quiet is given, each skip is reported so the
user knows why their topic was kept.

Explicit deletion with "git branch -d" still uses the normal merge
check and ignores this setting.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 +++++++
 Documentation/git-branch.adoc    |  5 +++--
 builtin/branch.c                 | 15 +++++++++++++++
 t/t3200-branch.sh                | 26 ++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..d8483acb4f 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.deleteMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --delete-merged`.  Useful for a topic branch you
+	intend to develop further after an initial round has been
+	merged upstream.  Defaults to true.  Explicit deletion via
+	`git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 56ff889447..59ea3f471a 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -215,10 +215,11 @@ A branch is not deleted when:
 +
 --
 * its upstream remote-tracking branch no longer exists,
-* it is checked out in any worktree, or
+* it is checked out in any worktree,
 * its push destination (`<branch>@{push}`) equals its upstream
   (`<branch>@{upstream}`), so it cannot be distinguished from a
-  branch that just looks "fully merged" right after a pull.
+  branch that just looks "fully merged" right after a pull, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 A branch whose work has not yet been merged into its upstream is
diff --git a/builtin/branch.c b/builtin/branch.c
index 35fd3e9efc..5ea610efa1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -758,6 +758,8 @@ static int delete_merged_branches(int argc, const char **argv,
 	struct ref_array candidates = { 0 };
 	struct strset deletable = STRSET_INIT;
 	struct strvec to_delete = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
+	bool quiet = flags & DELETE_BRANCH_QUIET;
 	int i, ret = 0;
 
 	if (!argc)
@@ -775,6 +777,7 @@ static int delete_merged_branches(int argc, const char **argv,
 		const char *short_name;
 		struct branch *branch;
 		const char *upstream, *push;
+		int opt_out;
 
 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
 			BUG("filter returned non-branch ref '%s'", full_name);
@@ -793,6 +796,17 @@ static int delete_merged_branches(int argc, const char **argv,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+					short_name, short_name);
+			continue;
+		}
+
 		strset_add(&deletable, short_name);
 	}
 
@@ -814,6 +828,7 @@ static int delete_merged_branches(int argc, const char **argv,
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
 				      flags);
 
+	strbuf_release(&key);
 	strvec_clear(&to_delete);
 	strset_clear(&deletable);
 	ref_array_clear(&candidates);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1d372f95e8..b80d558b4a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1990,4 +1990,30 @@ test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch
 	test_cmp expect actual
 '
 
+test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch deleted origin/next &&
+	merged_branch kept origin/next &&
+	git -C repo config branch.kept.deleteMerged false &&
+	git -C repo checkout --detach &&
+
+	git -C repo branch --delete-merged origin/next 2>err &&
+
+	test_grep "Skipping .kept." err &&
+	test_must_fail git -C repo rev-parse --verify refs/heads/deleted &&
+	git -C repo rev-parse --verify refs/heads/kept
+'
+
+test_expect_success "branch -d still deletes a deleteMerged=false branch" '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch kept origin/next &&
+	git -C repo config branch.kept.deleteMerged false &&
+	git -C repo checkout --detach &&
+
+	git -C repo branch -d kept &&
+	test_must_fail git -C repo rev-parse --verify refs/heads/kept
+'
+
 test_done
-- 
gitgitgadget

