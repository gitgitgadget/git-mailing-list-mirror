Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0C359703
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962420; cv=none; b=KDtz1FcqULOLFgEPjE8Yj38/ncaI1j/BNCEaMuBeuKYAELRaMhJ5X7Qdeo6kKcKGkOS1GAe6H15D48CIwMZEBx+/XYvJNCasTXJw/jQY1vok3M0J0JHmuidNBoiKlASnw4bjrCzxAcK0pnMqRu27pySP6QYnIVODYhqZwcvK/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962420; c=relaxed/simple;
	bh=n625NCxBSvY0O77b2nD0MSHwucPLpf+N6+9LF21Javs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ff3Ufos5ipUGMQNcR7vl08bEZ+CQUQrfM7GzLkYeR4pFDNbqganNlpts5JTmQ3FjQ4xkqGoXHBJMvsHFQkGSeGdRbGSG+kZ2r8Cop9QDVoXFyy9Mn30T5CVAPqDU+6xScvev/Dcu+HDx+LCE4Yq15WYeeya26WdHlsLlx/CRNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yy7bOOd5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OxRzkiqF; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yy7bOOd5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OxRzkiqF"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 964977A0178;
	Fri,  9 Jan 2026 07:40:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 07:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962418;
	 x=1768048818; bh=cqbHk6MumolgGgaUuzh1inLgGmAbFZS/8fkqzVXLnbg=; b=
	Yy7bOOd5rLLwEOZP7yMU8+TMRjqMWOfg/vNmwqntxXLhM3zIoCggDtNc/DoPLLGU
	x/MRAKUU30tw0UNJa6xURe37XxEKShOaGf/a+8D9s7fkrZJVrA4OdxaFXR+ZafKv
	3MNTtxDzADdv8uMzvMUxpBC7cpHkbg5xbKotZazzXEix16DMHJkvqgkX+/vv/VLQ
	/uolA6xqJhZnoADbbLTWffrKt7QRm7kt0LkhmyjNnN2cZN3uluZYpKSSST3rmNLB
	sWZm4+5tQTbUuQqEk4sWsSVsbZ0hzbYU3w6JS2HSrlX9XhG/Jl6Xpu2vcr43RpLW
	KaMTEX6B4fspRzLNnz55Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962418; x=
	1768048818; bh=cqbHk6MumolgGgaUuzh1inLgGmAbFZS/8fkqzVXLnbg=; b=O
	xRzkiqFCaB0loOnpEP8odGxeElQVnzzw1D9DssQj1D+CqEvAozIzObsbAff0JSZX
	/VXICZPkTomMrSUXU5fwLhXddz8ZT70bttl0mXHRin8yo3lgDWpk0GNE6NA+NsSs
	zcejm3sLhVUFf6XiItd2w6wCT5PZhfm1iG5NpYMyY5BFNA3YiCspVvEDW6cr6V1S
	5ppCv+QaLa+lF4fOJfKaCQZdcx07KUnOKnmAqNh35NbSj67bOxudprPqC0iWj/9l
	69D7yQ6n6UVFGgyAQ19K93Ri1A8SsNEeJEQUL5CAXLCUC6K17mjk4mslSTB3/I4p
	I7R2J0175SyAKM4hYohWg==
X-ME-Sender: <xms:MvdgaViZYHPNlfJ9qNYGj4-DdIWpG9stnWfACRAcRCYZwF3F-3eBMw>
    <xme:MvdgaRdS2EhJ75p6S-Td4MT1uE1MXE-kpUdHMpjmiODjyy3DXHpbYmLwOdTTFfXp8
    iXct-BSYzHx2lgJTcYhhHpfWaxULkfFsKKbvhmIXqGBXLhrpEAi4w>
X-ME-Received: <xmr:MvdgaSemjTFviuoGC0OteU58C_iiNimBuPC5zCp7KphGuuiddIKjFqqxJbkG9SZlpymQn0UCUlCX4rgv1HOJ20hm5CW9is71Fg0D5jXYbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MvdgaT9MVUM_L3SyUY3eItWbvw5xtIjgdk0dz1GpjUscLqaUc3GLeg>
    <xmx:MvdgaWmMR6Sd5l3kQTjZ5YeOry-dYXfvzH_RRPO1YcGlkzP2h6Yb-A>
    <xmx:Mvdgad-f-sPBijwxmMli1mEcxblb4wqTV70ya_9e0EY9qDO35UviEw>
    <xmx:Mvdgacl1v863fTEuxmMwPkzGBOvYhnlZIJV3C-pgcgqpcnxNh3ZWNw>
    <xmx:Mvdgac4z3XXAqowAKrJAfG4dsGsejVEoSu5vSsiYEGa_cM0Cg8mrHVwQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:40:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a9e53a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:40:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:45 +0100
Subject: [PATCH 16/17] builtin/fsck: move generic HEAD check into
 `refs_fsck()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-16-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
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
2.52.0.542.g9473a8513b.dirty

