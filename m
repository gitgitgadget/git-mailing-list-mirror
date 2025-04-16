Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED5D238153
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797754; cv=none; b=Y5eREM2KBINVmCOrUDncz2EdJ4O+TgNQEaekGzVDcLrNA2HTZEYmHXKAlRQZGnkmbT+63GSH4dIn1hBvHkHNpVL6eoleFSF1IpDB9UPmLRaFC1sZnS8164DPHMQKLUCjpkNuzK4Dp/CXzh/Ymqut+sgdh51SLLrLv6x5ZjlG1to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797754; c=relaxed/simple;
	bh=NTPOaKtCMGcslMSWT/7obdkeSNMaKkLjSPn2B4UKQ70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJjwiavbHGVIPnGQpLUwRFOgVhYPLmYrk/G9IyqM5joIHwHxD4gQaXGpfZspYK3jt9jhdhm+tK9BoIQZHcTqt1I5jNRioRCvZouXO3QU7VO+8rR3qzAmqQnB6Y9SE6HbCAbNJJbV5KD/6npy2BBG90z16kAUkRAcdfNqURXq/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UBVH/3MX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKC183w+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UBVH/3MX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKC183w+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BFDD1380198;
	Wed, 16 Apr 2025 06:02:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 06:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744797750;
	 x=1744884150; bh=X0flypOkb5u31lBuemid5c4Nr1z4rinZxjq0JmdZnNI=; b=
	UBVH/3MXARtma/7aoivwGnneHFBl6PLBbRFaPSUnWvG+7lYeFOGiMlWmMe0GDPWa
	VWS9IU+oQOK/WEgOqrSAOgsw80hvG4NRE4qhdxiqdTy+WD9Wgu70hkTRlbr5jRrG
	40TVVE4dtAxzeowQAhqeKjvw6EyNQQVzXyHYWD7urlYPo3Hm0g4fjIGsmJn9O5J4
	rPGX+a7e0x5TKEEArBVH3Ll51TOHEpNfqExTeOENK7TeE6VxZvjDKjuGR8EVPiUO
	6YhZC5hL8voPgv2EO6ZZ0OQG4otxY47NktyV9KSjT/D7XuFusEKxl5ygzhnRTwFa
	6ao1+MpgBJtJ4Js8mTZ6dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744797750; x=
	1744884150; bh=X0flypOkb5u31lBuemid5c4Nr1z4rinZxjq0JmdZnNI=; b=S
	KC183w+aZE5XMASLFdIXuadxB0uO/tubHpR5g3EFQ2GKnA3UM9cwOY87HM1qxOds
	tAn5XrSJKuiDEF0sGAzK+AJaasZjEIBkRVFoTG23/3o7wdgDz+06fQs+L7l0QSvh
	mxI4ueNv1MCg8FsiRvYT8lvS8h4YB86zM1lg1tPLJezAV397cZ8QjC3yXIu8SW1t
	GMGFl35vwigOAFTUcbtaeOJo/MERYz2XHAAIz50CpWcfrTzw+xHvkRPbUiIwveRJ
	5T/I7EgelEsQN1Tp5k14fjcaUUnyEwKlO9oPCv6VitLQkFPvhn0gWlh5pFm7l4zy
	VpKdng+ojS+bhVey/7g3A==
X-ME-Sender: <xms:NoD_Zy8Z4dYOM0I0PxcnFJyDurx9vhZC4XDUMyTy9mYoVZ0bCzjgCg>
    <xme:NoD_ZysPwvtOgpWAXfP4FPG6JY8w49wkuTEOVu5t3wbb_iQpl3vyLPEZYK7zpqVq7
    mZGg-9KN-D6f3exHg>
X-ME-Received: <xmr:NoD_Z4BvRcjj4ZHAqvv4rDpdkfiFrANIRwSyL9Jg9MukLPfMz_ruo6f-xG6vbHH4uiFHtfz94S9OUVI5KE8hJ0CpNXrm5DRZiMjKpw-jK2T7Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthho
    pehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvg
