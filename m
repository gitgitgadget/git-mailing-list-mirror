Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECFB238144
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797753; cv=none; b=nyKR552jq55MTzFiQd8bREw741CRPJC9JVGhnvpgvBFj0f8v6hHrZXArgXN8wNr34wg8GCRB7vilQd63yQ7DA4VvBdHSnwEChVc7zDRNeCa2ml/MXvgn0kP6VHtSufVEAn4auUwotqFbNee7qZi6s1RCrQoOCi5KHPTr4Isy9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797753; c=relaxed/simple;
	bh=LJss9KCOiT6NaDFpz73huf9SdSDIPLaMSPhNx6awWqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJTNFM+3YbmPCq1/wIl7jcduRairJ0IA+KDzweuKB34+9pd6luHnGylC5VgoTmtzg/JSu2sXTy/86urPGlOFnJSRSd6L8D+aQ16vi8zQTUVO6YOGFo4avhg4EQMbkrUAE89W0J+RU2zlEZnyrQufMmbvOZnSt1yJqeSgLdx20zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J2IDhagi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcpzGSjB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J2IDhagi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcpzGSjB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2893C1380196;
	Wed, 16 Apr 2025 06:02:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Apr 2025 06:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744797750;
	 x=1744884150; bh=6RLnQdulVmAYPteG/ekQ6rKbilmmu2qgG6rOpYkN9OE=; b=
	J2IDhagiETN5mrvN1nfYBrKo+5DCR1gkOiVBaRFkYqivbnA2JCc6rOx0PN8l8Xq6
	Jqh/J9voOl72/v2zDjs6lallPFDyMqYqT+pjmOUVjJWb7gHrUgghQbKZ8FBGLuWC
	9wnl+0/98SlG6LKRjM0Qg4wxnk/1A/dbPp8QJwBFS1vzMSvD6RPAb1a6V1w1Zl71
	OlxUwXx2T7tKHeY0J4tMbUc0sQlkn3r/Hf3bvWOnTPeiOdBdePQ95Kn+/vzegcsv
	wVTAZfs93QYgTl+4Yo+pbUjhJElpCZb0qTORa5iwzAHuAmn0jl420bDgdM/rztqR
	2x+IxNQAg9XXMUVQLfy0OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744797750; x=
	1744884150; bh=6RLnQdulVmAYPteG/ekQ6rKbilmmu2qgG6rOpYkN9OE=; b=N
	cpzGSjBMuTufq4SBUvNFN1zT79pwt7hg9K0GEWI1KbX8F3iEL6Fp926b0LTD6d/Z
	M67NAArhp2/67k7M1YEK2GHKdFLYN+lSOXwVPSDmnGmbj57TvtsweRFGD+YU5rLF
	NweMN5e21zIwVGPnnPUR7nznP299OqxJYeTWqynrPJWqIAixRaEX1NluEm/VO2nD
	6hg1qZGTfh2852jb4+PTlMQsk76HWiSTFXvEH+YRmuyiZxjRktbVeB4Dpfgpwg9O
	/tFhk+x6umiE0reviuNzAMzmNk9JTVSmIJdZCyyIz5S/2LB35T7Cp2vPv/TpRP2Z
	jx8wVTJfpK+bM1bAuLk0A==
X-ME-Sender: <xms:NoD_ZxCGBDENfAQYkfPMMKJTI9tfHpCfWSTsPaa8S2Aw2oFfTvNAtQ>
    <xme:NoD_Z_iQFa5mRXmuNLA1ga-3LKysTaBN1qUBL4Dj7Raa1rxtUqyxLZrA_AsKA0eem
    7zhSwLbKn_CTV7pEA>
X-ME-Received: <xmr:NoD_Z8nhbStRgyoYzSB21TBkPoCDUpXKRu8CznOHAYFlJe_LlyAg4rj7ZbKZITyq0227ajPwB9x_L5Cv7fKrBwS0wDnC9J3L1tVnu1GBvk3jsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdr
    shdrrhesfigvsgdruggvpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfh
    huqdgsvghrlhhinhdruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpth
    htohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvth
