Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20509200BA1
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203791; cv=none; b=UtxKM0P/eSBI3cS7WyJGUMwApRPCX6WGoQr6uCneOk0FxOtXJP9cS7UcTi9Uc53gVHVaF0iwIRpkucMY8G+Ue3rYMahF982S18+ylhyz+JpDhSjmZW3TV7GNqHFhlFg5r8zFuQauSJIpGnhkXaHtpQXStWkkwvdjs4foaaDVZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203791; c=relaxed/simple;
	bh=5nPEZsokYTKr5/DybYcvCw0pFyCDVajSaWwbAZ7jj4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUbcvNytXj2OiIflcXqbba9Ls9KFqUUurYXx3nNdzkhX9ob9MxJ3SZ2pH98gIBIZE/OSrG8HIbt89N8o0dPD88+25RMIrdeDhFencE+851HcEbvq0TtVu6st+PBJdhpUfo1G9Kh+YSVIM37pAZ1P4dzTE850v01s7T6wvXhYfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rJBb7ER9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xkookKMq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rJBb7ER9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xkookKMq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 553ECEC0129;
	Thu, 23 Oct 2025 03:16:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 03:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203789;
	 x=1761290189; bh=PYAJW0g6y7zgj1ho0/oUHUxVv32rSGUMUhGBunbac7w=; b=
	rJBb7ER90NXcbPv80KykDc55+sCV6dLdDKapLmEYdaH/LjvK1jD2+12xRHL8yh50
	+asXXQdLsDOt1sBQZG9G4tdiVtVj+cl6POJ/TC+BexFHtqItKieNHnnNCw/oGBGl
	sS/BkBJ0z2akhESpcQPZ45R3cFEmLU3rQOjQYRH/lregTtcJzofEVMkLBunqhGj+
	Eg1AdgOdwrtacrh1dWV/MOmoeK2pTFX335XJLaYBYfBv6Gw7TCXvNexmmANCkiIp
	vwDqlTT7WNcROfMhR9TLWQBP9fgfj8F+b/4Q8hHmc+W7vxaWEyXVl9CiqS1kYqoq
	nhd03a+X3FaBXwP0WuYb3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203789; x=
	1761290189; bh=PYAJW0g6y7zgj1ho0/oUHUxVv32rSGUMUhGBunbac7w=; b=x
	kookKMqqBXtAxSiKeoEtI+dBYuhFGa9vK0tiCiRPUneQU5IPLfina6lBVHSIo/cI
	VhRB4bJOepR4c4YSU1DsptigstExnSOkO8YPA4XBEm0L5yC8vCygR+uJ8AYgFZAV
	sjhwOQR6lXuft5O51q4HUAUc/T631BwUKnmYIv2ckX8P35l6Sjcack4LZQiFVPMi
	jYy2MEZdH7gBhX4RyULRGsT/oiu/aVpePya4T4RCyPGsqd8lFLVF9JkOV25p9JRv
	0oEDnisuV46dSIFkalcVFDDS8FmZyNKvSL+InjemetziAggpuBLMQYHs2r2Dzep+
	WuQtfdtXFv+Kbi4Z+t9ew==
X-ME-Sender: <xms:Tdb5aOdEZj3iA7yDfYe6AAD4aAvo7MSdBVOr_PbADUE4fR0iOUD8IQ>
    <xme:Tdb5aL4h2NRj81X0l72gCZSIp4u32OrkxXS_Ue1075DOjar8vEFxUCg_zjoArXSzY
    G8vetCUL4PCgvNfhluYHwgi0lMAzNJp0DDZhruiZs0N82eNtKvjSg>
X-ME-Received: <xmr:Tdb5aJVsQvbQUcR2s1HVta1qxTn1btxp6WCmiZ7Q4XI3KPXsRiKsErDUQtqq364YdDwUFhRFpFszDftvUOWdEgtahXpcXTYdhCx7zgRiQ_lLiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Tdb5aC6JH7utXitMbsLHI5BPJ5tXITktuDkEDwWVyV3Se1IK4zS1IA>
    <xmx:Tdb5aMqLisK0zAT7fOXMjrB3Clg8GEjOrGhvoQae5HZ9XxKVXUjVYQ>
    <xmx:Tdb5aNkf_ee2K2gKJD2fikonIUDkW4VdtsjgyQlQOyZ4278iR5_xBw>
    <xmx:Tdb5aAP8d8kriwu1NbTUuX4PytlRHCZ2p1Eo8G_wv_yEYZTELeRgEA>
    <xmx:Tdb5aKaRHRcryhKxAY8dYbtHrQPY8EHcLD18XoyUUe1btl6tjqAi0uIE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c568eb4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:13 +0200
Subject: [PATCH v4 04/14] refs: refactor reference status flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-4-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The reference flags encode information like whether or not a reference
is a symbolic reference or whether it may be broken. This information is
stored in a `int flags` bitfield, which is in conflict with our modern
best practices; we tend to use an unsigned integer to store flags.

Change the type of the field to be `unsigned`. While at it, refactor the
individual flags to be part of an `enum` instead of using preprocessor
defines.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/refs.h b/refs.h
index 68d235438c2..4f0a685714f 100644
--- a/refs.h
+++ b/refs.h
@@ -333,27 +333,28 @@ struct ref_transaction;
  * stored in ref_iterator::flags. Other bits are for internal use
  * only:
  */
+enum reference_status {
+	/* Reference is a symbolic reference. */
+	REF_ISSYMREF = (1 << 0),
 
-/* Reference is a symbolic reference. */
-#define REF_ISSYMREF 0x01
+	/* Reference is a packed reference. */
+	REF_ISPACKED = (1 << 1),
 
-/* Reference is a packed reference. */
-#define REF_ISPACKED 0x02
-
-/*
- * Reference cannot be resolved to an object name: dangling symbolic
- * reference (directly or indirectly), corrupt reference file,
- * reference exists but name is bad, or symbolic reference refers to
- * ill-formatted reference name.
- */
-#define REF_ISBROKEN 0x04
+	/*
+	 * Reference cannot be resolved to an object name: dangling symbolic
+	 * reference (directly or indirectly), corrupt reference file,
+	 * reference exists but name is bad, or symbolic reference refers to
+	 * ill-formatted reference name.
+	 */
+	REF_ISBROKEN = (1 << 2),
 
-/*
- * Reference name is not well formed.
- *
- * See git-check-ref-format(1) for the definition of well formed ref names.
- */
-#define REF_BAD_NAME 0x08
+	/*
+	 * Reference name is not well formed.
+	 *
+	 * See git-check-ref-format(1) for the definition of well formed ref names.
+	 */
+	REF_BAD_NAME = (1 << 3),
+};
 
 /* A reference passed to `for_each_ref()`-style callbacks. */
 struct reference {
@@ -370,8 +371,8 @@ struct reference {
 	 */
 	const struct object_id *oid;
 
-	/* A bitfield of `REF_` flags. */
-	int flags;
+	/* A bitfield of `enum reference_status` flags. */
+	unsigned flags;
 };
 
 /*

-- 
2.51.1.930.gacf6e81ea2.dirty

