Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713632B9B1
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012813; cv=none; b=UzRjIKDXeNfnVLHqM1eVDgQJEGQgmMXLjiI778Lq8kuZ2UpkHeC/GnkjWcRp04s/xDwqpRrHfV52Rmzo5bUFnfOXeDdjGOJDDmS9UNWGcOcREZAdkb4qQXOG/z4BwIsdjpx19HUBSYVw2etsJd+wqPGF9DR4ofB5oqZ7H2ZeIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012813; c=relaxed/simple;
	bh=MOOMtofSZHtReWecg+VRJ0yO4ARtY/5MrCLidndpp98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fviQQxp5vTnkaRluij/goztDOc1OtXfCznZRW285G5vb7t667yA2YJXONdYpo9tnxA0P4gPJfQP7UfymOl+reMfcS2AbQ7gEYgEgGO0xEQ7s/vO8K3U8RP1012HXWSuPe8VCjHoKd8/JQ3EI7SRpAaiqc4mGrmsYGGGj+tIEJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgsmBX0R; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgsmBX0R"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7e7a1b08e9dso7350b3a.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769012810; x=1769617610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9WMO0swwXTM98LTo5HxhOgnUj0dlWyajxNJefAgGMXk=;
        b=AgsmBX0RLymkE9m8SdYEB1jWdm29n798t2TAHPMEfQv25kxs9Hl98RZlq7JNhGpEqR
         b5j5E0i3p87g3lEK7nHHhhR/Bm/5S/gco0d9S55ae5SFUk4+9yHeKAsZZrY23gKqtzru
         q3Xn7Ni2zaQ1+NKJwNRvQVWwmnniOWc2lXO+ssc7f945ruw2QByaFbIkjJpB6DXtqCP9
         nq4XSlR2USELMuqCYcW+Aqz6OCmc1iIYDlgpZl7v4M5iIfsBNGldZDBZvgeQXUe5QjRJ
         Qgufr9A/IFIM0cIQf/vPVjbCTya/1jHhUBO3bS9ETK5WcIHJJyqkd99xHy7Gl5kNeAjY
         v6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012810; x=1769617610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WMO0swwXTM98LTo5HxhOgnUj0dlWyajxNJefAgGMXk=;
        b=esarQ7kfvkDM2d+NGEA2mWvMAB4JohkWqlkhY/VI94IrFmoevrxm6ht3TVkjxDKPpq
         Zxy5Y7AKLlh+H0dgsAQ2nDeREWIZ/NRV1wq19OMi3Ebv2IwZT1HZ5tTLNLUeUAQNHqpr
         kWgwvb404RIp4Ncz5A4xwEt6zl7jL5H4ePFMQ8n7AyuV447BgC4iHHNpIaT+71WJSUpB
         LMu/yanVawT/eQB0f9u0XkLhNnnSL8rzSv4OTjl9m7G6NO7FEVvi4pvhlKYGUsx1A9zh
         GQfA/VGe/x7PbeoZn9JGGf8T+EDZeTxv0qeCVBV7TabGXY/swiV5TPLGKh5iLgxY7b7v
         uFjg==
X-Gm-Message-State: AOJu0YyKf2FwK2CxYPDpSakYNMI0uhZBWEooUCThgUhMI0oLfjiFlMXx
	EppqcYn2Ulp6bRbIwTZOZXXF/2AiOT2X5e0GI8r5PmOPMVQmRSyZYJ2Y9n7gadGE
