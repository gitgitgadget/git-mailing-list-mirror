Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7B347FE7
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208618; cv=none; b=HLBWQBN5S29yKw91PXiMOcHtQbsvVZo01elwQfONHRubgWRsjjTmuUyrapG5WbaM0RjUlGGQbdiuBAc6XpZHWYqG8FYP1st1pUr+gX0YGwnkosT5QHfNIOD96/mWoSV91Aqyx5jDTdJXZWsdmp7loJWJ07YcJa/7GcV7oXv6NaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208618; c=relaxed/simple;
	bh=sbro+vk9TzE9/+vOfa141OLqia38039KzX7HHgaD84c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrtCAZUFRR6YBDfiuDEA37BMg9rP1DDJUfuW+5FJ5iRuk84pYmXMIL3pFa+LQ4b4FlW3+TrEeaaRm8MWIPn8ZjGT7WvLdXp4Rj+lGscApsXB0LRwRt7voY902oaWwiEGBMrDgMbH1Y6qdJPjJ1LYsrFy4f3PNLxPrVDUcwggDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H4gGjEYQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwbHX/hd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H4gGjEYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwbHX/hd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 180B77A00AE;
	Mon, 12 Jan 2026 04:03:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 04:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208615;
	 x=1768295015; bh=PmPFp2qUVCchndD1L/AjyCG6JnSU45L7HZVCdG0FAA0=; b=
	H4gGjEYQxDbcRp1GrunQ4TFjtHkKfFC0HAWaHGBexTl9jZDRvFquxdGtdU37y1pD
	nb2Ni5KbEvbqPXJ3xqN+ZAj0179/z+CRG0Zbplf4JWaLcwvHzMP7cbapPnbYvjd6
	K8z6cG9ToBfQNwSePs9BPtIHOLpelAnw8sWFKmewQjZMuM5SIRr1qObm91qChJwk
	TcoKSDXk5H9qs4sEWiReMKOzkNMlX5xoDcbUUcJPiYHSBulYZCHyxsUn77jqbi38
	PtsVdx57sRfHqbKu7IpVRgxzqposW/VN8RLGyqwGoZ52tukAYyACoeeFuc+7w76v
	mOfxMyUhiyP84b6Z6xVfrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208615; x=
	1768295015; bh=PmPFp2qUVCchndD1L/AjyCG6JnSU45L7HZVCdG0FAA0=; b=M
	wbHX/hd8HUjULH8OjH1ACXCRXq4MaQvwlfrDk3U3a8wD9Ch+DxH95e9dn2Rvh3Rc
	Tmq5Tl4PnDb35577uOE70RxRWpKj2p+XMqoW4ao5bCs4whTyddXS44L/6nvOASar
	ptI2uJQtaYqMgkuJKLc1nuxLkV+nIe67wUZijM0oyYKGnZA9ClmEkgdVN3Xi5rYh
	WE07kd9ril9HQ96ou601EwwOrtZtDvUru5ax/WpFpmMqJ0K/OTFxJnCazeInUrRV
	xZ9jlcRCSb5/+Oab+VVGUZ4QXNcHeBgGUfbOzQTIifoMkiq7xeAXmH8WpNwqDaf+
	Q72M4b2YXGmKu9/FCagXg==
X-ME-Sender: <xms:57hkafQuwjp0_EB3Y3mw_UJ4nSYHKMnqde7Np1qLxo1AGhVZ6oAwgw>
    <xme:57hkaYMtnw1SH0hmgtmWPWUN9fwqkB4J3hsSiUZFWVH-c53YbxVwTDEJVsiCvQTqy
    2zhMH_cZ2ZMR7vPkPNwV_AQhbnjXzOa9GIMCKtWp_MSitLwM9s2Mg>
X-ME-Received: <xmr:57hkaSMb7JIRXQgZYnCpa01n32AJt30yLHATs7OkKa-0PKmMqNrxSdOvQIb9EXwHzCZI3jS06ZHruZJGh1onjmsIBGzFu7XEJ69AIfu8hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:57hkaYuD9_U7np7Vemc7FLldanOdeSThY-UhTaLfYDtpfhNbc4HOAQ>
    <xmx:57hkacVfF1Nl8F76A4ODsAU_O3MGydkZOeDHBTz_6qRWMiO4LmMgUw>
    <xmx:57hkaQtGLIubF9ts1y5rfaIzYHcLbkF9DyJeBmRBkTD1n_tRqWTCmg>
    <xmx:57hkaYW-vpJk4LbvC6d73xaawM6vdaxgH8b06PhHFj2gbQ4UogNrVA>
    <xmx:57hkafrl3nMeSl7lc8kEH5jHW6xFbiC5jJizF5yDPEc0yw6sgOnKsJfk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e441a64e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:03:04 +0100
