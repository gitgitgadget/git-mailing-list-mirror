Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90C0368284
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753700; cv=none; b=TqRHTSzXIEWH960JveVLBP2Cz18JUXMddqD2HOVwODaPhAMsnA1tguZcH50E1Cj3L9kt/EGqr/2psPpLpbsQ9NOxpufuamLOvhIJP1bjKgJUBqHnSBjaHqh5rLcm1N/75vl33BzxvXq/DkuBC8yJIFJuugo5ncwRl5mi1jGame0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753700; c=relaxed/simple;
	bh=58ngq1S+o9n3s6Ao9ivTDk9u7nVpqwBmnaganzDGaD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYPyenrkcxkodt36zWC/VKZtRdUaifFEqkwT7C6V3Uo682BBoS863fHe6lXPWtGHf6i1LUurn94WfjgU8Y/DNUTrbJlcC5iUZeZRktOzPvZorYtXjpZAPzFZj86un6pJ7Fim2ns145S7488WeYO+BSN9xLWbpEVBo/iACLejhnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lbi56TOA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aUWFqWEC; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lbi56TOA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aUWFqWEC"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 443691400216;
	Thu,  5 Mar 2026 18:34:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 05 Mar 2026 18:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1772753698; x=
	1772840098; bh=2uHr3v7cDAcq72Eav44zM4n2KxqI88aTqSjZLAb395A=; b=L
	bi56TOAlNBSDzPQPkqauFGYy7JVNZnozVFp+DYajdu4aAT5kQsA/DOob/o6tY6n0
	uepWqyNNPvoTE6mkHDAduxh7roPwmDjGKoJJBtON+SnHYM8yfEnFzOjz7dXBr9wl
	I++q16JT2U5CCkV3OK/h3CcpTC+PPbWAfEL6OSUqiZ7ahxBp/38Xck0fypslVefD
	JcHi65rz+7ZhWvtqlt6n45goHUj2EJS9alMg5yLdxLQmW/WxWgTAq3BV6Scb5KWb
	Wc/Pg1nDpF/UmhZOqXsYRmXpc/L9LgCQp4oimU/Sl3FOkLDZcnLaTef4JVzZJg2N
	9UZibqKoVoKIGaZu1RJzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772753698; x=1772840098; bh=2
	uHr3v7cDAcq72Eav44zM4n2KxqI88aTqSjZLAb395A=; b=aUWFqWECTbeK2W+qW
	DddxlykXdNXQiUM+9Io4AaAfo4IfBM5DfBpj5SVTYwR+sAtuOBnLaW+v18SazHDP
	PC+bumWUNyJrbu7mh7wAjyELhTsCBA/mUVnE7PH79NrP29dCYzLkFDSSoq+dnF4s
	N1VIIXeAaRUhHWQ08BfguL0J8dsPzzX8PG79+oB5VcngI8v2m132IQkFs5SynKKM
	bul3zZYfuEb2AdOjU59vYs+j0znIVh66jf0HGI5NMmgVOG6exOvsmGQ+lDOHyR40
	dETyVIhzR+1QZPA3rxg4DJqLWUFVfZiesteOPWzl7qZrUu49QP8ti6fJyDCBqcce
	bzC4g==
X-ME-Sender: <xms:IROqaUStkA-CDol2iXMebLnP9v12k-6dNAHoL4AA8L6DJ92KDwqkjQ>
    <xme:IROqaYyeI7Kx0LCNW-N_tMdRHJUiqNY8rQSLJNgv_-Qd3XvyDsJlB5tVzBAQ3nm3t
    1NtXPZLy2ENo6CbQaPTn84nimeHTICKzSoxcAwt5hoOBJxdf_aRkw>
X-ME-Received: <xmr:IROqaW1XltgwK5FVEf4LYabyN-JjVYSmIrEhY3u0-DOR-nSftjXJPjYFxPvdQNy6bUpGx1AfbOvLin1JNRtiqHdvwcSZJqwmrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdfflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddv
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IROqaW41K0L9aKJnM4dgDyX4qjlXEB0Ssc98Z-2iQ1bVCQQ53u0tow>
    <xmx:IhOqaZXJD1EPVo459e8eGZJe48G9icvBDOrjovmTTKKmkrvDx8t_YA>
    <xmx:IhOqaVAAxwxG7IF174r_ar0gxi6pgxeniyC6-qRIkifjGiS8UmPmIA>
    <xmx:IhOqaY4Vrmwhcmv_zxrHbFRUvE3EIXrxWkxdy2fBatVA3FBQUp54Gg>
    <xmx:IhOqab8-b863dIlVVyCn_I67l1paP7r0jUVBiwmpCJo9-nQZc1ltfWt6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:34:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v5 2/7] sideband: introduce an "escape hatch" to allow control characters
Date: Thu,  5 Mar 2026 15:34:47 -0800
Message-ID: <20260305233452.3727126-3-gitster@pobox.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.adoc           |  2 ++
 Documentation/config/sideband.adoc  |  5 +++++
 sideband.c                          | 10 ++++++++++
 t/t5409-colorize-remote-messages.sh |  8 +++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/sideband.adoc

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index 62eebe7c54..dcea3c0c15 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -523,6 +523,8 @@ include::config/sequencer.adoc[]
 
 include::config/showbranch.adoc[]
 
+include::config/sideband.adoc[]
+
 include::config/sparse.adoc[]
 
 include::config/splitindex.adoc[]
diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
new file mode 100644
index 0000000000..3fb5045cd7
--- /dev/null
+++ b/Documentation/config/sideband.adoc
@@ -0,0 +1,5 @@
+sideband.allowControlCharacters::
+	By default, control characters that are delivered via the sideband
+	are masked, to prevent potentially unwanted ANSI escape sequences
+	from being sent to the terminal. Use this config setting to override
+	this behavior.
diff --git a/sideband.c b/sideband.c
index c1bbadccac..682f1cbbed 100644
--- a/sideband.c
+++ b/sideband.c
@@ -26,6 +26,8 @@ static struct keyword_entry keywords[] = {
 	{ "error",	GIT_COLOR_BOLD_RED },
 };
 
+static int allow_control_characters;
+
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static enum git_colorbool use_sideband_colors(void)
 {
@@ -39,6 +41,9 @@ static enum git_colorbool use_sideband_colors(void)
 	if (use_sideband_colors_cached != GIT_COLOR_UNKNOWN)
 		return use_sideband_colors_cached;
 
+	repo_config_get_bool(the_repository, "sideband.allowcontrolcharacters",
+			    &allow_control_characters);
+
 	if (!repo_config_get_string_tmp(the_repository, key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
 	else if (!repo_config_get_string_tmp(the_repository, "color.ui", &value))
@@ -68,6 +73,11 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 
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
index aa5b570571..9caee9a07f 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -105,9 +105,15 @@ test_expect_success 'disallow (color) control sequences in sideband' '
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
2.53.0-629-gb58d2f6a3e

