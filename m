Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50F3DA7C6
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685042; cv=none; b=qHdgDtTXgsWS4FEASxPWEZpPDRH9I+k3Zo3PZfACdu/vEN3J1P4qx5v4SGcQR4L5kKPtyY8w1q+j+Q3rP3yz/svxpMPUcIJhdZYUfaNSm5QtZ74jcXPJKPAXUyTxGNP0BKzWP0UcDEJ5i7bTCwoypOLYc7JdsmxUtOzpY5PXd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685042; c=relaxed/simple;
	bh=+79MjAl3dh8tsg2lttA8lSQNTeriukWfCgMTEKtg4Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZwqRUDP8vM4tDXseInf9Z/HE6aaFOFeDfbaBltJAnSdtURbagqq8GjR6hF7xH6AsGFbZHz7C3tJEpjDyM/V9jdie/vX/Gf8caYU2ExgwTbq0mnNYfC3EAor++LVVh0r5vzeqkeZZ4mz93X4UJiT1taBVfqHJwys8VzYPS4M5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=MxbEVw6U; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="MxbEVw6U"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-80a854e5b3cso57020a34.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789685038; x=1790289838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJFu3k09NZTTPnWUN9D/naMHYE+Zx+p8+Kvp+Yeb0TU=;
        b=MxbEVw6UNAzMYsDz8N/y2gyhFgSnqcZWi6T5XAccZZxU1VN6MQZOpLx3AVIpKHacbw
         qC56ZHAjsSnh8ixqG5ujeHShdR8P+/Q1tcKxSnLYLIGltnulRnBl37VaIhkrkD0J0e5L
         +DfZLLQsUWxXApBMWzxr9E1q32wQi3TnuhD1bU5oEZw4KsHjwqE94OcpHdVbbof9/3iY
         N6gciN/svD2Rzu68g0M7wypMBZ7SRXLg3/ObfhY2PvbKF3ZrqmWG++Y6H85cDMxKftZA
         jEHGSqfMlpvpe04trQpoXQhxymjKbkdkao469NQ0WCxYdUicXwU7NR/7r2FtTze5aMTx
         Hxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685038; x=1790289838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJFu3k09NZTTPnWUN9D/naMHYE+Zx+p8+Kvp+Yeb0TU=;
        b=ANscAnozO78IEPEXM6Mg192fyl50BCfIHj02naNcmEtUNYIqYLnTYAK/gI59mZ4BC5
         NkkqCJaaXUdqg5qtPrsG1WVw5xM6CF7ryb39M2w+cV7jQCmQ95JHSlRyULQsO0PY2qCC
         ba0smk5/PmGvg3dzzqMWSk6+BALDk663DEZ72sQZwss7ET2Pa0a6X6jLw1aHlBNbdxeR
         3t7f0oleJwFYgeNx4vK4n14lsamd/cHghuGWzjNfyIzmJAEmiH8BNwHffEtjySVvHSWp
         ftUa1xVvVsjcxGs03psN8hfWYjpqCmtkpVsrLgJ5mTI8joCvErVWC5o6hGhhQ+miHLNw
         0dUQ==
X-Gm-Message-State: AFuF++kea8arXdzouzMXyoTA7zn+vCPVHJWeK2ZJCLfDdBSmfeYrTJBZ
	yTm8jD2kC8f7bW5iZtlwZRivpuhgZ8xLwApUWNu/PkZrTCRXbnHtVMgvkhm8otjC9tRU/I8Jepb
	Ww8Jyvqs=
X-Gm-Gg: AYBFou1+CXED5QLB7Og28Ig1FtXrosJ3jjvCqOlzzytMA0z67gaLTbDREmS27rtji3e
	78gGc3sboDd214ztdYYfBY4zIXbnSdsngWP/tpfmnQHO22vRAjRf5dOvOcXNBgVCHeEOCX0fyFw
	nbuyfIc/fDbIluVzIoi/URMwyvZTZOSsVz2yi1oAUx1VxRzZmbJ4i4U0aFYn0FC6Jqe/qCC7V7B
	p7Bk+DfvcJXGZrjo4+BtRsAu8yf+Fy0MB7KrJ+xxk41+TG5rsHj4ViKbtl3H/mN+A8nLBzaUd3f
	BNXQyOxrgskVyaouyqsepwlnj/SwA/rltqhquhS43O8tbuWiCyyA2myE+f0Y12HxsQqQPa0tLb1
	zuVG6C/zhqVOnxM0apVMsm7ke9jaiPDTsYlJV9X+NwWl4INiGfOiFMZDw65ujPq/zfaHmE3rbiJ
	+WGOAYFWSO6/kcYiINJUQIOA7jHlIdRvZs7XRup/yrYI8yef9YIWTbBBP3zPNtUW8ovH0eoz0=
