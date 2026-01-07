Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726D1F5834
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 01:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749492; cv=pass; b=nntID/EfPHhY0QvY22Kdp1bnVKS5q1OcLm2euKAfIiigsUl+4WwyuR3bPP+2pURGDkvHV2GP111btRuf975G/X6WwNfe+zhpXKJCfD+hkwcMKm2rl0LX36zCiqtvVwYa5C3+f0u0dGN1HWmF1SlacaX28145CB/iwFJG2Myfv7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749492; c=relaxed/simple;
	bh=nb/a4YhF8G4YJyC6B7zGlAIDe8M6W1OvO8x6x/1k8SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Js3A0o/Wmw9ynjDjW4CBHTRCNDEyAeoexWjCFE3aqGFKd8iqOENd7pEeR6OtG5UyDCu/0LyUuuCPVSju7ZY/kySOVrZ/RorHe+fGDB0Xg7EZ2Ve0fSH9cf4puJsR9+UZZs6UDVNEiuDpOJrcDcZI3ZVR3KR3YL3dUOMeb8IgMb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=c6dbU+Dq; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="c6dbU+Dq"
ARC-Seal: i=1; a=rsa-sha256; t=1767749481; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jPfjoVMTYSOX5OjuJic4BwBs8ugc2Og73FhPqKJ3SKroniRNhVdRsjNJNo6s9XUYrZ6u3jB+xyEEBHZ/UUwukPeInD1RFfqbrAZpEiA/kruB+ophw9GkLen9x5lB75MYkNXAEg5fXfN1Wojq2VfG9VPoLrgrXG+T36QnL8OAupI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767749481; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GopSBtrtyZ7/XyZJuVqyWVbXcvmEbbg79oXQtuS5wYE=; 
	b=LpkVK8vYGzTxWWIMZQDEAmGypWzEqA1Ey0Pz4ADVYzGX0NNtFq5uHKd7U0uurWlMHf6ZuUkw6Zo5aImVe5QvVLc8MsMRp6+LG1vBA00nOtbQZZgmdwp6NFfLpNT+ktJdeuYTEbUtfmGttrYSb8pwr+dq7qadf771UJgUGFrde7o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767749481;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GopSBtrtyZ7/XyZJuVqyWVbXcvmEbbg79oXQtuS5wYE=;
	b=c6dbU+DqNGTxTeK8mfjaNUdawZshXlq7n0qo6/tcW4mOvGPP1iZdxa8WF0kS8dhn
	OQrRxo5mnNCRlsQyMjPqXD0DKeaejHraN3Cd8FuFp1HLTHjzCFu+Lj555LsXOiuzMwW
	fJIhVOz4XFpphSAqS9jbTg0Wecghl0pew+MaAXyE=
Received: by mx.zohomail.com with SMTPS id 1767749478522254.38202698323073;
	Tue, 6 Jan 2026 17:31:18 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2] ws: add new tab-between-non-ws check
Date: Wed,  7 Jan 2026 03:30:51 +0200
Message-ID: <20260107013051.312291-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds a new check to detect HT in the middle of sentences that
should have been a SP, as suggested by Junio in
https://public-inbox.org/git/xmqqy0mwsedz.fsf@gitster.g/

The check is a bit complex because we want to detect places where
a SP was intended (HT can expand to more than one display column),
so we need to count both the display columns (col) and the string
character columns (i) to determine if a HT looks identical to a SP
or can cause confusion.

Highlighting support for tools like git diff/show/log is added, as
well as git apply --whitespace=fix capability.

The middle section of the line used to be assumed non-highlighted,
which is obviously not true anymore, so we split its logic into a
separate function named emit_middle_section().

The new check is enabled for Documentation/**/*.adoc, where these
kinds of mistakes were seen in practice. It can also be enabled in
other locations where it can be useful, by adding to the relevant
attributes file.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes in v2:
* Highlight the new error in ws_check_emit_1() output generation so
  tools like color git diff can show the errors to the user (Junio)
* Expanded ws_fix_copy to detect and fix this new error (Junio)
* Added more test cases for the above new functionality (Junio)
* Improved commit message (Junio)

Based on the latest master branch.
Pushed to GitHub: https://github.com/10ne1/git/tree/dev/aratiu/whitespace-new-test-v2
Successful CI run: https://github.com/10ne1/git/actions/runs/20766920987
---
 .gitattributes             |   2 +-
 t/t4015-diff-whitespace.sh | 143 +++++++++++++++++++++++++++++
 ws.c                       | 179 ++++++++++++++++++++++++++++++++++---
 ws.h                       |   1 +
 4 files changed, 313 insertions(+), 12 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 700743c3f5..d3c40a038b 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -7,7 +7,7 @@
 *.py text eol=lf diff=python
 *.bat text eol=crlf
 CODE_OF_CONDUCT.md -whitespace
