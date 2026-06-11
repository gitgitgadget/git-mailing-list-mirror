Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB740BCCD
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184458; cv=none; b=d3jzxBTA6jg83Ph8k6MIsKUSbani/zDDvZamrpElTxbx6KIuriC8FDiqe9d4mueBemo22WJ80gl2o7E6Zr72OlX7l7PiNocr0cnqX0Ua+/X4sYPG2Vdmci+ej5MSG7Fx3yopx2+VL6/PvPIq1tZ4DY2zlVfwwf5OzP1eo6Gs0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184458; c=relaxed/simple;
	bh=5IZJHLVBy2qJoe0VhN2D0YkysL/7HAqo6X+2eF682S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gaJonWKUBb2cc4SCTItksSYCFMNo3tqf6E7YdBUpCA9dU8CZVfkT2SaXox16FqvTnX6XRkVe7BMtTbHoQkfhMmY1wy9PEl3O6W2kjhwmumYIja6uuSPJp69wlCk/CjcUsHtZ7bNVNHU/HBvnBquk9SEfP6OljqEa9BS+ODXi9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ENAPMFpJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LhXOUudA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ENAPMFpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LhXOUudA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D8A32EC0185;
	Thu, 11 Jun 2026 09:27:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 09:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184456;
	 x=1781270856; bh=sOsqAfttR7dMzXVWVEFEKfZTfxt4wGkxFXyn6yEwutY=; b=
	ENAPMFpJGVW3AEJfxEGtVwYxiPcH8iUuWjknbAxx48pcxVLj6Ojup5Mw83lx9cgj
	hZ8kYYWIFOfbNF4Bpu0+94sioxpAO4h+C10MSLIpYp/j0A1Uy2da1GodD7fa0oiq
	UDtCMKpfvcMC6ucsoZ0/KV5tOmykE+U1hZ9g4Cn2X6JLaeeEm/qzmTdNf0Omj7GW
	T+wbpCbPly3hYLk3jb/xmXaOaELo7+rypZjCYY9NCZGZziKgfdyYcopEXFfu3mkS
	u1/psKnngVAngcYr7S/4wKhuJagCLaC6IXe5iOxUQQsbJCneHuCN5q11+2ChuZoa
	F+Y5rEpoFPcfrN9wiOGj6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184456; x=
	1781270856; bh=sOsqAfttR7dMzXVWVEFEKfZTfxt4wGkxFXyn6yEwutY=; b=L
	hXOUudAqzLyJUvfFRnjBnvXjAqqMkRgLVffoNPKLbhopZ6QRR4S98JrFoQDZYCaT
	06d6RdPAOdVLPZXT6XUm7XdHe3r2p3Vd5rbeFpzSktTJc/lPUbzXTIT+15sRR3/3
	g0UErDCKLOSkjP/OLY/HthfFrQ+tImc0Sok76vnCrookbN4SXVTqNOHFWeR8rg10
	46FjdPnpXOCqdvhXtL7B7PRBVFqpkJj8omUMKaD8s14jbpm5DU2TXLxA+IdrNt39
	Hp8mcjsLm6T6OZs6Ixk3T2D66xBXYTt/PbR4Gr/1olRB5g7Cts+qt2T8AklEZlIy
	6dik05qpytkWgKYnOrzgg==
X-ME-Sender: <xms:yLcqahylQfHAWleQ0hkQOEk4B2vydM_ovvsw0IvRJgHbz93H5ZVJ1w>
    <xme:yLcqaiyfu7Y-ELFgjtVWsRNbAXRyQ-ZzXxFNhkuLFZau3rLsFgYNsMlY9IkbreHeb
    a0rG9o7j7-yFmZzgPC2fM3GOY-GOhwxzMH9YbRVcctNOVeaEKIUHw>
X-ME-Received: <xmr:yLcqarYKinhNUBTHc13OcJZmYR2An9auk6U7NbdsDXn9Jr3bU7YG52FEUe5H3JzWPk32kKgKL0rhbjNAIOA0ITOxE97D2eYd4gvDrLpqLdsj>
X-ME-Proxy-Cause: dmFkZTGGNOZQy2QTFN7IZUfAYMTq5Ljsjny/aPIOx7WJqe7Z1LumpFueIzeDdJnNJ5DVRz
    36KQCGTaoNUuTNfOfSxzVLKyz3syu0LyEd+VcrSaIbKR2Wk7mIy39Hol2k7OuX4+m1/Xrl
    QAVFceJO/5DINnoaU26AA0MPf95ZHQ9cWzgSwjXix9sAfTqoT0utcmEmlXQ8CpRHfMI13E
    5B4Mb7HeFzViwhZIFrHVRQdl5UW+0EMgSFWe6vn/6xx9YWCTd6FX/8MUSb+Wys5/iT0aWB
    cGMngkH9QtISmu5huLQYQ4jCqugx2AyXKFtoDlr8DLcs7+95+gqLjyrCGApmWLjjQ4h7qn
    X1d0IV+Z5gtiqpcrjHsYnjq0GD8M+TnfivJscJzeRLw+AWwN2ePInej010IyAqyvcZjXwy
    LlINEVHm3UsBZ0xPbsODrU/wc6JuNQ89sqqWFtWcQId6/fu4jGID5V5XKXKiHb/gyr8zdf
    L7+DEFEGRx+SahQyvTUqAaTRXAxlcmziSuqNFM9BAKoywbd7O0J5n2hPJFHZUh0NIjd4tP
    ycCtAZkWbV/0nXTnlYOyfbxlr4J9HyagoH3/xpmeGxWLWka6rxCnB54AdNe76xRoKj9NFn
    8+75FdX9X4yKq6Hb/FtpxzmmCt/+Fg5VHN7llTbD5tkVhYJdVN9YYYMxPpRg
X-ME-Proxy: <xmx:yLcqajVtKhDTmmCPicwaVv2m7-_hpwtDP7MicJJ8Iq3hElCzJvt69A>
    <xmx:yLcqaphlQ_mnYoH7m1YagQWI5Lpk3CDZYCKvsCRRHMZhjYc4-x8AWg>
    <xmx:yLcqahsTih6w80ZZs9EnA2uMW_at_CLs_9Z2Y1dvBL-DkSMUXkBLPA>
    <xmx:yLcqai6_m13UHUSOAoMeGdvw58-bWZ46L7idM9u_mJykrbQpN1O52w>
    <xmx:yLcqaim6P_KdQeZgEX0AHRpkhwa8b1O4pRocidUrWzxiOB8a9CKYT0J_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9ddf1802 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:12 +0200
Subject: [PATCH v5 09/10] builtin/history: split handling of ref updates
 into two phases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-9-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
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

