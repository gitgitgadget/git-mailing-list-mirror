Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E559273D65
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047742; cv=none; b=YioaRFu6offNJsKVtZYbFGoUSz2F9umxXeULfoE8j4X2n3zDFuSgCqxJDru5TGW+e3KXdgay2B5DhsIAdk6ScAJ5C4bFBhYHc33wpXQD8+ceuiG5m1nCTT2+YkrI0HvnICNeb6K9ZQdkT/cSTqX+13oFBFgPx3GiMcE6qzCC3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047742; c=relaxed/simple;
	bh=8GQ1PzFkTPlecfc2PTw/9t4kyymPYzslEqdLHYAmTdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrvHY6cJiow7EDQP/2eqxixjQK90+ISEOiaqYlEkqqG7p6OLXY8buW83/CXJ+aT09muSsjjJ3wlCUtaX9Jy8sKUilMCGdz2Jtw6EJhyLAOlI+rXzxpffc7jhku752w1UJ8Ke7XcAd/5pJrEjl0NvcYrjMWfqLpXbW/gyQMbWkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OoJzMv7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e1raDafQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OoJzMv7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e1raDafQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2C75914000E4
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 03:55:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 09 Jul 2025 03:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752047740;
	 x=1752134140; bh=p+0Fp9hMqYBc7sNEVHVC3FhZkO9wVtI9PyIMS12JwQM=; b=
	OoJzMv7oDXKHV1wER75QEVn1rhh5MJPOX/1gwfhcnteavSmu3t0JmcSO/yhjTr0S
	G5EABnl27QezTv5XV1NqJj2Lq/mopNPEHwG/6P+gzFWbstmL+oO5uGeMftNo4gi5
	Txp9XtgjPLYxuBJCqhvImaqmx50xokyf6rhCdmt1s0Y4VyU9om+HFEF3dI0IXG+y
	XkVMc8aGpiIpYvMqyNfXa/9F1EN4hqqkJ6KBd9EVdrsOuF2JS7IKCkfWiLtrNpor
	Fvc1OXSzVnhESzV5EEZxq/k6lnbW9p7UmuOo+Y10vmFK5Ima0zVTr+MhFvZhit4P
	UajCp8atq/kwoCDWmCtrsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752047740; x=
	1752134140; bh=p+0Fp9hMqYBc7sNEVHVC3FhZkO9wVtI9PyIMS12JwQM=; b=e
	1raDafQhnf6FAYCCXkZ+89DxLTd9VTPniqDdjaHElioInXQdxzcWg9asz52ZW8JE
	KQ2JbalBwfSG2VMeW+OlFRpeYZNJ5y2dBt2u1SDEIj+XkK1y0LQimbi5kMwsQ3Xa
	2uNy4qpUalCb7ucN2QOEaTqoS1Ml2Ia7Qdh2yrAMJ+cI3ORVtHzf/MBkIICbRQQW
	nZU8DZOd/44FSfrOgf905x7Z63BZoi7n/zQXluu5yxiJFUJ6VOhwVFh3ZmbthT2J
	aJQ5CarXFvmBimh8svgVLi48mrIJk7ST7P09mXe4dIPsIwKCMulwSVkeSKofVF8r
	NSa1YgG81aDl8akE/EC1g==
X-ME-Sender: <xms:eyBuaJvwsajmyjYwqSrQ5MijavYASRPHXrHsFZhHYtpzLDAmjD4oJw>
    <xme:eyBuaEcf9WbqV685fYyzUhGglRSrXyBR2838qWnn1iCSQ7-S8u5Jp5O0664K6uwCp
    mq783Sydzi3tJcQrQ>
X-ME-Received: <xmr:eyBuaGKcYeA97Npf91G3XEK7diOd_v3N7-fSkLF7sTWYLlB4b7MccFEpugM4O2pyAozzgqFzo1UOr3RNjkxJwo3PfZ9f3fT98fWWb-1ckfK9iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:fCBuaCaXjAPgxEE4avWpVcNVB7nYJUJNMGDLfmKzInPD5pXvm3EorA>
    <xmx:fCBuaBtsW99LGmNJ2ggJ2nH6CM9kMOc0AoWVz1-fIwDd7mF7Z5UCCw>
    <xmx:fCBuaPtS8F5-IGCUwNtGUUdfmlS13k9Apy0z7KNLES-eF0hdFXPQPA>
    <xmx:fCBuaGd22FgnLTswvKSZjFQmvgw1t1F-FjDXVWHTJZN5kCeSY45ydw>
    <xmx:fCBuaJXRQ4-IutFyOqLlhIAu-9fZzRrORV2goU26dEbQ5pyUcqCXF2Mk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 03:55:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9c4241a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 07:55:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 09:54:55 +0200
Subject: [PATCH 7/8] packfile: stop using linked MIDX list in
 `get_all_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-b4-pks-midx-via-odb-alternate-v1-7-f31150d21331@pks.im>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Refactor `get_all_packs()` so that we stop using the linked list of
multi-pack indices. Note that there is no need to explicitly prepare
alternates, and neither do we have to use `get_multi_pack_index()`,
because `prepare_packed_git()` already takes care of populating all data
structures for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 776a72678f5..3eeec20906b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1085,12 +1085,13 @@ struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
 
 struct packed_git *get_all_packs(struct repository *r)
 {
-	struct multi_pack_index *m;
-
 	prepare_packed_git(r);
-	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		uint32_t i;
-		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++)
+
+	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
+		struct multi_pack_index *m = source->multi_pack_index;
+		if (!m)
+			continue;
+		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
 			prepare_midx_pack(r, m, i);
 	}
 

-- 
2.50.1.327.g047016eb4a.dirty

