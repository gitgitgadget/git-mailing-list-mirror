Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988A3BB123
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914234; cv=none; b=Y0Yg5DF5kPBgQpcHUH6jSAhhm9rrIbIBr5BGHWeTjg5s3qX4PpPUmSlh3JGqq83BpZ53dFta4k+liNgq5Y+f+tVrRhMXygLDB9qER/Yaamtf9cLaoszmR8JtJlEKNV3DA+TL7T/Peo1XVNuFS1drSv8B3OcUNF8q1OT0K/8i/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914234; c=relaxed/simple;
	bh=nhMq7dA3bPrIsP2qSOuf20SFGLY7TlquWfDyIVas6Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7PDHZxkXQ7aTjdk3CjX3xnyciH5UDy9SReLUOo6hAo62gX9t6j70Ipix6/pJqK8JXEg42mXuFV5LLvYPh0GLTyQjtJMyiCD6a1fHHfAxq6rFX2ZmapR0ER/suUBaPady8v3tkTLHOvElVnLeIFurWH3CtqmsFwcpp1vrjrbTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z/6ZSYc2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmH/348Q; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z/6ZSYc2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmH/348Q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84DF57A0079;
	Mon,  8 Jun 2026 06:23:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 08 Jun 2026 06:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914232;
	 x=1781000632; bh=2uYVzpzlfiWAuW+vgygjoky6FDIouXZI5u6mQNIGe7Q=; b=
	Z/6ZSYc2dP1IUL8jp/R061zTx7//p2c2u0TeScn/X9URuu5wRtwxhQ1ZINZ2ra+d
	FJ6OREdngXFE1KIly9yHD+ZZPb7tSsxyulGgReryCPml35dcL3SF56MhzYxSgYzW
	RGcxlSkW/iQfGTJ54rG2VFYEcXWjjSvLIqsZQJ7Cpy75mM7lDF1/js6NyqX2EEjD
	hbocfwukoma32cbRUBnPHktaqnsLOQ40VEL5KajLRyhtQSrAQNZOumVS0gz5MG//
	33cqO4giygDqjS3MGasAr84JJQBUMvhHuH+4HqGRLUcPQMrfmihcRoZr/P6ZlC4z
	QVtQ29xcFRL4IIEE4hZ/Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914232; x=
	1781000632; bh=2uYVzpzlfiWAuW+vgygjoky6FDIouXZI5u6mQNIGe7Q=; b=b
	mH/348Q42ZfCSGOeQttSmDENff2Qw5EC2OpicTsay5F4z45bxqnICZ48uNSRsUj4
	kySe/vrnxlYensUrf0DfcIY64qoi4S5Z3aPtSS85O0butA8msK8sasaLE8FfNAxO
	SfuQX436EISWw1lKtBBEuQ3z4EJFjBoUlUJhncgRhdqxfXo/xuzY8XzSeBsrDqR5
	92z1tO9TWOctrbR3ZKwnvS09jbai4h9tF6j7fUhbjaJxIEup5zfjt0PAkNWx6j8h
	5lpUgAnFUgntXPRO0RQYf1tpCSyv8pgJR0VJQea4Lsa50rXUsn3RwISXYsLid7cP
	sGswYxh+Q9t8rxrHeaoaA==
X-ME-Sender: <xms:OJgmauNu_AbKNbGod4a5j-zQznz3VVbdtY3sltWjDHVQJBgiXNREkQ>
    <xme:OJgmaudSAF6bo8QKidlRqWSkmqc1wvCzq5NNZ1kgvWPQhBzykNiJ8CZdl9DMpY_hK
    WBdCOJzNcmUmxsTZgziAayo2aaGZNDHnNGjSuVtCWtM-W8ZjNY>
X-ME-Received: <xmr:OJgmalWTqESHRulDwIH9xx9XsaIN-wYRW3dmAr4ZaIsMuIQ3WrKRAQXOz0p1gYblrLnQRRWdFnN63eQ2hmBxaFhXW3-4ndGGQyAe92fcHA>
X-ME-Proxy-Cause: dmFkZTE5TQe8hpv70ABKPBTJxGWpdo/cGQ72TfL6sqGzRnXYRKe2zl1W4uOIootjY7cZ80
    MniDNd/FNRDj1su/0pnc3HD+a/NtQ4/l0tMPv0ndV+mMpmp9/FVlN8MEifvX4kBYvCEMGg
    YbFb3qassHDopf/x+IzqMaPdLLZBldKr+Hf9eA+gNF9LzdD6ZHfzYJyUrRzMUMjGYSJxev
    D+UZFjhrRS8B/kVLgTLeoJ5Ei4zam2XjDnc6pKm4P72xLHD+niqliX1XcVTKQbiQsR4F2R
    Sq3LHl/JD0qLSnR9kovfQmrgSYkW6S9Si0VQYG7juxkUvbtkOBzqIja7YEM21vPF3WF/Vf
    CvayG47/y7XFjwpdszCwM/o/lr4eH9AfxG+RMFam7Bb4U2uCTaq1j6kmkufhSNBxHf8gIF
    34Eu5UD8fJ1pw+EWZ/uhSyVJQdN+9GEkvWTuYHGe99h2Tx0iKC61dY5ZBEbvkfYeX+Y90r
    dCDuVD2IyaN8+40nV1nZGsWsTvXO8wHwWH1jPeyr+s9g8PuihUS2TZ/yXMDJJb3UMXowdU
    SdxYtaiACKOmbXDAGqFJPTg+Z9KJw2OJw3gD4Twml+K3xbKt+B5zNF7Gi0kG6jGFVDPwwY
    4JCsk13F0uRG/kYvyBj6BuwiwlDropaj8j2+aoHojWs78B6oeKk5Cn48Koyw
X-ME-Proxy: <xmx:OJgmauhyfTw_Y4ID8WUkMzaTE9tRvy_mpcs_Jk_DGs03-AB2TU-MWw>
    <xmx:OJgmas-kv-qbBMR8B1Z9kr6ofR1AEdDmXp7_TtTSMmmSXO-i4KgzDw>
    <xmx:OJgmaoZn8IlpbkWzvxSWdYnizftTIrtlX8aC5Cixfl8d45qf2YDOdQ>
    <xmx:OJgmar3SqaTOZWSdvd6mYO_zl5cmO6t5ntj3gJzoTxE5wVyda9KZdQ>
    <xmx:OJgmaozQnQfWSpGcASDkoYF19j2JB8Js0Dc0nj45YteRYo3B73to-Qqz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3fa58c22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 12:23:32 +0200
Subject: [PATCH v3 8/9] builtin/history: split handling of ref updates into
 two phases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-pks-history-drop-v3-8-84ca8e43e937@pks.im>
References: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
In-Reply-To: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
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
2.54.0.1136.gdb2ca164c4.dirty

