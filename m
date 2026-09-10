Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A87E0E4
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081538; cv=none; b=Dl8wiQb4rOdRz328IMHIgnFEs/5uVJCFd8gqRoqYL9aJXkPuLixIuWJT8XpoWieXDpAZEJujVpX0R5McylosbeSawbwcvF9Gip4hMyrpzBbxF87l+dXp/jcWc35hFq4uChlKv3vQ5A4BUceTaF9GppAy2PC2PEX6UsaAj+YE5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081538; c=relaxed/simple;
	bh=JAK1KJ2EO5uTwkTOdE6SXW7IOZK2eEoxdvPC6aNEGK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnupR8KiKmNC9/ZjYdVMG5WN1rmFRwBthij1Lhf9x6in4NjQnlMokuI+eqzJESpPwnldZLF92pfJNeeWdOWcCex3eN44m1JrmHS+6q9dhpHRMEimxXk/QhzHn76nnTM4bs57RffxacdAvU3df8WUorO7YmHEwCnQf+d8/N2SXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=KPwQA8Oi; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="KPwQA8Oi"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0cfb33cso230830a34.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789081536; x=1789686336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMYUJbFne3wQhfHUL6gkFO8KML9lM8fTbwc2s4nzOhU=;
        b=KPwQA8OiXtpYpUJXEh8+Bo5s76VIA1jCIlP51HG6Znsg2/+eQnG657fEuPnMGW5+9d
         cRm5xh9kGnjmmu1iZRy1EPXAXZQtTMhC98weN36Jhxm7fg6bKO9udYJNdzWhyvI/Z+ai
         NRluiMDCXIR6cU/CgV5cQ25sZlXQIeaHPnFE1nDm/ymHlv0+UR2+mwmYN0C9pCvn3hSz
         Kjb/fz10h2GX0041HwVElHP2WXGxpjjMnS6ghnwXa742OL8vTMn4HkujqCTGvG+k+9W2
         81aDawInpOY521dfs/sg6fEg0Gq0JfhizkLuG4cXvNxm7hPTaFAzl8aTKkhgzI2UzIY8
         iE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789081536; x=1789686336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMYUJbFne3wQhfHUL6gkFO8KML9lM8fTbwc2s4nzOhU=;
        b=o1/mgF3Xo8vHAc04ovPsv5ydsIf9VaROPP4b/rwTj549RlIzt6ySNONTa6YhtFBP10
         TMfLABtUSM8Dog+msMhsiyEKP6D8KsDvcWg7U7BfOK8O+nyeYikN9qhd4jrGvmUxBjv9
         nq5j9ERBGHzHPJAjxaOgnY9G9jNH7mnjQiIchjYX+1GI9krX16JD04bve2vIsexB8SSl
         I8EWr+YHMj/cROgY3b0CMTskxQoDxy6qisUmp9Sxzf5+dASzL7QjxlANjAeS8fsfWDSy
         /YazY/VYxPLU4lc9zf+mrv9e/8KDixoBHUk5HDBBWlXdrdhjDNPpxyUyXnE4MyIeu/8H
         sCAQ==
X-Gm-Message-State: AFuF++kpQSWN4I0gSF10fRS7JglnIAFNiBv3ULzeeUcn81+2l8oJg/hX
	v7icJORqs4G8zXkvLL9i/yTfRDmUCMrWz1wupqhUwN2a4xf5PGEIS1S5SaUop+zDuShvXwtSGS+
	pnv0Htzc=
X-Gm-Gg: AYBFou3wNZ0WqcPiGEmoDWRuzERvifDddszFNLoi9QiPNp65JFVvbzqDwRh5B6Zg1gr
	Dp1MDFPc1V3jfn1V7nDJhLDpMBdSP/aRKu3X2i9Zn8b15l1K+Dpzk9M9dCu7QMEPtzxmpIeu2oU
	CB+WG72h1IT78YhW8frKZW5eCWCeFLjZmmROBgbL6DtsgfACx4pYgMrvL+eKdn2XNmQ4N0LDAya
	u8UWlEHdoIb99rC9KnbaawBpHLqvkbPGfsI6PxqZUgiQ1m6MMWKd/x+uC85GP6/+u6/Q4jOgV39
	EdY47D4Xcgmsg3+hGMX9TIeo9VuQsdZUd58wZhXnPHr92+YQ/cgk20eQM5n5upiZW/kWEsG++QX
	LMbRc3b5Y0AuPj4S5Exe63r/pvSFKeLeni6Ut1Qmx24fVlgFr78f4lGtarW+UltLA/v9Z+U85jK
	JLXIsdcQyJ0+LzlNoK37srYQaV0dliN0dzUByGy4QzSwQNiZ+4tIUXnnh9V7gxiuVFCqcpOUg=
