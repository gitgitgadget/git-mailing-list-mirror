Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9131F1E008B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459451; cv=none; b=UTfSnvgkVbD4lNb32KJ9ev5KVoQGnihBcqUowrxjVrdbVlHZTiJJc3sUgFU7AbDexCiMhmPceud3kAMK3er7Wou7Gy2y/tUZddsLw4NDrBThetDn371TFl/ksv7Futmy3TFPkcsd3yh4R6GFDNFAzEc2Fr2giMAVcUeyG8phVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459451; c=relaxed/simple;
	bh=umbxzN25NfOdHqjq5CI+5XCOtv8lv1uEHuEAgvaWwMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzdxrWJmbfGBlexlJqaknExxhPFZpFmoc2XVPbfqqk8oKqwezlFw5HtSTSgVqyUh5H5cupcyDd+/j2h6xKZzVN/+g3IAT8EMr8KoPLuAMvFSirZErFfNXNhTtFdCV+pP+K8/cmmWCWMf4jeFNjRR0XMbbfj4zgs2G77m5Z+qmmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cNcFS5Nz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNztjtsn; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cNcFS5Nz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNztjtsn"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B68761380230;
	Wed,  4 Sep 2024 10:17:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Sep 2024 10:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459448; x=1725545848; bh=GPubbogDEu
	PMFR4oz3KDmn0a5xYshlqV6IFNlNXYNRo=; b=cNcFS5NzvH44qfrdOjaaSOkzqo
	0Fx9drI16aslWzoXe+jUweLCsyuepEtM+8PzS606rHjIPs2a5oP2NYYI/HQ8hGSJ
	8FTmiwuoJ+RSvOjV2QCup8aka2NmwQANqQgetVg8wGsoXmXW/nt6YK7GQSHb2Lna
	Jmk6OD5caYpZLHUsAxwpklvFoYvvtgpQAQ5ISijLVFRJHsEEyUX3/y4ER0mWyY3w
	nlN1yPNZuPe/+rcW3qgFoyPT6y4ohW6kjK+JRalw+bY/g+MqLj5f8e02hq/gOWAk
	HjwcraB5FqUBQ3Pyw16GJS6yn2RRlQEA54O4OpNCQ8D0kBTWKTssTOInzs1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459448; x=1725545848; bh=GPubbogDEuPMFR4oz3KDmn0a5xYs
	hlqV6IFNlNXYNRo=; b=TNztjtsnhpT8pbUWvSa36cG/GD5Z/BnA62oI3CKCOJdm
	sCfI8uzHOOFxOuk5/qJOnEF6ITCzOSX6ZV38tCNjQHpfyW4Ib/GSn1S3q2UtTcsT
	DG3nqMhS0QTnzEHPnpN6SYoK05StiPs1NcV2CS6eCiIH48PmEaA+p7Paxb+m3doV
	2hD0uujCHEGyFgNeDMyqDdTLKMQRybN2/zz3VcgX8RPXqc1hvrwiFHF2D4Gkf27/
	VHGSzgvTNHQl63Yyhik2Q6KVoQJnRsMODe1RaBGZQ13vusNDrrXMwhYffNf4rjEo
	yvlEqMvlZXZIyyH7x5RC4jPT8qelo6/7PJAtk0QVJg==
X-ME-Sender: <xms:-GvYZhs4WkzruJ4k_MWk-Qn30HpRt9e2uejFDtzH9r6B8ak0VXeU7A>
    <xme:-GvYZqdBrPujVyXkQKx4gWpf943ULUN1wkmNt4dBcInjDntz_SejwRNTt38aEiAvj
    zSLpokJ2fgbu1MzpA>
X-ME-Received: <xmr:-GvYZkxWqDqO7OCYwrZBAqwy48Hq481UvvqhelB7j-lQcc7amJUvx4iw9I5HS2hImuySuQW3K5ngggDfOxS1NIwTSd4FsATKqjDQ3KfDyEWOMJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepshhtvg
    grughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-GvYZoNyKPILHj5T452R1PLwiWVM1Piczs214uTUxDnQSRqoJ6volA>
    <xmx:-GvYZh84ItkqmNp_cvVklKCkKju3-Ar3pNNOzlI8ocWN2AO7OYH_AA>
    <xmx:-GvYZoVbeFFDWD0jEZQurj1aUrt6Amjv_o6BlL8vUVOYMuCFLLhgYQ>
    <xmx:-GvYZicHsvkHuNB0TwfeH1FuRIk4vwSlFbwgiTdEiND_nMuGwadd8g>
    <xmx:-GvYZgY6m-378mKUjXRRYhm5YbdSfKLNARWOZls2YzYD4DFhDyPKnGOS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:17:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82ff3cc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:17:17 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:17:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 14/14] clar: add CMake support
Message-ID: <8441d29daa868f74a55b7c1111edb336c5502ebc.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

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
2.46.0.519.g2e7b89e038.dirty

