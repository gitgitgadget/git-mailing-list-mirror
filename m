Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF342EEAE
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922557; cv=none; b=SpzBZTNQPjCMMGqIRaW+ri6+AtbDkdf98ZnFthQMK4i1FIa57aZw/U+BxAv4m58kkuojIVwWllJKtCOEU5rVhQRG1eijw6IUQTx5ZhyuWsmmqwbfSYIXbz0SX4vU1tmmTyBT+UrJARy7McOFP/MXJZB70KOblQL5Kz4O7aLW2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922557; c=relaxed/simple;
	bh=2ZcRvi4Kg/fgkIQO7fgt94AzXwVSTcmnXAWPzvccsUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfT+uTPOOjkl++u+osPbh3m68bEo3ABmEQ/Lf3rkVmaajspDJcn2o3WhfWURMtflWN+OrzIzVp/Loe58EK1h0SQ8czGBB5eUncrg5L2q4MAnrbGmh2hcdaxIBM5DwBUO4FbXPvzsBcZuHPOL/q8rIbIFJvY8Kp48DDI5fVEcjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9NIGN/R; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9NIGN/R"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c03ea3b9603so223663a12.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768922555; x=1769527355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+dt8l3Jrqo1sDkvnXF1QjGeY9gNJNbS6kx9t4gydis=;
        b=G9NIGN/R4I8UQFmuDODL6i4u+uty7GmDhtgW3Z1/evLcIb4iZMfg5zzArgiGuzAciz
         NCqt15ao8YJ9dpGJrye0C1RiA/KztVHegXaih1+w+dNcj006hyCyLmZLzN3qFXeMREzI
         EDQmo9MBAHb+q9zTPwjGwEeo9ki0BKJunViNZhHu3nF4WwNotYOHEtX77vPG/srXa8QP
         LVGp9eH4kHnzHPBfTZPcKTB2gOrh+EGlsQr0r0TfFdgau6oNsMe4DlRTeqXqooUXDeGG
         rYGDRit1DTWJAv5ge+qSiAvXyjIgBnWWrweiHC3pjYD9B/NhI51pl2O5OeQ9NWJktIso
         e3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768922555; x=1769527355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+dt8l3Jrqo1sDkvnXF1QjGeY9gNJNbS6kx9t4gydis=;
        b=uCSuySIAWstAIJv550lnVyJhZEWpWqYHN/eYVcdEazrbkZNicrMphT1AtRRFTBbbAQ
         0j4he4RnJyBzfZZDUvjStVqIJ3s2S9QMLlx2+0T5ObdYlnoe78ma5gVz1uPqtHWhAs2j
         coHi7HvgA8g5U21hDICN1oYuYYoLOysMO3c9cudh1TyUr8GZM5lI+q/TCeeFz4TtDWg2
         joBa3j4dv66CYYA7s5/i4Kq9LfB0suO5ChMQg5kRxg4URLsR9x6XDEGgWPq3Tv3QeAbY
         p0ro8U5p3kXnO7hLe19lMwGIOm5VGG9pmof9uX3iXrXVpF87l/NHfTnoHjSq5YbTnU8C
         d3ug==
X-Gm-Message-State: AOJu0YxndJx/9sm7zJEpq8j28aR5GR/07lDdyNQTHQoKbPRmYSF4j3Pf
	VXQ0QK2nEKp8cedcVSgg7BYKP+mVo14CoZ6kOn9OkO+Mel6Z8BXduWmO//jNRXFKBfU=
X-Gm-Gg: AY/fxX50a26jc8/rD4E9meeN4xZRI/sbhKohyTQla5ikGei28B/hm6dUYFpp2ll3rV8
	jrj7dOePpsq/obd14pDc2RFe2ztRhZcTnsUjQhbH099k4J25xQhv/3SCYX371y8aLzqArHKZBoP
	Y8YK4dOLkVh9qiWF0BYHeJNkKOXSrRZsTxm0ufkB/lBDOMO09vQD0ZcZlOyBGl2TUjauUoyf99e
	+qNF2/5tzhxfPVxHcSdirpohYqiinhG4A188iPARH84hot5NndfOdT2ytU7mZLhhp8M5opacBlr
	yYbuStmEOO2nqs77PoqFu3VWK/h+AGKsUTJZGtYXVszksrDH5zjYotR33+dTjRYaZ4ebUR9jDpg
	alEvUDTVSwhf91yOriJpnAzQMQ8YLKTJWwpLH6VadlmuhBhyqk6G2EEZbVzuQY7b/sY65WuuHnO
	DzXzyIpORVA0Yw6RVJXYOZcHR5X48=
X-Received: by 2002:a05:6a20:6a0b:b0:342:1aab:4c79 with SMTP id adf61e73a8af0-38e40f66c8emr2326759637.3.1768922555059;
        Tue, 20 Jan 2026 07:22:35 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d175sm12146200a12.23.2026.01.20.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:22:34 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v1][RFC] symlinks: use unsigned int for flags
Date: Tue, 20 Jan 2026 23:22:19 +0800
Message-ID: <20260120152219.398999-1-a3205153416@gmail.com>
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
 symlinks.c | 12 ++++++------
 symlinks.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 9cc090d42c..ed63891149 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -74,11 +74,11 @@ static inline void reset_lstat_cache(struct cache_def *cache)
  */
 static int lstat_cache_matchlen(struct cache_def *cache,
 				const char *name, int len,
-				int *ret_flags, int track_flags,
+				unsigned int *ret_flags, unsigned int track_flags,
 				int prefix_len_stat_func)
 {
 	int match_len, last_slash, last_slash_dir, previous_slash;
-	int save_flags, ret, saved_errno = 0;
+	unsigned int save_flags, ret, saved_errno = 0;
 	struct stat st;
 
 	if (cache->track_flags != track_flags ||
@@ -192,10 +192,10 @@ static int lstat_cache_matchlen(struct cache_def *cache,
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
@@ -234,7 +234,7 @@ int check_leading_path(const char *name, int len, int warn_on_lstat_err)
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

