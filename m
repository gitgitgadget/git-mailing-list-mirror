Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939943290BA
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954128; cv=none; b=oNbS+2ncapSP1gWw01YJiw1JAlDIHUMvb/e/I0D5nUfhr4a4BfKN32PecyNetaBGkRNza/HBHcWB2OJpocNDQf8mTKqD+ZVu/udTdsS79rmSVVxGAnqx5hPBMKvaLwzr3QhYko49Xlow/4ESkahrgEcQ93VFGl2tPOEE5+cUGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954128; c=relaxed/simple;
	bh=YhRhn4Trr/hi1hj+92/UF8C6yr62yKHwnRLbCDeeip8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMoRKy/Ok6V4AxdzbhQw+1etgp6yFzpCt5TthuLe2vJofYm3nLD5eeRMOYjApg7OFzGoutFr3Rxwns3At8IXhZU5DjeR5PKXIG1kaCJp/MpkmXd2C+jMtHbxyQZP21OMmDfmJ7In1TrcXxmEuyvORr13LyMwuCL6DLQrXdLQ64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HkGuHrO1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rd3JaTFR; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HkGuHrO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rd3JaTFR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E4F407A012E;
	Thu, 23 Apr 2026 10:22:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 10:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776954124;
	 x=1777040524; bh=j9UsOfXrTzVw987oNc70OWncxfblN1mg8LBq5oYnL/0=; b=
	HkGuHrO1xfqHTgkd0LOMsr+ipnxpD4bkBaO9TJSlLFSu0IdP57G6eoKXwGTn01EB
	EGDPz+YvHFNvYyDIS1rmYYgAdvSJR8CQE+XZkIhC8kxgxKzUnTQo/k+CGdjzOCTt
	cmSuAAKNH8IEXgAve7XansV7mxTJpCv5l/L4K0ZCb/K3l1yMysKjlEEZlg9UOKFQ
	jOpm7Bn+2lZhGKI0P46lsbXpTu5RczBnU3Vwu0fHjkuLAqXrmEFBuQUF6q4D5KDS
	kYo+glY4hFUCsltTTfGgorsJKRvKTJETzOOqj4eLe0TDmENmqGT5gYvR2KKHXBVF
	aa01UH8AomyS7wwihVGrQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776954124; x=
	1777040524; bh=j9UsOfXrTzVw987oNc70OWncxfblN1mg8LBq5oYnL/0=; b=r
	d3JaTFRNdDQ6ZL7RenlR6KfWjjZN0mm1EQpu71Utn17HlTMG88ip8ahqKVAelel7
	rQ2K0Vc9BYoe7poCJDkaHLvsBh8eU1DCPtQtypPc3d3M17fxjCwj5nWAwyJ+ZqBR
	KJXFOmUlwwCvHZ8lwzDUBmMFs/FMmVGywDt+AklyCmr8EPONxrSAqCamglOheZnI
	EnsqX8o7tL5P95r2SwpAK5sA+eMeKeAJH4vK2TQjLZjih58WrsIZOy8vCJ/MGBMm
	VmoK1B3GZY1ry/nhVhs0Otk5w+pRlhyzyjV2rc1xlqwuE5wMPEhFEby1igGAxLRH
	4hcxO18EgMyoCkJNlecgg==
X-ME-Sender: <xms:DCvqadTrcT8QOD7hAyX_tjGDsgBmS3Rh70vMyDK3blQQ1eMhB1z4Yg>
    <xme:DCvqadyhAAB9HufQXR1_f7TFzb1rizyppO17znIpLmaUljt7HvA8h6xOZfwMwe1nj
    OJib6d4o-WiatoP-xo471__Frf7X_7Gsns3cnDaR8sMBasntmojrA>
