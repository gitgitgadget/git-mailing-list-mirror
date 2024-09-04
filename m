Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0A1DC742
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459440; cv=none; b=NOBHyWgEZipLzpio9XSb9GJYUVzHVtz4e+g2BUf3COZxqAiYsdxAlrvsVoQKVRC4Mv/1jFL/bZJnTlMTM9FgkMUSt0a0N4A1NQhwDNCHNg3nhyT2utXfHZVw15Mmunu7j4kFc1Jry0Ua5rg5JdTDUU7KgEZ4bp89e4ItoStAM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459440; c=relaxed/simple;
	bh=/2r9+0PwPDTeuCyqCutdtmH8g2Z92oSBugzkhG+eYXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1dytb4C7/yuFbGXIHFwGD6Ql3FuNv5l9bBKqXIKJFGI2ITcceSK8UWWsiHwkEseSPDQ94HHjtHbEy7xQO3w8+ZhqmjdE/lQ9SecqfK6dwI2hzYFuUbBZnhMS7TXW13kvqIIlpb/V6b8cGfhknZJ8i0XHhLjLSzwfDxAYe5RS7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a8gw/dmS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=osckJbTO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a8gw/dmS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="osckJbTO"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E398313801B8;
	Wed,  4 Sep 2024 10:17:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Sep 2024 10:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459437; x=1725545837; bh=1PTM3+rQCE
	4ci12tFtSst2ayN+O8e3S5F/H5UQM2Vyc=; b=a8gw/dmS6TxPLGvtbij+RdiYVY
	xwgj+EMY/68T7PPelthxI8DHI/sEIBrUhiy7fjeL73ZNdWdu9qI+YwEkMe7mmw6O
	2VZJsHIfPz/VkZELQ4e+MA78oFhLzsjdvMo2b6Zulgzb/K4zs0XtPPoisJKqU0Ti
	Kn3LP1Q2Xeli6Grc1riRbJkvTfcA517i2UupZn1A1YhxLVI6E731pR1Gc/54zRn5
	90s02Y/ypjC5vekrkMFsDi/mpM1S0Of/WmFhyQ6B/kwg/nT1G48Dw+i9cHT1QbZ1
	H2RhXR1rBDMZC2i+zjysK41teSxh9rsvdPc6LV3+jkoXRyhy6+PUjbTpfGLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459437; x=1725545837; bh=1PTM3+rQCE4ci12tFtSst2ayN+O8
	e3S5F/H5UQM2Vyc=; b=osckJbTOI6thFWzBg0Zn3U0Fwjc2RZZNb0XLx0J133IJ
	3RW720zvI5OWModjxZ5EirRwX85TLg0Su74lhxh/jRZIY+i7lwvX6JXR/n7OCGgE
	lDi6sHrGTJf3UgHvnNz9cIV3ONNdpYFoHP+t50pkNW4YkjoKaCDiv02wOa1cU7SW
	NmsUjuZIny/nFZ0A2kQipyAbLjqD5/ODRPk7JfuCqsNumw4dK8uBafonv5X7Gp7n
	yCI42Sh6amCPnL+UZd5PCXGbMEcRKOtjmoaFumm4csmP6RZpi7HZtmvC5rKkwP0W
	xzTfBCGAErlpozDuj+6tOrwzcm0Bo6QHSNKjo1vg4w==
X-ME-Sender: <xms:7WvYZu93FtxydMl5oR-3ElfKrGerNBmEdbSMnV91rX_4gO5lJcGTZg>
    <xme:7WvYZuvmm_8AQO3S9fsbzpEjAuhOJq3W1EwOxQhXRzN9_diYQ8N2bjbPaKGPlbX1M
    o2gHIjREDY3F4NEFA>
