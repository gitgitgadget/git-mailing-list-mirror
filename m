Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076442951B7
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719262; cv=none; b=U363SEFfJ2MZt2rlov/4milZ7xDeuN+d/M2aJ49b1uJtKbjgtrwQMFZNExCL52c1FNtPEwddNHtOdkGE0oW7VnyWV2/satb3H3WwiSC+8VToEf/lQn6Xl6W+Jd7tNZH4k0PO++mglG0Prpyb/Q0DYgtmY25GD7fxNqlk8VyOTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719262; c=relaxed/simple;
	bh=xzF6f3TRMSPeJqJykBTHdbt6jh7M88tzg5ydBnkMv2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0y2xi0oX7IYs+eS/NXEs0oKjJh05QU0tXQyUOKdxng3YNOTtniVRq3wGG4BPEprMQzLOWkSNGQlgSxLk+VPR/piCXVD9wDrHd1brIxBhBFBWbULRCQvqiEwfpAV4sVU0l/GIEqNV1t5BKMtVJHpT9ZNAi7DrfsA/y0T7ZiqUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BxATnuZ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3Aiyg3g; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BxATnuZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3Aiyg3g"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE553114035F;
	Tue, 15 Apr 2025 08:14:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 08:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744719258;
	 x=1744805658; bh=9xx7U+JB6JrWrykJ10GjVLPbm5/8OLKFFnQPzrwzItk=; b=
	BxATnuZ2TewbYoJu06YpyxarqtIywILbxaxUXFStRw2VgaY45FIJB/QGKju2/+9+
	seg7IeiTCejSUm8NItZ15mqADygamoBXAXze/bcjGR+J5chQ5zT3rPcvSeDdJy4G
	JeiIEmVGhF8QuRixXQHQ+lID6iwTyplCs5bU8+Kar5wY5n5zS8gDIkTAYYmvr6vl
	rAen2r3vUXAgDgXWhxqvzp5SxIM3+PW1Uv0y0J9RLknnF0PzED7EMbSOklOHfY3S
	v8Kt9mNaPYDzvqkdbwR9SuzdBM95FXAgQ7VOZ050ClwLy6dgcW1sw+UkrPDXNs90
	i6TMiOuELTLAwFG7zrJBTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744719258; x=
	1744805658; bh=9xx7U+JB6JrWrykJ10GjVLPbm5/8OLKFFnQPzrwzItk=; b=i
	3Aiyg3gENrxaM+KRm5CkETkulUSHETgUppcb6EWYvUHVJf5DSgUzIFDNA0DKjZBj
	taajja6ha7IwJrGLSuE9SR0Q/V6vts7hKds4XeWsHl+1nhW2b0UNXYskINPy+HAj
	fbyX3U9KP+jz7Wf3oK1u/qmWZJJvbTdCm1AiOckwbmMsR1m1dNtwAuf85Ff0lR+v
	xMXvYQKIuMG2nkCIpGGUYliAVf7OTVM7/bhOixGb/WX5rhsErkAc/2PS1r2TVNMF
	5KENtjdBH8fBDmBr8woVFIt0KbfwCzTDllw/STIhMjIeXyLHU+xrntaGqucTPpy+
	nUf10fL6WoZCAoLRbNl6A==
X-ME-Sender: <xms:mk3-Zx6DC3_didxz2B1kYRWVlaxDDSUfzI9CjYLQkkCNApGa79jH2g>
    <xme:mk3-Z-7jUZvIe9p7adebUP4IHe2HO8s3aLvItcC-9pT4Mv5XwZpLxDa7QyEGQqMoM
    L3QTA3UDDdBBXTg4w>
