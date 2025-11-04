Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F52459ED
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222191; cv=none; b=Y/QZLPnpIUBDer0fwSL0KzFadPKiGhUkuKpFpMOcVCcfWhjCKBaSW2nC1jXjnOfwE7qsEPM52i/6DzC9Mvo/+6cJb5DEhb8kwCEDBCNDLa2u6VWKRFbQsP7LA0N4adSuiFZN2C+5DqThIzJTo1/CdJzR105ObXnovTcKil55I7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222191; c=relaxed/simple;
	bh=9cESc2ouliOrCtsIPzZfmlTUkFjniNsCD/aPkAx3MK8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYwodE3pddkzPxqwLLMq/2xFd8/3ayQ0WWQPvhZZKww8VhjrU0AKe2iPaLAayKIvOrR7DTRdntxI4KB2EUWcw8eq3noKxm0rd8a04OloVgGJSliGcayZEyTL/B7mSB0Xejlg1/Rq52FQPebQKXmpfRnt57XKPxSxNbH3SX1aV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kjE7u8cu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3kfWSIO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kjE7u8cu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3kfWSIO"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3A637A03F6;
	Mon,  3 Nov 2025 21:09:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 03 Nov 2025 21:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222188; x=
	1762308588; bh=z/N4V+WRCopOqY23QJiydcFNdIobbCKin51yP5oAGXY=; b=k
	jE7u8cuqz7HVlZo9Hrdbo/K+DIg9gYsHCU+9JTdtFxvYkIGWGM25t4TRm+QjqkJO
	ijffljTaPUiOBFd7zPhSXqaHTSK3fXDIhOFW45zlrh8jlyamdNm69LurNfF4aXQU
	QLGt0u05pgFdVWk/PeyIKFxk3feggkORsdpTW2mw4HP/+ksh1aRtc452P8OPX3S5
	WCLr8IAJMsKK7LEs6/fE7N18cWoUpMYWtfqNQEOkB+Y4lck4mqt69J3kG/lJTAso
	c6PKGVWOQiCztajs2khTzkuE/1mn202/kJdsHpHaN+T5dAoHyQFbb8UDRX6YpfWC
	Sq7LVUNFuvTgJbnWiwwzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222188; x=1762308588; bh=z/N4V+WRCopOqY23QJiydcFNdIob
	bCKin51yP5oAGXY=; b=O3kfWSIOIsgoEiKvJDq3YMAz4FMZHstmuCHvtt/FfzoR
	QjhBiJqn9GceEMhvzBdsyyiKyOwJwkudLRazqxxmh/os8+YO8Z/wCeVg01osRD3X
	+VQ5pcFDPJdAHq7JCfS5EVj/Vmtpual2+oznCjJknwNut5A1c0E2KN24YQmNIJRz
	XnpIk6a+w9MMoqetWeHe2cv8U6hCzupbU9lI7bZe+AkC2uP0L8r9gtSdXJm5Y70E
	L/9dpZDpa1/hc5JdvhRrE4X+w543TC9jLkquLdEcdzJ+J37jxy99nHnj0bd5rgsB
	E2UPcHuEveJU/gInDc8zjkSgNaAx4kDzEfTV2dFv2A==
X-ME-Sender: <xms:bGAJad_HWFtu3vZCP_1rDYRNpRDjET2b9-deCcpeg1UWbuNSDLP4QA>
    <xme:bGAJaXsThySraHQTepuV_8ewZ1qkc5AjtOnvOOC0-aCXuvl7UYRTEE7cQwOa0BAzS
    WKgw09j7tN8ddL0PrvihwotytCVmbIL0gILnhtQXlOU2XPCpzM6UA>
X-ME-Received: <xmr:bGAJaYrDsLzJnef_j7qANaLGv6PkNoFhDBBmV0vrn-seWQLzHuqzM5-JQeve8aSl4MIAxSMtjJ8JnPrze4WxeyZrFT-aebYYGAk9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:bGAJacmGAz7DH-W0W5Mc33y9cQQR8eRzo2HKC_IoJ95jsi8rdNi-yA>
    <xmx:bGAJaUx3qwv9Pw2jJcLZHJ4PR_b_nmHXMW8f6tf6EM8nFxsoKY25xg>
    <xmx:bGAJacn-14S66mwYwT5exZ8U16XOWqPSh-zn1plCJw1OqKMipcA2Iw>
    <xmx:bGAJaVfEwKkqyMwbyhWwdt3kZf73h8h-YQ7jpOvWbrR8nAbiXu3zAg>
    <xmx:bGAJaZUxIp0ItUHIb_n7mbGk7775d2du0hhLd3m5DKEap9jWK5CTlyzp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 10/12] apply: check and fix incomplete lines
Date: Mon,  3 Nov 2025 18:09:26 -0800
Message-ID: <20251104020928.582199-11-gitster@pobox.com>
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

The final line of a file that lacks the terminating newline at its
end is called an incomplete line.  In general they are frowned upon
for many reasons (imagine concatenating two files with "cat A B" and
what happens when A ends in an incomplete line, for example), and
text-oriented tools often mishandle such a line.

Introduce a new whitespace rule "incomplete-line", which is off by
default for backward compatibility's sake, so that "git apply
--whitespace={fix,warn,error}" can notice, warn against, and fix
them.

