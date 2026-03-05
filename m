Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BB368274
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753701; cv=none; b=aRZkcyw6+D+ZU5jkvMw0VftOUq1nE016VDDeua9O7D5f2lfBmDRDbtQfi2VFj4zbkGhYU6Wf9aOiO7/fbiYPyZT2oNlwV/G42S3OohGxjFCVUB4ekZS+bH8EvW6e3JyrVBD0aHac+ybUZ7H9+W1lieqHBdH1xIHkWVsgndZc6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753701; c=relaxed/simple;
	bh=StuLTcIQjPAvyy7ZdiSO5Cj0mWd4J66O6vmUXKFDpI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuhjJtH0k8m4WmaJBtlqDLftdrZE9wvMwwMsyvbIjDjVdMQqwovWerWhKJrwE6TPFsBcYlgneBeyV8LQvoH0e4uz30usJOQA/SdkM5GW48w3yCsavYJnYzaB1uPhbXHipQ47kYeVsLmEySeaeiDHV8fw9Pdc6B7E68Kznz0v9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VcLf9EAg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZfu+ApK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VcLf9EAg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZfu+ApK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A96A8EC0582;
	Thu,  5 Mar 2026 18:34:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 18:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772753699; x=
	1772840099; bh=nDHpS0YEag8VOG7Jg0CbBuciFVoIe5cnHURHQrFV/pY=; b=V
	cLf9EAgYKfwZ413f/lK9JHjj46uMToBk8VCHY0sidQ8ntIU9gnRZlNap1hWkxcmS
	kMInenVqpsz492sWW6DPLAkCtwKdeZnHzuLcABAUTL1gXaQmYwu2yyHnC74aAnJ9
	s3sksYc5tp8qw6G6Nn0LPdT2Ix4q6rIK99hDgF8p/J6+OkmRd006+a8QTuKpKzLj
	viCNLRulWP4ovTJuwxcYOA/T9hLeHlnKGsKhvlCBi91QUmliIWc0DRR+OrxGvrsJ
	fg9umGk8uASQJxb9CYrH4c6hKaXg9jDwkztJI7AiruMVk62Qt1lP5QzQKlfJYbPT
	/GEyPjVOtmfbY6kNUAMBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772753699; x=1772840099; bh=n
	DHpS0YEag8VOG7Jg0CbBuciFVoIe5cnHURHQrFV/pY=; b=nZfu+ApKv3Zt7UGxG
	ylJapO3kp4LIHME6Q/zST1SXnKpzrHRlUIIdHXhTPjpMsnyaNjCTj5huN7r7U+aj
	d7ykL68sicYsZ4kJYI1GH2IQDYPlBg4gKn/U/oQNHaI5tgxwv0snu6izapOP56iH
	a/psYbIrMG8v27MnqHeSXiud2RaoHVA5gtzSmmnKL8No1fbjkBlGc6/zhNA1kPti
	gj/4wcYIslffOkMYJGNLg1DBsr6mZ0lZwRIinWIAzs9PJT0ftyajh2dgevDZXue/
	TLBHjoOpz3dfZwJuVz74uZAFZHV0jpFBf2aTFh1PI4hkfKYV24Ut21bYa+GnwDrO
	Bk5Ww==
X-ME-Sender: <xms:IxOqaQX1_aDvrSPjF38daIfgoHzIoeUnjXjCUJtDisjbUmUmsH3Rww>
    <xme:IxOqacDIsZ78AaEyjkBvNWaXosKQjR3rYMwffsz9aDy84agkthURdN_oMMtrd7EIW
    CNQiFpc2Cpv3RpkMlLjIZT_a-ZocdmdVJPFzuQFX9LM0kMoJU5J>
X-ME-Received: <xmr:IxOqaRwCjRF7Lk_QnWyRdQknPgq-F5r_ZEFPH4D8S5AE2L3agNTdIMaoq1bYlaqWoQ0lBKOlnuAhiaFdhqCWZf-6e2N1OJF1EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteelfffhgfelgffgfeehteefvefgveejveegvdefveegveetleekvdefffeh
    hfehnecuffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgv
    shdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IxOqaZCRiUsvyrCznQphHpWY30KkYCqwSsau9msI8eoIc8ejbrwJrg>
    <xmx:IxOqaebVez3tDiJebX-lJNnR65b-3QLh9cJdoULmjTFsRltkxbeavg>
    <xmx:IxOqaRg4gB6uoUBjbzZrO48UR9jrlMQZU7_sqHel5OigK2CwTtlv5Q>
    <xmx:IxOqaQ588CKEHQfndaWDtdry8FbE61BhijS-rmgqsbmo1wrh9htn7Q>
    <xmx:IxOqaWkAtoszmORDjKnmc6lSPD-96qSMuz-jZNF0E2S5QPu_zaUbvMd3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:34:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 3/7] sideband: do allow ANSI color sequences by default
Date: Thu,  5 Mar 2026 15:34:48 -0800
Message-ID: <20260305233452.3727126-4-gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.53.0-629-gb58d2f6a3e