X-ME-Received: <xmr:mk3-Z4c4bi9UW19ox6O2cGxj96Kz2-I4i4bAe66e3h_yRmv2vh2NM8_moB2YmIxOz3VaD2Rtn2snaZ7KmVZITavJsAX8KIZF6f_lhfwjM59drg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpth
    htohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehglhgruhgsihhtiiesphhhhi
    hsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:mk3-Z6LHDqypT9RufrTQjnXWzie_QQM_dyUa0tjjLxd9VlAtRZITtw>
    <xmx:mk3-Z1JQQkt7PexBOg7hByhYcqis01LzZiPEB3h9_pr3PyPm_OBXeA>
    <xmx:mk3-Zzx75EdJHoZpWC8tAXdEemqONW3QHnG5lanBlVnejkpkCV1vFg>
    <xmx:mk3-ZxLy7fgCfsNPylq94RAhE4de24p5WsbZItXmZQSoTpOeg0Agow>
    <xmx:mk3-Z9Dc26ZmZ79ygEdXi7HlEry8oBJdANcxK8IbeyUtLvA8g3XSkWIK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 08:14:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f27861b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 12:14:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 14:14:08 +0200
Subject: [PATCH v2 4/5] parse-options: introduce `OPTION_UNSIGNED`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-pks-parse-options-integers-v2-4-ce07441a1f01@pks.im>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
In-Reply-To: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

We have two generic ways to parse integers in the "parse-options"
subsytem:

  - `OPTION_INTEGER` parses a signed integer.

  - `OPTION_MAGNITUDE` parses an unsigned integer, but it also
    interprets suffixes like "k" or "g".

Notably missing is a middle ground that parses unsigned integers without
interpreting suffixes. Introduce a new `OPTION_UNSIGNED` option type to
plug this gap. This option type will be used in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c               | 43 +++++++++++++++++++++++++++++++++++++++++++
 parse-options.h               | 12 ++++++++++++
 t/helper/test-parse-options.c |  4 +++-
 t/t0040-parse-options.sh      | 18 +++++++++++++++++-
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index ae836c384c7..9670e46a679 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -216,6 +216,49 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 			    optname(opt, flags));
 		}
 	}
