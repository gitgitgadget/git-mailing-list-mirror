Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C09232792
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886997; cv=none; b=NMgLdSnoJMdqPVyugXaNd+c27AjbwH4Ha/ntlpqc1be/sOf2rASGLMlWa4588G2x3Rffmc9oVV+QBSueMpRGBQJiSzTX1GfmrS8RjYD0kS/Ki4jy9PEulEOtUwZMs/PfY99ejM691CeCZMhFLahUPNp50KwU///7r75tfTwdB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886997; c=relaxed/simple;
	bh=zM97Hc2kPM2IiRME5R1znM/N/HIAqzLB18+2YfRlciM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjCQP9FQCAxjQ5rmCmB07bLy3mJoaXEEBLMQSJ3Vulavwai+htwrIDOe989dy4kBUyy+jM5sW+J5AUfGWLdyuSicVJd3h0hG+UOIxKGAMlLJ9MAgirR+Q5dD+FvhfrGAh7BDA7khLtpCg0/I1rn4dm2lG5HR4KrsEVrWYLYnlpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aARJZtM1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GwBe/8gN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aARJZtM1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GwBe/8gN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 34D8811401A6;
	Thu, 17 Apr 2025 06:49:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 17 Apr 2025 06:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744886994;
	 x=1744973394; bh=KXOAkrdrztEL5M6NQjuxQfoKD8g5SwR555IjU7j5thc=; b=
	aARJZtM1B+0oN7EyFX7eiP5mMqIXVk9N6KBlzj02Zsd9EugPjtr2TZg5Z2k1loPv
	B3tKNojSYAL4dQ5vWfy9cO7AtrEvrLNZv0FJLzLkcxlZ1qAH4b5CULy+hl4e3A+D
	asi7odOj3EvjPIN63gUTa73V76HPyKcWJ7w8/JUlOiWQAmhXhdgbZuaG93es4QJb
	cn091/e7jTyH4yE1teHmIUtXskBER0s88KF1ik3hwVkRIfdqO7Hzj81aZf+hUPIK
	AWViCeV7yaFy5yP8AMbfMODPOzAMxUD415oeJP8huiu51+u6C28kV7u+Q7ZT0h6o
	fsZgd/yazdwnWswk675sfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744886994; x=
	1744973394; bh=KXOAkrdrztEL5M6NQjuxQfoKD8g5SwR555IjU7j5thc=; b=G
	wBe/8gN7EIf2R9va80gntd77lw6IsQlNuuAu6gSVeslqYFx7ogCk6ONVCltQeYlC
	BIDv1v3reKOT276c2IP+/myee38lKZPZmFqee+rO+uJbTd21E0qGjWIhOg8X4IIJ
	9dZFO51E8nEEIgXHp7jm8uWB7F/8h3KCzdaHT/8PMarVw2kHs/WKAuUa68hqtXAB
	8twCh8XBO4VyL8wm4uGjtL5Wx7E+ndk52kB+Sz+gM471onOV5J9Yb5Ohrp71hkkq
	AigYd44pvPyfucw5ArIbQE5fXCXYrj4uvYjmea8wUSBK4lIm+pvkMdGYRbhzK13b
	vRYOeVFKvkwukcF+b9DhA==
X-ME-Sender: <xms:0dwAaBFyt17AIao8AcMroTGHM2Kb-d-uIo1_YCOTF13jhsqiB0npcQ>
    <xme:0dwAaGXzOFJ-7EV5mLAzARhDCx992yZ9Vg5HgTecBAfCGxEJ0gDSj7Q5ZBCKVoKGU
    Lofn2XcY4EAYMbGrA>
X-ME-Received: <xmr:0dwAaDK4aBuWz3XWcNvKhCD7V2eyA5XxwL0WxBhBTR9D-5LYn84fa63HpTBRJXxitYFDlBJm-bvar0GGpmtavm1cUB_mDCsMPva1GHmEwW7hbBt5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgv
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehglhgruh
    gsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvg
X-ME-Proxy: <xmx:0dwAaHHFDjBuZzvVjyraV4szRE8KonW0eUD7fNJG53YU8Y9KuY56QA>
    <xmx:0dwAaHVbHfp9bA2SJeXzFFI1_DuS6H3jWNc5PFQdeppVwtqrqg1e_w>
    <xmx:0dwAaCOrbSV26-jhj_JdNtM_I0oC3REU-7vk2a1iQE0kdfP7b9Oncg>
    <xmx:0dwAaG3hVAihxinSdK3QgU-fs1NizjN3IfDy_1Rkqzm4-Xt6x-69Xg>
    <xmx:0twAaKr19fogywdiVxoA2rj-rPczui7mOlGCeJz481vw96Tn6WrjXqU_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 06:49:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b30cbba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 10:49:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Apr 2025 12:49:41 +0200
Subject: [PATCH v4 6/7] parse-options: introduce precision handling for
 `OPTION_UNSIGNED`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-b4-pks-parse-options-integers-v4-6-9cbc76b61cfe@pks.im>
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

This commit is the equivalent to the preceding commit, but instead of
introducing precision handling for `OPTION_INTEGER` we introduce it for
`OPTION_UNSIGNED`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c               | 48 +++++++++++++++++++++++++++++++++----------
 parse-options.h               |  1 +
 parse.c                       |  2 +-
 parse.h                       |  1 +
 t/helper/test-parse-options.c |  3 +++
 t/t0040-parse-options.sh      | 18 +++++++++++++++-
 6 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 768718a3972..a9a39ecaef6 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -197,7 +197,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 
 		if (value < lower_bound)
 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
