Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA21F130D
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296441; cv=none; b=OQd2gZx0DL2fw0DJ0kkymOZR6fMnncR4IMCGZwRs/2jlnb+OlBg0yndU0SVFOxU3/hI9umT7/rEeJcrm7YqtpFQRSUxp0LD4WTpcQFnnbZ5rsC7iERc0qOX0EG7urFE/aoJyT5kIqzUbsar6v2B4GCaQaVzWprgCcha7cvFsUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296441; c=relaxed/simple;
	bh=EUDVjAVZVhB7sueLaL46VD3nXlV8Wdoxtj0CwK1eoqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJfxA83By8qgO9t28cK2atpBH3Yqw7wy26ZolXAGHdN9jsNtFIWOcKVMeMY5mb/18j8HD9XV6leV2jClbk2DcUQxBOOQtCraxzFpUT54zV4z9jxEdsgOKcBai3lzob1jQiQkzH8bZC+5JmmYHuH6d7CcZOUXpEiYYTRZUtOXSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pYQhVV1l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5gfFIwD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pYQhVV1l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5gfFIwD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A380C138009C;
	Fri, 27 Dec 2024 05:47:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 05:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296438;
	 x=1735382838; bh=/e4A7vHStJBS3+u6Z7NkXFgt2MTauRhGc6L5fOlUgoQ=; b=
	pYQhVV1lFTaCoqSKOM/KabkX4Wvnbqm2QCQ9GuAXu8PmBvGTvGuQeseeYzNDgkzc
	jBh3tVOFEFGRDNrZNeZXRffG7mA7R5jnSfNVrh4HpkWwG7JL5iQWkW/zNwy81+EE
	S9tlyOIOEuu7XYPOVoT29R+D4zVPovtXqz/sh8Ie9rA22MKxvoRwIvJC0dN3FtGr
	dogQ3axHMMlok4p48NhXhZRLKDi9WrWgCbBOrXX1UCI6A3MYsi/vcIeRfCURVHon
	1y1yoofNuPnyIyvju+74qK1kCuCgF6GCMD78pW/aFWsrRUTQTnJVwd/wGDmphwyp
	s6GDw+2aK+RRFazdVfRa9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296438; x=
	1735382838; bh=/e4A7vHStJBS3+u6Z7NkXFgt2MTauRhGc6L5fOlUgoQ=; b=W
	5gfFIwDLbYVETbMJWRSucE93KEepJ4AkDsiTT4FLNbSDHMkNqFOIdtKkkJjNfuNd
	NvtPqGeD4hn5B29QgM0/9RTb0EbmqwYEtthyK4KNZOGCEmbDvnaHEl1ydDCjRkQQ
	2E9pBvpu4NHQr8tz65ZcEkqybIPtHavO0CNyCh2q03Ee/BF61lMMQUK56HkA0rBp
	idf/cVOA2q8eu/IO5gXCvtdfR3BAFeHoSRadEwd4K807QyEGZToMA2PrGWibB/ni
	WfynXz3svX1vrOk/lHyYlXo5dVedgPcCIXHSWOzK/VBNKia46KF4rk7MVTC5SfTD
	nupCQkei77PtJz2/WapsQ==
X-ME-Sender: <xms:toVuZ7eImxQqVZaoF2lOSlgBZaQW3ogCriKbeEFmkF--ChsyQpieHg>
    <xme:toVuZxO8t4VMLZ4-IUj5Kidy_kk3GERPBOG8AZ5-oW-gUcfkQBKXXpBG1LAuDSj1d
    tTaT1kkHsx92-QzVg>
X-ME-Received: <xmr:toVuZ0h-GNX3qxON_hDFIxvSZPT-7uIaIJB99IlCFngus1ovEutL-Qcs9VrmgXcZh1LIOJ82aveiGNr1wTHeHvlfVZKfhXHlJ9yi8dpE1nb_sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    ht
X-ME-Proxy: <xmx:toVuZ8_gJdz_xubTbem2dS_ogEIb_6NXCq0Sn5I5W3pkUpKu2lkJGg>
    <xmx:toVuZ3t2MsHAWUAr7VMvw_O2wq7BTP0h2G3Jm5ndQu7ahqDwGKqGTg>
    <xmx:toVuZ7GQOf3HaEWHqxdHTJo38sVXuqGhor3VY44NZtofQGXSqOYEJw>
    <xmx:toVuZ-MyS91EJC5qEMUhZpf47ohYoguC1P3KiZVdQE5MNBMZ6_91Zg>
    <xmx:toVuZw64qYBftm6jk60sJ51S3s_acGxj6kTPBJFe3bD0H2EWU9_IGqXp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1ccf9c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:21 +0100
Subject: [PATCH 1/9] prio-queue: fix type of `insertion_ctr`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-1-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

In 62e745ced2 (prio-queue: use size_t rather than int for size,
2024-12-20), we have converted `struct prio_queue` to use `size_t` to
track the number of entries in the queue as well as the allocated size
of the underlying array. There is one more counter though, namely the
insertion counter, that is still using an `unsigned` instead of a
`size_t`. This is unlikely to ever be a problem, but it makes one wonder
why some indices use `size_t` while others use `unsigned`. Furthermore,
the mentioned commit stated the intent to also adapt these variables,
but seemingly forgot to do so.

Fix the issue by converting those counters to use `size_t`, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 prio-queue.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/prio-queue.h b/prio-queue.h
index 36f370625f0802cb84082fea904ad6e8a456520a..38d032636d4cf9c544811cff6c3e6a080d6c7b82 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -22,13 +22,13 @@
 typedef int (*prio_queue_compare_fn)(const void *one, const void *two, void *cb_data);
 
 struct prio_queue_entry {
-	unsigned ctr;
+	size_t ctr;
 	void *data;
 };
 
 struct prio_queue {
 	prio_queue_compare_fn compare;
-	unsigned insertion_ctr;
+	size_t insertion_ctr;
 	void *cb_data;
 	size_t alloc, nr;
 	struct prio_queue_entry *array;

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

