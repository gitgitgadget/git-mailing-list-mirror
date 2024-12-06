Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224DC204F93
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480871; cv=none; b=PgKZOWCIbDq/ttw/I+Uw1GaRbREI3K9oQIU5FNGXGHYezuDBvQLVVdgqWi2o5v3oAvjV8TaM/M70Lw4m2GL7kuhlYv9BmIDaIR/I1S9lvGe8xIr2f3QoczGamhuL0f2SDD9kTB/5XZ6xBtlk+UBu0MfxNvxpiEDuRlbQnzhz54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480871; c=relaxed/simple;
	bh=4A5hJcnl89eJSiYK+D/tsPW0zSdbZrIuo/Hk/pk2ogU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kze2itlvg0WL5Q0/hAP3QrW+zDC4SZTxk1PmZHFeK0VHZ6iYnuUeTCFK5kRYPM/DOAicFyndZwPjxHpqtYs85UAk6Bf9WZ7BuKTA6Tm7opOdu9Wfj+Zvt/lzQKtZaQ91et8LfHHrwo5y1UUogXT9mi4bhD7RkbE4U1McX/kKUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L9ajW0TQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CmyOyNUO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L9ajW0TQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CmyOyNUO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2882725401A5;
	Fri,  6 Dec 2024 05:27:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 05:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480868;
	 x=1733567268; bh=L9fwyeePiKCC2J7KAJdx1nMDCEg27PWm1Zxjr2q5wzk=; b=
	L9ajW0TQ+hg1Lq6JgJWz8EyTtwsvQiSV1vcFpe74uqhw2IJKjdBhY9l5wj6Yghkc
	f9cQbzOU/EqvDgLRs1zVcSSPb1N4oiDp5igiP1mYfKX4y5g/3yNrKQWsHvdCiDq4
	RGCPTI+yUMR3BEtNfDBezM7eUsuz+GopjIwZ5cLX+LTLhmSh2GO0Q/xZSQGgcYM2
	OPXoAM0pGZjWFAAcsiIxo6XVZ8DwIXmpWSanKG/2mO4FQ2C7E/lewm0Nk1Z1pV4h
	0kiHREkVv5vyASP1He9BlTxH4ae5iGViXIlOEAB6wtppy0FAZVt2ChwgiXLWRg5y
	tjVo8wk+VA3crRmSvraxZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480868; x=
	1733567268; bh=L9fwyeePiKCC2J7KAJdx1nMDCEg27PWm1Zxjr2q5wzk=; b=C
	myOyNUODf5fMisblg3ojmXT2c4qEZ9nBQUBp/aGLlQ+yghFfhK2V82v2wdEqBD66
	wPhBmUl5HZwXclxc6tRQPgucRj+JaCv7mCsWIyA7KZN1tZ6kRKX9T+vkotJmON35
	oqoVgzFYGSCthXAPBnxXm0qRJXUukvAUFsG9335It4ZnNDSWifhr6b3dikPADqIl
	HuKH16Bl8ErAFWB37I4FrXsoXPECovPhyFbYJa0x2sHsIBdHfJcNjC9h1sdiPjuc
	AHjd9Vm8+S+uGUEKDfIAzHSte1EB9InGU6ToHadGrmIKkbqH+mvR8Xk+JkS0Jek0
	OeJgxl8Oo5LeTf/CzH/xg==
X-ME-Sender: <xms:o9FSZzx1oYSigZJ02yP9rYFsUU1RTSXZuP1eYkdQYR1jxkcCiKw_Yg>
    <xme:o9FSZ7TuWOvu3EZpjx43LdlPrl9LysCjF7S9I2lZ-Fw5POYHY7_olg95jTgiNxreb
    GVvFRX5ImF1RlJKtg>
X-ME-Received: <xmr:o9FSZ9Wyozgr9lqZOPpco8mM0MGvKJj2qx0c-y1n22CVgBPQABAOCqcGUy59NXkwCxHWWyfwexgHBvnrYx9GeEokkjd-8JH-DnWbmvFefi2rWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o9FSZ9junQdD9lhxWi4JbtVANF9zOccjPdisTAe39WJh9jXaBw3k4Q>
    <xmx:o9FSZ1CGON69tjmg8c2h7klTcex5fBIUgFM8HeemLD3K_9fXZarIIw>
    <xmx:o9FSZ2KsYxnxJ-rJXaRO2CpLd_iviporLEmAlQ4Q0uXg0z6bMma85w>
    <xmx:o9FSZ0ADRrUekBNyLukd6b-mzMt9Jdd-hcI974GA0FDsD12yV-Gnyw>
    <xmx:pNFSZw-6PGd88TXzdiNRZDLmxz9U6qH45fu4i9e8fUry-5OexSIdqphK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8507b04c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:28 +0100
Subject: [PATCH v4 13/16] builtin/blame: fix type of `length` variable when
 emitting object ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-13-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
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
index b33b44c89a431d45e05d9863f69c049ba5eec08c..867032e4c16878ffd56df8a73162b89ca4bd2694 100644
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

