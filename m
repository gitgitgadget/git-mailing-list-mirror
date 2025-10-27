Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A798A3054FA
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597411; cv=none; b=eJNKajxos2/doVlrrJAdHTmc54XZ0GUsD28jVz/UMNXgcxP+LvD9HI6UewOtPir42MFv5lNjRnMaxJ3B8ZetdwpNWrYyue7J92qh0yRFqQOf3n/4Xz/gu4z37eOUjMQcLr6PBBXJ4WnexCmNyta/APrxJAxYDtsT4PO0KhFCtbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597411; c=relaxed/simple;
	bh=gP2XYYoGYRYbKF3yHu9KdzPG+koWWlHVRzkpxnfTw/4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EzQMFKAwfwysXZmUmf7UkieK7QCExS02VhO8B9My/HDUg29LNHp5oeS8ZFsYvkhET15GIU4ApMO9oWbM67lgGAf4zPu74BDq7sybBhNPscHedGVzHGffU1Pv6jJN5L+DGpB8g6CgugQMR0AczxDysfh4cBwhgmPz87S8oAiF/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=acyDSFjS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJ5AcLmE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="acyDSFjS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJ5AcLmE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C3146EC0096;
	Mon, 27 Oct 2025 16:36:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 16:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1761597407; x=1761683807; bh=JzwnGzcBVbjBtxcEiV5W9o2WI9OpMyAZ
	NqT89JPpbeg=; b=acyDSFjSQEF+10nNDFzmw0KJgcUPRUlMvdacEnheBiy6j9YC
	PJSsRVXcG1n5TRTHKQpWVdX69Jc7ZeRqXQfGk0EnBjHDySqWD9ZHuXy3ZDOPnrOD
	cibefSo8li7bquUCeReb/8rH+Ei7Zk90Io0Rj9wOzlFv0oyFPwErLt4N4OSvr89n
	OwCWGLrB9G3d59IYkIQZxKrb87feFExuMZNoXyagRxN9QIZqnXQzjaRkNJfa1QTX
	yTyZH7qObMUppHBVo9trzFyWZLA9pAq+dR3+qtK7mtZZu4ZIFdbh8aXvLSkq3X0x
	9cxST6MVqCt0CEclHZoI/vOoMezWaWjhny1xtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761597407; x=
	1761683807; bh=JzwnGzcBVbjBtxcEiV5W9o2WI9OpMyAZNqT89JPpbeg=; b=K
	J5AcLmEmW66Qa4RMJFjImvwqzGsVWs/Ro0DlHrCTef025C9cRNfGptTWRR6UdMmU
	MjxwEqjTyiZ7JuMpdqixk7ekgelr8uIJpzGUOYc40YjCvSpIXbHHC1g9TsAJG6fm
	BAMknQqaihMIIw6P2IZFnJ1uSEvN7Mo2z/vlDzlhFjxpwRg8y2MaIl7uAXbwC7wD
	tpgsrONOhfayGJbwxkdLJJGhUsPjFd3pLoNGiJZn3YFNdq3mdFaQT0bAEIT+8vZb
	FcNUZXckzafQzcH3RpGM5P+p5K+CgO6QXu0JEdjbC7YvD9gG9ppsNlPMYP5kebIw
	tNwD7Qdu9truA37f3x/9Q==
X-ME-Sender: <xms:39f_aEC0Ncu0IiQVUvtmBXAV_E9ZAxMdt43lUSLMMu-21uldhm8_8g>
    <xme:39f_aMjeYkke5Ek2-hQ_66cfxHAL7SZuyg6ePrgjYSpqU-IkApZE544yDZW13pjMy
    unIAyFVOiWXhg5VCFljsydO4KEXQBWvdc70QLMHq_PXDRkKaS4>