X-Gm-Gg: AZuq6aKfxuZPuDdNJYvLpNXV6nNyVcxQjAS8r5IZ82kA7zjTEVtRfQQqmDB7ObcT61k
	wZgu+iUc9HHy8S5e7VnidUcmc0Twg+QC+4SkH03cCK5STSpZyuxTpgrXk9sQuKxCtAkFnuSVkGs
	ThveqqZfPozHeJlb1ulX7jA7Wkz43Zut5ckYclfLcZZNvOGlOMSecfoy1B5IMbSst5iNXuzkRvO
	E9w1DrU85E0Z86gZxvKaWFYjxxtW0dDBNM2KjS+l+5Nd6gaj8fXMPjLkI2FInBmc1MljNudb9Cy
	cGyhTg7HA54zn9NcshLE8vp2589nhXlDSLXxDr0c9rabX9etZeLl6YBTK4RRYA0TyPPCW6+O2wp
	fw+prI4CVioV70CdAzlABZjRwvxbxrEhfBCbOqBDgTYRwMh+5GBGe9T75rDWcf4zhGRi1phI6Ku
	8F6V78QvvwqNptwmNMRRmNmfYCH7qSbkE4lrgouw==
X-Received: by 2002:a05:6a20:e293:b0:35d:8ded:c580 with SMTP id adf61e73a8af0-38dfe7c29fbmr13622994637.6.1769012810538;
        Wed, 21 Jan 2026 08:26:50 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa127875esm15625060b3a.35.2026.01.21.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:26:50 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im
Subject: [PATCH v2] symlinks: use unsigned int for flags
Date: Thu, 22 Jan 2026 00:26:40 +0800
Message-ID: <20260121162640.424126-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'flags' and 'track_flags' fields in symlinks.c are used
strictly as a collection of bits (using bitwise operators including
&, |, ~). Using a signed integer for bitmasks may lead to undefined
behavior with shift operations and logic errors if the MSB is touched.

Change these fields from 'int' to 'unsigned int' to align with C
standards and typical usage patterns.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>

---
Changes in v2:

Decouple definition of 'ret' and 'saved_errno' from 'save_flags'.
'ret' captures the return value of lstat() which can be -1, so it
must remain signed. Same applies to 'saved_errno'.

(Thanks to Patrick Steinhardt for spotting this)
---
 symlinks.c | 13 +++++++------
 symlinks.h |  4 ++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 9cc090d42c..9e01ab3bc8 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -74,11 +74,12 @@ static inline void reset_lstat_cache(struct cache_def *cache)
  */
 static int lstat_cache_matchlen(struct cache_def *cache,
 				const char *name, int len,
-				int *ret_flags, int track_flags,
+				unsigned int *ret_flags, unsigned int track_flags,
 				int prefix_len_stat_func)
 {
 	int match_len, last_slash, last_slash_dir, previous_slash;
-	int save_flags, ret, saved_errno = 0;
+	unsigned int save_flags;
+	int ret, saved_errno = 0;
 	struct stat st;
 
 	if (cache->track_flags != track_flags ||
@@ -192,10 +193,10 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 	return match_len;
 }
 
-static int lstat_cache(struct cache_def *cache, const char *name, int len,
-		       int track_flags, int prefix_len_stat_func)
+static unsigned int lstat_cache(struct cache_def *cache, const char *name, int len,
+		       unsigned int track_flags, int prefix_len_stat_func)
 {
-	int flags;
+	unsigned int flags;
 	(void)lstat_cache_matchlen(cache, name, len, &flags, track_flags,
 			prefix_len_stat_func);
 	return flags;
@@ -234,7 +235,7 @@ int check_leading_path(const char *name, int len, int warn_on_lstat_err)
 static int threaded_check_leading_path(struct cache_def *cache, const char *name,
 				       int len, int warn_on_lstat_err)
 {
-	int flags;
+	unsigned int flags;
 	int match_len = lstat_cache_matchlen(cache, name, len, &flags,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
 	int saved_errno = errno;
diff --git a/symlinks.h b/symlinks.h
index 7ae3d5b856..25bf04f54f 100644
--- a/symlinks.h
+++ b/symlinks.h
@@ -5,8 +5,8 @@
 
 struct cache_def {
 	struct strbuf path;
-	int flags;
-	int track_flags;
+	unsigned int flags;
+	unsigned int track_flags;
 	int prefix_len_stat_func;
 };
 #define CACHE_DEF_INIT { \
-- 
2.43.0

