Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E545191F68
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162574; cv=none; b=utRsUGTIFhFcrFSWWhXfRVUYrkOMrUh3qiMJdAgYE7EfExKdIgaN9zcah5zocCzv3yDABArYO9FxJIi50njlnLzZjO0ZD6QOFo48xwp1CtnViQk5EBJXvLhHR9zToGWgLOe3Ide8OxhBeJyKQHR7xT3NUCBnhfsldAkDjSsqFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162574; c=relaxed/simple;
	bh=iUSa3H7uad3aniljrI8u2S9gZyPTkfIDSLPOEft5Tf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4pJJ+XOUDjR2l7Z3i6IuS+Nu7wtHlfManbrzSaigKkDYq6U51/oH1f4dvxJCMsxOsvgKl7PXfYbAi/fBS9KlbAUqkZY98dJ6+3UOQnQg84kblkVipegpE19bKsqMYtIlAGOGph2JZaPk2rwDmv+YpDOh7cqcH0VTOv917lZ8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HmK32AGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QZToxqo5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HmK32AGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QZToxqo5"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 97F861389445;
	Tue, 20 Aug 2024 10:02:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162572; x=1724248972; bh=KVMoWPBCwy
	mHvUe8gbHD2Y9yqj2A6y6NU7xKRJwLJn8=; b=HmK32AGscK6ZVix8nPqeUMtQC5
	KbEnXvFXa1Yw4FhFUlER6k/lyGYBuoLfi69jlb7+Ia9M8A+Sqj4+NBXAWComcqZy
	dchaLEuXfJ53hkRwD0o34QL9eCYa6Hg5Z57oXPwSpw9g6AStB5Lprq2ssR6rwi2U
	UI+IVmwLaEtjt03gSnR62xdlH3rGqUJos83a8YT1EAdFMG0zOXL36ED1b3d1WjeG
	0cAJ7HmLRp/De3bOA8Ks786GDJEQCoxqOjZgtm0VYyeBF3wyO5+lcRZLfeyWxK15
	+IahsXAlLLawEhJYcR5kSHyCTXGnvU3gPvXsf465GYkaod5fLfHrmS8H9cog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162572; x=1724248972; bh=KVMoWPBCwymHvUe8gbHD2Y9yqj2A
	6y6NU7xKRJwLJn8=; b=QZToxqo5n1nSv2vnuMUlmmf72Noju9NdIE8umRul7O61
	cAcsXDZPqF7K4ORVAW4Egsmo4nQszZh+FiIGMG6TG69cX3q5iZ98iJdt9mhgercQ
	VxSlkanXmK7P53tCvUSqLs5TavI+00PdyVBrlvUPF8Quk5h1onDOfuR+niaKq4kp
	wECDyhYInJ6hTEBOqOSlUCHQTZ8Nsn37EyH6WULMdnRIrI4auiJBPT8sWmafqvhR
	eCi3YPNyJxfraU69UzeJVSU64hTKCiv4m+ol5TpKt8XhahZrXckirwarBJeiiu/R
	h4hJZR2PmNCaEf9z48lV8vvoP82wnkYLUSghJ90dPA==
X-ME-Sender: <xms:DKLEZrEVVuaCYV0O7wOmu_-yctK6ssLw9NeNRL04bqtlA1UNxWjSNA>
    <xme:DKLEZoVeRi-SwwFqjc3136WQ1Zt1MDAHM6wpq45O57TciaJgcSP4si-vioEVoR7yy
    IX30iaTa2WaiIOQLQ>
X-ME-Received: <xmr:DKLEZtIU3slYjT3Z6bACTJcdxP7gD3KrYL-oFF301H1aoSZSeOjemumz_rriO1PlJBrqENclEwHEvF-rfoCVqoRz_vGgCtvGqZdxJr5H9Fv0XCQnIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghthh
    homhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhtvggr
    ughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgi
    gsrhhiughgvgdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DKLEZpH1vgztvcv9jMHGtzK6WEg4CUmXbP--ai440Y4MKMmeLQZYSw>
    <xmx:DKLEZhWZ3lnEB1c_wJiawtXpG5kXPbCbJRrPMAz-nQ3azU9UTjMDEA>
    <xmx:DKLEZkOokheL1bTSVxJJrAye89z3lzyU2Mn0gmDTH9JFjulJFZ9Wmg>
    <xmx:DKLEZg1o_3bw1e0suUl-aLsfvslj1aEcnx6vfkIav7wcpUx6czVcOg>
    <xmx:DKLEZpScMH1egR1preQVApRjx5C9lBge_XBMbgZZCGUGr8ETl39ZjCOP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7a318c35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:02:20 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 13/13] clar: add CMake support
Message-ID: <131036c398eda859255ecf4a6162be90ca1db1c3.1724159966.git.ps@pks.im>
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
2.46.0.164.g477ce5ccd6.dirty

