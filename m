Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D42F5A0C
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984998; cv=none; b=rtPAiVUqwpTH48OCbFiiRMAekTlYWi9bdSapTSfyXZ2fiGsRrqKng4sDUZDRApGuKhXYdkFdTo/IYv2zAxPCKU0FiUL76EWOWWF9AQ+quHKEqv6oxhtcu0H5Dt39jvjr9XviO4n9WkE6JiPxqfZe5Vh0SaC9Y6vYDSf6hwHgRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984998; c=relaxed/simple;
	bh=YbcJCbojCjWhp+qUPDN4XsarDR+WOAY8Mwcvw/2GauU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqFkrgbUWtvQoQ6Z3i/yVdjQdu42jTsRV/xu2K5FhH/ZEJcu6wy7MRe9KPIlBqyidur8yZlnIY4nf5DgvjP6rCz1yjRA3cXyJbyKeW2x2iMTZABsicMqptCAZIlvHQ9QbZ2MndJ/qM4OBus7rlgY/5++znAwI4YUN9gaAiMT3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SkDJ2PwT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jjIbO0t4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SkDJ2PwT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjIbO0t4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D7BE7A00AF;
	Wed, 12 Nov 2025 17:03:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 12 Nov 2025 17:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984995; x=
	1763071395; bh=9wnu2YEbRxSw2myXnB63sCuxlvED5MqV/2aNlsdVh3Y=; b=S
	kDJ2PwTeOPO24iDYfajLLwmSsHPKwkIWb2bwb5uR4WPOt5FlLq2Vs5j2dLwV78Ma
	hFh/lSqAVCPnro88BGkevK1ie+HGjL0V5tQTtNQCt8tl6W9TIUNj4WjB4icFfTSc
	H1L2T3BhnGiICDkMmkjDYzctWksVSQFgkdILLFoILy/CsTvs1SL0hdon9AbbOZ5y
	gKM4XHGiF5SUn4aYwhiMcEodMM/fFFbkH1JdUrklW6NZjzivmYVFxc9WvMg+xQHz
	j8cURQg40EBHA7CZNhkKCKFnSy1Ij+UolIQ1qgLHtNjmzl1EUqDh4b/78QR+qP6Z
	RHdeXMnoz0qSqQk/kXLNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984995; x=1763071395; bh=9wnu2YEbRxSw2myXnB63sCuxlvED
	5MqV/2aNlsdVh3Y=; b=jjIbO0t4sWsus3UxZtgGizz/J5wSmBmuv7kTjKqBB69/
	y3uPmlGtBYlHO0DdMra9A0a/wrDeJP0nXsVnHBOMlrfiq2b23bgf5r1zILEIjvIE
	AWE45lR8n7UQBpazl8oqxBruF7pWLRJr8vkxBQowI5Pjs86qlYkJf0cGjilXjSf5
	yrwl61H7SjDginHbXOUA9PgKySNyyu+oBdaS5ZRKWg2aWQjZi2gTz1Q09+ClC9gE
	z9NkSyKeGfn9W3taRh9itr1NHGpbFuZOVCxVateiZMgt7OpLc1XvImkJS4rXUnzY
	5PjvFbzmFM2Dhb7YBPdeoq5vY6tgutwvEeoOhYpDMg==
X-ME-Sender: <xms:IwQVabwITz4CTXBV52H4visB518zxbj4qzlxe4qPtKiNuOhGZ2Y0IA>
    <xme:IwQVaZQ_Y3cyPMlZPcx5lSW8IBy2kucIRYbUc28o1tuEl1BG_3xsLcFbiHcM1Onb0
    L42ItW14dV3yaP4zuv7-dRwClOxIVpa29gyTMcQ2n2xJyw31G6W>
X-ME-Received: <xmr:IwQVaS8AGimIjkzORBqRP5f53WaSJWBdKrM-Bwyv8MEqyC_wW9Mvi7Qu5KaBHCzBOn8Ch-Dvb9fG_6P23JTtb-egv6VwCFVbWZ2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:IwQVaQqXavG4kGlSs-sYs3fNxkCNjTX36ZlLlz99csph2OkkwoL5AQ>
    <xmx:IwQVafnIE2FoPtKGx3X_Dg047uHEYv5juzUn6MDx38WkegCnznNCKQ>
    <xmx:IwQVaXIzIO3d8IcOsfVcNjAHw0ISOHP0ULjAF5T0dfaLdYRyc4VEIw>
    <xmx:IwQVaUwGmwmByXE_RstOgfBE_bDlgYnp8eoFroQ56l0NvtubOUhcwQ>
    <xmx:IwQVafIk46asIWTrV8m42rSJiLGflPXcjOFn53YXBQexOO0EUiup03KV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 09/12] whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
Date: Wed, 12 Nov 2025 14:02:55 -0800
Message-ID: <20251112220258.1009253-10-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
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
index 5c606409bb..1b27b15f84 100644
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
2.52.0-rc2-441-g030905368a

