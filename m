Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26F2D839B
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579014; cv=none; b=iIePzqJeEV63oro7EKBQ7s0JwCvoeGWnjRuReRoqTPxLtlms5MoH+bgfoMrkokeJmgKwA/BBVVwhwMTskpZTZvrbsA7ROuzwbND+MjRwxdoNwmniHfL//uMu0xeUlVbzmuuHu92XA3nIbKJB6SEDrnQ6zrBE4OgyNQLMW8aDoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579014; c=relaxed/simple;
	bh=WdJl0vEIrh0z24PlxVbFdHxQkkjGpRuMqHeyApl5+W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc0HLa3eKdNz8OdBZCZzKXD93TzSZvmhtuh9EdcjSP90O4oBykk8dbmlnW7UJ9vv5bGF53nYlomjGO66PiL+i3cqZGu74PHum5Z0lCaUYDy72tZRA9RaI58hoPiQOfKtcVj1x3Hwq+sh9idzcbtic4FMdBk+7FdeBfMFqVsqsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrJv/nd+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrJv/nd+"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c75387bb27so700067a34.1
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579010; x=1766183810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ntno4dkgu7bH98l+kfTVuwXHWJFU1+VuG/a2CezgBYQ=;
        b=jrJv/nd+Ysh2Mq4fMdKRL4hgmkANxeDcIviWLHn5hLAb+xALDRzp0pLLCYMXm9lFxG
         k5OY/VvBss4zqciQ87IS/wVMW+ZyXxNR3gDN+x5HUxI8Aq+Yo4Ajcv922VrQcrUz5d7l
         pl2VEAgcO3SSjKPphpxGtaGxqQ3uso1lTMe0WF/YjpPXP0r2NfIK3aL6GyHGly7unUfN
         XrUMDZzc6JeOclXRdZk/bCMlHLYykcjhCfMfRpXow7aeZEs6I0JD7WHwSRxidHtCfWAK
         1ULtyj+5gSGDviK8LH+SXK4hiFUmzV0IGGdjtAHQUyG5R6irFaZfs3qUAaZSct7PT/Of
         MkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579010; x=1766183810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ntno4dkgu7bH98l+kfTVuwXHWJFU1+VuG/a2CezgBYQ=;
        b=HJMWDV5MeILgyOG54nHci2df1vRa8lRhfE5yfcVJRh+VK0FvEpjfdifAFq1eN1q6/9
         yadpGvTTAfkvkeY15SWtCUTNBg5OjSZCD+NMcVjBKj4e8edlsdMD2cx4acIjArqWt62J
         Ze+H3lKWQpPH/nkglQqCWhDxpWugCFkqcwmZs7TDhabau0trc6VbeO/B15064Nm+rVwc
         yRcF812putFwvTsvtewa1yyXqaBAEjRncCXos9t7RV5ApXYmsb6fpklbiaLRLRqPIX0C
         PE9OFzlfZmXOVtw/9wU7qz8dMg+j61Zf5KW/mQqk8n7G65NvdgOm907mW7X7VEftuGdk
         G82w==
X-Gm-Message-State: AOJu0YyZMyNp8m+DaBeiVT+nIcFA4bQst8V9N+s9GytMOr7L57BdVbpE
	oU0GgjJTj1NNofVpNp6p1PmmDuso8LDONqxe20l5RdzqcMS77V57s5LKu5PoFA==
X-Gm-Gg: AY/fxX7DGA7j12B2S3yrlXaa1knKjjaDwgvSyL+PaHmNXOo1MrIQHkEptIPp63bV2Ly
	sJZjKQxCGa7cAi9G/8JpYPod+uYn39B/wfP5nvvKlbTVlQVuogrHuzmiVc0/jcAyXH6S22+kFP2
	8E2Q49aaJmECYk0yaKqwFjABhc5JpnQbtSnlPN0T0m93WAlnA+RePTPXb43/iuZ37tKTTJ5gdG/
	C5anencWzYdL8Vz8MvTtMldxUAIKWu7L5amZ5pvyNy6Sleqq0T6SsGZ4ghiEVLhdvym671E14A8
	vMwZdcEeoqTqTXfn3HZBtv1m3jKfRjmwyHxA///4X2RaAEAZ3xVsDLGB6poUmReGbrQhbRvQGLQ
	wk5kERwogO47yCAEk5t4f0Cl0pmQ67pXUh0TZm/MabmYR5rRyNpmScnlfYilxfH0PVqLOp9CtXx
	vorkHj1A0TKXBvU9lLtHw=
