Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3B1AD250
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354921; cv=none; b=S5dusHIjlPGAzwmFZIIj4fi2nNQeBbma2KdMQSGrpcqXvFsEvkqn7GoCYJolghWa/YfF7a42so/OKU2z936kMmImc3DnGR71X82pWuaCWTdtLq73kksLiXmadQEimezDAsgluz+jySV70+8CNI0MxCMw+iLwExwNukqzIInlcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354921; c=relaxed/simple;
	bh=GYikfNQ7yWqaozdcScET35JZjw6jit6Wp7EIhOTyjTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIdpVqHnd5lnKpEBooKl7OPX0w4UAnLfM/E4diGcUm+rMMk+JkVyorkPIMzCyylmRLR/Slq81vGUFeWqWv1gaZ0sHMvHpjVrc50rCeBurZxk0LSBzJYNOE7Ci5JtvTqVYZ/93uYW0NmWdeqUfSNraRSIJ/k9P7W1mIFdj85mtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UH4rhlzp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IxV0S23A; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UH4rhlzp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IxV0S23A"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D123E11402DE;
	Tue,  3 Sep 2024 05:15:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 03 Sep 2024 05:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354918; x=1725441318; bh=9+01RIOplL
	3MejPA2j7JjS2DT7phb0RTErJSwO/FFpM=; b=UH4rhlzp7nM5G6PxVGKpj//ofF
	p89uBbD+0kX6EI0nVMOT4B87lto1Dxowwpi8shafcocP/Q+XMH1Ds54j8qZeL5yW
	UmF+8LE69ikohwxVBe3jtsk8DnHGtIqCLQqy3J0nUGByrf0cVY+8MzUMEY+8ZR+I
	qYv0w/ujObk/qL8PUMijYHBwHVkNu4wAfaxnxlWkD6ymMEbdrCtq/VqwZdM8Hcle
	sgugBl8tRJaXkNDMUqXvMA37+q8garn/JoPqH10gScYxPlsX3C+PtVkNVeEVl6Je
	MRXO9J3Vysxp3Cs4W4lc2tEifmTit/dYXGmwlmLe17+VkeOsI/0fzAvw3FJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354918; x=1725441318; bh=9+01RIOplL3MejPA2j7JjS2DT7ph
	b0RTErJSwO/FFpM=; b=IxV0S23AkyrM/fE17kdb6QkCtmpiSF9kKR9zlLptj9ks
	s+ZAkQJW6vwaJ4E3ZFZ16q2+09r1hH/40iNEd8NNTAKZch6968CdhhlMRGJe0rvD
	DckDtcOpgLmr1S6qwaVd+MDBV8Kk1T6Rh47l9CIawNZmHHOvrYLz/X6FfwrThMV7
	aSjzMppRCkJaa/212Yflb9/ggah1zZWPVYJ+elGnWOX0839EC3ThARN6uj6CkS5z
	lQno5YF1rK4lS+rfCLL4g2h2KRmSsKvkduPJl9bopowpDOE5fxMhN7nJJHwTdCqA
	aAcKPh/JejV81TpMGhbm3pZS75BktGM3EHnFS7ZlZA==
X-ME-Sender: <xms:ptPWZtUYTBn9K0NFNmZhVm_TJeqMyz3y36CyJweeKFinsfe0jGCjrQ>
    <xme:ptPWZtkMCAZrIp9GVeRf4FJKe8rrx9XaULiYsL6cYhOhvoCvZANzKVRmVFAdwFqSh
    Tu-HbAoVPgS-5jLIQ>
X-ME-Received: <xmr:ptPWZpbGZMobfSntTWxdAegEjjYOXC1cOH_yd0vo_giLAoXMDdDKZ8IDYWNOcPKjuDxhg9h8t5EF2MltANzkJvlzvR_UoxJCgwHDIqGIANpuDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheprhhssg
    gvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:ptPWZgW-fiLVqA6rgCqTiBvmjQqcJiJ0FEvkx_jM-BvU8PwmdOzovQ>
    <xmx:ptPWZnkqj014OTr4ns2wnq9InpHSyZITl8q6ObqWi0757a93_wEJGg>
    <xmx:ptPWZtdnkDyX0iAO4HqldNv6peywK2D3KDNO56_SUtHA7KBbulLX5A>
    <xmx:ptPWZhHymCWF3_5cTp36jF76j4X6jLMv_X4VtAcaQxjWw_h2PqVX1A>
    <xmx:ptPWZghqA9f3IMrSqTbSyhuRApx0dAYElrQz8TLGzSF7N4y7Ox1IGx1U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:15:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 023f4953 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:15:10 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:15:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 14/14] clar: add CMake support
Message-ID: <d51c146cd9d866b4900e0e75a4bf98ca45c720f5.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that we're using `clar` as powerful test framework, we have to
adjust the Visual C build (read: the CMake definition) to be able to
handle that, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt | 53 +++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 832f46b316b..608fd3fe709 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1004,6 +1004,59 @@ foreach(unit_test ${unit_test_PROGRAMS})
 	endif()
 endforeach()
 
+parse_makefile_for_scripts(unit_tests_SUITES "UNIT_TESTS_SUITES" "")
+
+set(clar_decls "")
+set(clar_cbs "")
+set(clar_cbs_count 0)
+set(clar_suites "static struct clar_suite _clar_suites[] = {\n")
+list(LENGTH unit_tests_SUITES clar_suites_count)
+foreach(suite ${unit_tests_SUITES})
+	file(STRINGS "${CMAKE_SOURCE_DIR}/t/unit-tests/${suite}.c" decls
+		REGEX "^void test_${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*\\(void\\)$")
+
+	list(LENGTH decls decls_count)
+	string(REGEX REPLACE "void (test_${suite}__([a-zA-Z_0-9]*))\\(void\\)" "    { \"\\2\", &\\1 },\n" cbs ${decls})
+	string(JOIN "" cbs ${cbs})
+	list(TRANSFORM decls PREPEND "extern ")
+	string(JOIN ";\n" decls ${decls})
+
+	string(APPEND clar_decls "${decls};\n")
+	string(APPEND clar_cbs
+		"static const struct clar_func _clar_cb_${suite}[] = {\n"
+		${cbs}
+		"};\n")
+	string(APPEND clar_suites
+		"    {\n"
+		"        \"${suite}\",\n"
+		"        { NULL, NULL },\n"
+		"        { NULL, NULL },\n"
+		"        _clar_cb_${suite}, ${decls_count}, 1\n"
+		"    },\n")
+	math(EXPR clar_cbs_count "${clar_cbs_count}+${decls_count}")
+endforeach()
+string(APPEND clar_suites
+	"};\n"
+	"static const size_t _clar_suite_count = ${clar_suites_count};\n"
+	"static const size_t _clar_callback_count = ${clar_cbs_count};\n")
+file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${clar_decls}")
+file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar_cbs}" "${clar_suites}")
+
+list(TRANSFORM unit_tests_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
+list(TRANSFORM unit_tests_SUITES APPEND ".c")
+add_library(unit-tests-lib ${unit_tests_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
+target_include_directories(unit-tests-lib PRIVATE "${CMAKE_SOURCE_DIR}/t/unit-tests")
+add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
+target_link_libraries(unit-tests unit-tests-lib common-main)
+set_target_properties(unit-tests
+	PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
+if(MSVC)
+	set_target_properties(unit-tests
+		PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
+	set_target_properties(unit-tests
+		PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/unit-tests/bin)
+endif()
+
 #test-tool
 parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
 add_library(test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
-- 
2.46.0.421.g159f2d50e7.dirty

