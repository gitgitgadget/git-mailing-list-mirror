Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04D2E284A
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378272; cv=none; b=pQ4X9vtJ3As5eaNEc2i9WJjKXpowtRbTM03sHq589Gk+/MLkbf7bliN4AeVQ5A5bhb54xIZMPyxMpG7spvIo2SwCO1r7rPwF3pMbsmpZbYxj0q08L6RPv1K9HdfceZH6rAezOSiMfABszFXYPR3dxY8eyP8gLPf0pQvaji+DByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378272; c=relaxed/simple;
	bh=iRINCs4e6UNaaBhOoRuYHsfFSd+1rY5MNYDR9rPJizU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnGaYO9TcxiDxs4vQg8q/KQWzo3jJbM57fGxJzINmlOxdsKuJYrJ2OSkXzJ4ywPpresSPrA/mkxvDwN7RRqTB/33bS28dpedvg0QS8PG+iyKCI+tqVVaJ+r4Do3U1VHHxAWNubo4POWMbgQScwvusQpRxx+ahgPIZ7zWK6bj2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V8HXRjfi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JcUihU+M; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V8HXRjfi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcUihU+M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 073541D00055;
	Wed,  5 Nov 2025 16:31:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 16:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378269; x=
	1762464669; bh=596/vtxUbg21oOTISYDBkV3u8SDlHY3n8I6J9nsatLM=; b=V
	8HXRjfiFfiQL3w1RLJfMYxOmpOgpeZfOxHUsYSobgPApEEktcJDnPMxTLTL/FF+w
	u0Z0RRPJEoqIpeaPWyAkwisJwykMQH2JeMc5xBgyW2+atG9Daj0FFIxzBuOQlJcw
	RZs+J6E6+gzD0TqVENBsCK2lrh0JGDUnykuqoeQ0Z9eYQ0oarlXkOl0bP0JkSow8
	XzpXW/F+D0pg3ldBtMidheEWN+X/7GZ77hDO8iUelVhGGUnAfoBqIu7Mfru0RDW6
	Vcxk0/sgKXoY339I1nSunFTTGAZ9FA0BOsoNE3T8QJOJdjFRtoda9Iggz2qBMH/L
	ZixrJfkwvOe/qVU0ftl6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378269; x=1762464669; bh=596/vtxUbg21oOTISYDBkV3u8SDl
	HY3n8I6J9nsatLM=; b=JcUihU+MdEX7P6hrNzdGRX+/7Xs1TYKb9Sw06gHzAR+E
	L2mUQy56073Q2vfdt/+o6bZkxUFdAtGmen/3tcwYbFvYHbRvpPCs1CX66YYpCgn+
	pzqbs8M5V84+7TQPEvvSR41tBOGScgKmQciUDSVgMI8tpF3y/eT8OaMGUUowsUp7
	yVRxAwUVMTR9iqZ1U7sWaa/MmVBCB6/c4/znNQDWY8WorbBr5/oZaQcnQqJb7Rro
	DQkJHOD5XX53I8iP6kxQVmLf46wU9oIN1pRAizkF9YlCFgAuAUG6GGBLlR/zNx2T
	If01lNMWQ3vHm2PXmKVTDZwVir6xInqIBuEKPrEkEg==
X-ME-Sender: <xms:HcILaQhdfsI5SjSMf3Mx9zrpFkPNXalGaPjsN8ENUWI4R9pISluOsA>
    <xme:HcILafBrVuMNy_abV5jnYe7_mCyxut0vh4vDDx-0lTUT3hg2-dQ0VZrd8gG5tFRPM
    hp2ELUBCegG5blDlUCE7VIhLRWH3ktSJk6FlAVh15ZZJUa-YiMV1w>
X-ME-Received: <xmr:HcILaVuLTkbKCSIBODl3GXJM2eUG-mTt0KGQxzwZjpvFbBiCRjfNlDxnz5i1v3-ubUW2LQWqOjsNBtanFKQhAlE36y657VUJyYIq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:HcILacZgYwr818JvOTzpYAO4GASKWg7Wc3vIQp2wwJ5io39OlGO0ow>
    <xmx:HcILaQWWkImek2GWZlvp8WIo0fQ1oCL0aDNdo_Iv_S0o5__pHJHskA>
    <xmx:HcILaY5JjLmSHMi5G2pmGcW8C71S5iVAuSN_xAuCnUSPNq9RKAy-IQ>
    <xmx:HcILaTiYTdlDg-UZrNEoJT0JL_mH94chmVMf72cUZLsgqTJiSZeV6A>
    <xmx:HcILaZkf3KmSJp3bct4AwncsGsfsmZQwItneq7GKWMnOd0z5v6gEfjO_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 09/12] whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
Date: Wed,  5 Nov 2025 13:30:49 -0800
Message-ID: <20251105213052.1499224-10-gitster@pobox.com>
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

Reserve a few more bits in the diff flags word to be used for future
whitespace rules.  Add WS_INCOMPLETE_LINE without implementing the
behaviour (yet).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/core.adoc |  2 ++
 diff.c                         | 16 ++++++++--------
 diff.h                         |  6 +++---
 ws.c                           |  6 ++++++
 ws.h                           |  3 ++-
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index e2de270c86..682fb595fb 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -626,6 +626,8 @@ core.whitespace::
   part of the line terminator, i.e. with it, `trailing-space`
   does not trigger if the character before such a carriage-return
   is not a whitespace (not enabled by default).
+* `incomplete-line` treats the last line of a file that is missing the
+  newline at the end as an error (not enabled by default).
 * `tabwidth=<n>` tells how many character positions a tab occupies; this
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
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
diff --git a/ws.c b/ws.c
index 70acee3337..34a7b4fad2 100644
--- a/ws.c
+++ b/ws.c
@@ -26,6 +26,7 @@ static struct whitespace_rule {
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
+	{ "incomplete-line", WS_INCOMPLETE_LINE, 0, 0 },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -139,6 +140,11 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "tab in indent");
 	}
+	if (ws & WS_INCOMPLETE_LINE) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "no newline at the end of file");
+	}
 	return strbuf_detach(&err, NULL);
 }
 
diff --git a/ws.h b/ws.h
index 23708efb73..06d5cb73f8 100644
--- a/ws.h
+++ b/ws.h
@@ -15,13 +15,14 @@ struct strbuf;
 #define WS_CR_AT_EOL            (1<<9)
 #define WS_BLANK_AT_EOF         (1<<10)
 #define WS_TAB_IN_INDENT        (1<<11)
+#define WS_INCOMPLETE_LINE      (1<<12)
 
 #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
 #define WS_TAB_WIDTH_MASK       ((1<<6)-1)
 
 /* All WS_* -- when extended, adapt constants defined after diff.c:diff_symbol */
-#define WS_RULE_MASK            ((1<<12)-1)
+#define WS_RULE_MASK            ((1<<16)-1)
 
 extern unsigned whitespace_rule_cfg;
 unsigned whitespace_rule(struct index_state *, const char *);
-- 
2.52.0-rc0-105-gc08128fbb6

