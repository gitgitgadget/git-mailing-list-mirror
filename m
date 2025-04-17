Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D8230BCA
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886995; cv=none; b=tREyhYr95UeBIHXD20eb4Ofg1xJqTxpqWqa4SxnSot6RqFPhifRYFr5Ga/E4T1TLAeMsn1mgDLMuj5K/IIi53afG3SaD44xrEY7G5Ap9E1FWoNyf1bO7iSLdGMboLsk7dXk26huOKV4MqIKsMy9XeDii9LWcfLjs8nvqIRmufPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886995; c=relaxed/simple;
	bh=9MOrYwZBzyKHeREIfOL/EtcKoeGbdT3NLIx0AQPHK34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qo2W8wPvTyeHTW+xV8S95GQuJ3x4LE+y+SUGi3kwORv6m6rUdV5ByyMWh73bh4D3R2POgbn+GrWuVMzCdcEvGwQgTu+S5f9w6JUCLblnTqLr3tp7+ogJEBwvxzdcYXbu9DEZKBymW2/1EwqcCzlw/6pVVEEoUSyiuPqVCPoFJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gvXGxb9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCcak5Gi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gvXGxb9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCcak5Gi"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23D3C25400C8;
	Thu, 17 Apr 2025 06:49:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 06:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744886991;
	 x=1744973391; bh=DVXKz3gwX/MM0+FS6SfZxJbb5dY5ksbiL0VSiwDYSbg=; b=
	gvXGxb9lb2c5q+4M8U6NUUS7a52jFsgw9Zk5xyf9bCFb68pOd7iLL3LM5d1DERPN
	i3/BHKhXMzkp8j0o2QnoBTVyzOL5IJPpXg2HpXUsCP8xPGAkBjWbcdXMiruL08pk
	+FNwbTIgXWDOSfMEg6/k+iim3SCm1Ewu6hKE+OC9/jOIw1EqDFbye5WQzsUMqsJk
	cLryNHsPBeckqWuEp3lDB/lxvg9lazfUcHpOWoHjSPo/6h7e4e50tseyDiBxBDMA
	j2TJkciCJ+JWRBIXm6JPdRa2PO8utJxEBxNKeQqeTTy71gyfGiJmXDcWtu2nQUne
	O1NjdxAhULYds6hjL64R1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744886991; x=
	1744973391; bh=DVXKz3gwX/MM0+FS6SfZxJbb5dY5ksbiL0VSiwDYSbg=; b=c
	Ccak5GiW0bdF7csx8X8f5N6di4CzDG3fcLe88cFfLGhAkIFp4T4h+RbzARzGo1dT
	dVopOnJL0OGvV0Y/PzReGseoySAcJgonM/PrDCtdzLYZRfyfYfBZuPO3yuTAL7l/
	n5Mqcyv9GJ7Rt0RgrXwpisk80KU6h68kqbZvgPnt4F2guybxpnQHqGGunjf19YTh
	wgqIqKanuqEM94WnVlQfS4XqdPByIn/e8J/a5SYSKQTg3yYpKCmYTVr82eF7gtYM
	BOXWUGdZD6HvOC6hYPEyFyBn9QAIumugOlfeqYhxNKIWtDnQrwtMfKdPepI2s8M6
	kCkAKIbUzZ4wtnJ8P2eIw==
X-ME-Sender: <xms:z9wAaHMPVCnMO30MKN0l9s0ziVYkN8o21wT78he-w48CEmu4cSQhNw>
    <xme:z9wAaB8Cpl5YgSNIJ5-gqws6prHBix9XfjI6rbyinhLVdWLUC72f7oGtiqR57q0xx
    YdXTkZUyJ-mqmwUAw>
X-ME-Received: <xmr:z9wAaGQZi0CKk-BLQlwn3foXcrlzG_OokMGEdjq9wh7a7CeEBcIDHSp4wTTIok8Gtg_PnjxN7UtdL46hHdCs04ZAzGrjaQlWzxWOy0uDFDb1QxMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehl
    rdhsrdhrseifvggsrdguvgdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehglhgr
    uhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:z9wAaLsTHdkp01VCyL6xJ3wBqnGXjuY8cmNBS05b7nYqJgDwUhnnqw>
    <xmx:z9wAaPcswyc6z1aPTbOLS_rbzgT1Uk-cxOgAk6KzR22j0Gegt8eo7w>
    <xmx:z9wAaH2rGm_TuY5aZ9aOC7wlHChhw_H63evDm_N1_V2Oshg6biRwgg>
    <xmx:z9wAaL_jRjTX6nk8rk3c-_3tUFFcJ1KZKe7_R6AQBO9Bn1uVMra--w>
    <xmx:z9wAaNwRrTVTCRwpFddnr3b6KbRQv9Kjk_qJ1d4TcYAvh4f3s8K_PJKf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 06:49:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ffbb16b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 10:49:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Apr 2025 12:49:39 +0200
