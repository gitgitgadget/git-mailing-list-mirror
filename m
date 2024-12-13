Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4311BD01D
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086506; cv=none; b=B/awrtjF4YQ/NAoMTDumQoBsoYBGoQVY/0t1Ug9xsNVUjLw6hmV8YIUEyCCItvqrhSU8N1AMaNfelrbryimJqmfo/BWbOk2s7qedQxVBfv7k6qUFYw87j42YX0/qbokGZLKQoeTujn3kkEkvSAikfSDgoMHYJO+kX7yb3kVwLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086506; c=relaxed/simple;
	bh=pFYNSeOC0dZqV3ncVHV3bXz+YI+syTJwIvF2qXoUjCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxB8evnntEIPsVEtpNuWMByjO95GzlTEKqZHrMC4Z6V5U90i5lCkC9Y5JadXKDXA5hZIegokC6+dYj04NZCLMwSZDRPf0V/C5HgZ7NYiaEmoPf6sNeUYsMUYdjulBgFulS928RI4tgLsElS+dm6awpwJRMhZ5OMnZIKQuR2WtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zJuse075; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3zqRDGS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zJuse075";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3zqRDGS"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B03EB2540206;
	Fri, 13 Dec 2024 05:41:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 05:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086503;
	 x=1734172903; bh=dlHdCt4FzOcIHjkhZFlN3njsmNnitRwFO8z3dlpI+Ic=; b=
	zJuse075tA3e6tiad5QPtxb82YZOEwrv4UyvrDn5cOCR3bH7ALlIaDVrhRE+7zBy
	YzrfL8tdp3Q7hwCLUXqbahvkPUExDmPsdIBuv5i3q+iMEV8BXaUbgPNLipHw+m3Y
	2Ugt87bUN1FDfZ5/v4Q5KlQEjD9OD7TYkKm8qSOZzOc2jLpxq+UYbdC1zj7zORCk
	HoZv8opW4T9KbcMmIHK8T5wa/qOfv/vlea9U5YT7CD898AhZleBJR1Rxclhdf2dX
	O5CtINIMYd5zBgFgF8tXLwbhvWAqLcPbMeelBILWLCqeJxWwcuhyNAT5d73Z/PqO
	cwcmtzzmaZTMR+rsNA788Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086503; x=
	1734172903; bh=dlHdCt4FzOcIHjkhZFlN3njsmNnitRwFO8z3dlpI+Ic=; b=T
	3zqRDGSJ3HrTOXG+267YXVQ44cU5ZI8Jl6fcihagzLgzTGOJSuwWoGDNzHzdSBlD
	Re1lWvzt2/hZNgCCS0xOxW5RTVsFxCUIi1xIlbN7CmkysbZhI6ESgKPbtotmlPn7
	OgoNkVJF0NocxrwuL9JoG5TmbrRipWTDGtl6ccoSx75X7OYL7v2TvE6sYJHVjQ1B
	0hv/gcmrc1gzhkhmzV2gkJmdNhsM48SHmrkCD2MQxJBBK6NZPkXc1fE24TY6Y1Yu
	unxmCjrkxT8WZ6TZrShZg5UvghwTpiGyHJAVi/knEB1luSpWJ8L/Jx6p/NYoVW+p
	JfvDprhzRDp6noguCpx4w==
X-ME-Sender: <xms:Zw9cZ52ngeG51njZaCuAMPyxK6zB8HJ8bbM6x3RZBhtpH_aGga4VMg>
    <xme:Zw9cZwGIfXOvlaAqi9qt7G1P1AmjHKE5_P1LChB4z2Tb8pCCrGdB_eKi7dbkWb1q2
    XSk-EsYw275jEhSzg>
