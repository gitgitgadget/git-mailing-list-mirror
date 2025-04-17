Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789322FDF3
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886994; cv=none; b=rTtmljeqAZ4D4TCLYk/2bac9QLJSBv6N9m7rPVJEF2N+8jKg6k5YT5EO5zDumP4C39Wdyr6597vgLjTxaD3ghMIRaqhlFd1SPHbBTngA6Q6glnIQIFr6urHwyqznAOhXf+L3nlo1UdHlpN8Uo7UwH43NPPH5f91Puhv976Ahpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886994; c=relaxed/simple;
	bh=Tw30xc04kM6mDpS21KEZLJ+8FutYcExzbvOeaptyF5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGPrkI3+cyBJ2tQ3Y9Tmi308Wpy2UFQghwDReGPtjSUe2rWvK9YEyJZmlyPRXhGRBcfrNL9oebJuqoIkhN4zhocnKGK9p7luRvrRoX2IfUvxsZ7SF28VuFAP6wd7yfjIiHZKGu0RJaDH3jev8Zpq1tiQImJTddhgbknPhAWKm/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X9YiTpV9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNT6rbnA; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X9YiTpV9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNT6rbnA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 43CEC114018E;
	Thu, 17 Apr 2025 06:49:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Apr 2025 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744886991;
	 x=1744973391; bh=Bcm9Dz5OXmPTKvffYfiZ3Hq7MG7rNw+SRqrZEpb+gD0=; b=
	X9YiTpV90nEC8ophyzP8GJ/lYEfKWCECv82N2LHBYIHBNT0zMUnY/KXkJVNWN8oc
	BnI5/Z672SjZQExjwWxrVlf4Az7FvQQXgehnarf+EMe2x/53w1GvZ/iHySHqNISz
	hsEQQzxy/VPf8k1kJ6EfV56aYmE06NUlrbvBqmoyrLV3KzvmT6fnnVqzHMkg/60Y
	jz27SNgNkobgYYUPcSMvNMG+W1WsfwZQ29DiQbS4Xxm3GtBH4aJU5/8oEfGxHGKt
	uz94zRD3eNd76Wv7b/WlOQY/FNumUIfHJuVz8SRP35wqZxnIS815+aA/iWy5V9QF
	8PnAK29mwtBAgTJGuHQdOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744886991; x=
	1744973391; bh=Bcm9Dz5OXmPTKvffYfiZ3Hq7MG7rNw+SRqrZEpb+gD0=; b=c
	NT6rbnA9Q0QUfuWWA+Qv6sktwI2Zkd3SpIAtgFjazp5F+cSQuxLteiX+ee6zG5gR
	+Oa62pe1OnKwDetlOX2jpBbkBvYwkUMyj1l145qBZae2Ot7cfaYsa6ek1gtJEcGX
	oFYkMnoqXxmA/MwJJd2IXlBGIBtU7EM3Gbmw3eJTSPjKGKIFU+v8YuN9tSkgWwMG
	IwLCyoJR7OT6x1DbT2V1Y5mKWeD5yo7CtQ4stpHAvIMzKjg+j/5h7jUnSRlXxbUP
	6y2lZagc8MMgAix8DOKI0flHhXNtP6nShpkSYi7xnoF92RFgIwH1Qu6Vhr/52dTK
	+f9muXYqcelKmVNz5qvIQ==
X-ME-Sender: <xms:ztwAaPKQl9g6n5vmVO02cuG_avHlVrVj5TgvEXmilv55hdsbAWZM7g>
    <xme:ztwAaDI_0Ce6L61F6yYuhMkh0rq_YbEp8sNG-WjM5u9taJ_7All7H2A4u69CNMBg_
    m3xnj5N_PB7LaYRWA>
X-ME-Received: <xmr:ztwAaHss6qEFIUuv7vxxzh5VBuPFAGIkoghN1lGpdNpM0rkP1NmngGd-MEGqp8cBpY2Eqsa6oygzVRZ_A4nA2YSYoBsA-v7VLBTLsPnmwOZU6SZz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuh
    dqsggvrhhlihhnrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmiiesphhosg
    hogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhes
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ztwAaIbe8kQDehPlsqr18omPuN1Qplk50iQ76DvIEIxfuVX5jCvc4A>
    <xmx:ztwAaGbnICP2h31ExXbU6f5V9_gqIcPZD3eJpJYD8vcx24s_Nbm4_Q>
    <xmx:ztwAaMDG1svsCmdZOitRuIKbgbVXzF5j0lXAGrvhWrFzQzFFBMULgw>
    <xmx:ztwAaEaxoOymvhVhlMVn4p7IY4RAFFuCh763lvtZP5ESupqJTppacQ>
    <xmx:z9wAaEu8ZKXwCjKuIddj0j7Kxu8vJmzlBwof8xwf4kHGeVB3NLn3PlQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 06:49:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 23f43809 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Apr 2025 10:49:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Apr 2025 12:49:38 +0200
