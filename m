Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E481EC4EA
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914397; cv=none; b=UewkwvHKbdWTNGbfxSo0loxLmNcPBT1JTcxiYgrH4/omudgKcqOgtA8G+cHgzGoxLWCRPEOCIGzfEAWSRdNbjwbtTLtx9ypGs82PK+V628CQb+RfpWnvNj9OK9rO/hFL/BC5EdUyy7yfFshyE6Z+GvziS3TPnj6C1vIWjW4Xoqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914397; c=relaxed/simple;
	bh=Yzc/njr5uaynkXCRS15MyOWRIZDy3dSgEkDFN96+pvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XA37f+23uQEnfqwSDq8SLXjZglewgOz1Vvzd+G9EDlH+pkmfjs0Xaew7cNPsyrVxMRrJAifjKX2Xb7MbulZxC4vhw1wMxWznQj08kBk6iuA5QkGBSMEDby+Of7d9NWhPfnYt1wKBGg6F3EpEGHTaKec3LQ9soy6cz9t0UTIWy5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sEMOTHOs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LJayfNCi; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sEMOTHOs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJayfNCi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3837D1140245
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Dec 2024 05:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914394;
	 x=1734000794; bh=r0eOzndW3Xj8C4cTgfC0ANlIv+wG78T0FZwPHIwY+dg=; b=
	sEMOTHOsyyW0Wtb5nDIqKTeEy6Jnh5mrZAnPP37DC59qeii8OSpxtyqW4uOAjE+o
	EAmgTMCDVmU0Xy3Z7cpxBRqXY6fEgAaZ7HwyjQ4ftD7sJqGwEfNw5ympel/alvmp
	8gPONxzm7fBW+tKBy7JVn8bYNeMENbqjrn8hOCjUilLruL8t3xCrcIJqOat98Y+i
	OLH2sukSOWgT1T64YIP+R+M98zUtQ09uVLkcPLFPB6q+yLmc0iBzWKiEN7/t2GRh
	qnZkdzir9hGIbmxF0DGG787KrWKtQuzOb94Mta0i8GdHm33D7N45vp5GMCbS+z1X
	fQofCe/va98DtM6DtKEqIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914394; x=
	1734000794; bh=r0eOzndW3Xj8C4cTgfC0ANlIv+wG78T0FZwPHIwY+dg=; b=L
	JayfNCiJ1kLrmAdFnaByKosovl9FSH0h3n0Ji0AumIMzaZ6fxxQr6/7A/+XI3WW0
	xM/L1FtX4nkiKLoXyiZbu0uonQ7moCvncTUakMXpkEzro02kFhok3746LGmLVR0R
	vWndxJtQMs/WessaMwM16LBH6tNnv3tCPSdnmD6fxl3PYrYLy9uTstyWJeJTmy/g
	HcbB3Etda+5vpMMNUicza247GbBiy5J+Oa1WuuYaVe+ru1Ng1uuqSVhojAFHYhPW
	ZY3iJetxse/hgtbRlamfz1W8Zg5R+Dk9hoziPE0MCYnKrsADtNKTGvEsc0T7ZN2Z
	bwb10V/teiVBGyVg17TLg==
X-ME-Sender: <xms:GW9ZZzrxhA4hmhI9RZrRJGRANppk7JUbIOhpdwgmlqF2ejmhsiAU1Q>
    <xme:GW9ZZ9rtwpRJwe0k2fgbFbtfjG3c-zMx3FfZ3pf1QIgZTpC0lefvJ6vIYHzuTlyDx
    hUUq5_7_g1Cyi10SA>
X-ME-Received: <xmr:GW9ZZwN6CcGkoXl8I7u7sUnsDwnoMw1wC4XsUyO1iWRr3aKqyh0k_x-k66BAM4FxvIV49kxFFxAUdYA5x4JgSNYsKz2-WimoByyB8AjtIQerXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GW9ZZ24RTw4y1bs5rFhZ47nHyJvFmeCjoLdFSjTP7qiKE2do8XRFHg>
    <xmx:GW9ZZy4E_9KBHvS9K5Wy9AfXJXnRpdloxV1LUOs-ygDL-1RbQbeaKQ>
    <xmx:GW9ZZ-i3pDMG0lYchAYRT-7vyptxxV7aD3lc-LFyjDZPtta-yfhZeA>
    <xmx:GW9ZZ05P2iYcrNDFeiHbMjI8UQsrAeYW0znJajwrInjR6eK_oZKDSg>
    <xmx:Gm9ZZ4ScQeYRLaONkkQMn-fqg7-cUqDdlDh6bi3NKFUzy_EN97k-yvH3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42fae122 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:52:36 +0100
Subject: [PATCH 5/8] Makefile: detect missing Meson tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-meson-ci-v1-5-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In the preceding commit, we have introduced consistency checks to Meson
to detect any discrepancies with missing or extraneous tests in its
build instructions. These checks only get executed in Meson though, so
any users of our Makefiles wouldn't be alerted of the fact that they
have to modify the Meson build instructions in case they add or remove
any tests.

Add a comparable test target to our Makefile to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/Makefile | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 131ffd778fe00864fae1f5750269615556c6cdea..290fb03ff011d39c31c5073c796aa6f4dc966283 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -59,7 +59,7 @@ CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT
 
 all:: $(DEFAULT_TEST_TARGET)
 
-test: pre-clean check-chainlint $(TEST_LINT)
+test: pre-clean check-chainlint check-meson $(TEST_LINT)
 	$(CHAINLINTSUPPRESS) $(MAKE) aggregate-results-and-cleanup
 
 failed:
@@ -114,6 +114,22 @@ check-chainlint:
 	{ $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual || true; } && \
 	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
 
+check-meson:
+	@# awk acts up when trying to match single quotes, so we use \047 instead.
+	@printf "%s\n" \
+		"integration_tests t[0-9][0-9][0-9][0-9]-*.sh" \
+		"unit_test_programs unit-tests/t-*.c" \
+		"clar_test_suites unit-tests/u-*.c" | \
+	while read -r variable pattern; do \
+		meson_tests=$$(awk "/^$$variable = \[\$$/ {flag=1 ; next } /^]$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047,\$$/, \"\"); print }" meson.build) && \
+		actual_tests=$$(ls $$pattern) && \
+		if test "$$meson_tests" != "$$actual_tests"; then \
+			echo "Meson tests differ from actual tests:"; \
+			diff -u <(echo "$$meson_tests") <(echo "$$actual_tests"); \
+			exit 1; \
+		fi; \
+	done
+
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
 	test-lint-filenames
 ifneq ($(GIT_TEST_CHAIN_LINT),0)

-- 
2.47.1.447.ga7e8429e30.dirty

