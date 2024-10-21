Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725821EB9EF
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508213; cv=none; b=seI0UikoNUl9OjhtFZFtOpGa8tWv/yxIo1LTBBKAoNOK4NQRUddOV8Go6O3BxTqIms9jfVvT6uq08lY7Kv9RyEDUwAZw/4t5k9UAuIdW9j3vcwclyl8cSqadt9dr4YOGVTvqczIKEEePgbcVb5ChSseEtO8lmu6D/5xNxp7nn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508213; c=relaxed/simple;
	bh=GsLwj5/w33fv4cikxIvLwctBSP2ExHPAE6i4bKSo6PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smDJ1VjMtSzMWdXD6B7pTSFWxYw/v5JwUBg2Yj8eJOtJvZLoP+atP+8UZ0K1mN28KpEKQ190LRfjZLzyuxPj2yy9/ULnZzBVDDD0NRzODyrsLWFvWNm6p7Ys2uqsRanKDBVVayGhAJflBKV50xXavQGgfVmT9mDPj9avcy8kM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TmFIuycp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iW+LHjl8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TmFIuycp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iW+LHjl8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B2993138004F;
	Mon, 21 Oct 2024 06:56:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 06:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729508210; x=1729594610; bh=nXEBxyoUXU
	2vNAnXcDZ4i2LAL0iOEDM9z+7UIryYypU=; b=TmFIuycpzo7zGk1WQXUhhTLYTH
	QldtbbUanv2koRS4MfQVpCiTa9aKvnp/VeqE3Fj6FaH5zelTy7G5O+FgzYk6Jyxt
	nLQXJ1NC6rU1FG2govJvZnfhXEyZ1jR3zC0b0qZFqkYbVuI88OnFpYFo662+GuL2
	qUCSYRmfSwQs+oB0siJUJjjfntZdGRLSOpCeuKeAU9xJUsUWadcLzd95Iursol6N
	rRWemLfY0pp7qd41F41uR7PM4pp+pfcbizkC7OnFHxZ/cqUDFBONyCqfuA/On9TL
	8cKsnrR5vhEYFR67/T5JXCGzebnPMHBGttQztCXQyPmEJGvJaqbf9WIZo8vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729508210; x=1729594610; bh=nXEBxyoUXU2vNAnXcDZ4i2LAL0iO
	EDM9z+7UIryYypU=; b=iW+LHjl8QDrSb8r9gz0tKQ+M+4UaLfslcZn6IzkxdG5T
	d1zeHMWZYydsoUjRCEcc7A9zPctAOjS366/ypvACI7buGLRI8eZcHKuqDmVunmJI
	BDTt/GLhOUIHXmm35JEqPlVM1D8jMXRba6E8KgTTJEJBi4Z2GPKAiNwrUGCvqcCM
	FSe8HJ9zbRfK3FWUfsi2T7sQtjbsxHicrLRnFymvxaKFwsL7cJrgWyBur8tZZnQT
	vTEse/8TpMwW7L1RFogE+B4It04h+6T9VgRqHuRIdJRen8nBa/XbZZRtjc4zly2V
	3mpdQRrMwQ7gqlrQNAj2HlOb9kFVdrRfv+h29z/SNQ==
X-ME-Sender: <xms:cjMWZ9cX7Y_xPr9TXtfNpVjpthQDKbRzqniym8wh4mzzRIObZrYphw>
    <xme:cjMWZ7NsiP87H0jxa1q78ID6Mk4qgGSQsIL5IhdXZoYnwWCMNhWzjkanfXVuzXY5E
    lydfUENjzRKFpLf5A>
X-ME-Received: <xmr:cjMWZ2hyI8XTIlxwhD3jLo2JToxiqkqTjEelLxqtrpbi-1eiO1YnxIzepjNlXADOWvQrJ59TX5ZitxM1yUlmiZXX0AYEHTtvDAAH03aFOuop>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggrgh
    grshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopegrshgvuggvnhhosehmihhtrdgvughupdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhi
    nhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:cjMWZ2-SpLXKcAGlDJ8SBuNyH-8ZvPd57BRnCeBLlMiY7PnMl4DbWA>
    <xmx:cjMWZ5vXOa9DUbfjgHj_N7axuhHvX2_C96VCbGuB3b0NRlHV8fQsqw>
    <xmx:cjMWZ1GrIEHUpxW3FxJOA0vr2yXh55PBNlBu64FqLgZaAESZXmm9UA>
    <xmx:cjMWZwNJHbRyXVjKubNWrhLasWd0acFL9WzfK9ZHk43-loT23ObQvQ>
    <xmx:cjMWZ6mGAVTfYNtQsGVizW3nKJbdboDwgEi6VGvmuSUmP3Dw64ZikFqT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 06:56:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b94673c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 10:55:21 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:56:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 5/5] cmake: set up proper dependencies for generated clar
 headers
Message-ID: <bb005979e7eb335b0178094251b5c37682d7d47b.1729506329.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729506329.git.ps@pks.im>

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

