Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEEF4C6D
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798226; cv=none; b=ZZDreeMxtTJbQJvCj+oIZzY+SQRhxx+qZksJ05xme8R2fqjBS8HIWGGHMY4aujB8vIvi1wK5761KJv/G+PphBJA3jpJZp89qb5GB2SkdeMb2G0WyyHpLAM6PpFO4s0HCQekgFJgQrfTbVSSohN9x67YPS63Hg6v21VUfbbsQTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798226; c=relaxed/simple;
	bh=e94rZojYkOWMKZw85akjnqpyyWegf5FsNuBfYYCYGTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JqO3A2P5shj8wNYurx7YGzgmPN4fNkcySn+Hugt8jfTQvnDID9SXK0JWpiF9uEtnTI9Kb/ZzP8YmGsLfx1PNcr5iYOaqJcfoJrwJavmGpnl85i9HOo+roGD3xacx82gUMzPNfWk9Lo6T2weGflePPNIUgTKbFImofp/Y3uQcwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T2cs0kYd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDzZvsS3; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T2cs0kYd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDzZvsS3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF8537A03C9
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 10:10:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Jul 2025 10:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1753798222; x=1753884622; bh=VDbuBueMox
	2LJNL46q3aln2B4SpkDMB+8vouYRZMBC8=; b=T2cs0kYdmbFE4MFVsTtioJTt+C
	sIAtfXmwXg0+bwBV2ha/xWpiMKq43Gpl0+DTbLSTze+zY46lQgjjs7ua7aqC6rgv
	cOM6mHtn+pd6DbOO4sRuoc3d0OACYBIsjFwZ+D6cktNL3m+ssCg8F6u67mlmgVCx
	yoq0zkODwGBJR6tOTjjq/F6jQjWAbqJpvVYcj1ohN4+qaZqdmubkehewY99tZLZV
	l2PTtHiPB6NoTo7/MZIbSvq/IkCchl53w1W6aa6BPjsjaOCVe/yysp6tTdtljbwd
	UBGjHNBdGGWjLUuX6QDn8wbVH0S+bF2/H0NnXaUfK5IwljPkanWGzWNJHUlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753798222; x=1753884622; bh=VDbuBueMox2LJNL46q3aln2B4Spk
	DMB+8vouYRZMBC8=; b=hDzZvsS33BYchFXM1I0up7MAfn56u175GAkCjo6UKqW1
	wY/wU4Jg7yThxfwPt8rUF9SPs+DnNJ/aChL5Fg4uzso4OfNvNGIu7sfRAtEJxpKQ
	7vj9SFEms0Ueah4C8mDCTnLSWAT/Hrvkgztj5jlnRz/YEp6V0H0PTmsgGOEpBlw2
	V93LzdonWOWVetdj5ptEDJMkFbsbDo+rs0v0bVqg5a3CAx/VCVwmXDDSVOCpoyYC
	kwQcrAkG+A5rWR9VZf8wOGrJHU8xdFAYdc6zXktPalBUMTTBXtD05Ss019ZFYpzf
	70dVUHuHbyRDk+LHZMDp0wqOpB9DFTtKPKG3iwNlRQ==
X-ME-Sender: <xms:TtaIaOitVC8sCZccEr-VlbJyt6kHg7PUv9_tj8MUBrrVYF3ete-kTg>
    <xme:TtaIaBDnTjl55B9JGAqaHYRSN19Lo_Oo4F41715j6gsGyYSzf8OQF8cNzRRekrU_j
    H5G-8NwUaMI7-sgKQ>
X-ME-Received: <xmr:TtaIaPdCZpUsPocyrba5a_yTQlH0NbEL2puPEW23hxPO0vODgjFFIWMRHBeyekZdTM_09ypBjS_sHXEY18XSh_BkIxPaNLyLQA9gKqTQj_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeigfeitdffffdvvdeuheehjeehheeludduhfehke
    ekgeeggfeuffehveegteejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TtaIaJdijQtuyvVPmEy-P99cG7vy0z5KuBqmdw8gswPufJvietTyJw>
    <xmx:TtaIaDiRpYh2kTxV-aPBjboVvN1O4t2LVkbj7z_mj5ZvF-6Bw7_mtQ>
    <xmx:TtaIaFQulm2InrLyZk8dLrnxo9THa8Gwy6yGgsA7tmuk3FuznWLhkQ>
    <xmx:TtaIaEzRlPzherUffPfpYECbBxOHAuujFsbBuoK_-t-qKoFjWW63Sw>
    <xmx:TtaIaEZbQihV1USMkkhqnOBw-_B1VCnkHqVU7JqnOi3mm1GMb-hC_pHJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 29 Jul 2025 10:10:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5d63df9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 29 Jul 2025 14:10:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 16:10:11 +0200
Subject: [PATCH] meson: ensure correct "clar-decls.h" header is used
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-pks-meson-unit-tests-stale-decls-v1-1-4a7770c84307@pks.im>
X-B4-Tracking: v=1; b=H4sIAELWiGgC/x3NQQqDMBBG4avIrB2IaUTqVcRFEv+2Q22UTFoK4
 t0buvw27x2kyAKlsTko4yMqW6ro2obiw6c7WJZqssb2ZrBXDo73p/ILuiV+JylcoEVZi1/BC+K
 q3JsQ3OAu8LGjWtozbvL9X6b5PH/qneDzdQAAAA==
X-Change-ID: 20250729-b4-pks-meson-unit-tests-stale-decls-50bb4743eac1
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "clar-decls.h" header gets generated by us to extract prototypes of
unit test functions from our clar-based tests. This generated file is
then written into "t/unit-tests/" and included via "unit-test.h". The
intent of all this is that we can keep "-Wmissing-prototype" warnings
enabled. If we had that warning disabled, it would be easy to miss in
case any of the non-static functions had a typo in its name and thus
wasn't picked up by our test case extractor.

Including the file directly has a big downside though: if a source tree
was built both with our Makefile and with Meson, then the Meson build
would include the "clar-decls.h" file from our Makefile. And if those
are out of sync we get compiler errors.

We already fixed a similar issue in 4771501c0a (meson: ensure correct
version-def.h is used, 2025-01-14). Let's do the same and pass the
absolute path to "clar-decls.h" via a preprocessor define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/meson.build            | 3 +++
 t/unit-tests/unit-test.h | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/meson.build b/t/meson.build
index 660d780dcc6..9d476011347 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -50,6 +50,9 @@ clar_sources += custom_target(
 
 clar_unit_tests = executable('unit-tests',
   sources: clar_sources + clar_test_suites,
+  c_args: [
+    '-DGIT_CLAR_DECLS_H="' + clar_decls_h.full_path() + '"',
+  ],
   dependencies: [libgit_commonmain],
 )
 test('unit-tests', clar_unit_tests, kwargs: test_kwargs)
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
index 85e5d6a948a..39a0b72a05d 100644
--- a/t/unit-tests/unit-test.h
+++ b/t/unit-tests/unit-test.h
@@ -1,8 +1,13 @@
 #include "git-compat-util.h"
 #include "clar/clar.h"
-#include "clar-decls.h"
 #include "strbuf.h"
 
+#ifndef GIT_CLAR_DECLS_H
+# include "clar-decls.h"
+#else
+# include GIT_CLAR_DECLS_H
+#endif
+
 #define cl_failf(fmt, ...) do { \
 	char desc[4096]; \
 	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \

---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250729-b4-pks-meson-unit-tests-stale-decls-50bb4743eac1

