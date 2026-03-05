Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90532368277
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753707; cv=none; b=j4wJmKPxzTKsVgXgVlYh4wLd9Q+SB5od6x+zIEX+fAHEimQzgdRb8jAqt4Gq6kakoHT8QZdnavTSBWDaH7BMBHPI49vWyqjFB29+9A1B4+xqExJUE5Py3IZRbV9qT6qGNQy1CIbRRv5j40mo+ObJTHqKboJF/wZV1NyNbEqCQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753707; c=relaxed/simple;
	bh=zu55jb/g1iC9RU2rKQ+SmPHfPJano58oZtbEOGYI64M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkRWVlKlLwvRfBfy8E12KxlN2BVA5V+H6OsVdNUrejE1MAbKQpV9mn5LIn0YVMHc6S8f7HEl8f2hQNdia5mZv0eaRc/GH0VfrMJRDH4Rq84leFL1twQqjKumReZx2N/N8MQbvnSvvB/BCvX5ppwMyhT9FyU1U8WbDz+JzC2FZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iZvbLaSy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kl6khw3S; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZvbLaSy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kl6khw3S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 032C014001FE;
	Thu,  5 Mar 2026 18:35:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 05 Mar 2026 18:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772753705; x=
	1772840105; bh=iozVWp0whK1PaPBp5MAWuEeMVEIf3agDK1OO7zZWiI8=; b=i
	ZvbLaSyXkbEVIOwApQEzpu48mdj/2OVbGv7hhxHs8rjaQx7IkTvzRo96LGeGual/
	gJaeVuSN8ZrAH/P3fYLoUqX3IeAmJ9sZ1uZ9/IwXTCtcw0MdUoc1nwdmP3fOjd0u
	czGUhWtdc6FC8Ya97SUf/rh/gUqqptM1V3/L+p5kAw95ZdXY7KbG22Ny2mQkz96Z
	2LN9P9ZPP6HL/w+lVlHy27O0OyEtdhGZq5O/SFjN2c6h5+LHd0OR7Vx/YT0AIHFQ
	ju6rhrxPku5/MvaS71goyd22jfZSDs8tmUYmnLe4oZV6H7DlJywfvSjyE/ih/TCY
	CQs6GJVC87iGWSRvTfGmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772753705; x=1772840105; bh=i
	ozVWp0whK1PaPBp5MAWuEeMVEIf3agDK1OO7zZWiI8=; b=kl6khw3SC7VUooorI
	kNJ0lPDJurgy3ZvARJz8lIyiuKtkcG6kSmD6DlqW9T3Ck/TNMX35K6yhUFKgcN2h
	MRfqhXKsuPmN82vPahWW4wQ2AQuGy/GnJb8rhI6rpnhPbOSheFTpF4IjuSQUeCYc
	hjcvI8ZLtt9QjJ22U4tNfIaEXLzBAti4uLCkR2XFuDHth9iO9HTJF6cKU8gQaPwO
	c92HuiHVGAHmkEuoYLljGEy4K7TQIt/yfRjFWEyS9vf+/lm+XoU+WN/SC7ad7xEX
	8F36OrXCcr+/xPq3QbmefunVG2/L1aRXFcykE6pDkitw1nW2vpDn+hOpirIT434t
	ibW8w==
X-ME-Sender: <xms:KROqaXFxLRv41wEOQW7ItDqHg0dwGwap7EgwROjB9sgxVMY5Ogt0nA>
    <xme:KROqabzKQqrsYI0zLu8-Zv8ZuybTMBFxQAwkqcTjIhCK6FCfoxd65eKB5LSqDvmtn
    LCEz0HJF0thXl8epFyAAZqSaP06YXRsKyAyXrXSs0rfC_j756rECA>
X-ME-Received: <xmr:KROqaWhCY6Lb60RfqmLsgaYuvDlEPS_XOCL7h5awvPxCPJXIE1os7T2wuY6YkW8R8I5CIUrbhX8h7Y0r-yTK9kdSn7G9pzFehA>
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
X-ME-Proxy: <xmx:KROqaew5l6L3IhOaVHwlJTXHzundgLVybkwFhw2R5jSj05Rp_Tmljw>
    <xmx:KROqaRItX5BEha2jcZ90Wko4qZqL2HqY9UOS2CBibnwkiaWkSbA10g>
    <xmx:KROqadTdLS4DTi11OauVRmpxPvXU9s2qhz_TjEMMbaM1JqEOjFjVLw>
    <xmx:KROqaRr1FqRdkfxqBEeaRExWRn-KRhvlJASYNa7wDwFCQ0YQQzdGQQ>
    <xmx:KROqaWWnN00co_ibgPa16Kir_ALgWnw6dXLzySqD0L1t7TiVJbQoMGrQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:35:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 7/7] sideband: delay sanitizing by default to Git v3.0
Date: Thu,  5 Mar 2026 15:34:52 -0800
Message-ID: <20260305233452.3727126-8-gitster@pobox.com>
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

