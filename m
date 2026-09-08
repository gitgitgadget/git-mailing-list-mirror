Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF43B8D40
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906107; cv=none; b=GcFx3gzkb20+eZ3UNCqNdX8mREz8SWmeyuofWLn0Yp1w/+p3xVkgfnpGcPZeGo5EGDJwicFryQjSzpbJ8ix0bL6QhQlP9KBjCUP8GzUiUFcaTjZI6BKTnOBFbfFcwDt+seHtG9XIRJsafDg0mDhfBBXuNXl1+90YfBYFInje3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906107; c=relaxed/simple;
	bh=JAK1KJ2EO5uTwkTOdE6SXW7IOZK2eEoxdvPC6aNEGK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCdCmNwmydKRMCnyXhC3VXWJmHoe/UzoKofn9IG2dkGOjQRCuQDRf7hdM1k2zlKZ4XfN9Y37/DmNfd40ChZOPg3pZJpzbAXrlcOhW0n3qpXNctvNszfDSduHSRe5VAq11c/Wf1AKhjpwSqzZu9J8oHIijF0q0UJW46veQQX/fmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=Raz/2pc9; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="Raz/2pc9"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6bd209cf210so595300eaf.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1788906103; x=1789510903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMYUJbFne3wQhfHUL6gkFO8KML9lM8fTbwc2s4nzOhU=;
        b=Raz/2pc92x5jub5o6Vs2FAE7VeYTdmlYQro2May3S+35KvqhUE2a/Vrg67s1f2SUy3
         uc/kJzLQE9r5XGcA2F5YmpwLrCMCho8tOnjasqy6wdkp0uoU5GWIYn4XHrNWckTm02v4
         YDKWhC0q4OcIDD3K9cX+4WK80EkEcMARH84HgW3LLo/1jT5Uq2V+ZAvX99ey7ip1s3EK
         nBu2kX6OQKwQMyC7kr/Yg0B/DYboNCtgi9RiQ2TUWMbeJsNJC2JBYJTkurOoY3AlRxEW
         2hryo6H2oASSGokKAzUP7JxX9UYA5/fbUJmB1dL8Ccr0XbdJ7ZvOEWvYqnKC20yK1pBL
         hS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906103; x=1789510903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMYUJbFne3wQhfHUL6gkFO8KML9lM8fTbwc2s4nzOhU=;
        b=HOdlX3Z+cazGUmLTgPDX6MFgy52WEB4pbtqtdmbkyfa1P1Ett8ORtsIYJJySh1XtUJ
         bkSrMXRgrfu6TEUtnhwVxYzI5vcyzogQEzUIsURXnFCNyaDkDd7s2GlNfgnErUMxL4N1
         jKu2Sp9fhmMPCxll6ZLSCfidmeMaYGDS++xZ2oT7UF4nvBfQbQYr2k7f1BHg8NsSfIxx
         lBy6CUqHB3mCTgpniyoYknT8+YqZCH4ksqCbmRwbILmNCgLwObfTNOpRw0hltUQHH5Pc
         dU9cweWy9QuUHK5le7+zqa37YnjHQzJaysf5aOokObY0nB3oclAXcfADMkd69goBw7nF
         aVOw==
X-Gm-Message-State: AFuF++nemxZy4qL+efodjpL2dGIVih5IJxUA14/Q+Nd42e6tQS5B4BRN
	mFvNElgpAGcQ0QoIVrvloXVOM6EYdBRfvG+Fc6rJmG/Wl6eT82/WKAsoz/CNKPIaASuQ/nMYb5/
	ZGBwmsCc=
X-Gm-Gg: AYBFou2qRnCPjVFpxkV4SEamFr2Pt17nBikKnPtv6VD/mlCTEMDVr6hssTPlop6Kehr
	9oXQEet2ik1wbspKzTAi5L/s5TGQQyeABp1tktRfiLcp833diIhsA5Uu3AAzHx8yfR4HJpNMDoO
	pBZeJx2iN736nUgqxDoYrwFl958ndvRTyqSF2tND8shZnPKWtwId8s7zpUDXocpG31k+zbT3bY+
	o7jyv49hfKKixp6d1C+kARodfKDySZ7FtJXkY1bqw0EMCX9RF4V9gxtZvp/GzrzZLf/3Q66WWkV
	v5Vb0gO84WxMHcFZgW08UgKw6sSz4HZX2QVZFkgQ85B0cQYjG6GRdU9W4nATe4ymLBi1pw8M5vu
	ggMvW39qiz+bVbLK50hsd4yr6SYEyMyGJHCkw5+hAX9/b5X8sVnx+Bm0ofiI1GkLbWNJxvnfYDm
	1KNqWi+1iyycRBIE2xnD9XWA+nB6sqfeu+PeXNiH/BYQ2SajUNXhZKBuitcK/8
X-Received: by 2002:a05:6820:16a4:b0:6b3:6236:6fa with SMTP id 006d021491bc7-6b6fc9d063fmr16086542eaf.21.1788906103309;
        Tue, 08 Sep 2026 15:21:43 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7f9f72d3c8asm15976862a34.21.2026.09.08.15.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:21:42 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH v2 1/2] push: check pushed ref for --force-if-includes
Date: Tue,  8 Sep 2026 16:20:55 -0600
Message-ID: <20260908222056.1150748-2-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904210122.431757-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
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

