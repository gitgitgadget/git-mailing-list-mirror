Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BD33B6F8
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981432; cv=none; b=WyhoGbA7rcEJs7S4HSDwJkKc/n1TsW8FkqbmggPK5PbKbMjzuDiNphXRePOC8TCAwzA0ciEO89evLXGwqkbJwo1UZtb2xkTZYBC/stkck0JlkEPZJEnjI4rn5jlgzrlLk4lUlmouAU4DnxrptEs/oj8xs3NrdVX/GeyyjQqOh8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981432; c=relaxed/simple;
	bh=ErFDAVtlj55Uh8lME1Z8AiZP3MiKu6bOaUqswxvbOgA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G/mBxWdl20hNTbhrL3XVeyQ+pHOJtBCBdcmHp7i+tVmLJsgK23skMZxUdu9Ocouz5UWODJWtWhsQ1STNgqHyDxSYWlno4xCDy0g+gihAqmsXit+TSmofOYO/d7Lz8SY4kR0R/7eX4z9vlbbWNzFKnEQPkaq/8SPRH3UqZMiLxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDBIn1P+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDBIn1P+"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8a3eac7ca30so446141385a.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981429; x=1766586229; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXwTu6kxS71sUDtrW8Lq5KQ8zTi03KaUqQwwBmLjtpk=;
        b=hDBIn1P+njuHd0fLEr55f20c6l8NJWJo2lAk1zeq3QxKwK+ut3c1SngvM6t7hTxIO7
         kWioDhVNAx+T47r6UdeaeY+iie6T8HIo8+AdUTZFGeP5Hl3hAMzvaG5jGdGA+IJks4xu
         iFlMDBquhhKWpR9vkx75pnlyEtf+x7mI4WQf5aktYRk7WF1WZdbr5sBzQ1Qe0y6kkiOt
         YcjVRE4JoMQgUm3ohEkfpBnX7oKwvGAtKyin2sK1o2iai93xqjh67e164g5F4RLm4ufT
         eCt1MCfpc5SDUPfqMCpBEa395JYKWgPv883Kcn2JlTWk2JRNzcw0WcQ8F116vYksHtdq
         wtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981429; x=1766586229;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXwTu6kxS71sUDtrW8Lq5KQ8zTi03KaUqQwwBmLjtpk=;
        b=qFRHKl+ixT54NMYVCW5dk60UMZGX/At0UKX+INw1acGXDTGW2y41ZNOlZCXiIXjv3d
         L0Yoy+URuXhLXnJZCTaieDGwu/6kPV1J3vlNx7JYBIc5hYwWgPzR0vFOpQB2IatgzjvW
         ED+Q7FM9t5xu8saT2jYupd0X6vEhBegZjGKXn6IRVYDUb2rBavIAEUC1uORUfZzyPZE8
         gg+pvAPfrtX2kPeVf9V4EcZ3pw6dN7MI2ZYgAETyvC0s82antarJ2oPu5AjL9avpRPHd
         LJMH6aUUNiwLMAHz+P+1VV1TqYuK9udrY8lf3Xa1VAN5z+7cof2ZhvTR92vAVJumo6SR
         1csA==
X-Gm-Message-State: AOJu0Yzq3CQ3VlC1egRPeHe/3dbfu0DLajV0owgFGrAiW2sf2gho2HO+
	/FcQ01sMWVvhdzbIjvOYyt2+x8HNenPMNDbZoo5yXmEA2jNxijMjfQT1DtOxwK9WRzs=
X-Gm-Gg: AY/fxX45kPpSdDFBFkOvAdQIzSXxdG5fjtPdazjO7oP6nSnuh9pp+44kQfgazKA9WbM
	LHPnEMes5Lg+0wdiBClzywu2BVlTuA2pFWxYZQ1ptuxk0gmUh8RJjXwJ/zcNU1di7pHc6b1dCPA
	pCXfmFpBjjQl98tupJr6I8ZTI4W8CA/aIRO/W/80Be8I7iXgGzuvS++u8QMyVapUb4HbVd8nWeU
	wEy5vWOknr0Mu2aa7joj8+clhdQb9gHadgoKozfIIm+whoK4RwxN0d++WOHXKs6eTpjvFPYKiYK
	WAds+fQxiL+pmPG06dViIvq8PeUwBPh1rU8thd6WU9fC9yh4H35tKXnjOM1WaiNrF29J/fuyHwl
	OXiICW9V54YkDYE6cqrW/dZxF17t6Ctd/FvTphktoAcD/WenhPIu0GgUxj0gONyiAjw2Gp+k+h5
	yx5hWhWkhWaQW7rQ==
X-Google-Smtp-Source: AGHT+IEN1EpBx3hUB3A/jAbvSzk7DS4mq0XMSI4iF//KKjyQTpyx8zQ+3C1sGTNJ3zWDMvVs95NOTQ==
X-Received: by 2002:a05:620a:472c:b0:8b4:3ea8:b30e with SMTP id af79cd13be357-8bb3a248ca7mr2624533385a.46.1765981428643;
        Wed, 17 Dec 2025 06:23:48 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993c6363bsm95159156d6.17.2025.12.17.06.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:23:48 -0800 (PST)
Message-Id: <44585ba1f4223f053820d82f1513c2258e1e0059.1765981422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:23:41 +0000
Subject: [PATCH v2 3/4] sideband: do allow ANSI color sequences by default
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
 sideband.c                          | 68 ++++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh | 16 ++++++-
 3 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
index 3fb5045cd7..e5b7383c7a 100644
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
+	default::
+	color::
+		Allow ANSI color sequences, line feeds and horizontal tabs,
+		but mask all other control characters. This is the default.
+	false::
+		Mask all control characters other than line feeds and
+		horizontal tabs.
+	true::
+		Allow all control characters to be sent to the terminal.
+--
diff --git a/sideband.c b/sideband.c
index 997430f2ea..fb43008ab7 100644
--- a/sideband.c
+++ b/sideband.c
@@ -25,7 +25,12 @@ static struct keyword_entry keywords[] = {
 	{ "error",	GIT_COLOR_BOLD_RED },
 };
 
-static int allow_control_characters;
+static enum {
+	ALLOW_NO_CONTROL_CHARACTERS = 0,
+	ALLOW_ANSI_COLOR_SEQUENCES = 1<<0,
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
@@ -81,7 +136,10 @@ static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
 			strbuf_addch(dest, *src);
-		else {
+		else if ((i = handle_ansi_color_sequence(dest, src, n))) {
+			src += i;
+			n -= i;
+		} else {
 			strbuf_addch(dest, '^');
 			strbuf_addch(dest, *src == 0x7f ? '?' : 0x40 + *src);
 		}
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

