Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649023115B1
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602385; cv=none; b=favMH642QWWND0YH9Qj2ma0nV+Fv8+zbMz/nFQlhSrG5fseqnS4pXyeEdYKjXbApUG6CVQ1Opzn6g4aSqFrnPFSYxgIBBA+HdhwgNRPmLIguJ19mRneJ/TAIAQBDcpIziRSwQ0lYLLxSotllLj0MN3vxKGD4JY/vu5DUv1eZts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602385; c=relaxed/simple;
	bh=9Ynu5ICR8gucwuKOUOKJGXpl6+qc432/WMUU5O07HsQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fp0v4qVOKRk/5hLoHgUDshs+o/PD+iP8DSucDKPxnKywi+8B3PfxZh6HYKraTwppJFSoMWTpIa3nmW2++FyWfjzc1jBZZdoQpkvSxuw/UneCTjcagGnA9O5Rft3DIikSA742lg3MVuGMj2Q4DQvvvVbMFhkZJ4SG6CDZOcJD52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwL+PBQJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwL+PBQJ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8887f43b224so47009446d6.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602380; x=1769207180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IALE4jFnWqm7klGTi4+MFMQjzCLeYn3hJGPvnRSIquI=;
        b=YwL+PBQJXayyAuX4iENO/mk5U/6nPe+RzDgsZz8lFDEtPJWH517Jhu8gfv6i+0RYcW
         Yb9hNbN6Oz0s8WC3hj1ijaY9SxspwRcJx+xFL+7RpEO89RD1y8/vmm/gNZ8GMlJpdZ58
         Wa5HbCzpbJs2ibRfIlMRSQYPeS1qkTP/xzB/U8zyiwfJpOzU1eLwoz9IGE0WlegkxEZ/
         JUJGPI21XfkP8mtF9AmFLUZ8Ci35WzkH6+UpwCXN/frH7iZhWQlJhNygJOYP11xnih78
         IlFk6zBg04timdCUm9il6YSFfc//LHriaK/f9rcVLXtHIWjj4AlJ2okBD/QkGAGZtm9I
         PR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602380; x=1769207180;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IALE4jFnWqm7klGTi4+MFMQjzCLeYn3hJGPvnRSIquI=;
        b=bqB2oDTQeCRWgn9GXKhQQKAXRlYBkYkquiCpgWy9gXedUcd5F8Sfz/VYrwkcqsJgju
         tYw7oALndrOv6ZWTJCpRDWMEcFpgWqX9L8aMU1qp0JWdOcICzpdYUkQkg9NlN6V7ExYE
         yRLXFO3z2jMyquYgbxU7j0skI9Vwwo2JJosVTCHVxoJeyclneCaokiee4NrpahUt0Y0C
         8B5IDGcCnFxfZISb3ouKUM8EZXMGX1eNR1nL6VGYfMcIoMVdSXPawhW/Yf11i9pep76o
         HndACU9VeHqKsv8r5FO6YIJwzMphOfXuKoAicsOMWP159wBkkm7S858oKquZC8ekvBVi
         9dew==
X-Gm-Message-State: AOJu0YxuG0WOa1aGwVZH92R4j38v0bEM99pdK4y0AW9uWx4AyZJ2Iv1O
	ljTmwcG8grEZmFrVMho4btPDlK+MdxnX02OXiphSkJIruy6K0ZtIRoY3UKeBBg==
X-Gm-Gg: AY/fxX5iRMTFMujxEKTl5jK23cBUPOYShYuElE4/80W7oD1DeCqAuOgzTvmqFCrV5dW
	H8mW+1sUPmi6u0kOBX6hIN9KEpqujB0xZf2LJVGGKnlofW9arV3i3pXMdj/WBKDjP+W3vUTEfEV
	3jDSnas3RIyMapD0TXmPV3fw5MvenXsaT7U51fISZDyZ6uoJ5Iy4pQn0153gsfUajLfHBBE+Hbh
	OnEJprvDidlNv5ocKxUdX0EKic/YicY2G2z03tocRGzsEzh7h+ERA2NKZ1sPdv7HSGYWVj/3xc/
	qI/q7NuJf9m5lbRrHd4hJ+XCT754FmFn1drKqlRKAD/ji9mAp2TKN2uWuj4EWQxFczSTtV++GBv
	35NoaORYf8xgsUoRJq48v6fS6y61tOJl5q3Ioybv5tMkxGr8buyxAljDxcZnPY/G44TiSanZDSG
	apAPgZ2pikuAQzccenwfrYuZ2L
X-Received: by 2002:a05:6214:19e2:b0:87c:275d:adcd with SMTP id 6a1803df08f44-8942e47df0amr59984316d6.41.1768602379951;
        Fri, 16 Jan 2026 14:26:19 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.100])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad566sm34225116d6.35.2026.01.16.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 14:26:19 -0800 (PST)
Message-Id: <44838acaccc492785e78156cb9a5e2cc9cba20ae.1768602373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
References: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 22:26:11 +0000
Subject: [PATCH v3 3/5] sideband: do allow ANSI color sequences by default
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The preceding two commits introduced special handling of the sideband
channel to neutralize ANSI escape sequences before sending the payload
to the terminal, and `sideband.allowControlCharacters` to override that
behavior.

However, as reported by brian m. carlson, some `pre-receive` hooks that
are actively used in practice want to color their messages and therefore
rely on the fact that Git passes them through to the terminal, even
though they have no way to determine whether the receiving side can
actually handle Escape sequences (think e.g. about the practice
recommended by Git that third-party applications wishing to use Git
functionality parse the output of Git commands).

