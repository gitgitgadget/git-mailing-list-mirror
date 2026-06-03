Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5CC3A6B68
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503268; cv=none; b=QTjdMl/4g+aJwbDMpXT5QKpP+JH1d+vw3oeeFfdZ4HDLgmZSbBoodsArF2xMudoGVsdYY8GoPdzA4A4J/h/BqlgSV5bFMjVZrDNmy0aEHSKA7ITfPRudG2NGf66/JB147C5x1NLwfW54W+gNEqKwTlQrkfTVcyCA52lqvMqSi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503268; c=relaxed/simple;
	bh=qSmcuMogRYyVVu0HH5UKnzo6PmfgVKg/qSC2O7XEJKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yota/LruavNPf3P+rgL+AYZEQTuKNP+GzMzNCzeHDQ7ndNjflS8x80KMYlkPpWAU1IsupKBvobyDNQA4mDW7JaiHdXqkZE5nb2z9hcaN+w3aAeKI7Xbuek5wS+ZTMZQ7z2OXNq7zz3K1hufZMtUXV1rOXKKl0/Y/WtcW3bNfApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e2e8Ml/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CxWlxIge; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e2e8Ml/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxWlxIge"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6E7357A0133;
	Wed,  3 Jun 2026 12:14:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 12:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780503266;
	 x=1780589666; bh=hCJ+EoGXC71ZBVMPA8hEr/ir4DoYtgeaVBLLOPgmmx8=; b=
	e2e8Ml/uBaqR/4JzzI2hgHJ3tnJnq1xjjPa9jWPsLXnPEztZpqW2ZFOS+o39Z4ce
	iB0xVe/WOW+I/Kz4KmeviKlz7gg6aSu8kutaRP7QhunDMXTQMKqBfHjuu0pEVhGL
	WsYJZCyC9xuBvpaiJWzerIHSBP0PglLRWbSvmnbBk9vMTPWAZz+aqMISuZS5pHIQ
	9n8RndSz7NuEjw5UnWbAda1Cng5uxnGu+eWpS0Oq/Oc1NLTWLDubVzjo4Lv36rAx
	XrawR1Zmpq7eju3KRsE6BQhcWWD2HOsZ3NXHIF3Ge/22OBl8Pil17EV7WeJ1yDdW
	I1SMLDqOK7uiI3tdkt51Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780503266; x=
	1780589666; bh=hCJ+EoGXC71ZBVMPA8hEr/ir4DoYtgeaVBLLOPgmmx8=; b=C
	xWlxIgenVYCkuVVc7hsD4MuSNMg+x5aS+Rku//vbLXpdOnQOsRMEcA940Db1VjYt
	cyvtG8+IJEKkOp/SVl2SM1JZNODZwuP96Pv8MG7ORLbBI8jKy1kfismhjFjISQ9B
	agTd8OOFgaeWaLajP7qmTBw1xbK5MjXZj2hPO8DvHv3T1x4wv0wW/r3GZoYoIMs1
	eDNSCHRJyNCr+E2Bg3Up8vEHZNl+AZnAzVSek2PXm30jfYrO59ZE1iRp/T98bRBi
	QiV2+1aSEyIBQrmocsx6yzHGNth91a24zDFZRAy+wxb9o6jY0LwiuJy7cQeppJVZ
	+xNTWPCKEXq5c2+GEuCSQ==
X-ME-Sender: <xms:4lIgagNKH_GwevmEI6lMW8nHKEenpJhmzyzjYkKrKhD4ilj2wPgAAw>
    <xme:4lIgauYsZ02wpcbop5nDE0EgamTepNZlwypTHbjaFvHQilNs7wxT-mnDDuTraEZOI
    bSpeHnNxIBRuKwCO9c5ERxNnuvVKjkdOOHDfcFIG1PuLLoGXWoIxQ>
