Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75ED368285
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753703; cv=none; b=tHE6bC3Bqp2P4qRwIrZYEeETV+gLcgk05OsFwQEWa2JGeM7i1kfa76suk5anU5zWPmKW6fa22IM/6WBtcv9RZJVeCIaL/QSpfWoH44qR271osw2YPUVdh8hdyigZWUouG+nvT5v5B1DSAfdzQt1Q65RlIS7rq/jk1MtkHWuah9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753703; c=relaxed/simple;
	bh=3DbpJu40tjiObsbIR8DBs3azrMqhiMcemFD/pDM2D5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EK8uE+AsnDlYTpH4N4kgbLgqMHqSGu8zSXzw7lNZdKpGW7Y4h3m05EwK9yqmObXioHNQYWy+pYNVSV/M+eE8OYcZYVhTFP84PpCKfMpNWOzsiqSRr0Fn1dOiEQ8HWm21PGiLJR5JK6uKCc1oRZtf2yc5ABsLePtFtLMdi34pVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fY2MI9kV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ehnKz38V; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fY2MI9kV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ehnKz38V"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FF951400219;
	Thu,  5 Mar 2026 18:35:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 18:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772753701; x=
	1772840101; bh=YLPI6khOhveCdSHrx4ZXp80H+kYl+/mm+y+mrTjZNV0=; b=f
	Y2MI9kVIgFDLrwBuAHIMQwv6fIvdtMMw2kuBbn0a1B61RG2jVI439IBRJEPbE+EY
	rh8Mp30mbMoXSJZDHVudNRAUq01ZptAhiiRhmefNZh4Tr6c199mYriCZQov1e3Dc
	s7iC/HWJyvyDpluJm6MoZXvn9y5PRYZi+7upmSvC5TH3yuLikjru4shfXZy4NjMf
	2y4uRMzrO9LbFkt2W/TE1x7eeVT1NyarOkqotfBPxMMDq6NVeJQ3f3KAjAamtwLg
	bBe/NKpbTRGM6Qsyr+mws7zvnkPLZ9Zej1BAD8FPU0fb4cF9Ou/R01cLBy8qW2Wo
	+YsbXqCp9e2OvKudmeVKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772753701; x=1772840101; bh=Y
	LPI6khOhveCdSHrx4ZXp80H+kYl+/mm+y+mrTjZNV0=; b=ehnKz38Voopbb5TWw
	DhxdGFE9PX1DSl8+SRO49ZDb3ZgpQ1ehi9IDBmKWykboDqzaRQjCESaK9OXMRXMn
	Vj5V+kYDMIQZYLwTVbvFP5a4Ea72RA54pu/OradLPmGUXQGaUaN5jFi4v2by/Mo7
	lcuqAbpcvotS8B8BlNYT8EQsuxi4bfbP/qpEs6zZbU6UAvKJn13cQ6ciKl9kSX+t
	vZPIYZGA2zBkupOeLiIvp3qjsvJbzrfPKZgr2RUCgUVDG0LbR312E6XuxpJqoiLK
	yNujTzsazVTJoUnjhYQu6YqEezy3w70zz/fxk2ZgCNgNZUksTxXwXRDrgIm03EZn
	BqdXw==
X-ME-Sender: <xms:JROqaU4sgI_lYJtoADTZgsVdmoPa7Ocb8giWqNG5xxh22o-93rLaTQ>
    <xme:JROqadXoGm9EXLL89pTHmYdqSr-A4JEQqfH8KzXJQBeprR89wOukn9iyhCQu1JBmY
    m3yNvbhFuQbFZLFw9GBKPlCtv3CdeupWiR4eftzmtF9KTm6ycrDsA>
X-ME-Received: <xmr:JROqaQ2JfgqW9W5GLTS_PPCF3rTy2mySANB_McT7UdiBYRkDiLtKx1DVLp-4_0begRIUFIULk2DGKLpct8znRcHqn7iroYPVVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteffuddtveduteekhfeijefhtdekvdelfeevueeijeeftdduvdehgfduueet
    veeunecuffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgpdigfhhrvggvkeeirdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JROqaS2MyK2ot_zaLqN0lZ6VxTtNfe4ykxvKZ9GvvHtCJYFCILBPuw>
    <xmx:JROqab-YMdaTFm-v6oPGu5XmEwP8KcV18677fY-nOjlZhiz1ukQmPw>
    <xmx:JROqaX0k_z5WOOT7VjRzPVtWFRomTp_YgAC5tpyP2aHyvTsFsS1MaA>
    <xmx:JROqaQ_heYSEaQsxLUfFtS2dAmZh6KLRiXtY52sagmTuF8wCVEBFOA>
    <xmx:JROqaT6etpo3o_uQXwebKDmmxdCu9HfOnI5HwpRfpC-QRYI-HVGttjq3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:35:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 4/7] sideband: add options to allow more control sequences to be passed through
Date: Thu,  5 Mar 2026 15:34:49 -0800
Message-ID: <20260305233452.3727126-5-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-629-g0c401728ca
In-Reply-To: <20260305233452.3727126-1-gitster@pobox.com>
References: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
 <20260305233452.3727126-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.53.0-629-gb58d2f6a3e