X-ME-Received: <xmr:DCvqaX2gav5jgGa9aQXWmFnm51eCKGSxmYlee2lRF8KAII2uS_Tp9VUm4DDJ8Ik5-RdaFQIATdmE_jYV6IcwQuDFg2tcqzWLPb_kgqdq06rq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DCvqaT6x8lHChdhPgjagEzpWnG2IVq0Dzv4aMLPOHumwijFaS5Xhnw>
    <xmx:DCvqaSVh_MX9OppolScm_qD_qVTG9urMVO1TEt0-5kdjNhGPEWx8MQ>
    <xmx:DCvqaaDobv4Gevzz3l8GvVr5BAqr6hyv8KC3dPCngbUbN_OpKDFZcw>
    <xmx:DCvqaZ7fo7WfI6w7WA3zFTAdLcS_WagD-SNtZE3MCNgj5oNA69GxFQ>
    <xmx:DCvqaYxMkJfbIsjdZ89tZe2D1W1LSJiMKKhQnZKvuBL1SmvtgdwVk1oj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 10:22:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09a4a547 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 14:22:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Apr 2026 16:21:56 +0200
Subject: [PATCH v2 1/3] replay: allow callers to control what happens with
 empty commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-b4-pks-history-fixup-v2-1-d7571c6d36eb@pks.im>
References: <20260423-b4-pks-history-fixup-v2-0-d7571c6d36eb@pks.im>
In-Reply-To: <20260423-b4-pks-history-fixup-v2-0-d7571c6d36eb@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

When replaying commits it may happen that some of the commits become
empty relative to their parent. Such commits are for now automatically
dropped by the replay subsystem without much control from the user.

Introduce a new enum that allows the caller to drop, keep or abort in
this case.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replay.c | 29 ++++++++++++++++++++++++-----
 replay.h | 19 +++++++++++++++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/replay.c b/replay.c
index f96f1f6551..4ef8abb607 100644
--- a/replay.c
+++ b/replay.c
@@ -269,7 +269,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct commit *onto,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
-					  enum replay_mode mode)
+					  enum replay_mode mode,
+					  enum replay_empty_commit_action empty)
 {
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
@@ -321,12 +322,25 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	}
 	merge_opt->ancestor = NULL;
 	merge_opt->branch2 = NULL;
+
 	if (!result->clean)
 		return NULL;
-	/* Drop commits that become empty */
+
+	/* Handle commits that become empty */
 	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
-	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
-		return replayed_base;
+	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid)) {
+		switch (empty) {
+		case REPLAY_EMPTY_COMMIT_DROP:
+			return replayed_base;
+		case REPLAY_EMPTY_COMMIT_KEEP:
+			break;
+		case REPLAY_EMPTY_COMMIT_ABORT:
+			result->clean = error(_("commit %s became empty after replay"),
+					      oid_to_hex(&pickme->object.oid));
+			return NULL;
+		}
+	}
+
 	return create_commit(repo, result->tree, pickme, replayed_base, mode);
 }
 
@@ -417,7 +431,7 @@ int replay_revisions(struct rev_info *revs,
 
 		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
 						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
-						  &merge_opt, &result, mode);
+						  &merge_opt, &result, mode, opts->empty);
 		if (!last_commit)
 			break;
 
@@ -458,6 +472,11 @@ int replay_revisions(struct rev_info *revs,
 		}
 	}
 
+	if (result.clean < 0) {
+		ret = -1;
+		goto out;
+	}
+
 	if (!result.clean) {
 		ret = 1;
 		goto out;
diff --git a/replay.h b/replay.h
index 0ab74b9805..1851a07705 100644
--- a/replay.h
+++ b/replay.h
@@ -6,6 +6,19 @@
 struct repository;
 struct rev_info;
 
+/*
+ * Controls what happens when a replayed commit becomes empty (i.e. its tree
+ * is identical to its parent's tree after the replay).
+ */
+enum replay_empty_commit_action {
+	/* Silently discard the empty commit. */
+	REPLAY_EMPTY_COMMIT_DROP,
+	/* Keep the empty commit as-is. */
+	REPLAY_EMPTY_COMMIT_KEEP,
+	/* Abort with an error. */
+	REPLAY_EMPTY_COMMIT_ABORT,
+};
+
 /*
  * A set of options that can be passed to `replay_revisions()`.
  */
@@ -43,6 +56,12 @@ struct replay_revisions_options {
 	 * Requires `onto` to be set.
 	 */
 	int contained;
+
+	/*
+	 * Controls what to do when a replayed commit becomes empty.
+	 * Defaults to REPLAY_EMPTY_COMMIT_DROP.
+	 */
+	enum replay_empty_commit_action empty;
 };
 
 /* This struct is used as an out-parameter by `replay_revisions()`. */

-- 
2.54.0.545.g6539524ca2.dirty

