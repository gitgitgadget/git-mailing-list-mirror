Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06202951C3
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719262; cv=none; b=IdGR2r3e3aNbTtEYFLSIWl+z3I4FTg511+SckbiXXA5RqDnyCLsrW6nhqYJlxU1PeQ2KIhmM1Kim8YISX/x2cXAgdvQsEBdWZyYEAhxS9bjGZ7TZ47emh13dhZ0aoOCuxaHCtqypJTskQbWW/zTxEP12i/ZuA7gOE3QKaDp1NlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719262; c=relaxed/simple;
	bh=tFfDuAJQiFjsafwEVVY8iGRGog8UZHqcqQ/G09evIcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V++5xQFj8MC0S/PQrMZsf5xFvvpgXjbCycBFEnL46Xo/va4frEFRekl6dqeuLVku4PjXaMs4GB7F0igWLjkI6lrcU/vWWN4EfpUvhjjbhuQBji8zXdWykNZATTnUkReT/h4p99plsmcZUKH0OnzdErBWoo1IHh7PxfYamaxPusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ols2Xrr6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pD1Ko++L; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ols2Xrr6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pD1Ko++L"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A655F114036B;
	Tue, 15 Apr 2025 08:14:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 08:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744719259;
	 x=1744805659; bh=xqS3Pg5325h78jzBCnnpwA88ASjh1/fZbIOOCNPnsr8=; b=
	Ols2Xrr6rThfoTmquQkYnNcRYk2guY3sQMMD9QZMQwFL+7Ra1qekwe93voAX6tL4
	Sf524Taxp+pumXWA9iU8JTMoMfkRDq7FsLfJyHgkgRF/XeNPsVbp8WXqHrsRxSfP
	864HzubgacD1lD8WPaiNGOlznXOoOVW4WHAa0wil7xzn2iZYiIJP+GkfFMgoBY7r
	PpxhyxZSpgzAtMkmte8zuXbW/AsyrL1zIun6q/eHyuHVuWLEZUj3SHG115r3O5ga
	gQcYiIlB6vg516vX+6b3Fjis54yJO+pbQE3K5TYniaGZsof8CDjWNBEEyM5ZHMq4
	LQ0mY6HVSBpoKaA2qkTw0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744719259; x=
	1744805659; bh=xqS3Pg5325h78jzBCnnpwA88ASjh1/fZbIOOCNPnsr8=; b=p
	D1Ko++LRg63Y+dVmmNSFvJpZ85h40qtD979NLSePZIZ+5fKdgs0RpPXtNLfEAnyO
	T+e7k0tRuD646b8O4lUb6P2DxOqJy3qDaFLWuwXaRrXvc70uIngyN9k9r7g7ZpSI
	D852r6XAhU5kFHBPlTb+RGLEL7GepIQGvinYMJb9IDSiEDFaJ+D2WsadxSjznvVa
	XIY6wEINI3uERwkzbubPjN7s+Y1wdlSLucTZgBYrMcM+EVfTBXYi/1yI1Q/77EyA
	DMfBzDKOKtkaDkFKkkqrmnn01kp7HdMdEIAhQ02VggLJCRk7EGZaYtFE74mpsKUV
	QmE4fBqY0u1HaSBiBaGHQ==
X-ME-Sender: <xms:m03-ZyGuPGvZhzO9nTSjJRuADVP_8syXL_PJPhIskcDVGB83Ar_WGA>
    <xme:m03-ZzXmqZlsgqn-omZtzDWCaqqOgGaAEaIStaxBqj0l76oiORC9zWK-oemFLHzSv
    2-wBVxEXB6SWRP8mQ>
