Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CE156880
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489708; cv=none; b=ml0ztIO5xFarkALv7Fhx4sCIpf1LfGFdypg8VutCY0r+PDprLot3tMK2C447WbwlpyhO9yNyDNSdj7bG3TBrEpS8ZHLhVPKMKPH8tML/YZnIFc9ehtJLMzBz8n9/kkHIaX4OPCD491UmgWtAhyq5xRCmMIB2BTPXxilAndYuBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489708; c=relaxed/simple;
	bh=IjikH6vm5wc4fLWTdqe8ayEuldOnlg/oiDHd1BG+M2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO15R035WxUe759fxl6GhO30SLsLV2KjiQgBUecN6j5UKtvoe5J2nTbvtsPs7FcWYrLqSMccNq1tyENlVzgeH1Qie9xKkpJlhqY7OtxepB4DGgew1dqdahCZDa8esGKTw5Bn3i63awG2NEnz2DUwbQaiNPVGBEzFqXvB/yxqm5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P2I3R/bb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnYou75W; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P2I3R/bb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnYou75W"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 82AED13801E0;
	Mon, 16 Sep 2024 08:28:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Sep 2024 08:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489705; x=1726576105; bh=PBf06YxzOs
	ueTYY4ppGTCh8x5orFv4h5rxmtgVf6LLM=; b=P2I3R/bbNESNTSVG1jPE+wsoQI
	ZYyOrFHg7+U+66Nt61ma3x3vmO+2crEY3pzPkEBx4eCnXN8d+TO2kfZji0ltZJWU
	cV5VhES3HrMrhxIJFsa7j+3J4Xx+uzLrotFz1lRn7bI8S5NyUYcBD/DK1VV6qAE+
	7CaV88YSUyr/Fe651WnEI8jkHj/weSWqPjXKLuq0t38/RnCq+ONFNDWeUwsP6c8D
	0HtxW3G/wJ2ZIpz7D46iSVyyLviuEIqApNsJ80ZVlmu2pdqrtxTBX54TMfjkx0sc
	VP6ULK4xPazkjav2HoPe1tS1GoY3JC/QQgKbYtydhxBVt7IRrttgFi8rJMtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489705; x=1726576105; bh=PBf06YxzOsueTYY4ppGTCh8x5orF
	v4h5rxmtgVf6LLM=; b=EnYou75WaYo7D+yy5hqd0+zztK/3bj5yinyAYj9bdocW
	Brhqp2ucdmuy4fpKzt8dl6sY0PLwtwL4YGwpiU6LYEI4uRcs385ZTTr83fF9lzGs
	AKdCGNK4nQvV98oFhh1ri0HGxvovZJ2It/AX0BEMQcEkftg5sQna0uKlv2xyt1EH
	UZsZHaMkIkSs81O4piwOqxgbHWzAPnmDwbMyoPAle2xMBgFAdy87MxiyMqjvzWTv
	j7D5Wqg4HKW5jVxHVNJr7zra/JAS6OThg4o8kziijVypgetjV0t9bO+omGfUcMFP
	LI+Cvjuyhy7/wo969kZ/rdO8Xig+qYg/J7nC7h+ZHQ==
X-ME-Sender: <xms:aSToZhSoI565_JVchiVqwZraNqw0WCQ8qoIVsWsrqVwryCzpn-MMgg>
    <xme:aSToZqyklvC96K8LDtvPtgAqzUfKl9ymiKMA9lXDKJ8Efnz8gNE-t_TOzfeWcYU2Y
    npDS-MrYeYLM3OJcw>
X-ME-Received: <xmr:aSToZm39BrbalS_40sufuY6l7AG6vIlVan6rgla7qkwSm1BJy6zHK5T6FF4dO2JYnNYbl2U5iUARV6TuBtwUtjJT1kiAM-Wo1CIv3aLhAr7LPckh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aSToZpBBCTR-9oPIHRXhshUVGwIpG0kV6zeZ-a0XTUa5UacIMTOfqw>
    <xmx:aSToZqgO3AVP7RCaahHX25h68fGhNVudDQPBUIap9rytQZSR857omw>
    <xmx:aSToZtrJo-cS0Gw1Daei_or2UPG7a2o48URFpLo_tId9RNZRmq_eSw>
    <xmx:aSToZlhfrFtJqgzwNPx015McjVbGHfE89XH7gpvpPzT8ivlKU6gulw>
    <xmx:aSToZttIi6EU-jpWFZudHTLjH8DM_ka8nfn8Ti6i_SYWnePuNXUzq09E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e87a575b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:07 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 03/22] reftable: introduce `reftable_strdup()`
Message-ID: <21fa9b15d96809728455943877c1b32781364041.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

The reftable library provides the ability to swap out allocators. There
is a gap here though, because we continue to use `xstrdup()` even in the
case where all the other allocators have been swapped out.

Introduce `reftable_strdup()` that uses `reftable_malloc()` to do the
allocation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 10 ++++++++++
 reftable/basics.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index cf072935c88..4adc98cf5de 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -43,6 +43,16 @@ void *reftable_calloc(size_t nelem, size_t elsize)
 	return p;
 }
 
+char *reftable_strdup(const char *str)
+{
+	size_t len = strlen(str);
+	char *result = reftable_malloc(len + 1);
+	if (!result)
+		return NULL;
+	memcpy(result, str, len + 1);
+	return result;
+}
+
 void reftable_set_alloc(void *(*malloc)(size_t),
 			void *(*realloc)(void *, size_t), void (*free)(void *))
 {
diff --git a/reftable/basics.h b/reftable/basics.h
index 4e2e76014aa..f107e148605 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -54,6 +54,7 @@ void *reftable_malloc(size_t sz);
 void *reftable_realloc(void *p, size_t sz);
 void reftable_free(void *p);
 void *reftable_calloc(size_t nelem, size_t elsize);
+char *reftable_strdup(const char *str);
 
 #define REFTABLE_ALLOC_ARRAY(x, alloc) (x) = reftable_malloc(st_mult(sizeof(*(x)), (alloc)))
 #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
-- 
2.46.0.551.gc5ee8f2d1c.dirty

