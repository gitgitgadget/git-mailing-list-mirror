Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CB2DF15B
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840886; cv=none; b=oYQCKZ3RzFJ/0miwqFK2BbHOJpkdUJQ1YTYil0OR7jdsWjdm7Im26sgZzQrz69xyEzERJDIRO4y6x5z7eZ8a3aY5GpVIu9HgHtFQKi1ePzme48ekKBJeMvfP4x33JQDVZZorQ1Y4TYTSb/xmvYK9rcbtj0DwLrFnQcUqqe6RWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840886; c=relaxed/simple;
	bh=wC8YXN97/EUUuGHq8jyHqO5yqd4WeDLeWXZQQGat3W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdS61pQmnV3AppydXQxzQhEAwYNkptMJVW+E+uJwTwbTRMDQo6E9OdZqqd925EmOKhweRJgrha09VW2NicFlfFSlFKWJnFot6dNq5liGMTP5wpN/wx+85yoMcPYhExZc7dLIFjUna+xHNJMmNhx2x+0jvijmlBXxsrL1Y4YimF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=In0IKmlS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ElsAg1qx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="In0IKmlS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ElsAg1qx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A1DDEC03B6;
	Tue,  7 Oct 2025 08:41:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Oct 2025 08:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840884;
	 x=1759927284; bh=FPC9fnxItzALtTEzmL2fmYoYRRjH4VWtp3ofMVjlKM0=; b=
	In0IKmlSQ1Mf153b16Wz0dziWAXM3MpJvyHtoctrXGREA7auIcqLgmFa5sPb4QNq
	b5mXciFrWlcocsaPv18PbUMF9NUc04xVE3+xxvphbPCGmdr5AAAy6pFEGZpKO2Rl
	KxbQZ0xBD9OgP9s8b9iEDC4dPMAf9IqcGSipjm1EWY2+2pKOsS97+ysQvWo8TzQd
	4CalG7cGnGH8lyOcHSSMOdiSerYlUGu6C7GttXlqTpYmf/LIW/HgqhLs57J2Conj
	XJRn3mkxjaUMqP9pHdeLLwCOnLciI7BMbXs50jSHfzmbx+4Ah8aaNjS0qdaLBvbd
	pk3di6ZlkPZFDk/jqx4ltA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840884; x=
	1759927284; bh=FPC9fnxItzALtTEzmL2fmYoYRRjH4VWtp3ofMVjlKM0=; b=E
	lsAg1qxgN/Ol2sF2KCaT+YUQTZLzTAToeDHNX1qAc2tS07ZRPS+zj24V69RtHkeX
	x1+lbjnF5ZfqamUJXWeZds9g5oV8NEsfgz6yTrTxa+bMIbCTOHv93KJG+KJLx1jY
	DxVYgBKZFMi1RemZI+KhxR3Zqc3WEFOHKwdDVLGrnkXe4sgo0v0XWdyFFePRUkLN
	50i+tSQ89y7Xs/VYHS0R3edA9DxPSbO3r6IplTIVyIbHsdPofVthlUu1oCOasZA5
	XnHwwsRdfkcpLkc4+aydQpzwgxexqqtWxa+TIf4E3aGIClOknkWdCd0tlZ7yK6pM
	bZz1wIsM/B+GOF4FD+RVg==
X-ME-Sender: <xms:dArlaDbZI3KJfeJPtZShRkdFhL6YHt_YHfNVNkGiti6bavPrWeY7Zw>
    <xme:dArlaIafxbjTH04A82OyjsF4HTrlQBtNVZNxnESQHz6RvaXmHvq-VOQWl59wJhvJS
    S_8viwad8JJwpAtwE9n3wUCX6HWPRTDA8mfG_YPOBGxULSnTWcT>
X-ME-Received: <xmr:dArlaDlGSLEo9GVxnlOEXV8TJaB2DJyRXLh8W9qWWf0znpOot7Akz2H8OiadFO7cvglJBDtTYQ3rwrJDF12Vk3ezeKnHEx0C0zHzaYpl2JU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dArlaExlQ70RzUdd4Jsc5qJ25s9YwqduUTm3WeL14m6alvH3luEwkw>
    <xmx:dArlaBPnilbkrxrReYO8efEfvD2KYqmCT7IDPVkZg_ktrKM591bTlg>
    <xmx:dArlaIRg28ErqbL6wxCcXCOjD6kFvHx12Zl08zfHpQtTTHSaK5-nnA>
    <xmx:dArlaPZiY_ABs5tjI-Ala6pdIv680wjyjD1dFN0YrUeJ6oAsUNZFfw>
    <xmx:dArlaAgPhRkS1kckyKh8nPFMmzh7soumcybS-cTC6c5se_800KFrR-xP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:41:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49380753 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:41:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:41:10 +0200
Subject: [PATCH 4/6] packfile: drop `packfile_store_get_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-pks-packfiles-convert-get-all-v1-4-428227657a89@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

In the preceding commits we have removed all remaining callers of
`packfile_store_get_packs()`, the function is thus unused now. Remove
it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 6 ------
 packfile.h | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/packfile.c b/packfile.c
index 5a7caec292..db748b0bd4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,12 +1027,6 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *packfile_store_get_packs(struct packfile_store *store)
-{
-	packfile_store_prepare(store);
-	return store->packs;
-}
-
 struct packed_git *packfile_store_get_all_packs(struct packfile_store *store)
 {
 	packfile_store_prepare(store);
diff --git a/packfile.h b/packfile.h
index e7a5792b6c..3f38c63476 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,12 +136,6 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
-/*
- * Get packs managed by the given store. Does not load the MIDX or any packs
- * referenced by it.
- */
-struct packed_git *packfile_store_get_packs(struct packfile_store *store);
-
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.

-- 
2.51.0.764.g787ff6f08a.dirty

