Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2923315F
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797751; cv=none; b=uIzQH+B0g0pxbFF+BNnWi7AvZcR47DwHi7ejKl0/b+i9m6I+2ou+Hsc5ViZG/H1vxyKRCZUIHlwmkAxgJXMADqm+/GBS8Mg7rMaZMudP/6J52K+QvD3S6V7lT1qnNO3yXSgV/P2cOEDRr4mIlegaTfEwJp+qEXWck8mAoTsGzUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797751; c=relaxed/simple;
	bh=X52QNf6dbTU5OV8bZx0IJ3q9QIyGl81wL5E3yumdarE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gs/swYFC5OxjNfo4QfNp1qSUps9o610ySL/Gp3bs4lBtfo4FO3nzFvVC/8vnGvyYgD67amZjGFNQQfBnRU5Oi5Nb0SBTGr0LyYhitXvbaI7mJdHERTeU6gyYGyStBP8U6Ilq0io3DZtwFvWyTfDBbQ5wu6YYNNwYGyZxIyZsGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p74Oc40q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpgdpixP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p74Oc40q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpgdpixP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BAE1211400FE;
	Wed, 16 Apr 2025 06:02:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 06:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744797748;
	 x=1744884148; bh=hR3ek4FdtgdKdX+D35Uqr/VegY1XzVUfhO/Caooe/Kw=; b=
	p74Oc40qHVTb8pst37lq5cGyqQESC89qVbWXo2NUSFYgfug5SWWIGh+75ss78eNf
	I9HZSiHAMkiSU424yJeLVPFV245rWXMcV2tw8tlfnBprCpRY/4dQVtefmWgNmSr3
	ILxMJgAP4zBj0TV7tlHuTwvzFYYwTBGYaFijw3PeFYVuduBedzvg67Wh1KHDvfwr
	N7XDlyY0JP/WNy3EBt21HqVni30zN6O29EEK8yoLIzKfR7sG7JZunLzMG8UaKzTE
	arefvJydHL4020zM8KHRyUmRTHhDKLO3d0RGizNeNyEedkkojMuGmf7iBMV6qgHF
	+anzZ3B85ToVLL4vmMwAYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744797748; x=
	1744884148; bh=hR3ek4FdtgdKdX+D35Uqr/VegY1XzVUfhO/Caooe/Kw=; b=h
	pgdpixPQ4ru/ZTv0VmE18yBf+dwUSmE2a0C8YpeFAugbMlmggbi7hgyqrlhpUUHm
	dxeU1lfj2BfyxonSqG8i+7thxF5LDoRnm12Omi4CL4/r92EBmVX+VKZpkBLv+ITB
	uyntxepiCDP7lCEDc4h2f9vGpx5p3xIVTljNMqvscs56C6+oiWwpp7L6aibFvzqD
	0dCRJqEBt8cOZOCp9DeBP53PCzia3FF/pp3bQjbnV84U6ALQ2OPhWwk6rPjv9m5L
	etYlFFlZZgVtSwbQTQFIE36XWM6j7nWgHDrhzgmqWy2Hxko6XuJEGGf7642jVUi4
	iXEQEMC27qau8AlOtgeFQ==
X-ME-Sender: <xms:NID_Z-kExO048KqWkBdsmiCbO6NRlPHt7LB0XGWsNaBQUwZkl86bUg>
    <xme:NID_Z12JoTW7CnspRidXCCQA4LpgmMIIVGz04e7VAe6dMcn9pgso3j_Xg-4j33EVb
    IQH61nwN8VuG5QFHQ>
X-ME-Received: <xmr:NID_Z8piTTbwvcz7V4SXr_p7kgSoHGcmNvSCDRgqOqEJekwunYgGr-7_-RejXOrU_EqbrD0apZT9HVKwkZkrH5sTv3d9RCBfq1aikAw1y-X48w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsiigvuggvrhdruggvvhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhl
    rghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvg
X-ME-Proxy: <xmx:NID_Zyn4zyigzvZQZXT0HVTl5AUsxvTvBB797EsTtpzuTjsJHYVXlw>
    <xmx:NID_Z81DkclLcM6SOGVIJqBQBiqXNdZUxV7QvxkdMOhi5bPHxqmdoA>
    <xmx:NID_Z5uoph3sn8MlkprGNFNoH4Yy0o5R1GDSve4xaEBFFwuhRA0PoA>
    <xmx:NID_Z4Wd8qbmf5A0BISLahKahKQOEP5XJ7nR8nNmASoDgSQeI9In1w>
    <xmx:NID_Z4LSnkGAhL660C4EM6MtEcDgE53Mm336gujfSeK6GKxsgdAVUZt5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 06:02:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 111a3863 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 10:02:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 12:02:11 +0200
Subject: [PATCH v3 2/7] parse-options: check for overflow when parsing
 integers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-b4-pks-parse-options-integers-v3-2-d390746bea79@pks.im>
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

We use `strtol()` to parse the argument of `OPTION_INTEGER` options. And
while we do check that the argument was fully parsed, we don't check
`errno` at all and thus may not notice cases where `strtol()` fails.
Most importantly, this includes the case where the parsed integer does
not fit into a `long` at all. The consequence is that we'll happily
continue with an invalid value.

Fix the bug by checking `errno`. Note that this change alone is not
sufficient to detect all possible overflows: `strtol()` returns a
`long`, but we end up assigning the value to an `int` and will thus
truncate the value. This will be fixed in subsequent patches.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c          | 10 +++++++++-
 t/t0040-parse-options.sh |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 35fbb3b0d63..e8c08e55e02 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -185,12 +185,20 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		if (!*arg)
 			return error(_("%s expects a numerical value"),
 				     optname(opt, flags));
+
+		errno = 0;
 		*(int *)opt->value = strtol(arg, (char **)&s, 10);
 		if (*s)
 			return error(_("%s expects a numerical value"),
 				     optname(opt, flags));
-		return 0;
+		if (errno == ERANGE)
+			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
+				     arg, optname(opt, flags), (intmax_t)LONG_MIN, (intmax_t)LONG_MAX);
+		if (errno)
+			return error_errno(_("value %s for %s cannot be parsed"),
+					   arg, optname(opt, flags));
 
+		return 0;
 	case OPTION_MAGNITUDE:
 		if (unset) {
 			*(unsigned long *)opt->value = 0;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 2fe3522305f..5eb1feb61b4 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -783,4 +783,10 @@ test_expect_success 'magnitude with units but no numbers' '
 	test_must_be_empty out
 '
 
+test_expect_success 'overflowing integer' '
+	test_must_fail test-tool parse-options --integer 9223372036854775808 >out 2>err &&
+	test_grep "value .* for option .* not in range" err &&
+	test_must_be_empty out
+'
+
 test_done

-- 
2.49.0.805.g082f7c87e0.dirty

