Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C25209679
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624781; cv=none; b=YaJ088HhKw7oWnsMBJ59ArharkiAYs5ajf7tBDqKgK3hv/BdbtmwpxbV2quO+UbzA72pLnMljObuTimwW8awKHjqMhJm2zWTdEHsE7JkgM7o1B8qlKdyH/+/MGAJof0pZYLoP+O6mMuHaa6Zi5Xffh9G2NhJuOJKs2kgD3dyk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624781; c=relaxed/simple;
	bh=UuCFJkPoyxER7iGPRZbJFc8IZ07FKz5kwtZPBD1U2dc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkyGRz9/W/EfhLLvtF7y7gsQZIxQzUayI3+ydy6zO9odt3RP2v4LQoy8Qg8aPem70xxoQ3PGke9S8I6UcMwza4FheOKSy3RQS1Q2BoiH3llrQSLnQ2FEP3z2VH9Mc2BgPKnN3raLWEB5E0F4HyPVSuY6thQQaNF/pnskRSqW93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J2v5iDwX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gzd0YmKr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J2v5iDwX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gzd0YmKr"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D37811400C4
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 01:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624779; x=1728711179; bh=NvMn4yIYOQ
	eHoZTsAWbx/uGMpS8oHLqnnd3k23+pq6Y=; b=J2v5iDwX6CWTEUiLkoy5QUeaqK
	jUQSQ+elcf3zBd1AUVjv5B25hXvyEa6kQ+GZBOM5ptmhaQiTeMZuxHw8rwNUIMGi
	IG50fOlS1gxyHrrQpCJ/K0mELtaGrpWwvem58TStXqXul4zvJs9avYtAnCERWRf6
	sR7CgzD8Dqn+YtEa4mEActgPYG+rbtrqUGMJcVL8oLVVeF/HNazDsSx1VGfhqDwo
	oIL8b4VDTcO4y0Dltn61jLfPAWcKkfWcaPzh/EjH5uf+a0yQBxwwWYL0NEo+nzQ4
	AFw7JZ5Ey/4EqTZHlr5znXifSLmTyCpzFEosQmlb/swVubeZAXOndC2JadVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624779; x=1728711179; bh=NvMn4yIYOQeHoZTsAWbx/uGMpS8o
	HLqnnd3k23+pq6Y=; b=Gzd0YmKrSFMGPKr166y3LFEBVAW/S3kvNYMEkggyD0Hq
	0NVHNb4YHQIh0DkRgZOFkmcOVbAxT1RmjHgl57agI2jYrwBnzgV4Vv7g0zSWkCTo
	z3roYwRIZsYTn4+/Q7Z25o5X+oZ5jr9+Zyyb5tFDVlhyvNSEJcAIGcieJaFjatrb
	uTyJvvqh3LA9E8RFjSuWoA0AFd0u0L/izZg55dyzTHqAVzBcip9/gCfyAJeBTr02
	El9PHqRWdbS0ULo/NaSzHNCqkgwEpsZ/4p83b2jpZb0v+cx6uHUdgpgn/hBnZCTE
	x2JOc0yeVVBcES6897WU2LSHxPQFgbB2U97BdmQsIg==
X-ME-Sender: <xms:irgIZ3nNXM_JTqUpxd_Uzvgw45Ex6rpwA0c9n7O7wqDt-9TZbKND_Q>
    <xme:irgIZ61OoExM_FrnazptQ4JwAdN3SpXgG-pqIR-qvOF2EZOw9hzqtfgROGSWhvZue
    TFnCP3uLrKYrQUCdg>
X-ME-Received: <xmr:irgIZ9pFzSutDTvum6i_29PdKL2NhJqt5wVPl4E5oBeh_T-94tdN3Auj8bK8ed-o4L5Kxi0Rbx0gDInHBz05wbxd84s17G2amespOsvViZZnROY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i7gIZ_kFBMmdDUfj6jCQbULx2oS_b55L-dl4rvq3a5dUjvkmx08ccg>
    <xmx:i7gIZ10F5N93haUoSubwuSkIfjv0ZzgByO_oEoTjWuisOsh1KhkGYg>
    <xmx:i7gIZ-tyiknens74r5GE5MmT0qMh8RecJaFDtV6eub_YR57vi0fHAw>
    <xmx:i7gIZ5Whc-BbTca1Kc02ni6B3FYRCrNC47ree7fec7ZJKnesACO-8A>
    <xmx:i7gIZ293jgjubGEmFWxmbhIoAOdAbB6IJymFeVEyLHwaAeqBYwHrnEPs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9ba339c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:52 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/21] sparse-index: correctly free EWAH contents
Message-ID: <170cc61edaa38d3ff76578f2228e855f19b8b8b0.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

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
2.47.0.dirty

