Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DA1C3C0D
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086504; cv=none; b=RtseRreY7l2yMZPiXMcoHuRhba0qiAk6HvjnYzwQVPgLbsaCHhnc6mxYYgJnPmVv7mICLqAs67Z06DcmaxJSMJDoM3hk4llOX2ISqe1Bf+rSHQsqeWka8/NO1CnoYshYmQIUHXmJHJ67YdMbYz8Jt3Z4xQORJs6kRmrB9JCxtK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086504; c=relaxed/simple;
	bh=atjj90Rhux641+xOnSs3M8yiqvXM7oc/9Fec4RUIS/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q14jp/fYoJKgLWsMcEWjzJbAHiOS53gpVAjhsHIZ6VUz2nIPeZsHHj1fyr4i0nXG9NI4iAmV69PNvEHEj2Va+/6+SlkYs6ZBPUbRvXulG27j/3PTxUMydL5JGT6b16Sh9ym7QWWze41JRS1qeMCncjRIXnKieLpeF2xpR1x8jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SKi0JgEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vuk8buuH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SKi0JgEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vuk8buuH"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0F6F2540131;
	Fri, 13 Dec 2024 05:41:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 05:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086500;
	 x=1734172900; bh=aCAdCno6eatn93mkrN3OeSCeuMcXNxumFw8afk7n6tU=; b=
	SKi0JgEtglAM9drI6xplCbaey0vA74ncbCQDeo/c6R5PR999Gm0ZVXyXm/YPK6b3
	8tb1xaVl+hRk64orw4g5hA4oszIqJ+tBTucnLx0S48NeWA5f5bP2V2wKLHgRyTE5
	eY8XwyDk3Osq3B+NaFWwXc4gb3ucJ2ouRFd4bEAB3s6OrJW2gkW6BR+5FwiE8x2N
	Ubqlk2ibIp/TAHXcAtvcheOfthZRaJzNMxptc+4QK1kA06c2VsiT6H6jDgRHkF16
	0uUnnA1FQ/xo18cU8nLvSWoKZxv7d5LKLZxxQKsVYzsa+0xVSYEYT1kIgstZ4Zu4
	ezRP4hmW5SZK36TJCBwJXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086500; x=
	1734172900; bh=aCAdCno6eatn93mkrN3OeSCeuMcXNxumFw8afk7n6tU=; b=V
	uk8buuHwLu6I1cPF2ypZaP/yIHrVxnsRYjoxZa+k2i5wm2tWRaFO/iCfd0kSI4F8
	DShN74SuU8aaYn9UyQjuJtsRDn9y/XA7IBGbQz6vkItq9YUPtX/r8AkLPVD6CKHf
	7wKqtrcyb5JMfLwUFisYqHof2RaOW+h1EeBSc6RfrSgcX7t73ejdWuQJMslmiJ+8
	OkobXe+Z6Mkl/juttpP7ch2xtcs4FFSPaqrG3kiaWQbCOnaieuR9Mz5Kmwp82SFp
	w2CPtoyxbRwUWhV3wTWnoPFfHYPj7QZwr8cfDDcUnfyLzA4mu7SKc8i5XHT7Y8gP
	BsKV5V2jsF6PHuJHscdJg==
X-ME-Sender: <xms:ZA9cZ5B3kKWr1Z4U5HpLJ8ilw9J9F0ktjlDBWVVSZ3zjbjGPurpF9w>
    <xme:ZA9cZ3hkpKryaPWxRQdyPTEsbTd3GXC53YROQ51t7FT6lutZsJqTgFShU0NCHQunx
    wQqudZJYk4ke1oMGg>
X-ME-Received: <xmr:ZA9cZ0nvQgAsnBIvoN4AFbxgNQJynbNsfGXHptQz2mfvzz0lbHpal2LBSTICPvYybYhrAkrLOZbZ6Rf52nR6YGLXLP1wG4yXSby3Agn9z0I-_iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    thhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:ZA9cZzzkqmlbHiaz2Ot8nVa95MCmpXmSqr61R2-Z_eTtIrK6xZJYSg>
    <xmx:ZA9cZ-TZZDL1Xf3XpsXdS0BBv4QBzWTMr83ruNH0RChWlG2MhI__Hg>
    <xmx:ZA9cZ2Y6yifC6kO_iqMzxxZUtW9Qr9fAhuj_h_A7TGA_Li3N4BDnbg>
    <xmx:ZA9cZ_QSOF4Ik7KOShsfJJZSGw1lQEFc9PZD6uMP2Iyd279vAjW5lA>
    <xmx:ZA9cZ8dGvWuKuIUYVYHpuOC4B8vKMYiVxtpqA6K7Pn4sovs8RiBQecjY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id abf30361 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 11:41:20 +0100
Subject: [PATCH v2 5/8] Makefile: detect missing Meson tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pks-meson-ci-v2-5-634affccc694@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
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
2.47.1.668.gf74b3f243a.dirty

