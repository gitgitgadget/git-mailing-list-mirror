Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1EA480964
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905759; cv=none; b=qjHVezt0Do8Y8PNfFd/KJbZZHhzKonB6ILLIM03Xs7vGDMbfGuBdkCihgxos4dDmi5L4OjiC0/nt9YPLGeLOXQY949fn+c9NfMPGRWO2QReL8OSjMUxjw+6cjb8EHTIJrABOgNQzCkx6qVEoBBtVSrHklVHVCTXIBuXgE0VN0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905759; c=relaxed/simple;
	bh=9l686+uOgKX/ycgssIaqn7qhPl1W7ue2cxfhoGe388k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrin0L1F0mG7JWYarjYIjQ68IcrCu3qqhhMMp+7y1eE8zJG4aeuNs8BbIfW0iRS9ltbDLNmrAW/iRueO5PbbXCmdfSdS+j4nuQJcZ5cAbwwAC4ldtb2xNEHU2YuYstBKbjJf1LNqhIxbSAb7vjqkATJFpeC9dBiKEvBzgoLLCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uyaGNwfY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CC2x3Fi7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uyaGNwfY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CC2x3Fi7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AF65EC01B7;
	Wed,  1 Jul 2026 07:35:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 01 Jul 2026 07:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905757;
	 x=1782992157; bh=OJ3kM7tmIhVyoq2tzDhUeqnrTbaPXYnGMfcnxMGlov4=; b=
	uyaGNwfYPJVJOrh5GvaFu8/IRVAzKArrZRW3w8J+nGHKMlcZTr+3OVcNmR9kRz6y
	1ZSHSDxmNBSF8eCerO9H5nHoycNg61xO8uR0XRtd2CZCE2x06guTaiU6MdNR/dlw
	CatiJfFzv9gLV13yDDDF3T95D3mPABFhs1jCga0QG4Bk9MmpTqu4V3lewLy7poy8
	67DzcSKkOri2zYh9yaD4UoDsiZNTt8b24v/oGjUHOihVbXKwievkq+hogljtklwQ
	tl7NTfMpjVX62c2oPABqbctIZRDZAwhEfM+lEL24dzz/LbkYArqnM0D1UZWMhyZY
	VxwZIgRtnFu4KuEtErVn1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905757; x=
	1782992157; bh=OJ3kM7tmIhVyoq2tzDhUeqnrTbaPXYnGMfcnxMGlov4=; b=C
	C2x3Fi7UtacZaTRj/b/1wI2DNP2PSCPnUrLvAd84Y2EG6WKAeAZfAFokiHZNiPJ4
	6Yu86k6UIXsm1ronu0/6kiroRQFcf4uaDd4lsxdAwGLB76Hmzy3wOvTHlwedF1Uq
	FFTmqJ64Q+yJuVad6+4wjUAdVBX4FDO3RCTa4/LPLqDsDRZRxuP4Gkythy6xrA8n
	Qa8XPjGWjxfgk8c1fOdzS4aC3pCroAkpevnmTLI0kA5KwpeMcaJ/tY8f1yQtG8PM
	9d4d4eWEWnHQfCIDWtEEpfo9HlsFRedc1IesvoqY6HlsPZtLMlbyoeglaBsKYUnp
	DOE79YP30iE9ESvqK+big==
X-ME-Sender: <xms:nftEaojbkq1Zp7FeCDwlEX-Xkn9Ab0MwTq8k8TZ1XUJHmazpNpkMjg>
    <xme:nftEaqUYEQ64auly_j_va56WRSDAlJrZVsbxq8Jb06TQjp3bcewColeP4sBiJENyj
    GWAjVY3UEV_tGksX5KM-rsjaqJWSFAU_hgQYxSq-nYGA3OKVCHe>
