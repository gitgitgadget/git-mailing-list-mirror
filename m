Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E8225760
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378258; cv=none; b=uDwTXSvUaruywfaMA7PVue/YIuKRYhg6uKoiiitzS0YdaCPxbt/bwElTSPOEk8KvMLK26ozqU9U3LRVC8dxxtKSPrBfspnegpB11WXxLXEIRLzoypSPAw0aNAH4bpsEZLMFFSMI8EKOLef42eI5vjRNzpZcSODh1U0UfYSXvwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378258; c=relaxed/simple;
	bh=a9RauB7clbDeLyansbAvw+Fa0tKKjDiurvNmz2mXilc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHD15mQzUVIWs+mEJ4su1loiPhM6vhEKSNV1/pWIpJe4VUwB7xh9JujVd/onqpukXarBYziB6tCHHNBJLwjqc/V5j2IC4AoUewSalNlDknp7oQTepIm3EZRib3ZnT8+UZWeKGHDAwRRndu908wk5gPgWXqO2DdWK2tYWYmIdrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YmiYpTxH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u6agn8+0; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YmiYpTxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u6agn8+0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F18501D00222;
	Wed,  5 Nov 2025 16:30:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 16:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378255; x=
	1762464655; bh=20axvizTZT2tV+/0R2y+nx2ZQpSbDdV00V7pI9252X4=; b=Y
	miYpTxHydJFwjNR1D+7n1msjSOKwPigxRV75SYlpIth+6ppd6PyaEL2auHyyC1ne
	nMA0e5wCGf7jaXnGaKzE5oV/gLhrT8wTjVszApk7BCn3ODu4znmjaOupewPbH3M6
	v99GkNmOFvZvgDL2N0mEM2vsXjfsfXoPvSraB1gtMSZeeO2t0cDhMY85ncLwdgZu
	nD9S/PPN2473kMjy9D6bybeFT9hWNhmo91DzeY2BP/S45/ni7WvKVIPSn6pHZhP9
	sVACaBChCJW3p0P1ZBBKcR/f5z9OjFYoF+HjQ6wH4+nPwqyc/9/Tkznndv9eLXsn
	bmMfVq5WiYaey3zwY6+sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378255; x=1762464655; bh=20axvizTZT2tV+/0R2y+nx2ZQpSb
	DdV00V7pI9252X4=; b=u6agn8+0/dysdo6nEuaj3sNJAz+KFH4FKvFqOHKOuTF5
	fE7Er0Jyx1I5lL7mgkxdTH659z7AVwTrMDBber+kQ8stPvM7WagTl2mqIdGhl+RE
	8pCeF4rVlyiqhSDOHrW8CD9BdCGwS1v7UgcNB12cXPtTToWPQdKLjzxSDsXSoKwU
	l53p4SiyCvpxfJFZF2SQYPJUKvmW2higQmfeRqD6zhevl/+UZpHx2nvnS7IqwDd4
	lTShNyrpMyGFpxx8niPUYkCa34N4haPcZiepcXVBPxiGPg7rEnJXNegSrDberE1M
	pWD4V+gGEpFOlXYwbK0zml0yBptMoVTF46ZQoI7TrA==
X-ME-Sender: <xms:D8ILaYJNtnPw20ky6XcQZZMfSuKEfxk63V0s1V5NLNci7q9pwxV9Yg>
    <xme:D8ILaeJrrRYpeLNOSiz080uSxP8Kb6L7ERM71OsOGWC73O1wM_BxJ8A330JynZGRQ
    74Cx9Ztg2lN74O8xlat2gvI4QAA7eN2XwuyPRcwbgVftAr-F8WT9A>
X-ME-Received: <xmr:D8ILaWXxZBvYLZqOD79-jE8gL7uZGGafVPNz2CEmiVT81zvq-rTDd19hkWr9BvhChBIVgGa-VNhKx9wOzXl-QSfBH_v-SRdeE51O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:D8ILaQjP0aEHJoInR3O06wvg0TBJq7SPTGr-Apcm__5nsQghn_Ss6g>
    <xmx:D8ILaR_UfBv8-RlrtvOHd_Afkv445DpNBe-_KBSlicUXOs4PckBviA>
    <xmx:D8ILaaAW5uYU8_qG8bNIlTvgjHCGlz6Qqdxt-0aGBAVyIwyHQnGEuA>
    <xmx:D8ILaeIUYH8q_uB82KESwRxcrak2oHT6FDQCb7laM3egN403Lxtdew>
    <xmx:D8ILabhEmojOnhAtlqouXkiRWRr1UPV-AyVLzljBVBVs7LXFAiJULOEh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:30:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 01/12] whitespace: correct bit assignment comments
Date: Wed,  5 Nov 2025 13:30:41 -0800
Message-ID: <20251105213052.1499224-2-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0-105-gc08128fbb6
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
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
2.52.0-rc0-105-gc08128fbb6