X-Received: by 2002:a05:6830:4129:b0:7f8:4ebe:2854 with SMTP id 46e09a7af769-803fe7f9e26mr1744033a34.4.1789081535804;
        Thu, 10 Sep 2026 16:05:35 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-803f66fda4esm912019a34.16.2026.09.10.16.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:05:35 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH v3 1/2] push: check pushed ref for --force-if-includes
Date: Thu, 10 Sep 2026 17:05:05 -0600
Message-ID: <20260910230506.1631656-2-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910230506.1631656-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260910230506.1631656-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"--force-if-includes" ensures, "tip of the remote-tracking ref is
reachable from one of the 'reflog' entries of the local branch."

But check_if_includes_upstream() uses the local per-branch reflog based
on the destination branch rather than the branch being pushed; using
ref->name vs. ref->peer_ref->name.

This can cause confusing rejections or unintended data loss.

Using a command like:

    git push --force-if-includes --force-with-lease origin src:main

False rejections: when src is an up-to-date branch, but main is
out-of-date or nonexistent, then the includes check will fail telling
users the remote ref has been updated since the last checkout.

Data loss: when src is an orphan/out-dated branch, but main is
up-to-date, then the if-includes check will allow the push, clobbering
the remote main.

Find local reflog using ref->peer_ref. When using a refspec like
HEAD:refs/heads/main, we resolve HEAD. If HEAD is a branch, use that
branch's reflog.

But if HEAD does not resolve to a branch (i.e. a detached HEAD), then we
reject the push. HEAD's reflog is too broad to tell us if the history
being pushed includes the tip of the remote. Rejecting a detached HEAD
already happens today (if the same-named local branch lacks the remote
tip); now the detached HEAD state is explicitly rejected.

Skip deletions:

    git push --force-if-includes --force-with-lease origin :main

ref->deletion is set after apply_push_cas (which triggers
check_if_includes_upstream). The ref->peer_ref name is "(delete)".
Instead check with is_null_oid to detect and allow deletion.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 remote.c            | 24 ++++++++++++++++-
 t/t5533-push-cas.sh | 65 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 00723b385e..326af76eeb 100644
--- a/remote.c
+++ b/remote.c
@@ -2806,7 +2806,29 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
  */
 static void check_if_includes_upstream(struct ref *remote)
 {
-	struct ref *local = get_local_ref(remote->name);
+	struct ref *local;
+	const char *name;
+	int flag;
+
+	if (!remote->peer_ref)
+		return;
+
+	/* A deletion has no local history to check against. */
+	if (is_null_oid(&remote->peer_ref->new_oid))
+		return;
+
+	name = remote->peer_ref->name;
+	if (!strcmp(name, "HEAD")) {
+		name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					       "HEAD", 0, NULL, &flag);
+		if (!name || !(flag & REF_ISSYMREF)) {
+			/* detached HEAD: no per-branch reflog to consult */
+			remote->unreachable = 1;
+			return;
+		}
+	}
+
+	local = get_local_ref(name);
 	if (!local)
 		return;
 
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872d..0c02151747 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -396,4 +396,69 @@ test_expect_success '"--force-if-includes" should allow deletes' '
 	)
 '
 
+test_expect_success '"--force-if-includes" should allow forced update when using differently named branches' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch -c newbranch origin/main &&
+		git rebase HEAD --onto HEAD^ &&
+		git push --force-if-includes --force-with-lease origin newbranch:main
+	)
+'
+test_expect_success '"--force-if-includes" should allow forced update from HEAD' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch -c newbranch origin/main &&
+		git rebase HEAD --onto HEAD^ &&
+		git push --force-if-includes --force-with-lease origin HEAD:main
+	)
+'
+
+test_expect_success '"--force-if-includes" should reject forced update from differently named branches when local lacks remote ref' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		git switch --orphan orphan &&
+		test_commit I &&
+		test_must_fail git push --force-with-lease --force-if-includes origin orphan:main
+	)
+'
+
+test_expect_success '"--force-if-includes" should reject forced update from HEAD when it lacks remote ref' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		git switch --orphan orphan &&
+		test_commit I &&
+		test_must_fail git push --force-with-lease --force-if-includes origin HEAD:main
+	)
+'
+
+test_expect_success '"--force-if-includes" should reject forced update from detached HEAD' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		git switch -c newbranch origin/main &&
+		git checkout HEAD^ &&
+		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main
+	)
+'
+
 test_done
-- 
2.47.3

