Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCD2361EC
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855873; cv=none; b=nMkibrRhfi/qWoEXwXGQUIkCr9U0ukArQDX/HW7qxEaZzNmOjagMpN6p/iW5L+wk+ly+LHdiwtE5iqsW3UIwdtLxsTyAE5mZJiBces6+J0Rm7bj2xno31YOWEofOJ/m07NAEDPdXrcejb4fXPL1Xw82P2fKRBBnPMN7aWSb8BiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855873; c=relaxed/simple;
	bh=r92l7z9HmELnrzTDskMleuZv0HTmrO8UpFxH8Wf/duI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPl51mVruMyVDoOwbZEvLBvYCe+tFDcInqrywyUfqioK+fu8xpnXvwUXk7XjMiDtuE7BrDzt31KBkkr2c60jvssaXTEBDbQY75RLICNCspbkgAon/pMRDSzRTRfdtmBg0Q6NnciLuH471iG45ujYEZPR6CKdhqRdzFGrZ1dWzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QL81PNIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFyVVfy1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QL81PNIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFyVVfy1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E36751380389;
	Tue, 14 Jan 2025 06:57:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 14 Jan 2025 06:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855870;
	 x=1736942270; bh=4thj8EZ6nvc4ZWyvEIc0Ju5Ukod5vB9FH/XIBmTHlS0=; b=
	QL81PNIByg++rwOT30LJMo2krzT1zsmjbc0UdQ7OLx24moIPV1F3L+hoEDLfaaFk
	8E3QBIxUYfmLXXKRlZp26WHqvIjLQaaYzntbDxgFi6dc1iQwDknEyQofi/GSepO1
	X1qOGqgg3vZP/lysb5fonNLyqaRhksTQ/I/cQi2l7AFugzbe5k/dBqrB/k4jIruM
	MRS/x6oAHA07TMSTPiPP36ZauZglJ1s3xwTNXDQMgXG4mGhaRK4w9EvWCyTYMa6R
	t2xUfGF4/pB99Kr7Y7mupfknt/qPwihuArjopBdqs3nE+re6hyigo8bFN9VhICCx
	DxMolh7W+RiHFjLISnVUSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855870; x=
	1736942270; bh=4thj8EZ6nvc4ZWyvEIc0Ju5Ukod5vB9FH/XIBmTHlS0=; b=V
	FyVVfy1DtFUXn9TyIm7fSMBRfPcU6bY7M5h2ueYDY3EtQoEhBjEaaOl/PKXmOLSd
	uCqRpNSSxUbjG2zemv7qBWMu2/qTxcuH4XuZ99POFRTnC8PuVPuELojlS6RQFqfH
	I+lYN1xFje1VSOUjNyg5Kh6BD2hQs0zQL8pH+XpRiYHfzoeHisXS3GKNlxOpJB6W
	ASwN/fukmvz8t9UKdrrnLkERswV0XzPM0TY59Vx9cAYUIdEwf5OBId+FqmTUCZ4W
	YLKJfg9iYVbCShG0PW2Pyjs+r4v68T21aylIrCckEzPvUXHMrCdMa2SzDxx62XgW
	RFeK8a3ZwrlOa1mqj+3kA==
X-ME-Sender: <xms:PlGGZ1ddjCib6dS8Z0gJCz-FJa3kuJtSnPL0RbcWc6wPC2UCNpSldQ>
    <xme:PlGGZzMEyiWcJ80zTK2ohvZYUfHLWzP1kqK1gr-rgxYFi-6lpjWyo6X2WQfsLmx7m
    P_p1Sk_Nk8ed78vjg>
X-ME-Received: <xmr:PlGGZ-jzLacrbKLRjj7oytYWYHeUbNroM0aQTVuWle5XyqkCE9Mn8WJMj6Fh6Io8_2Ogjncqic9L-r_nFM6F0J1vD3d3TzIp3yjKOmBe_b1RRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:PlGGZ--1dsY-tj_lv-p0BCvQEyPAx78JTmmXqr4pKME57HhrWMIQDA>
    <xmx:PlGGZxv1l16tBykcoDk-qxKBhwga5uYroIP8rNum9rmLtFkmUhWxog>
    <xmx:PlGGZ9E6tKw9o_yy-pZNJbi2I9yADr2RtKMKMnMFFmk_eWMrVcBCQQ>
    <xmx:PlGGZ4Ni3l7KZE6ij0q6BBV1V5R5KjJuaTpVIJ5owLIaHVZdKIY94w>
    <xmx:PlGGZ65qhIEae1V9UgrtzsDSg1WvLwRuaYUEBagX1Fl0uFfV5VKZhGW4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8273091f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:46 +0100
Subject: [PATCH v2 05/10] compat/zlib: provide `deflateBound()` shim
 centrally
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-5-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

The `deflateBound()` function has only been introduced with zlib 1.2.0.
When linking against a zlib version older than that we thus provide our
own compatibility shim. Move this shim into "compat/zlib.h" so that we
can adapt it based on whether or not we use zlib-ng in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 4 ++++
 git-zlib.c           | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index bc20b884efab72028d5f696923e9800e39b08ce3..96a08811a98ff7fa057f5682a5303a06cef40cd1 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -3,4 +3,8 @@
 
 #include <zlib.h>
 
+#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
+# define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
+#endif
+
 #endif /* COMPAT_ZLIB_H */
diff --git a/git-zlib.c b/git-zlib.c
index d43bbeb6daa4c195048f7012e0bccff8c5b4b5f1..2e973320c232438cce7c83e25cc60a6b773670fc 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -147,10 +147,6 @@ int git_inflate(git_zstream *strm, int flush)
 	return status;
 }
 
-#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
-#define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
-#endif
-
 unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
 {
 	return deflateBound(&strm->z, size);

-- 
2.48.0.257.gd3603152ad.dirty

