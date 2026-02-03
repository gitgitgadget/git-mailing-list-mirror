Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC303009DA
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113897; cv=none; b=RM8cdlCT7bdAh0V81pgokjiGZ1nkAvECB2lFNcKTSVa1rpwx7gRgPFWoMhfxaLc7WX9Q0+Z+i22ipSOB2WTObJ4m20pcwGUVbPjW5szsFgPjvIvWhlBeOU7HMziLwrbC6fUMQcTfSJtYQMS5K1Gw5ZMq457H5Sad2HJdWI1TQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113897; c=relaxed/simple;
	bh=JilRf22FOk4sqDhkKfQ4cpIziKGq77Q4L6+kgyASSHk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d5KC/hNdcS9KTz4wk6tfbwDoBplrNhY74MZFqlgelPqwVYXO4M80H3FNuvAmDoqboczfU9hkRRdvHSojQHXof/lkIAyIfLSctYn2fE5SCG60fyq6Mb9mFASBWQnSuGrkR/DEw95k2KulWLOm7bS15yKh8znuJlBwzoZejKWMxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnDIZxSs; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnDIZxSs"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b785801c93so2273462eec.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113895; x=1770718695; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jDu87aQA9bL7Q89axp5JuKV2r517roHG1sUk6Y3jdE=;
        b=RnDIZxSssRxZ1VO+2PbjApO8N1h0gBVXt0FSjmsMwI7RRRdIv9tyFwKZ4EpleH0wXB
         RqhoNUzsO9gH9EuPYW7OaIGBhvSWQxilDBWxwwUelMdBAiXJpykcbm3zdz0LzY/BuCxU
         HhCDBQAyTtWIcFVbaBTZK/ed8a3dBkWclmu0/ZQ0GJAxr8kQrI3pyAsQw0UF4gVwJ1x9
         ZZpbVCHYyToKCsg4sYR4bMlzRDCN1MoIZwrFmlN51tFgj3jxqkR8fiSU85YS+/Ljpj3N
         kK3U9OXsDrUt0lLL+wIAJ7VIP3GW3ogaENQPCkWlqQZY8/lop0moik8vnEQOUfdp7UA2
         nKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113895; x=1770718695;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8jDu87aQA9bL7Q89axp5JuKV2r517roHG1sUk6Y3jdE=;
        b=JgySsq3asCXK9QJASpzswl/SSfrbC9cUQMfFA/kTNnkvCIk+4VOuidykXxY7vVhqfn
         N754W9rTsWnA2R5GgY81qnXl1ww/Lydotvb+H20W4ki0969ZZaztoHecXfF0jvLLLLHi
         ADnQZqtIQL/30jjD5C7Rjd+S0JdprUVP5eKVEzYuR9yK/uzbLR+QEnUoyxNpBZ90F8Sf
         SCnZ6AfRNVv3vxkY1G+mu/3CEm8l6q5kofBO4d7kX1/cVc8jOeKDaKkKQ+iAaH2czh1k
         Zw15fp6LFMv0m3M/rGgYEQiMzi8Mk8WOywf8lg8/QcfnkhJln32SCAhDy8w5AZ0fy+PT
         CGXQ==
X-Gm-Message-State: AOJu0YwKcI8ecMUlxAamKm35qtWKG6AOHnvgRYqYKDwqXcFmPQjuAczu
	ryTxGM6Sy/tPUdp6SHDsb2Dv8y1k9VwtPWXM9xb5VVz62+wFuI4Wu2459/vCPnQS
X-Gm-Gg: AZuq6aJlTvbDZRoK7qVaS5mYLJ8ia6vx2Mubi0CkR2g6vFIXRwSbmRwvk8N12+xQOV7
	90qrX+NegR7pSdu6cudVY5f2MXe+UQb2sj5lz2id6YtpKBVihAZfNTigc/IrozetWiTJTuwAMEb
	pLbp59pRVCKgvQjYOzQvpRJLmE0C2fQULG81Y1mZcoRfFBeJylPISPNugAAkx5H2Hnc57Rk0BX8
	pVODonW0uZ48CJuRbOn//HMg3U6ninsjPNHrB/OXp+GTiaxjabQJDUWGC0GkpKJbEo1Nk+0WmLr
	8iQBoP9dKV5RqJr9ivdW7MKiAi5Ng95gUGElZU/b5mX83wblRR1CGgw0n9KnIrVe5bElNFXCzPR
	fcP9kdmuNTGJv5MeEL260olrcMO9T5Of88TCTaq0Gp16NJNox4gejeUxjJY3wwaGqcxdzADfs8F
	gMvL3H1YkHbFyGiA==
