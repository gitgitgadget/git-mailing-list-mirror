Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C303F6C5F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531722; cv=none; b=jCyeA1byNTjiOQ0Wxgwkn/Cj1cSOPYQOJnZHhWqRrrkuXE0q8uw0ILmTScPygDpLHuSic+YUsBGydzF7HjxnN9m9zVPy/SpfEqX70UEZK5Fob78FKUooZsQ85t01EuGPH+33RSrGAyljMwXzLV7DLYhjkiJsCy8wzZmAJnwcszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531722; c=relaxed/simple;
	bh=OLPo/Qgjsz2dautvqNFMSz6dyNbGA/zNQkyijeqwqkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmKEtvmEYClNNojF4baLDGS0JSmu3QGtWqNWsDd0MTDAd9OwEwVSNfzKdPC6lPp2z+BpaIjzWgcgpxE5s6URPuebsJ+BaQkiucRx1ASf40x4LF3PDMG0NqgL/OSqNvUneM/mtCcgatA16oVfth1TwtltCrSUMH/r9Xk/4AeyKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m6a+Fx97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drkU+9GJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m6a+Fx97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drkU+9GJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4AD62EC0283;
	Mon, 15 Jun 2026 09:55:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531720;
	 x=1781618120; bh=qEQ7EXIE6tRRkJFAM1x9w1hDUst/yHroezQY9rv8rbE=; b=
	m6a+Fx97xkib7vRrphvQQI0k6OahJub4Exsh6S4kkO/GO8C6d1J3iUjXzkpm3/Ez
	zictVF/jvpg/2dottIAwi9rf7/eGWko0LRX2zyetSoNbc5DsdUPfRvcryYgU1ba0
	0mFXddgTfNKmcw6C4fD0LlxQ7VfchDTYouKxatSu/KUXnLXcFQkG7t9d3ywNi6tq
	YqiaLkXUjQXDTXgQsNXFxq/842CEPvnSa4rGZp2wV6JtNxzQwImYRdabNcsq42GQ
	KRACqAFsNWy19cT6UD4BQ8vka4SdddaGxn6iIS5C/mZQ2QqV0zx+57h77pD/gMC1
	3xPjmH1wMy87ps19YTMm/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531720; x=
	1781618120; bh=qEQ7EXIE6tRRkJFAM1x9w1hDUst/yHroezQY9rv8rbE=; b=d
	rkU+9GJzjwnFNllAXPKsYrCJlJ4jOqnc50kVu7rwj36QTH/DbQvIO621GfwM0h0W
	Cl84jPRFekr3wa+Jvd6S63ijkobhqC/uVUNvpX3anBPEt1v7bV4VIYlKk5fMGFoy
	OFEcXf8ZFfc071cBen9DeYG19TIksDNSyV7Rna9BOtKecUHHqQMHR1Vy9TbmbX+Q
	mBwA8jf2t2H8po8QeqzmC6h/RS4Y2D5H0elUYecG+cCV7JfO2QGYbUbG3lQBl9fU
	jJZ2uVNJo5V4jT/oss/z7gNbAG5TbpEYgf/57lEJJiDVEQGNUwF9gPUAiahrettd
	unYdDPUbDuDgNzub7Z4pg==
X-ME-Sender: <xms:SAQwahmMTWF2vbBKNHPxpKR_ZYLXe75C8m3c7iwwVo9SRxFBM8tItA>
    <xme:SAQwauVGkHQksWru2HzzqqAEb5WhU-h4BlxpVDJQ-vML-L60kCvlBFQ-kfkB7wngk
    Ik2wUHCsguDbUMn21qtkrg-DCv5QPED36ogIhJKZCZFaeOHEoy2HGo>
X-ME-Received: <xmr:SAQwanuqUWcgeItxvwvUos2D3x2AwZGpO1RPYt1K3DOlSMuUZKmijJOogbaVUYsSyEzh258weOqOVh2uYJg2K_TEu6EgmlCIY3OQd5vHHg>
X-ME-Proxy-Cause: dmFkZTEdTLBp8ruXXUEwqzLqKZduxrc08bc6xz9iGkN7oNGE0pSZpd0qY1ebBVJym6f96I
    wa8ENkW12fVqHYnZ6n/i1A2e1uhyU89CTnl5NeKwyjGuDhRoGfSpHPuWehC+0KsOmWXJL5
    FkLsCIMTxBxej8O5RKWlh777+0mW7a2Ecc7tDrNNl95xbi81amt+AyRj+cXa9JovzJvDzO
    Ax1W2USuE9tz/mSVfMX6xiZWK7bFSgusvkl4fpdS6xyZKh5InKMkT7toL4gYsIgzF8381i
    eUpU57umKZMtFaiF8WWCDTJilBikQBlby6MDUjrIPPHhra5lZzK3NcODBNBy5RO/ABDSWX
    Sg2upJRroKj/bQ9nziwZEujZTjwiTw/PF+XqNOluKsVCWufcA9rLa+3E/z7BrxEIDkQe74
    Sxx2gaR/6N+q9KClu+FAs1QouG2jp3wZ1y0mxRAI+qEbstWWKb2Y3MdGxWnbdT9WBjyCsT
    bno2+g2J0ZLnsi6TCEJ0Jdn8qqnq5CsTx2ItPo22QVgHaVy0w6ycrEysopqxVK22H/80Cu
    Lry3WKek/H7SMk/ixxBo7plMs8tbMxlrZaVgROq8yW8DlO2XPq1O/vjo3Pi2g6NUi60z+9
    82tuu7XlfP4LNZG5MFT9lGNDyUZjBKT44HKipGikwZ+Z3ZGaGW2LrWzUuc6A
X-ME-Proxy: <xmx:SAQwahZyUDS0VRDrKYrQR4wxY67180HARKgKdfDr885LZJ1BKjSqWw>
    <xmx:SAQwamWfQSNmQ7fdlT1m_qvP8bA6A_MYFUijCfqypVkAoAqQdQqJPA>
    <xmx:SAQwamTdsnaqlypVBhO-PbcxU0kKKJ5vQbvQZuknObiXdzA3eO7HRQ>
    <xmx:SAQwakN2A1YXppBbMnumHtNsjuKepagXkjDp92qmP0C_k-gkAyacvQ>
    <xmx:SAQwapqxSLQLdbwlWUcro3azVtTZ7p9GHyo63-urk9qzfOm8WtL2OFSF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:55:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c94af35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:55:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:59 +0200
Subject: [PATCH v6 09/10] builtin/history: split handling of ref updates
 into two phases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-9-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
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
2.55.0.rc0.738.g0c8ab3ebcc.dirty

