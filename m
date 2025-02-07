Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0621DF99C
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929138; cv=none; b=pCIP1V1Qi/StghrjARGp+Jck+HQii+JIMmeNXAGvLAbkH7Lxjk+fKPintGv0VNhwGRzBC2hLUBcE+3YEpBi0MCzkto33QouIBPinBRMEggf2FaMnuskfneKu+1LMEEAuSTdJdPpTQp2Op8eAml5SoTxd3ltBYAad+zdL6jlmrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929138; c=relaxed/simple;
	bh=PwtwJgqncRkQ+/QmJZLIt67toje4FcAFM/hKDh3beEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQIsP05OgChylWVojqANnV5r3YIJFbqQwJnO636MlqeMmwiBmBURd5Ik6H7luGZHpCnmtT5Aqg53NCAUPiZelaHv2VFyXQDv7I/1BRbKFK/Ccln7UGWDY6FlRn7wRkBzsP6iT5D3GEdXWfWlFBfl8JTJqZl+O6fvqxX2g3JtVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GJS8mD+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U8fukNf7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GJS8mD+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8fukNf7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DAAF138017E;
	Fri,  7 Feb 2025 06:52:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929135;
	 x=1739015535; bh=WfB8amsHkYCbCUYxXEFCoq/KZGT+ysKHg7ZmZqXzx94=; b=
	GJS8mD+PDMBjCZOXC7HfUIXMaWCWbSFTsfFVIPGut+lseTaZ3vnELEec0FP1nyY/
	rpednJI/S61ZcZbzO/y9FOU2edqIVRtqjg77miK4lwjdapBymEJXkDl1t+f3HnsU
	0fDBFNoEHTSUk5MyXn25bnYLFtoZP9x47dqst+Ah7Rpr5UpWo7QTEjp7b6FspPtG
	qj4H3CF0HmpInkqVdET85NvckMlCo0mOX1gHIZM91n1I9i4BVCPtnMNp2VbTW1sy
	DyXhiIVdeMOVJenGoFdAueTvfQEEJ4cav/4H9lMBMqhhviGdsOp11ZS4xRFAHOft
	CPCqf0tS1ah66z6cEDGDrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929135; x=
	1739015535; bh=WfB8amsHkYCbCUYxXEFCoq/KZGT+ysKHg7ZmZqXzx94=; b=U
	8fukNf7Bqluz8AveyrPLPrxqbjUebe0F0E1urdJX9IMbVZ2L+Ci7h+q8vG9Ei8Kc
	ee/AqOuZz84XlqhePKMwHxJjshrtvYj9+uQ1MjWAZ3TrJ/TVo3s6zXoE2k790Tf9
	mDKiduKNWHBbE4X4sayjwWrVIeWQFA4pmgqRPtMgY7POKO/krsANtbl8I5AVBLbx
	fNAoEzbEE68WL6vtceFCfzGORVmUvh9ixN4LZvbLu1tdvSu6nwLEq6I5OStvUL6P
	R3WABWo6rgPQvGSJWJ78vF45O3hFokMuj9+mShYJ7YhiePJVDT9WSydHVsZKCbC5
	mHCA8SKvAf9t1l8l+PIRw==
X-ME-Sender: <xms:7vOlZ3a6vt0XUza7jVSM0F6WZPWPHKiPGok-E0msjigryTZ5cNas1g>
    <xme:7vOlZ2aEeUaOsZJ5a3u5j2lLQbODdJcwqHuQu8nL3S5TFCFp1E_RwL25VfGVzrT_x
    feeCuR4VvhRT6mZIw>
X-ME-Received: <xmr:7vOlZ59bGajsJgOHcqPCZGqWU9wNJTeQZV9jR-RxfIwcUM6xS2ITDNRvZZiIBscpjlA2z6qjVLpbtv_OgKeZHCjeaPork0aGohPQcMd6mN9vKUZP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7vOlZ9pIlPjN_p3WlXeolQ-rRoksY7oyTFtogas0-BUmzlGQGDD5LA>
    <xmx:7vOlZyql0oEBQJamzaA8PJ-CpSnZW4k14E9g5v1YjMTYSTv4WVlgSg>
    <xmx:7vOlZzSrsraXfxmY3mgH0LNFov1YLLCQm7tzR9N6uKKsvYuR5QFoWQ>
    <xmx:7vOlZ6ouca55b8-0NO5zgOP65doeuEPkKG18ZJs_jPqNxA181D_R3w>
    <xmx:7_OlZ_CC2qgyZG4VmKbC6srEbRxGXl81Do4kyJmy1kSzj6ljOihvfIM5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1bfbef8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:05 +0100
Subject: [PATCH v5 10/18] reftable/reader: stop using `ARRAY_SIZE()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-10-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

We have a single user of the `ARRAY_SIZE()` macro in the reftable
reader. Drop its use to reduce our dependence on the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index bf07a0a586..c3a3674665 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -849,7 +849,7 @@ int reftable_reader_print_blocks(const char *tablename)
 	printf("header:\n");
 	printf("  block_size: %d\n", r->block_size);
 
-	for (i = 0; i < ARRAY_SIZE(sections); i++) {
+	for (i = 0; i < sizeof(sections) / sizeof(*sections); i++) {
 		err = table_iter_seek_start(&ti, sections[i].type, 0);
 		if (err < 0)
 			goto done;

-- 
2.48.1.538.gc4cfc42d60.dirty