Subject: [PATCH v4 3/7] parse-options: support unit factors in
 `OPT_INTEGER()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-b4-pks-parse-options-integers-v4-3-9cbc76b61cfe@pks.im>
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

There are two main differences between `OPT_INTEGER()` and
`OPT_MAGNITUDE()`:

  - The former parses signed integers whereas the latter parses unsigned
    integers.

  - The latter parses unit factors like 'k', 'm' or 'g'.

While the first difference makes obvious sense, there isn't really a
good reason why signed integers shouldn't support unit factors, too.

This inconsistency will also become a bit of a problem with subsequent
commits, where we will fix a couple of callsites that pass an unsigned
integer to `OPT_INTEGER()`. There are three options:

  - We could adapt those users to instead pass a signed integer, but
    this would needlessly extend the range of accepted integer values.

  - We could convert them to use `OPT_MAGNITUDE()`, as it only accepts
    unsigned integers. But now we have the inconsistency that we also
    start to accept unit factors.

  - We could introduce `OPT_UNSIGNED()` as equivalent to `OPT_INTEGER()`
    so that it knows to only accept unsigned integers without unit
    suffix.

Introducing a whole new option type feels a bit excessive. There also
isn't really a good reason why `OPT_INTEGER()` cannot be extended to
also accept unit factors: all valid values passed to such options cannot
have a unit factors right now, so there wouldn't be any ambiguity.

Refactor `OPT_INTEGER()` to use `git_parse_int()`, which knows to
interpret unit factors. This removes the inconsistency between the
signed and unsigned options so that we can easily fix up callsites that
pass the wrong integer type right now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/technical/api-parse-options.adoc | 6 ++++--
 parse-options.c                                | 8 ++++----
 t/t0040-parse-options.sh                       | 4 +++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 61fa6ee1678..63acfb419bd 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -211,8 +211,10 @@ There are some macros to easily define options:
 	Use of `--no-option` will clear the list of preceding values.
 
 `OPT_INTEGER(short, long, &int_var, description)`::
-	Introduce an option with integer argument.
-	The integer is put into `int_var`.
+	Introduce an option with integer argument. The argument must be a
+	integer and may include a suffix of 'k', 'm' or 'g' to
+	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
+	The scaled value is put into `int_var`.
 
 `OPT_MAGNITUDE(short, long, &unsigned_long_var, description)`::
 	Introduce an option with a size argument. The argument must be a
diff --git a/parse-options.c b/parse-options.c
index 35fbb3b0d63..b287436e81a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -73,7 +73,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 					  enum opt_parsed flags,
 					  const char **argp)
 {
-	const char *s, *arg;
+	const char *arg;
 	const int unset = flags & OPT_UNSET;
 	int err;
 
@@ -185,9 +185,9 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		if (!*arg)
 			return error(_("%s expects a numerical value"),
 				     optname(opt, flags));
-		*(int *)opt->value = strtol(arg, (char **)&s, 10);
-		if (*s)
-			return error(_("%s expects a numerical value"),
+		if (!git_parse_int(arg, opt->value))
+			return error(_("%s expects an integer value"
+				       " with an optional k/m/g suffix"),
 				     optname(opt, flags));
 		return 0;
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 2fe3522305f..0c538c4b437 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -111,7 +111,9 @@ test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear
 
 test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
 
-test_expect_success 'OPT_INT() negative' 'check integer: -2345 -i -2345'
+test_expect_success 'OPT_INTEGER() negative' 'check integer: -2345 -i -2345'
+test_expect_success 'OPT_INTEGER() kilo' 'check integer: 239616 -i 234k'
+test_expect_success 'OPT_INTEGER() negative kilo' 'check integer: -239616 -i -234k'
 
 test_expect_success 'OPT_MAGNITUDE() simple' '
 	check magnitude: 2345678 -m 2345678

-- 
2.49.0.805.g082f7c87e0.dirty

