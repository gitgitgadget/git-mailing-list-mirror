Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8591B29AF
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433243; cv=none; b=uvBsFWs/njPulwiUtgwnL4S2sWsKdVZWuAJ/QrdNX8w72c/iJqJxPXtMyWm+ceUpn1DzaCb0pUNWg0QD7EIka57aug7KaZkcx2arkiv6mG3mRjESelvZK4KkJ2H6q8TaekoPScFVK7cLJ5IAar8opzFOHH2ht4NVrud2T2OxK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433243; c=relaxed/simple;
	bh=Gng4k46f2LffGGnECwQtmZwK7f3IGq4hSi1EkConw+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyDhbA+GzoB48JtUhxyGj8d0FWg/zIh6+4TtC0Ukwi2wJQM9emf2HQBOK2Wv9eeNDNFYLfxJjynW1mfT9LHlBwMuvMp+FHfIW1M/Ue11tV1P/Co7rgrLx9TL1OEJX1pm7EMjG00f1ogqnQB94Yeokr6zVn1vwTWfs3KQnT0fKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzsmii4q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzsmii4q"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so8957135a12.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722433240; x=1723038040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUtbEsMeijDKXZNMoKbWZEmXR9Kf9ouXo3brZom4o4g=;
        b=bzsmii4qn7n8HYgaH1MGuEu5iVxtiPlldEwwr0LIGLwVq1UEQcq/hgtr7NAmy170V2
         Jh5hGgzkZrmUOvrzLwC4CzrNu7O3Eq2a0wPf9Wk2uVVOwRrt5sfkgZfi3RbUXNPU9kMu
         1s+blkzZqmWSsda8ygiyZ+prMQlObNNMO7SoU90D3n2u+GlXT1aa3ofNPAK/s+alaHfp
         ntxe41MyQrhhoUQfRxOi9iEfEUHX4UW6IFBso0iL8irvM6+GQSXrPMg9w7E4jYMlm1/b
         pZV2iTmKyG/5n0iRddu7nYbmnZPyyIKVyrTD2X3jWrP0nPQndCC1HjwbQ5Aucc3Vt183
         ulKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433240; x=1723038040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUtbEsMeijDKXZNMoKbWZEmXR9Kf9ouXo3brZom4o4g=;
        b=mhcYIJP5Dooa5XzpljKZvVgMne9Y/SKEUb5l5jz46GB4WiLZpakqQSL1pqKKqUfDrg
         s1Ds3YBChEoCjF4wIYSFf4aaMnnqfY8J1wMWDV7oeS7nnTI5Tcy6tILHM2Y73rooWx3h
         mR3ngLFQnWCZoqzSMKa+/imdDx5GdfIdmCF5HnSxB5V8SUYt/QKoG/RPq95IdNt/+CZv
         WtBj0AFH9jrQ+D2myoaB2Mpg47pOxC1edcQ1SjFosxvPZmWCkAy7MnxgUahXLvr6dwie
         xmAKGUtyV4qrRz7BD3m/sQwqs5T/EDa81NGfoooq5eI33y8mp0QeLt7RCMr7kB8yxcXb
         dq6A==
X-Gm-Message-State: AOJu0YzgjnYTIjF8wEPi2/OqFh0HqZQrY021GUg0iO7SmdQJO7MQDGWg
	FmeYCUAX0eQyoM4+Zy4kSlvdo++vupNUnK0yhX1kcU7jIvw2dRIWFmsn1g==
X-Google-Smtp-Source: AGHT+IFK+sLmudskAI0LnSCxBfvKzv5VXpdvDAz+a/lqE9OghuBvzF2xxqQQfT7DUjSDUpu7XBBW3A==
X-Received: by 2002:a50:baa9:0:b0:57c:7471:a0dd with SMTP id 4fb4d7f45d1cf-5b0206ce157mr8848631a12.12.1722433239082;
        Wed, 31 Jul 2024 06:40:39 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63c50fdesm8669641a12.56.2024.07.31.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:40:37 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] strbuf: refactor strbuf_trim_trailing_ch()
Date: Wed, 31 Jul 2024 15:40:12 +0200
Message-ID: <20240731134014.2299361-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.4.gbcb884ee16
In-Reply-To: <20240731134014.2299361-1-christian.couder@gmail.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We often have to split strings at some specified terminator character.
The strbuf_split*() functions, that we can use for this purpose,
return substrings that include the terminator character, so we often
need to remove that character.

When it is a whitespace, newline or directory separator, the
terminator character can easily be removed using an existing triming
function like strbuf_rtrim(), strbuf_trim_trailing_newline() or
strbuf_trim_trailing_dir_sep(). There is no function to remove that
character when it's not one of those characters though.

Let's introduce a new strbuf_trim_trailing_ch() function that can be
used to remove any trailing character, and let's refactor existing code
that manually removed trailing characters using this new function.

We are also going to use this new function in a following commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 strbuf.c         |  7 +++++++
 strbuf.h         |  3 +++
 trace2/tr2_cfg.c | 10 ++--------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index cccfdec0e3..c986ec28f4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -134,6 +134,13 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_trim_trailing_ch(struct strbuf *sb, int c)
+{
+	while (sb->len > 0 && sb->buf[sb->len - 1] == c)
+		sb->len--;
+	sb->buf[sb->len] = '\0';
+}
+
 void strbuf_trim_trailing_newline(struct strbuf *sb)
 {
 	if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
diff --git a/strbuf.h b/strbuf.h
index 884157873e..5e389ab065 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -197,6 +197,9 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
 /* Strip trailing LF or CR/LF */
 void strbuf_trim_trailing_newline(struct strbuf *sb);
 
+/* Strip trailing character c */
+void strbuf_trim_trailing_ch(struct strbuf *sb, int c);
+
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
  * on error, 0 on success.
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index d96d908bb9..356fcd38f4 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -33,10 +33,7 @@ static int tr2_cfg_load_patterns(void)
 
 	tr2_cfg_patterns = strbuf_split_buf(envvar, strlen(envvar), ',', -1);
 	for (s = tr2_cfg_patterns; *s; s++) {
-		struct strbuf *buf = *s;
-
-		if (buf->len && buf->buf[buf->len - 1] == ',')
-			strbuf_setlen(buf, buf->len - 1);
+		strbuf_trim_trailing_ch(*s, ',');
 		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
@@ -72,10 +69,7 @@ static int tr2_load_env_vars(void)
 
 	tr2_cfg_env_vars = strbuf_split_buf(varlist, strlen(varlist), ',', -1);
 	for (s = tr2_cfg_env_vars; *s; s++) {
-		struct strbuf *buf = *s;
-
-		if (buf->len && buf->buf[buf->len - 1] == ',')
-			strbuf_setlen(buf, buf->len - 1);
+		strbuf_trim_trailing_ch(*s, ',');
 		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
-- 
2.46.0.4.gbcb884ee16

