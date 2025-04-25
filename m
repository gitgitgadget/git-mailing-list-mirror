Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182422E415
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566105; cv=none; b=PXWaVKCrwGqWsS3Bp8LzuTDxXhC6RWPxEXBPFOudsx2SWFZ0u3u/z6kkaOuW9iJY5OBYGT5V8da41F+cAN1If/8dHNQptZpu1lvAO1kx0uUL4+7acQQFRgmEaTpfEIPSm0qzSE9/xTQFP3akwmSRxuBokvLPjgkbLv9jCoqIJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566105; c=relaxed/simple;
	bh=szI+x/KCdMdvCBeshvjQWjO0boXLMTwvEm5nkYJmWQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rP7ysLCZ8f745mu42E5bJIidJPUTc8yvIZsAkKGAwPipgFKCtLdrb/DOjgO4TRYmenmemM7MS5lXDYFT02kJ5PE18SZGE1y/sL5Hc7RVJAzyCQ3suecAaKHVurLu8nrH/jlGILvh8EUg+h2zeBWvVbeMOSiLk6Jix5xGzT95uN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HJrHaBi+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImI621dE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HJrHaBi+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImI621dE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8AC13114022E;
	Fri, 25 Apr 2025 03:28:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 03:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566102;
	 x=1745652502; bh=38xTV37/QQpTQhDpMXbxdqsZ8Klq6kot67pVBFGqGXA=; b=
	HJrHaBi+hl9x5Y/tdKrSJcbKwVKakMwcqnOsROjd35NAur+L1RHW/akwSiYjqENH
	tPRxETsOL66/SA7X+kRkvxL9rBcg5bd9AaABMDZnD4cv0/wjcabow9JtKnmghray
	4fAHuWx4wlpYTMCzrpTwIWmpnrQXqWNks914M1i8VxV/IY7yTcRhxfO0RpNatNeN
	QnkmfXTw6ioDszAiVEULQX9YGcv3Xmz0KIhc5pgRELw8faHib6CwnMc+JvO8mu7w
	GG87zy9rYJaDmmAZBag82rPHE45g78HlvFZFEhEiwrGmagTaROKQI7/oD8zh5ouY
	lZa0cPnHPfj3PcmFxRaNcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566102; x=
	1745652502; bh=38xTV37/QQpTQhDpMXbxdqsZ8Klq6kot67pVBFGqGXA=; b=I
	mI621dE9+gPo08qKPiX/EpCR1iR6jjagiSlQ6lfpkiBfo6M/kPDQRz9GeIBJtztL
	Xa8YVmpQe2toqpeHjf0cOc3rVjG30NX5oXQZcgl+vqQ/BUNYv/FmhzNZCfjC72Bc
	xt1pe5oNlAuZwuShBj3Eazhmo+IaeY64L0MD/jLVBmWQ3SIv0tIDntkEeaP/HjJr
	vqCvv1vSFJssRBqUC/omFPfALzCpIXMHFykjizdY19MMGqU13uiZDjh6ZpidP1TS
	IbzqYwvp7OyXXwfR4b8PdcxcSDzO3y0Ohkww4aDoh222SKFBYVxG2TKUdOIQ5TUg
	Svee08Vcy/IjNVhqLiRyA==
X-ME-Sender: <xms:ljkLaGlJPxy4NgYlJcA1clc2-mpSjKMZFAyiZZrX6ljwwy-sJJmVlw>
    <xme:ljkLaN2zqOUkhLsV3XpS8HkIeMDM1EgpFmKXkXrGUHnw9mPzxP5I42gI9iBu92t8F
    Yl_WK9I6PAdxpTs0Q>
X-ME-Received: <xmr:ljkLaEp7icdLAmAdO7q-lxoqij8yhLGzV0EvRa96rd6nbu2myzciZghWLI282l1jY791gx8Itds2U0pXWlLmca2TQZp3yxNjlryZH6At>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhm
X-ME-Proxy: <xmx:ljkLaKlmaZNWjVh11uj-H0y391J4bpWfGVPnDBPZu7iDA_s3naAHWg>
    <xmx:ljkLaE1QLORkjHcDgkz5YiV8NA8ByQMtiLEHdl179-7HvYTn-ICe_A>
    <xmx:ljkLaBv75USBRgLlKTF5Z4H8J77ChkOdwxqgBthspYXrDCdYbeQCTA>
    <xmx:ljkLaAW-B0_YJkDapRoXzRgBDafG_3u-YeN3-yGHuFS95Vv_CMsh5g>
    <xmx:ljkLaD7WvXgZmA3meHBIqtCu8KXQtpkeE4_oMhXaFOIeZEX75gf7cFhM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:28:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65b8f6f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:28:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:28:17 +0200
Subject: [PATCH v4 5/5] meson: wire up benchmarking options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-meson-benchmarks-v4-5-6b89555052c3@pks.im>
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
In-Reply-To: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index 2cd05a9b1ba..5e073403632 100644
--- a/meson.build
+++ b/meson.build
@@ -706,11 +706,11 @@ builtin_sources += custom_target(
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
index 7f5bca5c029..8547c0eb47f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -103,6 +103,12 @@ option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto
 # Testing.
 option('benchmarks', type: 'feature', value: 'auto',
   description: 'Enable benchmarks. This requires Perl and GNU time.')
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
2.49.0.901.g37484f566f.dirty

