Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBFA1FFC6D
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222175; cv=none; b=FbHPK31wKI9psfNKa4d0Uxf98hkCqWd0JlWxJZMpKGI+KMrovZT9ID91Ezn5rFVznWaEHTmlEZedjhepzCmM3JB4197Kic9Y+j1UYtgBme98QupZI2nVqH3kkzAUuVAhjfyzlxmsxz3fYFzekAz43fjVjbeuThC9AMi3RcaXljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222175; c=relaxed/simple;
	bh=8eV5YGRyQGxklq7lA6qqs5s0JYxney9CtWD9c6k4MFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+sIOHyMy0j+nCOppKbhitqgveHarYLL75Zz86Xb33nbsuJdtB8v4mrWlM324CCt9m13kMpNRJXEGqW1UCx042vuHK58te1iTn6e+aUjS2qrJfh6PR+I0deEbvyjwGhPpsSSVyBXKAl8PNomtXDXZep4KhRVPB0Yk9p9C2AsQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E5YK481N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XtiG3tQN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E5YK481N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XtiG3tQN"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id ABC9F1D003F1;
	Mon,  3 Nov 2025 21:09:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 03 Nov 2025 21:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222172; x=
	1762308572; bh=F0tV1ayGn5+RqHRLCyxYTrUcQMVUDRt9Q7GjHcWIgqg=; b=E
	5YK481NDGrpZzLqMmdEWnvlKGxE6l/d0DBgVk26T59saUe5lo3TeriGXZlm9CeKw
	+2+frFAHc0ZqBzCbhk8Rd5t6My71437L9UmXVcfz9p+iHtirQmHjbfh8Ys8ZVg7z
	3+Jmsv0EAEN4lJz/n5TbDjvtkDD2IF8Id7blYBz6CAN/S10xUxqw4dw1/hhOc2VT
	lg+gTWIkmwcvTyVKUHnS1gw6PVpGuHR0Bx4l/W97aJX64rr+FqmHoLnGF/zMAEIs
	KoBtKqZ7CzlDCHcCL8R3zsmpFJrOWfe+kbCytr1hpdyfFZPZot0gfeHYc8f0B45t
	p1YLBEJiI6/qb/arUX9UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222172; x=1762308572; bh=F0tV1ayGn5+RqHRLCyxYTrUcQMVU
	DRt9Q7GjHcWIgqg=; b=XtiG3tQNK/8aT4d4xnaCEvWqFpYccQo83+PAbH0bOtu7
	vG3TKbAxyBpN8FpeKPr4zHDvwCOXbSxahG8eeW1UFIsHFi1J61iRp+ViEhoQKWrn
	g358lIrHkJ6uDF2lEfDxqofCMx1/TvzbzlvgldWMyVfNZ7+KW+gZ6ISwwaS1IVR4
	nCVlNHgYEJKeqMUJ7+glJWOzoX36GvSDcO9dWikZxrHgqFnBn0tHFk/HhIpVSkaI
	JlCJzcKdSWrHVLTJyHh8GaOf9vsMk6I5kkoooN8fAprHkTHRPzSNROKGwUKxCYi/
	U/boIbwGOUt/uOHsenOef1721ClEef6wWHkUO2lMnA==
X-ME-Sender: <xms:XGAJaeBHNYxm6QJgENkxR8tkEFtx2ZrLA4aJq3WaCOkNNCDGsnpGAg>
    <xme:XGAJaeh5VuwT5tmYvvW80SIFLoh4CeVcTRgOinzlVl9WssuMCPMzHtfpobxbjOsh6
    1HJnN_-QFjyOT0XNevh4_4ahFIc2q1NZkosNi_ZXGMwJCMTY0XTZ-c>
X-ME-Received: <xmr:XGAJafNNgRiDW_ZkqgKqmxscTj9k-Mb9jXz2MXKuvkb6Ps-VNXj9tog7PnATkORKvuGEsV3vvmSZqviqtOi4G47XGHZGS67WCE_T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:XGAJaX7L9FgWO-FcsJMUMzTsHWFLKnItEOKwqFll0vKZMMhhXej6CA>
    <xmx:XGAJaV1W_JQeg3cpJ4I-JzRWFBlBk6LugemlqsxJcg67klPYWwQwCg>
    <xmx:XGAJaQY_XAZ2YfgsfiN8E52vGqaTeXNWJjMV7oJjRg-Fz6kyfamFkg>
    <xmx:XGAJaVDsAr_p_mCkLtRaq4umLqWHMdiij8L3DdjqFzFR9ClYfxR3rA>
    <xmx:XGAJaRbGK8G94qR5LZfsnySWxMdkUOIJhoOpjuBMhO36wfxRCNKyK4Di>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 01/12] whitespace: correct bit assignment comments
Date: Mon,  3 Nov 2025 18:09:17 -0800
Message-ID: <20251104020928.582199-2-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0
In-Reply-To: <20251104020928.582199-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.52.0-rc0