In contrast to other ANSI escape sequences, it is highly unlikely that
coloring sequences can be essential tools in attack vectors that mislead
Git users e.g. by hiding crucial information.

Therefore we can have both: Continue to allow ANSI coloring sequences to
be passed to the terminal by default, and neutralize all other ANSI
Escape sequences.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/sideband.txt   | 18 ++++++--
 sideband.c                          | 66 +++++++++++++++++++++++++++--
 t/t5409-colorize-remote-messages.sh | 16 ++++++-
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
index 3fb5045cd7..b55c73726f 100644
--- a/Documentation/config/sideband.txt
+++ b/Documentation/config/sideband.txt
@@ -1,5 +1,17 @@
 sideband.allowControlCharacters::
 	By default, control characters that are delivered via the sideband
-	are masked, to prevent potentially unwanted ANSI escape sequences
-	from being sent to the terminal. Use this config setting to override
-	this behavior.
+	are masked, except ANSI color sequences. This prevents potentially
+	unwanted ANSI escape sequences from being sent to the terminal. Use
+	this config setting to override this behavior:
++
+--
+	`default`::
+	`color`::
+		Allow ANSI color sequences, line feeds and horizontal tabs,
+		but mask all other control characters. This is the default.
+	`false`::
+		Mask all control characters other than line feeds and
+		horizontal tabs.
+	`true`::
+		Allow all control characters to be sent to the terminal.
+--
diff --git a/sideband.c b/sideband.c
index 1499587ff6..f4bcdcaf9b 100644
--- a/sideband.c
+++ b/sideband.c
@@ -25,7 +25,12 @@ static struct keyword_entry keywords[] = {
 	{ "error",	GIT_COLOR_BOLD_RED },
 };
 
-static int allow_control_characters;
+static enum {
+	ALLOW_NO_CONTROL_CHARACTERS  = 0,
+	ALLOW_ANSI_COLOR_SEQUENCES   = 1<<0,
+	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
+	ALLOW_ALL_CONTROL_CHARACTERS = 1<<1,
+} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
 
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static int use_sideband_colors(void)
@@ -40,8 +45,26 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
 
-	git_config_get_bool("sideband.allowcontrolcharacters",
-			    &allow_control_characters);
+	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters", &i)) {
+	case 0: /* Boolean value */
+		allow_control_characters = i ? ALLOW_ALL_CONTROL_CHARACTERS :
+			ALLOW_NO_CONTROL_CHARACTERS;
+		break;
+	case -1: /* non-Boolean value */
+		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
+					      &value))
+			; /* huh? `get_maybe_bool()` returned -1 */
+		else if (!strcmp(value, "default"))
+			allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
+		else if (!strcmp(value, "color"))
+			allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
+		else
+			warning(_("unrecognized value for `sideband."
+				  "allowControlCharacters`: '%s'"), value);
+		break;
+	default:
+		break; /* not configured */
+	}
 
 	if (!git_config_get_string_tmp(key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
@@ -70,9 +93,41 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
+static int handle_ansi_color_sequence(struct strbuf *dest, const char *src, int n)
+{
+	int i;
+
+	/*
+	 * Valid ANSI color sequences are of the form
+	 *
+	 * ESC [ [<n> [; <n>]*] m
+	 *
+	 * These are part of the Select Graphic Rendition sequences which
+	 * contain more than just color sequences, for more details see
+	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
+	 */
+
+	if (allow_control_characters != ALLOW_ANSI_COLOR_SEQUENCES ||
+	    n < 3 || src[0] != '\x1b' || src[1] != '[')
+		return 0;
+
+	for (i = 2; i < n; i++) {
+		if (src[i] == 'm') {
+			strbuf_add(dest, src, i + 1);
+			return i;
+		}
+		if (!isdigit(src[i]) && src[i] != ';')
+			break;
+	}
+
+	return 0;
+}
+
 static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 {
-	if (allow_control_characters) {
+	int i;
+
+	if (allow_control_characters == ALLOW_ALL_CONTROL_CHARACTERS) {
 		strbuf_add(dest, src, n);
 		return;
 	}
@@ -81,6 +136,9 @@ static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
 			strbuf_addch(dest, *src);
+		} else if ((i = handle_ansi_color_sequence(dest, src, n))) {
+			src += i;
+			n -= i;
 		} else {
 			strbuf_addch(dest, '^');
 			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index e8067df591..f34977b332 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -101,7 +101,7 @@ test_expect_success 'fallback to color.ui' '
 
 test_expect_success 'disallow (color) control sequences in sideband' '
 	write_script .git/color-me-surprised <<-\EOF &&
-	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
+	printf "error: Have you \\033[31mread\\033[m this?\\a\\n" >&2
 	exec "$@"
 	EOF
 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
@@ -109,12 +109,24 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 
 	git clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
+	test_grep RED decoded &&
+	test_grep "\\^G" stderr &&
+	tr -dc "\\007" <stderr >actual &&
+	test_must_be_empty actual &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters=false \
+		clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
 	test_grep ! RED decoded &&
+	test_grep "\\^G" stderr &&
 
 	rm -rf throw-away &&
 	git -c sideband.allowControlCharacters clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
-	test_grep RED decoded
+	test_grep RED decoded &&
+	tr -dc "\\007" <stderr >actual &&
+	test_file_not_empty actual
 '
 
 test_done
-- 
gitgitgadget

