Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816EB47F2E9
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905766; cv=none; b=A1UJY0qbICU2SV8Raqw3IggFXPn4UAJqeO9gxPBuRBh+qFJ4/wZeB5l8XiAZtEhKguwkGkptGLp9lv4O+EE0KBfyUFYc6BOvbaNHGVenVbQx1e5upRSAQHvu0iTLy8COAV98++nQUX7UhMV8eFwr8dn44I77boie5W+29iSP1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905766; c=relaxed/simple;
	bh=JuPKpbBf/JAAudkiw0oc+C6ZLJwwAEhVBm8NoSaaNgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0vzq+k8JGinJSoGw3qRQZ2cfC5twrwXLWOmkdBnLU4kP/EM3Mt5cbDBDVXjcfCrZH2g3QyYNJMxmCK1wecm2Ho6z58cJlhChrXrGgYbtDR3HlHa1HFg8uNPvJPoJjaHUefu7aMmF4TunGq29X9zreuZNcuZYn+WCpHVPq+w3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gy66rKMW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kblbGvCU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gy66rKMW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kblbGvCU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D0C75EC0113;
	Wed,  1 Jul 2026 07:36:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 01 Jul 2026 07:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905764;
	 x=1782992164; bh=IgcwUvG5PlXPZrAG7hrqMrC9mzbmof/nN40KVRNeyOo=; b=
	gy66rKMWrw+CP512TMr1S4HEvs3xXZ8CjnGndDaNcKRjqHNLWi6jPlMBiy3XM5vg
	WBQaDK1+Q+J7jVMIcaamSjTKWXlSRoefa9Up2LlLn5kB0qrWonxRP9KwWJ3wpqmU
	/lNV9OQDVZHyIMUN8DEDj+J3ZCrUvJFeYXQZrbSx1J3efLvg5mR7GBuXLLzypU2h
	UpTu2PClbOlaJRaXIgvOvWcRaYm9oa+h4bGekEoXK9g8icV6UYcmIV/Pgp4fO2Zy
	wPtBgXBGoTaG8tVG1OAVi77SniP8fxuJsDbevjGh6uzkqrQHZj8TXJVH3j9cq6RB
	rCVHwia3p+VBWSg4fPXEOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905764; x=
	1782992164; bh=IgcwUvG5PlXPZrAG7hrqMrC9mzbmof/nN40KVRNeyOo=; b=k
	blbGvCU2JDRjiX5/mpEYMOKQID403fq0XXCoNPsE2JV9U4vxM/KNEh22gM0mp6YB
	FtJQt0rzspr1zsc2NGEi0rK4FKsw11DmWc0QoJPOzQuRoXZueaQWwQsX4zR0OGAR
	9/FZB+tHR7CBsTWSZ3LjLZPedcko8RVt710MWQwS1FwOv+R9GRZyT0VKGdkOfBcw
	lctubhm5GaLnm5czPc3s+fAv/Cu+8fDGQwN56yQBamfZm9WPL4GlsW8Ie2c7sicx
	4DXp+/s5LmxVAmNEySuuFqUlfYbn7AgQndISUyt3MzBcRa8Y1E1PREyvdIUaZh1K
	xczhhbs9VteJGEQMt5aWQ==
X-ME-Sender: <xms:pPtEaiCBAhCpOWgt7jl45mdGgE90t_WoHqU1J6Gx8F490uTlMctjfw>
    <xme:pPtEal0qgb7f6-dT6ALlxI8PWMckASJ7npPpPNCoD4UpYfzvUnAKvMRMJ97YEbSEK
    jTCl2BO-Yi3DFtQEEm3r1bnDuPVjoLXCWn1rrqmlaTsYGjeWgYy>
X-ME-Received: <xmr:pPtEas1mQEO2io8e9J9ujYOPQSAML237uLtenBi_9aVSa-rI1tBiK7UzQBaMBCYxcTgOhvqti3dJP1CiqLzDh-2hWxrXdGLsWEjC191Hc0Y>
X-ME-Proxy-Cause: dmFkZTEo8ZZHEmZJrYDFbUzcKrTBWt5qTuoxbO1aOxYxA3DYPvrzR23lWBcR7jXqOxzD98
    o3z+qAe0QCn9j0IS5sJhiERCedRGEOsiP3ZFDurmq72DBHYhIijNlzIcMKv7/oQHD2fAI6
    a2YJ3iio/ewW3qzpdfr/ZyfoiGsqTRhEuI/PQ1QQ1ozMTJKkioXe3ov6ZmhTYTkehKJ4Tz
    Muaap+SlwiohuWguopspR179G0mcemhvJiII58WbJUfwhMfpL0kERvqXJu4VfajmyJWXmi
    ovh8MCh8s7BmgTwTYXpmSmr5e6X+bOB6iAA+Nffgaj812s8+epjEmeIAUw+pkWoGKlmLZM
    9ZOJneOWomVBqqYvuYPNwFrMS2EWScbjd/uJUs/8S47C1uVmkZtztJ8eDBQfLaMyWGILe4
    /Q3Z/YgJ8N2uRdAOjMCk2h6AWgvLbfcZnVouO2PIuswgZeLR4EwfSObhoIK2nad+32FUYB
    bw215Shvba4eLOi1U9HGcFSty1pZOQQLsgi+rgnDcM//hsMPIbKaTAqK9gQEqcW62P1MFL
    zLFpBkKWMvrklR5JezzlB6arMwcatFNCJgxLt5AeEHZWENpr+Tgy7Hxcq8f6/PNKj6p0tD
    ySfxBx4J229NH4y8rVs0H0ptINlKCmrIILwGrh6NckZw6TwaQkFfvJAvr2qg
X-ME-Proxy: <xmx:pPtEaiAS9JgKstYoattK7LOIyWEVVPIUz2tMY-JS1NSmF6GYbRY18A>
    <xmx:pPtEaj7uvOthnrGobC8-DaGHtQewB6CKA_hwrHFdxCqWa66DmZWv_Q>
    <xmx:pPtEarIoc4GReYX8ug5S1vU7dPU8h_waePdCSi2K8gkTGGwObGZ6XQ>
    <xmx:pPtEassb9F8ldMfSzK9VgTQSbbRWdzrFubdcwbiTXyelrSb2X-Ux_g>
    <xmx:pPtEasfcxXqqQ_wngxfdGw3wrPitVuRsksmfWcFVYcaUt6-mRYbsAiPX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:36:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a55f3500 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:36:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:37 +0200
Subject: [PATCH v8 10/11] builtin/history: split handling of ref updates
 into two phases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-10-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
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
 builtin/history.c | 100 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 0fc06fb204..22b9fcb4a4 100644
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
@@ -414,14 +389,41 @@ static int handle_reference_updates(struct rev_info *revs,
 		    !detached_head)
 			continue;
 
+		replay_result_queue_update(result, decoration->name,
+					   &original->object.oid,
+					   &rewritten->object.oid);
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
@@ -435,11 +437,33 @@ static int handle_reference_updates(struct rev_info *revs,
 
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
2.55.0.795.g602f6c329a.dirty

