Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5CD1D8A10
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391421; cv=none; b=qC1THi3+Ic/DD897sEW3h2+QOTWCqNCFG5H5EDZwhG/Gva+fiB+5OQ1tE60l0DoT8JHtGcnm5aPP37BPcIXz0o5RCZIyCyCpyXruLbNfpgA8a03NXBFOmpKmE3ykuaygkhhWR32Nb4P/Jhbt7D2NGZiUzl1lQE17TkAo4pbKkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391421; c=relaxed/simple;
	bh=y8FQbQbsybzkRszw4z0Q7nr5ZJG10Eaf1qFV/jzO/sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ql0q6u3q7xcO5ovvcLpaK1Kfw34osKRl1BgH/Smnb4hPGQJhVftbuqVXBnWrJ+eI4wJuGNZO8Vfw6ZNczSHg6GnRb5/65nW5By8FpiiNe7yk94/PVDleiZdE9Q7sz2uA1NFUDB2dIufsq7BaUR0/nZz/djYpjWD4I/pjLIDmKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tKjpCyKF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QEeb5hZC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tKjpCyKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QEeb5hZC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AAF941380B87;
	Thu,  5 Dec 2024 04:36:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 05 Dec 2024 04:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391418;
	 x=1733477818; bh=suVoiW7cBGLiXeZR5Wi4pkUd8RCD0UVV+bHRKtSsX6U=; b=
	tKjpCyKFfQ/Mhg46ahqUIXk/CP0NEh3orQZNrnYx6RXCWEoqcLcr9G4HpFvRCcJt
	bqgyKJTzj6DL1IUCWmrhohtqM5efSFhkZniAoUESHfoP0Dup25hy4wCynEbyZKdL
	G2Y3RWcMzhd+k4ru/iyV1Ci6Sd8uxQl5UtoZzdv7nk9ZCcldb3Xt0EnYQcOEPFgW
	+Z/+8+lLY6v+N+aGU6bM38qjQPx8ViOREtxx0rmO7YKuPr4lhQH0rvIYyWbUWnOb
	50tqttiFygqD21HAghx45JcwRXSwV1iTGXoY8t/JKrvr6fs6HgMFh6gL9YEjV23F
	nW59Wx1XQ7qF2Ug3a4G2Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391418; x=
	1733477818; bh=suVoiW7cBGLiXeZR5Wi4pkUd8RCD0UVV+bHRKtSsX6U=; b=Q
	Eeb5hZCzpUVYwSmii088jYjv619Dt1Ov4EYhbfw2HhADPDP3vHnrMSIwtMPbsx75
	yojqHAFmgJ6oANfGy8pgNQg/kxc5pTETqd3SGVHAmjtoX9xjL81WPbIONIrS0YNY
	sr8fGpyC16dPjJPQAXCmVzMHH2MsS6LncYWfrtiYIY1aXaKotGlOP03oPon0AeaD
	qK0x0In/PshTMeMJWh/7yKw0A0/WgwcJHLmvOsWRsfy10B4NAB9JTHPUpe0Ckqrm
	D+qorzU6QWfteCNUZhgb/3hM60Be9uqzWk2IL5UcrOjm8owoLQltuCfWjb/Nu78D
	RAyEhIoMTTyOQoMvVvnfA==
X-ME-Sender: <xms:OnRRZ_nzUYj_GC7vCb0Tpc3ELi06FUNsIoiaJMlb6OQn5cAQHqxBOQ>
    <xme:OnRRZy2zmMtA4izN0g1BZgpE9PCFRPS0CXHxZiv4wrmRFOUX1gmThh7nmeRXh4JTS
    mpdDs8xwIm492VzFg>
X-ME-Received: <xmr:OnRRZ1oQ2wvhgK1-X9WjesmqINMrArXWNlr3xbyyUzIosFRlQCIzxmj3A05QAQiZVwmm4gFlUJBpEifEzq3Hy11qjMJ3SOMrKJzpnlWCC9gSpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OnRRZ3k-0kDaQ2h-mK96z5e5F1PNt4GXHyL0qlB-xRTNKqRH5XnfNA>
    <xmx:OnRRZ90TdT_ruILLR0FUv07rRoLcJAcxxuCOGsBoYhEu9e7rCAiVYg>
    <xmx:OnRRZ2ufVKs_gUCP4bJNpAAeJN1D_wk4XQkUp53zuvZtjbbJg3hoCQ>
    <xmx:OnRRZxWUgy3JNSwxPcGxL-RR0_-hC-tLRL7NnzV3cPYXFl0CfBk1MQ>
    <xmx:OnRRZ4Sw6V3UcbhmUAP7qC7lbVkWFgDySjBNV2O0Kju61cYIDMpfLoam>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 307c2149 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:34 +0100
Subject: [PATCH v3 12/15] builtin/blame: fix type of `length` variable when
 emitting object ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-12-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `length` variable is used to store how many bytes we wish to emit
from an object ID. This value will either be the full hash algorithm's
length, or the abbreviated hash that can be set via `--abbrev` or the
"core.abbrev" option. The former is of type `size_t`, whereas the latter
is of type `int`, which causes a warning with "-Wsign-compare".

The reason why `abbrev` is using a signed type is mostly that it is
initialized with `-1` to indicate that we have to compute the minimum
abbreviation length. This length is computed via `find_alignment()`,
which always gets called before `emit_other()`, and thus we can assume
that the value would never be negative in `emit_other()`.

In fact, we can even assume that the value will always be at least
`MINIMUM_ABBREV`, which is enforced by both `git_default_core_config()`
and `parse_opt_abbrev_cb()`. We implicitly rely on this by subtracting
up to 3 without checking for whether the value becomes negative. We then
pass the value to printf(3p) to print the prefix of our object's ID, so
if that assumption was violated we may end up with undefined behaviour.

Squelch the warning by asserting this invariant and casting the value of
`abbrev` to `size_t`. This allows us to store the whole length as an
unsigned integer, which we can then pass to `fwrite()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f0d209791e44025b1965cd447cf4fc1e2ca5f009..94aaa5eb1d2f410274cc5cef1b242f247bf48c1f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -6,7 +6,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
@@ -468,9 +467,14 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 		reset = GIT_COLOR_RESET;
 	}
 
+	if (abbrev < MINIMUM_ABBREV)
+		BUG("abbreviation is smaller than minimum length: %d < %d",
+		    abbrev, MINIMUM_ABBREV);
+
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
+		size_t length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
+			the_hash_algo->hexsz : (size_t) abbrev;
 
 		if (opt & OUTPUT_COLOR_LINE) {
 			if (cnt > 0) {
@@ -501,7 +505,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 			length--;
 			putchar('?');
 		}
-		printf("%.*s", length, hex);
+		fwrite(hex, 1, length, stdout);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)

-- 
2.47.0.366.g5daf58cba8.dirty

