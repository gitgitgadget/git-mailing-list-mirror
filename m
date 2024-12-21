Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E791F190E
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734781846; cv=none; b=Ww1EUfxACv6F9LsOhyhjTYrXKs1NkJb21F3RKvPhBiCN95ewC/d9QNk5ktB56kcXRYmRa22O6GHqY0Fcns+4uAKczjU0dAJ6d7rm87EdR8KxvcLeiLXnoYTYrZsVAKrsfiQNrba9XrIRcNBBWzX2GCBIjow4pzxuB6HYno4uxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734781846; c=relaxed/simple;
	bh=B72wCzzjAMScPASrFs+lO/j/sySeBigjXsrrfoNVCSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSJg+iYsgaqLdo5sfOdYNCKPnF2WrMkOiz02JJB7NzGiTHigqYEnFvYv8PPw1xItGs+zkuSx4xuTyVgA9Li7bCgwoQGQtOaBG254Thcw9Nu+i9pA2UM3LBsd7b71eI/HKohz8zhi5KdVbodiS6AuUx6I/96HkCiL35n3dEO9QMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j6tQ8dEr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IoZCpF7F; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j6tQ8dEr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IoZCpF7F"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A239114018A;
	Sat, 21 Dec 2024 06:50:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 21 Dec 2024 06:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734781843;
	 x=1734868243; bh=vM4VanXwFujuK2w2Psv62FAZc8cPmTAe1U8IwEHjapI=; b=
	j6tQ8dErIS9YdQyBnqQp3fVKOdMMCRBdOTM04lASjNS4SMEwcMaq3RttcwXZidsW
	SpG31U+uaCcAp8LG8p8pvXsAkRTgzIHdeje/MOuIXgsAajlZUibgqRTOSaoc3ble
	Lp+QRyLN8cEy/4aaEO3Ewp01tsQQsBOIUnCk8yusI6H+LkmUGfrDIUz34DGs6Dub
	AUI05zdNtSapblUuhdsdjmFD6ThneFKHg+dH9aLm8A6Fcqbq0R/2x1V9dBJ5k8nE
	xMFJcLQGkwqIA5Sf3oso2Eug/kf9fHU8zGJ8zNDmklzSCWBIYfYz80mY6hDbeVn1
	4eLXNglxrNuPW1CUPWaVtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734781843; x=
	1734868243; bh=vM4VanXwFujuK2w2Psv62FAZc8cPmTAe1U8IwEHjapI=; b=I
	oZCpF7FybTWzX/bvlPwEtxSGJBn0AcubKCLbE7uK1PCooOj/q1zxxBJoxUq7rf0U
	W0kpzdAK9ndY6Gn3SgQbyC1AkY0xCi1cYuOohtBvt5EaEZs97DV3l9k+c1CFcNuG
	fN0+HBa+JFZhfPBS6UbD1/U37x3mCw+4XQWERG983tGwyWO5/DqD8FO8yEKrZ4ea
	iY9M7DEjanre6Y93HPnWGrK4gMI41GzM2GEZN5UjEb/tVqToypWYZMxLe6T1KPuP
	q792jeyVorC+RQmYECKhz3toE/rh1UkW49QaeQnwOAVG3tGTq1fIdOR5cpQ1CnqV
	XKvglIBvK8ELTqm60ZyCA==
X-ME-Sender: <xms:k6tmZycBIdZ0U_uKreZk7FYpRiLp1fH-JDRK7vhKa2lJpNCsvr73BQ>
    <xme:k6tmZ8OjAP3-4RWWHHqgts5yjzvzc98WAC50RDCNB0b-dPlTYYh5kpfVvykPOuu01
    qslaeeWbRZx_yx6qg>
X-ME-Received: <xmr:k6tmZzhEi1U-jCEOwIM2Y_DTsgiiqqTyCelVzN4KY1gvDTPO1_cOqGTO4yavm2bQ_q1M3b0ETMgyNIefnZFswebabX1l2u1HyyD-mPCVcr_KwygKrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrh
    hiughgvgdrtggrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:k6tmZ__HGUQgN7jQmpSr5TYPWIcxUEOsKsiSlo6_CtEFBdq0IMiHsQ>
    <xmx:k6tmZ-sFAeZiGamaby5bi_dseRSSW1qCy1P12vcgUNPx8FKKtD9bUQ>
    <xmx:k6tmZ2FDS5mws0e-2zXvmG7i749_5NKfrS8U-D1d3vasLCfJsze3jQ>
    <xmx:k6tmZ9NnnpFDPLIbsE9WTw5cVuts0LchsNeLVsd3Q3ebHdt4wffxgw>
    <xmx:k6tmZyJUOmNL2JZnDlPwlIKdLUAS8n8gyRwQttX7VIc2Atg5PvozENlk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 06:50:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0067804 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 11:48:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sat, 21 Dec 2024 12:50:10 +0100
Subject: [PATCH 4/4] reftable/basics: return NULL on zero-sized allocations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-4-12db83a3267c@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
In-Reply-To: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

In the preceding commits we have fixed a couple of issues when
allocating zero-sized objects. These issues were masked by
implementation-defined behaviour. Quoting malloc(3p):

  If size is 0, either:

    * A null pointer shall be returned and errno may be set to an
      implementation-defined value, or

    * A pointer to the allocated space shall be returned. The
      application shall ensure that the pointer is not used to access an
      object.

So it is perfectly valid that implementations of this function may or
may not return a NULL pointer in such a case.

Adapt both `reftable_malloc()` and `reftable_realloc()` so that they
return NULL pointers on zero-sized allocations. This should remove any
implementation-defined behaviour in our allocators and thus allows us to
detect such platform-specific issues more easily going forward.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index 7d84a5d62dead1cf1a60698b1bb12fe6ac41c090..70b1091d1495bb5b4c8aae63bd9213dc704aecde 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -17,6 +17,8 @@ static void (*reftable_free_ptr)(void *);
 
 void *reftable_malloc(size_t sz)
 {
+	if (!sz)
+		return NULL;
 	if (reftable_malloc_ptr)
 		return (*reftable_malloc_ptr)(sz);
 	return malloc(sz);
@@ -24,6 +26,11 @@ void *reftable_malloc(size_t sz)
 
 void *reftable_realloc(void *p, size_t sz)
 {
+	if (!sz) {
+		reftable_free(p);
+		return NULL;
+	}
+
 	if (reftable_realloc_ptr)
 		return (*reftable_realloc_ptr)(p, sz);
 	return realloc(p, sz);

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

