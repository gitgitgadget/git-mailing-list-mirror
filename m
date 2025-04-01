Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942F2054ED
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519702; cv=none; b=n92shHDj44SyTgrXYGt0p4mO6L7ZSJCm/KTdb6Y7g/CcQNwt6AEl2J2M8lgc77cnFWsGCSt/Hj+vNXlI6IDGSOk2wbKXJzEGzYFAnoSyDibLHM95uxiNUWlO3RnkHrUTA4iB3oBecs9bFGkTkdAqShpCY4WpjpNGMvsYlN2q5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519702; c=relaxed/simple;
	bh=3h8puqS1/eeMNSDVNrSFv4o0l7RwYo1DKfoX+hvJkaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSXwRlwL8EBKrz9e2hWkGAG2WVPNvkjcJEbNT9yaUntYM8bv5PBjI/CSLUp7CSX/hsbkvF3HywSoEoUQbRqnNstFqtWQTR/xkO9xCJJgZDNkArVST9MtyppLSS/PALQAKKLREV4pg9KKmOCHWni6OHDeNffbtL+xy5TDnAgIJn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SLLbuphK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B59yprci; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SLLbuphK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B59yprci"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 668C41140236;
	Tue,  1 Apr 2025 11:01:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 01 Apr 2025 11:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743519699;
	 x=1743606099; bh=q1GaeSo1OPJk0lU5HXJPnJ3HKlNGsegXj4FT6IjXdQU=; b=
	SLLbuphKtPYsD4d9fmnVZCO7ZzNgQBNdWBpNABYFJEJDJJEfZHqdBhFNs+GIJWG7
	aQhbm/a/rpRe5eGStM9Gq9cUTZKKfODIOPoPJC5ha6oMUKwz9aspAXv1kjPx/A7U
	It1FdH4skOZ92YJFlsu44tjKn7QdCCYrxSxGWDYjWzHETjBIJRGu13HevftRHjfm
	kcIH7R2D9p9+ApSSJCZn/R6LZhG+3h8tFhV0Q2nx/XaqHzgfnUuCisphnk8VfnCe
	zZglceoKfG+lhW45E50Gd0bpzyVGLvJ1XiHAVyBZFLCJhel2y5+vapRlS2973q0J
	jNM5xkghKl0Cyqlw8nnSDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743519699; x=
	1743606099; bh=q1GaeSo1OPJk0lU5HXJPnJ3HKlNGsegXj4FT6IjXdQU=; b=B
	59yprcihOskX13PGgj96NSlzIUSbD0hAvyvGAyNTKbqnsYIiDIoAYgiurqtkWWZm
	hEzzBqDL9Qx3A50/OR9jaLZaFFTuiDqbZaxvHmK+ON8fGBUQk7aQOmyhy7A0/Sfy
	MfZRNVfHaDjv8gQxNAFewaAGVnWYtyL2052kQsCQG5TE2TAOqFvjuHeGI7jOpCQ2
	FPHi9HTK/qh05ruCbM/Cnx7VnL/+vcTAJUeaP5egg9j02+3IpwOIFBTN+EyzVwlA
	n8Knf9lw3O1ByIWhnmQ1tlnEyoSgs3ekdcE2LMs+ioyGtnz4F6JlHWnZUGegrijt
	cvx20F6iYN/6kigaJRSdg==
X-ME-Sender: <xms:0__rZ4NDhdqtbwtTaIniwSuQT1a3peVevNXyCWjjq68N_chG9K5qKg>
    <xme:0__rZ--MH-QDZkQRG1Ol2rfrnxesi8fG9Inl_BcxN3WmcPBDllhhWciJ4hfdc55iS
    k4mqFohcOTR8odYJw>
X-ME-Received: <xmr:0__rZ_QTwp_BdOCpYf4NQ66amkr5zMPh-58CyHG-sLZvMn8ScIibGVnmbuU3ft7ymXBZrTcU3UzZg1fNpwpMHnchtmWsOjy9e9a1J8OXQQTRB6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehl
    rdhsrdhrseifvggsrdguvgdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfh
    huqdgsvghrlhhinhdruggv
X-ME-Proxy: <xmx:0__rZwsjY6WPdwDaHwml-b4ahvwrcPhPNtA-8nLdTfXKYVVDEhrGSA>
    <xmx:0__rZweSGZE1uyltk0Mlp4dZ9Zz5YQEKd-sVcH6AJloxkjy-JRQlRQ>
    <xmx:0__rZ00TcPJER_7i_8FMAuRY1aROEGtn1enkSFIk-pPaKA8u0sqSzA>
    <xmx:0__rZ0_3qO4O5v7-Und6j0ySKJuQYAKkD8GUhD9JbByLoFeQOqyRFg>
    <xmx:0__rZ-sw0plTCFAaJpYBee-un1MSK_6CsrteEjM9_s6bVpPJBDLoLf5O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 11:01:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4cf7cf03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Apr 2025 15:01:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Apr 2025 17:01:19 +0200
Subject: [PATCH 4/5] parse-options: introduce `OPTION_UNSIGNED`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-b4-pks-parse-options-integers-v1-4-a628ad40c3b4@pks.im>
References: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
In-Reply-To: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
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
 parse-options.c               | 50 +++++++++++++++++++++++++++++++++++++++++++
 parse-options.h               | 12 +++++++++++
 t/helper/test-parse-options.c |  4 +++-
 t/t0040-parse-options.sh      | 18 +++++++++++++++-
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 3954ee0e570..fcc415b43fb 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -216,6 +216,56 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 			    optname(opt, flags));
 		}
 	}
+	case OPTION_UNSIGNED:
+	{
+		uintmax_t upper_bound = 0;
+		uintmax_t value;
+
+		/*
+		 * It's stupid, but the obvious way of calculating the upper
+		 * bound via `2 ^ n - 1` overflows.
+		 */
+		for (size_t i = 0; i < opt->precision * 8; i++)
+			upper_bound |= ((uintmax_t) 1 << i);
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
 		uintmax_t upper_bound = 0;
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
2.49.0.604.gff1f9ca942.dirty