X-ME-Proxy: <xmx:NoD_Z7wk0-44_D_pZ5UOd4Jiof1poSWaXVqcKuYh51LKYhJLDgKb2Q>
    <xmx:NoD_Z2RQe4R2JpS3unFHZHAQ0Stsw2ZM14MxaaIHzUbKQj_0wAuiAQ>
    <xmx:NoD_Z-au0YfCxZUirdoCC-u9uxoURFunFWmbd0Vj0vmLroqRmF_pww>
    <xmx:NoD_Z3StD1rxxD16f6x0UsbeiQirO5YwDPYXWDlFOyCSG52JC-uaXw>
    <xmx:NoD_Z-mpO8LhLfM0RH401YdO3LYANGowRR2OwuEYH-kZIezkc6HPnlNY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:02:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff6c225b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:02:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 12:02:12 +0200
Subject: [PATCH v3 3/7] parse-options: introduce precision handling for
 `OPTION_INTEGER`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-parse-options-integers-v3-3-d390746bea79@pks.im>
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

The `OPTION_INTEGER` option type accepts a signed integer. The type of
the underlying integer is a simple `int`, which restricts the range of
values accepted by such options. But there is a catch: because the
caller provides a pointer to the value via the `.value` field, which is
a simple void pointer. This has two consequences:

  - There is no check whether the passed value is sufficiently long to
    store the entire range of `int`. This can lead to integer wraparound
    in the best case and out-of-bounds writes in the worst case.

  - Even when a caller knows that they want to store a value larger than
    `INT_MAX` they don't have a way to do so.

Funny enough, even if the caller gets everything correct the parsing
logic is still insufficient because we use `strtol()` to parse the
argument, which returns a `long`. But as that value is implicitly cast
when assigning it to the `int` field we may still get invalid results.

In practice this doesn't tend to be a huge issue because users typically
don't end up passing huge values to most commands. But the parsing logic
is demonstrably broken, and it is too easy to get the calling convention
wrong.

Improve the situation by introducing a new `precision` field into the
structure. This field gets assigned automatically by `OPT_INTEGER_F()`
and tracks the size of the passed value. Like this it becomes possible
for the caller to pass arbitrarily-sized integers and the underlying
logic knows to handle it correctly by doing range checks. Furthermore,
convert the code to use `strtoimax()` intstead of `strtol()` so that we
can also parse values larger than `LONG_MAX`.

