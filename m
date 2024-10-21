Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C41E765C
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508203; cv=none; b=qwBSdCOw0lrIJFaxfnQRebvdKLdp5+OKBUMIXJfmPL+2Dup/ywRYwdtVn7dRodLdn+Irni1AbpCh79DS5scycaCNwZVUQFEaQN0JNJrxxAXkGbbPb1v80RtA2ylPjsouxsxvcSLjc2WeaOWvrJ44yc2x2kWS81TydQVeaI5HCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508203; c=relaxed/simple;
	bh=nSFVXuh/O36rY0TcWW5He+uo83eAKx9Mv/0yNSyFJvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh4cvRMchcBxN5c+tgqJQk5w3biFWEis7VUJoIRWT+Zcpe1A/R5LBwXVjQKlwQJ9c0x4CSXdtGTYWsv30905r5+sYmi/0yL1DbRpCmP6PI/wXKCkum/aYOKYEtb68tcKSSQKzlVhHACn58r2HBk4jkZMcBiZItRzElejhMriD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K01bZ2Fj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WekeLuhD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K01bZ2Fj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WekeLuhD"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 122D11140235;
	Mon, 21 Oct 2024 06:56:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 21 Oct 2024 06:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729508201;
	 x=1729594601; bh=aJttxmBkuKljI1wHM/DP2f0F/WljyOzokRa4QBQ236s=; b=
	K01bZ2FjNvRkXYYUYVBi99guMmrm8b4W57CM12FhC4nAIEtLoQpi7CdppDl0kV2g
	pbnb/X5sntuqFRCV5QysF+6Sln9ZsaPMSoig9j+ZeKWC9/C8f5zcotVjp3kXkTz6
	CswDoc7dpD5IGCPAtEM5eIe2BsYVY7HqIGPnXZ7cHIyJB84gWCBW0pnY/fAceL2i
	CWOHcO552FhgT+n7ds4rkPnIGEWHq5kLbNWwzFAtV61/3w/ov/5JgNFlLIruome4
	zfw6B3jo0pfNbBaf4iNrN1k0Bxa6kHrpKblpoV1p4cXz9GRK2xiW469F/vHkdDN4
	ojEgmF2OBd/Sg3Mtl02SMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729508201; x=
	1729594601; bh=aJttxmBkuKljI1wHM/DP2f0F/WljyOzokRa4QBQ236s=; b=W
	ekeLuhDP/nhFMv/VXHfsQyDRmHLaPdWy5PQ5INZWUjF4hm+D5d40zZdmqAtw/vxn
	ysoCdjg0r6Lx3N0Z66saez1wx7sNODI+x3qs2DtEJmcFrHpFcqQtiIOlqyH/KLeK
	iWASSLTuFzOhvlxkeWQNDx2Mkw6yi6B4N3GobXytDtHaXzTZx0RsUScjlHIUWyA9
	4mweNAfjVLthIV6HPotBkoZfpcQ+OKawfzh2Gb5qprqMy1+V5FZcPOCiug8nEx8e
	Ve1/j8kMl9VtwUcMmCb+qInQhY+Dj36oOLr9XOnTHXzT/kJUcI5htdaeo9IcnR7Q
	PKgdD6qslfjbKDyURZ4pg==
X-ME-Sender: <xms:aDMWZ5QPZK-NTyHdy2W4yL_CHi5OTUh5dkLDsmAJ_QjYiPWEG3XZCw>
    <xme:aDMWZyy2_48I6PrQGdej5JerNPPJDJbftnKYijaceKYG-_YyfgepFg56KV-djBwRI
    pKCWzDpOSQBodGV0g>
X-ME-Received: <xmr:aDMWZ-1wfB0PZG2GPa6w8d5zeViInerBgNxw3d3SXZAE2W9gRC6FWZFubwHumoOXk8RbOzOgCrs_yJH4Aut1MJ18ghlF0hq6zT9gGyoAmw_O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghonhgvthesghhrvghnohgslhgvrdgtnhhrsh
    drfhhrpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvg
X-ME-Proxy: <xmx:aDMWZxBv0EAJyLwqrePnOzq2IaNj1SXeY20KAy3ld0mr65Ovloqj1w>
    <xmx:aDMWZyhui1sL6X-2OM2fBv6F6ijm_ETyZIoLXtfCEKowEacZVmo2IQ>
    <xmx:aDMWZ1pzHP3MHzfK53vxia2jvp0x2GpGJqmk5bdnfsKQkbhua0Jksg>
    <xmx:aDMWZ9iKVSrUkwrwDuL36QtP4FqZCqJAdRMOcZZm1eYjuVhFl8mA_A>
    <xmx:aTMWZ3bayc-vRrBC0zqqKTPKQrZr3LeGdSil3_Nnp9GdXGOHZsk7SCkp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 06:56:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 35d4bc2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 10:55:11 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:56:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/5] Makefile: adjust sed command for generating
 "clar-decls.h"
Message-ID: <17d77f36d41fb2928565a4922eab3a67426d2da6.1729506329.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1729506329.git.ps@pks.im>

From: Alejandro R. Sedeño <asedeno@mit.edu>

This moves the end-of-line marker out of the captured group, matching
the start-of-line marker and for some reason fixing generation of
"clar-decls.h" on some older, more esoteric platforms.

Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index feeed6f9321..0101d349f38 100644
--- a/Makefile
+++ b/Makefile
@@ -3905,7 +3905,7 @@ GIT-TEST-SUITES: FORCE
 
 $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
 	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
-		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
+		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$$/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
 	done >$@
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
-- 
2.47.0.72.gef8ce8f3d4.dirty