As one of the new test shows, if you modify contents on an
incomplete line in the original and leave the resulting line
incomplete, it is still considered a whitespace error, the reasoning
being that "you'd better fix it while at it if you are making a
change on an incomplete line anyway", which may controversial.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4124-apply-ws-rule.sh | 112 +++++++++++++++++++++++++++++++++++++++
 ws.c                     |  20 +++++++
 ws.h                     |   1 +
 3 files changed, 133 insertions(+)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 485c7d2d12..568805df31 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -556,4 +556,116 @@ test_expect_success 'whitespace check skipped for excluded paths' '
 	git apply --include=used --stat --whitespace=error <patch
 '
 
+test_expect_success 'check incomplete lines (setup)' '
+	rm -f .gitattributes &&
+	git config core.whitespace incomplete-line
+'
+
+test_expect_success 'incomplete context line (not an error)' '
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	(test_write_lines 1 2 3 0 5 && printf 6) >sample2-i &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample2-i >target &&
+	git diff-files -p target >patch &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error <patch &&
+	test_cmp sample2-i target &&
+
+	cat sample2-i >target &&
+	git apply --whitespace=error -R <patch &&
+	test_cmp sample-i target
+'
+
+test_expect_success 'last line made incomplete (error)' '
+	test_write_lines 1 2 3 4 5 6 >sample &&
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	cat sample >target &&
+	git add target &&
+	cat sample-i >target &&
+	git diff-files -p target >patch &&
+
+	cat sample >target &&
+	test_must_fail git apply --whitespace=error <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error -R <patch &&
+	test_cmp sample target &&
+
+	cat sample >target &&
+	git apply --whitespace=fix <patch &&
+	test_cmp sample target
+'
+
+test_expect_success 'incomplete line removed at the end (not an error)' '
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	test_write_lines 1 2 3 4 5 6 >sample &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample >target &&
+	git diff-files -p target >patch &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error <patch &&
+	test_cmp sample target &&
+
+	cat sample >target &&
+	test_must_fail git apply --whitespace=error -R <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample >target &&
+	git apply --whitespace=fix -R <patch &&
+	test_cmp sample target
+'
+
+test_expect_success 'incomplete line corrected at the end (not an error)' '
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	test_write_lines 1 2 3 4 5 7 >sample3 &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample3 >target &&
+	git diff-files -p target >patch &&
+
+	cat sample-i >target &&
+	git apply --whitespace=error <patch &&
+	test_cmp sample3 target &&
+
+	cat sample3 >target &&
+	test_must_fail git apply --whitespace=error -R <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample3 >target &&
+	git apply --whitespace=fix -R <patch &&
+	test_cmp sample target
+'
+
+test_expect_success 'incomplete line modified at the end (error)' '
+	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
+	(test_write_lines 1 2 3 4 5 && printf 7) >sample3-i &&
+	test_write_lines 1 2 3 4 5 6 >sample &&
+	test_write_lines 1 2 3 4 5 7 >sample3 &&
+	cat sample-i >target &&
+	git add target &&
+	cat sample3-i >target &&
+	git diff-files -p target >patch &&
+
+	cat sample-i >target &&
+	test_must_fail git apply --whitespace=error <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample3-i >target &&
+	test_must_fail git apply --whitespace=error -R <patch 2>error &&
+	test_grep "no newline" error &&
+
+	cat sample-i >target &&
+	git apply --whitespace=fix <patch &&
+	test_cmp sample3 target &&
+
+	cat sample3-i >target &&
+	git apply --whitespace=fix -R <patch &&
+	test_cmp sample target
+'
+
 test_done
diff --git a/ws.c b/ws.c
index 70acee3337..6cc2466c0c 100644
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
 
@@ -180,6 +186,9 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 	if (trailing_whitespace == -1)
 		trailing_whitespace = len;
 
+	if (!trailing_newline && (ws_rule & WS_INCOMPLETE_LINE))
+		result |= WS_INCOMPLETE_LINE;
+
 	/* Check indentation */
 	for (i = 0; i < trailing_whitespace; i++) {
 		if (line[i] == ' ')
@@ -291,6 +300,17 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 	int last_space_in_indent = -1;
 	int need_fix_leading_space = 0;
 
+	/*
+	 * Remembering that we need to add '\n' at the end
+	 * is sufficient to fix an incomplete line.
+	 */
+	if (ws_rule & WS_INCOMPLETE_LINE) {
+		if (0 < len && src[len - 1] != '\n') {
+			fixed = 1;
+			add_nl_to_tail = 1;
+		}
+	}
+
 	/*
 	 * Strip trailing whitespace
 	 */
diff --git a/ws.h b/ws.h
index c77d3b6b19..06d5cb73f8 100644
--- a/ws.h
+++ b/ws.h
@@ -15,6 +15,7 @@ struct strbuf;
 #define WS_CR_AT_EOL            (1<<9)
 #define WS_BLANK_AT_EOF         (1<<10)
 #define WS_TAB_IN_INDENT        (1<<11)
+#define WS_INCOMPLETE_LINE      (1<<12)
 
 #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
-- 
2.52.0-rc0