-				     arg, optname(opt, flags), lower_bound, upper_bound);
+				     arg, optname(opt, flags), (intmax_t)lower_bound, (intmax_t)upper_bound);
 
 		switch (opt->precision) {
 		case 1:
@@ -218,21 +218,47 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		}
 	}
 	case OPTION_UNSIGNED:
+	{
+		uintmax_t upper_bound = UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR_BIT * opt->precision);
+		uintmax_t value;
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
+		} else if (!*arg) {
+			return error(_("%s expects a numerical value"),
+				     optname(opt, flags));
+		} else if (!git_parse_unsigned(arg, &value, upper_bound)) {
+			if (errno == ERANGE)
+				return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
+					     arg, optname(opt, flags), (uintmax_t) 0, upper_bound);
+
 			return error(_("%s expects a non-negative integer value"
 				       " with an optional k/m/g suffix"),
 				     optname(opt, flags));
-		return 0;
+		}
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
index 4c430c7273c..dc460a26ff1 100644
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
diff --git a/parse.c b/parse.c
index 3c47448ca67..48313571aab 100644
--- a/parse.c
+++ b/parse.c
@@ -51,7 +51,7 @@ int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 	return 0;
 }
 
-static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
+int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 {
 	if (value && *value) {
 		char *end;
diff --git a/parse.h b/parse.h
index 6bb9a54d9ac..ea32de9a91f 100644
--- a/parse.h
+++ b/parse.h
@@ -2,6 +2,7 @@
 #define PARSE_H
 
 int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
+int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
 int git_parse_int(const char *value, int *ret);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 3689aee8315..f2663dd0c07 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -120,6 +120,7 @@ int cmd__parse_options(int argc, const char **argv)
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
 	struct string_list list = STRING_LIST_INIT_NODUP;
+	uint16_t u16 = 0;
 	int16_t i16 = 0;
 
 	struct option options[] = {
@@ -143,6 +144,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_UNSIGNED('u', "unsigned", &unsigned_integer, "get an unsigned integer"),
+		OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integer"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
 		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
@@ -214,6 +216,7 @@ int cmd__parse_options(int argc, const char **argv)
 	show(&expect, &ret, "integer: %d", integer);
 	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
 	show(&expect, &ret, "unsigned: %lu", unsigned_integer);
+	show(&expect, &ret, "u16: %"PRIuMAX, (uintmax_t) u16);
 	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
 	show(&expect, &ret, "abbrev: %d", abbrev);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index be785547ead..ca55ea8228c 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -25,6 +25,7 @@ usage: test-tool parse-options <options>
     --[no-]i16 <n>        get a 16 bit integer
     -j <n>                get a integer, too
     -u, --unsigned <n>    get an unsigned integer
+    --u16 <n>             get a 16 bit unsigned integer
     --[no-]set23          set integer to 23
     --mode1               set integer to 1 (cmdmode option)
     --mode2               set integer to 2 (cmdmode option)
@@ -141,6 +142,7 @@ boolean: 2
 integer: 1729
 i16: 0
 unsigned: 16384
+u16: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -162,6 +164,7 @@ boolean: 2
 integer: 1729
 i16: 9000
 unsigned: 16384
+u16: 32768
 timestamp: 0
 string: 321
 abbrev: 10
@@ -173,7 +176,7 @@ EOF
 
 test_expect_success 'long options' '
 	test-tool parse-options --boolean --integer 1729 --i16 9000 --unsigned 16k \
-		--boolean --string2=321 --verbose --verbose --no-dry-run \
+		--u16 32k --boolean --string2=321 --verbose --verbose --no-dry-run \
 		--abbrev=10 --file fi.le --obsolete \
 		>output 2>output.err &&
 	test_must_be_empty output.err &&
@@ -186,6 +189,7 @@ test_expect_success 'abbreviate to something longer than SHA1 length' '
 	integer: 0
 	i16: 0
 	unsigned: 0
+	u16: 0
 	timestamp: 0
 	string: (not set)
 	abbrev: 100
@@ -261,6 +265,7 @@ boolean: 1
 integer: 13
 i16: 0
 unsigned: 0
+u16: 0
 timestamp: 0
 string: 123
 abbrev: 7
@@ -285,6 +290,7 @@ boolean: 0
 integer: 2
 i16: 0
 unsigned: 0
+u16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -353,6 +359,7 @@ boolean: 5
 integer: 4
 i16: 0
 unsigned: 0
+u16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -379,6 +386,7 @@ boolean: 1
 integer: 23
 i16: 0
 unsigned: 0
+u16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -459,6 +467,7 @@ boolean: 0
 integer: 0
 i16: 0
 unsigned: 0
+u16: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
@@ -806,4 +815,11 @@ test_expect_success 'i16 limits range' '
 	test_grep "value -32769 for option .i16. not in range \[-32768,32767\]" err
 '
 
+test_expect_success 'u16 limits range' '
+	test-tool parse-options --u16 65535 >out &&
+	test_grep "u16: 65535" out &&
+	test_must_fail test-tool parse-options --u16 65536 2>err &&
+	test_grep "value 65536 for option .u16. not in range \[0,65535\]" err
+'
+
 test_done

-- 
2.49.0.805.g082f7c87e0.dirty