X-ME-Received: <xmr:nftEanWL_Y33JM0al3QgGr2x9jNMIHXPBNfTwNQuydc8qbKZ7nosF4KVeiomkOIvf85Mg-UGwCgPLJwgDttt9cdFPlWO_gMorCzvaBPyHqY>
X-ME-Proxy-Cause: dmFkZTEZoO6HolNFiuzhqEVK1EXq4BbCn1tdQX7LTJIMJcT/+latCDErJzD4+CwgisT7ri
    qxkn+QB2VfpeBpgOV5q2sBGT63aEOuYhfWwjT+wgnaZ2qGTsJfaJHBVk347IlsaCNTe39N
    jrZm/FsYSWHGfvBlbmbsEFy/XtzODL8fdqiFNJeGFn2lrHVPGPL/Yr6cOMglYCr7uBXs7r
    aXJwkPam35tJtUVY8r7/VZg2IyQl/w9r8/QisqR4rjlYUkyluAeVVxaLcVOMBGocW1MGez
    Nwenq9cyAhPKHT6bW4GOhAoe1hp9EC68DfdP8WD4TQ3JQn6e5yBMnRKyOIrDWHKuIfRTOU
    W8A/949JqAkCrdcI62nRoEpi4JXcuOgWuImL7epT1y+2e3m/4AvRVdovqEK12fT9+dCLY2
    LJQrikHN0E8EWQhbqIsDTXJH6cGGDxg7zFatJhtgi+bQv7vv5HK5NOTOzJXg1oivjpc3sc
    XUtJWfJolJ42vvRQUPU/2RqZWlnGQJF5IHa/V8l78DeQQDlmz3qJOw4fQAHQ3QAgSQocwh
    714Dr7lA0Vq4KYUqEz8Su6lZchv41/SctJyBoMXRYbyJpSR9zhgSdzkqjWBoBamw5wYxA6
    DYs3myOwcGEiDx/OuNCaBnaIIdUsaqKCCDgLG5RihQohwcHmfvLdh4+vDJSw
X-ME-Proxy: <xmx:nftEaqidS9Ugl4YIZ3vnuGMOehNFlIxznwqAlJzeXIsi_Dh-9iaJDw>
    <xmx:nftEaiaHv9UQT-95pcjMwG3RpX8GWQ2_VMB1Yil0XvueB8YNJLLY8Q>
    <xmx:nftEanqzzp95LyAvlCJO-1kgKeVTMM-eQvEAXA9-CNRs9fzKcAieWg>
    <xmx:nftEavPi_etNW12cbcFThUqjtfxKZsZvxeS_k_jzIY3WU6b3ELQ6WA>
    <xmx:nftEaq87SaFs3zv0lOVWmD8j8WhgDz5TOAJUzWsFvSLA-xL6fcqmB1QW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 860111e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:34 +0200
Subject: [PATCH v8 07/11] reset: allow the caller to specify the current
 HEAD object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-7-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When calling `reset_working_tree()` we automatically derive the commit
that the callers wants to move from by reading the HEAD commit. Some
callers may already have resolved it, or they may want to move from a
different commit that doesn't match HEAD.

Introduce a new `oid_from` option that lets the caller specify the
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 5 ++++-
 reset.h | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index 4bde5d8dc6..06f375f296 100644
--- a/reset.c
+++ b/reset.c
@@ -122,7 +122,10 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	if (!repo_get_oid(r, "HEAD", &head_oid)) {
+	if (opts->oid_from) {
+		oidcpy(&head_oid, opts->oid_from);
+		head = &head_oid;
+	} else if (!repo_get_oid(r, "HEAD", &head_oid)) {
 		head = &head_oid;
 	} else if (!oid || !reset_hard) {
 		ret = error(_("could not determine HEAD revision"));
diff --git a/reset.h b/reset.h
index 38b2891b53..4c992ba671 100644
--- a/reset.h
+++ b/reset.h
@@ -37,6 +37,11 @@ struct reset_working_tree_options {
 	 * The commit to checkout/reset to. Defaults to HEAD.
 	 */
 	const struct object_id *oid;
+	/*
+	 * The commit to checkout/reset from when doing a two-way merge. This
+	 * is used as one of the sides to merge.
+	 */
+	const struct object_id *oid_from;
 	/*
 	 * Optional value to set ORIG_HEAD. Defaults to HEAD.
 	 */

-- 
2.55.0.795.g602f6c329a.dirty

