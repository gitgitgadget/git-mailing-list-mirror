Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C12F12C1
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115282; cv=none; b=W7NWqM9mWEmxdZNQGVU+aj/DZ9oI1VYvbk2kVwUW1nYXn4vhke/hS+wR8XV4P8DaOSQVnhGzWxuCiFTjnHHi0ApSpnz0vFpXqcbCFl5piQZl2jrGECLQOPnZ6r5Dy4x3PYKSlRSokBHirDA/Bzj1ANg1LpWz3KFy9+aHhS06wRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115282; c=relaxed/simple;
	bh=zVwVjjxa2l+w+CoQq+Nu1eqn61bn67E5+mwpn+Bp7Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFkMujA/d9KR3F0mH80NbcUFeLV93A3mm/w8iC461e8Hd/IUwIVEcdHgPFIWqlY1Y5P67Q6/N3ovyxuiiaKCaVIBt9VxENIsQ/pVpnHZDSW8qDJrxr3NcPHOQo/Ox0kiPXn+wwtihonQnGXChykpG9Fupo6hiJ3CzT+Ry8TUuf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VbwcrlQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXPV2IgQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VbwcrlQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXPV2IgQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BA927A008E;
	Wed, 22 Oct 2025 02:41:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 02:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115279;
	 x=1761201679; bh=iMJMcG6xLBFKUMIqhIF8jnl+9M+Oh41b2KUahKRJ/qI=; b=
	VbwcrlQfrDW6Mz5uGWWxum5wd7mSsMUTrpk7xzqkFi5YWygiIDJ9YFXTgNyA1h0e
	pmWqJLBacpitDsLPSoT0K/pKpSYZcJrXMPF4RYinHkZ7PhqgVJUdMrufWaV2R/eA
	1mP7VFI252s4LfQMYGd66Ol/rSmnNyaZobuEpKPEpme1IS+IYDxnncKRjQsoC29g
	osgrCRLINqCga1BjBybZfvmXBno7QUf1CyuD3vCbBRwrHtyqXi2OgunNiXuxv/qm
	Tg0wH6VPEtJZrQcm0n9VOaUXEr/HJ34Fh41yunblN/3s22H+Y62p7Gi1TkSQM6vv
	QH6JOyLpr7NVaJFu6uHj7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115279; x=
	1761201679; bh=iMJMcG6xLBFKUMIqhIF8jnl+9M+Oh41b2KUahKRJ/qI=; b=b
	XPV2IgQKwaMiTeKPSpxlFuS++XfXVI6RBhqss5V7tmM/LAF/w+6MJkB8scuLdYJj
	5/KznBDXJzFy00/op9kiQ3cbx2gGXdn8Qnok5gl5AtqVAG0HjfW9PebmUZ1TVyxy
	hAI3Rrg+mtvOVuyFjt+4rQIHI5efcSSrT0HQisKfGM+JGu74UblePcCOoZI0BwdJ
	FvlGJXLJv4P3Pg1PToeynGJUGHyUdSAE9LnWMjF9olKfxHjxDQogK3uAJAliq/ed
	MsnkQnw62VztrYxRuKGzqIGB4OC2jgdNm/wT7rEMaULU92gkuMNwo1BJeOtIjXdE
	8KEcAxJdb1Eml/mcpLxpw==
X-ME-Sender: <xms:j3z4aDCMHQXUYZ8pZH1f3hFM1x1RbCGEuvnNCFyQfIc5qXImCu4baw>
    <xme:j3z4aNMROY1wk2v0CS8Goh22tuLHBT0aSPZbz1AxT1xAby9ppgDfGzDAAZszvLaLo
    LHN_Nl1vPY7LeCoBsVxPzCiCTtJx1q073fTtP0fh6wTAemMETKuOw>
X-ME-Received: <xmr:j3z4aIaDlxiDxsC6aC-UWsDktCj-VvL3Fog-4V_9b3txHu-RwH7bmWQX1WLtfQr7h0GMnfEHtzxqhIxxFs0k4cjLRT6BfAwPGyrf15KZdHI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:j3z4aMvTIvDzwLcMv-3DbhqF0rrxuL1latkkIKaQMAOkgd1Q39wWBQ>
    <xmx:j3z4aKNetjgp00FdClAlYJScAeKvplRNjF2NMqlA7gV8nwkLjud_0A>
    <xmx:j3z4aD7cICZCa0nil1SC71gyrW7l-zRfiVwuhsgn_iJtFvxDKyN_TQ>
    <xmx:j3z4aATxDZ1SFIG9sgbpYrmOZ99X7OESm3SkBeNNsIKvmKFsX68reg>
    <xmx:j3z4aF-oJ0APLW_F32yGElIV1gqH9G8CCnNMZq25gDKaXU8me8Q3Zvfn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79bfe7dc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:04 +0200
Subject: [PATCH v3 04/14] refs: refactor reference status flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-4-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
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
2.51.1.851.g4ebd6896fd.dirty

