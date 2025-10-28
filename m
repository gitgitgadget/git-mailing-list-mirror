Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F87288C3D
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669188; cv=none; b=LevqVdfYESIji7/TN0q5vEjTZLADI22KWr21uoS2x76mHn/d5+J0vb8o9Y4k6s//uKLUctX5oNhzIGtZe8NTpEbzK7xAdH5tq92SV4p1JeH6vgzb5qZv74cSBTwN7VrzXfnm3fYvyf+xkNivLlI6NhC1F9uU533zC1UPNLUTX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669188; c=relaxed/simple;
	bh=QGbSk83iyq9EBYGQmiOAUnjLw4aqzAIMAJ9iuAiiVaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JLEOxMhx52+018DyvWnduqUYFZnHoyGDrOxePTNLfzNtIt19ET47czEbNKh5YUwHm7V24T657ksiXaCjUgbxa9c+inhWfr+BqupCzHduFhPmo0+MuHLBx4DO2XgVW5nZhortNcuzDuqT+CP9rBnl7C9eBvjmuo7FG6/MBTA5iqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vp7ApJHp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5ic1oiG; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vp7ApJHp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5ic1oiG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 533F51D0006F;
	Tue, 28 Oct 2025 12:33:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 12:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761669183; x=1761755583; bh=28eN2sCj6c
	OKFzLjHa+X5nFpoLoOqnGr+dM6OpRmMxA=; b=Vp7ApJHpA3jtWZHOxtAQkYAOsv
	/vdK0j1XN6HKrByR2wRtPhD0ui59zcvI9BvfZFDClJEjH5+MvWqVf31S7aPzOOjZ
	UihE1U8VIi8oKeKVNaCYjXZD7mGOasKmSHHD0PMcK0+uGB3CJjACsJGYRgtzo5Ap
	gfYx5s3gIIHynYq9r7vUl74ETz8Hj5H3q2y2kZcFnBN/MmqLzmqcjSpncV6X3GAT
	Wq45LPvB5Yf1JGUVlQqpy9o32Pg/v4GhmSe9ak+/Va5VWULGPnLxHb+G74ZNhR7y
	hY81MT5gjflPBap/AwfO5AsLixi3ay0TY+MMl69UELKVkmvED1fKReelt7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761669183; x=1761755583; bh=28eN2sCj6cOKFzLjHa+X5nFpoLoOqnGr+dM
	6OpRmMxA=; b=E5ic1oiGXITmKSFbHi4LnocD/LQIsPlTuMqFxiIb/HWJ2grd4QR
	EkxaKV/TEdea2jLpNPF++EueIlubo2cMM9WlHVs9nUCGVkk7KFY16FCdP8pXTBAm
	3W4kR5+Chwcq0Zb4IAurh0vCgbfhFfmrSAIyGOjHs+h539QKbU8rogGL41YGcGSd
	quVW+ZL/eMmREXcu8KP9RrqYC9nXGRT6opE7rZANUejUFLETsBzTmbiRD1DJf1XE
	oCorsG4014E3bL06yh2Hvfks3dm8bS5EsF0CYP+0sk1Dp+eQJ/Y/PUUty3HZaV7q
	GS4xc7TUdA6TRNfFpTFChIjWMWDHHeDVlTQ==
X-ME-Sender: <xms:PvAAaQ_Roak-Z-l4654cKhQx2jjp5mwfVongQShH4Xc9ZpH600KP2Q>
    <xme:PvAAaQJ1Xwli-KQ8s7JchW21CBWSVdqhgc73-mNkjGeLWAp8SEPyJf7QeS5tFQomG
    uAtwdh9QpuSxHynwN2AqYmjA2gOR8pntk5AXtxFo7xEgbaB4eiyCw>
