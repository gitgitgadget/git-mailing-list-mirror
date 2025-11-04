Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318E23D7F4
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222189; cv=none; b=IZmXB8j8uFLJ2thvHDNp12xx9wB+oZOxssscHEEQJ4F57gX3F98+BvTCr19a3Nq+ze+4iZTjlqTti5boHoxAHjSXqG/4af7C6u6eVFzWveRi/qVq5VGnsw5+78/sYB5oz3+23cr5nNH0YHtGk5KI8OaYQj02g56d2jY92y+0P0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222189; c=relaxed/simple;
	bh=CQv/baKI5Q70jBgSxdXSwFmzBdv55XoEGozbZ/e0zSs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5/d7bjwTMxs/fzoMkkRxdamVYSm/w2bPH+Zm4nphOOPOkfGLEk3ECwDadZPVOhNPxnLwdyKQneura528o+JKaqK4QvwPJYzmbLMy6//Crne3nbAS3skbbcslkwqKPRniU2HvKpRa3Ip8wdJq8zA9QB/ERxtHDMcJy0P2kDOygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G03nNndw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ec3+J/6M; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G03nNndw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ec3+J/6M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E79C67A03F4;
	Mon,  3 Nov 2025 21:09:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 21:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222186; x=
	1762308586; bh=3FGigmdZrScHhbMm8cRy1B12PdFWiF4jqS4g58sjy/0=; b=G
	03nNndw6tN3LnttOZclwql7t0bBbdH7yxpUP6spWJab+Gzojau1JxV8aqdtKVWdi
	In+50MQqQoCgDYleg8lPQCLotX9ZZPou7Jnjs/HD9OCW8cZ9HQ6fDLLzcpP53PJr
	BFaR+Zc0uBfwrmZk4EHQMTL1bqIo8mY+wpI72NYyNvwi0NxWCE5TDcknfAL2Pc+D
	JSgRTF/Gxl88jcm/PaFTiJXL7VxQ7dEZ4I8qzlOnyuN+4bzgNfSLjw3tLwuqHFVf
	6zCnVSpIXJjH2yHFLXLPtkuPeyEEu8ysCeB2ejMtaFNveYfotzYBa0Wnw8+p8nMQ
	HZvN4E9HHjPYwOl+9GqrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222186; x=1762308586; bh=3FGigmdZrScHhbMm8cRy1B12PdFW
	iF4jqS4g58sjy/0=; b=ec3+J/6MDHu42lSNLf2bBzgW20wLP+F85m1OCoyaMHgK
	9IRzFLEZX6eV3vAXCUQt0ayqnl3GmtgvjSatPiyw1Y6WmPN1waTYKHjnRYVWNVTH
	7I1ydtq6OEZgtT05oabK6MTB7pKWduz/UlZUD3woD09IY2HiMBmW7yKIT5Jx03Np
	VZ1X/+7qOWemn6XiNaV7QU5JtnwMOoHk4F4Paks9lbd9QsgZsV4UMkHuAWsYEex8
	fhxVZaxGuDM2R+1fpf8DtjsUHY6nR9bhVysocTEkEUFePoAW2He07Lsk4iYCnfyC
	hIdoBWEuRGO0B9mZ/0b+L5Qr3CHZJgP5n9cYH8iF1g==
X-ME-Sender: <xms:amAJabho-5P3_AP5tYv2h_JxY5Fgfsb6kVLx9vTIrdGdWSWZuyED_A>
    <xme:amAJaYPcCTBW3ajx6J9BepSNuGQdFKHVgVxOD-2kImFShCRWW6fzp47fShsN-ZNMa
    O7KxmQ66xGMS6P9L7gxDXTdMtLf6IgSwAOEikSAFmRIjMQtegQ3gA>
X-ME-Received: <xmr:amAJac7e7loWuNl8hDNdUUOkIZEmi-Xz7W5-F8zQ-I0zU9UniaV23Yz1qYgKNviP4DKpMEZruEJZQtBtfvOmNwCyxZi_FiNGZqG6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepvdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:amAJaW1vkEf9D-Qb0MjyIsCPNI7g56OkjBa9egjDX1pSsbFA6lFb2g>
    <xmx:amAJadZKrxjC0Ao7m4cSc2WpGwaOrJodWO5gIaK61Nqhy0-dia6GpA>
    <xmx:amAJaeDTu2zzWIvnxsjz0iB8QG9n15ZdkC0s89YYRJuKdb_winvQLA>
    <xmx:amAJaf9tplBPTKTXsXppOQiO5L_b52niU3_c1G70UNLurraOZ3moDg>
    <xmx:amAJaWEg52VBxecMDSJg05jHil9Rd-CBQAmE3rgH4OLW8TFpjbLBnqzf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 09/12] whitespace: allocate a few more bits
Date: Mon,  3 Nov 2025 18:09:25 -0800
Message-ID: <20251104020928.582199-10-gitster@pobox.com>
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

Reserve a few more bits in the diff flags word to be used for future
whitespace rules.  No behaviour changes intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 16 ++++++++--------
 diff.h |  6 +++---
 ws.h   |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 99298720f4..8d03146aaa 100644
--- a/diff.c
+++ b/diff.c
@@ -804,15 +804,15 @@ enum diff_symbol {
 
 /*
  * Flags for content lines:
- * 0..11 are whitespace rules (see ws.h)
- * 12..14 are WSEH_NEW | WSEH_CONTEXT | WSEH_OLD
- * 16 is marking if the line is blank at EOF
- * 17..19 are used for color-moved.
+ * 0..15 are whitespace rules (see ws.h)
+ * 16..18 are WSEH_NEW | WSEH_CONTEXT | WSEH_OLD
+ * 19 is marking if the line is blank at EOF
+ * 20..22 are used for color-moved.
  */
-#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
-#define DIFF_SYMBOL_MOVED_LINE			(1<<17)
-#define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<18)
-#define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<19)
+#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<19)
+#define DIFF_SYMBOL_MOVED_LINE			(1<<20)
+#define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<21)
+#define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<22)
 
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
diff --git a/diff.h b/diff.h
index cbd355cf50..422658407d 100644
--- a/diff.h
+++ b/diff.h
@@ -331,9 +331,9 @@ struct diff_options {
 
 	int ita_invisible_in_index;
 /* white-space error highlighting */
-#define WSEH_NEW        (1<<12)
-#define WSEH_CONTEXT    (1<<13)
-#define WSEH_OLD        (1<<14)
+#define WSEH_NEW        (1<<16)
+#define WSEH_CONTEXT    (1<<17)
+#define WSEH_OLD        (1<<18)
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
diff --git a/ws.h b/ws.h
index 23708efb73..c77d3b6b19 100644
--- a/ws.h
+++ b/ws.h
@@ -21,7 +21,7 @@ struct strbuf;
 #define WS_TAB_WIDTH_MASK       ((1<<6)-1)
 
 /* All WS_* -- when extended, adapt constants defined after diff.c:diff_symbol */
-#define WS_RULE_MASK            ((1<<12)-1)
+#define WS_RULE_MASK            ((1<<16)-1)
 
 extern unsigned whitespace_rule_cfg;
 unsigned whitespace_rule(struct index_state *, const char *);
-- 
2.52.0-rc0

