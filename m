Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73E339A1
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519700; cv=none; b=OubY5GHfB63hME9P+6vJTG+Ld+NfFlwLtmvBmlV4WSzIa30a81MmDLfc8Kki2CvDoDiAXg/wfQtPvGKttpJokyX4dtOpav9aJc3VaNkC70sHrKx/2bPTXCzjiiMQ8o824xjizzz+8WhjHK2+6ZBPPURkbAYIv0tg2ik3lzOCGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519700; c=relaxed/simple;
	bh=ZGeTSjroKGU18mROQJXClWNfgsRk/KJxkioMGPedMX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWlV5EFiGvKZuBuTqb3lUW3gDeiyOjsX8SXuDEFJ8uxbpX9N0ueH2J2QpuuuTwjpVg0Vvp2qDIeZG+9+wU/1StC1ZruaFtEMw8FBZR9P08e61+1fqLPkcUHNlqQztylhaWgeKYU1WrmpM3RHiq3+FadzD8GpjP/uMLfVFHRM04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aNxn1WNQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDeKQPBK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aNxn1WNQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDeKQPBK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2C00114022C;
	Tue,  1 Apr 2025 11:01:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 01 Apr 2025 11:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743519697;
	 x=1743606097; bh=kAex0Dy5mrlPJfBjFYXvyc1Hxci0zpb9UnlB9VpNgI8=; b=
	aNxn1WNQz6slGfdq5PvZrabXx9LXYNo/8//Ri2VmPMmTlswa90PfAiKdyCe+R1tx
	ClJpHivG311dJ1tATB9/JdhvNqBG8/TwHlhmfe3q/vozQT+rdLppyNKZxv6XLDCU
	3Xjm6Jh3l4ebvWgPBfRdyFLz4soP2If04LLggP3HloFCnjrmS2C05F/1gKLdxHS7
	e6xlODQUoaFYPLt3LAGQF1HSiiypPHOECIffVcGRCbIw/BkgxS4NgUSR80iXkEQo
	dFvFVNoHTVBBymhiCNqc/B8iwemEDi8kgbVaBIVlZ55bx+RWGOtwTJprIrxPekAg
	FkY2UGn7se+7bxUMc7psyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743519697; x=
	1743606097; bh=kAex0Dy5mrlPJfBjFYXvyc1Hxci0zpb9UnlB9VpNgI8=; b=X
	DeKQPBKAlhk6lXtv9Iss5FfK/JTe4dzbRYa0Gb+ngwPbAIGDrMkH9bQEbPCBFOSd
	HIsN0ZvM2YPlodyANKT7HAcMiUqn3GnKmy0lC2ii6h5SiCpJW712ON7/nnp05dZx
	fI1tID0NvdkYQQKXVuG0ohLkSzQX+9McfGjrqfOvGbRbcPum5GyAUPhpwd7UK2vT
	IyZUVXeNlM6K7ThshEDbZc6lci0fMmvhSEgYkRYf1W7PXdj50I2P+OhuDuxabXQ3
	auZgo/0iYoLgjdbPaCtsGqUoe5dUlL0IDWKxRKWmyXhZH4P0k+Wq6Z7LsPwDAPD3
	rhCU/ziN39tfr6R9fTWdQ==
X-ME-Sender: <xms:0f_rZ5XsPB0QbPb08k_5-F1c2YRFa6Ei7lfmL8d_6GlMJ0rD0bFKzQ>
    <xme:0f_rZ5m10MZbLI3h7BG1uf_cROmGnWAsGUy0VpLI5YDVRhGRDTCBgERtBL5ZfneUs
    0Ev5NqWZgy6_5IUHg>
X-ME-Received: <xmr:0f_rZ1YgcTgxR9kV-hue7eZPqCOWSCF-WLCQLDVHKFVkEdmhDqjeQ0h-XPTF421Zqd7KMAOoid89ZHFCfgoIxN8DMkBSit0xXwCcsYolDkFQmjc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehtmhiisehpohgsohigrdgtoh
    hmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfh
    huqdgsvghrlhhinhdruggv
X-ME-Proxy: <xmx:0f_rZ8V0Y1OPTtBz7tPa9ur_d7vXuUqFx95RKr-Yl6d7_cYmT2O5LA>
    <xmx:0f_rZzl6IZTo83GmXCXYepTChl8ETbz3MZnMRbZkF1jsvyPBR6o7Jw>
    <xmx:0f_rZ5fcgsEZ6d8R1fkwl-9wMZFf_Y2IXnjM-4k23dSitficDuTueQ>
    <xmx:0f_rZ9EnubYjR1hKFpqYcVJHxP2tikfuR5ICgfpQzzgrWQfwTt-jnA>
    <xmx:0f_rZxXYJricuITsidjYK62xghsgU68Je6FWQzSfYH4OpuisSnJTDqTl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 11:01:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f01c08f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Apr 2025 15:01:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Apr 2025 17:01:18 +0200
Subject: [PATCH 3/5] parse-options: introduce precision handling for
 `OPTION_MAGNITUDE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-b4-pks-parse-options-integers-v1-3-a628ad40c3b4@pks.im>
References: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
In-Reply-To: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
To: git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

This commit is the equivalent to the preceding commit, but instead of
introducing precision handling for `OPTION_INTEGER` we introduce it for
`OPTION_MAGNITUDE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c               | 50 ++++++++++++++++++++++++++++++++++---------
 parse-options.h               |  1 +
 t/helper/test-parse-options.c |  3 +++
 t/t0040-parse-options.sh      | 18 +++++++++++++++-
 4 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index dbda9b7cfe7..3954ee0e570 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -217,21 +217,51 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		}
 	}
 	case OPTION_MAGNITUDE:
+	{
+		uintmax_t upper_bound = 0;
+		unsigned long value;
+
+		/*
+		 * It's stupid, but the obvious way of calculating the upper
+		 * bound via `2 ^ n - 1` overflows.
+		 */
+		for (size_t i = 0; i < opt->precision * 8; i++)
+			upper_bound |= ((uintmax_t) 1 << i);
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
+			return error(_("value %"PRIuMAX" for %s exceeds %"PRIuMAX),
+				     (uintmax_t) value, optname(opt, flags), upper_bound);
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
index 8d5f9c95f9c..4b561679581 100644
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
index e3ca7a27738..5f503b26cc8 100755
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
@@ -804,4 +813,11 @@ test_expect_success 'i16 limits range' '
 	test_grep "value -32769 for option .i16. not in range \[-32768,32767\]" err
 '
 
+test_expect_success 'm16 limits range' '
+	test-tool parse-options --m16 65535 >out &&
+	test_grep "m16: 65535" out &&
+	test_must_fail test-tool parse-options --m16 65536 2>err &&
+	test_grep "value 65536 for option .m16. exceeds 65535" err
+'
+
 test_done

-- 
2.49.0.604.gff1f9ca942.dirty