X-ME-Received: <xmr:Zw9cZ54m8CqRBrDInlYCuJh_NIehvJRl-KRFEOjMmTnnjlAdYmhhGP92BeayG-iyNbI3ZtfPY5yFtH-6ajtClJedtHCkVsmeeD78nGT1AoBWDyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Zw9cZ23Rfe3-w5WlhPnpvngqMMQB48SObE69pRV2j_17bFKWSLLekA>
    <xmx:Zw9cZ8HdefstG5-cr50_w6QWny7l8gkOCa6KcWS5GyX6IVCtDr4lwA>
    <xmx:Zw9cZ39t8dwAIVquLz6CIh4eOIr-ul9sm_3fdMC9eGOGXu8ASnDiAw>
    <xmx:Zw9cZ5lK3YDfWZnarIAH7_nkaV1147wcnDx6Tqra6yWD5pdCETTDxw>
    <xmx:Zw9cZwBkJAipG9lXVwcLUta4w3YyEI-1vjAjWw-7H6ldMGDU7Fj3QjNj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e6a619b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 11:41:22 +0100
Subject: [PATCH v2 7/8] t: introduce compatibility options to clar-based
 tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pks-meson-ci-v2-7-634affccc694@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Our unit tests that don't yet use the clar unit testing framework ignore
any option that they do not understand. It is thus fine to just pass
test options we set up globally to those unit tests as they are simply
ignored. This makes our life easier because we don't have to special
case those options with Meson, where test options are set up globally
via `meson test --test-args=`.

But our clar-based unit testing framework is way stricter here and will
fail in case it is passed an unknown option. Stub out these options with
no-ops to make our life a bit easier.

Note that this also requires us to remove the `-x` short option for
`--exclude`. This is because `-x` has another meaning in our integration
tests, as it enables shell tracing. I doubt there are a lot of people
out there using it as we only got a small hand full of clar tests in the
first place. So better change it now so that we can in the long run
improve compatibility between the two different test drivers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.h          | 12 ++++++++++++
 t/unit-tests/unit-test.c | 19 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index f0801d4532a175b65783689f2a68fb56da2c8e87..d01361ca97fd7227a0005b5c447d954fea472ca0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -353,6 +353,18 @@ struct option {
 	.callback = parse_opt_noop_cb, \
 }
 
+static char *parse_options_noop_ignored_value MAYBE_UNUSED;
+#define OPT_NOOP_ARG(s, l) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = &parse_options_noop_ignored_value, \
+	.argh = "ignored", \
+	.help = N_("no-op (backward compatibility)"), \
+	.flags = PARSE_OPT_HIDDEN, \
+	.callback = parse_opt_noop_cb, \
+}
+
 #define OPT_ALIAS(s, l, source_long_name) { \
 	.type = OPTION_ALIAS, \
 	.short_name = (s), \
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index a474cdcfd351d9d624178a769329252237f951b7..fa8818842a42478c7a8fa6f6ecbee0777bdf472f 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -18,8 +18,25 @@ int cmd_main(int argc, const char **argv)
 			 N_("immediately exit upon the first failed test")),
 		OPT_STRING_LIST('r', "run", &run_args, N_("suite[::test]"),
 				N_("run only test suite or individual test <suite[::test]>")),
-		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("suite"),
+		OPT_STRING_LIST(0, "exclude", &exclude_args, N_("suite"),
 				N_("exclude test suite <suite>")),
+		/*
+		 * Compatibility wrappers so that we don't have to filter
+		 * options understood by integration tests.
+		 */
+		OPT_NOOP_NOARG('d', "debug"),
+		OPT_NOOP_NOARG(0, "github-workflow-markup"),
+		OPT_NOOP_NOARG(0, "no-bin-wrappers"),
+		OPT_NOOP_ARG(0, "root"),
+		OPT_NOOP_ARG(0, "stress"),
+		OPT_NOOP_NOARG(0, "tee"),
+		OPT_NOOP_NOARG(0, "with-dashes"),
+		OPT_NOOP_ARG(0, "valgrind"),
+		OPT_NOOP_ARG(0, "valgrind-only"),
+		OPT_NOOP_NOARG('v', "verbose"),
+		OPT_NOOP_NOARG('V', "verbose-log"),
+		OPT_NOOP_ARG(0, "verbose-only"),
+		OPT_NOOP_NOARG('x', NULL),
 		OPT_END(),
 	};
 	struct strvec args = STRVEC_INIT;

-- 
2.47.1.668.gf74b3f243a.dirty