-/Documentation/**/*.adoc text eol=lf whitespace=trail,space,incomplete
+/Documentation/**/*.adoc text eol=lf whitespace=trail,space,incomplete,tab-between-non-ws
 /command-list.txt text eol=lf
 /GIT-VERSION-GEN text eol=lf
 /mergetools/* text eol=lf
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 3c8eb02e4f..f5b6ceeed9 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2440,4 +2440,147 @@ test_expect_success 'combine --ignore-blank-lines with --function-context 2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check tab between non-whitespace (tab-between-non-ws: off)' '
+	git config core.whitespace "-tab-between-non-ws" &&
+
+	printf "1234567\tb" >x &&
+	git add x &&
+	git diff --cached --check &&
+
+	git diff --cached --color >raw &&
+	test_decode_color <raw >actual &&
+	! test_grep "<GREEN>1234567<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&
+	test_grep "<GREEN>1234567	b<RESET>" actual &&
+
+	# should apply without error because tab-between-non-ws is off
+	git diff --cached >patch.diff &&
+	git checkout HEAD -- x &&
+	git apply --whitespace=error patch.diff
+'
+
+test_expect_success 'check tab between non-whitespace at tab stop (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
+	printf "1234567\tb" >x &&
+	git add x &&
+	test_must_fail git diff --cached --check &&
+
+	git diff --cached --color >raw &&
+	test_decode_color <raw >actual &&
+	test_grep "<GREEN>1234567<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&
+	! test_grep "<GREEN>1234567	b<RESET>" actual &&
+
+	git diff --cached >patch.diff &&
+	git checkout HEAD -- x &&
+	test_must_fail git apply --whitespace=error patch.diff &&
+	git apply --whitespace=fix patch.diff &&
+	printf "1234567 b" >expected &&
+	test_cmp expected x
+'
+
+test_expect_success 'check tab between non-whitespace not at tab stop (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
+	printf "a\tb" >x &&
+	git add x &&
+	git diff --cached --check &&
+
+	git diff --cached --color >raw &&
+	test_decode_color <raw >actual &&
+	! test_grep "<GREEN>a<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&
+	test_grep "<GREEN>a	b<RESET>" actual &&
+
+	# should apply without error because the input is valid
+	git diff --cached >patch.diff &&
+	git checkout HEAD -- x &&
+	git apply --whitespace=error patch.diff
+'
+
+test_expect_success 'check tab between non-whitespace with tabwidth=4 (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=4" &&
+	printf "123\tb" >x &&
+	git add x &&
+	test_must_fail git diff --cached --check &&
+
+	git diff --cached --color >raw &&
+	test_decode_color <raw >actual &&
+	test_grep "<GREEN>123<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&
+	! test_grep "<GREEN>123	b<RESET>" actual &&
+
+	git diff --cached >patch.diff &&
+	git checkout HEAD -- x &&
+	test_must_fail git apply --whitespace=error patch.diff &&
+	git apply --whitespace=fix patch.diff &&
+	printf "123 b" >expected &&
+	test_cmp expected x
+'
+
+test_expect_success 'check tab between non-whitespace with tabwidth=4 (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=4" &&
+	printf "1234\tb" >x &&
+	git add x &&
+	git diff --cached --check &&
+
+	git diff --cached --color >raw &&
+	test_decode_color <raw >actual &&
+	! test_grep "<GREEN>1234<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&
+	test_grep "<GREEN>1234	b<RESET>" actual &&
+
+	# should apply without error because tab is at tab stop
+	git diff --cached >patch.diff &&
+	git checkout HEAD -- x &&
+	git apply --whitespace=error patch.diff
+'
+
+test_expect_success 'check multiple tabs with one error (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
+	printf "a\t1234567\tb" >x &&
+	git add x &&
+	test_must_fail git diff --cached --check &&
+
+	git diff --cached --color >raw &&
+	test_decode_color <raw >actual &&
+	test_grep "<GREEN>a	1234567<RESET><BLUE>	<RESET><GREEN>b<RESET>" actual &&
+	! test_grep "<GREEN>a	1234567	b<RESET>" actual &&
+
+	git diff --cached >patch.diff &&
+	git checkout HEAD -- x &&
+	test_must_fail git apply --whitespace=error patch.diff &&
+	git apply --whitespace=fix patch.diff &&
+	printf "a\t1234567 b" >expected &&
+	test_cmp expected x
+'
+
+test_expect_success 'check tab at beginning of line (tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,tabwidth=8" &&
+	printf "\ta" >x &&
+	git add x &&
+	git diff --cached --check &&
+
+	git diff --cached --color >raw &&
+	test_decode_color <raw >actual &&
+	! test_grep "<BLUE>	" actual &&
+	test_grep "<GREEN>+<RESET>	<GREEN>a<RESET>" actual &&
+
+	# should apply without error because tab is a valid indentation
+	git diff --cached >patch.diff &&
+	git checkout HEAD -- x &&
+	git apply --whitespace=error patch.diff
+'
+
+test_expect_success 'check tab at end of line(tab-between-non-ws: on)' '
+	git config core.whitespace "tab-between-non-ws,-trailing-space,tabwidth=8" &&
+	printf "a\t" >x &&
+	git add x &&
+	git diff --cached --check &&
+
+	git diff --cached --color >raw &&
+	test_decode_color <raw >actual &&
+	! test_grep "<GREEN>a<RESET><BLUE>	" actual &&
+	test_grep "<GREEN>a	<RESET>" actual &&
+
+	# should apply without error because tab is caught by another check (trailing-space)
+	git diff --cached >patch.diff &&
+	git checkout HEAD -- x &&
+	git apply --whitespace=error patch.diff
+'
+
 test_done
diff --git a/ws.c b/ws.c
index 6cc2466c0c..633bc69418 100644
--- a/ws.c
+++ b/ws.c
@@ -26,6 +26,7 @@ static struct whitespace_rule {
 	{ "blank-at-eol", WS_BLANK_AT_EOL, 0 },
 	{ "blank-at-eof", WS_BLANK_AT_EOF, 0 },
 	{ "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
+	{ "tab-between-non-ws", WS_TAB_BETWEEN_NON_WS, 0 },
 	{ "incomplete-line", WS_INCOMPLETE_LINE, 0, 0 },
 };
 
@@ -140,6 +141,11 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "tab in indent");
 	}
+	if (ws & WS_TAB_BETWEEN_NON_WS) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "tab between non-whitespace characters");
+	}
 	if (ws & WS_INCOMPLETE_LINE) {
 		if (err.len)
 			strbuf_addstr(&err, ", ");
@@ -148,6 +154,80 @@ char *whitespace_error_string(unsigned ws)
 	return strbuf_detach(&err, NULL);
 }
 
+static void emit_literal(const char *line, int len, FILE *stream)
+{
+	fwrite(line, len, 1, stream);
+}
+
+static void highlight_tabs(const char *line, int len,
+			   int written, int trailing_whitespace,
+			   unsigned ws_rule, FILE *stream,
+			   const char *set, const char *reset, const char *ws)
+{
+	int tabwidth = ws_tab_width(ws_rule);
+	int start = written, col = 0;
+
+	if (!tabwidth)
+		BUG("a known tabwidth is required by WS_TAB_BETWEEN_NON_WS");
+
+	/*
+	 * Calculate the visual column position (col) up to 'written'.
+	 * Tabs expand based on 'tabwidth', so for example the 5th character in a
+	 * string might be at the 12th visual column, if the line contains tabs.
+	 */
+	for (int i = 0; i < written; i++) {
+		if (line[i] == '\t')
+			col += tabwidth - (col % tabwidth);
+		else
+			col++;
+	}
+
+	/* Iterate through the section of the line that needs potential highlighting. */
+	for (int i = written; i < trailing_whitespace; i++) {
+		if (line[i] == '\t') {
+			if (i > 0 && i < len - 1 &&
+			    !isspace(line[i - 1]) && !isspace(line[i + 1]) &&
+			    (col % tabwidth) == (tabwidth - 1)) {
+				/* Print unwritten content before the highlighted tab. */
+				if (start < i)
+					emit_literal(line + start, i - start, stream);
+
+				/* Apply highlight for the tab. */
+				fputs(reset, stream);
+				fputs(ws, stream);
+				fputc('\t', stream);
+				fputs(reset, stream);
+				fputs(set, stream);
+				start = i + 1;
+			}
+			col += tabwidth - (col % tabwidth);
+		} else {
+			col++; /* non-tab character. */
+		}
+	}
+
+	/* Print any remaining content in the current segment after the last highlight. */
+	if (start < trailing_whitespace)
+		emit_literal(line + start, trailing_whitespace - start, stream);
+}
+
+static void emit_middle_section(const char *line, int len,
+			       int written, int trailing_whitespace,
+			       unsigned ws_rule, unsigned result,
+			       FILE *stream, const char *set,
+			       const char *reset, const char *ws)
+{
+	fputs(set, stream);
+
+	if (result & WS_TAB_BETWEEN_NON_WS)
+		highlight_tabs(line, len, written, trailing_whitespace,
+			       ws_rule, stream, set, reset, ws);
+	else
+		emit_literal(line + written, trailing_whitespace - written, stream);
+
+	fputs(reset, stream);
+}
+
 /* If stream is non-NULL, emits the line after checking. */
 static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 				FILE *stream, const char *set,
