Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F825B082
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328185; cv=none; b=DLThEHmu//FEZwB8RYp/o7LozjZMSOmFLo0Dqejv/Tu6lji9RFgbWn+ciVMSQ8fWKNwSWDNx5YXSsSAjErrB004smNOsIz5TzktNczR3A/XuYJtJaau2qFPMLo9Th1I/t+RO6x7ngnXku8qUBGwDVwkkpZR6qigOxuRrUpeDAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328185; c=relaxed/simple;
	bh=Fyuopru7RKf6lmt8dpdNRcoUl62UjH3ZdEiB8f/BfL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gErELDm1GZPprh8sq9VVJIh+5OGFI0M3ibopnHVsCjSoz2G4dZt/gPcnkKd25VhbyXN+6Xf46HbqZKQBW2ceZYvEUiZs6MYtxQw+KLkLKfkPYBIpgqUMKau0WoPmDC8RmpHhwR0M/JVtOIa82pdVLkdyVYX7myJFGVeYo7A2XO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BwkbTlhK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ixh7Gh58; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BwkbTlhK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ixh7Gh58"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA13D1400107
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 11:36:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 11:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780328182;
	 x=1780414582; bh=MvCndCTKk+et256vh+gOhSPJ0WtjSzSEl0r19WdnxLo=; b=
	BwkbTlhKmbdam3BdN0UagClZaw2QWT9c3XRVnTLPsKvtfUFdVo/ppibBKIEi124A
	Nghguvv1dejd+Taa2W4e6f0mcDLtulx+Ha/qqshUIj2HKyZ+Q4Bhs4sz5oWsRjcU
	MCKa6upwvfqWtTw4GpsqgA/DPAIlNIhRHWZ0HwS3NXr6AfX8BACwW+XRGSp6+Hea
	2NKFMMj2C34qLO0HLs/1hoUPsGr7vlW9ZlSPuVVKqQby9EwieaNLXcdOmnTCWWry
	XTrkIRyP3DX3vbgbY+bKQU2tWw5lreyUrl1B/SFCGilTzhQuFYLo86RgQ+r42Yg9
	1Wwu5Ec8naYO/W1rLDcNxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780328182; x=
	1780414582; bh=MvCndCTKk+et256vh+gOhSPJ0WtjSzSEl0r19WdnxLo=; b=I
	xh7Gh588vabVafV86QhnkM7jBs6pZWFmUJmb7rYl2AnZKTX/pr2ki0HRMCpbtYkc
	isY7bcnSnxh1SZFPQSZztiyf3kqlCGxOAWTyYXJCb+aHmCRvLK3cP7cXNUHYl1HH
	niXyOQLlJthBbpgpDOJ6+++ElwNav4uS4EvXs8TM4tt1E+kxxQu7nZI7Y5hm8xEI
	Sdc+0Ldz+Gf6Io7cNqsKmhxF/X0/2uY6RxCM6woanZ5hJK7MJY2fRzBaW6fMh7+x
	j12eth1ahm1ErdKWncyfEh/29Wv6nMF/T0vgwRRMpSiOndFsP8R8TMNXs1PMoZ/O
	HB9VlC9xwA6S43/uO+Bpg==
X-ME-Sender: <xms:9qYdar7bkGI87taaGnVpCcbvLXb4QjcgqjN5a67jPYMEny08d-f_Fw>
    <xme:9qYdan1Y4hoINiZiBgbVmeXM39o4VuEzV6oDzb-s5Za1VZbPypf4apGMqYuMBXXMr
    EOkMnd8mycr4VsOxfnwlxcWTP5AVmwh9iUjYBhuHD31ZUP7Uvzr>
X-ME-Received: <xmr:9qYdaoFmPkPshXyN-sda37LjDNpsGOxnXGuiZX3tk02WpQ9Qln_VRcYK4Fdtqh83c8MzoEKVysiMGZuie9wkzTRGlwtGHiaxAeLN1RnFkIcO>
X-ME-Proxy-Cause: dmFkZTFkHzWC5i+5+kKJ+Xd0+ihbZxPxh5njuY7FmBapEVVWaZxbPraD7cNCeiEhB3JMp0
    KlemCvSjGZ+hU7wmpvKgHVnSlQ/0OLx2Xbi1wP28OP0502bWu++EhQ/uinvQEytJ9PoXcN
    yGcU/6ECLyXQDrMubtX0YGTKmlTc3Thvd1PDj40WJhJ8XIU80nFsunzBJa3c+P8/GHjrTu
    nb0f7u70DWYYkWDs4IzpJFIqFHJuRdoV8LuJUsSRvRqWiLLeylTLqNrJxLFeuT7y6V3TyX
    dM5YAeZgKWK6alPWxhn4gXkClGYU3oZnDP4GHzlVtvTtqKzw390qFDmoaOjEVn/y9ekxJb
    uPT55Oyn+CXkBZH56MotWTeMkh9NjqrGEo+XyJyQIx7dmUH9LF5aGNe09ofC6GyuM7NOhb
    QHCAB8Um21VJ86W8emfzeSOcc2ATo0mX+f2Mb7fXx5uWIiDbln6unYIu9ppnr9V/p+KI1h
    Nxlg6eYoHxOim0YJGTE4auVJwXEECgvJ92jsaMPrF0SokRt9P/Q8wb5ZtbmU7DoOCumC0c
    rgtb3yDWDzXq0piZQ6dqG/K+Aape39DPnKlle9tTYJze7MksffLrYsusXOuArHs+cpFCnE
    6dUR+WgNmKPbFAtcvV9cQ4uPdse4iV9rP4qbYczvR2Gj4GhRcQvSt5iUWFZg
X-ME-Proxy: <xmx:9qYdahQMC3eUH5J7mAilv5JJsH4Qt_6bew2m-XWZMd6-FkGSNi07Pw>
    <xmx:9qYdavARI7iHT79pBad-w4YPieWktRf8IktaQiBuZqqDGAb447JrMA>
    <xmx:9qYdah0w91Nur7UycNM_dYFiD_LAUOTKVhi_yeMYV41qGtwTyAE3wA>
    <xmx:9qYdatWTNGVBafrrrz_0x4IIpNTzCpwqxz6o80Pqa12zupSQG6qpQg>
    <xmx:9qYdaoaI6qo37IBty7rMcpn8toOWi0CtkOD2nq8EDXvMHuNGxXtQD3yu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 1 Jun 2026 11:36:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7195f84c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 1 Jun 2026 15:36:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 17:36:13 +0200
Subject: [PATCH 1/2] builtin/history: split handling of ref updates into
 two phases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-history-drop-v1-1-643e32340d55@pks.im>
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
In-Reply-To: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.54.0.926.g75ba10bac6.dirty

