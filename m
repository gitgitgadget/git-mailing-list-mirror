Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF11C54AA
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986557; cv=none; b=T79fyzNbxZaGjKT0oWWahRe49nRH1PhgcryjPWNSRF6UJ2VMZRBWp/aWwvAM/a2PO06YvpZfkuUKNliSqF/jH8N7/G5TZSYL+U8MT8BvkVRZGKgtIRIAvOkYHEsrJl/ok1tScx0SatPu3PbBr2x4tT2tLdEPbuC0FRWW30Lnxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986557; c=relaxed/simple;
	bh=yqoP2NQTbIfjzkh8xxhI58gGZzBlbSQ8DQwe+LsgSLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fisPHZ5NqyDzMmUFuAJYfxGPj/0ntZGgrWWd2zGsAUlisBe5hVL/9aW+4AFpIs5XGUo9vMtr9jrOcIwO4EfUt0BBfLKJFO4KTaAMdNzF+M71B/tLh89+RQR1rOkx62EkyesRlriWbJYauMfOkRCUeQJ7c8Kb1X3FQ2Rk4/kMJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=perC2XCI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNbIjzkz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="perC2XCI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNbIjzkz"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E34CB114018F;
	Fri, 14 Mar 2025 17:09:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 14 Mar 2025 17:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741986554; x=
	1742072954; bh=zwRx977EW+vFccB3zUTMvfH4RQSGXpTjvIKjVDnEU0o=; b=p
	erC2XCIA3Pderk4lynQhBIV3lF+5pBZK1edN8BDOjyAKX6vi7t2KYLcU1W4EHYKn
	DBZyvXy32Niwl2bFmyQ3/xMmMWxupced4R6r9SFYOJ21cUJGhwTbhtHySewW0lEB
	8LgrrdVwb7lgt3qZg9vNujUSOgy7+GtrKpbhozdzTwSJvDFgGsQHchT6k9DEnyaH
	6lt/3zgwEGSYSjU5l1nNmj0Pp95CENjRz3fOpBKgSAuvlCUheCBPNUwfGJF41jvT
	eptxXcGv1Uf1t9BUxUI0i98RhPXh1zruu3zZmmWo974In56xBWTHM6lVvQaBx/uZ
	03NlEZIiV6i8McEwKG1Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741986554; x=1742072954; bh=z
	wRx977EW+vFccB3zUTMvfH4RQSGXpTjvIKjVDnEU0o=; b=UNbIjzkzHXWBbcexD
	h9DnEmgSf7D0//eLuPT1AZNWl3LVSHvUpCcJX5DCMGXhWhZZeGRiEFoZm6Rbq28Y
	sVcotRvg32TU+OrEFBhMZbeGIfaUHVHEXKdEfSkCjWRF66TwCXn5knr5AehdcWGp
	GQv8rRsn5wGF6zHsOUM+HOrpo1ycpYRjs2YmpMVFMd0yHQnfPpKoxjuLDaLlRK67
	Yp9nMrYBRTG6bTNskt3Ro3PVlqTKjF6lqnu2VY1+dNCt7ntzyoY0kVCKRjv62YBW
	tr3B20TWU9u6hy4JyNRDeUQDeasPgBRZ9Huex3MwktHnxpEAZFnBzy83YLJ++a41
	3w0RQ==
X-ME-Sender: <xms:-prUZ0rtbTeyH-PKGOi0suphHBAcIEoeIxHIGJmAJQ68k0lgrB8-rg>
    <xme:-prUZ6qgLJGGztO73sH1Mfu5ruLEZPUmLYn00pthcGN9s-FZH0jmAlN4h85mEEq3p
    I2cKiQTfVROOFU0bg>
X-ME-Received: <xmr:-prUZ5N8cWjRIijXcqqwh7zPCWZxc91dhovuoB7bWGxNC86z96KBkVjGJcUtioNwzjAtfr3qEeLqUZwraM9jm06NbuineiOJ9jznUaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dvffelhfeutefgkeettdfhudelffduteelfeeiueelhfdvudeiueekhfdtvddukeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:-prUZ76IpQRr8V1hbSfUL9EvhhHZDacq61pOOVKRZJixfOkS1tL-tg>
    <xmx:-prUZz6xwcLpaJ082JZKZXLmtsm02ftgWckhH6JZu7fI4gSMYiXGcA>
    <xmx:-prUZ7jHxJs8S2ZdQ0dsvrDdA27XsIaK2hvKRnKat1A9g6-0hdnogw>
    <xmx:-prUZ97qdT7WtuUdgiU3MkdxPz4Yagvxu7WGwBridow2lTM8ZmvS2g>
    <xmx:-prUZ1lsqVc8LWHna10GSfPDc-1aKkEKvYF0xQbBWcPvld0JkaHAMHOq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 17:09:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] run-command: use errno to check for sigfillset() error
Date: Fri, 14 Mar 2025 14:09:08 -0700
Message-ID: <20250314210909.3776678-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-188-g35fcca2323
In-Reply-To: <20250314210909.3776678-1-gitster@pobox.com>
References: <20250307225444.GA42758@coredump.intra.peff.net>
 <20250314210909.3776678-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

Since enabling -Wunreachable-code, builds with clang on macOS now fail,
complaining that the die_errno() call in:

  if (sigfillset(&all))
	die_errno("sigfillset");

is unreachable. On that platform the manpage documents that sigfillset()
always returns success, and presumably the implementation is a macro or
inline function that does so in a way that is transparent to the
compiler.

But we should continue to check on other platforms, since POSIX says it
may return an error.

We could solve this with a compile-time knob to split the two cases
(assuming success on macOS and checking for the error elsewhere). But we
can also work around it more directly by relying on errno to check the
outcome (since POSIX dictates that errno will be set on error). And that
works around the compiler's cleverness, since it doesn't know the
semantics of errno (though I suppose if sigfillset() is simple enough,
it could perhaps realize that no writes to errno are possible; however
this does seem to work in practice).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 402138b8b5..d527c46175 100644
--- a/run-command.c
+++ b/run-command.c
@@ -515,7 +515,15 @@ static void atfork_prepare(struct atfork_state *as)
 {
 	sigset_t all;
 
-	if (sigfillset(&all))
+	/*
+	 * Do not use the return value of sigfillset(). It is transparently 0
+	 * on some platforms, meaning a clever compiler may complain that
+	 * the conditional body is dead code. Instead, check for error via
+	 * errno, which outsmarts the compiler.
+	 */
+	errno = 0;
+	sigfillset(&all);
+	if (errno)
 		die_errno("sigfillset");
 #ifdef NO_PTHREADS
 	if (sigprocmask(SIG_SETMASK, &all, &as->old))
-- 
2.49.0-188-g35fcca2323