X-ME-Received: <xmr:39f_aFOB6Rcwu_gpGx-vklmWhR1KdnfWJKb4tLXZJe1An3oLUeZvz-bWunocIbbgvZXc68xtbhL-xT3TkxeORLXFc_fPWgXI9K0L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:39f_aF7r-lLWjO6ENfgpSohT0w69Ewv5mZbfl1Qz1LisScVseGbEJw>
    <xmx:39f_aL0ouyzBUnofa-_KxkYSfpGhsQbWFiZouM_ZR2yxMtXUScbS6w>
    <xmx:39f_aOYRHkQkzGUNLxEUxlWGmbO-Gib9lHQ7hJWHApMQb7zcc5jJKw>
    <xmx:39f_aLD1ftT9yMvxcrmCqk59tlo4HT94BLA8WazGgmMMY1jRJxkgjg>
    <xmx:39f_aGGvnFBAEXQHOdxQGan0aHymt9iBGCWgfE0t7f9rL-aX4ucZ3obN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 16:36:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] whitespace: correct bit assignment comments
Date: Mon, 27 Oct 2025 13:36:46 -0700
Message-ID: <xmqqfrb4hyjl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A comment in diff.c claimed that bits up to 12th (counting from 0th)
are whitespace rules, and 13th thru 15th are for new/old/context,
but it turns out it was miscounting.  Correct the comment.

Also update the way these bit constants are defined to use (1
shifted by count) notation, instead of octal constants, as it tends
to make it easier to notice a breakage like this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I happened to be looking at this code today, and noticed this,
   but I very often make stupid mistakes while counting things, so
   sending it out (which should not change any behaviour) in the
   hope that somebody would (again) notice that I cannot count.

   Next step would be to make a gap between whitespace rules bits
   and WSEH_NEW/CONTEXT/OLD bits, so that we can smoothly add new
   whitespace rules later.

 diff.c |  4 ++--
 diff.h |  6 +++---
 ws.h   | 20 ++++++++++----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index a74e701806..08136ad5c5 100644
--- a/diff.c
+++ b/diff.c
@@ -803,8 +803,8 @@ enum diff_symbol {
 };
 /*
  * Flags for content lines:
- * 0..12 are whitespace rules
- * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
+ * 0..11 are whitespace rules
+ * 12-14 are WSEH_NEW | WSEH_CONTEXT | WSEH_OLD
  * 16 is marking if the line is blank at EOF
  */
 #define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
diff --git a/diff.h b/diff.h
index 2fa256c3ef..60749154e7 100644
--- a/diff.h
+++ b/diff.h
@@ -331,9 +331,9 @@ struct diff_options {
 
 	int ita_invisible_in_index;
 /* white-space error highlighting */
-#define WSEH_NEW (1<<12)
-#define WSEH_CONTEXT (1<<13)
-#define WSEH_OLD (1<<14)
+#define WSEH_NEW	(1<<12)
+#define WSEH_CONTEXT	(1<<13)
+#define WSEH_OLD	(1<<14)
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
diff --git a/ws.h b/ws.h
index 5ba676c559..611c6b6d50 100644
--- a/ws.h
+++ b/ws.h
@@ -7,19 +7,19 @@ struct strbuf;
 /*
  * whitespace rules.
  * used by both diff and apply
- * last two digits are tab width
+ * last two octal-digits are tab width (we support only up to 63).
  */
-#define WS_BLANK_AT_EOL         0100
-#define WS_SPACE_BEFORE_TAB     0200
-#define WS_INDENT_WITH_NON_TAB  0400
-#define WS_CR_AT_EOL           01000
-#define WS_BLANK_AT_EOF        02000
-#define WS_TAB_IN_INDENT       04000
-#define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
+#define WS_BLANK_AT_EOL         (1<<6)
+#define WS_SPACE_BEFORE_TAB     (1<<7)
+#define WS_INDENT_WITH_NON_TAB  (1<<8)
+#define WS_CR_AT_EOL            (1<<9)
+#define WS_BLANK_AT_EOF         (1<<10)
+#define WS_TAB_IN_INDENT        (1<<11)
+#define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
-#define WS_TAB_WIDTH_MASK        077
+#define WS_TAB_WIDTH_MASK       ((1<<6)-1)
 /* All WS_* -- when extended, adapt diff.c emit_symbol */
-#define WS_RULE_MASK           07777
+#define WS_RULE_MASK            ((1<<12)-1)
 extern unsigned whitespace_rule_cfg;
 unsigned whitespace_rule(struct index_state *, const char *);
 unsigned parse_whitespace_rule(const char *);
-- 
2.51.2-686-gf92ff40d17