X-Received: by 2002:a05:7300:2303:b0:2b7:857:db6c with SMTP id 5a478bee46e88-2b7c88da439mr7077348eec.28.1770113894852;
        Tue, 03 Feb 2026 02:18:14 -0800 (PST)
Received: from [127.0.0.1] ([128.24.162.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88c4sm21769929eec.31.2026.02.03.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:18:14 -0800 (PST)
Message-Id: <692d1a63edca011c6f556d6b0577659cba0a1a00.1770113882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 10:18:01 +0000
Subject: [PATCH v4 5/6] sideband: offer to configure sanitizing on a per-URL
 basis
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

The main objection against sanitizing the sideband that was raised
during the review of the sideband sanitizing patches, first on the
git-security mailing list, then on the public mailing list, was that
there are some setups where server-side `pre-receive` hooks want to
error out, giving colorful messages to the users on the client side (if
they are not redirecting the output into a file, that is).

To avoid breaking such setups, the default chosen by the sideband
sanitizing patches is to pass through ANSI color sequences.

Still, there might be some use case out there where that is not enough.
Therefore the `sideband.allowControlCharacters` config setting allows
for configuring  levels of sanitizing.

As Junio Hamano pointed out, to keep users safe by default, we need to
be able to scope this to some servers because while a user may trust
their company's Git server, the same might not apply to other Git
servers.

To allow for this, let's imitate the way `http.<url>.*` offers
to scope config settings to certain URLs, by letting users
override the `sideband.allowControlCharacters` setting via
`sideband.<url>.allowControlCharacters`.

Suggested-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/sideband.adoc  |  4 ++
 sideband.c                          | 81 ++++++++++++++++++++---------
 sideband.h                          | 14 +++++
 t/t5409-colorize-remote-messages.sh | 24 +++++++++
 transport.c                         |  3 ++
 5 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 2bf0426284..32088bbf2f 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -22,3 +22,7 @@ sideband.allowControlCharacters::
 	`true`::
 		Allow all control characters to be sent to the terminal.
 --
+
+sideband.<url>.*::
+	Apply the `sideband.*` option selectively to specific URLs. The
+	same URL matching logic applies as for `http.<url>.*` settings.
diff --git a/sideband.c b/sideband.c
index 0b420ca319..a90db9e288 100644
--- a/sideband.c
+++ b/sideband.c
@@ -10,6 +10,7 @@
 #include "help.h"
 #include "pkt-line.h"
 #include "write-or-die.h"
+#include "urlmatch.h"
 
 struct keyword_entry {
 	/*
@@ -27,13 +28,14 @@ static struct keyword_entry keywords[] = {
 };
 
 static enum {
-	ALLOW_NO_CONTROL_CHARACTERS  = 0,
-	ALLOW_ANSI_COLOR_SEQUENCES   = 1<<0,
-	ALLOW_ANSI_CURSOR_MOVEMENTS  = 1<<1,
-	ALLOW_ANSI_ERASE             = 1<<2,
-	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
-	ALLOW_ALL_CONTROL_CHARACTERS = 1<<3,
-} allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
+	ALLOW_CONTROL_SEQUENCES_UNSET = -1,
+	ALLOW_NO_CONTROL_CHARACTERS   = 0,
+	ALLOW_ANSI_COLOR_SEQUENCES    = 1<<0,
+	ALLOW_ANSI_CURSOR_MOVEMENTS   = 1<<1,
+	ALLOW_ANSI_ERASE              = 1<<2,
+	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES,
+	ALLOW_ALL_CONTROL_CHARACTERS  = 1<<3,
+} allow_control_characters = ALLOW_CONTROL_SEQUENCES_UNSET;
 
 static inline int skip_prefix_in_csv(const char *value, const char *prefix,
 				     const char **out)
@@ -45,8 +47,19 @@ static inline int skip_prefix_in_csv(const char *value, const char *prefix,
 	return 1;
 }
 
-static void parse_allow_control_characters(const char *value)
+int sideband_allow_control_characters_config(const char *var, const char *value)
 {
+	switch (git_parse_maybe_bool(value)) {
+	case 0:
+		allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
+		return 0;
+	case 1:
+		allow_control_characters = ALLOW_ALL_CONTROL_CHARACTERS;
+		return 0;
+	default:
+		break;
+	}
+
 	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
 	while (*value) {
 		if (skip_prefix_in_csv(value, "default", &value))
@@ -62,9 +75,37 @@ static void parse_allow_control_characters(const char *value)
 		else if (skip_prefix_in_csv(value, "false", &value))
 			allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
 		else
-			warning(_("unrecognized value for `sideband."
-				  "allowControlCharacters`: '%s'"), value);
+			warning(_("unrecognized value for '%s': '%s'"), var, value);
 	}
+	return 0;
+}
+
+static int sideband_config_callback(const char *var, const char *value,
+				    const struct config_context *ctx UNUSED,
+				    void *data UNUSED)
+{
+	if (!strcmp(var, "sideband.allowcontrolcharacters"))
+		return sideband_allow_control_characters_config(var, value);
+
+	return 0;
+}
+
+void sideband_apply_url_config(const char *url)
+{
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
+	char *normalized_url;
+
+	if (!url)
+		BUG("must not call sideband_apply_url_config(NULL)");
+
+	config.section = "sideband";
+	config.collect_fn = sideband_config_callback;
+
+	normalized_url = url_normalize(url, &config.url);
+	repo_config(the_repository, urlmatch_config_entry, &config);
+	free(normalized_url);
+	string_list_clear(&config.vars, 1);
+	urlmatch_config_release(&config);
 }
 
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
@@ -80,20 +121,12 @@ static enum git_colorbool use_sideband_colors(void)
 	if (use_sideband_colors_cached != GIT_COLOR_UNKNOWN)
 		return use_sideband_colors_cached;
 
-	switch (repo_config_get_maybe_bool(the_repository, "sideband.allowcontrolcharacters", &i)) {
-	case 0: /* Boolean value */
-		allow_control_characters = i ? ALLOW_ALL_CONTROL_CHARACTERS :
-			ALLOW_NO_CONTROL_CHARACTERS;
-		break;
-	case -1: /* non-Boolean value */
-		if (repo_config_get_string_tmp(the_repository, "sideband.allowcontrolcharacters",
-					      &value))
-			; /* huh? `get_maybe_bool()` returned -1 */
-		else
-			parse_allow_control_characters(value);
-		break;
-	default:
-		break; /* not configured */
+	if (allow_control_characters == ALLOW_CONTROL_SEQUENCES_UNSET) {
+		if (!repo_config_get_value(the_repository, "sideband.allowcontrolcharacters", &value))
+			sideband_allow_control_characters_config("sideband.allowcontrolcharacters", value);
+
+		if (allow_control_characters == ALLOW_CONTROL_SEQUENCES_UNSET)
+			allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
 	}
 
 	if (!repo_config_get_string_tmp(the_repository, key, &value))
diff --git a/sideband.h b/sideband.h
index 5a25331be5..d15fa4015f 100644
--- a/sideband.h
+++ b/sideband.h
@@ -30,4 +30,18 @@ int demultiplex_sideband(const char *me, int status,
 
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
+/*
+ * Apply sideband configuration for the given URL. This should be called
+ * when a transport is created to allow URL-specific configuration of
+ * sideband behavior (e.g., sideband.<url>.allowControlCharacters).
+ */
+void sideband_apply_url_config(const char *url);
+
+/*
+ * Parse and set the sideband allow control characters configuration.
+ * The var parameter should be the key name (without section prefix).
+ * Returns 0 if the variable was recognized and handled, non-zero otherwise.
+ */
+int sideband_allow_control_characters_config(const char *var, const char *value);
+
 #endif
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 896e790bf9..3010913bb1 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -166,4 +166,28 @@ test_expect_success 'control sequences in sideband allowed by default' '
 	test_grep ! "\\^\\[\\[G" decoded
 '
 
+test_expect_success 'allow all control sequences for a specific URL' '
+	write_script .git/eraser <<-\EOF &&
+	printf "error: Ohai!\\r\\033[K" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./eraser &&
+	test_commit one-more-please &&
+
+	rm -rf throw-away &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep ! "CSI \\[K" decoded &&
+	test_grep "\\^\\[\\[K" decoded &&
+
+	rm -rf throw-away &&
+	git -c "sideband.file://.allowControlCharacters=true" \
+		clone --no-local "file://$PWD" throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep "CSI \\[K" decoded &&
+	test_grep ! "\\^\\[\\[K" decoded
+'
+
 test_done
diff --git a/transport.c b/transport.c
index c7f06a7382..1602065953 100644
--- a/transport.c
+++ b/transport.c
@@ -29,6 +29,7 @@
 #include "object-name.h"
 #include "color.h"
 #include "bundle-uri.h"
+#include "sideband.h"
 
 static enum git_colorbool transport_use_color = GIT_COLOR_UNKNOWN;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -1245,6 +1246,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 	ret->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
 
+	sideband_apply_url_config(ret->url);
+
 	return ret;
 }
 
-- 
gitgitgadget

