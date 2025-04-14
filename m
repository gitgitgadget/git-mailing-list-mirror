Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130331C6FFA
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613483; cv=none; b=QVZEPtUpQ4KxsblgUAaGintt2xM+guIoEKN/JrsZQbyqjg/kUxFIeq0mzIHis8u7B9HCmlkgqib+nYDsTpJavK1gUJbgC8YwSQwPeNOE42NGUQ0FH/o8Oo0Mic/C3aIjjYIc9BajBYck/+G2lSxTdvfwqUFgCbb/TWwbnUAJ1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613483; c=relaxed/simple;
	bh=x6OSd+3/KRXw7vltgagM3on1EfNRoFD1HAURuPyBGXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Ch3uOMl07tesuMFioU5p4V85A+Wb+hXP5hOWGWkqvxUHY30SeNFN/UlD/ViiqRNoTGzxhj1jJ6IaPByZjaPj6JYGWDi4uFrh+HpXHkUlaDiuHqZzxz25jMFEq2uQs5ZsAbAenmVKjijbwkRbzkVuNKdyyGZCVuJChkUXORkrQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UY4aQZlF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUx58od+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UY4aQZlF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUx58od+"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E986F254007F
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 14 Apr 2025 02:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744613479;
	 x=1744699879; bh=g+ZPP7Cx8Q+V1v76tNHwGI7Q2WNIxi292/8h7JkEMsU=; b=
	UY4aQZlFnwabjoEDOwS/BZFzeHYaFwJvMrS5g+XdwQvoh8aMaOpKZewvNvKe7owC
	MTBWWi+a6F00gEPIToYQlS9idUr3bBNX/5eRLhSlRs3YY/kBFO5l3TWmj47Tjq43
	cl7av1JV9fXf0OMgenjV0c2qo5M17gdF9JizkuD1OXTg5OU7Z4B18lnDmMRm6LXw
	OEv+fvGW5iOvND4TCGu28sSZrQOz6OZrRGzPRMwk846UHWSmPcp29rTLixPAlOZt
	6I3asQ2gnttvzfFsongujt9R2DiCbMl4tLRbxR7q1V+oEyHR9YXky0BccTK8jkAJ
	QJtc4f8eFO/1copTTNuf0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744613479; x=1744699879; bh=g
	+ZPP7Cx8Q+V1v76tNHwGI7Q2WNIxi292/8h7JkEMsU=; b=CUx58od+kcWZgSd5d
	mwpUNHZUUw7kOTD/8mIObensO4Gjlgcvgpmi/8qWzObAjrXl1ToNtq3c6bIImGuF
	42oekJv41phrBVb6mkCzAVyiz01fdeuFdfglGNerg/mtpYF6PBoFCPO8xHsoJYD+
	hv9l0JTYMBTh7Zc5j99Y9RWsXxSoBl92OUPTaSa0xklmjoqyqvrPzMRv5x7bp+Ya
	JvqYAHXDzzEgR74BvIR8LE2oAH39FJhB8ncFgfzI9S6GNvWL6XoTFIdDMSxaBpFf
	BNPSIuzgE+icUVodDFOdmFksUeZvTSWyfmaG0xFUzGhTkJm9pRCcqpYHQKTiKq5C
	ZXsSA==
X-ME-Sender: <xms:Z7D8Z9DrHhaVfXcVlG-GDoSewFOOuZtFJkhfFFun4_bw46HlDgY02w>
    <xme:Z7D8Z7hjvT4ucuJ897F-BOioR6o3VBg6sOA3zKdKJAIC-a4N4aYKGALH07Ira737I
    qIUBS3fcg5q-86lsg>
X-ME-Received: <xmr:Z7D8Z4kdO1OEk_FYyIWzzbZNRD32iHkCH2P5yRGjdBl8tQzCmIBia2jtWisW5-tLpQ9dUGSq9o8CKK2aEJdaJNPqUuhdqeAFrtovMFAao-cu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvffosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelueduue
    eljeelhfejueeffefgtedtvedtfeeffeevleelueetffegteduffegleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Z7D8Z3wV5NnVrCJK_5zqUqjOBeVz9P-FVxg04MURnJiW3Ud1OIx6RA>
    <xmx:Z7D8ZyRS_kMo7_jOZIaPYmdyvS7INpYSgovkceTQmVaZmjeb25xqbw>
    <xmx:Z7D8Z6btK-PGn67Ym1fLlVATKTfzCBMDXvsZ_AAjtJrhHd2pWRP4Ow>
    <xmx:Z7D8ZzTl3KyiA84Fy2tRm68QJXG5AL8S_vpKhIUwe20NVDCje5O1kw>
    <xmx:Z7D8Zz-NWXT237soXyIUArI7ueJa04uIFZZW-gycuTLKMCukZUOVvhRk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7af04519 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Apr 2025 06:51:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 14 Apr 2025 08:51:15 +0200
Subject: [PATCH v2 5/5] meson: wire up benchmarking options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-pks-meson-benchmarks-v2-5-04377080a167@pks.im>
References: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
In-Reply-To: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
To: git@vger.kernel.org
X-Mailer: b4 0.14.2

Wire up a couple of benchmarking options that we end up writing into our
"GIT-BUILD-OPTIONS" file. These options allow users to control how
exactly benchmarks are executed.

Note that neither `GIT_PERF_MAKE_COMMAND` nor `GIT_PERF_MAKE_OPTS` are
exposed as a build option. Those options are used by "t/perf/run", which
is not used by Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build       | 6 +++---
 meson_options.txt | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 9af4a10188d..ba128ab0759 100644
--- a/meson.build
+++ b/meson.build
@@ -660,11 +660,11 @@ builtin_sources += custom_target(
 # build options to our tests.
 build_options_config = configuration_data()
 build_options_config.set('GIT_INTEROP_MAKE_OPTS', '')
-build_options_config.set('GIT_PERF_LARGE_REPO', '')
+build_options_config.set_quoted('GIT_PERF_LARGE_REPO', get_option('benchmark_large_repo'))
 build_options_config.set('GIT_PERF_MAKE_COMMAND', '')
 build_options_config.set('GIT_PERF_MAKE_OPTS', '')
-build_options_config.set('GIT_PERF_REPEAT_COUNT', '')
-build_options_config.set('GIT_PERF_REPO', '')
+build_options_config.set_quoted('GIT_PERF_REPEAT_COUNT', get_option('benchmark_repeat_count').to_string())
+build_options_config.set_quoted('GIT_PERF_REPO', get_option('benchmark_repo'))
 build_options_config.set('GIT_TEST_CMP_USE_COPIED_CONTEXT', '')
 build_options_config.set('GIT_TEST_INDEX_VERSION', '')
 build_options_config.set('GIT_TEST_OPTS', '')
diff --git a/meson_options.txt b/meson_options.txt
index 78d172a7401..ca106c43b2e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -101,6 +101,12 @@ option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto
   description: 'Which backend to use to generate documentation.')
 
 # Testing.
+option('benchmark_repo', type: 'string', value: '',
+  description: 'Repository to copy for the performance tests. Should be at least the size of the Git repository.')
+option('benchmark_large_repo', type: 'string', value: '',
+  description: 'Large repository to copy for the performance tests. Should be at least the size of the Linux repository.')
+option('benchmark_repeat_count', type: 'integer', value: 3,
+  description: 'Number of times a test should be repeated for best-of-N measurements.')
 option('coccinelle', type: 'feature', value: 'auto',
   description: 'Provide a coccicheck target that generates a Coccinelle patch.')
 option('tests', type: 'boolean', value: true,

-- 
2.49.0.805.g082f7c87e0.dirty

