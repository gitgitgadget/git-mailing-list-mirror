Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C035CB78
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962417; cv=none; b=UuC3uN+zcjjelty84K+CE/BF41aRNNYubVTwW9PGceLlRAGoQyJUSP/R0GK4daPotfpq+7RIiz6u+vqQBhEfkoXrdqh/r1f3Wzn8iooinsz6dzwOqFcbLUzg149D5NViwziP0SsDarZ521GXxVqyX8s5JVkh0/cv51DK7b6OD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962417; c=relaxed/simple;
	bh=9HFPi1p+Q44nFkx3BTQcRC3/w4K91lrZapN/20khMIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtA8FQX8E4FN9sHfu9t+GGtftXP+vu8tdeyb5znOg71vnBkKyrKPfb+xZju2XNWwv2wiiTy8E4OIs37lCxdB1wqqaVignjkL08rMA+/+ctFUEvPkmTjZlu7b0elgt9sNI2laG8xooHtt+fRhyBHC6EVgQw837lufMAk6e0TtmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FcdxIo7y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5lPB5ZS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FcdxIo7y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5lPB5ZS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E84C7A0176;
	Fri,  9 Jan 2026 07:40:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 09 Jan 2026 07:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962415;
	 x=1768048815; bh=+zF++aywY8FW6U3fetqpni5ik7ZacquEzKBSwajoVfk=; b=
	FcdxIo7y/O16za4CLmgSTeZ1g93e49cZ6z51vXiEIKhk57JJhbaJUg8uWdIxMdyA
	a+LbHAhu0S+MxtULzMUGzFCMsLn0pmVtR3OiN6cUqFYSQiZ9QQZVPi/3pQ0F97Z/
	HMZYRKvDb8j7ZUel81ghJXZWSrbUMGsEgLBJaNZs4eWOgDld1aTmQRDwqH953UyD
	I2l47ePCUbgt8/N1EK640dX6abtmfAG3ZJFtr8kicTmy997ZZGzlLkxmAavEQi9V
	1Mb98dXKzaFQ5Ttf1B4YqA5ecoucmhfXXkQcI4q3aGsy0pnl8BvUIfw8jsKXjbU2
	+iJ11qAETGwU6cU52LbV+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962415; x=
	1768048815; bh=+zF++aywY8FW6U3fetqpni5ik7ZacquEzKBSwajoVfk=; b=S
	5lPB5ZS9dUxYpMKt3CqpPiiVqPo6tAvMWKyDCFAIvDZUV1JMZuJA+LkPd+zaBN4H
	q/1fRdCbMq3bY2LhhBIb+zXVfZ498/3Emr1W7ewMViPPBAU9iR4ThCqlgXMFign+
	UvWrxFe6QB5oK/6PXLXCJRnZ7rCh4eucJzoeR3uaYX+37hbQ3dhxOLPmpLHSKGI2
	58yPS7JR8jj8lCygcUMBjAv99xUJM7FshPMNRI/PkFjVRo/j6RAkoDTs320jS00P
	HjikO06W3A+RKj0gdLI4lo+5qinJFcbxizKaU1yoDeQRj4s3eNc0rkXbRDRbwt6P
	330whA+gkPcSqL1rh56mg==
X-ME-Sender: <xms:L_dgaU9-jx8by-mAWrZo2vClnrzOQX14Z4WXc8TiGozYzEBUVda9Dw>
    <xme:L_dgaUK5OQBtVjvBRUFUhGWUzbgzdwRQOPpoSX1b2TpxGEyX-pVNmEE4FcF03n-BK
    5nB8ZHCaRY6zNlAcJgR53VkE5ST0mhX3Xt0J4FHELT8zzSLtYU>
X-ME-Received: <xmr:L_dgaXY1Wy5xUb-b5pk74rbJ4xoNJznawEJjg9k5p9POzdWLRnwLJM1GtQWxbnyRyccAlrk53PXv4iZXZSie5JlOWs7C2yN21ov07JwZ9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:L_dgaeJKcDS5suy5LzLB01Q__aWRb21c0QQgTB65419azzlhB8SHSg>
    <xmx:L_dgadBp0KXPe7V8y9Cp3ItW52GeKeokG3w-rqktswUodvwsWM_Ecg>
    <xmx:L_dgabpuH898texLGedcDRmePyAfz9LAsAb1mNeL4CpoQdbSqVGlRg>
    <xmx:L_dgaQhLKDtY7DQDcnCXbBRNErPz7UPp50Fq9WVQXrWlaSXsfldCNQ>
    <xmx:L_dgaanVoy2r_2Yj58HQ6TGMT5YWGz8KPC2e8Qkuu6JTGFndl3v7XD6U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:40:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7264ae9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:40:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:44 +0100
Subject: [PATCH 15/17] builtin/fsck: move generic object ID checks into
 `refs_fsck()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-15-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
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
2.52.0.542.g9473a8513b.dirty

