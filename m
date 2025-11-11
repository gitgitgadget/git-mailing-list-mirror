Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E017E4
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819498; cv=none; b=IbA39o3b0J2puJ2OsFv24NtCux4Srf3qEf1hB2s4uuoHq5HiqoqHYiB7GrRAOIjXf7b26dn5oBq+hFLwNfj5OQ6CzquLUZOK5VBK/tO/8ftJComT2KfEL6wSm8lABVT0Jh3pFmCN6GiHOjnytXOwmN55ktnbDI1up2rwMLxG/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819498; c=relaxed/simple;
	bh=sfO/mOiZYE3t8ilfAA7r7CVOS3qjf2e/P6c7fl1TnSw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9ZqifGhz5bmk8v07X9V0eMGwyCBjSN0MihhIYKl5XuFGSBoQ9gzq7H8veSaKWYqtRV90NHfZ1Kd842Jtx/Nk4+9KddhVAyKfpyARL4vZ9rtBNdsf9lKvAe8XWWQjleoxyELhzwHpwiT7QEoGD8hXMb+pU0PVgPyXbFOtkPhbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aebkw6eW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMcz4aKh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aebkw6eW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMcz4aKh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0C657A00B2;
	Mon, 10 Nov 2025 19:04:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 19:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819495; x=
	1762905895; bh=0wJJT4LfrvTq/JdVxlrWvqVIQ8VrXlICf2fmFb6Ynb8=; b=a
	ebkw6eWnzBNcs8Mzr1genQqgh9ac5Sc5iWU9Whx/FgV1kRtNQgVh+l0UFnmiP43e
	dwvWurv6CwID+zJMszapAWsOnfF91HGvLTfBHw5iBSVz0kvRNovCAmBeF3JfVUwb
	BxzmC2py+XxFsQTff47KIC7gw2PWU9LSEjwGYxsxPw6lQ2NWycZymWFrI2NhK35f
	5odmMr+hz5z3bll6zwCQCDZqffi8AbgjiAY+oOoX9xm1vPOgFe/N8dtcz2xvwVH0
	1PXZ8glS/j0jDiuBZVmCrFp4TbB99uCNDTPXL0Xdv4XttNqzZ1HxdNUZXFtxo1PN
	7lkCfyygOr1zQu21JcF4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819495; x=1762905895; bh=0wJJT4LfrvTq/JdVxlrWvqVIQ8Vr
	XlICf2fmFb6Ynb8=; b=vMcz4aKh/E7sM6yRQjictAoUvQYGCU3IYm07iHSrn3H7
	qJEE+7ChuKeJGgFSCPldX2t5huy/hr6NOgg/i1X2rzusf/6E35pvy8LIXWjNF+QH
	Y95CdwWyZdh8EeBCmzeFMsBqS/u52a9IoML4roVvkxsVIwN8d3G710rf7eM11y+f
	pVaa9P6ZsK0cxgQvIuGSzEoJF9wluKbfQWrpXi2mW8j0dIzr2Gd2O0iQtKF5GrtH
	Y5AtrBeE7O0l89RbdY5DcMrFGQsh2Go0CMdcRlxIYZXoe2KBCk1af1rBbmGr9xJL
	k2rjK75T8EWFNfze+bw3aBNIkq/9T9gTOuf5lNSo7A==
X-ME-Sender: <xms:p30SaR97vCVpGtEa3yha3gC6pbe23pDfWSRyaZsIdk2jHiDINRBJqg>
    <xme:p30SabvlBaOwOwvlwFN_N1nkyVFeyBWWE0bM9bC6AHJdSlwmImQtOTUlseM0rR2z2
    mwTQpEgLoM4oUbqlFoMgkIAAB69ImHLJGRrBEvJn0xJopXHzLP1>
X-ME-Received: <xmr:p30SacrIldw9N5izpNcjygwmAt0mWLvUEaVsFDRI-vLr688iOEle8c_tMevLdEQUacpOBFAXpWgNoLFv46-nhktWZoXNeai4H0XS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:p30SaQlDPuwchtXl8tzQG_vRz5PH5TI3Jv_G8zrmHAID5-UnhGZCaA>
    <xmx:p30SaYwezwo2wHRK6DGiUxQcpwt9XRSgAKtvzy1CTqaIjE_FHFCuTg>
    <xmx:p30SaQm1Sd7f8eyC8nnChNf0Fbe406k_TtgTECehuCwnFE5qmGiyBQ>
    <xmx:p30SaZfd6Gt-4KHv0ai_jG_MqS6PdhcMOzvEKO9iDxINHxRy77UOPw>
    <xmx:p30SadWEoNUXlWdbFaenx2k6QCkzJh26CqOIbnrn1Jmdd_De1gejdsS9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:04:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 01/12] whitespace: correct bit assignment comments
Date: Mon, 10 Nov 2025 16:04:40 -0800
Message-ID: <20251111000451.2243195-2-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111000451.2243195-1-gitster@pobox.com>
References: <20251105213052.1499224-1-gitster@pobox.com>
 <20251111000451.2243195-1-gitster@pobox.com>
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
2.52.0-rc1-455-g30608eb744

