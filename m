Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117A47ECF3
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905745; cv=none; b=gSgpqpkUbKaRJn0bSj9039kXZIscknlpAlwJPJ0Dc+LK2fmIjcdlIQWaUCtqh5trnYWeAULRsr4cZ+gzk7lQHdUV1oo4oCgdXGkV7kKJ77F3dcX3g9TyIkBlX4M+JQmVmesyd4oGf83TnxIFcMrNVNRzuxM9dUT0wrkiJjN9fXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905745; c=relaxed/simple;
	bh=v8u4Zu5LxgFXGFcUCE4igSnfOPNhQr3SgVdeyTyAyao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcRHm3vdnx6U/zvmDCzUw2fv5WgIB9DASdfo74Xjz1DkDI8/k6Ks2WOMgeGVu0a82AFk681fcXn1U8A65NymlkA513JjW+s80lvpIDuhb796xY9nvOrwdJIeiKySkQLscKCsj6mQtjCRxAovqOpVaCy6u98zP/UiFkDTGUFvV2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OhQ10fI4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MSo5H640; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OhQ10fI4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MSo5H640"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2564DEC01B8;
	Wed,  1 Jul 2026 07:35:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 01 Jul 2026 07:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905743;
	 x=1782992143; bh=Gjihn/7AqaG2pfE+aO6EbgB/DK9YjOsV2XrZUdrvS9I=; b=
	OhQ10fI4wTB4siqgdhOzTMxPPQHT7SSJafm18P3dg7WxOLN2gFz6aE7L7DDbgIZ9
	/LKfyJvjm7QS0R/bduoppUGhA3ZHOlpyHjRV17TvaUMZowGNfPxh19+T4Owq7ST0
	AjsInoalhWeo1AxSJ6GP0IkCAgZlAfQfdAclm+d3wYjQR1cGcm6lm6mc2HTCUngj
	1W3v5nSnsA9flqWkYgq55vCBXVF/k1U4zoqE2HhjQDhenp6D4FCGZN1XhQbDmL21
	zgSFmPD/YaYovVaVqdlRPcOx8ZrxsGrQANxUXcAI6V203Q+N0Yt9o9nORKnUuudl
	OZAyC1NgZBxJd0AUjbYNgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905743; x=
	1782992143; bh=Gjihn/7AqaG2pfE+aO6EbgB/DK9YjOsV2XrZUdrvS9I=; b=M
	So5H640IkTojSaMiEVUBu3TGMf1NE/69u7do4TeHUsUJxJwmBliRoA8jtEpgziN4
	Pgu1oyqwBXyL6PPS/KDLxWHbPyh0SNGEOdZlsVREx65PYWZD2D8OgFNQ9vtpyTK7
	lxurfQInVaKQjZ9eTDcr3sEW4ujB+eDfUR7bt3ii5vMqhwaTrWwJTo4hmh3D/zIq
	as8/mGXirBjSB8B58G97RkJlJN6pnV/13zTLx4dbQAq7Gf/Mm7l6aCL1vDuhLU7y
	pPajSKgrHWDfanbAOAGgvAhjgMvwUQ4+7pPkxjLH0w7L9MRTw8kauJUeImcSLycR
	Rqy+gDvzO5kmMUCbfqppg==
X-ME-Sender: <xms:jvtEajbAfihAYmJrKeMdW5GLRV-VYj9xBL3Isp1SCbTe-WXZj_ZdOg>
    <xme:jvtEarvKXQjHTChoFIRmhzT_Tb3otNbQvdUI9bTQ_xqyue__aBuo2eVlHdTxjRjp5
    OV2bFNkkohcoPtnocYoPGnn5lCl5mdF0Hth7oRkGGxi1191YAsUnlk>
