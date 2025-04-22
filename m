Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE271F09AD
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304626; cv=none; b=PECoP80wfKurGIbGhRm1sTm4eyT0pQtMDoqOS99Xg5+N4F9qIgntyhVMy7m16pgwdX+6kR9ObVosqgxG15te+U2l1JrL7ak8RZLIucfbXpZ/5qbLK0hiffnzhiqfVLuQjXYs+AXaIXVjPa6Ej27e6KqGweZ9ZboSF9dIP5Pxzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304626; c=relaxed/simple;
	bh=Ap+bJwyeBS9juCIf97RH39W6IBqVC68QqgW081TIVVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNbv/VjfBLGtyTPRDuyB/YWzVgQpA7JMpERSYAUEeRiUqK6/5jLg7D2AtMpz8BoZ2smNi7botNUbj5o7FjM+Mp4s17ocOItEmzrqsRwbWSf7cS2cFuSVZiYmLHUUzW3JDeuw+/9v1xuqtbPy56ueMO+WrlkWgpyXDZzFmgPL8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JIATTn4t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xWX+37F4; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JIATTn4t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xWX+37F4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BEDA411401E2;
	Tue, 22 Apr 2025 02:50:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 02:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745304623;
	 x=1745391023; bh=l5kFv4XdrhEf4vMhuqI7DkY3fVUmBzJ7UlMPrhPk3YU=; b=
	JIATTn4t9FrB8+WhdpYwteF6G9ZMjV2uoypmRnwztDzX7LOOxL83vI+yIwFw1OUL
	FznOHMgqUVl7R7a85ZMCK9tqfRX3pD+qRFWfICtAraIMsbC/8WOsmba8vRLDQcpA
	mkZCcAQ9vkfCmQ2UB1rtPYd9ZDlYQWAocM0e4Lvam37DodNxAgXPNis/UeRcL0DY
	Nv2C0iyYJZDYV3cfQewkzDxepZmzBtx+PjYqZQRiJeSoc5MvDfgX6w+az2mGWRqO
	APG/nMm61i3XWvEBdehEX4cHTL1ui+rhHqRygfI1ukazx3f/BBWPBEt9Fz18LNnV
	jhus9h2x2UyxtgRAbKSGfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745304623; x=
	1745391023; bh=l5kFv4XdrhEf4vMhuqI7DkY3fVUmBzJ7UlMPrhPk3YU=; b=x
	WX+37F4Cifg3ADg5w0lne6mfnrc2qt1/qxyojtJ5BLeiFsQR+7PN3GI2Lwa6txxD
	UawPqmg+d6qY15AJVnscAikhh3wMg0/69urnkch8jF7Zci/nFmDOA1upoLgCbs9F
	qEjFnTUdz2uwWO1bvAdfPq/oe3ANP4Lp+E6+IfG5qC0aB8ADvARvomOFCskx3Nbl
	Op5M19b64/hb3o+ALxDhzO9EnMD0Ncs2BOXV1dH9xDekFm1FZXkevIV0N0tWGk63
	teyh9N30OWeF7CaLVeIz8hPCd7HxyQkw8bTT1dIsi/EVzFMcb85Zt2y3vjyqOBnn
	iI7GOc9CPtcnPczCjQepg==
X-ME-Sender: <xms:LzwHaDQxoBlhKUejhOpBoTMZcixh66mOtvjSGOoQ4OaRAZfIJ4DDwg>
    <xme:LzwHaEzHT5GSPoB0j-yXuM6Y4ZAgx2DhjpbZ892jdWuhfnPl-yUIG1-P4GcbOBr-d
    3KJovTcJrKhXHu69g>
X-ME-Received: <xmr:LzwHaI17diWPzmKjLtdYbrFvcC3hGinWjPcvLyzAjBvnH8jA_RtIavqRXXQgY5MH6Iqzsoj-OzHM1F3vrEcTPKix3I9CwTDwsAuRoBFCJxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LzwHaDC1UtcW5rSnZ-6phgB1npPyLG00Aq-4LSpJEpA72o_6emmA2A>
    <xmx:LzwHaMgJhOEK7qo6kqbCm2RnwK-GY2WoVOc9SO6sDUU8LXUvuxVxFw>
    <xmx:LzwHaHp2SJt0LaN-FguFXW0S7XdSZSgiy5EUkBnU6aTx46WP3DHfzQ>
    <xmx:LzwHaHifYa9Cu_TtldeeeqId72qzqjzkVaFa7J17uIiu1r5mtabvxw>
    <xmx:LzwHaBFJXyf9KzvTcv-6sXVLzKQAAU0eIvasVrXcZIOxiB3oweDZGPsB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 02:50:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 035b08ff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 06:50:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Apr 2025 08:50:15 +0200
Subject: [PATCH v3 5/5] meson: wire up benchmarking options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pks-meson-benchmarks-v3-5-7aad68bac6fd@pks.im>
References: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
In-Reply-To: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Christian Couder <chriscool@tuxfamily.org>
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
index 205b1bb301a..5bba743dc0e 100644
--- a/meson.build
+++ b/meson.build
@@ -666,11 +666,11 @@ builtin_sources += custom_target(
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
2.49.0.901.g37484f566f.dirty

