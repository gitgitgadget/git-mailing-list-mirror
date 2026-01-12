Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40827348456
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208622; cv=none; b=qDbeU2IbZFfaeRqZdMUegeqe4u/alLNaCku0sYbizbMOvRUPa75yzV/BdVcGV55z2RSoGihqXj1n4KcWzGYJvvlU1VQU1sJhYsnk9Wwkmun29fmZI8WNQdOrV0HlZxgz0PObLTigftvY3Lt2NKSeL3DUKhiMSnfB+0Q+kuiHBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208622; c=relaxed/simple;
	bh=m454/5OY3+26E4vGAnXIcPp8JUAsGUq8R0RemS/jqj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZmOhk7hSuetnix15MiQitoxCPpLxOG0EDlpIxnQkdui9d+shxnM3a1pnjaHnUglxHfykzfEA6bYQqTm0ZVEuBg/y/wYa69xADehCKn9x4a4AtaCZsTqaXL9U4U6kHU5uA5PSzZV190x1GfIm8bHQ4S8U432d8OaPgfx95idtg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MWo9tWCZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8LtKGOZ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MWo9tWCZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8LtKGOZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 43E871D00011;
	Mon, 12 Jan 2026 04:03:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 12 Jan 2026 04:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208619;
	 x=1768295019; bh=P1I3LBAOTQruFpIjQSvuybY1OXcVHIcTHbmwfoeB6QM=; b=
	MWo9tWCZs42+WA04Xy+ZnWCSh6SL6gELqb+HXqkTpZFuF7e8DO3+G4kHP+b7Pg8y
	o51aqgNZdPsRIFe+TH/P8MUUVf/Z53/SCJwxFIv+iZG6zwQwPuwuUMdhjR8q62RW
	v/jjJciR8s7QEJrFtPsu2AlliCzYeOiNCTUuKRibzTeq+MbwUki2k13xvnGqJ4fn
	iosfAalJv8gzMonhk3zhtLtUQ9H7sy9HLE7B8NIzZ1KekkhG12lQvYy0tcqH0MaU
	XChn0H4f2Y9GfokkoJTc2k+QivJXw1/h63O+z9xHKlW6lnOrWLBRzanUriWWjb75
	gLLu9egHZbXtBPbAkgMjuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208619; x=
	1768295019; bh=P1I3LBAOTQruFpIjQSvuybY1OXcVHIcTHbmwfoeB6QM=; b=X
	8LtKGOZeimHoxurmcBvRmkS29tUHEh810mna3K8s9dk27Vmy3gcNc2f6hhSSuSBl
	psnyDpR9YQR7BzkcLqdZLKYZRqqcWVanosBA/wbCn59iEZpIRzzbli3XExCmM0FP
	/Zv1pRxkkPDS0GckQPH7GN6gDSnkBNxKJDCKesEZZ8ddzvS2GUAiiajowwmgIBc2
	ztaaeHnBqfZDNlhMVKGwPeDYXonzGPqtjdBn9MJkb6dt0aLZi/g7xLvLQqHPMbYS
	FQlRF16TOu43XzlDQZwskg3I6eAgQKRDjiFVQeeg1lhWwHISfJ6J0tx/hJfadyeN
	I+closV2GFOtzy+tccV7g==
X-ME-Sender: <xms:67hkaZmms9aEdgg8dR7iE1HLpRSO5LhCCJtcoKNHa_BCEWG8LAis2Q>
    <xme:67hkacRcCceBwuzGxp_NkGRBWc_V55A0ZrRStsiOcU7c2bqCauX6d4HJLIKxQJAHi
    G5m2lbNILPRqqIAy4dcHXos0djR2Wc2HKDbZLSwJ9-300pJldbYtQ>
X-ME-Received: <xmr:67hkadCfgtlygzaaMwGDclDVEGPmeC4MT5ooocre9Yq-qYdraBIHdTgJSkOulyBCoxM7z_z3SkRY5eyeIvRoGFFFAR1p5HbdllaSoGzxlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:67hkaTRvvZTZdl-u3rvlQsw0Q-1h9jqtJRiwz3HoHZi9CmRWsRI3-Q>
    <xmx:67hkabqM4oyqxTWO-0Njtl0SVZw8A3b_29xg8otNqOXr-Xde6u_5OQ>
    <xmx:67hkaVyI7pj_pWZLupg7gMERCq8YrBoS4K6kGTAXe-jpLj6ncHAbVw>
    <xmx:67hkaQLBtVaqsLgoxvZorWfL45mnkkKEecIB8_fz3xF4-GcppGOoEQ>
    <xmx:67hkaUthsh5AY762ORSqubR-fDbFalDNRRYTIHVnxDcmMP3oIFRLvwHr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 624668dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:03:05 +0100
