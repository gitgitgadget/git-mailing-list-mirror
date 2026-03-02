Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39650342523
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475116; cv=none; b=S0rG2JFwOCYYzGfjXPTmXUFnEUHfb7jD4bNwedM6fljC/vFzFmzvkJMaaAjsbSHlveNQJIAWIxHDnsottxU5LpukjacrvN4nVCnnChbjJNZM7HR1ObGBn7PnIfvtGJEguGuigJIsNh/vfMbAHoyHkzMXDJzyNSrL5C0APRsPbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475116; c=relaxed/simple;
	bh=SPuwRqqDjAN7HHujnRErK9VXw3Eme4rdyjHU/dZFC18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpCJyHIC1w3akCP1ioXUb0iE04nZPZ+kC+OwaT3iNXKyhhxCCMGrKaY8ptqOfRoinY8oSiWS0mAoF+b+9J6mq1exAVBevd5wYu1IzmVsc4nS5sv5My+RXcIWvyhVvcvD7N9HfoT8X+cOHPEt1qbVl74A41znLjRdRM4MRU5r8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L4N0+47j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/oOOUiX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L4N0+47j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/oOOUiX"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 84373EC0546;
	Mon,  2 Mar 2026 13:11:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 02 Mar 2026 13:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772475114; x=
	1772561514; bh=Lf4mayG7ikXfagSpS63oBwtXcSGuX3y4G0UZBvPJUdY=; b=L
	4N0+47jlq4mjhCzj+3agfW6jXlLlyM5olpLJKVHhYMqfEBK3UmJlXgmUpGr7duim
	lpDaIli7u2GeVOTVvDgSj3rmPkEkB/YbBikELgD1xNzG5+H4DwH3o8psiWwzTY62
	Q4ilnml0MnGLyBt8ZKJm994rDoY0yKaQBc80pwzW9ACR5MdwwGXnLEn42hsyd4zr
	R4aGW5NU03itl4o4B03Fr87EBVQ3tY++lAAbfA+Dc74xV2edTJF0NsJqCNaLWg+8
	ohWBZBrGd6GMaokPJpX0346uVPqTOvmOLUTaLdVCaLDbiccc8Xdk4O6k7DsBeS+d
	qn6DIR8s8DYkixOsPPL+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772475114; x=1772561514; bh=L
	f4mayG7ikXfagSpS63oBwtXcSGuX3y4G0UZBvPJUdY=; b=e/oOOUiXf3aE0JPPu
	pln7DbJlO3I3/gAvzoXydt3rktqFY0MTtGq5nj5w9zYQNIDu/VOLCnwmUfrDgG7O
	a8vEq9O2cyVi1hgjqSjKutBI7nqgY2pYYo1bJy7V+qjAIXZdctR2WfSBkLraaD3R
	Ogc1mGcpnKj9QWi3DIJ4oME91OSW13yA9GduzBIDRyFuxLYU69JksGJ0RuMG+zyQ
	E9B1qaV9kJ51UIm1fMkYhIhgUI8tyWP/cKX8n7Bihg9bMbe39jDs3umX8llMERNB
	azQ+AiUHZ6kEueqO+tWPlVSXbbfnu4ygg1UYLlLd2Mo7EHS8p6YbqjIjs6NVyInl
	dzWfA==
X-ME-Sender: <xms:6tKlaZ68vgElht12SlHT3c5alMrL7puxV4WEjEabW9ZWZSHUXiEvEA>
    <xme:6tKlaTcqIHl_LyFhpzo6qbxfL8UdN3japVpypaBZFI5F-Azp-YyYtzCLwm6i-2lke
    8bh_cAdzEbMlDCKaOUZmn3cHAeofkFEFwMtHeV_8bMEbw-Z9tefng>
X-ME-Received: <xmr:6tKlaU6c-YieZeiWef8QqWIFHEwBr9rf3jcTFOZoMU1DkU9AZ3Xnq4itKw1QAMI0tlP2hDz0uy8dfY-LJSunJTxD_LATymxgyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdfflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddv
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepoh
    hpohhhohhrvghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6tKlaY-iEoEClW1x_FTfAERZYBFfMKW3BmHM70y6zSaAtGSpimhv1g>
    <xmx:6tKlaeGI7exxjtYnV3Vf7O8lXxVkI_uupIvLJ3LynUsYI9ip-b3IsQ>
    <xmx:6tKlaVXli3C-JCmJ8KXxI9Da86IcBqKvFnRnRsFk4PNMOaAB5CxmvA>
    <xmx:6tKlaS9st09IRjbWxFqkLhTV38SaoTnK1SjCz2PZFjvDKdJPCIL62A>
    <xmx:6tKlaSlwV7Jl6_-VGEW2tNs179G__DIuXgWA-k2h3u3ZyD-tLuW76btI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 13:11:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	"D.  Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH 2/3] sideband: delay sanitizing by default to Git v3.0
Date: Mon,  2 Mar 2026 10:11:48 -0800
Message-ID: <20260302181149.3502811-3-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-549-g863838a955
In-Reply-To: <20260302181149.3502811-1-gitster@pobox.com>
References: <xmqqv7gcnwd4.fsf@gitster.g>
 <20260302181149.3502811-1-gitster@pobox.com>
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
 Documentation/config/sideband.adoc  |  7 +++++++
 sideband.c                          |  6 +++++-
 t/t5409-colorize-remote-messages.sh | 18 +++++++++++++-----
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 96fade7f5f..85205477b7 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -1,6 +1,13 @@
 sideband.allowControlCharacters::
+ifdef::with-breaking-changes[]
 	By default, control characters that are delivered via the sideband
 	are masked, except ANSI color sequences. This prevents potentially
+endif::with-breaking-changes[]
+ifndef::with-breaking-changes[]
+	By default, no control characters delivered via the sideband
+	are masked. This is unsafe and will change in Git v3.* to only
+	allow ANSI color sequences by default, preventing potentially
+endif::with-breaking-changes[]
 	unwanted ANSI escape sequences from being sent to the terminal. Use
 	this config setting to override this behavior (the value can be
 	a comma-separated list of the following keywords):
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
2.53.0-549-g863838a955

