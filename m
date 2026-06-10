Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54E3B7749
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081578; cv=none; b=ONVNMZ7O0+TG3qpXTnuLhikTeYwtc7ZcmgHg9lPHDwGekPzMvw+rS8HvJPLOeX0NJ5rHP5Rg6B4ANQ+u5YAI6HhI2IwUay38nwyBIlpw3ZsnPsdPpTJXZcumoX6Zo8+f3U/VPUBW6/LkyxbuD4ESZoRePrtr/rVIFb21j+vMvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081578; c=relaxed/simple;
	bh=5IZJHLVBy2qJoe0VhN2D0YkysL/7HAqo6X+2eF682S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=be7sQ9mZW+x2W/L6IzHzACAXbUesNHZeoC8uiDrQoUpD48Of4CO0UzGJ/vcCDaDsXwAnH90C4X26RIGnH864NDd9QmhFt0Nc0l945ul33rWt4KTM9kNurpTIDsYPlZK79wKKr3QbeAMawbWJy8wl6brXLmgWuJgXRhCgZqezhng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ScIdvZL+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J1nJpnCE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ScIdvZL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J1nJpnCE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7086F7A00A1;
	Wed, 10 Jun 2026 04:52:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 04:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081576;
	 x=1781167976; bh=sOsqAfttR7dMzXVWVEFEKfZTfxt4wGkxFXyn6yEwutY=; b=
	ScIdvZL++vI5p27sT+wKZdH8s49961qD7YFyk3Fb6ZFmfASKxybYpgwR4MZ0CLZ2
	YQw4csIvQNChBfqVydg0hYGDUKYD7Vd2Ee02OTteYM5aD9v+KuoH0gFgZVKs3NFv
	28eEk58jkv+TSTgU1D4csLKoeXy895/1Vo9Ar/evNcgiNFPMOdVdQ6pwAGux8UtD
	PJcEoXL7y4b6atVCZ2iArrMCeGJOAdLhgKZlDDw/CdikhIZ2UL7gYmw/OjRhMh8g
	OXr+mBZsp5yaND9VWrYMD3KanEWn6Oup2y4hpCpIfO6/Iya0je7ZAC2m+X7/Wv1U
	zwZckfcuw0/YK5vzqihzNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081576; x=
	1781167976; bh=sOsqAfttR7dMzXVWVEFEKfZTfxt4wGkxFXyn6yEwutY=; b=J
	1nJpnCEKPv25LEy/j1p3a2iuU+7aTYPrzRqBnyJmZ88+MkYREcGTjPQrGybiCEWe
	HJiFWcEagO2RYDou2enzIUrKZtMTe0c9oyqrBKzb/Z8yx6ks1yQ1DL1MgV4+1gBM
	i1ROzyJeqiwb8IllRnZnpO0h+xRSG/dcCm8kOAlfkSpJwf7E4JuH2LhQulImlywJ
	1METR2N9IoTgaKBoIhJvGpIn86grgFmRhXBmh8i8Y/jERwpBTXzStnTyQzoFgd1K
	Rm/kQfIs57zWyheS4ulmbOoZIKlyDRKv8FFMd7rrgbfim+Mjo1dcXFJ++RtPHRQ9
	bs9AaxU3XB0Eel5agKhOw==
X-ME-Sender: <xms:6CUpasB2Tyln8zmuJOyqhGpvNePuAhDsLoQV7lu5YGIhgnY3iwNK-Q>
    <xme:6CUpagA6J3pkJukZLH3Ic98nU8S6JXqehp8T5Sm_Mw1ma7XafZ7qfKRmTz4Ohtmvd
    HovyDwA3I5kW9kU1kGQLlJVXMJUINSLI2QG9cm6KoPsRgzW31D5Mg>
X-ME-Received: <xmr:6CUpavpu5e0sSeHwo3s1RI1e2BwTU8WMDx-PGuCXbGwpeN-TQCrvhO6i5RAUC6PQERZUGD-ddCxLLcRIFrheESqcmq771cvz2K8Jwy4ZCA>
X-ME-Proxy-Cause: dmFkZTF/iC3EZ3ej+MEI5OZ52EXmJ/TXvV4dUJC8U1ZO1riGGImkArj5j8jvPHQCT3dgAn
    x6bpMacACpM3l1rT/ILW2rb46G3l/pyvukBvnCEQtke2fdwOZDTjdAkfWjhP4gv0X2+j6j
    LQ/4rwoaY0X9hygmgmSNNpJHXODEgV5dItXT7qcmb4cGDTj2O1Ka0ILQkoeMwTDE5Lhf2D
    VVhmudBQR/pwqwGqxqgINq7JliwCb84puvN32j3zuIRU6qQvorcNcgds4YwFEYGeE6VRSO
    G/XW17ntokjTblT+byQdJobwstwXH/LnQUtxYvM+s5Hxq+34QB9dsXu7dLGkgBQVLVPxr1
    ulKYtxafh2jZNc8Gh0g0wsTJAjesmCBjsPUbtyBji+NC5eCApBYuM4mO6Gmm9gDS/CMEUR
    t89AuxE2DjNHH1jkBIEVqQQ/d0FEew6ZJlDdC4EqKHUYdxN6eDRVJ4SoRcTMPiRuG10tnK
    rl2RywG9gY0MDD/Gw3MxG7z5DtlpbJ/slkAidNf76/bZk/D+y2kSKAWxFFeMHH9eEisqMe
    2MPIGoAvXTGc+nbD0aIYUECsTt9R2IsrGJAuHf6kOohItuCAv72wqRhsW4bFuWpgBrv2UQ
    9NUQLYYWiU7dmJloc5aRyMFSNkD/5ysJn5b8bcsdQUMOQ/ADkTP2VLlR0fqQ
X-ME-Proxy: <xmx:6CUpaik22YrtouTTJ4oBOF-zkE4npVgIAEUIJSbQm-iD-6JeT9lFoA>
    <xmx:6CUpanwtKheunwZli6-IxwS6LOqge0puPwujrxcJbnEZ6TgJ5tmXZg>
    <xmx:6CUpai8HlC_vDBlYky0S8Dyx9jaS8OiFCr8E1lr-dI4opuZxS3Bkhg>
    <xmx:6CUparKjkurTdtzqkf5YVQ6EFdKHLs3XGSgwvgVvm7zXRc6syaO4zA>
    <xmx:6CUpal0cs1Yhcmjc0OkoBnwlxl_nFLythWfdafXWpP6jkIyhYSdscGKp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fca27bc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:29 +0200
Subject: [PATCH v4 09/10] builtin/history: split handling of ref updates
 into two phases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-9-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.54.0.1189.g8c84645362.dirty

