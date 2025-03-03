Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3323E33C
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034712; cv=none; b=YoK5kmDn6EigJzo4Dq50Mtn0c7WaLDery3lZmCjbr7WAyZKQxWmLVlg3O09rATjcLiEZVsAAXuzNNidfxZcLi5DmOZ3kqM691R+yDsEFP3/+ja5fiYPdpbLmLISDgHwJ/WK1NGN87tbN8PS/cE0XeVNIKOK36DHEq28OAIqU82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034712; c=relaxed/simple;
	bh=ZJm7Tv+uW5nZ+e4R786xnYnkG4Kye2skdI5S9H2f/oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG0+aod5OQQWzso5LjoXBGZWs2Lk1lwCfR88LrPTCMQOBYn3stzvADct1lQNGDy2qtfCms+5b/MIMHW8uw4xgeM1xxcJX5//1TcGQE658CK/U7vsV78RfgeH2O+vT+DKrlWhLuw6b9hH2sItF55okCOWHogmRoTgS9EjIORLNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v0AVBIJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3B+Z7Npe; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v0AVBIJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3B+Z7Npe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B58E1382C57;
	Mon,  3 Mar 2025 15:45:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 15:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034710; x=
	1741121110; bh=p3Sta/DfbH9vs4Pcb3K5AY/jFZYDpT2rol/saTeahiw=; b=v
	0AVBIJ7YshtV/IMj+qtSnqLGu7XYudXp8tC+UNMZO7rcd6lXqTQ2uchb+3cRgYGi
	CJVL+fa+HcLlohAQ6iylW18R7B/JCaiOQORPz5njLmrL77yf+F75LjGd2mtWr20y
	i7t4AULpvQe07AWolhCvtI8oUXLKQWNEvbhjervxMdV5sVJWqM1JhPUyIRRFHaOi
	NDaB4k8tNBTPDx5i173oBUiB94OhKXdmsMeAkIlr4gf/6e1b+I/rfhxZvnZGIFTo
	uQSatJcplli9cwbyVtxqgm1IrnU3r3k3N5usiif7pd6u5lY0VJMTV25B2TOuNCmP
	HFCKp9FSA17lLG3PXd4Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034710; x=1741121110; bh=p
	3Sta/DfbH9vs4Pcb3K5AY/jFZYDpT2rol/saTeahiw=; b=3B+Z7Npe/X5WBrJwh
	v3IMcD7euXSG+oWPp+d+Qp3tR2XaehjzFiV4Mlrp88BXFVDm4R0bvuXAbgUWcnV0
	fPUugW/1wO5VwOvpifdUGPbCa/oL4PSIiItqEUtf8iAq1eOaF1utH5QpK3J0dzxg
	bTdpsGps2j27JIw85qXNdtylAARKq6z+5W4SINUzSuGveCS1IJUVdu9wot6pd+yl
	+xwCtQKmo6tjHyh3R4EWyoJkZBHT0x5bHQ/zftaM/y1Js9VgD0n1VmbnQaW6AsGC
	OaPM48Lrv8Z0cYEMuXczAJCv/D+acP5F8ez8bKm5xH7XyCD9pCq0bN0yBaz7xd/h
	Gl/+A==
X-ME-Sender: <xms:1hTGZzkUMHjIW9erbI7Zry0Q6vSzB5jltN2_x0742ulpgTSDI4n_qg>
    <xme:1hTGZ23uJbniRsaFIz5w6FqLuOI4UayaQAio4eLhZ-Rbi0KkIqrFB6v35vGtH2ctS
    yVixB68zOx4hXN2FQ>
X-ME-Received: <xmr:1hTGZ5rKODO015c4Zsm8pxZ8HufHtZlkhXXZx0OriO2D46zFMEawnq3fn5MCvHEuXOUbLzCEjK-n3HoFkG9bn4_NJVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeehleehle
    fgtedtkeefhffgudfhudettedvvddvleekudelkeeukeeiudeiveefudenucffohhmrghi
    nhepthigthdrthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:1hTGZ7kLEGz9oY8LaIv49lZ9qpwHA_0rBW947wDz8ojHHEUDcxFXbg>
    <xmx:1hTGZx34LOZaElvMGThHUIAd9Tpqq1tH5U-2lePNl1itVfk-_-DI7w>
    <xmx:1hTGZ6tOssn9kO66JSVsU8roQPZHyjHdg5wl1cB2-_F5FcBuRd4VqA>
    <xmx:1hTGZ1Wy2lVDoX1Ia5MKccj7tdwyU61WFrfIxzzpNKG-6wS0FqlGRQ>
    <xmx:1hTGZ6y-NzgPcnwAmvo-DCYmK_1ov-uNhxv8KcdYmgiyRBKuizfDEFG7>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:09 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 24/34] refs.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:22 -0500
Message-ID: <20250303204443.360595-25-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 refs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.h b/refs.h
index 09be47afbe..31c67a71b2 100644
--- a/refs.h
+++ b/refs.h
@@ -577,7 +577,7 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
 
 /*
  * Return 0 iff refname has the correct format for a refname according
- * to the rules described in Documentation/git-check-ref-format.txt.
+ * to the rules described in Documentation/git-check-ref-format.adoc.
  * If REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
  * allow a single "*" wildcard character in the refspec. No leading or
-- 
2.49.0.rc0