Subject: [PATCH v2 16/17] builtin/fsck: move generic HEAD check into
 `refs_fsck()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-16-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Move the check that detects "HEAD" refs that do not point at a branch
into `refs_fsck()`. This follows the same motivation as the preceding
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/fsck-msgids.adoc |  3 +++
 builtin/fsck.c                 |  7 -------
 fsck.h                         |  1 +
 refs.c                         | 12 +++++++++++-
 t/t0602-reffiles-fsck.sh       |  8 ++++----
 t/t1450-fsck.sh                |  4 ++--
 6 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 76609321f6..6a4db3a991 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -13,6 +13,9 @@
 `badGpgsig`::
 	(ERROR) A tag contains a bad (truncated) signature (e.g., `gpgsig`) header.
 
+`badHeadTarget`::
+	(ERROR) The `HEAD` ref is a symref that does not refer to a branch.
+
 `badHeaderContinuation`::
 	(ERROR) A continuation header (such as for `gpgsig`) is unexpectedly truncated.
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4dd4d74d1e..5dda441f45 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -728,13 +728,6 @@ static void fsck_head_link(const char *head_ref_name,
 		error(_("invalid %s"), head_ref_name);
 		return;
 	}
-	if (strcmp(*head_points_at, head_ref_name) &&
-	    !starts_with(*head_points_at, "refs/heads/")) {
-		errors_found |= ERROR_REFS;
-		error(_("%s points to something strange (%s)"),
-		      head_ref_name, *head_points_at);
-		return;
-	}
 
 	return;
 }
diff --git a/fsck.h b/fsck.h
index 1f472b7daa..65ecbb7fe1 100644
--- a/fsck.h
+++ b/fsck.h
@@ -30,6 +30,7 @@ enum fsck_msg_type {
 	FUNC(BAD_DATE_OVERFLOW, ERROR) \
 	FUNC(BAD_EMAIL, ERROR) \
 	FUNC(BAD_GPGSIG, ERROR) \
+	FUNC(BAD_HEAD_TARGET, ERROR) \
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
diff --git a/refs.c b/refs.c
index c3528862c6..a772d371cd 100644
--- a/refs.c
+++ b/refs.c
@@ -334,8 +334,18 @@ int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o,
 
 int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
 		     struct fsck_ref_report *report,
-		     const char *refname UNUSED, const char *target)
+		     const char *refname, const char *target)
 {
+	const char *stripped_refname;
+
+	parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
+
+	if (!strcmp(stripped_refname, "HEAD") &&
+	    !starts_with(target, "refs/heads/") &&
+	    fsck_report_ref(o, report, FSCK_MSG_BAD_HEAD_TARGET,
+			    "HEAD points to non-branch '%s'", target))
+		return -1;
+
 	if (is_root_ref(target))
 		return 0;
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 479f3d528e..3c1f553b81 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -910,10 +910,10 @@ test_expect_success 'complains about broken root ref' '
 	git init repo &&
 	(
 		cd repo &&
-		echo "ref: refs/../HEAD" >.git/HEAD &&
+		echo "ref: refs/heads/../HEAD" >.git/HEAD &&
 		test_must_fail git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: HEAD: badReferentName: points to invalid refname ${SQ}refs/../HEAD${SQ}
+		error: HEAD: badReferentName: points to invalid refname ${SQ}refs/heads/../HEAD${SQ}
 		EOF
 		test_cmp expect err
 	)
@@ -926,10 +926,10 @@ test_expect_success 'complains about broken root ref in worktree' '
 		cd repo &&
 		test_commit initial &&
 		git worktree add ../worktree &&
-		echo "ref: refs/../HEAD" >.git/worktrees/worktree/HEAD &&
+		echo "ref: refs/heads/../HEAD" >.git/worktrees/worktree/HEAD &&
 		test_must_fail git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: worktrees/worktree/HEAD: badReferentName: points to invalid refname ${SQ}refs/../HEAD${SQ}
+		error: worktrees/worktree/HEAD: badReferentName: points to invalid refname ${SQ}refs/heads/../HEAD${SQ}
 		EOF
 		test_cmp expect err
 	)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 900c1b2eb2..3fae05f9d9 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -113,7 +113,7 @@ test_expect_success 'HEAD link pointing at a funny place' '
 	test-tool ref-store main create-symref HEAD refs/funny/place &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=.git git fsck 2>out &&
-	test_grep "HEAD points to something strange" out
+	test_grep "HEAD: badHeadTarget: HEAD points to non-branch ${SQ}refs/funny/place${SQ}" out
 '
 
 test_expect_success REFFILES 'HEAD link pointing at a funny object (from different wt)' '
@@ -148,7 +148,7 @@ test_expect_success 'other worktree HEAD link pointing at a funny place' '
 	git worktree add other &&
 	git -C other symbolic-ref HEAD refs/funny/place &&
 	test_must_fail git fsck 2>out &&
-	test_grep "worktrees/other/HEAD points to something strange" out
+	test_grep "worktrees/other/HEAD: badHeadTarget: HEAD points to non-branch ${SQ}refs/funny/place${SQ}" out
 '
 
 test_expect_success 'commit with multiple signatures is okay' '

-- 
2.52.0.590.g1f87b77810.dirty

