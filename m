Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8023BCFD
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797753; cv=none; b=YvrZ62hIkrq0VossyeyOGRlDD8B1H2b9RL4T+yf2l3ML+tg9aHmpKwWnVFhhZbNvuQA9HYeQ6HpKQBmM8o/FRbiorQAJAsV8pit98SCKx6hxuI7+7ZiJJP6qWqhCbip4XApBLk/2BRGT1EzRgC1HXYuzRfc45tR43V/kowmPFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797753; c=relaxed/simple;
	bh=DWFzKPMh/iozpLmckl5wVvy/NkUHtIsdjVLqJM8l5lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLML4RTmoZSIpc9i3aS1JZcIui4tmrG1qV9Ss0Hl5KsYkbaptHr5+vsiSpM0WBY/rFXtHwOzrmTHLglfy5+QpxkcJh4HVelsesG4o00M9ILVsd/CU8hjVBHPaS4bvR0sVtTeJUIMJDDb16r3mjce8adrDVuXbw/Mgd9lwRLl11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H9IfI0Hs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rEAXBqpB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H9IfI0Hs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rEAXBqpB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56B581140102;
	Wed, 16 Apr 2025 06:02:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 06:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744797750;
	 x=1744884150; bh=et4S9Kzmlk6L8G9TnDjZZFrJkYovtwHP2u0Lh6hXm0g=; b=
	H9IfI0HsIom/nyFTTJwRqkpsJ2POfCsslcyGjw7Cyf1/tqWGuJIg3PbkE6yeMzs+
	tJ7BX4FRLE6RpMHpTOQShV4fI0cLwJjVBkYgMOT5q7Dqb6rXvYnsYm5ofyDY2uXa
	Oj2vMLpizc8NCC4y/w1PKeLQnAYGE2wj+bQ7ptRQ/pHxsc0n2BkxTMkyWwjQb857
	BKl7LYNbH4tLSY37Ghk/5tuEA4sfqJsQeFnUQ+ddRzxg/CVg0ceGOh9RSAHbPAq8
	rJ9mlqDmLI+FJxTWvmYWNmjXBn07sdZbF7Xg8KvusAqELdl+hXpglL8d5r4s+OC1
	afbpxy6v/Jhtnb76of6tyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744797750; x=
	1744884150; bh=et4S9Kzmlk6L8G9TnDjZZFrJkYovtwHP2u0Lh6hXm0g=; b=r
	EAXBqpBd/Igs6M7UWhXfJnoUc2/CXRjYga+CEU9Ki6xp3lhvCEuMTcqyAnu2GJTT
	WrNpxMG0odWQjHjobXJu085EkjTqZpgK1D9Im9/ZepcsVI9pPuR9tlcFjKKC3fKA
	aGBCWhsLugb7avTqjSxkePZi3X8LFkQz8pIunZR8vXN7QW3Hf0hSolWMV51ZfpJm
	ubgX3SYCji50y1FAgPkoPsPWP3nyBMA5rCtCXNpokDHCBL+vkTsvK6RE17cvIVma
	+7pM8X8y8aOBqWlJDRj0WMUjxrzXxtZUTr7EL7aw8bvcF3YDeaX3UXX9r76aFHMt
	2TVarUsPnjHw9K8orgsAw==
X-ME-Sender: <xms:NoD_Z0COmBDKZX6hofEcv3g6VTti0UxGqpRCM7fbhTABFFYcv9_uAg>
    <xme:NoD_Z2gtuAv3QSrw_YlH1E9CbjQ-QB2famQw021wBhkigqLwOZCXueGrqmpFyiCFE
    lLsv4LVfa89ZNj9lA>
X-ME-Received: <xmr:NoD_Z3kdd3kbh1s1AYh4Jj3NTR6EcQf3mpvaYLnQ6836Uug6vVmF7wNgy5IBL0nBTM_fc2HuDJSU2NJgk5QdQcFCqjqoKigvU6dksgWcW6Y53A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtph
    htthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvth
X-ME-Proxy: <xmx:NoD_Z6yuoRo71e6ADZa8RMShNx0cny75vw2HpmW6kZy1gFXvdLQzgg>
    <xmx:NoD_Z5SrmQRd67vbe85QtVLjVx0y7RMdzUMCmqxuhk2k71bNU6gNOQ>
    <xmx:NoD_Z1ai6wrAUGc2sCoI23eedHJf98kISSNNu6WUuwnmqTRTkitctg>
    <xmx:NoD_ZyT0EgiiR6Ji8JjNyjqLozH7mm_x6MsgaTleCS7g1-HDQL8s7Q>
    <xmx:NoD_ZxmmP6wL2dfFb6_cvyYf8Cny6Sp90P_e5C1JtKIjdLwNeoZJFpHn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:02:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a62737c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:02:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 12:02:13 +0200
