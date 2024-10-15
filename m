Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4221C9B68
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985586; cv=none; b=W+UtjkZBhtstRdOCn3uOqJ3N5sx0qWrKwCSuAUEBk+fKh01bPzgv6A3DQDUFVyr5F0F2eJfS0rrEHMjWodch1nMCazjHFt7fONXObEECrrxjmwO3HvE8Bv4WI9o7OUljERgPMoA0SsIGZ9HF/ys1UC3IyUWTNSNQ3UPHprVve68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985586; c=relaxed/simple;
	bh=GsLwj5/w33fv4cikxIvLwctBSP2ExHPAE6i4bKSo6PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqY5uMQuX1CWHosaXoeQLAddd97eO8koO3aiBEknKQRjKJqDTJjy2eHxmYUUaOWFcvOhP5BHeonyXYKwRZDmpgC0yc3t+IzYDCtGlkFJhmPkDwvgRmPExhYOcr9WqaNSZq7auyfy+XZI3Ox0+hKDtcTcWK1ZnZPSdk3GS5zswu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YiCtg+Lk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLoR0ktL; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YiCtg+Lk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLoR0ktL"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B555425400AC;
	Tue, 15 Oct 2024 05:46:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Oct 2024 05:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728985583; x=1729071983; bh=nXEBxyoUXU
	2vNAnXcDZ4i2LAL0iOEDM9z+7UIryYypU=; b=YiCtg+LkrYNN2EHuktnkvghLQQ
	nU5eUR1P+AsDHKZyFYJVtKvGaGW7XTNQzPYWWTP/SIq5PlGermMwDYJLEuRhc3kM
	QaNmHCv3R6okFko5rqDvSNqRFBfifvcOJOzAJ5a9NHTuTOYnaelh29m/WTI7JUik
	5n0idmgIheplSnzKs5nDvslAQ5UroqAIfBERzbrNSWEKAVUO2ncIUhldZOGXvK+x
	VgEBuhDx+LAr26MHafsvO9oPNeRU2u05W9qCElf0G7umoIwkLS3dktXOLNZrFFFp
	HGLLGkqrPbJ+d2y2RwyQQ22s/tI5in6nTmtVwnQz0uchLEBZThgYfeBXQXsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728985583; x=1729071983; bh=nXEBxyoUXU2vNAnXcDZ4i2LAL0iO
	EDM9z+7UIryYypU=; b=VLoR0ktLyx7WZkOpDelgSXK7cdykhPccGIrrl0RL1fjZ
	jwsasDa22aj5mCTAtuIhY9kO0vf0L6DNeSmWk2rUR7ilAzxcGW+TDKYPT7blveUc
	YXVrh3s41OlYqx955YjRoYKpbWW5Ht5uNxmDak2Sb9kSv+2HXgmwfvEZ4XXHaKPd
	1ryTXYuueRv8qd6fHJkrM3T0pAflh+EseMAeOFiSg5c5RTGvgSRT0/r/EcVDqu6F
	hhssoryOfmkXarP3IzLwAznjGniH88tv3hl/KQae5x+WyDoDa9Iokm8xW6qgu27i
	568fOorNmrzU8I+SDN8Y15M3wpIJGE5xDScsjjfKOA==
X-ME-Sender: <xms:7zkOZ0VJsKb-ZKO0gEA2v9DrgRfvJw5FGZ8AmU9uXoMhfnJ8Z4OM2A>
    <xme:7zkOZ4lMdQRFe8c19w_Gk-fY14q61q1AIeX5ZyAYXGgreJ2n-dEiw0WsLqKmQqjCE
    _wGYMzJI2q4jG_2kw>
