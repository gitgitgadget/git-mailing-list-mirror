Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93322B8CE
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175452; cv=none; b=rUgRcXOAKqLlnvSFIiJYuyfur8clmscHjeLpBU0x0/JCQVbvM+AUBUUd0cUquESdRMYZ8PdZuBtCe+x+gd7/3sc7G2NwxgdJS4RzjYqKbr+v5Twtoiw/GnMGTQC+N/PHXPt9pWD96m37d0U973+t+bu9fcsNcqp4cxgxMc1YWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175452; c=relaxed/simple;
	bh=X2rvscZuZT2bPJgO7qRmnypaMrpx0DzlonZ6YMU1bSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qA20RybMLvXvt5C5T9Cu3Xqc63+4xC/pnG08TwuWvl8SGWxs0DzBfkQO895qPPztr4P5w0f3vjQ7P9mzQm9FM7+9/r2RvIJg7L30vcG+VgJ6ohmYtxBdPWcNqLiSUZmCcZrBmX0C7YzNIBQGYIC1WU4mC1uiVynVtffz6+XiIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2+KlIPte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pkqmObKC; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2+KlIPte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkqmObKC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70C3D11401EE;
	Fri,  2 May 2025 04:44:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 02 May 2025 04:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746175449;
	 x=1746261849; bh=cslH9NHgn0WLIsCOYm2hK7lG+0QInTHK5uyrhycegMk=; b=
	2+KlIPteaw0s3T0vT3Dye7728TzjZhcUo2L93uGI3H3FThfu9wsV+K/excJDSz27
	f0Y7LCIYF2M408kUXN1WVowsOJVx9xi6CBEl59ow266uaRm3IIB5lNAtdNPhczCD
	/cbslmiRhP5MU1PcMpli3vsQdIav69af3mi+dVlKEpCxkbBC8K0E25BCZjLP+AOz
	uIq9MWhLWBTdIzb5abffnnlZuBaDj2kOcVk0YbYLRjQmGuyOfI6INGw0rZHiP6GP
	d3tUxiWU7JqH78jtNctgSUc3R0e5XSCksRtwJyWsMWNFB+0XtLG2bSF42ECFGaNB
	pT4rcsQ1boa6elVpFYf7jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746175449; x=
	1746261849; bh=cslH9NHgn0WLIsCOYm2hK7lG+0QInTHK5uyrhycegMk=; b=p
	kqmObKCS9nuU1k93pUKAEaXnPKQ1o1NW7BWFNhnGXL1w/3H8dJUXSQi9uH8nFgGE
	P1wrsl45BbDSe+Zad7xkiSLI0KUf5IcPVvIyd+asRhSmoCLaoJRjiQth2vwZsRH7
	/G62pWPwRyM9DVn05+QSvcnERCWJE3Ut7xWJWp9Pw4Eyb4dS8QJZQzOjm+UyKRZl
	aMxLMlGMn/Ec6V1ua4J6yrEG5FyiVzS/SolVG6r8s5LfbUfjDOpBpOAno+P4WryA
	WssHYEl/MXfBeW7MW+uVIHFeBf3cFmUoGWMuopTiRb8su2vUEgT4OrXgp8TC/aM3
	DlKVURGKxBfOgUBuOGYAg==
X-ME-Sender: <xms:2YUUaNoI6-_uLTy0ALt1stZkfINyJ5dufLTX1ydLhzuAjvV-RtR1IA>
    <xme:2YUUaPq89M1LYy_vBeCB-eoEzNMk0NUeL7SGKfTrAYMl2lVLCW-_lNyx3Le89f7RR
    -9ihCGZSyJJQmRMOQ>
X-ME-Received: <xmr:2YUUaKNq1Yw2YyUi7VO_eovBo-r6Kkp4E8p6mploB3B9xZ2gcf_wNsa-GlIJvcES4Mz0-_wDbwk72fub74a9lfNG2IuT-Yq2szDxRoQXLV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2YUUaI5F1KE80nbz5X8rM4jr30ni48yWpIMHN4TVbGb3RAXc8XJaMg>
    <xmx:2YUUaM71Ch00Csg77xpHC7SKripFZOHKBYzUzSIJ7aksQS0VyhEV-w>
    <xmx:2YUUaAhZUPVQjMnuvWAeTUUE1sMjLDkM3tNYNIy519V5c-SZPHfjhw>
    <xmx:2YUUaO6pMBl6-7wsiCoH3p71DpsJ8pFlCcNpqyCHKqVTKz6qOXH8tQ>
    <xmx:2YUUaDVl9vhqy5HVzQ71PtI_ukr1wsePS_9oXLb-bvxatGcYxCbNqHIc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:44:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1037fb8f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:44:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 May 2025 10:43:58 +0200
Subject: [PATCH v3 1/7] builtin/gc: fix indentation of `cmd_gc()`
 parameters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pks-maintenance-missing-tasks-v3-1-13e130d36640@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The parameters of `cmd_gc()` aren't indented properly. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d5c75be2522..a73ec22fb18 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -724,9 +724,9 @@ static void gc_before_repack(struct maintenance_run_opts *opts,
 }
 
 int cmd_gc(int argc,
-const char **argv,
-const char *prefix,
-struct repository *repo UNUSED)
+	   const char **argv,
+	   const char *prefix,
+	   struct repository *repo UNUSED)
 {
 	int aggressive = 0;
 	int quiet = 0;

-- 
2.49.0.987.g0cc8ee98dc.dirty

