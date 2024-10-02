Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426E1EC00A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866539; cv=none; b=UKpOQixd0rP3HuHlrT/r6CWTo0QP2qyN/jp/f9XJ96tiHEMm3NpOThs3kPt9xiG2JS8YcgmnLOZberwaSjt6kiCBtgdPybN4vUhJJTBFEkxq2O6xQz6Wwszh81kzknVp1a2C5AROGpLRjrw87k5Godg0nQ8JHdDni4rIdwsKZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866539; c=relaxed/simple;
	bh=b2gm5e6VuNcFw4M9Tw2VQu8j+T/hUd4g9wcPToddLhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo/WpbZdU0vYzBJMKt5LfCfAiA9AeDzNG7wvJSXEFgKg9j6PkRf0x/rcriJpq5uvWKKEqLaQQZIegx8J08GeyknyWyKXSa/Wz6JAihRduEVwUrmVLcNq08obdbzqszOBScNTdwweYIyuZzpaxwieyWeN0YmT2Xq+m8vMA1+RQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lu+DjZjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDisJIi3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lu+DjZjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDisJIi3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 874171140236;
	Wed,  2 Oct 2024 06:55:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 06:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866536; x=1727952936; bh=kaL379fZ/R
	biuQABPX9C936DoOsFwVDWSc6IHeiN1qE=; b=Lu+DjZjkVCfTaTTdG1mH8H0ihF
	AuUcrQy54syp+rkgxJS3rjAWIm84buAEXMpqfQweziy8xOWVIR56tkji0nPz1g4j
	pa0zn5BzBj9rplUPnBQURxVqtXJ+Na7C0067Wl2ASCTP/Fgg7AAsmSkv6ibpG0uZ
	DAEx2+hDGLdGx0JdqH0q+M5NkPhaaW+GM6T9L7ESaDe+PMnbru3pHoN+XITn7PwK
	1l7lOLL7YF6+Z1SJwSLv75ai0w637ApPw0aDcLX4SHqPQJMbj4/I+gOO5wCgDtcq
	DwP6QGhwTiM6hFE/3XJF/cxJLx/VVouM6s6VilSSfNEggmT3gr03GCL1zPeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866536; x=1727952936; bh=kaL379fZ/RbiuQABPX9C936DoOsF
	wVDWSc6IHeiN1qE=; b=hDisJIi3uMWRcI40IPXLMWACpO/6P7J0neLG5b0LDnFX
	k5fF1Yxl2tjhXa4r2FHvVCJLJvsHQ0Ck3VtjV3ua1+I1R5CpJ/EFaWJGc9u88kFS
	L8y5BkL7zNnKQqLVav9XgMZAxCb6KbVtkeDV5vQ4OAH3AO2Za95Q9orYWYeNmj7Q
	2Q0towD8cc3tmVoXDYc1/6yufnYCcUuPJfWdkWCHBR8XUZawzPy3/odM+KpleY/S
	aNbXlAwrwNEbjGaesZrunN1PyMko77IhKE8/c7l1jb3WZqpmdP7YYT8MH5teY2/W
	yqdQD/bZHnm/TwGes99bCv7KWkB51qfWkrJKcSJT7Q==
X-ME-Sender: <xms:qCb9ZmyADAleaqHB07akppMUECRBbtd5J4CXjjZ8FJtbvIxabKmTeg>
    <xme:qCb9ZiTSOWkewpxfVGNJLIuQTOf90qeH8Sae93Aoit4-SGzdAdHl6rJiLmS1nRec8
    zsLDhfq2Mte57-3Kg>
X-ME-Received: <xmr:qCb9ZoUp-6jZAwcaqr7Wzhc0K0V9aRapxDvwBhx6_cGDdmned9KbV9MCOqDhchjJtQljoQZMxQZWcpQqg775YDNSL87P0gopAd5NG3VtxAJYMl70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:qCb9ZsiXvXv_5UTJ7ulFf8qlN-4Ht6KzYePHneV5B4VlFxpmB1dmUA>
    <xmx:qCb9ZoAUu55z4vx3m-eT1cJK0VDeoxuASZqrz9TucuqQAbnSQA_cnQ>
    <xmx:qCb9ZtJW-RAvIy1e4igzL1F2kc1MhGLm82W7MyVr2r67BxSEf0NaDg>
    <xmx:qCb9ZvA0YNajbtie4Wbo5f3Ac5PeM9ic5BdodECVzav9cTeD-X0_iA>
    <xmx:qCb9Zr9x6W4Xoh9M3eIhtO67beX4LX9_e5uTzaog1KCzXYJO2dREiqpx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e1b3e3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:45 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 03/25] reftable: introduce `reftable_strdup()`
Message-ID: <b1a10d41d3798c98c53b251df9077fcc5eaef560.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

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
index cf072935c8..4adc98cf5d 100644
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
index 4e2e76014a..f107e14860 100644
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
2.47.0.rc0.dirty