X-ME-Received: <xmr:7zkOZ4YEYZzUEFX8xhbgUfBueRguT3mNaFYAZrEJ-VyS3FDMGKNZqGXu4AIJncPBz7oR7gqm61cR4HqQYeB40Di8zCCjveh9DzfEb-YLfsiaPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:7zkOZzW9ymOIGXrU_nwARSiw-LY5PnrlQdCXUZkjSkxd_WKiRziACQ>
    <xmx:7zkOZ-nxb0JSHWe1KwLzYOzJHUKIBUfbvt-wGEDt5bmr7DtWN87zvg>
    <xmx:7zkOZ4fys26PMUo5I_M84_aeinApr57NN91pSjCjAXr2NyHjaZCvRg>
    <xmx:7zkOZwEflecPnYFX-onTL2lzVgTiRvl07u8GuU1ZM2s-KbWg-IRiWA>
    <xmx:7zkOZ_Askeexseg4_U-fS4A-XafYCoCo0sBNrsUAfd46eYQeuCCblC_L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 05:46:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f23df85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 09:45:07 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:46:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 3/3] cmake: set up proper dependencies for generated clar
 headers
Message-ID: <cf4955b2ddc04786a15a2f59b6a96c9862491854.1728985514.git.ps@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728985514.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728985514.git.ps@pks.im>

The auto-generated headers used by clar are written at configure time
and thus do not get regenerated automatically. Refactor the build
recipes such that we use custom commands instead, which also has the
benefit that we can reuse the same infrastructure as our Makefile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt | 50 +++++++----------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 093852ad9d6..9f80ab92656 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1002,46 +1002,20 @@ foreach(unit_test ${unit_test_PROGRAMS})
 endforeach()
 
 parse_makefile_for_scripts(clar_test_SUITES "CLAR_TEST_SUITES" "")
-
-set(clar_decls "")
-set(clar_cbs "")
-set(clar_cbs_count 0)
-set(clar_suites "static struct clar_suite _clar_suites[] = {\n")
-list(LENGTH clar_test_SUITES clar_suites_count)
-foreach(suite ${clar_test_SUITES})
-	file(STRINGS "${CMAKE_SOURCE_DIR}/t/unit-tests/${suite}.c" decls
-		REGEX "^void test_${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*\\(void\\)$")
-
-	list(LENGTH decls decls_count)
-	string(REGEX REPLACE "void (test_${suite}__([a-zA-Z_0-9]*))\\(void\\)" "    { \"\\2\", &\\1 },\n" cbs ${decls})
-	string(JOIN "" cbs ${cbs})
-	list(TRANSFORM decls PREPEND "extern ")
-	string(JOIN ";\n" decls ${decls})
-
-	string(APPEND clar_decls "${decls};\n")
-	string(APPEND clar_cbs
-		"static const struct clar_func _clar_cb_${suite}[] = {\n"
-		${cbs}
-		"};\n")
-	string(APPEND clar_suites
-		"    {\n"
-		"        \"${suite}\",\n"
-		"        { NULL, NULL },\n"
-		"        { NULL, NULL },\n"
-		"        _clar_cb_${suite}, ${decls_count}, 1\n"
-		"    },\n")
-	math(EXPR clar_cbs_count "${clar_cbs_count}+${decls_count}")
-endforeach()
-string(APPEND clar_suites
-	"};\n"
-	"static const size_t _clar_suite_count = ${clar_suites_count};\n"
-	"static const size_t _clar_callback_count = ${clar_cbs_count};\n")
-file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${clar_decls}")
-file(WRITE "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite" "${clar_decls}" "${clar_cbs}" "${clar_suites}")
-
 list(TRANSFORM clar_test_SUITES PREPEND "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 list(TRANSFORM clar_test_SUITES APPEND ".c")
-add_library(unit-tests-lib ${clar_test_SUITES} "${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c")
+add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
+	COMMAND ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" ${clar_test_SUITES}
+	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh ${clar_test_SUITES})
+add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
+	COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
+	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
+
+add_library(unit-tests-lib ${clar_test_SUITES}
+	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
+	"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
+	"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
+)
 target_include_directories(unit-tests-lib PUBLIC "${CMAKE_BINARY_DIR}/t/unit-tests")
 add_executable(unit-tests "${CMAKE_SOURCE_DIR}/t/unit-tests/unit-test.c")
 target_link_libraries(unit-tests unit-tests-lib common-main)
-- 
2.47.0.72.gef8ce8f3d4.dirty

