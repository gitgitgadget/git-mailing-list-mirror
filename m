Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFF185931
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351223; cv=none; b=kSNPerDR7EeSl/su1sDL4jFB6RMOnLpq4gZsedsGYRqzpYy2XPqpx3CJe0SxFuEZbUFeXdc5WUUo4X+3bxJD0xvziaUHpEqsMPT9hOGnJOO/wj3zj0pyE0DS559IiXDlw88U/gXp6p3zhRzhl4louojiIok+P4MtbtRkOwzZekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351223; c=relaxed/simple;
	bh=akXhjL9mBMsT3F0JkkzTw1autuMoV32UjNucaM8p7aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlMKbPJBOcZWL1v5C+8RUxbbi6rDPoTkoUAA19tRJBNePoF3ura63+yjkTZrwXCZJPq+qAbmi2rY2FBfPoGGBYCIIesO71fXiRyRRFGwtolgl6reTNezLWioHs1sD7AWO4AtGotIPtAnXvxkyDzwrYyKw+3Of0iFdaoYkT701L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J3B4qRHP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j+2yKznu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J3B4qRHP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j+2yKznu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1547F1380684;
	Thu, 26 Sep 2024 07:47:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Sep 2024 07:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351221; x=1727437621; bh=o5ZHdr2XBJ
	oWgsDTJpfrIdSLficG3nXYvzgnXdYHxNA=; b=J3B4qRHPxNMZJY0CG4YmOILkUo
	o3YhGx5VeOFVlEH8inhD+I5tIqb62H0+KNmp2Zn30z74e/ibykktzOS/qSara+Tk
	XpivJlfe5nD1NoKVGeAhSgsE1LWzJPtxjyocCfQs6+fM8/xb/+4iwTNCiCHCqsde
	GmXRo6+iy1By85nDDJNrFi5Kua9vT517T8QM1IJkRmYYzCRI/MKt9eNz45tL6Mkb
	Fw2lICmrLZ4bCzJNsogqHCZ5j2HDyTL7xgenthC47ZLborqC1pa2uALRpOP5Rt/L
	UZrEowZK8Ngz48cz7x1xFKj6+ZC/lcU3vCkicJscDLQKBp8fLhi2ZheFxGyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351221; x=1727437621; bh=o5ZHdr2XBJoWgsDTJpfrIdSLficG
	3nXYvzgnXdYHxNA=; b=j+2yKznu2PLjIBOdguf8rwE5Q2Q8C0O+OnQa2kQQjX0Y
	PvAlc5mB/6Dkiz+6pU6Vi5VAWVvHtVEP7IewNVHJws0mBLafCDK+4dqYf+HGHWth
	38g2SlgjeszaQStwy+H2WDzk3IsAUzzAPyab3mle/79FRrvtImkLzR69uB5RN0R2
	6SG50ssMxxyvMHyWy9Ve2BlpyEIFXbyX4Z+dXFNLr5X34yuYz30p/zBKbhFClE/F
	MCtklP8p+Rr5DflNwVdPLJXa5CF7KtIF+mHvGabg+gya9d2dI8xa+yYs/Mxf7kFA
	Bs01ZYxdnXBUCD7I21hKrXnfFir0LZCj33dsBkaCBg==
X-ME-Sender: <xms:tEn1Zp5E5ETykamHh16QRg_Z14Yn3bOcESNie1qv7TnCcyf2KOSheg>
    <xme:tEn1Zm5Hdfg5ANwtUMI_ywUw05y2wOAG1K16y8THSBxfE5eB7kdgn6_CiRReSnkCe
    whwEc20JqoJzpdb7A>
X-ME-Received: <xmr:tEn1ZgeW5FzbZ0HQ49DUYmUq0eq5X_5mPp92eWiaygTJ6DHQf-rZkkr3UuiPiEPuO0DKVYuyi-Pj1qVQLbzEG1UzoD1-fDyk_b7EzJjOBvOWNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tEn1ZiKXdZHelsXHBqfUYh1EWJCCEIA5AqXpXBHUiSxXaFadX6_uZg>
    <xmx:tEn1ZtKpdaBbOkVh5cqLeXVPIFhshi7slu_0mrocanMY425oZwTYvg>
    <xmx:tEn1ZryWKjNb8wBBTV1HLOOtxgMcJrwDr_BnLYxAcF-qGXpgs3biRg>
    <xmx:tEn1ZpKnfHzQjaIcG4qabidjm5sL3C5V1gHvQFRJoveUHWcjJgdC3Q>
    <xmx:tUn1Zt2X8H4aXP5Icxw1diOW2p8o8eg1CA2gwJXJA-x3SrZOUQ2slqfy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:47:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33534e5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:22 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/23] promisor-remote: fix leaking partial clone filter
Message-ID: <da7768bad58ea6cd600b8517f943ad973d3d34cc.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

The partial clone filter of a promisor remote is never free'd, causing
memory leaks. Furthermore, in case multiple partial clone filters are
defined for the same remote, we'd overwrite previous values without
freeing them.

Fix these leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 promisor-remote.c                  | 2 ++
 t/t7814-grep-recurse-submodules.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 317e1b127f..9345ae3db2 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -154,6 +154,7 @@ static int promisor_remote_config(const char *var, const char *value,
 		if (!r)
 			return 0;
 
+		FREE_AND_NULL(r->partial_clone_filter);
 		return git_config_string(&r->partial_clone_filter, var, value);
 	}
 
@@ -189,6 +190,7 @@ void promisor_remote_clear(struct promisor_remote_config *config)
 {
 	while (config->promisors) {
 		struct promisor_remote *r = config->promisors;
+		free(r->partial_clone_filter);
 		config->promisors = config->promisors->next;
 		free(r);
 	}
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 167fe66150..55ed630e77 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -7,6 +7,7 @@ submodules.
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-- 
2.46.2.852.g229c0bf0e5.dirty

