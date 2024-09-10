Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294813A3E8
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985823; cv=none; b=sPvCWdlLyxjjeU5xdd3vG2KTaZDQsXo6Z/QWEQFqW7mh94zW+n/GL4+jog3yuM3IyNFCC4FnVRvByBPGoPYFB9Bxi28SOR3ggqvQ8odGsQg46401fwmKmh8N/3MfrhvUv5rE6t+yiddTO7XkQdxgDQEclMRQd5paxTneMEAp5BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985823; c=relaxed/simple;
	bh=1aT+nypFKeLY7fDpJL2rbrVDdpgmlb2TJQV3M4VGMWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je3FfHXh9+LtE9WqpGtql5QcZ6wIzDxU6vUagBvpTQW4S4FcK98bfdZOFe0+MDw9I+LvSLDNOL9hwivAgVyIDR9W8JfTxQXz89puMKHNWA2nLtkZX2gUNEfw3Ed7ArIZ/t6X2b/Wn+7lmlsicFowOI8QLVCsSOf6GD86Tc/GtI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb805f75; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb805f75"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so44418685e9.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725985819; x=1726590619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPnrOVcHCY6sFsCUjNfr/0qW1N6Jb5gzzCZUNqi5TaU=;
        b=bb805f758H5JRN9QOtxC0o01wMXYDYNI+1l/PAqtJr0CzQz/Uhvw9Hw1Dy8DMbc3oF
         55gqgqbN/+fXvEQmUWF5aQErhwITdgWQ5cB2mgrSBdQX8Dsfljx3sTAvP4+HqmzdoQA5
         PtT3v1BJT8BOJAaDA9xbrWBx2YVZZ1w7llSmaw5679ricN2RDf7cPz0a+Qe1/+LZm8vE
         8tlImnmOo38c0KW4BskLdrQ5CdfpEEvOGshW0doYGvi5dj4745l5zShunwqqkbgSXpuu
         bIsgG96niD+0c+bZGfZ6+lKszYQYIYRNniBUFrwsLdV14QxkPPoVFH28vLTsOG3s92kG
         okFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985819; x=1726590619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPnrOVcHCY6sFsCUjNfr/0qW1N6Jb5gzzCZUNqi5TaU=;
        b=d2EHW/xUvJI3CZTl/lbSiWhb2NHs4jBHP4/wd8XdmhrwAtfSy3joWcz2M7ZuEs0qRe
         slDOpeW1eZUpykkjfFwNKbc7qnMzOCjQkAWh1sEGrUYu9qttu23v5gFxtHcyrWPZt2T9
         n20cs4pTvxVpTSIAWi9izYMEfQbxSjCcCZCfw12ThkWCAdVvdnMS8fl9pl9DeLj4gOK+
         /cfgZNhLTzTW0v+iDRLzR1RoPMP4jw76QqH/38FKQgTNqs40YsxITTsU7t87knxdoCSx
         OfNVMs38OYQY70NoKXvTwpOP4JulGHzAo4j9Xa7OT3EVEBf0ePRJkO/0/Zhxuaoqhilf
         AXHA==
X-Gm-Message-State: AOJu0Yz8grfx/aVsJFuvnc1AGOqP4bFs5e8glcg/ZWpVDWjq66XhMpIw
	QuGdfLjq/waoti0SsTI9n0Aes2FwuTF4vTn4Ohh/wl9uXFYLjPm7rVVbzQ==
X-Google-Smtp-Source: AGHT+IFl517/0avT8b0Q+JTLaRJp8Si7e6VgRO49M1a7Z8s5t6y0lFBnTS4VxyXx6tlbwbM87npywQ==
X-Received: by 2002:adf:cd0b:0:b0:374:be8e:7325 with SMTP id ffacd0b85a97d-3789272c93bmr8199729f8f.51.1725985818697;
        Tue, 10 Sep 2024 09:30:18 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm29897865e9.0.2024.09.10.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:30:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/4] version: refactor strbuf_sanitize()
Date: Tue, 10 Sep 2024 18:29:57 +0200
Message-ID: <20240910163000.1985723-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.g7a37e584ed
In-Reply-To: <20240910163000.1985723-1-christian.couder@gmail.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git_user_agent_sanitized() function performs some sanitizing to
avoid special characters being sent over the line and possibly messing
up with the protocol or with the parsing on the other side.

Let's extract this sanitizing into a new strbuf_sanitize() function, as
we will want to reuse it in a following patch, and let's put it into
strbuf.{c,h}.

While at it, let's also make a few small improvements:
  - use 'size_t' for 'i' instead of 'int',
  - move the declaration of 'i' inside the 'for ( ... )',
  - use strbuf_detach() to explicitly detach the string contained by
    the 'sb' strbuf.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 strbuf.c  | 9 +++++++++
 strbuf.h  | 7 +++++++
 version.c | 9 ++-------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 3d2189a7f6..cccfdec0e3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1082,3 +1082,12 @@ void strbuf_strip_file_from_path(struct strbuf *sb)
 	char *path_sep = find_last_dir_sep(sb->buf);
 	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
 }
+
+void strbuf_sanitize(struct strbuf *sb)
+{
+	strbuf_trim(sb);
+	for (size_t i = 0; i < sb->len; i++) {
+		if (sb->buf[i] <= 32 || sb->buf[i] >= 127)
+			sb->buf[i] = '.';
+	}
+}
diff --git a/strbuf.h b/strbuf.h
index 003f880ff7..884157873e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -664,6 +664,13 @@ typedef int (*char_predicate)(char ch);
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
 			     char_predicate allow_unencoded_fn);
 
+/*
+ * Trim and replace each character with ascii code below 32 or above
+ * 127 (included) using a dot '.' character. Useful for sending
+ * capabilities.
+ */
+void strbuf_sanitize(struct strbuf *sb);
+
 __attribute__((format (printf,1,2)))
 int printf_ln(const char *fmt, ...);
 __attribute__((format (printf,2,3)))
diff --git a/version.c b/version.c
index 41b718c29e..951e6dca74 100644
--- a/version.c
+++ b/version.c
@@ -24,15 +24,10 @@ const char *git_user_agent_sanitized(void)
 
 	if (!agent) {
 		struct strbuf buf = STRBUF_INIT;
-		int i;
 
 		strbuf_addstr(&buf, git_user_agent());
-		strbuf_trim(&buf);
-		for (i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
-				buf.buf[i] = '.';
-		}
-		agent = buf.buf;
+		strbuf_sanitize(&buf);
+		agent = strbuf_detach(&buf, NULL);
 	}
 
 	return agent;
-- 
2.46.0.4.g7a37e584ed

