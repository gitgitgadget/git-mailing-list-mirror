Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258D1A4E84
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354913; cv=none; b=qDaWPHkJMPuUogUPThxvvoF1BRH5YeYqIq6fuuRS9ueQYt+ZZJem4z/mEALdjVpdrThOqW7T6VIxO7hIGWOuKBJSwuKHk2qQAh+dBSiewUR3KNS9FkGmkkI8ByidwcuIggFYE/iOQ17W/3dGUI2o0VMhaWC8KjekvGyGBcftUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354913; c=relaxed/simple;
	bh=6Yo4t7T8tMGPfD5/7GuVm6Qu351ugaTrN+0WIx1qZrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeWoOmcxbmCE8MJN2vulz6uLyo7PLRHN2zSN5sKHFbQyY4UP1Hu52Kx4PM/w0063EuFZDu4sEjeuWCMQuxc87r4Nb+hbiuqSFkuPmVUQ0reKmaOF5ImPIxikByLH7UafMMUtm3QoIkCkzvKOKOHwMI+eZ4p/pK3n/8wiH9jHClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BrQlBu8d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U8l4G+fU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BrQlBu8d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8l4G+fU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 27721138039B;
	Tue,  3 Sep 2024 05:15:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Sep 2024 05:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354911; x=1725441311; bh=ySSHlaLZoG
	gsdS4kmZH5RddeQPoSTlVVhMDFh7zZo8c=; b=BrQlBu8d2vdwzwKmY4ME+A0fGc
	ds3RKkBsj+wiGO+GglTydHXdO7JUlbKujGEwnqCblAjY97xrtIvQapjCKNVtIVLU
	S1KWZVx1sF3KRAiGMTK3Yo0eyZ2Mf+JqOErGb+GaztfXarKEWNCf3iioUgq+UZm2
	pSyjF/1yf4hXU0bniCQFImIqyxHH57I50OVf1YQ7su4u7lr+zfqj56IZu5otUTQ4
	1biS+16VuLaG7Dcs+seEnCb3FfXmgvjRzEScsQpwqYJCM7sfAJnOnWUOcHlu2+kr
	HNAQefJuZi0PgImVURVeoIb5xdXDUtoDbnynWRMj8+vCXYipv8NHxb/OqxbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354911; x=1725441311; bh=ySSHlaLZoGgsdS4kmZH5RddeQPoS
	TlVVhMDFh7zZo8c=; b=U8l4G+fUXIrWMmIy46/cndIdBdU5mQBZfHl2wzCWlGhG
	zvmeOddc9o0uRzkhEwcknEikkkUBOIbEyRGNwhQU6B6dUpZMYrHiv9XmS5U6Z8vd
	Ni6g0ROHgV9YCyxFEf0nkLA4ufgQDbF+DQqqGfFMJRwquAcUMCtFBx853FCFydw1
	HRoI9q6yKztdCtZ/E6dxfrNXCcpbbGV2J/b9dc7NtJacLBy/ILD3OLB4b3lGRO8s
	qRRDJJs79hed5FkAmb+FeNofQQpoKcdN5UM+dX90c7hXYjzJ6v52L731+HGNexsW
	7FRcNFtVLvrG3MS7gPFSlOHOeXqKmn2OMMg7tb1LIQ==
X-ME-Sender: <xms:n9PWZgAApRFI17WJrf-sQzhAIRPM6Xk9Nj_DUHC7K-x5zl8GKEvJhg>
    <xme:n9PWZigcNwnml7etVLUaN2oH2D3-JZr2tNs97QwpAA-XWGFW9gxnzJNcSL4HcSLIb
    6PHqYK-laRIzh2d7Q>
X-ME-Received: <xmr:n9PWZjlFAwyMcBq6uUbOiEVJZ7IOeYjbiOGuzlH9pFTmLoJFBxPjsHehJ5zo3DuX1ovWr7bnQQ_NB8i8nUtJcglS45NQBwAszVOTDcOvp4Awqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgugh
    gvrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:n9PWZmwbBZEjcmNzuPVrkndrDdQ1kvz6gpqHiydLKf7AKYImCgVOLw>
    <xmx:n9PWZlR5o4EAJGUQeYpE6I--xGbD7bokLE28RgiPEaNqiZnWKC0r4Q>
    <xmx:n9PWZha98kNPQP4M5AEIlUHXDsCiMrbTbjE5ZCXPVgFjysgPnPrvRA>
    <xmx:n9PWZuTXIdvgBK6ecC9_6kgFbHPSpOX2SlbXGrtWAkc1lqypW2a-ew>
    <xmx:n9PWZi_vh-bDqff2ZfQ55b8dpr40DIsDVfafPSWDP-uhpY7JrDDZcSPd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:15:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d3a1ae9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:15:02 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:15:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 11/14] t/unit-tests: implement test driver
Message-ID: <8bd5b3e2b2989a30b597da2103eb8d9699cf3d7f.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

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
 t/unit-tests/unit-test.c | 43 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 3d12cde6dae..96fa64de71d 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -1,6 +1,45 @@
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
+		OPT_BOOL('i', "--immediate", &immediate,
+			 N_("immediately exit upon the first failed test")),
+		OPT_STRING_LIST('r', "run", &run_args, N_("name"),
+				N_("run only test suite or individual test <name>")),
+		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("name"),
+				N_("exclude test suite <name>")),
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
2.46.0.421.g159f2d50e7.dirty

