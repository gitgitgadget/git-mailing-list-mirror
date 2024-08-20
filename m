Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AE191F7D
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162547; cv=none; b=Zd8Z6Dwk3DqcJSCSepnbCGBOqfvBBpoCM9t1HOzYn8etda3z9VNuZNe73OXyqKVivekpYRe7m3h6z7VINx/cTUU01jlcudqG2YBOUgBjqTqzI5PWOy5bCXzfK38njag8MzZQt+WaRWTUXdsqgV7546dORCsvRoT4bwy5asQAvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162547; c=relaxed/simple;
	bh=ZiuBKgGIKIEQ9v1fgk5o4CWTqb6t8eYC9yvjZ7XI/yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITbJbUXUUdJ1oYrwyRFpx3db3iuo7Xde1SlSAAvx95mT61W94+TaKyWnSAV6mOES0L9lGdOlwg+r8yJUrkMIwg6oi75JQ1MH5/MPD0PVci5FnbZKTC7X1ulWdnxo7XSjYQTPrcUkOhhNLtkmY8hLGcIqsUB91NkzKco/KN79G1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LTLFAGrN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S6lVWLzr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LTLFAGrN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S6lVWLzr"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8F452138D263;
	Tue, 20 Aug 2024 10:02:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162545; x=1724248945; bh=eunhwJ7DxC
	s4mcL18jEupIOr2lsNKc+C6waY6c0iHp0=; b=LTLFAGrNF83OZhSeFqPSWgdErE
	X+y/GwVHMfORVMn1kYJF09qJojD0dBf8hbYUnbXSfFtphIZ7zVrvSRq+LccP4Bn4
	eR6PkWHcuXgxFdi165B6DksiK4S5v5/VLHsuu6xf0esJPVe0RC6G2xuJcBqUZ2pD
	eGD65C3Ke1Tt4dGRTMF2pjeQBInbQpdWNlUqMcFurYfEk256aszx26MD7lyb0S+r
	ytGR328tnmVtysShGKSXTkWXDPshlkLarBkmxXt/nDLsTF6eWpF7ZRwChRxkpVgd
	S8QhUFM2AsItLc8GYfWjHZffy/cWc0eFhKRdwxB6gTg89W7YPv9/I05wDiaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162545; x=1724248945; bh=eunhwJ7DxCs4mcL18jEupIOr2lsN
	Kc+C6waY6c0iHp0=; b=S6lVWLzrJKyZW//g6Y9/Z5pBicAWVwlgHFmw9loqGRcJ
	uS1YyR7XXNNFHMJUhpu8N7GGJJE+9NojWDwKJQfx9iJHzwZ7XnE2SdUlrnlojN/P
	O1bQs1AN0yaB6RylswMWlA8Tip8ku1nL0D+ANjV6njRTOwPvcZvAT2Vc18XPLb9j
	hku/7BL9CK+kdIyJv1qsZc2g2CVsCdf4cWVbklNTGcq8g1zIUHFo1IcmNEbHN2x+
	HoB1fEERzD9a5tGsLS+P0ekrN60wc7tVHQJFLateYcZb73Mdvn2y/Xl9Ia9hxNDq
	e5vNp1h61vqV7VMdPBQulxP3YcCb0W8qjJDSueSV1w==
X-ME-Sender: <xms:8KHEZtkkzVI3vczEUWxS2oQ6cRwwy0kNgNCENHd4BhEQPgo_9OHA1A>
    <xme:8KHEZo3Cdf5IqzC_g6-z1j4ElH84LAjdAA0CoR5za7FJPqLodnyHypR77MMnOhd2Z
    1cDYZQx35JOd9X31A>
X-ME-Received: <xmr:8KHEZjrcSrxANNb9cEfJl6eUdmEvPlZGZdJhlifL3-BR2mu6kgyTgCiOmSk8tkgzlL94pqit-gt82M33BF27urkinu85auXcumARY23yIR6LuW2ejg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8aHEZtlMFwT7q0lZPAWaTbJUh_a9Lupi9UoM1rNe-X0jt4NFFa3qcg>
    <xmx:8aHEZr1yRu8sVTFzSOZ_x-NwLE4xyvHbrOJ3OnHjk0ejIQNoDxfrjw>
    <xmx:8aHEZstEN1nf0CnJfznILtAjd0iQM2MO7MeXaHMZOIA-B0PWGtSV5A>
    <xmx:8aHEZvU9GIwui9uIyyHAd_nVQE7SKeF0YKXbr83Bl7vcBhaqbZc3hA>
    <xmx:8aHEZtxV7YcT_n94oMAuyperTMa1DrhOHIeESiJxJO6sE78rw-889sw7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9063a49e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:01:52 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 04/13] clar: avoid compile error with mingw-w64
Message-ID: <06d2bce0d821175be323f352574068962ad3847d.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When using mingw-w64 to compile the code, and using `_stat()`, it is
necessary to use `struct _stat`, too, and not `struct stat` (as the
latter is incompatible with the "dashed" version because it is limited
to 32-bit time types for backwards compatibility).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index 3fc2c768158..e2ebe551d38 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -68,7 +68,7 @@
 #		define PRIxZ "Ix"
 #	endif
 
-#	if defined(_MSC_VER) || defined(__MINGW32__)
+#	if defined(_MSC_VER) || (defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR))
 	typedef struct stat STAT_T;
 #	else
 	typedef struct _stat STAT_T;
-- 
2.46.0.164.g477ce5ccd6.dirty

