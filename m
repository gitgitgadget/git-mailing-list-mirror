Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3F1DD0D5
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255616; cv=none; b=u7RjKZSuM4Nc7cgU+GEUAKGZKf7aDybk/6jkLdB6DElyaRZL5oOWnnKUuU3yvtKrfXzx115o1/xNY+4ITjt3b197x7/WpyaGiK14klIXBctZOe6u2bB3RKbrdqQX9RrZeIUgeqs2QMcvXiusLSrIlcNdxF4n0t2zTHARFsIjpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255616; c=relaxed/simple;
	bh=mZyp2GuJU4WBPQj+15HIUG6ORWpqKJhn8lRYEB/0q70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBjTI4VX3c5FbGDnBWySawpE0LTOLZvCJn9vOcKk+86PbiQG+rl/ssaiziPkV8+4akR4SYSt1xOHcMZ+VlD7skwy0/CfrfuG1wLJ14Cy1G8NbIqN8fnIPnwnprAEUBlT6RVkwpjFnG3T6GoCg9ys37j46DdgED3s91P1KoyFYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qyBO2qol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEp/wTpF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qyBO2qol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEp/wTpF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 305B91140237;
	Mon, 17 Mar 2025 19:53:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 17 Mar 2025 19:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742255613; x=
	1742342013; bh=FWeV7ol6yRDwRFj8n3fLro7NOQsPqTbR42o1EqkmCGA=; b=q
	yBO2qolCey3wT/uCmJnbEU5FoOiYlMIvZ93RkoJdBvcOD1sB5IB6P2SZs3o8YmNZ
	iyx1S1sCsRFbrwWQPA1CUFRMc3iJMbdqsw2MIQ5ofzLAlg+NCCJGGKtJXk5Mvz+J
	ZHBZcs15K+efrPYlhofj0Lbg5QIz8tcCEDqGMXLk5FSZCiBZtBry4ZfBMhawUcOj
	r8eKtmffOCbC06E5ZQ6jcvVEnbHBy1gM0B1VPt9ELGLiXgcpKSvPARq9Bej9qAjQ
	aFj2kZTfTdHKm1WKo9p54CfvaKe8QzHr2fWN48uiR4st2z94wIeXD8DUG2YyOiHr
	uOHpqMXausL1NPVv/oynw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742255613; x=1742342013; bh=F
	WeV7ol6yRDwRFj8n3fLro7NOQsPqTbR42o1EqkmCGA=; b=UEp/wTpF+2pDi3RXU
	TO1sJoM+FT2fWvnYQvvMGZ1Azt3PZat2V8lUPf/Ui7NvPPft1InMFBTn3BQFYOTq
	BjhwL/P7Pf/kbsSGDA1aOw+scfQPufuAEQaRpvC0OVQEi6xUtXmyqfUgY76SYnp6
	dDjvFnaNrvDbJ0pNcASGw8ct5P3vFPRcGn1sbuI0Q5n4dUKLCly9gCMNPDSJtMYi
	xBS7b+0x13RcFP4wmmdHO3IaPBcsRBhOB+lmCoCMtArE+hl5j2ZG7TSSjcCdIbF3
	YFQc/FqmR6Fno3qAvI9prEHsAbZ3k/SBWW7bptcIEQPo2sk14dT5NiYUX3q5QlyV
	/7Bfw==
X-ME-Sender: <xms:_bXYZ3ccvh5V2z2X5KG7csUWGo9BigFV5DzF8pmAXGOHDs0uQOXPEg>
    <xme:_bXYZ9MkL5y3DXrroWiYse1DEaMDVQE0oz6O7-DHaI0JuOpb-gnZRZvWCb6srM2v-
    5c5g6SM0FKx0B0zpw>
X-ME-Received: <xmr:_bXYZwiYDL9sbPnV8pBlgyxMGXsyZGsqmGrR5e5Xsod-rUWxrE3wHaP4kUauLPGe-wTwbn910Eun-8DiHZNVjkMR8qF0G8gnh3NIpig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtledtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:_bXYZ49XNwUTdz4FGu1eqzDF2IPrpo48suERpLRj0dqQcAIw8O72tA>
    <xmx:_bXYZzuGUufFNc9Ewz1aOBXlunqGyTfptg8tkwGo0nzL9eHJ5U4vQQ>
    <xmx:_bXYZ3HFBgwzU_m5iBiG6wTKOCqEK5nw5WFrIVEDicINjHz49B79dA>
    <xmx:_bXYZ6MoD6nWPaRqLrWYPHmz4c3c51rljPmioeL5yRI5hd2PEKedjw>
    <xmx:_bXYZzIIfl9H_gj3wV0CmupHM2lq3Nd5orFcl0RgCMi2s1-tvM-kxXEp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:53:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v3 1/3] run-command: use errno to check for sigfillset() error
Date: Mon, 17 Mar 2025 16:53:27 -0700
Message-ID: <20250317235329.809302-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-207-gc8924421c3
In-Reply-To: <20250317235329.809302-1-gitster@pobox.com>
References: <20250314210909.3776678-1-gitster@pobox.com>
 <20250317235329.809302-1-gitster@pobox.com>
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
2.49.0-207-gc8924421c3

