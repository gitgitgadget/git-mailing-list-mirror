Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF608313526
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113891; cv=none; b=jMwssXCBBqSTibkUwlD89oWnMq6KEa4B0W89riETWRwqSKErSrluTBEc1Vv7Mou3escee9+aPz/G62rt05eWmqMfEKoEm94oCLxkfpWgGC9bRBMyVVuEGpkhtDxWNFCWN1CoGecKOIKLiXi918rfLVteKCaTYTg1hz2DxlBLGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113891; c=relaxed/simple;
	bh=YC1EuP7Xd+XNJF+LEcT1cyyOTaXthCVcDQ0071iX7rI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CqRJ/HrPYqV2O4B0uPJLLD6dFCqn/3kRoNgZxogBO04xS28e5DtGLkuDaXn2VfUZTM6EwzG0SvrMT6uvtBMkv74/vWTShXxlQhzFGmIGgsndyrrLrbVMSZgW9P2HFZ1WFSlQA7PNGZayZQYEMk/EPnPv4p23IaOu7T/u74fdTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc1capn5; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc1capn5"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11f36012fb2so6356841c88.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113889; x=1770718689; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRPuyP7Syb7gkkOLmbei5etkw72mi+q/6wD/DH9BBdA=;
        b=Hc1capn5jLf03Sph7OkEFKemlK1f6Liu5Tx17hjq7hMynb3BQSxv+eu7YA0JP/O8PD
         5s9CgNZPjOrUnGr3gkAgb9gpAUfa3ylQDfgzZxfDrYQzAM5mpygL42G/yAPYzfh3dgXN
         L2sxVzBCjfmoDLQt6R/4RtjCmFyDQEyEKCaD89hGt2xoinhwzLuik1PZXe6NUJhX6fNY
         PAGVxDEP1NAUrvbGbhGwvApEUbPHGCcw6YqjSvD8Prkzb6rAX8CwTT2jCYEpjrfXxS2U
         qO84+l8swqVrcisLXpYJ7metZPMbDynRYf9f1hbp1iMlbBOo8LpBM23ozee4rb8h8fyi
         4ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113889; x=1770718689;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qRPuyP7Syb7gkkOLmbei5etkw72mi+q/6wD/DH9BBdA=;
        b=UnNleJLgjndH1Uz94s9YPrUVrHx7H5I1ZA8YVgqYJmpmAdb39NPprEe3pSLqZqOqrX
         Sj/rktO1UgKFKBj8inEFoQWGyv/Wnd7nzEp+R7+pMt9FhxGagSbqK4ehDB29q7DqVl9n
         VNd4KkLyuwM/os4szu/lHDeLY7LRdwvYFE32E/zlYaUIAgxGEpDFVgjo6KbPg7eRDbYo
         whvXfhvZHdlpzbORyyzWrD1w5RFCbHWhLbrDq7/aGejkTt3ayEVxVTKRmuJW8l2hHjiF
         +eDsUubs2Uys7sY2R6okWDUvsnkALxxtButYMm/Ff9GgUsIn9Bdi2L4lE83aneagG70c
         wEyg==
X-Gm-Message-State: AOJu0YwOnmbdEzNmdyqeUPETc9+ZhH6BM2lijRWcyVULZmrHGLc0Xija
	AalpcN08jAj980LSWXjfcuBOvpw1clZhYvWNwjF9iU+N3emxB+3C7Ne9m2uB05js
X-Gm-Gg: AZuq6aLwghqU8ebehJw/DXU5faJcy3RWbP6n87Z2KPm/f2eO7FEsQbfVnzxDE9fYQ+z
	2dXwRuyDfmANStZ2OVpfPh/BM+9II3rpRPdp//bnKyi+qEqaqPQHkTqBpeCFJ/mgXHUIxLTMv/M
	T411oNHqwk73fhO58yb1wl0yu6hAfeRLaYkuQPvOw2W6wR3ouGOaGwvEb2MYou060NnuoZqr5Qe
	vU0k3LXQunw/wiMgBUJG0gjuPVELMWPnzJ99DpX/lMgJf32U9ih2cm0vO13bN77AJ39zHaZWI6z
	LcNGbooUDoLggX0cIgHAPrXVgeO8yBCnxo1nFYsh+SZRAY5c2+wFwoH3HsayaddIccP/UpxyT5c
	yxGQmDAoRwDiHreFjBYolrXL4VEiZ7tw2opMR+fTz5OX82QDlp2T6cwajqhoC7sTY4hYnZZIiNw
	j9/NRcaOr0E7WuzQ==
X-Received: by 2002:a05:7022:226:b0:11b:9b9f:4283 with SMTP id a92af1059eb24-125c0fe0456mr6689118c88.24.1770113888514;
        Tue, 03 Feb 2026 02:18:08 -0800 (PST)
Received: from [127.0.0.1] ([128.24.162.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm19650772c88.16.2026.02.03.02.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:18:07 -0800 (PST)
Message-Id: <20058534e869e0ab520e28fdc82ee6437d505ad2.1770113882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 10:17:58 +0000
Subject: [PATCH v4 2/6] sideband: introduce an "escape hatch" to allow control
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
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
gitgitgadget

