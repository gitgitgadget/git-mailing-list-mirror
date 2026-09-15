Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C04D5A1
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515220; cv=none; b=sG1qm5CFYfV+x6X19JcdxrYLYSObd6aNbRf4CQK1AwMvfUDUuVlnvRw5Jr0kd6/m1sEmXKY3z6+Fzyz4YfQVFe9Apxyn/bieeC4P6NRHqDitz2gWpN+EFe+/8oPWFTosOlsjT31XqZOixIdxEK+vNbLJNv1ogeJEcYBC30qBElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515220; c=relaxed/simple;
	bh=+79MjAl3dh8tsg2lttA8lSQNTeriukWfCgMTEKtg4Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmwEqdLficqVJ49X6uF5DitSUutaavGA951ZH2fclzW6Zql9/G2zDUcDBT9aRQems9gkujZPvrmw4Y8FxHV7dOLUI2Iotc6ageqi9fywRiKzzu9R965DcFAbNctgvas1/5QJgqKOtwP6TL0pZf4XVvwVkyiYc0LCDsirpEZh5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=N9/DqXVz; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="N9/DqXVz"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0dd550aso90505a34.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789515218; x=1790120018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJFu3k09NZTTPnWUN9D/naMHYE+Zx+p8+Kvp+Yeb0TU=;
        b=N9/DqXVzjXhlI9wGWCwAxtG9m3lzNx8ggE+jpQtATGk0wqNvP6Echy+jaq+x2zzdlC
         DNw1rUuKiggJp5V1Zl+9J57zTXnq7Vphi3Ib+dHD/qX72buwXjA1PqSWS8kziFdZt0uR
         9qo1HZ3dEF3Zcz6WqrZV+aR/LJXyhEhgUT3K9ipcRWcoEbGe0QXXVvjFdXtH8IoTU2fW
         XFEUgjOkMF2Ky9s8gcRFAdGnGfwOxokHWe+16wqJfBX1lZfE8LqJwPApGHC7MgsMWdbJ
         wCUU90Xy1gDT10PZfyHFY/s3aGLt0hfTjo+kwsTiGXaE4UWnkj/lUha/eFJTDfjgqTbF
         jcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515218; x=1790120018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJFu3k09NZTTPnWUN9D/naMHYE+Zx+p8+Kvp+Yeb0TU=;
        b=LoQ6zOJQvleTwDv/YU736L3OXtynRK0YSDmrBDTTHmvft7tWNqkjAVvT31AE/nt3VO
         qyYMG7xj4k0PD8mVBrcaI6LSg1vgfBte4hQTugs/q6z4vbV0HwnP77/a18uQIzGcHg8L
         ORe570R9qshye+5xxV4IQAjO1BjF4dm1hOVI9Zi4QZ2UJVDl/7PaWAS2td5dyi8cbXqO
         r6Ff50e2kEp+7agwoedRRBrE8iaegVj5CCWA8leFbW52Y7ap4rtt3xuF3iv1xQbApUgf
         wkYceOrQIvklcAhcAgXNm4cqOv+2iHybZIqkpapcL/H5/vqIkEU0+uBsV3Fbx8ktFudl
         q1eQ==
X-Gm-Message-State: AFuF++k+rw7YVFwmpp9vJXO2zROPGghgTG5wCP27qRK6fpi6czFms5RK
	n2zNaSkGrHcJt5ttNknOu54hojZBCrqdKgyVgUSpU2C/5PXz5VwBWR9ouSDUfBxtBbwMmbEnHth
	LU+BVW9Q=
X-Gm-Gg: AYBFou1YPhSe4KmWK9+9OpeBl/LtiSIOb/WjXjgjnbKkSSwIkw8IK5NSJUwTmsAwnn0
	XhSaF6McUuLKKu4AdpXpcvP/J1CyeJGZonyBHM1TXBHkVhgUoyVzJhlJBtSWBPgRDhccaWGSOaB
	0e8YkSWS/x5R0XQ/arWHTPHTk7mYE9ZmM4v4h02bTn/aAb4oICg5vIloQ0emNnQFbj3hfd5aj0V
	EE+Bdi04GPE2apysZ6wyMzUzPdUYujwK3aiKYy9SQlLKG1tvR6pK7LWni2QddyZkdMLlnIHEGBO
	mSkWkU8KhxKt6mhiwqGlJjfUhSuUyeiEMIeOZhFZKJp388E/J0Nv8KwYzFY9BzM67lc65qwSEQH
	TRI0pSpdFoq5RaO1hkoSjvqoJ6fhigJ5ybO9x5+F4gwsYNUI5TXTPZP1IiYb5mSc6uj60ym+iQf
	IBKqyxFnj74PCQkshq3Y3vn2QpX2fB4/dXLF0btTHKFfcV7jjGib1yd53OfNFkYBqxXgPFObA=
X-Received: by 2002:a05:6808:5094:b0:4c3:7695:d76 with SMTP id 5614622812f47-4ca497b023emr762073b6e.6.1789515217706;
        Tue, 15 Sep 2026 16:33:37 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4ca242e7034sm880010b6e.15.2026.09.15.16.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:33:37 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/3] push: check pushed ref for --force-if-includes
Date: Tue, 15 Sep 2026 17:33:03 -0600
Message-ID: <20260915233305.334115-2-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915233305.334115-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260915233305.334115-1-tyler@tylercipriani.com>
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