X-ME-Proxy: <xmx:NoD_Z6floLYcr317oqB3rwyebNSHANjTRRSDZ-82OoWyT3W79JEnSg>
    <xmx:NoD_Z3OWDRXtkchPevJZum4ewhEEaF5_DqJWr2gB0-nXCgjyyfSCMQ>
    <xmx:NoD_Z0n93hidReZL2NldOyb_Z2aBmWPp7717sL7myC_Rt70_BIHhZw>
    <xmx:NoD_Z5v_ai4SEDw5VpKW-6SXDc64tEeXjX81Y-2dfsp0WFZtm0WBuQ>
    <xmx:NoD_Z0gVHe8WfbvRySq0lM6MMW2aMx1VVBq0ZRmDtd4wmGUxNtijnA08>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:02:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 065044af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:02:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 12:02:14 +0200
Subject: [PATCH v3 5/7] parse-options: introduce `OPTION_UNSIGNED`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-parse-options-integers-v3-5-d390746bea79@pks.im>
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

We have two generic ways to parse integers in the "parse-options"
subsystem:

  - `OPTION_INTEGER` parses a signed integer.

  - `OPTION_MAGNITUDE` parses an unsigned integer, but it also
    interprets suffixes like "k" or "g".

Notably missing is a middle ground that parses unsigned integers without
interpreting suffixes. Introduce a new `OPTION_UNSIGNED` option type to
plug this gap. This option type will be used in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c               | 54 +++++++++++++++++++++++++++++++++++++++++++
 parse-options.h               | 12 ++++++++++
 t/helper/test-parse-options.c |  4 +++-
 t/t0040-parse-options.sh      | 24 ++++++++++++++++++-
 4 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 259716efb17..e4dc22464b2 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -222,6 +222,60 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
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
+		} else if (*arg == '-') {
+			return error(_("%s does not accept negative values"),
+				     optname(opt, flags));
+		} else {
+			errno = 0;
+			value = strtoumax(arg, (char **)&s, 10);
+			if (*s)
+				return error(_("%s expects a numerical value"),
+					     optname(opt, flags));
+			if (errno == ERANGE)
+				return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
+					     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
+			if (errno)
+				return error_errno(_("value %s for %s cannot be parsed"),
+						   arg, optname(opt, flags));
+
+		}
+
+		if (value > upper_bound)
+			return error(_("value %s for %s not in range [%"PRIuMAX",%"PRIuMAX"]"),
+				     arg, optname(opt, flags), (uintmax_t)0, (uintmax_t)upper_bound);
+
+		switch (opt->precision) {
+		case 1:
+			*(uint8_t *)opt->value = value;
+			return 0;
+		case 2:
+			*(uint16_t *)opt->value = value;
+			return 0;
+		case 4:
+			*(uint32_t *)opt->value = value;
+			return 0;
+		case 8:
+			*(uint64_t *)opt->value = value;
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
index 55c42faa29f..aa37134dc72 100644
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
index 8daaf568485..66875ce0586 100755
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
@@ -826,4 +835,17 @@ test_expect_success 'm16 limits range' '
 	test_grep "value 65536 for option .m16. not in range \[0,65535\]" err
 '
 
+test_expect_success 'u16 limits range' '
+	test-tool parse-options --u16 65535 >out &&
+	test_grep "u16: 65535" out &&
+	test_must_fail test-tool parse-options --u16 65536 2>err &&
+	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
+'
+
+test_expect_success 'u16 does not accept negative value' '
+	test_must_fail test-tool parse-options --u16 -1 >out 2>err &&
+	test_grep "option .u16. does not accept negative values" err &&
+	test_must_be_empty out
+'
+
 test_done

-- 
2.49.0.805.g082f7c87e0.dirty