Subject: [PATCH v4 4/7] parse-options: rename `OPT_MAGNITUDE()` to
 `OPT_UNSIGNED()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-b4-pks-parse-options-integers-v4-4-9cbc76b61cfe@pks.im>
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

With the preceding commit, `OPT_INTEGER()` has learned to support unit
factors. Consequently, the major differencen between `OPT_INTEGER()` and
`OPT_MAGNITUDE()` isn't the support of unit factors anymore, as both of
them do support them now. Instead, the difference is that one handles
signed and the other handles unsigned integers.

Adapt the name of `OPT_MAGNITUDE()` accordingly by renaming it to
`OPT_UNSIGNED()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/technical/api-parse-options.adoc |  4 +--
 builtin/gc.c                                   |  4 +--
 builtin/multi-pack-index.c                     |  2 +-
 builtin/pack-objects.c                         |  8 ++---
 builtin/repack.c                               |  8 ++---
 parse-options.c                                |  6 ++--
 parse-options.h                                |  6 ++--
 t/helper/test-parse-options.c                  |  6 ++--
 t/t0040-parse-options.sh                       | 50 +++++++++++++-------------
 9 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 63acfb419bd..880eb946425 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -216,8 +216,8 @@ There are some macros to easily define options:
 	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
 	The scaled value is put into `int_var`.
 
-`OPT_MAGNITUDE(short, long, &unsigned_long_var, description)`::
-	Introduce an option with a size argument. The argument must be a
+`OPT_UNSIGNED(short, long, &unsigned_long_var, description)`::
+	Introduce an option with an unsigned integer argument. The argument must be a
 	non-negative integer and may include a suffix of 'k', 'm' or 'g' to
 	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
 	The scaled value is put into `unsigned_long_var`.
diff --git a/builtin/gc.c b/builtin/gc.c
index 6707a26bc6e..b32cf937cdf 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -709,8 +709,8 @@ struct repository *repo UNUSED)
 			.defval = (intptr_t)prune_expire_arg,
 		},
 		OPT_BOOL(0, "cruft", &cfg.cruft_packs, N_("pack unreferenced objects separately")),
