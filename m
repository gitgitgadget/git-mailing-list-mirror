Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861E29898B
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269243; cv=none; b=cX+fuV0jGkSj+IIK1n7NK/52BVpG2qJh67E6kt/5x55C0q1urMbEIF/aX1Tt8K0Dy25pnLa1zJau5u88483IFVJ0UEwUfuYTjyaE5RO8uXKpEgSIWZLB7BRTm7MNSVk8yiqk3DbOtlUyIQemnPZrqwYJWVlVBZOo0qs4wu7J6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269243; c=relaxed/simple;
	bh=YhRhn4Trr/hi1hj+92/UF8C6yr62yKHwnRLbCDeeip8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqSJPsnoOlvy5mgY/AnvYqcsU5sVG5AmLQ/QG1On9U442RaY7VckvAWY8VsOJUvvOTPKWW3qA3CQPkdu27T2isBkIIX0b1Snc8YGamWrjISxpSnCeBqj3+acO+1suZrizAnhAls9CwWdTjuQXdbsKF21k9AjFxV1PNFd4ajvYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M9P/9Ozo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SfjFpAe2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M9P/9Ozo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SfjFpAe2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2517114000BB;
	Mon, 27 Apr 2026 01:54:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 01:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777269241;
	 x=1777355641; bh=j9UsOfXrTzVw987oNc70OWncxfblN1mg8LBq5oYnL/0=; b=
	M9P/9OzoEgyO7LRChAm9prgHwPl4nfe4tbIlnnskXU2ZkSfhGneh60BjCA31T7My
	IIOIAPaHYibsnTL9KNqajfvkOOCNcU0uZc/n3mkfBQ73dPao7liyTMdvgPO5ktGJ
	DL2IbWFdownREwBa8TO12IStpL9n0MsjnZ3lynViBNgvsTHOne+IMWjT/7ofHoGx
	CHNKZJUnVZmK0O5uIdNubDqHPe8xmXVBG0EYDVw23CwZoOIHXDM9hX91fAY0OrC1
	EhuADHehopLHhtnnrjM7x3z+Y2zRh2KdJUo/DlbnTsOTrd6glyRZm3UUuTauoAj2
	Z7Fj5a4HMfsdO1Ub0agmPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777269241; x=
	1777355641; bh=j9UsOfXrTzVw987oNc70OWncxfblN1mg8LBq5oYnL/0=; b=S
	fjFpAe2Rz+SQ6HRwhEtDduFKaHsbnibOo9pqRRl56n4j88Uhg2CtzZZP4Ted3NB/
	CQaUEaLSoU/8pkbBAfHwrIOfjUUx0p9zJGfNI0HwILaOjcbF5OvDgsVsRjUut5yM
	gYqJeZbahM8H3EDq+R7hZbErd2553+uCCe2IAJpteripyD4137hXtzY+AQPL34WH
	2MLnLjAGon0vcdshHgADf+jYZY+URz/AjRd3imwnSosEpmhz4/7YhjfLPH1QJJ1X
	OgXK/9g664Ks8vsXWWHAwi8IC5lt+S9ZrK9D0z8nQEAzulXDg+WtLvZ1YOzshnqg
	CE9nH6NeydeCbYHfxoV2Q==
X-ME-Sender: <xms:-fnuaXwBeqx_dBHB_xeszklY33QUrqEE93y2DeGT025sh7GbychAKw>
    <xme:-fnuaWTKxlYdkVfMWMgXR3lFWRBk_GchOsewXAk5taYPAOffxaefPKUAjgMrgPdJc
    mkLEq_YTdsbWvPsdmOVJmQKV5CIbmnxP6ps_H3BQybgeaUyfaKRfg>
X-ME-Received: <xmr:-fnuaWUSlEakt7eV_XRJpPRd5pjB1Wa8I97f90Z09te3mV_wlnTiBUJoyAsxwr9yCiu7d2czpphn9V5o_4_MeDeq3W4TX6X3eYGxIAHMng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejjeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrthesmhgrlhhonh
    druggvvhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-fnuaQahznl3bQ_EO6GsUhAA1i_1zofUELdpZj-UEtt_DXDAn0dOeQ>
    <xmx:-fnuaU0pb9TfZUZXTNjf_GTR6Dn-fqE5VxDTCt8Nhj5C3IXI04gvGQ>
    <xmx:-fnuaagRAnpzcJiymCplhOU7cb-6eqaOZqRAqjqyGWnRinZRJeZKCA>
    <xmx:-fnuaQaIiU03Ce0T3MTENeuDMR0V3Ie3rZWT0w8GdP5OX4-4FVuclg>
    <xmx:-fnuabRZ4nUeHVEgX4fdK_FQ47VWQETgV8JpLn8QCeS1ukCc394MKQpJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 01:54:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e393e151 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Apr 2026 05:53:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Apr 2026 07:53:51 +0200
Subject: [PATCH v3 1/3] replay: allow callers to control what happens with
 empty commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-b4-pks-history-fixup-v3-1-cb908f06264b@pks.im>
References: <20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im>
In-Reply-To: <20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im>
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