Subject: [PATCH v3 4/7] parse-options: introduce precision handling for
 `OPTION_MAGNITUDE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-parse-options-integers-v3-4-d390746bea79@pks.im>
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

This commit is the equivalent to the preceding commit, but instead of
introducing precision handling for `OPTION_INTEGER` we introduce it for
`OPTION_MAGNITUDE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c               | 45 ++++++++++++++++++++++++++++++++-----------
 parse-options.h               |  1 +
 t/helper/test-parse-options.c |  3 +++
 t/t0040-parse-options.sh      | 18 ++++++++++++++++-
 4 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 2cb9bd3b5b9..259716efb17 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -202,7 +202,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 
 		if (value < lower_bound || value > upper_bound)
 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
-				     arg, optname(opt, flags), lower_bound, upper_bound);
+				     arg, optname(opt, flags), (intmax_t)lower_bound, (intmax_t)upper_bound);
 
 		switch (opt->precision) {
 		case 1:
@@ -223,21 +223,44 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		}
 	}
 	case OPTION_MAGNITUDE:
+	{
+		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
+		unsigned long value;
+
 		if (unset) {
-			*(unsigned long *)opt->value = 0;
-			return 0;
-		}
-		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
-			*(unsigned long *)opt->value = opt->defval;
-			return 0;
-		}
-		if (get_arg(p, opt, flags, &arg))
+			value = 0;
+		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			value = opt->defval;
+		} else if (get_arg(p, opt, flags, &arg)) {
 			return -1;
-		if (!git_parse_ulong(arg, opt->value))
+		} else if (!git_parse_ulong(arg, &value)) {
 			return error(_("%s expects a non-negative integer value"
 				       " with an optional k/m/g suffix"),
 				     optname(opt, flags));
-		return 0;
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
 
 	default:
 		BUG("opt->type %d should not happen", opt->type);
diff --git a/parse-options.h b/parse-options.h
index 8db96402c4d..55c42faa29f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -281,6 +281,7 @@ struct option {
 	.short_name = (s), \
 	.long_name = (l), \
 	.value = (v), \
+	.precision = sizeof(*v), \
 	.argh = N_("n"), \
 	.help = (h), \
 	.flags = PARSE_OPT_NONEG, \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index b1275dfade4..46deb4317ef 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -120,6 +120,7 @@ int cmd__parse_options(int argc, const char **argv)
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
 	struct string_list list = STRING_LIST_INIT_NODUP;
+	uint16_t m16 = 0;
 	int16_t i16 = 0;
 
 	struct option options[] = {
@@ -143,6 +144,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
+		OPT_MAGNITUDE(0, "m16", &m16, "get a 16 bit magnitude"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
 		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
@@ -214,6 +216,7 @@ int cmd__parse_options(int argc, const char **argv)
 	show(&expect, &ret, "integer: %d", integer);
 	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
 	show(&expect, &ret, "magnitude: %lu", magnitude);
+	show(&expect, &ret, "m16: %"PRIuMAX, (uintmax_t) m16);
 	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
 	show(&expect, &ret, "abbrev: %d", abbrev);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 95951436cda..8daaf568485 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -25,6 +25,7 @@ usage: test-tool parse-options <options>
     --[no-]i16 <n>        get a 16 bit integer
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
+    --m16 <n>             get a 16 bit magnitude
     --[no-]set23          set integer to 23
     --mode1               set integer to 1 (cmdmode option)
     --mode2               set integer to 2 (cmdmode option)
@@ -139,6 +140,7 @@ boolean: 2
 integer: 1729
 i16: 0
 magnitude: 16384
+m16: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -160,6 +162,7 @@ boolean: 2
 integer: 1729
 i16: 9000
 magnitude: 16384
+m16: 32768
 timestamp: 0
 string: 321
 abbrev: 10
@@ -171,7 +174,7 @@ EOF
 
 test_expect_success 'long options' '
 	test-tool parse-options --boolean --integer 1729 --i16 9000 --magnitude 16k \
-		--boolean --string2=321 --verbose --verbose --no-dry-run \
+		--m16 32k --boolean --string2=321 --verbose --verbose --no-dry-run \
 		--abbrev=10 --file fi.le --obsolete \
 		>output 2>output.err &&
 	test_must_be_empty output.err &&
@@ -184,6 +187,7 @@ test_expect_success 'abbreviate to something longer than SHA1 length' '
 	integer: 0
 	i16: 0
 	magnitude: 0
+	m16: 0
 	timestamp: 0
 	string: (not set)
 	abbrev: 100
@@ -259,6 +263,7 @@ boolean: 1
 integer: 13
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -283,6 +288,7 @@ boolean: 0
 integer: 2
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -351,6 +357,7 @@ boolean: 5
 integer: 4
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -377,6 +384,7 @@ boolean: 1
 integer: 23
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -457,6 +465,7 @@ boolean: 0
 integer: 0
 i16: 0
 magnitude: 0
+m16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -810,4 +819,11 @@ test_expect_success 'i16 limits range' '
 	test_grep "value -32769 for option .i16. not in range \[-32768,32767\]" err
 '
 
+test_expect_success 'm16 limits range' '
+	test-tool parse-options --m16 65535 >out &&
+	test_grep "m16: 65535" out &&
+	test_must_fail test-tool parse-options --m16 65536 2>err &&
+	test_grep "value 65536 for option .m16. not in range \[0,65535\]" err
+'
+
 test_done

-- 
2.49.0.805.g082f7c87e0.dirty

