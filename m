Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70A2459E9
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797754; cv=none; b=n7VBHlrHwrfTE3uupxFCzkoumGJLJgDuguVJ16zLf7nH3GK0AZ07EUWFw0qC/YlWnUVYzs7s15aDTTpgKgmf+acR2D3zcTzhiQjCP2OaHdZM3yvUwjaLj4UXZeEOJu0nw7LglFMBF7ofU5BoyfJzf1EDi7JxK3vpQoR75YdraqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797754; c=relaxed/simple;
	bh=ZxYW7hzJk/wKOL2DK09O3p9H+7Awnxx9HfhXCX3fL5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/g/X7nRofK/JLpcyvd2yQuoIrLUohV9TMwNCkWmrTp0jOkKocK7Nr4RnnIENiy+mW5F8NSwQRiGVRSigzc0Uj4fcQQRM4h+LbGLJ6xR3yolp9A2PXr+9oa3IqT+ETd9+DzMfvhGJmF/v1AGzfrigPUopJI+ezE1a/908O7CdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kY15OYKF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pzvFuZq4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kY15OYKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzvFuZq4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E624C1140107;
	Wed, 16 Apr 2025 06:02:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 16 Apr 2025 06:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744797751;
	 x=1744884151; bh=G9+uXx/N3fJzi9JR6cpGxq3DsghWGV931EpWoCODjcU=; b=
	kY15OYKFE7WyuqCocXH6rMdCLAUUxzfmUt4FYb5BYgyW5GXEe8orqpRHV6remTrj
	vIFP+Xj2iMxtRyQ5zx5JEtb6FhNiCLVv/ptSZ64mL2U0Q1eJBzGOE48+hSuM9NyA
	EVXJt9tLo2OlGPjLBzXUPe7H2nNQb/JQRt8MZgZNt18sAyVpfLNBWp7CGFAb8WDP
	YHESwG1N2WZr9V915xfhfvrJjiMjPUzQMUTHT9jiw/3kzQ64mZrwD2dwmNyhOK8t
	amuLvow944Alm0Qalz0rHvaOjezi5qHjPtDHjQC0VcFgiR/Dw/SNHaSsq0T9YCeS
	7h0hAkU09JnYHJ0K3X9p2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744797751; x=
	1744884151; bh=G9+uXx/N3fJzi9JR6cpGxq3DsghWGV931EpWoCODjcU=; b=p
	zvFuZq44N8r6mVwQbi8GCc/AciBvPJQqDq+wE8pMMOxyoxEobVwx5jCQmH2qmZ4u
	r2h9DwAtrkpr3YP2twBswCX9aNYyiOArCkqYUps9IwI9MCbQWQghKfqTlQIb4yMI
	VkOBY3X5lUNs/DhBQFT2KtNbDEyRYwWmCV9QRS5AKgG15/8+j5/vG/6EO11VQST4
	TOTyfnHxap/BqfYy5Oe7qIrXIFqYaFqyzg80KpMmSDIhJenvIYW+nSPG158uCPOg
	fAcaygDy7LqYy2RzpQojqUFVloZ8ghNa4V3DjErXzP8Z2tVgNos87vEvTJn0LSZa
	tUK8a92byk5oz7vTFgHJw==
X-ME-Sender: <xms:N4D_Z_vzdCaMe8x8a7PIAEnzYWH5frtJvh7622iRcfscuaE08pbMHQ>
    <xme:N4D_ZweAWVB1oYkkYBmEWyBm_y2VH-8DoWOafXXXen1OV3PF6t6SZmxF-4dRXZLEg
    zqec1M_lO9owLH-Dg>
X-ME-Received: <xmr:N4D_Zywl9q6rkJMArsG0yTG3rZivTfA6JSj4oIXCGdhmNLRqZy7E9SAm7iRPLt_7rEmSQf-okSfgzMGxH00zLkHfBO55MKUQmOzwqxJNlYOTig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
    dprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdgu
    vgdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:N4D_Z-PHplUYTpcjGXPUhyejFqOFrIa5yd8-Vv3iU75Q8iGXjHQcSA>
    <xmx:N4D_Z__RIKu27Es8r98KVBT7sTuEaqN89WSSrDGIKaEK3vv4To-5Ag>
    <xmx:N4D_Z-Ufn5M_PCVpqMUGe8sJksR8P8TGIqZ9eb0ptKCcCfI1Wk4X3A>
    <xmx:N4D_ZwfkIUGOtWT7lbf5e1fklvg5oZV_Xwdq55gzOz-P4WJ4jX8MQw>
    <xmx:N4D_ZxS9XsjwB0tENi7ceZoewkvdVyKfyhHRQEYYh99CKqyP0vWsEQaS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:02:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 154fcfd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:02:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 12:02:15 +0200
Subject: [PATCH v3 6/7] parse-options: detect mismatches in integer
 signedness
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-b4-pks-parse-options-integers-v3-6-d390746bea79@pks.im>
References: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
In-Reply-To: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>, 
 Phillip Wood <phillip.wood123@gmail.com>
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
index aa37134dc72..168df642386 100644
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

