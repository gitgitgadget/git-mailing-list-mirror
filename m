Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05F2F39C2
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113893; cv=none; b=PqZ0kr3VKyTK70i2f7+ql+J17Hj1EFOVDWVKBm6ypUZYsX7Nu9ZhH3yId2DtfnT9v4Z5fncQXhMmyXxBcfOuwN8Rh7HsokLdj1E0rKolpxbAYNXEwMHFn4yR5+r7BMezfuJxmGBK0GMVeKQZTAhtZvbGd5Qd6I6Okh0fIvNgZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113893; c=relaxed/simple;
	bh=ghFzK86EhQA8rJAyE+bhCKveLm0wcE0NelszFpp8Eoc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dAvzDEPDtkL8ubELE/Kl0jzi5fuJQNpfHCMBP17mgLbhd9e93zjSlPtS+9C1eB+1b/LhJXxWlxZQjxxKHKIPe0+JTQW81umpRz4cfSM7sD1U3KWhGdQs7LL3ZBONcFFNSZMJ2LW6aXPsxwIPTi9Rfma2PKsoBZeDEWLVnLZRHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8GLL0wc; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8GLL0wc"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124a635476fso7964236c88.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113890; x=1770718690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FxYArsKnEq8oqJ1fHkHZxZbPtgAwL7B6e2q8pQsvgs=;
        b=V8GLL0wck+m7GY8NbPDkuY16/XClqRq64ek8vl+Y1xqf0aqFWkcB6FY12K+4dD1w6w
         LvtUVJb2YqIzsT+1O8QHVQ07aK3Q/9XoCJJp5BW4SCUq5ucCl+k0Hq26oIS65XpsT9qM
         7CDvr0ncUPOZkzTrx05qTa6TZKghTcnJ1sg9EdLKhDCiP0f3tgl6l9Lh9QmWEemdiz1c
         K6iUjdwDCbz8JNCYH1bSatF7T2xgRV9aTCVma/eLmZ1oYH6wEkoneU572SLVQ8FzKzfN
         4qDq64JO/H+lHWXeqQLkditTob+1Rs8KxAi1cI1WkVbsApSGQrLXYgmipwg3kVKu7wip
         LK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113890; x=1770718690;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4FxYArsKnEq8oqJ1fHkHZxZbPtgAwL7B6e2q8pQsvgs=;
        b=A3nnXau88tUtPA7zp9ok7KsF46+iklO+1WvB0UkTyF+Dbo5fnYnzepTmSrbTzGtSrE
         Og7LgSLFMh2LgU+Ld9qHWPCZcGSEEZ0rlmDDBKG2qD1c309Qi3qzRVo6cqncx4xLtzy8
         P85as9dbjwbXIIDHGjtUl/YeGGIaiWbAbPH2n2CXanjVl55/7LuhUX1K1HPNR/kMJpr/
         xUWQ6GYtILhZJaos+dj8REW9rXau8a4l8LBpsd/ZqV9rPxEerMlwHcfXlkQI7MpKNC6W
         ZXsTeXQsCeI81yp9P0vjVF8EsjXhvLBTzG9ivG9qYZK2JaVFzAh62PfuO+LfNsRu1Ahz
         oPeg==
X-Gm-Message-State: AOJu0YyNyUOuVyUXmbsBOxy4iyAvx/Yq0D1rJKvTiCyCJnoQlPOIdqYo
	y21184B5k0hr/hMP1BQTAiUUestuKQKQYf0pigWJp2aZTmb/vbWDw0iYJCMQ9U8a
X-Gm-Gg: AZuq6aIwTmasbXzZNhJx9Ip41/twc1jL+ProNlb3rbLs+uzV6uYaNNtSIBthrWZi4yV
	oyqkCQK4P9pAXni7PIKGnv/JASVTPprQj//+o9mPRlTywRm/Ij54JH+XUTdEj3wZCJ6Taatl/SF
	TgSjLlzrfEOUhGEOYZyRJAxhOxGWaKksFI/YI0+a///Xtv80laSCqPb24y9HHyK+6CBKDJxszmV
	P6bB/SQVFpw6q6Getcd9QeKn10UKXvdyRZSt+WV0SpjROllqUeag/VjwTYEguH0G9f4eE9xTuZA
	+IKJE0PfiyEvgg5uo3XPDvAWtbx0O1BJUhNIShAKpNzem729FvRhYZXbZJTmNvPRhhdY2JKQez+
	NIKw9p5uGStSDDge+k07RHMd2Sltfa5/4ArWMu/ctfpoxP70yZMI4O/ipSiB5xManUE2e6jxHdZ
	A8Ffl0fKGPqLHuJg==
X-Received: by 2002:a05:7022:602:b0:11b:9386:a387 with SMTP id a92af1059eb24-125c100f46emr7230501c88.42.1770113890001;
        Tue, 03 Feb 2026 02:18:10 -0800 (PST)
Received: from [127.0.0.1] ([128.24.162.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de948esm21567866c88.9.2026.02.03.02.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:18:09 -0800 (PST)
Message-Id: <919111f590fb76eebdaaa47e36572dbc5e0c53d4.1770113882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 10:17:59 +0000
Subject: [PATCH v4 3/6] sideband: do allow ANSI color sequences by default
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
 Documentation/config/sideband.adoc  | 18 ++++++--
 sideband.c                          | 66 +++++++++++++++++++++++++++--
 t/t5409-colorize-remote-messages.sh | 16 ++++++-
 3 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 3fb5045cd7..b55c73726f 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
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
index 682f1cbbed..eeba6fa2ca 100644
--- a/sideband.c
+++ b/sideband.c
@@ -26,7 +26,12 @@ static struct keyword_entry keywords[] = {
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
 static enum git_colorbool use_sideband_colors(void)
@@ -41,8 +46,26 @@ static enum git_colorbool use_sideband_colors(void)
 	if (use_sideband_colors_cached != GIT_COLOR_UNKNOWN)
 		return use_sideband_colors_cached;
 
-	repo_config_get_bool(the_repository, "sideband.allowcontrolcharacters",
-			    &allow_control_characters);
+	switch (repo_config_get_maybe_bool(the_repository, "sideband.allowcontrolcharacters", &i)) {
+	case 0: /* Boolean value */
+		allow_control_characters = i ? ALLOW_ALL_CONTROL_CHARACTERS :
+			ALLOW_NO_CONTROL_CHARACTERS;
+		break;
+	case -1: /* non-Boolean value */
+		if (repo_config_get_string_tmp(the_repository, "sideband.allowcontrolcharacters",
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
 
 	if (!repo_config_get_string_tmp(the_repository, key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
@@ -71,9 +94,41 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
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
@@ -82,6 +137,9 @@ static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
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
index 9caee9a07f..e5092d3b42 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -100,7 +100,7 @@ test_expect_success 'fallback to color.ui' '
 
 test_expect_success 'disallow (color) control sequences in sideband' '
 	write_script .git/color-me-surprised <<-\EOF &&
-	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
+	printf "error: Have you \\033[31mread\\033[m this?\\a\\n" >&2
 	exec "$@"
 	EOF
 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
@@ -108,12 +108,24 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 
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

