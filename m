Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB03115A1
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113895; cv=none; b=JRFKpkEDIQrQvxSk12DipgCmijF69YBChyyn4jd9QxyTOKtBqaBCgo69gP2So7fLjAF0hT0YOQNKFiRvscQZdgRZU89HLQ0t2YjTQOu+Cl23TpAfzNlpK/1iGxbEj1z2x7uyLrONd7ZNCUwc5bJwa35tVZQuVV8j32t5IY9AQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113895; c=relaxed/simple;
	bh=yNYrvwcfd5r1r91f2g3wr5ucn4oLCzYTQj8edlJ5PPo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MP37oCKxYl6sEeit2s3t6cGab7iVXIe/b5UzSty9dKMbm8HcmpDov1BzemCzXihbj/fR1sbhrSncTSr+IsZiiK9zrMdDm/+IaUSoKiUQejQTH+7cj597j6rNldspUZL2a1czOSKOU0djQACggCOVFG+wf/iJafrHKyB9mspdYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq/6jaGk; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq/6jaGk"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b70abe3417so11640301eec.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113893; x=1770718693; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QctVCRZ1rxXoFemw4wgeie2Lkc+R3k48lN3nCwLm6P8=;
        b=dq/6jaGkpBK8XRYEmvhtJ+RJBujfaodlyQzI3v8KfW6ImDKU9Cx+lW4zuGrLsWqDIq
         F1NrEVSTDLDSsc2kZAw5vrxR4DnU+15ThwbvIMTRK5cppn6qgJyFG0WhxpQlN+hV9xb2
         67dImYijdG9dSk7lioIri7VyEndMhRKih39tynOv4XshrrKiIMUtgdcT6njA8vAxqrlB
         y+KEtLD+8TJFy26BQN/Qrtze3bfPRSqcXqLobcJ6te1+x2kw6lvL5DUkVoOVF/t99y5L
         Sj5uQDkQF54wFlHbODk3NZTIRS+WEBtMgFy0LH0rnMTrfAFPwJdFybJr7YCVsQJcZGLd
         Lp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113893; x=1770718693;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QctVCRZ1rxXoFemw4wgeie2Lkc+R3k48lN3nCwLm6P8=;
        b=AXHseDzd22dATnjx5x9+YLkDM7OUmWAMrlXP/gmVSxynAS4fhMG4MEpYWW7EFTo4Pc
         fqZVGDDajJE8G6sYuKU6TehhJa5YwVvsz2AyALcga6S7LpKjZiA5JEra6easPPD9QX3G
         jjtZLub8v5z+VJSANb1ZEZ3hsT0Ka7thcvVJJ1pANhcDpC8WupEEZIj0GYyh0shhTvoz
         SEboN2CoI1qSRGs8ZwUdf+gd+Uzus86Pt1BzS8ozafoOXbqoIF0kQGjLx84bQ09KP5iS
         hTaN2aDR8ciMtQzSZR23MMu0SOAWE4mozLdD1W9+KKh95XO+kN0Fltn5gFHDs0kmQqO4
         fFOA==
X-Gm-Message-State: AOJu0Yy7/Q/aTeJZ8w5yJb9Y53w8lHnbViQMLns2Z6bazWf+4ovVzmQb
	M67KvB3XCfuxLTsowB5N9I1cjuVsEdDgYPdiPBAUjxkcjRu4CEjxtSlNs7Wsrc17f8g=
X-Gm-Gg: AZuq6aIIwfFfDixz5mikhxISvdo4ksUSma+u2UNnSd9bD39jKmZwuGpRGcZ4zaeqtef
	HJ7Fh5+U2EFDAIq9Cbs54dBoNkJ56vjxHY8j3u9WB6WzpPhaZ3PsxRtOPNu7KkclduDebA5YvE7
	kItUlNzcFwTyhG2SQQTZJQ+PFUEGbHqueWqCJKDs3gE5tMtXZRsPSXSHJG7NiEFjbPOW9rcJLAo
	YycWdUqn3gEtYXEOGvB7WNIs4QBDQqQiz4LVqcGfbSVh9Nab5PyeS86sjh/6BrXUF8YScH1Pn2K
	V6jD5YlEhAzIhbDi72o/ESjvRorQHP5zkvuW3BbR1DvS7NJNZO9t2eLBrT0KK9OitamtgIEUaaS
	XzmVHJsUAYd4fWVpqqMPeDG41kxvX3PIs9T/wlqO9jQX2jeZzZoLoguLfsuwG50jv+iYbvQEOHr
	fxysd4nzYjB277Mg==
X-Received: by 2002:a05:7300:e7ab:b0:2b7:3281:6c33 with SMTP id 5a478bee46e88-2b7c86469a1mr6736653eec.12.1770113892461;
        Tue, 03 Feb 2026 02:18:12 -0800 (PST)
