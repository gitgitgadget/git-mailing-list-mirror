Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60A2F1FDC
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906759; cv=none; b=IkgUT9//HUzna8ZJu0tO/UyWWHtsk422Ve7w9q1JoQRq27gKddhp4UQadjEl1MX40ty6il65SdLc1aTzStA7rdGyXJN6ivn2lKHndUHxJ0gD0RiUMhLFcGTeE3BLNBu9LxmebK24Jvv9bCnadvLQkSaDCwyoKuGrGZCp5I4MRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906759; c=relaxed/simple;
	bh=hvpKKxZuPALwu2Uz4NPiiz4vsJ5DZK2bl54WOxMy18s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEeH9iSMuAn47H+Uc4/HZewhAnCqUXFgLfZE0zJVWVem83cXC2fbn9p4Lvx1hPNN4Bvr54zGgH2ON8Hqr2zMnEJ24M4XHeyr952h6VG8CIdkribBq+Obb9em8Gt6aEpiuyBoEVzmx91CFLO+YdE/W0U/3MBECoBxqZf1FUHANoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzXS1uEo; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzXS1uEo"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45085a4ab72so2851195b6e.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906756; x=1766511556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB6bXUnEUmHAbHypyXTnF6gCWd0gvxJcc0k91I06JDM=;
        b=PzXS1uEolKcWcinbbRVwIAGgtqjLob6a59QvqyF2viG0QP/1ECoXDSE7jG6IlC6qwQ
         zDPwg+/HJn5gBQujHgw29b0hE9J5gUL2MQW5dMI7DS9Vlr5zV4SQqlakkneHnY4dThkk
         /W4Lgj9q53UXyNlCfuHcWd8dyvi7ApwaQkjbXZGzo1nylRe61wr8wszK0XdbEjenWIDE
         Ddoy77oRZYwWTFfo7TLufmBi/3odQ7+I272sHqjYUGmmbUv+blqJ1X3dai7BliVTTxC8
         qTnFECbVEW1NbXU8DQ1YliuMMOIX58fuJLroluY0VkkHqHvJqTrrzffNj/tqRgmFa32F
         wkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906756; x=1766511556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KB6bXUnEUmHAbHypyXTnF6gCWd0gvxJcc0k91I06JDM=;
        b=OY8vbfIj77dzSf/+vkfK9OCFyX2hugbr+R2ZMfcgaAMwbXdCEZTGIDKLR7LUGCVS9M
         PhaC1JEdfUzKnhyZ/WD6Kh4rUJpt0z46hN/14PV9e/phY/h6H4X1hzicQV7ZKkKYUYi8
         l+ZCEG1fUzaNEeEXs3ODl6sMt3PhECJ93783MfJ9M/2PTS/NHlT4G759d5U21wKSWQAY
         4MnT82/9jhTsC5rnur7GaHcTX3BmNZONWh8Ohg7pDXekq8rKoQmQZ4SGfHFdQmt4XY+S
         pSEXis/WJImpCPnALF91+ZSftX1kqzvu4c6ZO3Ovl+tZ4cXpcWwAQEF3tHOJkBRkpTZR
         uxuQ==
X-Gm-Message-State: AOJu0Yzsgd/nP8GNaItuaajsqxLMJu4JhxuWcpiTp4+rILgMIXMY+K+X
	LVGygfu/rHaTDt5KSTM9QignduuqwTMI6TyoGoFeyODPApTCi4VrCJQGugsWQA==
X-Gm-Gg: AY/fxX4vpSHen9dohNFEh1hAEDPH1N5T97B1c3fbnSkOdYKTyhpGLJ2TKR0RB++23cR
	hPl6Wi7VXmw6NeTjEU+JB2kvuKWLo+ssVcZ5HpzXG8wAYwwlxBbuKA6WdMj1H4Zy0/6sEJABzlG
	A22grhIiU2UPJnyqJtnyLbQ719HQs2KyZ46U8ueO9wIFNa+EMdMQ56upQ4qkjRbbU/74UrqU/1/
	y2K2ghki7/asgukJMwC5kMA8BVO16CeV1XJDO2c9bGkXdCrHTB1gEcj9pg2ajSPFQJ5OcxzCVqH
	dZeLg8NcnnXf4fZM0snYodoSOw4gYuQXOMePSH74o155KL8XFyDMKRNjqhWDcpikaJZ07LfPgOJ
	RfnWtFwUxRM63dqjtf4EeySjhXN62NNITLX8htz5ghaMq04ZW/Q4sH8AF+x5AZqjLtbHoVVj4p8
	FEZow9uvwuhiCTyA2x8CE=
X-Google-Smtp-Source: AGHT+IHd/ed0ymk6vaT7p5rBrHxo71G/3jRrdwMtWfT6yy9DwxU33sUWTR+BG6anhyvxEKuC/cyngQ==
X-Received: by 2002:a05:6808:2120:b0:450:1fcc:3a9d with SMTP id 5614622812f47-455ac965e71mr9611494b6e.52.1765906756098;
        Tue, 16 Dec 2025 09:39:16 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm6438462fac.10.2025.12.16.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:15 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/7] strbuf: split out logic to humanise byte values
