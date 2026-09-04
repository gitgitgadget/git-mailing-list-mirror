Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97052D2B9
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555713; cv=none; b=Xsl/P8ZCXXOKSvRQQ5Z0D0qy8642dI3yJ+xAIrPJFd4QEWQpWnHE78ZpLzyjM0YblMTFkABzIWBq8aaAvKdtjsslycZtM51pwI1EAG1pfRHpQSG5VZVZdkg3e4eaBmjPrql3d73aKMFY4YGExsHJ4R/6keL5OZKUBTPYXGI1Jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555713; c=relaxed/simple;
	bh=u7Pz6rPpHQZh5/YTyQP/ynx+FRqxpG7sRgUbfYtMlcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0VEw1cVlHzuuAlXouF6G28SHwJzUGNFk49HTOEExIUGvkSgoyGG3/GTx3w2c/cXvKBYyt0rkEtrlAtciG/9lFCBrzEJj4RHGayWmf30XrIqnjIUcZUZtb+XWxjtCM5YvjutthsXDIzzv00H8s1BJoN3XbHn84xCPxhsO9l2ue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=rZkooM5W; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="rZkooM5W"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4a4cb36ae00so1334959b6e.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1788555706; x=1789160506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQZ+8dTK5QPvxaIyq4YYDNwPFbBi3jO/bI+NYoCUWlg=;
        b=rZkooM5Wm4S/cqoZCTBiHKHHW7jVDVMs9icbY7ChXCQWUfWM2PIJklKpLkcdutPHQh
         jfZyW7Ppt25ov7CyXLxN2zIlBh+5clvHnoyp/BHHt8tbgbhrcnbsQ9p47xCmI73XZ0k1
         76uxK0keRhkE8oejwLVQXm5oL9vdlaO5Uz5qwIGgELhEQTRv4Utwa+HwTcyAHb3u1bfc
         Hwn/te9R3ell8zmgJMGtje0WcHTdlJhlg/bfMxraFQff+spLpJg9ZtYcO0/ezZIC4nsG
         f7wx89HXHYNLVjkAF5JEHSClML3oVH7PtjT++78SVIewlTmN+8gSqScXujedpK0myyGH
         Vy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788555706; x=1789160506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQZ+8dTK5QPvxaIyq4YYDNwPFbBi3jO/bI+NYoCUWlg=;
        b=ReSIiqHGtUO2VVceIbYeDOyaeyyXebT11SCCqPlclBYfLiLlRER24cdkiS6XSN0/ek
         LSrWEXR9GnlWntHV84P0YOt8mAWZVxcJ+Fi2Kqp4zImjBUgHlLUIekkzm8CKfN8OnlIS
         iM/Y5bpU4vdOHhiQj6miSR+HF0B1mSJvmausEIaLTOuVcZSzAWDeu/fKiyGAyrf7VujF
         ZPLJa5PQ1e+A+Ok0kZGYj3AFbscKr0AbbAzdpR92JliqJfqasAFLbFbksSgfUZtZ48iz
         14PV7GhM76M0AoXX506geSD3WzqSYwRH65QTMrf+oUDBO3nhr9WPViCexfHKc18oUoBt
         LWJA==
X-Gm-Message-State: AFuF++mp9OhbxZzbS3dg2c0tKT3FoH+t49iQRjS9296DHDv7Bxe+YaTH
	BcXDPXB2K169YVdTHCAR1W5rHPORdWISkNoekfgtnDNUqh8k2W8S5ZjHq88x0T96ANw8ZA0F/tL
	dZfDCIm6C3lcz
X-Gm-Gg: AYBFou1o77HbB3Ivro7x6LsHUvEfIi86vsA9OrQYACrf+/D129PdEiKlreuFNNlHbWN
	xPX0VgRvkZ0TlnaahUVyFtA9GoCuVDAsetYnbzJgiO0Y0G9Vt1LXri0b1cB8XHOQ0v4pqardKnq
	wXi2xYjDi0/UQ44JmLb3VSGGeCrbcA6+Lrc7+UmvIeTGzarq3SyKf4LhgjImsnqAL3B0DhWLhxW
	QrByvfvLDvcWNkaKJFDI8pBMgkX3LGQv82qsecPE+nk8wswz6p41NBYb6SLgrWWWMjO9ruD13Yd
	erjlQdFbKppbqZlsol5eYvfV7hNGsy83WbEolM4jKXpiGN2V7CXzrYuKWP6/3LI4JLPo+evMYNh
	b99bfo/VpCTshQfwqJu2CIcM9DQPTWI46mIVdm/6WEw2bVJjxs6bMQedMjvva4Nf4mS5iSU/wzv
	8svopAUcqio0J5Ag01rBYApT2+BA8jO3XmvDckwaYPR+yXKBzadadplYaZb+t3
X-Received: by 2002:a05:6808:c2a8:b0:4b9:a829:f015 with SMTP id 5614622812f47-4b9a829f8d7mr4691845b6e.33.1788555705922;
        Fri, 04 Sep 2026 14:01:45 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4b971aa12cesm3468693b6e.16.2026.09.04.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:01:45 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH 1/2] push: check pushed ref for --force-if-includes
Date: Fri,  4 Sep 2026 15:01:21 -0600
Message-ID: <20260904210122.431757-2-tyler@tylercipriani.com>
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
HEAD:refs/heads/main, we resolve HEAD to a branch and use that reflog.
In a detached HEAD state, the reflog cannot tell us if the history
being pushed includes the tip of the remote, so the push is rejected.

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