X-ME-Received: <xmr:7WvYZkDM3Ig6uM_kB6JeEEcqQsA4NNVSX6GV5WWR1GHQLvMVGb45BoobfUEu01HfXxZqNFQ8VfzFaKanb6NiUIYCkGt0fpJF3O47DF2vzoYCNMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheprhhssg
    gvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:7WvYZmfjZ7Vd4HCxdxSHYNw8aWpdHTBzdeQE4fPW3Nmo4hHm4b8M_w>
    <xmx:7WvYZjMhwsQIo8z1GuVgT1mokDBQ3AFMNsg6dNeA3Um2ESSSvGopnw>
    <xmx:7WvYZgmRZoZURU8wjfaXZ7edDFloxPwda5I4G7bfbznXuvD8iPebdg>
    <xmx:7WvYZlto41RRxp1VQpRlDi_ZuVIoNSQtWyW9HOXaLXdr0AoO_7P6Uw>
    <xmx:7WvYZuqr6KZGXlRb89YBRHqI_cSdf2M7AQdYnyIjPUNlZOglaZ42LRPH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:17:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e2f92c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:17:07 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:17:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 11/14] t/unit-tests: implement test driver
Message-ID: <81d932bfa3328f9e876c0f51b4625974cda21471.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

The test driver in "unit-test.c" is responsible for setting up our unit
tests and eventually running them. As such, it is also responsible for
parsing the command line arguments.

The clar unit testing framework provides function `clar_test()` that
parses command line arguments and then executes the tests for us. In
theory that would already be sufficient. We have the special requirement
to always generate TAP-formatted output though, so we'd have to always
pass the "-t" argument to clar. Furthermore, some of the options exposed
by clar are ineffective when "-t" is used, but they would still be shown
when the user passes the "-h" parameter to have the clar show its usage.

Implement our own option handling instead of using the one provided by
clar, which gives us greater flexibility in how exactly we set things
up.

We would ideally not use any "normal" code of ours for this such that
the unit testing framework doesn't depend on it working correctly. But
it is somewhat dubious whether we really want to reimplement all of the
option parsing. So for now, let's be pragmatic and reuse it until we
find a good reason in the future why we'd really want to avoid it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/unit-test.c | 45 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 3d12cde6dae..a474cdcfd35 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -1,6 +1,47 @@
 #include "unit-test.h"
+#include "parse-options.h"
+#include "string-list.h"
+#include "strvec.h"
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+static const char * const unit_test_usage[] = {
+	N_("unit-test [<options>]"),
+	NULL,
+};
+
+int cmd_main(int argc, const char **argv)
 {
-	return 0;
+	struct string_list run_args = STRING_LIST_INIT_NODUP;
+	struct string_list exclude_args = STRING_LIST_INIT_NODUP;
+	int immediate = 0;
+	struct option options[] = {
+		OPT_BOOL('i', "immediate", &immediate,
+			 N_("immediately exit upon the first failed test")),
+		OPT_STRING_LIST('r', "run", &run_args, N_("suite[::test]"),
+				N_("run only test suite or individual test <suite[::test]>")),
+		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("suite"),
+				N_("exclude test suite <suite>")),
+		OPT_END(),
+	};
+	struct strvec args = STRVEC_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     unit_test_usage, PARSE_OPT_KEEP_ARGV0);
+	if (argc > 1)
+		usagef(_("extra command line parameter '%s'"), argv[0]);
+
+	strvec_push(&args, argv[0]);
+	strvec_push(&args, "-t");
+	if (immediate)
+		strvec_push(&args, "-Q");
+	for (size_t i = 0; i < run_args.nr; i++)
+		strvec_pushf(&args, "-s%s", run_args.items[i].string);
+	for (size_t i = 0; i < exclude_args.nr; i++)
+		strvec_pushf(&args, "-x%s", exclude_args.items[i].string);
+
+	ret = clar_test(args.nr, (char **) args.v);
+
+	string_list_clear(&run_args, 0);
+	strvec_clear(&args);
+	return ret;
 }
-- 
2.46.0.519.g2e7b89e038.dirty