+	case OPTION_UNSIGNED:
+	{
+		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
+		uintmax_t value;
+
+		if (unset) {
+			value = 0;
+		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			value = opt->defval;
+		} else if (get_arg(p, opt, flags, &arg)) {
+			return -1;
+		} else if (!*arg) {
+			return error(_("%s expects a numerical value"),
+				     optname(opt, flags));
+		} else {
+			value = strtoumax(arg, (char **)&s, 10);
+			if (*s)
+				return error(_("%s expects a numerical value"),
+					     optname(opt, flags));
+		}
+
+		if (value > upper_bound)
+			return error(_("value %"PRIuMAX" for %s exceeds %"PRIuMAX),
+				     value, optname(opt, flags), upper_bound);
+
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
 	{
 		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
diff --git a/parse-options.h b/parse-options.h
index 4b561679581..20ea7d2ab13 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -25,6 +25,7 @@ enum parse_opt_type {
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
+	OPTION_UNSIGNED,
 	OPTION_MAGNITUDE,
 	OPTION_CALLBACK,
 	OPTION_LOWLEVEL_CALLBACK,
@@ -224,6 +225,16 @@ struct option {
 	.help = (h), \
 	.flags = (f), \
 }
+#define OPT_UNSIGNED_F(s, l, v, h, f) { \
+	.type = OPTION_UNSIGNED, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.precision = sizeof(*v), \
+	.argh = N_("n"), \
+	.help = (h), \
+	.flags = (f), \
+}
 
 #define OPT_END() { \
 	.type = OPTION_END, \
@@ -276,6 +287,7 @@ struct option {
 #define OPT_CMDMODE(s, l, v, h, i)  OPT_CMDMODE_F(s, l, v, h, i, 0)
 
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
+#define OPT_UNSIGNED(s, l, v, h)    OPT_UNSIGNED_F(s, l, v, h, 0)
 #define OPT_MAGNITUDE(s, l, v, h) { \
 	.type = OPTION_MAGNITUDE, \
 	.short_name = (s), \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 46deb4317ef..0d559288d9c 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -120,7 +120,7 @@ int cmd__parse_options(int argc, const char **argv)
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
 	struct string_list list = STRING_LIST_INIT_NODUP;
-	uint16_t m16 = 0;
+	uint16_t m16 = 0, u16 = 0;
 	int16_t i16 = 0;
 
 	struct option options[] = {
@@ -142,6 +142,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
 		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
+		OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
 		OPT_MAGNITUDE(0, "m16", &m16, "get a 16 bit magnitude"),
@@ -215,6 +216,7 @@ int cmd__parse_options(int argc, const char **argv)
 	show(&expect, &ret, "boolean: %d", boolean);
 	show(&expect, &ret, "integer: %d", integer);
 	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
+	show(&expect, &ret, "u16: %"PRIuMAX, (uintmax_t) u16);
 	show(&expect, &ret, "magnitude: %lu", magnitude);
 	show(&expect, &ret, "m16: %"PRIuMAX, (uintmax_t) m16);
 	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 5f503b26cc8..9946e69f586 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -23,6 +23,7 @@ usage: test-tool parse-options <options>
     -i, --[no-]integer <n>
                           get a integer
     --[no-]i16 <n>        get a 16 bit integer
+    --[no-]u16 <n>        get a 16 bit unsigned integer
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
     --m16 <n>             get a 16 bit magnitude
@@ -139,6 +140,7 @@ cat >expect <<\EOF
 boolean: 2
 integer: 1729
 i16: 0
+u16: 0
 magnitude: 16384
 m16: 0
 timestamp: 0
@@ -161,6 +163,7 @@ cat >expect <<\EOF
 boolean: 2
 integer: 1729
 i16: 9000
+u16: 5432
 magnitude: 16384
 m16: 32768
 timestamp: 0
@@ -173,7 +176,7 @@ file: prefix/fi.le
 EOF
 
 test_expect_success 'long options' '
-	test-tool parse-options --boolean --integer 1729 --i16 9000 --magnitude 16k \
+	test-tool parse-options --boolean --integer 1729 --i16 9000 --u16 5432 --magnitude 16k \
 		--m16 32k --boolean --string2=321 --verbose --verbose --no-dry-run \
 		--abbrev=10 --file fi.le --obsolete \
 		>output 2>output.err &&
@@ -186,6 +189,7 @@ test_expect_success 'abbreviate to something longer than SHA1 length' '
 	boolean: 0
 	integer: 0
 	i16: 0
+	u16: 0
 	magnitude: 0
 	m16: 0
 	timestamp: 0
@@ -262,6 +266,7 @@ cat >expect <<\EOF
 boolean: 1
 integer: 13
 i16: 0
+u16: 0
 magnitude: 0
 m16: 0
 timestamp: 0
@@ -287,6 +292,7 @@ cat >expect <<\EOF
 boolean: 0
 integer: 2
 i16: 0
+u16: 0
 magnitude: 0
 m16: 0
 timestamp: 0
@@ -356,6 +362,7 @@ Callback: "four", 0
 boolean: 5
 integer: 4
 i16: 0
+u16: 0
 magnitude: 0
 m16: 0
 timestamp: 0
@@ -383,6 +390,7 @@ cat >expect <<\EOF
 boolean: 1
 integer: 23
 i16: 0
+u16: 0
 magnitude: 0
 m16: 0
 timestamp: 0
@@ -464,6 +472,7 @@ cat >expect <<\EOF
 boolean: 0
 integer: 0
 i16: 0
+u16: 0
 magnitude: 0
 m16: 0
 timestamp: 0
@@ -820,4 +829,11 @@ test_expect_success 'm16 limits range' '
 	test_grep "value 65536 for option .m16. exceeds 65535" err
 '
 
+test_expect_success 'u16 limits range' '
+	test-tool parse-options --u16 65535 >out &&
+	test_grep "u16: 65535" out &&
+	test_must_fail test-tool parse-options --u16 65536 2>err &&
+	test_grep "value 65536 for option .u16. exceeds 65535" err
+'
+
 test_done

-- 
2.49.0.805.g082f7c87e0.dirty

