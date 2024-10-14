Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0239B1ABEA6
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914810; cv=none; b=q55c8wga/TDgSeF9kBEazAh4Y2wccLTMrrwqzWPZeXu6YWHvwFc1YXa2bAYqX+wdPIVBPEPSWwCQSRgALZuTnwGQXz7kNLszL0TzjcZs/ZAbTgXKJbTCK9KC55szc6AJfjaqNBDbAQSYN+NWTQlJHTRDhxzdAqEZkNKrFBdkyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914810; c=relaxed/simple;
	bh=+yI83K1a0+L5dY9acS2pL/6311wdJOObB0OKyha7YH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I63fMQga3RzgDoB37uVdetld6KC+EQPNthAmKdQ6N8DlvdR709UCXcOSOJe70PxQs5CEIwi8u+fsS4xm5TWUnVr6ikxzh+yrPMlPYVv+iASb0Q6ik5UTTDANL6NMNlxkXiWlyPoQzKzqW5KMQ6G+5iHp/hZnlSXd4GIhkGzmuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nj2hagY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWoeZVGs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nj2hagY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWoeZVGs"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 13F3413801F7;
	Mon, 14 Oct 2024 10:06:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 14 Oct 2024 10:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728914808; x=1729001208; bh=Fz9gQvkRAs
	iUAHsqT95MhfuyrGDCWCR/pMfy+IWke7g=; b=nj2hagY6OmDQNHHrzyok/6oZ0F
	qJEO2NeyrYDPs35NAa9SYcxKDMn/2p/OIBe3ONmWfZeW4YiU685Gg7h3YlAScyxy
	jVlo8UPK/WDVXiitCm2bYcsRPxwAPgpBAKNHSBwcclr/F+K2n/+uTJdNwbh9nVkE
	VUJm6guEf6EppJ3ww8LsFLtNNfDBgGakyn9pTlY0z5WxZA4PX+8V+uycx/YtO3C+
	om83tNv7FvcRjsBIJlsR0ETXst9ZPEKth492ShdIUNJezex6fxyQJSfRXdo1nuRj
	akTVLlvi73coUalHsVINe0pBYi9hfuLyLlh78L7ecaFiFzdK5iBEtBLo/1xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728914808; x=1729001208; bh=Fz9gQvkRAsiUAHsqT95MhfuyrGDC
	WCR/pMfy+IWke7g=; b=BWoeZVGs7ae3D+emiIRftvv2t12crSd6A8GxE/tkzNVb
	epcF8CCCdn0hIOjDFF9rLCpcys4nurmz1987/31p4ca4CCythwDFlqQJIxkxnMfN
	XG8gQVsbyVmwFBr4QEhZDFIovQgvhAL06vv4wD7pxlmwoRKMfjp7euqwmOsejHBB
	jJKX+B2QWNdRte5x0al3brVSm92NtpNoVrw6eSgbXQmJkN8Q0pJxKlhD3t319LQW
	OUTcswd+nArP3XtjEmHdn3EoLREbUTdRyOT/yExp8qGmvsM0UkjsGAnoTIOjoM2Z
	lFGpFZr7TnVisSaaeedvXVbV951iYR2m41c9lbk0Zg==
X-ME-Sender: <xms:dyUNZ7epQnY7NHiWuBx0vSiJWQmeU-l9e0tCbQDjRZERAVi87CxIgw>
    <xme:dyUNZxPJhq3onVISoJtOoTh58uXsZs2Trq2MkQuIeh7SdfOTUoj7WPBsV9MWLu4rM
    hHc-jfQAXM2wAzwFg>
X-ME-Received: <xmr:dyUNZ0gH78mcRR8rsBRahBAxSSUOqN11dVJk84SF-1XapGC7wxMXT4o1VfIuf3W_q6mnGFBZvvMaAP8of75jXlO8G2T2eH_Y5TsMUB8yj1P3lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopegvughrvggvlhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dyUNZ881lCZDXDNqmj7AWENv-afAc_SdBgcfXK9lF0CSgDWzuSoYhw>
    <xmx:dyUNZ3uniu4--iyv0K1m81fw1Ism1vNeKKypyXOHfd7KmdUCHqLKVA>
    <xmx:dyUNZ7FtzLNDIuQZ37RWwoJ93hF9B6fe0MW-luIMT0EW9f1bYvd_JQ>
    <xmx:dyUNZ-NLYUh8C5Vn2z3F142vH5vnqEYiUrFAlu0Abw01aM5xPnnXjA>
    <xmx:eCUNZ3J4uNQTF4CWCTZ-wNaw3mz_OQe_wdO6n3FiebK4A6ikK_nJtnpZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 10:06:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d25a1ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 14:05:33 +0000 (UTC)
Date: Mon, 14 Oct 2024 16:06:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] cmake: fix compilation of clar-based unit tests
Message-ID: <b9afeffda292a068e81d05b91f759a5c53a24b15.1728914219.git.ps@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728914219.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728914219.git.ps@pks.im>

The compilation of clar-based unit tests is broken because we do not
add the binary directory into which we generate the "clar-decls.h" and
"clar.suite" files as include directories. Instead, we accidentally set
up the source directory as include directory.

Fix this and propagate the include directories of "unit-tests.lib" to
the "unit-tests" executable so that the latter uses the same include
directories.

Reported-by: Ed Reel <edreel@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 62af7b33d2f..093852ad9d6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1042,7 +1042,7 @@ file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar
 list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 list(TRANSFORM clar_test_SUITES APPEND ".c")
 add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
-target_include_directories(unit-tests-lib PRIVATE "${CMAKE_SOURCE_DIR}/t/unit-tests")
+target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
 add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
 target_link_libraries(unit-tests unit-tests-lib common-main)
 set_target_properties(unit-tests
-- 
2.47.0.72.gef8ce8f3d4.dirty

