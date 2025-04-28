Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446F21DDA09
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825461; cv=none; b=a7S5MXPuMeJeXE+fVkhQz7PkVlJ/XxsPwF1xW8aQuDR7L35o9EIJiksaFU19hiQIi2wVM7Qr4zlTk0spQd8/dpT/JrNA5J6g7nf80DPBCxNy8nzK3PWkh4YNCDWdudvAqSEEpp6h5+rvB+j8vI9XDGicMjBlimykLrt+D5fJ8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825461; c=relaxed/simple;
	bh=RhtX4wKEHvuSuGgl4rzSeoDmZJBHEH5AqTLn0OwIwf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKsgJjO3/dNyv/Zpv0+w+7cAkh1J1gxTkeZcw0daBD7F7ogLyBxx1SwlOzHIP5tT37LxIKzITcz+0W7sec9iAgmtqqDxe9RUHIvEOcdKV1e3NShoiJYJ/aXb8rtIDeRB69+W+2S1vDSZ/UolunIBh2lnom9gzxEpszVsxPGzmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nkwo9+n+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tmsbc77G; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nkwo9+n+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tmsbc77G"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 521011140251;
	Mon, 28 Apr 2025 03:30:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 28 Apr 2025 03:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745825458;
	 x=1745911858; bh=OTlrhGU8rUvtv8Qrr6IcU8c0KG3bkthRYIEchYJnYP8=; b=
	nkwo9+n+UjaPfKLTpaDTG5IkUm9W0PwZCX2o613zFeGLVlWGYJfST+dikXCL+Qek
	Vk2PFOn8WFgoSNMU4mfVnP2utNQ/1hA21fA9Sh31+QhPvVRavmIFOwBLSIjuLE+u
	WQX9depg7w0qmdqLUAiYcmL8KFlAsGAVHcCo4p4kBCkfgD7i7RfyjezDxmd99knH
	2uW1GayrpMumsvIqoGNzNZ+kqAXl8VFjJDwwHeUB21HAJWqlNiBQL14wYTQX3UQD
	7X+b798HQ1fKr/8NKQe7wouzRzFGuwH4xOb4Lvt1jW+sZkX/9+bjvddMuZncO3jz
	Gdb2tU0reY7BBsHMcfxsAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745825458; x=
	1745911858; bh=OTlrhGU8rUvtv8Qrr6IcU8c0KG3bkthRYIEchYJnYP8=; b=t
	msbc77G4Qv7PuAM2Yin+UR9MJDr40ayPjNlcIQNRUgn1EQzBJoX2l1KDi8DuIRam
	UkSC7ALY8XfDycJUvC8KIzxp2CMUJxPGaySaB0tSnqQnCjgs7Px4ADsg/BmVW4LM
	u+wKOCYwN24c/fburnFe2jCoeO6kVFUjPZhZl0uNK4nbvH1onJZUdaz/iG0SMEZB
	MYMso2r91p3XSRwVPdHQMKXBUKXRVpdmc0nyk1oXN4Evc1T525CnHNAd7wWVRc5c
	ZmdW0KX/F9CCuk9hqAH04Kryy3wYYUWtHSPuHmU/SQYSbysHd1yFdH1kj4Fbk75b
	IaC7gEugPzavEoZQTGpTg==
X-ME-Sender: <xms:sS4PaMmATi8JKfuhGjyEDw15kpZOgeKX5hGnl3OKri_EB2qUUDsS2w>
    <xme:sS4PaL2HY_uT2LWYlmELC3ncJQCMltpsn3N5iwlPF0FJBfOLQ8houT6g-ZlstuR83
    4Y256GCug0JuBgqfA>
X-ME-Received: <xmr:sS4PaKrx8HR1tVfH2ZCz9NLtjyhTcUFlcnRmPoRRioEvxzJEnFqzOUNhkk-9uK-E5wnYbXrxHiLSTTTN1lLZ5VcxQVV9gT7i7lCQLOGmr7UZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sS4PaIkNUb1TXZe4mfvK2JOilWDz7BHgPQumVcomYIWub0cBJh0g3A>
    <xmx:sS4PaK2dO_JmqhZsQsBeJpz_-aFTxnAu113q_XzLEgW6jIj-rGyo7A>
    <xmx:sS4PaPssbpWoGPDvT30O9-cUSllLYhlVan8-yo6mWznCpjnbY07A5Q>
    <xmx:sS4PaGU6VDBIxMTEKxJarou_rqEcw1qFFo5CzM8cT-tHgkqd9BvxNA>
    <xmx:si4PaJ7Aw8tgoQE2N3IBpxWrDjQGyomE66OF_qNRgy-OH2m4xhskhjDO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 03:30:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2848784a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 07:30:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Apr 2025 09:30:50 +0200
Subject: [PATCH v5 5/5] meson: wire up benchmarking options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pks-meson-benchmarks-v5-5-5010dd014d1d@pks.im>
References: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
In-Reply-To: <20250428-pks-meson-benchmarks-v5-0-5010dd014d1d@pks.im>
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
index 939a2eae326..d06f82ff9f0 100644
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
2.49.0.967.g6a0df3ecc3.dirty