X-ME-Received: <xmr:m03-Z8L6ZjizaYYRimNUPh18ilW-Bz5bV7byAmFsFq25EUsHgtLuADeGRH7I-dUoo2sU6TVNbf0ka1CmDOJnr6BJs6pgnat7bnjSAFfd89GEsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrd
    hfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehtmh
    iisehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:m03-Z8F83jRKmFcMsklu6jGfZ5JkSqeK-rCVcbe0wC_ZZNRhE0M6-g>
    <xmx:m03-Z4VIAAOHXNDQk-UCRHCx0W9AmaPZ78YfqPbyKP_1pjfEwpv-Hg>
    <xmx:m03-Z_P6yDlGg5O2bBitxOGrTGYEUF4IVVJCwvrLISxm4s2Ck3xs_g>
    <xmx:m03-Z_28qrAkbOghgtgOURFGVIPvqInz6wjYM8c_zy5V0wSg0Uh7dA>
    <xmx:m03-Zz9iV7QRuLbw6tuM8EfyjKEuaYl5Y1ffHnuX0Hf5zuunyTYaAD7Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 08:14:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98a433eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 12:14:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 14:14:09 +0200
Subject: [PATCH v2 5/5] parse-options: detect mismatches in integer
 signedness
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-b4-pks-parse-options-integers-v2-5-ce07441a1f01@pks.im>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
In-Reply-To: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

It was reported that "t5620-backfill.sh" fails on s390x and sparc64 in a
test that exercises the "--min-batch-size" command line option. The
symptom was that the option didn't seem to have an effect: we didn't
fetch objects with a batch size of 20, but instead fetched all objects
at once.

As it turns out, the root cause is that `--min-batch-size` uses
`OPT_INTEGER()` to parse the command line option. While this macro
expects the caller to pass a pointer to an integer, we instead pass a
pointer to a `size_t`. This coincidentally works on most platforms, but
it breaks apart on the mentioned platforms because they are big endian.

This issue isn't specific to git-backfill(1): there are a couple of
other places where we have the same type confusion going on. This
indicates that the issue really is the interface that the parse-options
subsystem provides -- it is simply too easy to get this wrong as there
isn't any kind of compiler warning, and things just work on the most
common systems.

Address the systemic issue by introducing two new build asserts
`BARF_UNLESS_SIGNED()` and `BARF_UNLESS_UNSIGNED()`. As the names
already hint at, those macros will cause a compiler error when passed a
value that is not signed or unsigned, respectively.

Adapt `OPT_INTEGER()`, `OPT_UNSIGNED()` as well as `OPT_MAGNITUDE()` to
use those asserts. This uncovers a small set of sites where we indeed
have the same bug as in git-backfill(1). Adapt all of them to use the
correct option.

Reported-by: Todd Zullinger <tmz@pobox.com>
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c            | 4 ++--
 builtin/backfill.c | 4 ++--
 builtin/column.c   | 2 +-
 builtin/grep.c     | 4 ++--
 git-compat-util.h  | 7 +++++++
 parse-options.h    | 6 +++---
 6 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index f274a379487..a850c7d75fe 100644
--- a/apply.c
+++ b/apply.c
@@ -5123,8 +5123,8 @@ int apply_parse_options(int argc, const char **argv,
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &state->line_termination,
 			N_("paths are separated with NUL character"), '\0'),
-		OPT_INTEGER('C', NULL, &state->p_context,
-				N_("ensure at least <n> lines of context match")),
+		OPT_UNSIGNED('C', NULL, &state->p_context,
+			     N_("ensure at least <n> lines of context match")),
 		OPT_CALLBACK(0, "whitespace", state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
 			apply_option_parse_whitespace),
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 33e1ea2f84f..d95d7a2d4d6 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -123,8 +123,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.sparse = 0,
 	};
 	struct option options[] = {
-		OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
-			    N_("Minimum number of objects to request at a time")),
+		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
+			     N_("Minimum number of objects to request at a time")),
 		OPT_BOOL(0, "sparse", &ctx.sparse,
 			 N_("Restrict the missing objects to the current sparse-checkout")),
 		OPT_END(),