The sideband sanitization patches allow ANSI color sequences through
by default, preserving compatibility with pre-receive hooks that
provide colored output during `git push`.

Even so, there is concern that changing any default behavior in a
minor release may have unforeseen consequences. To accommodate this,
defer the secure-by-default behavior to Git v3.0, where breaking
changes are expected.

This gives users and tooling time to prepare, while committing to
address CVE-2024-52005 in Git v3.0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[jc: adjusted for the removal of 'default' value]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/sideband.adoc  | 12 ++++++++++--
 sideband.c                          |  6 +++++-
 t/t5409-colorize-remote-messages.sh | 18 +++++++++++++-----
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 96fade7f5f..ddba93393c 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -1,8 +1,16 @@
 sideband.allowControlCharacters::
+ifdef::with-breaking-changes[]
 	By default, control characters that are delivered via the sideband
 	are masked, except ANSI color sequences. This prevents potentially
-	unwanted ANSI escape sequences from being sent to the terminal. Use
-	this config setting to override this behavior (the value can be
+	unwanted ANSI escape sequences from being sent to the terminal.
+endif::with-breaking-changes[]
+ifndef::with-breaking-changes[]
+	By default, no control characters delivered via the sideband
+	are masked. This is unsafe and will change in Git v3.* to only
+	allow ANSI color sequences by default, preventing potentially
+	unwanted ANSI escape sequences from being sent to the terminal.
+endif::with-breaking-changes[]
+	Use this config setting to override this behavior (the value can be
 	a comma-separated list of the following keywords):
 +
 --
diff --git a/sideband.c b/sideband.c
index 04282a568e..5fb60e52bf 100644
--- a/sideband.c
+++ b/sideband.c
@@ -34,7 +34,11 @@ static enum {
 	ALLOW_ANSI_CURSOR_MOVEMENTS   = 1<<1,
 	ALLOW_ANSI_ERASE              = 1<<2,
 	ALLOW_ALL_CONTROL_CHARACTERS  = 1<<3,
-	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES
+#ifdef WITH_BREAKING_CHANGES
+	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES,
+#else
+	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ALL_CONTROL_CHARACTERS,
+#endif
 } allow_control_characters = ALLOW_CONTROL_SEQUENCES_UNSET;
 
 static inline int skip_prefix_in_csv(const char *value, const char *prefix,
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 3010913bb1..07cbc62736 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -98,6 +98,13 @@ test_expect_success 'fallback to color.ui' '
 	grep "<BOLD;RED>error<RESET>: error" decoded
 '
 
+if test_have_prereq WITH_BREAKING_CHANGES
+then
+	TURN_ON_SANITIZING=already.turned=on
+else
+	TURN_ON_SANITIZING=sideband.allowControlCharacters=color
+fi
+
 test_expect_success 'disallow (color) control sequences in sideband' '
 	write_script .git/color-me-surprised <<-\EOF &&
 	printf "error: Have you \\033[31mread\\033[m this?\\a\\n" >&2
@@ -106,7 +113,7 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
 	test_commit need-at-least-one-commit &&
 
-	git clone --no-local . throw-away 2>stderr &&
+	git -c $TURN_ON_SANITIZING clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
 	test_grep RED decoded &&
 	test_grep "\\^G" stderr &&
@@ -138,7 +145,7 @@ test_decode_csi() {
 	}'
 }
 
-test_expect_success 'control sequences in sideband allowed by default' '
+test_expect_success 'control sequences in sideband allowed by default (in Git v3.8)' '
 	write_script .git/color-me-surprised <<-\EOF &&
 	printf "error: \\033[31mcolor\\033[m\\033[Goverwrite\\033[Gerase\\033[K\\033?25l\\n" >&2
 	exec "$@"
@@ -147,7 +154,7 @@ test_expect_success 'control sequences in sideband allowed by default' '
 	test_commit need-at-least-one-commit-at-least &&
 
 	rm -rf throw-away &&
-	git clone --no-local . throw-away 2>stderr &&
+	git -c $TURN_ON_SANITIZING clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >color-decoded &&
 	test_decode_csi <color-decoded >decoded &&
 	test_grep ! "CSI \\[K" decoded &&
@@ -175,14 +182,15 @@ test_expect_success 'allow all control sequences for a specific URL' '
 	test_commit one-more-please &&
 
 	rm -rf throw-away &&
-	git clone --no-local . throw-away 2>stderr &&
+	git -c $TURN_ON_SANITIZING clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >color-decoded &&
 	test_decode_csi <color-decoded >decoded &&
 	test_grep ! "CSI \\[K" decoded &&
 	test_grep "\\^\\[\\[K" decoded &&
 
 	rm -rf throw-away &&
-	git -c "sideband.file://.allowControlCharacters=true" \
+	git -c sideband.allowControlCharacters=false \
+		-c "sideband.file://.allowControlCharacters=true" \
 		clone --no-local "file://$PWD" throw-away 2>stderr &&
 	test_decode_color <stderr >color-decoded &&
 	test_decode_csi <color-decoded >decoded &&
-- 
2.53.0-629-gb58d2f6a3e