X-Google-Smtp-Source: AGHT+IGiJSM6uehM/6N5RJgz4a4SK3Lrt3cW9ooiBHks8n+qIzXYDoSXI830TV7pXB3OoM6SBhTnAw==
X-Received: by 2002:a05:6820:8ca:b0:659:9a49:9092 with SMTP id 006d021491bc7-65b450e91afmr1709881eaf.17.1765579009897;
        Fri, 12 Dec 2025 14:36:49 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm173998fac.10.2025.12.12.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:49 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
Date: Fri, 12 Dec 2025 16:36:39 -0600
Message-ID: <20251212223644.3090879-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251212223644.3090879-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
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
separately to ensure proper column alignment. Refactor strbuf_humanise()
to instead append the downscaled byte value to the buffer only and
return the appropriate unit prefix string.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 strbuf.c | 62 +++++++++++++++++++++++++-------------------------------
 strbuf.h |  9 ++++++++
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 6c3851a7f8..1fb47bf21b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -836,55 +836,49 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
-static void strbuf_humanise(struct strbuf *buf, off_t bytes,
-				 int humanise_rate)
+char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
 {
+	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
+
 	if (bytes > 1 << 30) {
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 gibibyte */
-					_("%u.%2.2u GiB") :
-					/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
-					_("%u.%2.2u GiB/s"),
-			    (unsigned)(bytes >> 30),
+		strbuf_addf(buf, "%u.%2.2u", (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
+		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second and gibibyte */
+		return humanise_rate ? xstrfmt(_("GiB/s")) : xstrfmt(_("GiB"));
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
+		strbuf_addf(buf, "%u.%2.2u", x >> 20,
+			    ((x & ((1 << 20) - 1)) * 100) >> 20);
+		/* TRANSLATORS: IEC 80000-13:2008 mebibyte/second and mebibyte */
+		return humanise_rate ? xstrfmt(_("MiB/s")) : xstrfmt(_("MiB"));
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
+		strbuf_addf(buf, "%u.%2.2u", x >> 10,
+			    ((x & ((1 << 10) - 1)) * 100) >> 10);
+		/* TRANSLATORS: IEC 80000-13:2008 kibibyte/second and kibibyte */
+		return humanise_rate ? xstrfmt(_("KiB/s")) : xstrfmt(_("KiB"));
 	} else {
-		strbuf_addf(buf,
-				humanise_rate == 0 ?
-					/* TRANSLATORS: IEC 80000-13:2008 byte */
-					Q_("%u byte", "%u bytes", bytes) :
-					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
-					Q_("%u byte/s", "%u bytes/s", bytes),
-				(unsigned)bytes);
+		strbuf_addf(buf, "%u", (unsigned)bytes);
+		return humanise_rate ?
+			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
+			       xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
+			       /* TRANSLATORS: IEC 80000-13:2008 byte */
+			       xstrfmt(Q_("byte", "bytes", bytes));
 	}
 }
 
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
-	strbuf_humanise(buf, bytes, 0);
+	char *unit = strbuf_humanise_bytes_value(buf, bytes, 0);
+	strbuf_addf(buf, " %s", unit);
+	free(unit);
 }
 
 void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
 {
-	strbuf_humanise(buf, bytes, 1);
+	char *unit = strbuf_humanise_bytes_value(buf, bytes, STRBUF_HUMANISE_RATE);
+	strbuf_addf(buf, " %s", unit);
+	free(unit);
 }
 
 int printf_ln(const char *fmt, ...)
diff --git a/strbuf.h b/strbuf.h
index a580ac6084..a5e3ab0cb4 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,6 +367,15 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
  */
 void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
 
+#define STRBUF_HUMANISE_RATE 1 << 0
+
+/**
+ * Append the given byte size as a human-readable string that is downscaled by
+ * some factor. A string with the corresponding unit prefix is returned
+ * separately.
+ */
+char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags);
+
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
  * 3.50 MiB).
-- 
2.52.0.209.ge85ae279b0