Received: from [127.0.0.1] ([128.24.162.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add4c2sm21800066eec.27.2026.02.03.02.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:18:10 -0800 (PST)
Message-Id: <ec48f1cba199d5ca466ad26cecfc4dfeb422fdf8.1770113882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 10:18:00 +0000
Subject: [PATCH v4 4/6] sideband: add options to allow more control sequences
 to be passed through
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andreas Schwab <schwab@linux-m68k.org>,
    Ondrej Pohorelsky <opohorel@redhat.com>,
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even though control sequences that erase characters are quite juicy for
attack scenarios, where attackers are eager to hide traces of suspicious
activities, during the review of the side band sanitizing patch series
concerns were raised that there might be some legimitate scenarios where
Git server's `pre-receive` hooks use those sequences in a benign way.

Control sequences to move the cursor can likewise be used to hide tracks
by overwriting characters, and have been equally pointed out as having
legitimate users.

Let's add options to let users opt into passing through those ANSI
Escape sequences: `sideband.allowControlCharacters` now supports also
`cursor` and `erase`, and it parses the value as a comma-separated list.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/sideband.adoc  |  9 ++-
 sideband.c                          | 91 ++++++++++++++++++++++++-----
 t/t5409-colorize-remote-messages.sh | 38 ++++++++++++
 3 files changed, 123 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index b55c73726f..2bf0426284 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -2,13 +2,20 @@ sideband.allowControlCharacters::
 	By default, control characters that are delivered via the sideband
 	are masked, except ANSI color sequences. This prevents potentially
 	unwanted ANSI escape sequences from being sent to the terminal. Use
-	this config setting to override this behavior:
+	this config setting to override this behavior (the value can be
+	a comma-separated list of the following keywords):
 +
 --
 	`default`::
 	`color`::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
 		but mask all other control characters. This is the default.
+	`cursor:`:
+		Allow control sequences that move the cursor. This is
+		disabled by default.
+	`erase`::
+		Allow control sequences that erase charactrs. This is
+		disabled by default.
 	`false`::
 		Mask all control characters other than line feeds and
 		horizontal tabs.
diff --git a/sideband.c b/sideband.c
index eeba6fa2ca..0b420ca319 100644
--- a/sideband.c
+++ b/sideband.c
@@ -29,9 +29,43 @@ static struct keyword_entry keywords[] = {
 static enum {
 	ALLOW_NO_CONTROL_CHARACTERS  = 0,
 	ALLOW_ANSI_COLOR_SEQUENCES   = 1<<0,
+	ALLOW_ANSI_CURSOR_MOVEMENTS  = 1<<1,
+	ALLOW_ANSI_ERASE             = 1<<2,
 	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
-	ALLOW_ALL_CONTROL_CHARACTERS = 1<<1,
-} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
+	ALLOW_ALL_CONTROL_CHARACTERS = 1<<3,
+} allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
+
+static inline int skip_prefix_in_csv(const char *value, const char *prefix,
+				     const char **out)
+{
+	if (!skip_prefix(value, prefix, &value) ||
+	    (*value && *value != ','))
+		return 0;
+	*out = value + !!*value;
+	return 1;
+}
+
+static void parse_allow_control_characters(const char *value)
+{
+	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
+	while (*value) {
+		if (skip_prefix_in_csv(value, "default", &value))
+			allow_control_characters |= ALLOW_DEFAULT_ANSI_SEQUENCES;
+		else if (skip_prefix_in_csv(value, "color", &value))
+			allow_control_characters |= ALLOW_ANSI_COLOR_SEQUENCES;
+		else if (skip_prefix_in_csv(value, "cursor", &value))
+			allow_control_characters |= ALLOW_ANSI_CURSOR_MOVEMENTS;
+		else if (skip_prefix_in_csv(value, "erase", &value))
+			allow_control_characters |= ALLOW_ANSI_ERASE;
+		else if (skip_prefix_in_csv(value, "true", &value))
+			allow_control_characters = ALLOW_ALL_CONTROL_CHARACTERS;
+		else if (skip_prefix_in_csv(value, "false", &value))
+			allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
+		else
+			warning(_("unrecognized value for `sideband."
+				  "allowControlCharacters`: '%s'"), value);
+	}
+}
 
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static enum git_colorbool use_sideband_colors(void)
@@ -55,13 +89,8 @@ static enum git_colorbool use_sideband_colors(void)
 		if (repo_config_get_string_tmp(the_repository, "sideband.allowcontrolcharacters",
 					      &value))
 			; /* huh? `get_maybe_bool()` returned -1 */
-		else if (!strcmp(value, "default"))
-			allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
-		else if (!strcmp(value, "color"))
-			allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
 		else
-			warning(_("unrecognized value for `sideband."
-				  "allowControlCharacters`: '%s'"), value);
+			parse_allow_control_characters(value);
 		break;
 	default:
 		break; /* not configured */
@@ -94,7 +123,7 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
-static int handle_ansi_color_sequence(struct strbuf *dest, const char *src, int n)
+static int handle_ansi_sequence(struct strbuf *dest, const char *src, int n)
 {
 	int i;
 
@@ -106,14 +135,47 @@ static int handle_ansi_color_sequence(struct strbuf *dest, const char *src, int
 	 * These are part of the Select Graphic Rendition sequences which
 	 * contain more than just color sequences, for more details see
 	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
+	 *
+	 * The cursor movement sequences are:
+	 *
+	 * ESC [ n A - Cursor up n lines (CUU)
+	 * ESC [ n B - Cursor down n lines (CUD)
+	 * ESC [ n C - Cursor forward n columns (CUF)
+	 * ESC [ n D - Cursor back n columns (CUB)
+	 * ESC [ n E - Cursor next line, beginning (CNL)
+	 * ESC [ n F - Cursor previous line, beginning (CPL)
+	 * ESC [ n G - Cursor to column n (CHA)
+	 * ESC [ n ; m H - Cursor position (row n, col m) (CUP)
+	 * ESC [ n ; m f - Same as H (HVP)
+	 *
+	 * The sequences to erase characters are:
+	 *
+	 *
+	 * ESC [ 0 J - Clear from cursor to end of screen (ED)
+	 * ESC [ 1 J - Clear from cursor to beginning of screen (ED)
+	 * ESC [ 2 J - Clear entire screen (ED)
+	 * ESC [ 3 J - Clear entire screen + scrollback (ED) - xterm extension
+	 * ESC [ 0 K - Clear from cursor to end of line (EL)
+	 * ESC [ 1 K - Clear from cursor to beginning of line (EL)
+	 * ESC [ 2 K - Clear entire line (EL)
+	 * ESC [ n M - Delete n lines (DL)
+	 * ESC [ n P - Delete n characters (DCH)
+	 * ESC [ n X - Erase n characters (ECH)
+	 *
+	 * For a comprehensive list of common ANSI Escape sequences, see
+	 * https://www.xfree86.org/current/ctlseqs.html
 	 */
 
-	if (allow_control_characters != ALLOW_ANSI_COLOR_SEQUENCES ||
-	    n < 3 || src[0] != '\x1b' || src[1] != '[')
+	if (n < 3 || src[0] != '\x1b' || src[1] != '[')
 		return 0;
 
 	for (i = 2; i < n; i++) {
-		if (src[i] == 'm') {
+		if (((allow_control_characters & ALLOW_ANSI_COLOR_SEQUENCES) &&
+		     src[i] == 'm') ||
+		    ((allow_control_characters & ALLOW_ANSI_CURSOR_MOVEMENTS) &&
+		     strchr("ABCDEFGHf", src[i])) ||
+		    ((allow_control_characters & ALLOW_ANSI_ERASE) &&
+		     strchr("JKMPX", src[i]))) {
 			strbuf_add(dest, src, i + 1);
 			return i;
 		}
@@ -128,7 +190,7 @@ static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 {
 	int i;
 
-	if (allow_control_characters == ALLOW_ALL_CONTROL_CHARACTERS) {
+	if ((allow_control_characters & ALLOW_ALL_CONTROL_CHARACTERS)) {
 		strbuf_add(dest, src, n);
 		return;
 	}
@@ -137,7 +199,8 @@ static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
 			strbuf_addch(dest, *src);
-		} else if ((i = handle_ansi_color_sequence(dest, src, n))) {
+		} else if (allow_control_characters != ALLOW_NO_CONTROL_CHARACTERS &&
+			   (i = handle_ansi_sequence(dest, src, n))) {
 			src += i;
 			n -= i;
 		} else {
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index e5092d3b42..896e790bf9 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -128,4 +128,42 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	test_file_not_empty actual
 '
 
+test_decode_csi() {
+	awk '{
+		while (match($0, /\033/) != 0) {
+			printf "%sCSI ", substr($0, 1, RSTART-1);
+			$0 = substr($0, RSTART + RLENGTH, length($0) - RSTART - RLENGTH + 1);
+		}
+		print
+	}'
+}
+
+test_expect_success 'control sequences in sideband allowed by default' '
+	write_script .git/color-me-surprised <<-\EOF &&
+	printf "error: \\033[31mcolor\\033[m\\033[Goverwrite\\033[Gerase\\033[K\\033?25l\\n" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
+	test_commit need-at-least-one-commit-at-least &&
+
+	rm -rf throw-away &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep ! "CSI \\[K" decoded &&
+	test_grep ! "CSI \\[G" decoded &&
+	test_grep "\\^\\[?25l" decoded &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters=erase,cursor,color \
+		clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep "RED" decoded &&
+	test_grep "CSI \\[K" decoded &&
+	test_grep "CSI \\[G" decoded &&
+	test_grep ! "\\^\\[\\[K" decoded &&
+	test_grep ! "\\^\\[\\[G" decoded
+'
+
 test_done
-- 
gitgitgadget

