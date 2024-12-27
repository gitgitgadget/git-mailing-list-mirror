Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B81F5429
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308014; cv=none; b=T7MMWecdWg1jsPQijrAx6/AU5jIv6HehQiohEHuIfy1WE2MsasP6JTjcnlhCWIkUG27vlRlij5Wuuv02yQcBXQ7PY8ov8UooNwMBkhT5m0QBjGfbHRddWNVTMUBojwyvv9vTgPTfi+EMeudue5YCtNdwq5y/bmqq5i/afUGX4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308014; c=relaxed/simple;
	bh=kcWJoB+mH+NTIBwTFkgj//ZNL6SKm26TCU+ANqcAYIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9r2UQ9Iyyyeo6htBW60MakWKQJjU27z171+acGL/6EfMQcpKTr2JxTT1zRnCMOIRFvHAQEhSjuHwbiCRdJvh8ZX8O3J7RUrcsONDnrwQNd5+hkjBfmE/nzBwFafzfPtBsC/am1fuElgWvYMlJXolaW1qO9P9E1zWljy9ztK0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CDogzYpl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nplv+FD0; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CDogzYpl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nplv+FD0"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73FE62540188;
	Fri, 27 Dec 2024 09:00:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 09:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308012;
	 x=1735394412; bh=DdKe+LntkSfX+gAdlfK1Q5JLQEPe0Ku5zdRD3fh3RLA=; b=
	CDogzYpl05YptRP1dz7+4Rl6uWDf4/IaSjxdIJvEz2+7gf3lV1el6KFaF67kOray
	XLQTBuie2AnaZgHAqxJqkaQ4OUj737zrtv/SGGOcDn2hMV9CDl+wlkDKQkW+iBuR
	QYvVBtkT2TnuczphNvSlgCPqRT+pvpQDbjSe9yiGagDX50lYnwBV+mRWKopoAtgH
	BT86IUdvuSu0K7C6lGtedUt8maYJ4cwiCAnuAAetFb4/4hv4srYoLR6fOZee1MWy
	NB+iPoHCQ/STny+R6Qg9HbhYxyiUKzpTnTTiZyvr8lHxh8VlVluKGId7lBIUsf42
	kJmH418p1Uq+era6KQIfaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308012; x=
	1735394412; bh=DdKe+LntkSfX+gAdlfK1Q5JLQEPe0Ku5zdRD3fh3RLA=; b=N
	plv+FD0SrDN1x2MkC4987DJfyvBtitxNHk8ssSS3+ZexqfpWZQXJ20FYPQIHXMRy
	e100hsUGXg1YGke1UnHnp1PhrxVsktU/BRkMl/epJO683YxC4oS4Y3nh6OFnvqMX
	z2jWY3B9UYBF/ZOf0RgyCIjL+/3bYvguzwD3XZnDHtcjoaUYKLB07oFDEfeZnUhv
	SeqS+bjpi0VB7SSDC927AJ7bxUOVr/Fl4xIhz98TdZ4pycdmpm0zMfhzNswNY1EE
	pQqDjT2xTUmmTh/EhwGcvjByxLN+/nRhUO7qiGuHZ8u99L8n4Lgqj1zQlgcc8Pdw
	ugVlYOW6gzBLwsQgq4ybQ==
X-ME-Sender: <xms:7LJuZ9A3vV1SNv0R30vY_yYinIzjKXb0UZ2LS3im9tD0mhv2WF-G6w>
    <xme:7LJuZ7i_awXdXLGaZq2bZXpGrY6AKPndrGODJcPxpVSbmkJ69-p8xjAJ8FatoizEI
    Ban1zjam0FOHrA5EA>
X-ME-Received: <xmr:7LJuZ4lJIGL5Up9rPMFNmf_ORFYCEiEOFlX7z08dBVa02PZMoRCEjwq38hgAswpT4kNv-VC_mO6Y_SeBCPADXrRxHjXmPhp2jP_HDSMrRyE6iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7LJuZ3zR_6aJVb3dOZLhfPSnxObB9rTnr6wFwzqDN76qz546WpkplQ>
    <xmx:7LJuZyRetdPuO7qw-InZ5Xh7TS4gUqhKNb4_HWCA0bXha8WU3rSHBg>
    <xmx:7LJuZ6YJ5JjiVITWE-DNjIS-7n2fWe6Kf_Ad5NBfr9g9U4LY82_PSg>
    <xmx:7LJuZzTRaEXjhHijr5RyzCnyWZYFBuNv7w4C14txW_dIeTrTTcHxCA>
    <xmx:7LJuZ9eL2KNwaWXDGo3eVg3qprcLjBv9oEu363pDf8w_OKfnjBIyJjBX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc8555c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:58:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:39 +0100
Subject: [PATCH v2 11/12] t/Makefile: make "check-meson" work with Dash
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The "check-meson" target uses process substitution to check whether
extracted contents from "meson.build" match expected contents. Process
substitution is unportable though and thus the target will fail when
using for example Dash.

Fix this by writing data into a temporary directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/.gitignore |  1 +
 t/Makefile   | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index 91cf5772fe5643dbe075da98ed5166e1899b9a54..3e6b0f2cc57ffed0394d1cd2efc1e374f1c2169b 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -2,4 +2,5 @@
 /test-results
 /.prove
 /chainlinttmp
+/mesontmp
 /out/
diff --git a/t/Makefile b/t/Makefile
index 290fb03ff011d39c31c5073c796aa6f4dc966283..daa5fcae86f3480079b8c9743dd28e3fd304c27b 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -103,6 +103,7 @@ clean-except-prove-cache: clean-chainlint
 
 clean: clean-except-prove-cache
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r mesontmp
 	$(RM) .prove
 
 clean-chainlint:
@@ -116,16 +117,17 @@ check-chainlint:
 
 check-meson:
 	@# awk acts up when trying to match single quotes, so we use \047 instead.
-	@printf "%s\n" \
+	@mkdir -p mesontmp && \
+	printf "%s\n" \
 		"integration_tests t[0-9][0-9][0-9][0-9]-*.sh" \
 		"unit_test_programs unit-tests/t-*.c" \
 		"clar_test_suites unit-tests/u-*.c" | \
 	while read -r variable pattern; do \
-		meson_tests=$$(awk "/^$$variable = \[\$$/ {flag=1 ; next } /^]$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047,\$$/, \"\"); print }" meson.build) && \
-		actual_tests=$$(ls $$pattern) && \
-		if test "$$meson_tests" != "$$actual_tests"; then \
+		awk "/^$$variable = \[\$$/ {flag=1 ; next } /^]$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047,\$$/, \"\"); print }" meson.build >mesontmp/meson.txt && \
+		ls $$pattern >mesontmp/actual.txt && \
+		if ! cmp mesontmp/meson.txt mesontmp/actual.txt; then \
 			echo "Meson tests differ from actual tests:"; \
-			diff -u <(echo "$$meson_tests") <(echo "$$actual_tests"); \
+			diff -u mesontmp/meson.txt mesontmp/actual.txt; \
 			exit 1; \
 		fi; \
 	done

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

