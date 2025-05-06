Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614B27874F
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529203; cv=none; b=o9IvAlKIsincm9h4RV1OtbCYxMVsG7cBKRySI80+r1I2IQbLqEpZGwyMoBCB03qLypwHDp51Ui1jkkQwbzGVRZXC9bWy/PrB0Bw3zL4A0X/gwZ4XlfWaN16MRn/BWQQedKgTMhedljgl6xNl5UvgKkd10OpiK4nBzsLPRVd8hEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529203; c=relaxed/simple;
	bh=p3MBZeaKxS08uXLHoBya8KjedgVVXKvKdsnWmF/++aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aj7qc4S6NMfBiJiu9ZXXx8bxEb9OrDuUWdUdQSY/BaE52q7L8TrlK8GF2qM6c1bwdeVGVcFKwKgiO90LnEj09ehp6VHRBL9Vn1aOQcmPBNI7sOqKGGP0lQuTCONirlNR8khl/SNOXIcAIelJeG7PYjIqewTk/XNCSEQUHOrbEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BV/ZkCz6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k4a9Cxb1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BV/ZkCz6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k4a9Cxb1"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 471711381006
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:00:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 06 May 2025 07:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529200;
	 x=1746615600; bh=sniyl8ENacKVkZe/53lDfLs7rgeR80EZ00PNXYejCMA=; b=
	BV/ZkCz6/5M83kRdx2OhQ7QfmwSBXD/ZHqjwdGPMXpJTeyJ4MSRgnDkKsgewXMTb
	KL0g9XcHwFYW1NXs7YgGpjoO0nDlz/oa5mnaJy78whl5FHPAgCMMOypQvJDK5idO
	WrI1S6W0eqtvZ4g3Ir4JXvNw5e3qn6flFCcMVfRQ0CNchOfVzcIqb67279ggA5sm
	cqVDKZkopfo9CNIxmUgLtocuVFh+uOVhltsDFU5qUuqKcPCGOu8+JNoeaaPtKXoE
	l2dFqcJsP4gQbonbhD4XGZj0e8+pNl7lfSilCvB7jkE7SG4XUpBZUK/2+ys1jIVo
	FGAZXlvfCqkZqvaVIxXxYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529200; x=
	1746615600; bh=sniyl8ENacKVkZe/53lDfLs7rgeR80EZ00PNXYejCMA=; b=k
	4a9Cxb1aOslZxX/U+eWXsnpIfZyP4ZvXYCXwPzcShrKEiRMAlQ4k9SNDUVdNl2mo
	k6ViRJ2ZUUHS8/W88f+plsKNx+vHfg5G14Fx3tu+VcxrX9K8Y3sxsKPhKZUqRXFY
	c+Cys/7mRcQxly1giFsOZDJv5U8jnx0ImC7Oz+nCkCTwd4lFEHjc2yd3+t8LqgpZ
	eBxDDzf+5CvBCo6hf1nsuOsVex0HSfoRVqh9Ay0ClR8YP0lzb7w/F+3dgcZvquKk
	1QyjN+0NSuTIyZ8MO7CTZJVEXr018IxOXwgjMwIeDdxzHzpagTT0e1S44K9xxiyQ
	4IuAdcWMUaWw05deEY3aA==
X-ME-Sender: <xms:sOsZaOTg8jS2XtItFHO-_9vIgSdXslzggrk2rG5d8vt_prOCRO96fQ>
    <xme:sOsZaDy1nBOnuNI18MoVqnXXPDfNTcCXAalwxPuaSXNU_Ohii1X_imufNU444Hjrz
    OPOks4gK9RymypS7Q>
