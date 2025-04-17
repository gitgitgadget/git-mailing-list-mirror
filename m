Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571E219A68
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744887000; cv=none; b=VAQiGmowrUhYgZcBev6GqdLR1tbzsn9slvgNI9LORWqr6gCFzITevQFtmc21KMZawbZ5r/li4KQ+nJxg35bxnSrK3WvyFU/H+V6NlzfrvrG0BELlU5AF30XnQX3cgCyH+1lqv6G8xXuZVS70tZnymXAoYnCxNkltKuwG1auuvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744887000; c=relaxed/simple;
	bh=Kiy0ewZAOR/lL/+xjM5csbx9ru9Ky6+gAePmtcsAh68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRJsbUXnEwREtyaUu2qpn16nRdXuBkYvBJnrHzeuSQz9q+1HoGtmH91ttAyCa0Z5TUyp4pAk/VJEBs1dZ6QewYSmInDTE3KMxBQpaoFS1C5HqFV/kPNb5i6LmL3Ao3APdm66rJWjwLvP8LncAAyheXq1EhqUcZjGYpazc5yBtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KGfxlKgJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RnYGl63R; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KGfxlKgJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RnYGl63R"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C71A11400AF;
	Thu, 17 Apr 2025 06:49:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 17 Apr 2025 06:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744886995;
	 x=1744973395; bh=QLYFCgFF0GNHho3n+cQQCCvfI45M8tMF7dKOAMdRKdw=; b=
	KGfxlKgJohy2TLu4ZMusxWSkWWitrtbez0uF/Ss4vIgZY9Ouxs1ZFGfEDyMFAmgU
	s4lbI1t1OvcekmZNUXafCF8s0yseCyJ19GeUW8a0J7FItUW4LriT02HdBkVWdphF
	oEbFIe5ETm5HgpiASa7SEQl2skTL2Q3C0tgnMz5004BzCcX3FYrJ2bUS8DhQR7of
	WbmeNO5MADF41zeMRlwLbFkZSm4StHmNt8DkEB30MmTW6/oy1yEOp8Qiat9HXG3/
	g8ji5yaS3TUncvFiikMHjJbN+EWCUE7uhqyAMFoVdawUa/f+PF9N0KzvzPuobGuU
	n3enJFhhNpKrm6nSCyPBuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744886995; x=
	1744973395; bh=QLYFCgFF0GNHho3n+cQQCCvfI45M8tMF7dKOAMdRKdw=; b=R
	nYGl63R2dQswz1e/Mtfgi2feAAmfQ06Jog/1LxSFZ3ond2u7nmneF7oGA5/sbQMx
	jZApzj77GprZ7T8JK3ScvT1sfHvj5Ao/se5EfnKAT2qFRVff6hqgAAeQGo3zhQtx
	58Or1fm0oxyblK/bCpP2WArVQX48FlLGJSflT/24qUf8/0VuMo6rn1srM86h1x79
	oCSUKKYRBRnCoOmHLctUc9AXkbnX1OP0KvPCBPh6CAZDTDSEuFnPgZxNb3lIUFQF
	PJQGBELRqS35v611vs+weI0v0TiXkUNK0DY9Stcnz8lvnuEJVllA7KQH5UqT/F25
	SJFuGy2UHMxlcXv+yim3w==
X-ME-Sender: <xms:09wAaCldOu-cm8O8Hs3-ETNvnZ967msYAu07gLsNo3F70BrIcIxWsg>
    <xme:09wAaJ2cTgN0i4xKu74eWzlD7c6sD1EJbtaE1FjO5os2hl-hAlGa01gGhafGdh27o
    uNca2OQveiozPljig>
X-ME-Received: <xmr:09wAaAoVSoe0zc8-I1s79K3woFusr5kNfan670PQtCprs8Ium6c2bwR-5vnJN8kVlBQY825z-Lf8mSb0l-lUSj83ujo6KBjqP1QobuPaZ5jUn4kU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdr
    uggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggvpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvth
X-ME-Proxy: <xmx:09wAaGldjX83zQyTk2fjb--HWP3dDAD04SZJTa1L127xVfrjP-ceqw>
    <xmx:09wAaA3gLLhKR_1sXOaEjVmIrM3-4J8vC5PuFEmlBUgfFL08le9jdA>
    <xmx:09wAaNuvSQ8y5ywn8jjGwVQUo7LBtSxq8wDAMCsaxQQSzNLqb_-PmQ>
    <xmx:09wAaMUz4DBzxS-rJcFbA71WIHEnCYFZwZg-iZouQGfZTSsbMqFjTA>
    <xmx:09wAaMIaF8esdv49GDeFvuUevkhPYhItlzaxenp6cIyLl7VXwu84i6ZO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 06:49:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73b1824a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 10:49:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Apr 2025 12:49:42 +0200
Subject: [PATCH v4 7/7] parse-options: detect mismatches in integer
 signedness
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250417-b4-pks-parse-options-integers-v4-7-9cbc76b61cfe@pks.im>
References: <20250417-b4-pks-parse-options-integers-v4-0-9cbc76b61cfe@pks.im>
In-Reply-To: <20250417-b4-pks-parse-options-integers-v4-0-9cbc76b61cfe@pks.im>
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
 parse-options.h    | 4 ++--
 6 files changed, 16 insertions(+), 9 deletions(-)

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
index dc460a26ff1..91c3e3c29b3 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -218,7 +218,7 @@ struct option {
 	.type = OPTION_INTEGER, \
 	.short_name = (s), \
 	.long_name = (l), \
-	.value = (v), \
+	.value = (v) + BARF_UNLESS_SIGNED(*(v)), \
 	.precision = sizeof(*v), \
 	.argh = N_("n"), \
 	.help = (h), \
@@ -280,7 +280,7 @@ struct option {
 	.type = OPTION_UNSIGNED, \
 	.short_name = (s), \
 	.long_name = (l), \
-	.value = (v), \
+	.value = (v) + BARF_UNLESS_UNSIGNED(*(v)), \
 	.precision = sizeof(*v), \
 	.argh = N_("n"), \
 	.help = (h), \

-- 
2.49.0.805.g082f7c87e0.dirty

