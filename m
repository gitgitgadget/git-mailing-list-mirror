Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F21AD9C3
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914812; cv=none; b=inLZYNXr0GASYCxjT+L2gyVD916Awxjr+Uz84dp66lvNEjCpMreeLES4wPlxQnzYgC34UWZrCJlwEoif1FgmGmPPyidzTmpHYIlaqIp9BPDFuN9fZGlXQIIMC/69uc0Eg/RB+p49shoePtlpwJzA7J3X+pegYm44X8SMvQRJYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914812; c=relaxed/simple;
	bh=GsLwj5/w33fv4cikxIvLwctBSP2ExHPAE6i4bKSo6PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQO5EVloISJjSpsHh5eIgpbztrhnL8WTqi2bsaT7+7sx4x+DpGsMBqC3P5OqLya7imFxakCKU4AS66y9IvcCRm0d3EIZEjMCdz8Mul9mqqVwvAo5TKAe2LnQwRzlNXpemeLfCT2tfbu2nk5iiUIVpHM687hqOFwdKNkL99n00UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j1aTaxSJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UltOuLkQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j1aTaxSJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UltOuLkQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B352138023C;
	Mon, 14 Oct 2024 10:06:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 14 Oct 2024 10:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728914810; x=1729001210; bh=nXEBxyoUXU
	2vNAnXcDZ4i2LAL0iOEDM9z+7UIryYypU=; b=j1aTaxSJ9CsGvJO2m2T2TJVah3
	Mge8TNSjK7dPMPPSlc32xZ8MPk4o9+hqSzpdlw8KMA/Ev8mTyETCWLRCD3QVgu7o
	95/z9khEptye6nRt8MFEELJ/ZE8voYRNsYiS+pGa8cbdYZIR3RuXjZoPwbjzEtZg
	R6bz5Z/863tAflydzTEi8bAejZisDwJhES3ZTsgPRsRvuU7UFy/+Y+bzcjtQqSsv
	gSqn+vSrHClCThZr6DUIxwHtvH2wEKxmzEvPNnAg6ucy+Gre3o2C954vx9se4kht
	+5gdnVez+kdKWvgg6jL/jALPufBi91WcsjFxDkpctosKmmzIaicUTcPGHCUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728914810; x=1729001210; bh=nXEBxyoUXU2vNAnXcDZ4i2LAL0iO
	EDM9z+7UIryYypU=; b=UltOuLkQDpspRYhEX9yZLtT77FlWkFC4jfbRcv483AFf
	XqUqLBSGO5FMntSCJth7ZIoDvx9mGqD6WPatkruz0ClrqvTVVfmOcOYamyYGoNLX
	uQly38cX2Z2hzY7Ax2GYj839FdPW3iTX0eINGTAoW7XTUTUDPAQ1l24sWZ+SXLcN
	vCtF+0AqogvjbYIIBMdiP+A409mUgOKR9UcdeFiAP8e16zC9IXu1SQn1DDNUpTO4
	3MeuhpJPswLWHSJJXrc9OYvhVHDlU1l4pa3f4wunCt0VGTQ3P6irK4Twczk1kQOA
	2mJL9Jkqi5O1ru1Gn8v5nl9FWNZ/MKoAiGsZcj6gIg==
X-ME-Sender: <xms:eiUNZ1Q2MNrl71-x9CUcpDOO5GWL97gfHdFjYnrgfPa24Y0QnqH58g>
    <xme:eiUNZ-y1vGybuP7mHO6mekKBs-opg_hxkpXHhmXItc-g_yE1y7FxfD3DLotBuALS5
    UbL9sL597YdtWnzmw>
X-ME-Received: <xmr:eiUNZ63VuyyzQXQkhfSayL3eg_gprLIoFsFieIddv2uOv1Db3Mxl7yotEOAR1Eq24sz8c8LkMhuCwHFAkbUYJ9rD9I0bIeknH1MWKUdfuf24kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eiUNZ9DUUhT6Z-gQwNAPTHlmFY19db8jlCcDyoyU_WMSGbD2asRXkw>
    <xmx:eiUNZ-hAe94-VzUXth-VLLN-LC7gHfUQXd3V2PGUFBBMk9A4FhyetA>
    <xmx:eiUNZxqvkf10_XsTE7IlOB3_ZDms4d4xFWWb-yxOSkPSstI7Oiygpg>
    <xmx:eiUNZ5h77kSc9eAkYxWQUeiiMaLZE35ho8pvAGRdEhlyEhVJR8Fhug>
    <xmx:eiUNZ_sd84UVe8DKNELhGkxvcWBIZI0VUgjmxrOuScTrhSPo2p-MUJF2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 10:06:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61697154 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 14:05:36 +0000 (UTC)
Date: Mon, 14 Oct 2024 16:06:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] cmake: set up proper dependencies for generated clar
 headers
Message-ID: <129d28ae48ad984e9fae8bf803ae50a390b15a46.1728914219.git.ps@pks.im>
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