X-ME-Received: <xmr:sOsZaL1qPTfF8MCO7i0nRyxfEPsyotzeA8-BFn0NPN2K6kdpR9bGZZi_ipCzi8k7EWVAZdXve9pp-G8t2bcpTGjyJJRR_UVU2sLTesUm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sOsZaKCsK0Sc1pw3eDfvSrT-6EZ6fwgDIVTL6HPzo-sEB-gPlMn89A>
    <xmx:sOsZaHgEdGPXyVwlfPT1L06mZ5E63ROv8PZNUQcnJvrwLthmRtHeWQ>
    <xmx:sOsZaGpT8EM9Gg1Hse-WrGDyjy79xQH6bVYaLcKEzCJDiNyEaTroJg>
    <xmx:sOsZaKhRmhyr9rUh3rk011i0ofMQcyCJxoVuy3XSHJPiftXfZaE0rA>
    <xmx:sOsZaGM1Bfzd8Wyq9KFCwv_6Eh3YbdJ_Hi5UxWhpNcaz4LVDITs_Gk2B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 06:59:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3894ce47 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 10:59:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 12:59:52 +0200
Subject: [PATCH 3/4] meson: introduce kwargs variable for tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-meson-tap-v1-3-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Meson has the ability to create a kwargs dictionary that can then be
passed to any function call with the `kwargs:` positional argument. This
allows one to deduplicate common parameters that one wishes to pass to
several different function invocations.

Our tests already have one common parameter that we use everywhere,
"timeout", and we're about to add a second common parameter in the next
commit. Let's prepare for this by introducing `test_kwargs` so that we
can deduplicate these common arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/netrc/meson.build | 2 +-
 contrib/subtree/meson.build          | 2 +-
 meson.build                          | 4 ++++
 t/meson.build                        | 6 +++---
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
index 3d74547c8ae..16fa69e317e 100644
--- a/contrib/credential/netrc/meson.build
+++ b/contrib/credential/netrc/meson.build
@@ -17,6 +17,6 @@ if get_option('tests')
     workdir: meson.current_source_dir(),
     env: credential_netrc_testenv,
     depends: test_dependencies + bin_wrappers + [credential_netrc],
-    timeout: 0,
+    kwargs: test_kwargs,
   )
 endif
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 63714166a61..98dd8e0c8ea 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -21,7 +21,7 @@ if get_option('tests')
     env: subtree_test_environment,
     workdir: meson.current_source_dir() / 't',
     depends: test_dependencies + bin_wrappers + [ git_subtree ],
-    timeout: 0,
+    kwargs: test_kwargs,
   )
 endif
 
diff --git a/meson.build b/meson.build
index 270ce933d0f..94bd525dd7b 100644
--- a/meson.build
+++ b/meson.build
@@ -2027,6 +2027,10 @@ subdir('templates')
 # can properly set up test dependencies. The bin-wrappers themselves are set up
 # at configuration time, so these are fine.
 if get_option('tests')
+  test_kwargs = {
+    'timeout': 0,
+  }
+
   subdir('t')
 endif
 
diff --git a/t/meson.build b/t/meson.build
index b09c0becb8d..1af7111b0f8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -51,7 +51,7 @@ clar_unit_tests = executable('unit-tests',
   sources: clar_sources + clar_test_suites,
   dependencies: [libgit_commonmain],
 )
-test('unit-tests', clar_unit_tests)
+test('unit-tests', clar_unit_tests, kwargs: test_kwargs)
 
 unit_test_programs = [
   'unit-tests/t-reftable-basics.c',
@@ -76,7 +76,7 @@ foreach unit_test_program : unit_test_programs
   )
   test(unit_test_name, unit_test,
     workdir: meson.current_source_dir(),
-    timeout: 0,
+    kwargs: test_kwargs,
   )
 endforeach
 
@@ -1210,7 +1210,7 @@ foreach integration_test : integration_tests
     workdir: meson.current_source_dir(),
     env: test_environment,
     depends: test_dependencies + bin_wrappers,
-    timeout: 0,
+    kwargs: test_kwargs,
   )
 endforeach
 

-- 
2.49.0.1045.g170613ef41.dirty

