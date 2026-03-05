Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3D36829E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753705; cv=none; b=dlsnx5CjIt+EooxUnCETpuVzXT9Lmxco1VtgobHVdvlt8Wt/SzpbYDrbWchmHjIGjUmYaIm+Sum9huZerUyLvW9sk9YLCHz3IeZUzhg+c8ni64O8SRxQsSG01yj6aM7aA/umu2TR7PlcdAgm+aL2Z1r8lknfowZ32IzGQqv7TK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753705; c=relaxed/simple;
	bh=ygMr+lhn/kcIP0pSJCiITN2RH+axXPcdkpWueN/Q0hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4+mUqiT7L54Vrmo+2EfzLZg/UoPgfjocQyMoGw3k9ye8aHtP3mJk0gMKOHcpvTISOJsaT7d3PU8eoaRIUT1XhTHM4MiIO3V04r6R4yLpi/YXczRm1rHl++JRhgz3fknVm7UKW2Vr2gzUvuwsk5WSXsIh+/fuB7e+FZpWvZ2G6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KUXp+mT0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXqb/SWR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUXp+mT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXqb/SWR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2ADA6EC0574;
	Thu,  5 Mar 2026 18:35:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 18:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772753703; x=
	1772840103; bh=mEnFIocjWdHQ6XfuoGB0WuJ5ppF/Cwm16Kg0e4scr9U=; b=K
	UXp+mT0/RmM0OctHQQnR0OrmMpDoJITgtSu8HBLONjRilEKrVCnSZ9f6nRuqYGIr
	x9ewZlaHNHDwtNO0YALft0W4cERlIKd9GUIeGs1KsNOfJJQbELOo5zCUdZET4nv+
	r3DZQXnzT9Y72Y1WWQfoXibq1grmoe/TUtuR7REdHADb8sIVX4ITOYkj6gSWAnrC
	L0ptZYIz9lZCRHHTvDFV+ZOpXedJF+WJxK1bvGF7TN68GFulvNHBxSy7ihuQS9C+
	X6KptVymUgZUpegfrucvzZGk3/t77rwvNn7hhExgO/1MrALgEL6hL3jUncP/s55M
	kUlLIGjXyV5uL7XNi7EQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772753703; x=1772840103; bh=m
	EnFIocjWdHQ6XfuoGB0WuJ5ppF/Cwm16Kg0e4scr9U=; b=mXqb/SWRna0QjvTwv
	yHGpF/XoD9s1frN3+GLPNw0j4rsGarldLhj1fMZkIVMqc8tmwv28kQcJEfP+e0rx
	9PS3IqeQ+HR7ZS+D0XKNJzDJVpGADX46pQQCulCprJulTift1Uz6l6DSxowQLbry
	sm6R0Jpjlzs/HUgz+ru144UgtiKq1x3NHo+KpJLC0dIBxy33MhkxaEz4V3Z9UW1N
	WcFQ1Q2NSVGQxeEaxnKzT9acCjJPyIVI6DBon7XAjJFJpHYMsoGiVOCjYpVwGMZH
	rr4J+/478XESc7m48nt2j8EJ/iRYviE88tIICrdHX0yO4tYj4CPCGoGPnHvAnCFP
	49alw==
X-ME-Sender: <xms:JxOqaUvqKany_Ra2EQQdfVMAJZ0-95IyuCZLm-V8feYK9b3DYgjJhw>
    <xme:JxOqaY4bTmirlTyQZz8RB2nukg2_Pl-W0rZH1VKihg_DT5hAD2qvDvXZ_5_8g4Jti
    8pLrpDhQJRDXXvBkZm0XcDCg3L04VBxTVfJf0eD0gQpVwKm7xQg>
X-ME-Received: <xmr:JxOqadJXaVVCwpJuYbFpFX0ziMURLKIxd0FB1GjREBXNy_qticbhoPaFFFrGzJ2c4Isnx3oN10oTlUaC9Bh6phiWzJW1DquQFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdfflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddv
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JxOqaQ6UI_2YgbD2Pr0hHJD0b4xtOfeOF0hrl4YRDWDGRyqEdd8Cdw>
    <xmx:JxOqaYwZdMo0_IDFZ4DDeArAr0K16UUj8gI4mxQY-pvjMqGfcS7-Pw>
    <xmx:JxOqacYpBIKoKNKVndPNBDzwcHdT5hW5owQ3YvWipJqw3DoST7urlg>
    <xmx:JxOqaSS3qL2txR7NpoDBqp4N36RP7rwDHyjImq5EZh8cTnKpH7N3ZA>
    <xmx:JxOqabfhmYR3ITk2B4M0zzEwaZBhE1K8YalI_FEahUd7z4UbuYdOeQHI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:35:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio Hamano <gitster@pobox.com>
Subject: [PATCH v5 5/7] sideband: offer to configure sanitizing on a per-URL basis
Date: Thu,  5 Mar 2026 15:34:50 -0800
Message-ID: <20260305233452.3727126-6-gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.53.0-629-gb58d2f6a3e