@@ -228,19 +308,41 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		written = i;
 	}
 
-	if (stream) {
+	if (ws_rule & WS_TAB_BETWEEN_NON_WS) {
 		/*
-		 * Now the rest of the line starts at "written".
-		 * The non-highlighted part ends at "trailing_whitespace".
+		 * A tab surrounded by non-whitespace characters is a typo candidate
+		 * (a space might have been intended). This checks for a tab that
+		 * would be expanded to a single space, which is when it appears at
+		 * a column that is one less than a multiple of the tabwidth.
 		 */
-
-		/* Emit non-highlighted (middle) segment. */
-		if (trailing_whitespace - written > 0) {
-			fputs(set, stream);
-			fwrite(line + written,
-			    trailing_whitespace - written, 1, stream);
-			fputs(reset, stream);
+		int col = 0;
+		int tabwidth = ws_tab_width(ws_rule);
+
+		if (!tabwidth)
+			BUG("a known tabwidth is required by WS_TAB_BETWEEN_NON_WS");
+
+		for (i = 0; i < len; i++) {
+			if (line[i] == '\t') {
+				if (i > 0 && i < len - 1 &&
+				    !isspace(line[i - 1]) && !isspace(line[i + 1]) &&
+				    (col % tabwidth) == (tabwidth - 1))
+					result |= WS_TAB_BETWEEN_NON_WS;
+				col += tabwidth - (col % tabwidth);
+			} else {
+				col++;
+			}
 		}
+	}
+
+	if (stream) {
+		/*
+		 * The middle section of the line starts at "written" and ends at
+		 * "trailing_whitespace".
+		 */
+		if (trailing_whitespace - written > 0)
+			emit_middle_section(line, len, written, trailing_whitespace,
+					    ws_rule, result,
+					    stream, set, reset, ws);
 
 		/* Highlight errors in trailing whitespace. */
 		if (trailing_whitespace != len) {
@@ -299,6 +401,7 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 	int last_tab_in_indent = -1;
 	int last_space_in_indent = -1;
 	int need_fix_leading_space = 0;
+	size_t pre_indent_len = dst->len;
 
 	/*
 	 * Remembering that we need to add '\n' at the end
@@ -401,7 +504,61 @@ void ws_fix_copy(struct strbuf *dst, const char *src, int len, unsigned ws_rule,
 		fixed = 1;
 	}
 
-	strbuf_add(dst, src, len);
+	if (!(ws_rule & WS_TAB_BETWEEN_NON_WS)) {
+		/*
+		 * Middle section does not need fixing, so just append src to
+		 * dst because it already contains the previous ws fixes.
+		 */
+		strbuf_add(dst, src, len);
+	} else {
+		/* Fix middle section HTs which expand to a single display space */
+		const char *indent_part = dst->buf + pre_indent_len;
+		int indent_len = dst->len - pre_indent_len;
+		int tabwidth = ws_tab_width(ws_rule);
+		int col = 0;
+
+		if (!tabwidth)
+			BUG("a known tabwidth is required by WS_TAB_BETWEEN_NON_WS");
+
+		/*
+		 * Compute indentation display column length because it might not
+		 * end at a fixed tab stop position.
+		 */
+		for (i = 0; i < indent_len; i++) {
+			if (indent_part[i] == '\t')
+				col += tabwidth - (col % tabwidth);
+			else
+				col++;
+		}
+
+		/* Go through all chars in src, fix if necessary, and append to dst */
+		for (i = 0; i < len; i++) {
+			char prev_ch = i > 0 ? src[i - 1] :
+				(indent_len > 0 ? indent_part[indent_len - 1] : '\0');
+			char next_ch = i < len - 1 ? src[i + 1] : '\0';
+			bool needs_fixing = prev_ch && next_ch &&
+				!isspace(prev_ch) && !isspace(next_ch) &&
+				(col % tabwidth) == (tabwidth - 1);
+
+			/* non HT chars are added as is */
+			if (src[i] != '\t') {
+				strbuf_addch(dst, src[i]);
+				col++;
+				continue;
+			}
+
+			/* fix HT or add them as is */
+			if (needs_fixing) {
+				strbuf_addch(dst, ' ');
+				col++;
+				fixed = 1;
+			} else {
+				strbuf_addch(dst, '\t');
+				col += tabwidth - (col % tabwidth);
+			}
+		}
+	}
+
 	if (add_cr_to_tail)
 		strbuf_addch(dst, '\r');
 	if (add_nl_to_tail)
diff --git a/ws.h b/ws.h
index 06d5cb73f8..35475fd320 100644
--- a/ws.h
+++ b/ws.h
@@ -16,6 +16,7 @@ struct strbuf;
 #define WS_BLANK_AT_EOF         (1<<10)
 #define WS_TAB_IN_INDENT        (1<<11)
 #define WS_INCOMPLETE_LINE      (1<<12)
+#define WS_TAB_BETWEEN_NON_WS   (1<<13)
 
 #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
-- 
2.51.2

