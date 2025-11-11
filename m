Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296122E403
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819512; cv=none; b=J6pQUfvMo26B+LqG3C+k8Nvpoi6leqrA1Xm93bTh9YJMfnUeS9xE822MJy+wGMEglKoVtjSvbac+9AUlAdF6xr/rnK2eweLXVNJeu74mF/L0n9fdRjtUw8PTpnE2FvinQpsLDxPNKvdEaYQlFgiLV+C9AoUcF1ThhqNxnlJp3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819512; c=relaxed/simple;
	bh=IQTqukOjq0/KScJRQDoTgHYihgSQ41KCL5zIjriTv14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX4hiG875+pggCoSoHhqCZJAXs6DbXV8uERMtHeyHYAYoZIEozh+A6KIFPW+OJTJ7PfebtqEimMUNLC4Ol/YZLoCY9KI84rkZLw+7uhu8Gc+HaOuwliIsMuAoUfbZGoCKeq9AL8JP7G+LpI4goxIQqnejp+RSj69EQFr0PIDQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OVhPqG8D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4pRVbQy; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OVhPqG8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4pRVbQy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5016E1D001A0;
	Mon, 10 Nov 2025 19:05:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 10 Nov 2025 19:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819510; x=
	1762905910; bh=BnV700GXbXlkk7+Wh4EnqeBlmNqdjkupC0v9ztF52u8=; b=O
	VhPqG8DcSYqMT+1hnhsI9ookN8/u+nQxCTSlhT8GT9hlv/JDm2AuKyBRNR8g8UtF
	sIInocN754ugsxKQvNXJNkeeLyF8pKefJ3epkmMV8lQ2DtRDvfMf8ynRggFUAqQ8
	t35J6HZc0ceB+yFqt1ASiozhDo0mkt1lenH/gDqo4PN+zWYwRhdEj8DTupjd8lQ2
	hg+zyEtXBYcWsUkm3Mzcma7OmB5wKpTYzQBotFNx2S8UOf69Z+wvg1tssguJcCgO
	gsFdlUtgaYhFIs1SYRKXAgdj/quWRdJCYWZDDgLm4WWwNmqWnuv91Kr6heo5dHXM
	20XGwhMUm1QMPVDYtkblg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819510; x=1762905910; bh=BnV700GXbXlkk7+Wh4EnqeBlmNqd
	jkupC0v9ztF52u8=; b=T4pRVbQyp7GxANdbFe03HkqnUXKLEN2llqMr7XqORlkB
	RTuZHer0WsL7kMQW7ADh5UCS61+vyNAqsJcogjdlvZztU94lfA6rZpUTswSqd+Is
	LVqoTPrq5ueep+TJ6Htj+pag5I2LHxuYIBlJGH6ddlTvlynSTjC0R0Cd/Q9IwlAw
	N1CW8tqtlajzhHhdRKET2s4hZQpqLzGpWU9lvmkVGHMBFybssCb7Hc83JCr3wznS
	LwUwnhD2NAyYokXENOHCLl4GTRZnvP34az/ZDi4FOur2MZ5hJczZT1vxMBcr8plc
	P1xiWxdPlNEttgVn9b34jbykqFxfFLLZdHJDLoVSBQ==
X-ME-Sender: <xms:tX0Saa5YAGdSpzrmBqtC20dwyS9_ttf2wnwpBhJ83YQXvcrwdxPS1Q>
    <xme:tX0SaZ61zafg2iiZ5epipcmw3CDP3Hg7Z9RhIVvC-qhs_3U3Loo0y49SiP9Tyhakc
    b5rOVDCDud6RCHT_NoW0SRAS0Mf8t9nt7HFzUOLRU86I9M3p6w>
X-ME-Received: <xmr:tX0SaXE-s-mEGNLzoN3ZGrbmSGp_Pu6y8evm8SDwKE7m4o8zd7H6oV5h7gV1tum65jOOPD-Iu3UT-iSW3AzpQTIoFkVxyr368k-i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:tX0SaSRlcUFMjOZ6VWlHysm9Z7wC63qe5oalW2YQwggUqeezXEZEuA>
    <xmx:tn0SaQvmHB2Out0ZUPt51Jo6aFiPTqkrFTGCmIEOee_aplYnHdpH3w>
    <xmx:tn0SaRzAt5UCUTkEPtKJyFbSZHwsBEAQCbnn1m1UWJTVZHWX6cF7Cw>
    <xmx:tn0Saa6mOhO5UrV4CAMUKXijg3TQ_JAqL_AI7xGymmvLU6X4C_CDVA>
    <xmx:tn0SaeRVhfkDbyf9572_-U1NqsXWWE7ev2bkuI00KDQUIsjeqyCm_6yr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 09/12] whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
Date: Mon, 10 Nov 2025 16:04:48 -0800
Message-ID: <20251111000451.2243195-10-gitster@pobox.com>
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
index c3fb3015d6..64cf1f139f 100644
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
2.52.0-rc1-455-g30608eb744