X-ME-Received: <xmr:jvtEatMi7UiPGlxKqO_IbB8GlcJTRrOLrme_p-mWai5mXGXVZx5o8GtOSa8S5nCpJGzAbSWvzCNmqWpxGWsaYHp1tEe_qCE45v-WkhCQHLI>
X-ME-Proxy-Cause: dmFkZTF3VQyu3zwQr7s0Xyy9F4M8mqCctkDGwOvRn/hCIhrLTwgo8rzt8MNXrzgAuSIw0D
    yhK8hB7LyrPdB2osjOxI3jvtRaqH8bJLRcK3nqDevNd7+EYetFlLBbgvthcEooZJWdEg8s
    G/rasbLQRd8Xps0CW5R71XjNtfznE0b93xWLTrVUbZibJYWul4srrsVQGAzkC+BPnb1JM/
    AxMnaUYc+zS6GOkezOPbMDAqYhjUJ5l7uVIHiCH4ba2cm2LPJektu+jnmbvb1eneppywq2
    5aiv8oGZ2/fBAHpTiYtX3FAkJPgJtcPAFHd6e/fXZn5hZd+rr7PYtvTvNxh3zOfxhNypkD
    cnBQ5yiGMSDeAIc5yjod5C6om2lMVC6iEkCgtuzQFr+mOSSvq/2ghZAThHe/Pg2NRvhHwe
    3Yki/X+ZSvGhNXT3xJAIYl5y5OQpVr4rtEORx0wFHerPGblQnhfrppyGOTfndegSQhIJQk
    LpL+09OQtHu2rQWW/mlHDOw/x/lD74QrWPwGfTreDq4P1rRX2kkZIyzp3yYw7MR8Va2oTx
    uwBFy4us/vX5or6qQY3GrxxRAUbFsBfy8U8jGPhvTHEHzMVtREmamvDWeynY0KRs3OuGB0
    gvK8foR3fPd1Ec+eFkmwCcWL97rdl+G9I3xc+8fVGEJ6ny18fp68ZtLSEdbw
X-ME-Proxy: <xmx:jvtEaq6E9b0Y0MRl25nyhjPNJc0Vw8WY16npPL7f8-MnZxTPCH98uQ>
    <xmx:jvtEarRILrnTL1sY8HAd0qXZleENjkPmGFbhb4o2WKeIne2BwwjrlA>
    <xmx:jvtEavCwxIpKA4OAiQhWA7kyjUkdLdIZVc5CbMRO-eTdQjVsRxbIuA>
    <xmx:jvtEajHSOvWfXpBV5GquNtIZjfvAfCgZAPyB3O5FYy2L26GAypBBmQ>
    <xmx:j_tEaliVWT2rzUsVmZ0BblyRRRLxKAqttZWJkQdNrS1Jn1pk3BE5XSwC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca1f56da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:28 +0200
Subject: [PATCH v8 01/11] read-cache: split out function to drop unmerged
 entries to stage 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-1-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

In `repo_read_index_unmerged()` we read the index and then drop any
unmerged entries to stage 0. In a subsequent commit we'll want to
perform this operation on arbitrary indexes, not only the one of the
given repository.

Prepare for this by splitting out the functionality into a new function
that can act on an arbitrary index.

While at it, fix a signedness mismatch when iterating through the index
cache entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache-ll.h |  1 +
 read-cache.c    | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2c8b4b21b1..71b87615eb 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -309,6 +309,7 @@ int write_locked_index(struct index_state *, struct lock_file *lock, unsigned fl
 void discard_index(struct index_state *);
 void move_index_extensions(struct index_state *dst, struct index_state *src);
 int unmerged_index(const struct index_state *);
+int index_state_unmerged_to_stage0(struct index_state *istate);
 
 /**
  * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..799a5bc719 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3403,13 +3403,15 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
  */
 int repo_read_index_unmerged(struct repository *repo)
 {
-	struct index_state *istate;
-	int i;
+	repo_read_index(repo);
+	return index_state_unmerged_to_stage0(repo->index);
+}
+
+int index_state_unmerged_to_stage0(struct index_state *istate)
+{
 	int unmerged = 0;
 
-	repo_read_index(repo);
-	istate = repo->index;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
 		int len;

-- 
2.55.0.795.g602f6c329a.dirty