Date: Tue, 16 Dec 2025 11:38:37 -0600
Message-ID: <20251216173842.3357832-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251216173842.3357832-1-jltobler@gmail.com>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a subsequent commit, byte size values displayed in table output for
the git-repo(1) "structure" subcommand will be shown in a more
human-readable format with the appropriate unit prefixes. For this
usecase, the downscaled values and unit prefixes must be handled
separately to ensure proper column alignment.

Split out logic from strbuf_humanise() to downscale byte values and
determine the corresponding unit prefix into a separate humanise_bytes()
function that provides seperate value and unit strings.

Note that the "byte" string in "t/helper/test-simple-ipc.c" is unmarked
for translation here so that it doesn't conflict with the newly defined
plural "byte/bytes" translation and instead uses it.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 strbuf.c                   | 74 ++++++++++++++++++++------------------
 strbuf.h                   | 14 ++++++++
 t/helper/test-simple-ipc.c |  7 +++-
 3 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..3fbd375ad6 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -836,47 +836,53 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
-static void strbuf_humanise(struct strbuf *buf, off_t bytes,
-				 int humanise_rate)
+void humanise_bytes(off_t bytes, char **value, const char **unit,
+		    unsigned flags)
 {
+	int humanise_rate = flags & HUMANISE_RATE;
+
 	if (bytes > 1 << 30) {
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 gibibyte */
-					_("%u.%2.2u GiB") :
-					/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
-					_("%u.%2.2u GiB/s"),
-			    (unsigned)(bytes >> 30),
-			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(bytes >> 30),
+				 (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
+		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second and gibibyte */
+		*unit = humanise_rate ? _("GiB/s") : _("GiB");
 	} else if (bytes > 1 << 20) {
-		unsigned x = bytes + 5243;  /* for rounding */
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 mebibyte */
-					_("%u.%2.2u MiB") :
-					/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second */
-					_("%u.%2.2u MiB/s"),
-			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
+		unsigned x = bytes + 5243; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), x >> 20,
+				 ((x & ((1 << 20) - 1)) * 100) >> 20);
+		/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second and mebibyte */
+		*unit = humanise_rate ? _("MiB/s") : _("MiB");
 	} else if (bytes > 1 << 10) {
-		unsigned x = bytes + 5;  /* for rounding */
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 kibibyte */
-					_("%u.%2.2u KiB") :
-					/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second */
-					_("%u.%2.2u KiB/s"),
-			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
+		unsigned x = bytes + 5; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), x >> 10,
+				 ((x & ((1 << 10) - 1)) * 100) >> 10);
+		/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second and kibibyte */
+		*unit = humanise_rate ? _("KiB/s") : _("KiB");
 	} else {
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 byte */
-					Q_("%u byte", "%u bytes", bytes) :
-					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
-					Q_("%u byte/s", "%u bytes/s", bytes),
-				(unsigned)bytes);
+		*value = xstrfmt("%u", (unsigned)bytes);
+		*unit = humanise_rate ?
+			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
+			       Q_("byte/s", "bytes/s", bytes) :
+			       /* TRANSLATORS: IEC 80000-13:2008 byte */
+			       Q_("byte", "bytes", bytes);
 	}
 }
 
+static void strbuf_humanise(struct strbuf *buf, off_t bytes, unsigned flags)
+{
+	char *value;
+	const char *unit;
+
+	humanise_bytes(bytes, &value, &unit, flags);
+
+	/*
+	 * TRANSLATORS: The first argument is the number string. The second
+	 * argument is the unit prefix string (i.e. "12.34 MiB/s").
+	 */
+	strbuf_addf(buf, _("%s %s"), value, unit);
+	free(value);
+}
+
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	strbuf_humanise(buf, bytes, 0);
@@ -884,7 +890,7 @@ void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 
 void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
 {
-	strbuf_humanise(buf, bytes, 1);
+	strbuf_humanise(buf, bytes, HUMANISE_RATE);
 }
 
 int printf_ln(const char *fmt, ...)
diff --git a/strbuf.h b/strbuf.h
index a580ac6084..4426163e7e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,20 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
  */
 void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
 
+enum humanise_flags {
+	/*
+	 * Use rate based unit prefixes for humanised values.
+	 */
+	HUMANISE_RATE = (1 << 0),
+};
+
+/**
+ * Converts the given byte size into a downscaled human-readable value and
+ * corresponding unit prefix as two separate strings.
+ */
+void humanise_bytes(off_t bytes, char **value, const char **unit,
+		    unsigned flags);
+
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
  * 3.50 MiB).
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 03cc5eea2c..442ad6b16f 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -603,7 +603,12 @@ int cmd__simple_ipc(int argc, const char **argv)
 		OPT_INTEGER(0, "bytecount", &cl_args.bytecount, N_("number of bytes")),
 		OPT_INTEGER(0, "batchsize", &cl_args.batchsize, N_("number of requests per thread")),
 
-		OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),
+		/*
+		 * The "byte" string here is not marked for translation and
+		 * instead relies on translation in strbuf.c:humanise_bytes() to
+		 * avoid conflict with the plural form.
+		 */
+		OPT_STRING(0, "byte", &bytevalue, "byte", N_("ballast character")),
 		OPT_STRING(0, "token", &cl_args.token, N_("token"), N_("command token to send to the server")),
 
 		OPT_END()
-- 
2.52.0.209.ge85ae279b0

