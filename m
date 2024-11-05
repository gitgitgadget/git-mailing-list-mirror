Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9F1FEFB9
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787469; cv=none; b=b1OP6alpy0jXHoZX0CowEDyre32lTbHtXZge4F1rcDgszaYoSMaZ3/KLOSAo0OesvV6X7uKvotGwi9ui80UFHnNSBO6laH1+ACgEyT6Mli3sEY2etCDxe/ATV0vmXGYyTBlSd2eBdCxinovgsCGPs2zYa+y4+BDe4UXuWnjaEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787469; c=relaxed/simple;
	bh=ZigeHW/kIhFdIJKfrttM7SPQU2kyjthKcAEmPcEkKN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVee3lVbXYHrZ5/N2yHUj1LarOHZSBAVeR6Qx8ZGR8n3DA0zmwTr2E8+I0RWuQN+pOr5l3w2eqEJ8rUqj3ol/6r0RgTOmS2hoyVPBYvB7fP/mEeenyrcev64isksv8Po0SvE3AaxAZRVD9bP6tu19fhbmHTf9Y65pvbd8CFb164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BWncDmoy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fr+LkPgY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BWncDmoy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fr+LkPgY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E011925401A8;
	Tue,  5 Nov 2024 01:17:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 01:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787466; x=1730873866; bh=JmdqMcNCGW
	uk0WLIaTV4HF3Idm+fg4Kj8jI0DPNFHg0=; b=BWncDmoyQs6RRrndd1kZ4qd/lW
	VyR14eWFrEa8cm5z6UqvI8Cp1e5SDEEkK1VK7YUvDejl//cvXhNLKVoL5RloFZZ1
	m2il5NL/JmYlaShKUZ7Nj0pDEkMlNKZjpJGKTDNhOhIyEIwh1yIPKnyyjUQuoJeQ
	19OP68CLNLE+WoQ2DzpG4KmuSrYYmFWWF0suwpXJwwIwcoi55b11aGwbIfSBe89+
	ZLp4ZjO5fUvA29vN5DxgMsQ09FJiz0SKSN7ZgWu5b6GztrahoW9aj+Q2KYiz6Zwu
	0xGdRJKeYXCXvvgMgFZE0k5hDt1YuUbVkA9WTHFixeCibZRPfKXZRS0tEpzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787466; x=1730873866; bh=JmdqMcNCGWuk0WLIaTV4HF3Idm+fg4Kj8jI
	0DPNFHg0=; b=fr+LkPgYt2CyyB2GagtQAeYCNEJGGsJ/zTgoMV39nOtbnNxqM6B
	heRA9wpisTbfgKFr5VHjSjZcMZxR1w7VGYZt5W6XfrDHo62lo2bzm2J8hIksVrE1
	oZJJRqxW6kqQ/knfMSVkQKl3CW1FiGfRQQJLQkN7lZ2Ztq/kA4CfB71JS1BlT8v7
	/yb7T2KnZV65sAG5UMRsN8Bbhdy+8vVr9H6gBgm8mLdrtXk2n2BQ8hlP7vddUZKD
	+sCpKpwvChc46bB/MBdmEhXf5EvRIUGZDwymtNb1EyjZgCrX762uzF8rKMKtMO3M
	gAn13UN2QkTVX8Nffzf4HljAP6t8jQRfdtQ==
X-ME-Sender: <xms:irgpZ2wvQkkHoXnAx1eTJiFdBnrt0CJUh-hZmusUHyv8YYDIxP_jlQ>
    <xme:irgpZyRVT089cEr6a6ADFpr-PqK2cd9wdTC6t9G7ahf2nVogSXkepNbbzhpMhtXN8
    OJvDKAj1Ba7567mMw>
X-ME-Received: <xmr:irgpZ4Xw1bftTIzQqGNTEN_o1Upis8swdUSqnBKhHEnk1URvdMtsq_YO-epjHkNMc3xs9r3FxiaRgHUI7cRVMpDJoOHAuDFH70EHCYAZ6gY-Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:irgpZ8hSrtHXXoGatLxY9OUQc_1vyHaptMFKEqGf2wKKMVdjvWxgdQ>
    <xmx:irgpZ4CzPOLMorIV9sc8BI5PMP28DSCCD8jqj6mUbuJXaIWx-RAlXQ>
    <xmx:irgpZ9IJBNgyaJfPrmOnAOZNXqGIxM7PvKqa0s-EXHnDIgy_SVberA>
    <xmx:irgpZ_BrwDajmB4R9KvT8O-9Ns5opG-CJ9YqGpy6uKoaksfjwuI_6w>
    <xmx:irgpZ37J95qW3lyG-rE-eWGqWI0XJAqj3ooNkSJubmiDRKg8BD3qJFJZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f123c5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:23 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 17/22] sparse-index: correctly free EWAH contents
Message-ID: <76e9a6d57927cb8e7363b3af20d9b194ab258b21.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

While we free the `fsmonitor_dirty` member of `struct index_state`, we
do not free the contents of that EWAH. Do so by using `ewah_free()`
instead of `FREE_AND_NULL()`.

This leak is exposed by t7519, but plugging it alone does not make the
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sparse-index.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 3d7f2164e25..2107840bfc5 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -2,6 +2,7 @@
 
 #include "git-compat-util.h"
 #include "environment.h"
+#include "ewah/ewok.h"
 #include "gettext.h"
 #include "name-hash.h"
 #include "read-cache-ll.h"
@@ -242,7 +243,8 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	cache_tree_update(istate, 0);
 
 	istate->fsmonitor_has_run_once = 0;
-	FREE_AND_NULL(istate->fsmonitor_dirty);
+	ewah_free(istate->fsmonitor_dirty);
+	istate->fsmonitor_dirty = NULL;
 	FREE_AND_NULL(istate->fsmonitor_last_update);
 
 	istate->sparse_index = INDEX_COLLAPSED;
@@ -438,7 +440,8 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	istate->cache_nr = full->cache_nr;
 	istate->cache_alloc = full->cache_alloc;
 	istate->fsmonitor_has_run_once = 0;
-	FREE_AND_NULL(istate->fsmonitor_dirty);
+	ewah_free(istate->fsmonitor_dirty);
+	istate->fsmonitor_dirty = NULL;
 	FREE_AND_NULL(istate->fsmonitor_last_update);
 
 	strbuf_release(&base);
-- 
2.47.0.229.g8f8d6eee53.dirty

