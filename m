Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7819148A
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162710; cv=none; b=a+gxahQ9gLJgjpzEAbA0tXrHTsD4SyUvvZOSl6Zf6AFnTXm1dp+KMfH2gRn3l2Sv/K8Henk0MNpzXFnCQXqPy8ZSekn6moo3F4zFsfvBFQ1LShWhLcIGqiL/evngyA+7JFQiNMI1iRcTorKa8b67Ep9lJExXIvo7nWT0VhD0m7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162710; c=relaxed/simple;
	bh=otBYJDTv0gRId/5uczKSEggpmDaJ+3GgLHUhS1ux0sg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNt04ykFqH2CsjFQoHIUgR8abk7h+51WwXCAYlPwWGcpdgSRPSrR72z/MYj7btp+1bLajdAIoVkvLIucpxG0DxueARzXtaSpJZhVWvKJhh0jra4vf0xPpK0Q9Jg30byWKZLDIWgAZNCfFUeO4sG6kBRJxBJ7gS4itlnNypjeKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lt1+pTUt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1leEA5A; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lt1+pTUt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1leEA5A"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5C7591151A9C
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162707; x=1724249107; bh=dn6/T2X+tl
	LtK6xfey+zjja8ro5u/5BaC0FCx5P/YkM=; b=Lt1+pTUtKOo1GVIUWfEcKHcKtV
	uNuQMGe6Dt3HlJjTb2O/V4Qe0jIakdi9dnL8vIrL/0GTm2bfCNLD+VuFjAkThenS
	74ttad5k4PL8a4DTaKMDLQL5AliYZ6B7dWCQamwCojgYZq+v+95SqVt75fUO4teL
	FunYoXROK5LzvJLiVQM01S/XnKQ2P5lz4wnBTPrGm2OeE58O9Nc4qbOQHqDhA0zI
	7A2OK/32OdYPZBqSD4R9D/n6wBpbFEBpBfQGWg/FHBPy5WTjNizpFfNFd0g5kprJ
	jBK55EOxY9/3wpgDbT0yCDudm0qtZfnzoKQuwDpiYXPjZgVMsc8Jji3rc+SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162707; x=1724249107; bh=dn6/T2X+tlLtK6xfey+zjja8ro5u
	/5BaC0FCx5P/YkM=; b=c1leEA5AegFKkWQ+ExN2DseGRlHMvLRiKTCugpKAbuOw
	pbYi3uoD4lLVUoedftK4f3R13Og46lpDHGarmVzwf/AMclmX7wvpoCP69161mQJV
	uO+lC3TlqZ02QK7aon/fHzo2mdTSQU6oBrXtYuvN/sXWC1h8o3dUF/hYnllUj82L
	Tsj6DSeZTkaIouQQBx3CEmpX5CSJr/WRkJKeTaV5U/lZCtdTmzf7NFsgZYzGuzHt
	oBvztD0fqlt3Koi8NffCs4IwppLDFf2LW3PJIw7mBm/mUJKcSVY6sdjZd+7Dv7f6
	2pFM9NoUGhWRwLu7yiOSFO9TU6ByB09xlZl0giO5hw==
X-ME-Sender: <xms:k6LEZkwDTLPrURrdgJD5dftLWzqbhJIoX995_aZpr-aArDgyIZpJPQ>
    <xme:k6LEZoTLWdxoXIwwY9gsvEvqLAJoMs38UyXjTRiVJ6xK9IqBCzm78as1_yLx8LaQn
    DjYFxgN6KxC1FIp2g>
X-ME-Received: <xmr:k6LEZmWXJIzpofMDkXVG73oTvck06hZmG6_hL0PpIwn4nsffOnygZj6hIDo-6nQNlpSpbSGz7VWXWQgDCR9pMdm5XSrk2QSg9ORy9WJvu3cLbjX0oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k6LEZiigmPdtD4wgrntw-8pG1uq8xipcbO5SH8DPg0s0F1z6stHzyw>
    <xmx:k6LEZmDlAx1t0Fv7nFn8cCk1l0n4kcdWevy8sLR4ohRA_DThxiG2lg>
    <xmx:k6LEZjKGIxAwpnoWMSS9mYaCxdgvP3_yhrZimNN5MbIpwUkwtTi_xA>
    <xmx:k6LEZtCgZk4kmZRXTZTdEhH_p7AEsf89iclK14q1ADWahrg0IZl7Vg>
    <xmx:k6LEZn6IRM9d-QVacyI3bXFP7TgnOnhPPUgqZe_wKO4SM_ewt3GeF7HE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 124dc988 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:35 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/20] convert: fix leaks when resetting attributes
Message-ID: <ed0f01bf92c83fb7371326bd1a59933619de2c47.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

When resetting parsed gitattributes, we free the list of convert drivers
parsed from the config. We only free some of the drivers' fields though
and thus have memory leaks.

Fix this by freeing all allocated convert driver fields to plug these
memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 convert.c     | 3 +++
 t/t4150-am.sh | 1 +
 2 files changed, 4 insertions(+)

diff --git a/convert.c b/convert.c
index e6184d21f26..c9a31eb4f03 100644
--- a/convert.c
+++ b/convert.c
@@ -1371,6 +1371,9 @@ void reset_parsed_attributes(void)
 	for (drv = user_convert; drv; drv = next) {
 		next = drv->next;
 		free((void *)drv->name);
+		free((void *)drv->smudge);
+		free((void *)drv->clean);
+		free((void *)drv->process);
 		free(drv);
 	}
 	user_convert = NULL;
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5e2b6c80eae..232e1394e8d 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -5,6 +5,7 @@ test_description='git am running'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: messages' '
-- 
2.46.0.164.g477ce5ccd6.dirty