Subject: [PATCH v2 15/17] builtin/fsck: move generic object ID checks into
 `refs_fsck()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-15-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

While most of the logic that verifies the consistency of refs is
driven by `refs_fsck()`, we still have a small handful of checks in
`fsck_head_link()`. These checks don't use the git-fsck(1) reporting
infrastructure, and as such it's impossible to for example disable
some of those checks.

One such check detects refs that point to the all-zeroes object ID.
Extract this check into the generic `refs_fsck_ref()` function that is
used by both the "files" and "reftable" backends.

Note that this will cause us to not return an error code from
`fsck_head_link()` anymore in case this error was detected. This is fine
though: the only caller of this function does not check the error code
anyway. To demonstrate this, adapt the function to drop its return value
altogether. The function will be removed in a subsequent commit anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/fsck-msgids.adoc |  3 +++
 builtin/fsck.c                 | 41 +++++++++++++++--------------------------
 fsck.h                         |  1 +
 refs.c                         | 11 ++++++++---
 t/t1450-fsck.sh                |  6 +++---
 5 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index acac9683af..76609321f6 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -41,6 +41,9 @@
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
+`badRefOid`::
+	(ERROR) A ref points to an invalid object ID.
+
 `badReferentName`::
 	(ERROR) The referent name of a symref is invalid.
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4979bc795e..4dd4d74d1e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -564,9 +564,9 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 	return 0;
 }
 
-static int fsck_head_link(const char *head_ref_name,
-			  const char **head_points_at,
-			  struct object_id *head_oid);
+static void fsck_head_link(const char *head_ref_name,
+			   const char **head_points_at,
+			   struct object_id *head_oid);
 
 static void get_default_heads(void)
 {
@@ -713,12 +713,10 @@ static void fsck_source(struct odb_source *source)
 	stop_progress(&progress);
 }
 
-static int fsck_head_link(const char *head_ref_name,
-			  const char **head_points_at,
-			  struct object_id *head_oid)
+static void fsck_head_link(const char *head_ref_name,
+			   const char **head_points_at,
+			   struct object_id *head_oid)
 {
-	int null_is_error = 0;
-
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s link"), head_ref_name);
 
@@ -727,27 +725,18 @@ static int fsck_head_link(const char *head_ref_name,
 						  NULL);
 	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
-		return error(_("invalid %s"), head_ref_name);
+		error(_("invalid %s"), head_ref_name);
+		return;
 	}
-	if (!strcmp(*head_points_at, head_ref_name))
-		/* detached HEAD */
-		null_is_error = 1;
-	else if (!starts_with(*head_points_at, "refs/heads/")) {
+	if (strcmp(*head_points_at, head_ref_name) &&
+	    !starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
-		return error(_("%s points to something strange (%s)"),
-			     head_ref_name, *head_points_at);
-	}
-	if (is_null_oid(head_oid)) {
-		if (null_is_error) {
-			errors_found |= ERROR_REFS;
-			return error(_("%s: detached HEAD points at nothing"),
-				     head_ref_name);
-		}
-		fprintf_ln(stderr,
-			   _("notice: %s points to an unborn branch (%s)"),
-			   head_ref_name, *head_points_at + 11);
+		error(_("%s points to something strange (%s)"),
+		      head_ref_name, *head_points_at);
+		return;
 	}
-	return 0;
+
+	return;
 }
 
 static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
diff --git a/fsck.h b/fsck.h
index bfe0d9c6d2..1f472b7daa 100644
--- a/fsck.h
+++ b/fsck.h
@@ -39,6 +39,7 @@ enum fsck_msg_type {
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_REF_OID, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs.c b/refs.c
index 4fc1317cb3..c3528862c6 100644
--- a/refs.c
+++ b/refs.c
@@ -320,10 +320,15 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
-int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o UNUSED,
-		  struct fsck_ref_report *report UNUSED,
-		  const char *refname UNUSED, const struct object_id *oid UNUSED)
+int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o,
+		  struct fsck_ref_report *report,
+		  const char *refname UNUSED, const struct object_id *oid)
 {
+	if (is_null_oid(oid))
+		return fsck_report_ref(o, report, FSCK_MSG_BAD_REF_OID,
+				       "points to invalid object ID '%s'",
+				       oid_to_hex(oid));
+
 	return 0;
 }
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index c4b651c2dc..900c1b2eb2 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -105,7 +105,7 @@ test_expect_success REFFILES 'HEAD link pointing at a funny object' '
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=.git git fsck 2>out &&
-	test_grep "detached HEAD points" out
+	test_grep "HEAD: badRefOid: points to invalid object ID ${SQ}$ZERO_OID${SQ}" out
 '
 
 test_expect_success 'HEAD link pointing at a funny place' '
@@ -123,7 +123,7 @@ test_expect_success REFFILES 'HEAD link pointing at a funny object (from differe
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail git -C wt fsck 2>out &&
-	test_grep "main-worktree/HEAD: detached HEAD points" out
+	test_grep "HEAD: badRefOid: points to invalid object ID ${SQ}$ZERO_OID${SQ}" out
 '
 
 test_expect_success REFFILES 'other worktree HEAD link pointing at a funny object' '
@@ -131,7 +131,7 @@ test_expect_success REFFILES 'other worktree HEAD link pointing at a funny objec
 	git worktree add other &&
 	echo $ZERO_OID >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	test_grep "worktrees/other/HEAD: detached HEAD points" out
+	test_grep "worktrees/other/HEAD: badRefOid: points to invalid object ID ${SQ}$ZERO_OID${SQ}" out
 '
 
 test_expect_success 'other worktree HEAD link pointing at missing object' '

-- 
2.52.0.590.g1f87b77810.dirty