X-ME-Received: <xmr:PvAAaTamGo-9ESeBY_kX4LVmkPHQwcBMvZ9uheLJPfKOZ67HhuJYoXDtLqEIKxsgVI0nN59oc0WV5gmJkauszAzQ2LDVLQcw4SLV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedufeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:PvAAaaLMP9ZNKW47vDOcdy8kI5JyeLaWl_8pgePRmYgP5RW-zsy46Q>
    <xmx:PvAAaZAovRaxJf6LPAgCTJ0Wp3nfIvTQzcV_GVkCXBfAtIyXDhiwiA>
    <xmx:PvAAaXomTfDkkmU61TpBhUIZbZjKluLEB4H8UJSphfmG3rD3XbMmBA>
    <xmx:PvAAacgHtlMl58EVPwxIF2pReHsEPE-c0M56vfG-PPZwjnaMx8-E0g>
    <xmx:P_AAaQSMU7m1U-fjGk2Etwv1iqThDnh0CXKPfma2l_WRUvJaQCdoLDAG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 12:33:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] whitespace: correct bit assignment comments
In-Reply-To: <xmqq4irjf8mc.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	28 Oct 2025 06:39:39 -0700")
References: <xmqqfrb4hyjl.fsf@gitster.g> <aQBlCCDWMhLX_aBa@pks.im>
	<xmqq4irjf8mc.fsf@gitster.g>
Date: Tue, 28 Oct 2025 09:33:01 -0700
Message-ID: <xmqq8qgvdm0y.fsf_-_@gitster.g>
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
but it turns out it was miscounting.  Correct them, and clarify
where the whitespace rule bits come from in the comment.  Extend bit
assignment comments to cover bits used for color-moved, which
weren't described.

Also update the way these bit constants are defined to use (1 << N)
notation, instead of octal constants, as it tends to make it easier
to notice a breakage like this.

Sprinkle a few blank lines between logically distinct groups of CPP
macro definitions to make them easier to read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The next step would be to reserve the low 16 bits for ws.h and
   then shift everything else up; we'd then have 4 extra bits to
   play with, and I'll take one for \No newline at the end of file.

 diff.c |  7 +++++--
 diff.h |  6 +++---
 ws.h   | 25 ++++++++++++++-----------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index a74e701806..74261b332a 100644
--- a/diff.c
+++ b/diff.c
@@ -801,16 +801,19 @@ enum diff_symbol {
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
+
 /*
  * Flags for content lines:
- * 0..12 are whitespace rules
- * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
+ * 0..11 are whitespace rules (see ws.h)
+ * 12..14 are WSEH_NEW | WSEH_CONTEXT | WSEH_OLD
  * 16 is marking if the line is blank at EOF
+ * 17..19 are used for color-moved.
  */
 #define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
 #define DIFF_SYMBOL_MOVED_LINE			(1<<17)
 #define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<18)
 #define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<19)
+
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
 /*
diff --git a/diff.h b/diff.h
index 2fa256c3ef..cbd355cf50 100644
--- a/diff.h
+++ b/diff.h
@@ -331,9 +331,9 @@ struct diff_options {
 
 	int ita_invisible_in_index;
 /* white-space error highlighting */
-#define WSEH_NEW (1<<12)
-#define WSEH_CONTEXT (1<<13)
-#define WSEH_OLD (1<<14)
+#define WSEH_NEW        (1<<12)
+#define WSEH_CONTEXT    (1<<13)
+#define WSEH_OLD        (1<<14)
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
diff --git a/ws.h b/ws.h
index 5ba676c559..23708efb73 100644
--- a/ws.h
+++ b/ws.h
@@ -7,19 +7,22 @@ struct strbuf;
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
+
+#define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
-#define WS_TAB_WIDTH_MASK        077
-/* All WS_* -- when extended, adapt diff.c emit_symbol */
-#define WS_RULE_MASK           07777
+#define WS_TAB_WIDTH_MASK       ((1<<6)-1)
+
+/* All WS_* -- when extended, adapt constants defined after diff.c:diff_symbol */
+#define WS_RULE_MASK            ((1<<12)-1)
+
 extern unsigned whitespace_rule_cfg;
 unsigned whitespace_rule(struct index_state *, const char *);
 unsigned parse_whitespace_rule(const char *);
-- 
2.51.2-681-g0e6cd5c3b3

