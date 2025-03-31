Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A119F117
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401833; cv=none; b=Oh5XK14o3dtR6AAFMzxkCpRlfX5r6l77xiN8xEcRgte95XdkPfBLEoGmNeuTXmeS19q6rQeYUPUFi+k/Zy2g3R0GvaGVEOrhtHHDbVyIZ8f5geZHkFamHHRGiPCj4Jm4Nmj747+z2vkJRl8XPEzW2NGFC1zgoe5UURJ9G248+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401833; c=relaxed/simple;
	bh=BN1VjZfIoAjP6WDL6QWARm3dqY28UQB/xWCI7kjtktE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3726AOFbfoaOs9UhTLllK9d7ds126ParZWfnhve0rYIE64L/VuU3qxde/B6hs+s54LPgqTVDdlpShArS9tpUYLC3Ivunl7aDuCgmCWorVsmnzF4/IxIc3Hgl31O3vt0qDcigjQvmOHn3CEQ6TExmpxJ6ThAfKJzI+MneCPvLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HbSbFsjH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtRWaVHd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HbSbFsjH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtRWaVHd"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 38B6A1384360
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Mar 2025 02:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743401829;
	 x=1743488229; bh=JNkTSEFlaG5j6dcwPoWHUuMLx1OkZTOv8UMEisE18GE=; b=
	HbSbFsjHhnIJE3Dpdu1ZwZdwZgJytORUWCbLwkLunpdwRDdWACmJuSxrKN5unNth
	xa/Fh9UodTIDP+63MvXpyoNpAu3KTtfMEbe8TQHBsN+gu0MAqDk2B5KFoZboZard
	7OGorVEJcwAeFy55f9BydarM5dcCkeul4lv6FSpHCfXAI1m9WzNIiUleTHJYUP2q
	RNrDPu9jJR0z08AfoC4LTNlGy7lqU+CFMO1/Vt8GqmHxVfAH17N7XdQoe6JZvO0F
	lb+E8JQZKe1aVxEMTWOI7D9Vxl9UDoS0YF3kNZ4Lx0LjvwfqgL9Vci2gIN6D1sT9
	QP5H4trZffrHykTO4qF8qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743401829; x=
	1743488229; bh=JNkTSEFlaG5j6dcwPoWHUuMLx1OkZTOv8UMEisE18GE=; b=F
	tRWaVHdwSdoEJoAlxuOD9Wwl+5nMDGaPZWqcn9DzksDmExomfJMtGjONiE7AEHbD
	+JllZ1OwzQUiHUt/6hcJbqrxI5k3+AcwGxZmV70xYXkkw27l5/OSKPVPQ8k5sWzZ
	gLn9b1Wu1bpMNqp6Emk5xLmyY+BCRuvJ9WI0KxCZfxn1u6FYRO5zxGTMmR9YR8fQ
	CDlFmG5Ed8K/axSb2TSlwczVCgq3uu+I/HphRruvZOOSKBSdjmAdeEPcanavgLZA
	HO6df8/hIOmjkeXyCAr7UPPlNsYFFbrkprky4chilyBL8JDFrt2QokgW5XooHx4M
	m/2SwFKVpmqf8xRYqjAFA==
X-ME-Sender: <xms:ZTPqZ6Wj8DMwtVvynm5piK-Zkhn5vbh6c4Xw_-UfjCMc_TV4wfPmlQ>
    <xme:ZTPqZ2kHjooTc_BUU7nk_sATakHTvVA4DjE8TvPCne25_7ofuzI2n_q2efpJe33Ls
    rudqHi6nm5xDYBWsQ>
X-ME-Received: <xmr:ZTPqZ-bVTXM-gevlGw74XlnjXMW7Y7Hlp076rUGUtJvcs3OUxYpQEq9X41a63pOUzAnVPlVFf6xAkIiAP2ILsD0u2P-CFyTWAXuQ6hLVKMCx6XjL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeludejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZTPqZxUjPO-7Kb0NIy0vDR87hRjgPsUVWW9Oq5FqjeAVgPBr-roVbw>
    <xmx:ZTPqZ0mSv63SjEcwghc6WkS3cvVYFnuBVmP6Br918jXTLz9XfJaO9A>
    <xmx:ZTPqZ2d7McLIi1GFoWyL9fwJ9RcPH24UeznJZka48eHNWsPJUqZ0_A>
    <xmx:ZTPqZ2Gmgasi6o8TBWrMiVKff1whyUyIU2Vk56pgHQ6IcDpG-O8z-A>
    <xmx:ZTPqZwuc6mi4WBLpsITqzG76Y9dnwbgTX9hA2GJG1YgwAJKrvVa3Pz7Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 02:17:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfc6d0d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 06:17:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 08:16:48 +0200
Subject: [PATCH 5/5] meson: wire up benchmarking options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-meson-benchmarks-v1-5-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.49.0.604.gff1f9ca942.dirty