Note that we do not yet assert signedness of the passed variable, which
is another source of bugs. This will be handled in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fmt-merge-msg.c       |  2 ++
 builtin/merge.c               |  1 +
 builtin/show-branch.c         |  1 +
 builtin/tag.c                 |  1 +
 parse-options.c               | 63 +++++++++++++++++++++++++++++--------------
 parse-options.h               |  6 +++++
 t/helper/test-parse-options.c |  3 +++
 t/t0040-parse-options.sh      | 23 +++++++++++++++-
 8 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 240cdb474bc..3b6aac2cf7f 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -24,6 +24,7 @@ int cmd_fmt_merge_msg(int argc,
 			.type = OPTION_INTEGER,
 			.long_name = "log",
 			.value = &shortlog_len,
+			.precision = sizeof(shortlog_len),
 			.argh = N_("n"),
 			.help = N_("populate log with at most <n> entries from shortlog"),
 			.flags = PARSE_OPT_OPTARG,
@@ -33,6 +34,7 @@ int cmd_fmt_merge_msg(int argc,
 			.type = OPTION_INTEGER,
 			.long_name = "summary",
 			.value = &shortlog_len,
+			.precision = sizeof(shortlog_len),
 			.argh = N_("n"),
 			.help = N_("alias for --log (deprecated)"),
 			.flags = PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN,
diff --git a/builtin/merge.c b/builtin/merge.c
index 21787d45165..9ab10c7db0a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -254,6 +254,7 @@ static struct option builtin_merge_options[] = {
 		.type = OPTION_INTEGER,
 		.long_name = "log",
 		.value = &shortlog_len,
+		.precision = sizeof(shortlog_len),
 		.argh = N_("n"),
 		.help = N_("add (at most <n>) entries from shortlog to merge commit message"),
 		.flags = PARSE_OPT_OPTARG,
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index dab37019d29..b549d8c3f5b 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -671,6 +671,7 @@ int cmd_show_branch(int ac,
 			.type = OPTION_INTEGER,
 			.long_name = "more",
 			.value = &extra,
+			.precision = sizeof(extra),
 			.argh = N_("n"),
 			.help = N_("show <n> more commits after the common ancestor"),
 			.flags = PARSE_OPT_OPTARG,
diff --git a/builtin/tag.c b/builtin/tag.c
index b266f12bb48..7597d93c71b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -483,6 +483,7 @@ int cmd_tag(int argc,
 			.type = OPTION_INTEGER,
 			.short_name = 'n',
 			.value = &filter.lines,
+			.precision = sizeof(filter.lines),
 			.argh = N_("n"),
 			.help = N_("print <n> lines of each tag message"),
 			.flags = PARSE_OPT_OPTARG,
diff --git a/parse-options.c b/parse-options.c
index e8c08e55e02..2cb9bd3b5b9 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -172,33 +172,56 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 			return (*opt->ll_callback)(p, opt, p_arg, p_unset);
 	}
 	case OPTION_INTEGER:
+	{
+		intmax_t upper_bound = INTMAX_MAX >> (bitsizeof(intmax_t) - CHAR_BIT * opt->precision);
+		intmax_t lower_bound = -upper_bound - 1;
+		intmax_t value;
+
 		if (unset) {
-			*(int *)opt->value = 0;
-			return 0;
-		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
-			*(int *)opt->value = opt->defval;
-			return 0;
-		}
-		if (get_arg(p, opt, flags, &arg))
+			value = 0;
+		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			value = opt->defval;
+		} else if (get_arg(p, opt, flags, &arg)) {
 			return -1;
-		if (!*arg)
+		} else if (!*arg) {
 			return error(_("%s expects a numerical value"),
 				     optname(opt, flags));
+		} else {
+			errno = 0;
+			value = strtoimax(arg, (char **)&s, 10);
+			if (*s)
+				return error(_("%s expects a numerical value"),
+					     optname(opt, flags));
+			if (errno == ERANGE)
+				return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
+					     arg, optname(opt, flags), lower_bound, upper_bound);
+			if (errno)
+				return error_errno(_("value %s for %s cannot be parsed"),
+						   arg, optname(opt, flags));
+		}
 
-		errno = 0;
-		*(int *)opt->value = strtol(arg, (char **)&s, 10);
-		if (*s)
-			return error(_("%s expects a numerical value"),
-				     optname(opt, flags));
-		if (errno == ERANGE)
+		if (value < lower_bound || value > upper_bound)
 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
-				     arg, optname(opt, flags), (intmax_t)LONG_MIN, (intmax_t)LONG_MAX);
-		if (errno)
-			return error_errno(_("value %s for %s cannot be parsed"),
-					   arg, optname(opt, flags));
+				     arg, optname(opt, flags), lower_bound, upper_bound);
 
-		return 0;
+		switch (opt->precision) {
+		case 1:
+			*(int8_t *)opt->value = value;
+			return 0;
+		case 2:
+			*(int16_t *)opt->value = value;
+			return 0;
+		case 4:
+			*(int32_t *)opt->value = value;
+			return 0;
+		case 8:
+			*(int64_t *)opt->value = value;
+			return 0;
+		default:
+			BUG("invalid precision for option %s",
+			    optname(opt, flags));
+		}
+	}
 	case OPTION_MAGNITUDE:
 		if (unset) {
 			*(unsigned long *)opt->value = 0;
diff --git a/parse-options.h b/parse-options.h
index 997ffbee805..8db96402c4d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -92,6 +92,10 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
  * `value`::
  *   stores pointers to the values to be filled.
  *
+ * `precision`::
+ *   precision of the integer pointed to by `value` in number of bytes. Should
+ *   typically be its `sizeof()`.
+ *
  * `argh`::
  *   token to explain the kind of argument this option wants. Does not
  *   begin in capital letter, and does not end with a full stop.
@@ -151,6 +155,7 @@ struct option {
 	int short_name;
 	const char *long_name;
 	void *value;
+	size_t precision;
 	const char *argh;
 	const char *help;
 
@@ -214,6 +219,7 @@ struct option {
 	.short_name = (s), \
 	.long_name = (l), \
 	.value = (v), \
+	.precision = sizeof(*v), \
 	.argh = N_("n"), \
 	.help = (h), \
 	.flags = (f), \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 997f55fd45b..b1275dfade4 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -120,6 +120,7 @@ int cmd__parse_options(int argc, const char **argv)
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
 	struct string_list list = STRING_LIST_INIT_NODUP;
+	int16_t i16 = 0;
 
 	struct option options[] = {
 		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
@@ -139,6 +140,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_NEGBIT(0, "neg-or4", &boolean, "same as --no-or4", 4),
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
+		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
@@ -210,6 +212,7 @@ int cmd__parse_options(int argc, const char **argv)
 	}
 	show(&expect, &ret, "boolean: %d", boolean);
 	show(&expect, &ret, "integer: %d", integer);
+	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
 	show(&expect, &ret, "magnitude: %lu", magnitude);
 	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 5eb1feb61b4..95951436cda 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -22,6 +22,7 @@ usage: test-tool parse-options <options>
 
     -i, --[no-]integer <n>
                           get a integer
+    --[no-]i16 <n>        get a 16 bit integer
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
     --[no-]set23          set integer to 23
@@ -136,6 +137,7 @@ test_expect_success 'OPT_MAGNITUDE() 3giga' '
 cat >expect <<\EOF
 boolean: 2
 integer: 1729
+i16: 0
 magnitude: 16384
 timestamp: 0
 string: 123
@@ -156,6 +158,7 @@ test_expect_success 'short options' '
 cat >expect <<\EOF
 boolean: 2
 integer: 1729
+i16: 9000
 magnitude: 16384
 timestamp: 0
 string: 321
@@ -167,7 +170,7 @@ file: prefix/fi.le
 EOF
 
 test_expect_success 'long options' '
-	test-tool parse-options --boolean --integer 1729 --magnitude 16k \
+	test-tool parse-options --boolean --integer 1729 --i16 9000 --magnitude 16k \
 		--boolean --string2=321 --verbose --verbose --no-dry-run \
 		--abbrev=10 --file fi.le --obsolete \
 		>output 2>output.err &&
@@ -179,6 +182,7 @@ test_expect_success 'abbreviate to something longer than SHA1 length' '
 	cat >expect <<-EOF &&
 	boolean: 0
 	integer: 0
+	i16: 0
 	magnitude: 0
 	timestamp: 0
 	string: (not set)
@@ -253,6 +257,7 @@ test_expect_success 'superfluous value provided: cmdmode' '
 cat >expect <<\EOF
 boolean: 1
 integer: 13
+i16: 0
 magnitude: 0
 timestamp: 0
 string: 123
@@ -276,6 +281,7 @@ test_expect_success 'intermingled arguments' '
 cat >expect <<\EOF
 boolean: 0
 integer: 2
+i16: 0
 magnitude: 0
 timestamp: 0
 string: (not set)
@@ -343,6 +349,7 @@ cat >expect <<\EOF
 Callback: "four", 0
 boolean: 5
 integer: 4
+i16: 0
 magnitude: 0
 timestamp: 0
 string: (not set)
@@ -368,6 +375,7 @@ test_expect_success 'OPT_CALLBACK() and callback errors work' '
 cat >expect <<\EOF
 boolean: 1
 integer: 23
+i16: 0
 magnitude: 0
 timestamp: 0
 string: (not set)
@@ -447,6 +455,7 @@ test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 cat >expect <<\EOF
 boolean: 0
 integer: 0
+i16: 0
 magnitude: 0
 timestamp: 0
 string: (not set)
@@ -789,4 +798,16 @@ test_expect_success 'overflowing integer' '
 	test_must_be_empty out
 '
 
+test_expect_success 'i16 limits range' '
+	test-tool parse-options --i16 32767 >out &&
+	test_grep "i16: 32767" out &&
+	test_must_fail test-tool parse-options --i16 32768 2>err &&
+	test_grep "value 32768 for option .i16. not in range \[-32768,32767\]" err &&
+
+	test-tool parse-options --i16 -32768 >out &&
+	test_grep "i16: -32768" out &&
+	test_must_fail test-tool parse-options --i16 -32769 2>err &&
+	test_grep "value -32769 for option .i16. not in range \[-32768,32767\]" err
+'
+
 test_done

-- 
2.49.0.805.g082f7c87e0.dirty

