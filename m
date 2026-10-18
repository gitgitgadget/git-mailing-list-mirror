Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F935FF6E
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355623; cv=none; b=j+UFCtQo65HsjzDNwJkjeGa3UVTXVNHDBcO7WM+lscVF1h0q7Z5ecCNceJ50N6JvORMYl0uyjQGEtsl7jMThDPmgr8VX2J1lJNeJIeJHh6FRogPxQv/FhmYy1kuDT/xJxVMtvINt44FtQd9Cq+yqBWxBbQnp4WUwnUhY6ZspRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355623; c=relaxed/simple;
	bh=4R4RfmUoU8K9ivIGWcL7WcyzvmrY4SAvFmnPprNryGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0Zk3qSI9Sg01ya5VtnKGooxX0C/FEoVgNWE4xcRvlWqxGxR+6zTPNL6p8mmrN9zo+qiPz5dQ68hZFEdlsmm5gBWytkfljhFisFY54eqHDXrthcps3IGVhVfPP/HD3+am8JFaCltjz1UgO0pT5kRTms6ZCv78oNsg061ThzgP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=hLr+7QfC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="hLr+7QfC"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8470d7d430fso369527a34.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792355620; x=1792960420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1c3lfBMrPFDS0+ppOZ2yAubyN50lMfX7Q/QL36h79g=;
        b=hLr+7QfCSoddLQ2MwbtR1vC+7xfYYHQRuAqebwjw7GlUbEqSQwr2DW/vcbZxjmx8hZ
         j2JM2O2LcAFuCTQFRKs6/a/OgMjPxrBjWbzYZwmNrPEIzHKZYY1jmG4OvG6e90yJb3vP
         yRv6OE7TQDffHUk8+vUA96DUT0NbHQ2kTbpnxyKJbmt34qOyBdyb2E3mQJWiMY8TIUwA
         BrQXzAa3fC1SkuAV+Qfp5wpJhGWK8MovZMHXqqN3J1CeXTxTLhf+NbtTS7JnJluolviW
         nHCLaxmrqvriCkZk3qSyjk3jEQrR5onGJ/+ewNjf4dU6AGgTvbPvGddeiSDqiBL4cJ8f
         x1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355620; x=1792960420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r1c3lfBMrPFDS0+ppOZ2yAubyN50lMfX7Q/QL36h79g=;
        b=kvtzhvSUh/i0fFtLv9qSUpxGqiVN36AT/X1KAkYygcu2zO0vAWWi4RxN6JQ3uFz2Ke
         is7eAYOnhziXFd0xiF14luSvM0jlqziBV8mNftHfh1Npln9X8AsX6x1Z1e9xKfNcT1az
         QGMRcz8lVLAplBWueB61SjYkcA1gNuy7sf7QpQ9zGn+G09+FYqkkoQ5M0FWip7VnzIuJ
         mldFYxxU1kjMyscdXyTy524xP17un9Z53WXCxAFtmySZiLU0Dm9om0w9+22Bei8/YqcP
         /NqXV+7CH+1UhLziawlR0tZG/ioM1cbOmC0v2R2VsuTbxGq+YeE+bzUM/FyZZA1SZiSj
         CQjg==
X-Gm-Message-State: AFq9FYJO71vE1z824+ivSexyoTtw9aRR3VyNAy5dkwwNw7qHEzvYGJM4
	vtHHm1OfCwSbg8x4gudKaKZeJguglI0dbrT7/XJhCX2KXEgZ+t1H/P6HgzYlnYl4P98pg/cFN4J
	VxB0A
X-Gm-Gg: AYBFou28xm/O82fIbKZedXTHztG3h73TJRuIh+78chzWk6MRvFj6og0r29xOsIc8m0z
	XFRVAkLH9mV4n+Cn8j0zJFAhAzJdsdnDvM20/MEMBhNKYCrXXciyceWdvxSez6IjGhzsuBqpr+2
	VxqxGFMDz45DJBXDaCqyNYxGIwp+1IgwY3Yxi+4bGx+eHYcKK2tnb4sE/p3+t7eGXU96ffSV8eM
	zIl6QiuAQRulfG16WDU9PIrKfD5JrOZ2dyLms/uBNU4WILmLuEXmnLLFYtW0bd2VE6dDpvwZDVe
	tBKhNbS32K+27fNmQnVViyiO9cFDXb0zsBBZ1Pka+SirVXHpM63qWfovidV0CSYYowOU2i3EdPu
	pZRMzPq/JyJjnMjzi3wihnJXo5G//Ts4hJdPDFkBkjMiSThOloyOiOwVd58SCZq88nvKxo+cfwy
	ec8ItMHagRxYRYuch5k7vXhdvuSc9bJ81e2RH+KCYmGFgGbyNRaJc+SGhQUpUwUFsX1rKUTx0Q
X-Received: by 2002:a05:6830:911:b0:835:63b5:8b7b with SMTP id 46e09a7af769-844fe39ff7emr6087798a34.10.1792355620449;
        Sun, 18 Oct 2026 13:33:40 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-843d83aaa5dsm6447994a34.21.2026.10.18.13.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:33:39 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v7 1/3] push: check pushed ref for --force-if-includes
Date: Sun, 18 Oct 2026 14:32:52 -0600
Message-ID: <20261018203255.2343005-2-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018203255.2343005-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20261018203255.2343005-1-tyler@tylercipriani.com>
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
check_if_includes upstream is called for refs that are not part of the
push.

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
index fe62068463..7cd7b0d6d4 100644
--- a/remote.c
+++ b/remote.c
@@ -2899,10 +2899,32 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
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
index 2e14aecaa2..febf16fa7c 100755
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

