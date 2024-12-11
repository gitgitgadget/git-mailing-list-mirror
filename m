Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D07205E06
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914398; cv=none; b=fX4KCFI8Ug1T0lw6hh8yO9GS8E4rWRuScjLuugXeHvKvf6/IQj+cixIi/LBpK1hch/0bFPtpddd4Nl47ObJvczfFbnVU6qe3yJPUMuE2SD3AT2z8OKnQ7SLK6GukC1sJ1HHKWz5kE0ECWjXIlw9qOyvg7p8f7kF+5iXOAMeC6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914398; c=relaxed/simple;
	bh=XSwJkfL8brVX3JDF2SqAIRy395fK4ItTQF+8GaRyRpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E6gjkt05vFLOCto41slcuZuQNixh1/Mv73upuxn2eFZ7hKdXUlGds7zG3P8cMRW6xM59fYLe3ctAeIAGdrSx0B14pTbXDpGpJGyG2Z6b0pe+Y2DuLGJuUwuQlHSDBgnDeIPqwiRl/PcvdOS0m01qkuTgSGhQS5oIGwDpRSuI4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J+mKtJtg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bwlgCt9H; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+mKtJtg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bwlgCt9H"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C80B1140273
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 11 Dec 2024 05:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914394;
	 x=1734000794; bh=GCyrGhhkOfxO/mCdYHzifqxLVUeVVPSSLCeBPI/ZPUk=; b=
	J+mKtJtgVxIojvuvTcV5iP+AcAJGuGJ8HSa8KjE/3Ag1kzJe1u2oq5oolYM+7zyZ
	gbJDX+7/Sunk+n/tre8TPuGPXAA1msnCTFzTigWNlp30TJDUiHmMr+FYc/h5HgpS
	ZmGG9mSDW1jBW2+/XfcBeKiFDowuZ0W1FJQsE0VUqzJWv+RJmeu4iTmAlPpPnZQH
	A2qZzjMXV40WWYNlk3+awE8poDZYzpAYiJUv8lG3RL6VYa6LOS7os6uAYPHVd+yq
	esvgEEb9nCWP4fmx/olY7l3p0qpg6uzqhuTGjMQLTptYxjsvLrV/MQ8jigiPtSTP
	kbKHyQNwKj7m8uRYJF/S8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914394; x=
	1734000794; bh=GCyrGhhkOfxO/mCdYHzifqxLVUeVVPSSLCeBPI/ZPUk=; b=b
	wlgCt9HxZVxdkk0lbqs8CAm89GU9BCtwDSh3AttkobjE99TzI8NV1Zxs+XDy/GPg
	1dGp9tCBtEbBoin5Z5qUvV1yqVhdIIwu6tYC/gY1+N2fmPixgtCHDbHJI3cDyOPh
	ftlpWROkbJOuMmnjeKHxabKnC2395ByXUPZEKNOqIpT08foajbjCC5MP60Z5eq4c
	sHcORC7Yle+DMvzJtV0vbyScbyjXQmBYutcZSrJ500B5U+MP2AGsx9ggPjyNIVVq
	ZPG5XVlhpArmJySZZW8LxOtWtoUcib7LxJgLhegVFKMMy6r7ZeqLCLBZhEc2IzMe
	7dDZyQ2kqracP4kqb2vxA==
X-ME-Sender: <xms:Gm9ZZ1P5mBA1y-pkw7TvUzXBvKbNF9boGNK9CIvJXmbNtkpaxr88rQ>
    <xme:Gm9ZZ3_WnJusqciiNfFbPHfSmmz0HRSTE8RdLcnKXnWftrJiL7eHEya5Tzi9ejxRo
    c4MOIdfnleZqWHcDA>
X-ME-Received: <xmr:Gm9ZZ0TG8QBldiKwMqAq3HOPM5kttiyYr4HEkKeQazbdXMHpWSH2cWh5OJ1yasGzAbRR5vF-3lYJ3pUK3GYXdGRliqA51jj0m5CLbsOLEGLXHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Gm9ZZxvvpaJHsLEEfDFbnKzwOXzxT1-_pOOCnlh_UxCHqfDRnIzWYg>
    <xmx:Gm9ZZ9fUoGj-Rzi4ZRiK3A5f-FVAuOk6yY3hlvuAGKFw6C2S7hkPdQ>
    <xmx:Gm9ZZ91lzjSc3C2R3V0imdN02A3OZioKwl3bPpD8WFqGYckFoLpCHw>
    <xmx:Gm9ZZ59-v-vISyWfrDxAJlk_5abhdZWvc1gPgo-8xVDhNdoqf5EhHQ>
    <xmx:Gm9ZZ9GiI3YrqpjJzCslvnUBEgCU4ww5qOMqtWpDn6mJnH9NT545GgI6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a51bc73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:52:38 +0100
Subject: [PATCH 7/8] t: introduce compatibility options to clar-based tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-meson-ci-v1-7-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.47.1.447.ga7e8429e30.dirty

