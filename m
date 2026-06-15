Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265B3B2FF7
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531702; cv=none; b=iZIhoRBoKw6vXAjjBcxxGO/gC3WRglN/coJ/ZI78GiYqozxArxoE+JYeik2pI5bdgNzyWnzc+oRA3XPv+B8G8bp+0ZY3p5ckGbG7zyDItiZ9zW/kmpfKlOeki3Oil5zROm0m6gSQGnNOKIqAq/cjFwENw6scsDUC6Ibb+RJYoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531702; c=relaxed/simple;
	bh=NBW3hK8eiN+LCAeJW52cY8meC5/iOQHhimSP/YwAV10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzfjHbZI4Z8JgMFOQP0zHg5Z1YA22+j/xj2zOFSA/AQOp+hknvw7wsAVdMM03A4mvF+e4KunQ9AsvviSrgkyc6dXeEDW8xovQo33xaM8ytbuLf/y0HgFzF9et81PXZfXP/yE3EisV6S3OSNbYYo1HItzry4WBQ7dUnHfuIUU8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LeAOS6cu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6wXCuST; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LeAOS6cu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6wXCuST"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 88862EC001C;
	Mon, 15 Jun 2026 09:55:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 09:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531700;
	 x=1781618100; bh=ivqNeaYkxAsad5yXMSpY4eI9go1LuCpRkUnqZaBLR5g=; b=
	LeAOS6cucoHNTtobtsVp4MjTOu5vOh2F5fxDNm+THKxmypH3Qt5w1DN7KLNnv4+d
	SgsCNs8kHGMqGPjll3gExF/O495nNd+dvd1QEa6edxysc3BuBaw/sax4zPb1A1x+
	VoQhT0VfohnjBktKb91DCXQqBzZVESwRw2qGMaBQQSz/zgE8OhFmAmz0EmWfuE81
	bWYQgpsN00eGbya8Ue8TD3PQ6dmdRSeEL81imnKxCtj1OzoyNiWAw0WVvjcpoOoC
	wBgGI6+3ACJqMZ6uqzQYZCb3mEQqM8X4+l2LT3YuetsAXbMvkC+mrrx6cwlrQ3GX
	TJ1NNCWSxwkOkltL2sFE9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531700; x=
	1781618100; bh=ivqNeaYkxAsad5yXMSpY4eI9go1LuCpRkUnqZaBLR5g=; b=P
	6wXCuST9BAJQx3if6aakXPS8jSYpR9ppVTu6Vfayey2TvFU23eaSXTdn4mr9ryAr
	u7536j/QRwJ3O/xpa97VNJqFEltjFV0qL8E/qtKlCpC9vXhkKimOYCrqVxSxRwCl
	Ap8vMmYTD2T7ohMVywVDazR4A5abchaXD7GtGEtboLTlhEQo2sGhbGIknFIyDV6q
	9bZDLf8IvMYKqwpn5FzDk/YJMGeK21aoNX6lRFEx/LVZpQyv+G/NdW11VbbQFFzE
	8vPGJS5isP739QuTxULT1HUvRmrlOfJTiwm3PPfTPl7fr27AiQSHI3AwqBSrYR8K
	w6iJv+D717IAxheWwNxqg==
X-ME-Sender: <xms:NAQwalHBS-0s24znDD9dIAXgWDnZEF6wt0gdIufXaiZrWFOrQAPoCA>
    <xme:NAQwar0_PRO128oMLn8OgAvfp501PBQRWT22NHBc0iz977BIraCiadjjXF6EjKZQY
    J_vIJK7mXtthWHZGKI_ACWtPDdgpaNyEBfLF65U9ZzjNr4XgO-xMA>
X-ME-Received: <xmr:NAQwanOuqRVEs4f4agv3j-4dAC_P_xK78QYlPNYtcAvxuBWfbUZUK93gKc-FFpwiay47KxhEOKGjdyU-20zPMebgQguZl-n2Sa9BsJ1UEQ>
X-ME-Proxy-Cause: dmFkZTEMPeD8zBW3DHtQEP5i93Acch+5rP0QNkH1cG/JXuA6+oEvHbtVmbD6clvJelgRZE
    1vBDsT7A7uQV6Gdj9OkjlqBCAnA412wemQtKwuPA/hvgcOh8CyRfV2AhtwfLNHTKQlwHQv
    oxhlnwtt/nGkegyVzC975GVhHt4uS6iBR/u/zU4/qV1aRi9gpkRnRhEG7H0vxr+9yXdWRU
    A8v/TL7rSWppNOMIvDS55f2AGwsqLpr5AvNVKzOZx9y2Ss5T1e/j4FoCcOGPCslmG/qDWP
    4JG1/aHeUY9Coy2vDLc1RvUk2C6XO8Fs5cA6VTVPI0cv+rNzSdKho8Uu7UNXJYJWmKwPs7
    SIPCcX6Yjad2VnXtMy9nZLVSaKA9OVLb0WjPQ5Cpdn0UHsxTaqZTlkM02xvzAwSkHYN0Wx
    8949nNBz9Cm7xYXVvhVa3VyLol/we5MpqAzHoJcancoN/MhyoNVVM534FmACeQfDzBuhRj
    jU/zz/hsWrvtVUyJYkKpq0pdUb7k2YxBDyN+ete71WzoYeqAB2melCMtdJDxHZehjniYPM
    SzrgzPrwSAR0OqcYAJkgvrrrFRrn5PllvhTEHkLcV15AMVCooCq7ye/U2B7qIHrJQ0Ofnt
    F+zA2QRF2prVwjnzukSNvQ0MTha0D2hkcF+XVSPGNc+zRhpOA7JIMxGJ7MfQ
X-ME-Proxy: <xmx:NAQwaq7y-jswG1CYXZh1zLCOTDh028wtrgK23BSEtwZzbH3wtX-DTg>
    <xmx:NAQwah3wgvJ0Kbr8ARrYLwgXMa73b9hVoZ_q9buPDduVyOjraaYJLQ>
    <xmx:NAQwaryLp119x1VRfPwKWDPVPJ9q9X-MNbmq-_Q4kRuycCY2nThKIQ>
    <xmx:NAQwarvB9ImCwGMYeVr2xlFajwCnU40D2ZxRx2iO4udu2bumNisDtA>
    <xmx:NAQwarJn9laCDw3gKnZLggEYAvbUR2DLtjd78eHgkeXrQpe6NCq0bgA5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:54:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fca1e3d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:54:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:51 +0200
Subject: [PATCH v6 01/10] read-cache: split out function to drop unmerged
 entries to stage 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-1-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.55.0.rc0.738.g0c8ab3ebcc.dirty