X-ME-Received: <xmr:4lIgakrKyrMWgY4sYucIrcYkSpcO7jXpLK1wkyd8I1VLmds0DuFS3sGsLJbtG_VRE1SFh4TC6UsE-BghWRe19iFvRK-GUDqB3j569-3GBd4->
X-ME-Proxy-Cause: dmFkZTE6N5DunCr2SyeSlDsMJPMWMflsCI44NrLn0LpjqTsdWy4MzrkM3SUUGtW/uOzZR3
    S+lz/cgLSxSgqDSHMqOozgRrPxDFboEjAE1e0RDD/LU7yNA8rVRECM5cUalWdctdXd595N
    H1ETd4AU80viWxXshE56AhETGGXQMNwbGLBeo6HAoN2QYbicvMf/DtScfo/W04DGTBngDD
    YR/AOxYN5bt/ejw7OjATW6pzi34xm15hpkujU5zGKFdenNatiwQJpAEjXn6zibTNBu03/p
    4pgpMWfVK9Zd8K3/Pp1p/q2t5jetfM3ofQorKyvxloXZ6ulOKr1m7LV0dJpgUr7rUwwhnr
    /oJE0Yof4EaQfy4OR3fvHC+D+RcrurumqL80cDn2MmPtT+ox0Ug0xoUGPLddjsQZTCYMoN
    611b5pKi79lACQohbXXEFNIwWAN3UBB422O/nuyOS+gSKQq/eSckEEFM5l+jNCdatuzZ+z
    HhXDK3BZZXlYri3x2NV2KZ8mm07N2J+hbk8mWqq6J3E/EASgEGdsbhJc6U3Hagu+m53j2t
    eRLK+BPTQS9q5m0cEJS4CS2f9h2ejk4p9e4163d+9hDLKE6jSoI829d3UgASIGRnjgw79v
    EyT4qXeZKXSk1Su6GwU0CXnPdAayGoyAPvhehY/IVpjkktkUmg1oiTbL0Vgw
X-ME-Proxy: <xmx:4lIgaiYhGVDJ11hBAdGjIHnAuVHjCwx8CvtqyMgaoujwFm1kPfdOSA>
    <xmx:4lIgasS85JtvbUuIbXozpREwmakT7ry_EVPrIEIG5s9p-6qQICbSzQ>
    <xmx:4lIgap74PeleGuLh_CpDJ1mjHkYVydrKliTMePtnc6LTN3qtgm95Ug>
    <xmx:4lIgahzZO6Bw_WgO4dVwZSMmPPYM8p7ek0nunIpcnVEhWrGcsaFnjA>
    <xmx:4lIgaqay0e5JSKq1Zc_Gka1o7TccyGkmS0vCl2ttG2aOS6uNxd3tZGgA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 12:14:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c905ae27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 16:14:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 18:14:07 +0200
Subject: [PATCH v2 8/9] builtin/history: split handling of ref updates into
 two phases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-b4-pks-history-drop-v2-8-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
In-Reply-To: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The function `handle_reference_updates()` is used by git-history(1) to
update all references that refer to commits that have been rewritten. As
such, it performs two steps:

  - It gathers the references that need to be updated in the first
    place.

  - It prepares and commits the reference transaction.

In a subsequent commit we'll want to handle those two steps separately.
Prepare for this by splitting up the function into two.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/history.c | 102 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 38 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 0fc06fb204..4fadf38c32 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -333,21 +333,17 @@ static int handle_ref_update(struct ref_transaction *transaction,
 				      NULL, NULL, 0, reflog_msg, err);
 }
 
