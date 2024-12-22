Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACE15B554
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852295; cv=none; b=T8OVQVNz8PTKCcwuqPNg5Y0dB/eMD16UN2Y9/gf9WybkUgFq33XxQ/D71VtjJEFcmDNJ5TJISvgdyEql4aUqvyQfi1LGt5NcBEccq0B2+RIJDL4S1V4p9ZM531/efe3bTR8WEIdTAG0eNFylZoJ3uemA4Ae/kJYulfSWbkgJQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852295; c=relaxed/simple;
	bh=wzixTvMRTYVAde8xzENZMNKqQ4ftU01bPEFhhl1TM/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iuxup+eYFssCXcNb1P02QjQaVtxCeXz2aqIa6BP8v8txhwtAi7FXhEMspC4GUkpUfDuMBaVkh7l7pIZrWVG6tN3we329lIhZ+anegJVsKTKYqh+w6aKtCUJpESidVUFQEAXkP4pfVMVk412288MILl7GpD25SpbKmFqIg6UY6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZPlC2OOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hcosWlXe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPlC2OOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcosWlXe"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E7A78114017B;
	Sun, 22 Dec 2024 02:24:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 22 Dec 2024 02:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734852292;
	 x=1734938692; bh=bWOmNsq890tCQ1Ux3Gv89ne0GrtNjyo/ZZyuT1rkEVs=; b=
	ZPlC2OObj8FoOlUqA3RZVzyD9BgL6pEHvtlEJwgc4PAZXe5/lsObTMT97wOb5d8B
	PhqIdefkjT6qTo7QtoeluAMkuIRozOW9IXlh8x28S0gyDnuV/eHd2sBBbq3OkCY0
	YFbDwMCvNf74bcoJzq14sH08tvXPzKXrwk6O2PP/UmaasOM9P07WPtw1WsNxBID4
	6Gsyy5feJpJSmncIjx3hVgLbN3DVcS4LN8/xwh3MKIQEya/WYc81/+UIvWk14UJE
	fFDLC9WIfKaJcg2KVUQFSxafQRXgKMozNp+wcV1Ng/ZVSotmT1x7uHe/f/l18OJH
	hOS43w+7NsRjzat9YnYfhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734852292; x=
	1734938692; bh=bWOmNsq890tCQ1Ux3Gv89ne0GrtNjyo/ZZyuT1rkEVs=; b=h
	cosWlXeBkxGSnot1vqRRD2zHeFTV+YT6rQofkOibdO1uBiZA6CCWEgzevAPHBcdc
	QhmTwKCNlknhipf12+SItmcUB/Sfx4iveUkJN8iB3x8/brMIbwEi5+npZxnM6AAI
	QInBXeSsz1c9OCzJqcwGA72FEaMyvDzp4+B0iKvDcen+GUxcfqYcppKCQEUPLJGg
	mPxeJhcXdxyCUksX9mp2wSFus+eWwik2qOD9/tI372FndvhV+yzmq6bh3aMlNRua
	jiMnjVBDELaRNMZkmGQA1WlrM8Xn9US0Ok/WHf+ijSe0HALwE56opvrw5ctPJEdp
	/QXYhpJf/UHt8sQ4FIdYw==
X-ME-Sender: <xms:xL5nZxpcEfceDffS7hUHpuaT1gDTuH-mASbPZPGg5Bh-ME5ScqEc5w>
    <xme:xL5nZzqvEYejOjReBEdUaJlefZvEJYA6C4Y3_GY1iORyXFM-ByVwxandg3ZZZgDCt
    nSoTABc7TOD2qHaCg>
X-ME-Received: <xmr:xL5nZ-MPzjJBfUeFs4i5R1WfrkYeJFZ3Ez0Yk2WXGJo-WIoYCT_euYBIMLl9R8YtYxNlxG17NRanrjhRb9nDB9zw1K-p9MAIU7JT2V8LwIkuyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghn
    uggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:xL5nZ84hKohl8i9qGHetu6JY9_XL-Nu_H3REMjLOK-o-1oZ16MR8Ig>
    <xmx:xL5nZw49e95jU2k8s8znPrZ-nf6xqhhlwH6u2Mg64be1_C3PDl_YaA>
    <xmx:xL5nZ0gvImHV27-HuoBf74YPwFUbTWlBpooXuDS3vY3JSbLzMdwjTA>
    <xmx:xL5nZy5jBou0Q_WqmF8xHIgIAL5PYrAQqoSo2IYrF1zkvEHnVgtdMA>
    <xmx:xL5nZ73pAyBawcuxTYaIqmrsgBhQctjJHKOfNM_AfQ3b6gWkMRFj1PLc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 02:24:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2578ebd7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 07:22:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 22 Dec 2024 08:24:29 +0100
Subject: [PATCH v2 2/4] reftable/merged: fix zero-sized allocation when
 there are no readers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-2-19550090d15a@pks.im>
References: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
In-Reply-To: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

It was reported [1] that Git started to fail with an out-of-memory error
when initializing repositories with the reftable backend on NonStop
platforms. A bisect led to 802c0646ac (reftable/merged: handle
allocation failures in `merged_table_init_iter()`, 2024-10-02), which
changed how we allocate memory when initializing a merged table.

The root cause of this seems to be that NonStop returns a `NULL` pointer
when doing a zero-sized allocation. This would've already happened
before the above change, but we never noticed because we did not check
the result. Now we do notice and thus return an out-of-memory error to
the caller.

Fix the issue by skipping the allocation altogether in case there are no
readers.

[1]: <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index bb0836e3443271f9c0d5ba5582c78694d437ddc2..e72b39e178d4dec6ddfca970b5af71b71431397a 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -240,14 +240,16 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 			   struct reftable_iterator *it,
 			   uint8_t typ)
 {
-	struct merged_subiter *subiters;
+	struct merged_subiter *subiters = NULL;
 	struct merged_iter *mi = NULL;
 	int ret;
 
-	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
-	if (!subiters) {
-		ret = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto out;
+	if (mt->readers_len) {
+		REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
+		if (!subiters) {
+			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
+		}
 	}
 
 	for (size_t i = 0; i < mt->readers_len; i++) {

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

