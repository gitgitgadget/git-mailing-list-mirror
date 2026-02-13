Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B234C130
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973985; cv=none; b=dq1RxLa41ItPASubUUkIxwXuKXJJYWjnKjrCjpSp+pKZSO+Og3SMDKxEev0dfmcAJZ8YcU06D6pqY8vzFMrOhUAyhGS2zlMi9iBs5TWRRBwJAcNjYqlPIHXXgHgTVSeyFPtHpiA/QMyGDn5T+TWbjGa07V2O2FYvSn+TOXLvTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973985; c=relaxed/simple;
	bh=grIcNI3r7rmAm+8utH6q0xXuiEhKjPa9K/BIdYqDLJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhZ2o7LZXIe0vOK1z8sTYBE1DD5KnyLRxu6uiNE8qEy6YyY8bX82DDFCSd7Hd/eO8kOP2526CeJOwpIcc4AHBWkhxk4GavOGOut/UEmMyG7+J9bOlQ/y3FYMCBjx6INisqWDK2bBiWcHvQaL2UCLzT/uesC1dICu9+UJwHD3z4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O1P4ThDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rmb+ebb2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O1P4ThDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rmb+ebb2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C83F140008E;
	Fri, 13 Feb 2026 04:13:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 04:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770973983;
	 x=1771060383; bh=iTPa5/8DAiLAD2VDta6jL3HePiY6Lu2g7erMG4OdJ4w=; b=
	O1P4ThDjIxk8VVqM1huq6j43fPgajQtOo+mU0N+5PaRIjNd2onNfBwCs9fA9jwAa
	uvYL0hUE1uX0RXUC3/44TdHLmRziCy+ps9dt/eOr07YtOAxtDuB6jDZTi0IbY0KU
	9N1zpjU2dc7h1Rx8CCqQX5xnhFrpUKH3V3kT6WRF5cW43rhofkGLbYIKmAn5ugx4
	URVuefPppBrr0w8puMPyiWuwyOjRnFJoltvGRUZ5lzzxf7xxIMsYKtt0jp1dBuPS
	l5wVlbLNpfunwpuBeeWEXYNRUYdYQR2LWYttqW/ZjJdXJ2NCE27Bx/MtW/955b4v
	4xo0veUAAGhJ7w/B8zX+og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770973983; x=
	1771060383; bh=iTPa5/8DAiLAD2VDta6jL3HePiY6Lu2g7erMG4OdJ4w=; b=R
	mb+ebb2kD1FgpB62nt8DNYN4ex2d/Ab4VO8uZGW8WSYiw3w+fIZo52OY+nRAZCqx
	lAq7utS8W1uErKZOtoOW0e9IJVXTsTSHRI6zAajTEJ/UQQuaWs4DdT6M+GQeniK4
	DoSfSsRBuvnag6tDIoCbuSkng735+bzKIk1EOuREadwbyfISFYmubztgdLTPuVB9
	qYh07oC1MrARvPFfLvMIrfRAKki6QuBDonHr9InXw/KMqBULD2l7mEdKyHx6U1tl
	15YYG6FWnVslxjNUcOIGcdy27/oggklaFnIrzZ1FnK9grtz+QC7EHwsyL4/eBj/A
	c7O0riA2WvoDHBJa5Yf8w==
X-ME-Sender: <xms:H-uOaTuJ89Pl96WqqN9C2X6sb3N6ZVHpIUQeVgBrf9_ybE6vANqqbQ>
    <xme:H-uOab5nMmpViz2UT03oM5pTNvSYBu2EmMOVKNpXbVvFKvchmq-u94QwdQCyi-yNU
    tCiWpzID_wuwdLpyrVEY50KHFbbm1RNYL46SZ55DoftoBTX3GelVg>
X-ME-Received: <xmr:H-uOaULoUBxfdhNLByiQKbHAjox2JydlmTXC7DXbli_6lbaIZxVfimMyULMjiJoHIihmZnL6uZUHPJVFkYxwKza1DVY5_KoglplAgyy0ukUu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:H-uOab6zwACOHIoUqE7T2v2Wpa8FYtJ4D7dsWSXY2JSdpbzN7uQsXg>
    <xmx:H-uOaXy3ElXR4eH35HZiWrqXRPbyVxs2HIt5h6gaYICwCU8BVmy67Q>
    <xmx:H-uOafYIs8KBFCCEA-BqRVM7ca-Z0h7H69M4nzRbq9n34CUhVUAF0A>
    <xmx:H-uOaZTe4sTGp3YVrKKzdV_bMNbn_M5WHsSAinRhtqSGMe-TTah8CQ>
    <xmx:H-uOaUyDnw6F3R6sgEYaB3gtUEPqAnTp7dTX0OkBjuunB4NAErMYIEqE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 04:13:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73ea86f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 09:13:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Feb 2026 10:12:48 +0100
Subject: [PATCH v2 2/5] builtin/history: check for merges before asking for
 user input
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-b4-pks-history-dry-run-v2-2-756ac376e9e5@pks.im>
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
In-Reply-To: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.3

The replay infrastructure is not yet capable of replaying merge commits.
Unfortunately, we only notice that we're about to replay merges after we
have already asked the user for input, so any commit message that the
user may have written will be discarded in that case.

Fix this by checking whether the revwalk contains merge commits before
we ask for user input.

Adapt one of the tests that is expected to fail because of this check
to use false(1) as editor. If the editor had been executed by Git, it
would fail with the error message "Aborting commit as launching the
editor failed."

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c         | 39 +++++++++++++++++++++++++++++++++++++++
 t/t3451-history-reword.sh |  2 +-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/history.c b/builtin/history.c
index 1de51372ea..ff90e93d6e 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -177,6 +177,41 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
 	return 0;
 }
 
+static int revwalk_contains_merges(struct repository *repo,
+				   const struct strvec *revwalk_args)
+{
+	struct strvec args = STRVEC_INIT;
+	struct rev_info revs;
+	int ret;
+
+	strvec_pushv(&args, revwalk_args->v);
+	strvec_push(&args, "--min-parents=2");
+
+	repo_init_revisions(repo, &revs, NULL);
+
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (args.nr != 1)
+		BUG("revisions were set up with invalid argument");
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	if (get_revision(&revs)) {
+		ret = error(_("replaying merge commits is not supported yet!"));
+		goto out;
+	}
+
+	reset_revision_walk();
+	ret = 0;
+
+out:
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
 static int setup_revwalk(struct repository *repo,
 			 enum ref_action action,
 			 struct commit *original,
@@ -236,6 +271,10 @@ static int setup_revwalk(struct repository *repo,
 		strvec_push(&args, "HEAD");
 	}
 
+	ret = revwalk_contains_merges(repo, &args);
+	if (ret < 0)
+		goto out;
+
 	setup_revisions_from_strvec(&args, revs, NULL);
 	if (args.nr != 1)
 		BUG("revisions were set up with invalid argument");
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 6775ed62f9..12a9a7d051 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -203,7 +203,7 @@ test_expect_success 'can reword a merge commit' '
 
 		# It is not possible to replay merge commits embedded in the
 		# history (yet).
-		test_must_fail git history reword HEAD~ 2>err &&
+		test_must_fail git -c core.editor=false history reword HEAD~ 2>err &&
 		test_grep "replaying merge commits is not supported yet" err &&
 
 		# But it is possible to reword a merge commit directly.

-- 
2.53.0.352.gd1286b26eb.dirty

