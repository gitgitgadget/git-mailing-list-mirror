Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702DD1CFEBA
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882162; cv=none; b=C4ZEoisouVKgEWsbTy1p8GKPPMQH0qmbcro5LBKiL/YM+OkYZC+qOyl2F8oeN3jnNki9dlDyTIHu05wLoHeTKBo4ywGTC2+OxatQay7/mIg6PxsxKYDGCcGrpzoXcc068f8Adwb7UKyA2ZDgSlGedPDTOQsVRCcni/Xojtf3bYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882162; c=relaxed/simple;
	bh=1zYUMZZZVO774KoBnZgPv/Z3CYUyDD31Nbuj23SWoAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FceiwvtTbrp7oCOXLjCLW8BWM+3I3T0uORYI0UK5tUQmTSj0T/+zGnz5zZ2GwV0YLvJW9fJuIEumgV8FbdRmbHriZZU5mdXIJx1ur/TlRDH2gX8qg6kzSfOBtWlIH0a9lB09w1CdJ6YQM1h/jVYM650yZHn1XZNzM/ToAOy8Ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=atjx4tS5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EVlzmegR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="atjx4tS5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVlzmegR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A33F13801FA;
	Wed,  2 Oct 2024 11:16:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 02 Oct 2024 11:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882160; x=1727968560; bh=Pq5Y5/+yhg
	iJ3+uTkENsfk3v5Nnyohvrl1LN1Xo4hdE=; b=atjx4tS50TI+u+ahc989o74hVy
	aldD4mB1Xl6+n4aG8285SiTWT84Qtkn08rBtxA+69s6kz9qPBRtkQL+gDC9x7KWt
	6QI6jc5gBNjlOWlva+e1MnpqSUorYbClGwBXhpK45MupXRLU/xLcWx+Pm0HbpCkH
	n9BlCwFjiLPYviH8iIy14PRJKphLx0Tb/DHa9QhiNQW4I/3PdTK4dWWP5E4PMOhF
	ZqIrP51+d6WgpjjZ6fqqkTDnu3eDY5Q0CDB2SxryEelZUdFORCo8mUHACyiPxXzN
	4Tj5WBbzYjv0f6wPxg3W5rpjatyY5nj5lqVmEqjhK5QwRSiMXGYmQZXBxigg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882160; x=1727968560; bh=Pq5Y5/+yhgiJ3+uTkENsfk3v5Nny
	ohvrl1LN1Xo4hdE=; b=EVlzmegRy9SRDhqwrwiq6KLN5F6XOS9bJK+hE4NXpRHK
	xQn0j8sWfYM57ywzgjA7SfZKvGX4CYB3/otcT/TfLfe997kXfCcvO2baH7ZUsZkt
	CQWAuSusJ505Ubl1iSIRIvMKVj1TQDwDhy9+eUEWNUCVNgu0n9L2zCObtT18mbJ0
	wFCzX9tskLfJKVOWqAvmruIrPYTeajQOUXvBBU95HwHCNErYtmpLf+dk/aA2D4mv
	cY3wxpsqDd4kpBgm5d9q2O1axTJD8ZVBddaSJlBCaxEVamIZ/tsAs/kV8EgmnZL6
	mQbrDK911wFdd05+e1/aSYK93mM/f+iKoxfrWNNHMw==
X-ME-Sender: <xms:sGP9Zg71hz7dWI8Qr3jaBcQGoP63ifCiOHl8PuxtCQSTs4GEJOF6yA>
    <xme:sGP9Zh4H7Bq4ffBNH38sZLozT7Yeg7oMHUdxqLfv1ToEDV8f7orovQJsgTQi8kGWj
    TtAoZwdnBoK-XGkNA>
X-ME-Received: <xmr:sGP9ZvdT7A_KhPSYu1JKlVDDFaWSHn6gVK_SC6zHDxhQSdd81zX_1qe0kmOw_XtWdKs1DNTDCyqvezVxlZmH-PBEvFJ22ItcHCV214mMFzo0vs3b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:sGP9ZlIWp_nVxKSJyAYo31PwVN7Y2GDNb0HeeA2XhNA0LzQWFte6_Q>
    <xmx:sGP9ZkLxDVaLlz9ml5TAX7nlB3MDIknX5A55N3MDV-tNmOejogF4oA>
    <xmx:sGP9Zmyhb1CowgDEvmWfRyxiiaH9q14LKl-o7XGZdUNC7VCBg5Vd9w>
    <xmx:sGP9ZoJUvHQTHQ0biaHWWKt-GbYI87bk0pBNOFN0UJuPatyU3MfuOA>
    <xmx:sGP9ZrUk-VkzFDkqTH1wD6m9ub3XWNKQAtFzAk9cPYamkoMurGSqaDw4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:15:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1723ff60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:09 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:15:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 07/21] t/clar: simplify how the clar derives `struct stat`
Message-ID: <f006545eef1624218491cfaf7e678c4cf83d42fd.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

Windows has different definitions of `struct stat`. The difference
between those structs is that they either use 32 or 64 bit timestamps
and/or filesizes.

In the clar we try to set that up automatically, but the logic to do so
is somewhat convoluted and really fragile. Refactor the code such that
we always define the `stat()` function and its structure together, which
is both easier to understand and less fragile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index f463ee823a..12fa66d088 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -30,6 +30,9 @@
 
 #	ifndef stat
 #		define stat(path, st) _stat(path, st)
+		typedef struct _stat STAT_T;
+#	else
+		typedef struct stat STAT_T;
 #	endif
 #	ifndef mkdir
 #		define mkdir(path, mode) _mkdir(path)
@@ -62,12 +65,6 @@
 #	else
 #		define p_snprintf snprintf
 #	endif
-
-#	if defined(_MSC_VER) || (defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR))
-	typedef struct stat STAT_T;
-#	else
-	typedef struct _stat STAT_T;
-#	endif
 #else
 #	include <sys/wait.h> /* waitpid(2) */
 #	include <unistd.h>
-- 
2.47.0.rc0.dirty