X-Received: by 2002:a05:6830:6f84:b0:80c:d30f:978 with SMTP id 46e09a7af769-80de28e7c36mr726733a34.25.1789685038211;
        Thu, 17 Sep 2026 15:43:58 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-80c46dc0553sm4131953a34.19.2026.09.17.15.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:43:57 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 1/3] push: check pushed ref for --force-if-includes
Date: Thu, 17 Sep 2026 16:43:49 -0600
Message-ID: <20260917224351.57171-2-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917224351.57171-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260917224351.57171-1-tyler@tylercipriani.com>
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

For example, this command looks at the reflog for main vs. src, even
though src is being pushed:

    git push --force-if-includes --force-with-lease origin src:main

This can cause confusing rejections or unintended data loss.

False rejections: when src is up-to-date with the tip of origin's main,
but main is out-of-date or nonexistent, then the force-if-includes check
will fail, telling users the remote ref has been updated since the last
checkout.

Data loss: when src is an orphan/out-dated branch, but main is
up-to-date, then the force-if-includes check will allow the push,
clobbering the remote main.

Instead, use ref->peer_ref to locate a branch with a reflog. But if ref
does not resolve to a branch (e.g., a detached HEAD, a tag, an oid),
then we reject the push. The alternative would be to use HEAD's reflog,
which is too broad to tell us if the history being pushed includes the
tip of the remote. We need a per-branch reflog, which means that pushes
of a ref that do not resolve to a branch are rejected. Rejecting the
push of a ref like a detached HEAD already happens today (if the
same-named local branch lacks the remote tip); now the detached HEAD and
other non-branch pushes are explicitly rejected.

Allow deletions, e.g.:

    git push --force-if-includes --force-with-lease origin :main

A deletion has no source ref, so no branch reflog can be checked.
Existing tests already enforce that deletions should work with
force-if-includes.

ref->deletion is set after apply_push_cas (which triggers
check_if_includes_upstream). The ref->peer_ref name is "(delete)".
Instead check with is_null_oid to detect and allow deletion.

The early return when peer_ref is missing in check_if_includes_upstream
is necessary because apply_push_cas walks every advertised ref whenever
use_tracking_for_rest is set (i.e., a bare --force-with-lease), so
check_if_includes upstream is called for for refs that are not part of
the push.

Remove unnecessary check for empty return from get_local_ref, since it
never returns NULL for a non-empty name.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 remote.c            | 26 +++++++++++++--
 t/t5533-push-cas.sh | 81 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 00723b385e..887c7ec00c 100644
--- a/remote.c
+++ b/remote.c
@@ -2806,10 +2806,32 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
  */
 static void check_if_includes_upstream(struct ref *remote)
 {
-	struct ref *local = get_local_ref(remote->name);
-	if (!local)
+	struct ref *local;
+	const char *name;
+
+	/* ref without peer_ref will not be pushed */
+	if (!remote->peer_ref)
 		return;
 
+	/* A deletion has no local history to check against. */
+	if (is_null_oid(&remote->peer_ref->new_oid))
+		return;
+
+	name = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+				       remote->peer_ref->name,
+				       RESOLVE_REF_READING, NULL, NULL);
+
+	/*
+	 * if we resolve the ref to anything other than a branch,
+	 * then there is no reliable reflog to check
+	 */
+	if (!name || !starts_with(name, "refs/heads/")) {
+		remote->unreachable = 1;
+		return;
+	}
+
+	local = get_local_ref(name);
+
 	if (is_reachable_in_reflog(local->name, remote) <= 0)
 		remote->unreachable = 1;
 	free_one_ref(local);
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872d..265be6a84c 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -396,4 +396,85 @@ test_expect_success '"--force-if-includes" should allow deletes' '
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
+
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
+test_expect_success '"--force-if-includes" should reject forced update from tag' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git fetch &&
+		git switch main &&
+		git reset --hard origin/main &&
+		git switch -c newbranch origin/main &&
+		git checkout HEAD^ &&
+		git tag stable &&
+		test_must_fail git push --force-if-includes --force-with-lease origin stable:main
+	)
+'
+
 test_done
-- 
2.47.3