diff --git a/builtin/column.c b/builtin/column.c
index 50314cc2559..ce6443d5fac 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -31,7 +31,7 @@ int cmd_column(int argc,
 	struct option options[] = {
 		OPT_STRING(0, "command", &real_command, N_("name"), N_("lookup config vars")),
 		OPT_COLUMN(0, "mode", &colopts, N_("layout to use")),
-		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
+		OPT_UNSIGNED(0, "raw-mode", &colopts, N_("layout to use")),
 		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
 		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding space on left border")),
 		OPT_STRING(0, "nl", &copts.nl, N_("string"), N_("padding space on right border")),
diff --git a/builtin/grep.c b/builtin/grep.c
index c4869733e1b..f23a6f1dc86 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -983,9 +983,9 @@ int cmd_grep(int argc,
 		OPT_CALLBACK('C', "context", &opt, N_("n"),
 			N_("show <n> context lines before and after matches"),
 			context_callback),
-		OPT_INTEGER('B', "before-context", &opt.pre_context,
+		OPT_UNSIGNED('B', "before-context", &opt.pre_context,
 			N_("show <n> context lines before matches")),
-		OPT_INTEGER('A', "after-context", &opt.post_context,
+		OPT_UNSIGNED('A', "after-context", &opt.post_context,
 			N_("show <n> context lines after matches")),
 		OPT_INTEGER(0, "threads", &num_threads,
 			N_("use <n> worker threads")),
diff --git a/git-compat-util.h b/git-compat-util.h
index cf733b38acd..1218fcf81a4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -110,12 +110,19 @@ DISABLE_WARNING(-Wsign-compare)
 # define BARF_UNLESS_COPYABLE(dst, src) \
 	BUILD_ASSERT_OR_ZERO(__builtin_types_compatible_p(__typeof__(*(dst)), \
 							  __typeof__(*(src))))
+
+# define BARF_UNLESS_SIGNED(var)   BUILD_ASSERT_OR_ZERO(((__typeof__(var)) -1) < 0)
+# define BARF_UNLESS_UNSIGNED(var) BUILD_ASSERT_OR_ZERO(((__typeof__(var)) -1) > 0)
 #else
 # define BARF_UNLESS_AN_ARRAY(arr) 0
 # define BARF_UNLESS_COPYABLE(dst, src) \
 	BUILD_ASSERT_OR_ZERO(0 ? ((*(dst) = *(src)), 0) : \
 				 sizeof(*(dst)) == sizeof(*(src)))
+
+# define BARF_UNLESS_SIGNED(var)   0
+# define BARF_UNLESS_UNSIGNED(var) 0
 #endif
+
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
  * @x: the array whose size you want.
diff --git a/parse-options.h b/parse-options.h
index 20ea7d2ab13..7b7c9d901cb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -219,7 +219,7 @@ struct option {
 	.type = OPTION_INTEGER, \
 	.short_name = (s), \
 	.long_name = (l), \
-	.value = (v), \
+	.value = (v) + BARF_UNLESS_SIGNED(*(v)), \
 	.precision = sizeof(*v), \
 	.argh = N_("n"), \
 	.help = (h), \
@@ -229,7 +229,7 @@ struct option {
 	.type = OPTION_UNSIGNED, \
 	.short_name = (s), \
 	.long_name = (l), \
-	.value = (v), \
+	.value = (v) + BARF_UNLESS_UNSIGNED(*(v)), \
 	.precision = sizeof(*v), \
 	.argh = N_("n"), \
 	.help = (h), \
@@ -292,7 +292,7 @@ struct option {
 	.type = OPTION_MAGNITUDE, \
 	.short_name = (s), \
 	.long_name = (l), \
-	.value = (v), \
+	.value = (v) + BARF_UNLESS_UNSIGNED(*(v)), \
 	.precision = sizeof(*v), \
 	.argh = N_("n"), \
 	.help = (h), \

-- 
2.49.0.805.g082f7c87e0.dirty

