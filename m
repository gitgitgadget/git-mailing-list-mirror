Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAC84A4D
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159527; cv=none; b=pSFIrBAyO3jTwCr+jiJkUCFXMJl2eJ08eh7C/fleGLdwuVlyvaqIbTLo3h0I/Tlth5gW80aTpXYBOXwHAm8jm2lDJ0IvgvUVQsvElMn59FJab2cI6DP/2aKKxrI34z1fFeVxBoKKLQCoV2vAEdfa/x4Ny8JqZFygRsgJZyJO5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159527; c=relaxed/simple;
	bh=OdyFkJYiuj+poeYUia+uyzHuAEChsR/GFivXkK6QhRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhCwaCV9SjIKlIdq0eMhb6/wwZR0YIrT+Aenm2PiMauzhjbNIxuu7Ki82y3nirmYCQhvee0ARjwEX9bl1ejzB8oEK2Pp9mEzPkgu2pkczgUiwBfFZNLpBK8qYtO0kfyw9GsQnuY4t4PgtjQLkCMoyS6fWtQgbmbzkMFfM73iRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Adq3rcD6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CIhWUzLr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Adq3rcD6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CIhWUzLr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B32913802BF;
	Tue, 24 Sep 2024 02:32:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Sep 2024 02:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159525; x=1727245925; bh=TQfgDHUs5r
	/neAI4IZKpFHjjjmJBdg2eMKfxgVYDVBo=; b=Adq3rcD6AfChEpufwGVIWWN6zu
	e4JTzU3rNBGXTnTRzO/jxI6ZjpbwCOSCHwDQqLxCxkOmMN2VZQFJ1t16A6zWa1Uu
	Nzg+gflnBG6qDSFWOKHaXoCWJeykuvmy5GeckK9fefD71SICsd6eadOirB1kkZnz
	k7M1G9+yb2Z7QCAgJ78Yvk6cPC7E39gLrjZSDFvaVb/VczNabwHMW8Ni/aUMUQ9k
	rMTgVQ6q6RrQtH81nXG/gdSdZOT5b2Q/R639JLJvF6Uu0KHcS+9mNKgQWI5KJWdw
	LF1UjMtnu1gllBfSBrJZKNq+3JZzTAq8eFJbGi37HTGWFy15YIzlUQAJi2Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159525; x=1727245925; bh=TQfgDHUs5r/neAI4IZKpFHjjjmJB
	dg2eMKfxgVYDVBo=; b=CIhWUzLrBN4uHqW6PTJosVuKOT70hqNoLddl0wxkZvHe
	ciyNH9JK1rJRYhzBj+GwsLpwuSloxGu4Vln4b/go382iLHh9suSDrseASss1kSA5
	vpICsQ2O6dq9M8vie06Ya+B8+XZJsuLOdUsafxl5z0m1jFS/Gr9H8D7U3MicgbFv
	jzaC9QKdpffmX0ZmfwY+PT2oBnSrus6XNOemRSnjvaZ7pHlZhTBNdEl3Y8ZdCUCM
	pk6Z70zEOQXG73gOvBaSkTevgAzSMftlumHygipw0BB37bXaMcM5lKPLT1g6nyhx
	tlSAQT/x8YK0sBWix7FyAAkvQP6ofenbI3HVuTzNCw==
X-ME-Sender: <xms:5VzyZrgprBJ2J7Di1LOwn_mNijzspAIWC6GrXg8B0acfuwgYUXywcQ>
    <xme:5VzyZoAvX-42x0pgiBb6UDblAwJbQWPwN7u9pebYKOA-8we8ie79u5efIZE-Drl0Z
    NCHrZmnrpOZXWRsdQ>
X-ME-Received: <xmr:5VzyZrGRlMR637EaEo7l9Stn1eQdbtGLGUzOFwEXvlw33w9hkPUMp8nVqkSc29ZggloD3O7KDDGAvpC4eh4TKdFOIgp7FDayh0ayoHR3odB0Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:5VzyZoR6NkBNQy_y_kSDacMISGoQLZUnq1Z9EtK3iVkqxH4UL79Rbw>
    <xmx:5VzyZoyGOO8z8Mv8Ei4R-jTL89AjYUcZZuh7zZR1GssXLH_szFEAaA>
    <xmx:5VzyZu6t6ZXXWoX4yibeI5JipXVLznnYjLtP0HBZC8qmmmpvHs3OUg>
    <xmx:5VzyZtxzyPQGS_2XJ08V1ksmSRfczPBM-gpkQuY1ywa_e570c1sPcw>
    <xmx:5VzyZk-jNFFxrfNyBZ3-24gdqr1s0mFfYtcmQYYRXlj-WAEyb471bcGu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed9b7c18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:30 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <f6ad92ffd01c442dacd3ac6aa448891028636636.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

Handle allocation failures in `reftable_calloc()`.

While at it, remove our use of `st_mult()` that would cause us to die on
an overflow. From the caller's point of view there is not much of a
difference between arguments that are too large to be multiplied and a
request that is too big to handle by the allocator: in both cases the
allocation cannot be fulfilled. And in neither of these cases do we want
the reftable library to die.

While we could use `unsigned_mult_overflows()` to handle the overflow
gracefully, we instead open-code it to further our goal of converting
the reftable codebase to become a standalone library that can be reused
by external projects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 4adc98cf5de..3350bbffa23 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -37,9 +37,16 @@ void reftable_free(void *p)
 
 void *reftable_calloc(size_t nelem, size_t elsize)
 {
-	size_t sz = st_mult(nelem, elsize);
-	void *p = reftable_malloc(sz);
-	memset(p, 0, sz);
+	void *p;
+
+	if (nelem && elsize > SIZE_MAX / nelem)
+		return NULL;
+
+	p = reftable_malloc(nelem * elsize);
+	if (!p)
+		return NULL;
+
+	memset(p, 0, nelem * elsize);
 	return p;
 }
 
-- 
2.46.0.551.gc5ee8f2d1c.dirty