-		OPT_MAGNITUDE(0, "max-cruft-size", &cfg.max_cruft_size,
-			      N_("with --cruft, limit the size of new cruft packs")),
+		OPT_UNSIGNED(0, "max-cruft-size", &cfg.max_cruft_size,
+			     N_("with --cruft, limit the size of new cruft packs")),
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &opts.auto_flag, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 2a938466f53..e4820fd721a 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -245,7 +245,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_repack_options[] = {
-		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
+		OPT_UNSIGNED(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_BIT(0, "progress", &opts.flags,
 		  N_("force progress reporting"), MIDX_PROGRESS),
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 79e1e6fb52b..9328812e286 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4483,16 +4483,16 @@ int cmd_pack_objects(int argc,
 		OPT_CALLBACK_F(0, "index-version", &pack_idx_opts, N_("<version>[,<offset>]"),
 		  N_("write the pack index file in the specified idx format version"),
 		  PARSE_OPT_NONEG, option_parse_index_version),
-		OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
-			      N_("maximum size of each output pack file")),
+		OPT_UNSIGNED(0, "max-pack-size", &pack_size_limit,
+			     N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
 			 N_("ignore borrowed objects from alternate object store")),
 		OPT_BOOL(0, "incremental", &incremental,
 			 N_("ignore packed objects")),
 		OPT_INTEGER(0, "window", &window,
 			    N_("limit pack window by objects")),
-		OPT_MAGNITUDE(0, "window-memory", &window_memory_limit,
-			      N_("limit pack window by memory in addition to object limit")),
+		OPT_UNSIGNED(0, "window-memory", &window_memory_limit,
+			     N_("limit pack window by memory in addition to object limit")),
 		OPT_INTEGER(0, "depth", &depth,
 			    N_("maximum length of delta chain allowed in the resulting pack")),
 		OPT_BOOL(0, "reuse-delta", &reuse_delta,
diff --git a/builtin/repack.c b/builtin/repack.c
index 75e3752353a..8bf9941b2c2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1202,8 +1202,8 @@ int cmd_repack(int argc,
 				   PACK_CRUFT),
 		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
 				N_("with --cruft, expire objects older than this")),
-		OPT_MAGNITUDE(0, "max-cruft-size", &cruft_po_args.max_pack_size,
-				N_("with --cruft, limit the size of new cruft packs")),
+		OPT_UNSIGNED(0, "max-cruft-size", &cruft_po_args.max_pack_size,
+			     N_("with --cruft, limit the size of new cruft packs")),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
 		OPT_BOOL('f', NULL, &po_args.no_reuse_delta,
@@ -1233,8 +1233,8 @@ int cmd_repack(int argc,
 				N_("limits the maximum delta depth")),
 		OPT_STRING(0, "threads", &opt_threads, N_("n"),
 				N_("limits the maximum number of threads")),
-		OPT_MAGNITUDE(0, "max-pack-size", &po_args.max_pack_size,
-				N_("maximum size of each packfile")),
+		OPT_UNSIGNED(0, "max-pack-size", &po_args.max_pack_size,
+			     N_("maximum size of each packfile")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&po_args.filter_options),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
diff --git a/parse-options.c b/parse-options.c
index b287436e81a..d23e587e98b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -191,7 +191,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 				     optname(opt, flags));
 		return 0;
 
-	case OPTION_MAGNITUDE:
+	case OPTION_UNSIGNED:
 		if (unset) {
 			*(unsigned long *)opt->value = 0;
 			return 0;
@@ -656,7 +656,7 @@ static void show_negated_gitcomp(const struct option *opts, int show_all,
 		case OPTION_STRING:
 		case OPTION_FILENAME:
 		case OPTION_INTEGER:
-		case OPTION_MAGNITUDE:
+		case OPTION_UNSIGNED:
 		case OPTION_CALLBACK:
 		case OPTION_BIT:
 		case OPTION_NEGBIT:
@@ -708,7 +708,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
 		case OPTION_STRING:
 		case OPTION_FILENAME:
 		case OPTION_INTEGER:
-		case OPTION_MAGNITUDE:
+		case OPTION_UNSIGNED:
 		case OPTION_CALLBACK:
 			if (opts->flags & PARSE_OPT_NOARG)
 				break;
diff --git a/parse-options.h b/parse-options.h
index 997ffbee805..14e4df1ee21 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -25,7 +25,7 @@ enum parse_opt_type {
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
-	OPTION_MAGNITUDE,
+	OPTION_UNSIGNED,
 	OPTION_CALLBACK,
 	OPTION_LOWLEVEL_CALLBACK,
 	OPTION_FILENAME
@@ -270,8 +270,8 @@ struct option {
 #define OPT_CMDMODE(s, l, v, h, i)  OPT_CMDMODE_F(s, l, v, h, i, 0)
 
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
-#define OPT_MAGNITUDE(s, l, v, h) { \
-	.type = OPTION_MAGNITUDE, \
+#define OPT_UNSIGNED(s, l, v, h) { \
+	.type = OPTION_UNSIGNED, \
 	.short_name = (s), \
 	.long_name = (l), \
 	.value = (v), \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 997f55fd45b..fc3e2861c26 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -6,7 +6,7 @@
 
 static int boolean = 0;
 static int integer = 0;
-static unsigned long magnitude = 0;
+static unsigned long unsigned_integer = 0;
 static timestamp_t timestamp;
 static int abbrev = 7;
 static int verbose = -1; /* unspecified */
@@ -140,7 +140,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
-		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
+		OPT_UNSIGNED('u', "unsigned", &unsigned_integer, "get an unsigned integer"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
 		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
@@ -210,7 +210,7 @@ int cmd__parse_options(int argc, const char **argv)
 	}
 	show(&expect, &ret, "boolean: %d", boolean);
 	show(&expect, &ret, "integer: %d", integer);
-	show(&expect, &ret, "magnitude: %lu", magnitude);
+	show(&expect, &ret, "unsigned: %lu", unsigned_integer);
 	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
 	show(&expect, &ret, "abbrev: %d", abbrev);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 0c538c4b437..65a11c8dbc8 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -23,7 +23,7 @@ usage: test-tool parse-options <options>
     -i, --[no-]integer <n>
                           get a integer
     -j <n>                get a integer, too
-    -m, --magnitude <n>   get a magnitude
+    -u, --unsigned <n>    get an unsigned integer
     --[no-]set23          set integer to 23
     --mode1               set integer to 1 (cmdmode option)
     --mode2               set integer to 2 (cmdmode option)
@@ -115,30 +115,30 @@ test_expect_success 'OPT_INTEGER() negative' 'check integer: -2345 -i -2345'
 test_expect_success 'OPT_INTEGER() kilo' 'check integer: 239616 -i 234k'
 test_expect_success 'OPT_INTEGER() negative kilo' 'check integer: -239616 -i -234k'
 
-test_expect_success 'OPT_MAGNITUDE() simple' '
-	check magnitude: 2345678 -m 2345678
+test_expect_success 'OPT_UNSIGNED() simple' '
+	check unsigned: 2345678 -u 2345678
 '
 
-test_expect_success 'OPT_MAGNITUDE() kilo' '
-	check magnitude: 239616 -m 234k
+test_expect_success 'OPT_UNSIGNED() kilo' '
+	check unsigned: 239616 -u 234k
 '
 
-test_expect_success 'OPT_MAGNITUDE() mega' '
-	check magnitude: 104857600 -m 100m
+test_expect_success 'OPT_UNSIGNED() mega' '
+	check unsigned: 104857600 -u 100m
 '
 
-test_expect_success 'OPT_MAGNITUDE() giga' '
-	check magnitude: 1073741824 -m 1g
+test_expect_success 'OPT_UNSIGNED() giga' '
+	check unsigned: 1073741824 -u 1g
 '
 
-test_expect_success 'OPT_MAGNITUDE() 3giga' '
-	check magnitude: 3221225472 -m 3g
+test_expect_success 'OPT_UNSIGNED() 3giga' '
+	check unsigned: 3221225472 -u 3g
 '
 
 cat >expect <<\EOF
 boolean: 2
 integer: 1729
-magnitude: 16384
+unsigned: 16384
 timestamp: 0
 string: 123
 abbrev: 7
@@ -149,7 +149,7 @@ file: prefix/my.file
 EOF
 
 test_expect_success 'short options' '
-	test-tool parse-options -s123 -b -i 1729 -m 16k -b -vv -n -F my.file \
+	test-tool parse-options -s123 -b -i 1729 -u 16k -b -vv -n -F my.file \
 	>output 2>output.err &&
 	test_cmp expect output &&
 	test_must_be_empty output.err
@@ -158,7 +158,7 @@ test_expect_success 'short options' '
 cat >expect <<\EOF
 boolean: 2
 integer: 1729
-magnitude: 16384
+unsigned: 16384
 timestamp: 0
 string: 321
 abbrev: 10
@@ -169,7 +169,7 @@ file: prefix/fi.le
 EOF
 
 test_expect_success 'long options' '
-	test-tool parse-options --boolean --integer 1729 --magnitude 16k \
+	test-tool parse-options --boolean --integer 1729 --unsigned 16k \
 		--boolean --string2=321 --verbose --verbose --no-dry-run \
 		--abbrev=10 --file fi.le --obsolete \
 		>output 2>output.err &&
@@ -181,7 +181,7 @@ test_expect_success 'abbreviate to something longer than SHA1 length' '
 	cat >expect <<-EOF &&
 	boolean: 0
 	integer: 0
-	magnitude: 0
+	unsigned: 0
 	timestamp: 0
 	string: (not set)
 	abbrev: 100
@@ -255,7 +255,7 @@ test_expect_success 'superfluous value provided: cmdmode' '
 cat >expect <<\EOF
 boolean: 1
 integer: 13
-magnitude: 0
+unsigned: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -278,7 +278,7 @@ test_expect_success 'intermingled arguments' '
 cat >expect <<\EOF
 boolean: 0
 integer: 2
-magnitude: 0
+unsigned: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -345,7 +345,7 @@ cat >expect <<\EOF
 Callback: "four", 0
 boolean: 5
 integer: 4
-magnitude: 0
+unsigned: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -370,7 +370,7 @@ test_expect_success 'OPT_CALLBACK() and callback errors work' '
 cat >expect <<\EOF
 boolean: 1
 integer: 23
-magnitude: 0
+unsigned: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -449,7 +449,7 @@ test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 cat >expect <<\EOF
 boolean: 0
 integer: 0
-magnitude: 0
+unsigned: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -773,14 +773,14 @@ test_expect_success 'subcommands are incompatible with KEEP_DASHDASH unless in c
 	grep ^BUG err
 '
 
-test_expect_success 'negative magnitude' '
-	test_must_fail test-tool parse-options --magnitude -1 >out 2>err &&
+test_expect_success 'negative unsigned' '
+	test_must_fail test-tool parse-options --unsigned -1 >out 2>err &&
 	grep "non-negative integer" err &&
 	test_must_be_empty out
 '
 
-test_expect_success 'magnitude with units but no numbers' '
-	test_must_fail test-tool parse-options --magnitude m >out 2>err &&
+test_expect_success 'unsigned with units but no numbers' '
+	test_must_fail test-tool parse-options --unsigned m >out 2>err &&
 	grep "non-negative integer" err &&
 	test_must_be_empty out
 '

-- 
2.49.0.805.g082f7c87e0.dirty

