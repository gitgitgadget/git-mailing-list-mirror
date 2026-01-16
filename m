Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266431327A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602385; cv=none; b=Pl2l+hcdLlKkbPaFUwPkqJebFLr+ArMA/pWL7Wm7h4e48afNJ02PViL4yW9e4byWPDDqs4onDsf1NfSmPcP5BrsLbvWba9qklXLVV3MxFUdz/LbpmursevVjjm10+4UJtC3NGF64DC5OpFBrXHFsWQ2Tt8CgclNuqK2UvIWnxYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602385; c=relaxed/simple;
	bh=3zoMVp4z5/fDHMKWWwAmij1g8Zc6+CGMpUAfV9LkNio=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Kds5xz7Frq5jm+dO5Npp1D5xC4p70XdXkxPZg4j9wwfCvFvP7XPaBuIHru+aCHPB0v6q4WaB7FQcvGMpy8kGybDvtjTLdb2Z9voC8Gb0a+WMbXkV+GF7TeHxY2w9PLmprRhrCra2SA6aEu7l4K4UW2Gh/KgwI3HQQ836XSXrcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp881Rje; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp881Rje"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c52e25e644so236088985a.0
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 14:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602378; x=1769207178; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkVJyWC9VCkTEtK3KoLq3DiZ9a2MR72lNUHR0cr6AH4=;
        b=Vp881RjebxDBOfpt91udJhLmmiIkgrCu39dFFV5O3QWJeAeT7KkMsneB6SBSgV2tCs
         GW4VcOv4GLai9FlD7JbKjEEiVgP6+uhI/6lgdj5whUta2OxpribXgpv5dIlYUYa0ya9X
         KFWuIXOgnY9whUjTRo/EZpX1UHc095qxGmYYlFoyapJbbTfjLfTXmx3vGZNVgcFR4tRt
         HM3GYKSTJY1FCq7+o8VKj8bugVskfYh6hGm+icxYc7Y+bQbNlYMWoBHR9xCoiiETe6P/
         m4+UqGJIRPy7B0Fu8y9+rSD/9e82JY706WDCl785tZgYRSQsICAwLc+eAhj1GZs8w5OD
         iSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602378; x=1769207178;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkVJyWC9VCkTEtK3KoLq3DiZ9a2MR72lNUHR0cr6AH4=;
        b=Mrcw/O+gNeCLx3odMIhRg7WwD4FE4PExLkwHW2tVpHbLwWJUhcbmWOyFPEstI02Nh2
         7lSrZ7pq7cw+sj4o0i7hCfeadRP0YnUXJCF9Fi6ge+4c4NT7TTlohKyZmtPUZFUrwpQ4
         y7JpddCZQzBiTVSR9e/GW+gUN8uK7z/i8JgEw+Xn22hHZRhIxY79iIxt7WraOlInciI1
         t8uhrH3vsDJIN664GVs3k4Ds+R+qy7A4g7zRVAQUgaeXBHOdPjaqCUN7JFN5+6AQvatF
         Q4Hl/NttRy9wWOaR6/Rh7eNYgHMOID3bSPejEFuYvnpvui0NMJjed1mWIaME5EmQjwmL
         E/mQ==
X-Gm-Message-State: AOJu0YxTg0wdrwhKNY3euw6cM9Mj2rTkm6PotvGhqzxnDBTH2YoysXeT
	LZ/iJhWHbNRJkKSxqkZtl0g7E7UkMAYIORFcbMpt4Ao/q9vHyW1Q5Kl2RMdK2g==
X-Gm-Gg: AY/fxX7eRVRKLePL+yhnGPRyxVpPO/llTL37uec40qYTECAOEs+GWkrop3muUqUGKeR
	3g0e6er7dtMWI8hYklVFwTbL/1289QK8lhNViqyVeHr3BYx2LmRXPZ09PK+9ZTSuSrg94S8Um4y
	5GcOQF6bH2465alOvFmnHjNSBv8oscaH5KDTd2EnthktLhFeiue319gzVEkvsc9VYe37GBMJ4MQ
	qXfa4rIm3mZCO8Nb906kpZRTobxURhxhj6PuSEA8YjmITdV73asaEqsOsNWgz5lnBF1H2VXveqU
	pV+4sGc+uMrFiWbB6iVMoZBUQ6GAkQuOsYbFXfZRXS1bAGJCvwLqRMZsefHwjPWxyrqOWQWOwfv
	npE/xOxb8WuSvJM3cOh31uXlu0AEYW7X+YINMu0T+ANqF1DLYqNQbPXuPheT9LYMBZ5KozRX+Zw
	iaEbbJOyLAYgWAvg==
X-Received: by 2002:a05:620a:458f:b0:8c6:a59b:243e with SMTP id af79cd13be357-8c6a68bb374mr612144985a.12.1768602377991;
        Fri, 16 Jan 2026 14:26:17 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72508f6sm318348985a.34.2026.01.16.14.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 14:26:17 -0800 (PST)
Message-Id: <8f64d658447da23736c5dd25010f429b1873b13c.1768602373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
References: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 22:26:10 +0000
Subject: [PATCH v3 2/5] sideband: introduce an "escape hatch" to allow control
 characters
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

The preceding commit fixed the vulnerability whereas sideband messages
(that are under the control of the remote server) could contain ANSI
escape sequences that would be sent to the terminal verbatim.

However, this fix may not be desirable under all circumstances, e.g.
when remote servers deliberately add coloring to their messages to
increase their urgency.

To help with those use cases, give users a way to opt-out of the
protections: `sideband.allowControlCharacters`.

Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt            |  2 ++
 Documentation/config/sideband.txt   |  5 +++++
 sideband.c                          | 10 ++++++++++
 t/t5409-colorize-remote-messages.sh |  8 +++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/sideband.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8c0b3ed807..48870bb588 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -522,6 +522,8 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
+include::config/sideband.txt[]
+
 include::config/sparse.txt[]
 
 include::config/splitindex.txt[]
diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
new file mode 100644
index 0000000000..3fb5045cd7
--- /dev/null
+++ b/Documentation/config/sideband.txt
@@ -0,0 +1,5 @@
+sideband.allowControlCharacters::
+	By default, control characters that are delivered via the sideband
+	are masked, to prevent potentially unwanted ANSI escape sequences
+	from being sent to the terminal. Use this config setting to override
+	this behavior.
diff --git a/sideband.c b/sideband.c
index 3c74f3bdb7..1499587ff6 100644
--- a/sideband.c
+++ b/sideband.c
@@ -25,6 +25,8 @@ static struct keyword_entry keywords[] = {
 	{ "error",	GIT_COLOR_BOLD_RED },
 };
 
+static int allow_control_characters;
+
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static int use_sideband_colors(void)
 {
@@ -38,6 +40,9 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
 
+	git_config_get_bool("sideband.allowcontrolcharacters",
+			    &allow_control_characters);
+
 	if (!git_config_get_string_tmp(key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
 	else if (!git_config_get_string_tmp("color.ui", &value))
@@ -67,6 +72,11 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 
 static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 {
+	if (allow_control_characters) {
+		strbuf_add(dest, src, n);
+		return;
+	}
+
 	strbuf_grow(dest, n);
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src == '\t' || *src == '\n') {
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index f4712f4161..e8067df591 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -106,9 +106,15 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	EOF
 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
 	test_commit need-at-least-one-commit &&
+
 	git clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
-	test_grep ! RED decoded
+	test_grep ! RED decoded &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
+	test_grep RED decoded
 '
 
 test_done
-- 
gitgitgadget