-static int handle_reference_updates(struct rev_info *revs,
-				    enum ref_action action,
-				    struct commit *original,
-				    struct commit *rewritten,
-				    const char *reflog_msg,
-				    int dry_run,
-				    enum replay_empty_commit_action empty)
+static int compute_pending_ref_updates(struct rev_info *revs,
+				       enum ref_action action,
+				       struct commit *original,
+				       struct commit *rewritten,
+				       enum replay_empty_commit_action empty,
+				       struct replay_result *result)
 {
 	const struct name_decoration *decoration;
 	struct replay_revisions_options opts = {
 		.empty = empty,
 	};
-	struct replay_result result = { 0 };
-	struct ref_transaction *transaction = NULL;
-	struct strbuf err = STRBUF_INIT;
 	char hex[GIT_MAX_HEXSZ + 1];
 	bool detached_head;
 	int head_flags = 0;
@@ -359,34 +355,13 @@ static int handle_reference_updates(struct rev_info *revs,
 
 	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
 
-	ret = replay_revisions(revs, &opts, &result);
+	ret = replay_revisions(revs, &opts, result);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (action != REF_ACTION_BRANCHES && action != REF_ACTION_HEAD)
 		BUG("unsupported ref action %d", action);
 
-	if (!dry_run) {
-		transaction = ref_store_transaction_begin(get_main_ref_store(revs->repo), 0, &err);
-		if (!transaction) {
-			ret = error(_("failed to begin ref transaction: %s"), err.buf);
-			goto out;
-		}
-	}
-
-	for (size_t i = 0; i < result.updates_nr; i++) {
-		ret = handle_ref_update(transaction,
-					result.updates[i].refname,
-					&result.updates[i].new_oid,
-					&result.updates[i].old_oid,
-					reflog_msg, &err);
-		if (ret) {
-			ret = error(_("failed to update ref '%s': %s"),
-				    result.updates[i].refname, err.buf);
-			goto out;
-		}
-	}
-
 	/*
 	 * `replay_revisions()` only updates references that are
 	 * ancestors of `rewritten`, so we need to manually
@@ -414,14 +389,43 @@ static int handle_reference_updates(struct rev_info *revs,
 		    !detached_head)
 			continue;
 
+		ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
+		result->updates[result->updates_nr].refname = xstrdup(decoration->name);
+		result->updates[result->updates_nr].old_oid = original->object.oid;
+		result->updates[result->updates_nr].new_oid = rewritten->object.oid;
+		result->updates_nr++;
+	}
+
+	return 0;
+}
+
+static int apply_pending_ref_updates(struct repository *repo,
+				     const struct replay_result *result,
+				     const char *reflog_msg,
+				     int dry_run)
+{
+	struct ref_transaction *transaction = NULL;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	if (!dry_run) {
+		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
+							  0, &err);
+		if (!transaction) {
+			ret = error(_("failed to begin ref transaction: %s"), err.buf);
+			goto out;
+		}
+	}
+
+	for (size_t i = 0; i < result->updates_nr; i++) {
 		ret = handle_ref_update(transaction,
-					decoration->name,
-					&rewritten->object.oid,
-					&original->object.oid,
+					result->updates[i].refname,
+					&result->updates[i].new_oid,
+					&result->updates[i].old_oid,
 					reflog_msg, &err);
 		if (ret) {
 			ret = error(_("failed to update ref '%s': %s"),
-				    decoration->name, err.buf);
+				    result->updates[i].refname, err.buf);
 			goto out;
 		}
 	}
@@ -435,11 +439,33 @@ static int handle_reference_updates(struct rev_info *revs,
 
 out:
 	ref_transaction_free(transaction);
-	replay_result_release(&result);
 	strbuf_release(&err);
 	return ret;
 }
 
+static int handle_reference_updates(struct rev_info *revs,
+				    enum ref_action action,
+				    struct commit *original,
+				    struct commit *rewritten,
+				    const char *reflog_msg,
+				    int dry_run,
+				    enum replay_empty_commit_action empty)
+{
+	struct replay_result result = { 0 };
+	int ret;
+
+	ret = compute_pending_ref_updates(revs, action, original, rewritten,
+					  empty, &result);
+	if (ret)
+		goto out;
+
+	ret = apply_pending_ref_updates(revs->repo, &result, reflog_msg, dry_run);
+
+out:
+	replay_result_release(&result);
+	return ret;
+}
+
 static int commit_became_empty(struct repository *repo,
 			       struct commit *original,
 			       struct tree *result)

-- 
2.54.0.1064.gd145956f57.dirty

