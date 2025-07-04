Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAA2F2C74
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627700; cv=none; b=iIG8JyH5VuqQjUVrmoyWaOx3i29UAqX5rs7X+6wmugMFu5Pgs27/sBZ0BQ26Abuzs24uiQRtSupHpyDhXKbiwBHGVESiKoAXsWiuV3o5zGTZFOTSdCYTKI3BIn3/omO8IUJ3lVYcKpivPNlR9EO5v1Gm2a8PsD2mmQvbuyw7FtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627700; c=relaxed/simple;
	bh=EBfLaQ7JI1iEz/6R7yhMlhSjpaqaOBEC5+/xYwuyE28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=susFuBzva8tTn3iPQZ73dSmwEqY42PMzi1cFVDRv1OmUjXErQxfXziL1d4VcLPk9+7ysyT+tnu+vunZRyq7VPD5B6eoiCxaKS1syLbH19PxMCPy8qyGX4rbqKVaCIFWpHM49aU/zWM24h4NnOVfIXvU2j/os8pY3rze7jfjsFAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij40Nd8s; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij40Nd8s"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so1632903a91.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751627698; x=1752232498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/y4gkL0GxDcfyyvpy4xqQkOADtHXn5YhBXo/vK0K6PY=;
        b=ij40Nd8s+vVWTVzxhlXh+FClSlXRkZ2ucPO6sl3W3fAoujKCzOtDN7BwWoC2z4Kyga
         t2TUIwZtNmgW23Agz+9auVMmmd1fpIvHlV+Lx6r5g9UTbeaywL+UAbtWDqLfBSwJ7kny
         AW4UUlE0NtumHCObL3cHycwWonL9STwy7QoCY1ddQfymyXi2sYTNQkpPfrtYRnMNsxen
         kDkPpButnaRfMeMYZGicsUZRXLsAPscF+rYVwuKhhDilkc+5Qiy+dg+RKXcSWh+H/NzK
         MZeuKuvpm/jAb9dbA5t9+vHZvra/6g4ttp/EFB94aiEa8iRQLX5p8MbkPSX8yZ0FA3ej
         3ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751627698; x=1752232498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/y4gkL0GxDcfyyvpy4xqQkOADtHXn5YhBXo/vK0K6PY=;
        b=g9nr22EZPTDDEWxc89mnZpcPaHOli598kVBAyDy9pOpqIEvZl4mPi6uJJ44Mn5E+HA
         2hBrgmciQ3QXxquH/IufYJlcFelRHUoamzqFmy2r0WoAGvKswKmT3+imvEpr3Ym15l3U
         3SydQKXgpK/Szsf61cz8OXzE0tOgBnz0Xv4iRjmFQoVnQf6mJNMddNzExsWtA0uZ1TyH
         pfDsjAz+f2Uz7h0wC5ewG2P+3x64dDNQRnY17RrWZr7ltZi1YY4KH6j17GgUq/7f+yQT
         xPUV4LIGIZ7gGfAExKLtgTL5IFf2SQHdffSrfb52pdmgbBlSEI+TdpIuu+E8V/nk99Zj
         lifA==
X-Forwarded-Encrypted: i=1; AJvYcCV5sH6zh+1H+uhYOD6rS+m0QEPbFSrUzvXARIlDYzb9OMLJNDAISC5FB/VStHDaBBkPVyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwOBKUcdz28K62ybxdq91w6w/xzlzca0Ur/YzHL8HRDf/SsiWq
	hOcTlzrj++WbOIkyFBz7PyzZ1Ver0WIFMU+LOdOKmwpyAsas2rhC0CLl
X-Gm-Gg: ASbGncttT7yBvGtg37J1Cxc3iZhvhbtCDfP4l6a3X11jzPZ1WWx3SexcOYPCiG1D2bU
	pNt9uZ9kkZ9lI4wy4ECA2gR3n3oX6za4EZ1/MltR4FIlCvYoruA4AxqmyOPIgmCN5Jbq4zyZtSB
	OAB7FDk6oQ4q671IgHQ2+0X/VmKQNbN2xE+ammHhEqG28hGfYUAVrcwRW3PltzaN1uDYVSoEdr1
	lgv8zol0dcI7z5QcfVFgJWZPKhxJMJShngNVprulmm72KiMeLyTKRp6VeXnNzMAyC8ZoE6lQ0sW
	ZsVR78Dzj3ETnu5623JnnyuKlD4hsPH29p0aDhm5/coz5K6XYi928CquSSk4nng/nEd/
X-Google-Smtp-Source: AGHT+IFqQthobLSMHOsCzcXo7rbs5kUP7IG5UkVNnP8kmlTpRG6caCSQZKrhakPcMpqvGOXxhS9Nbg==
X-Received: by 2002:a17:90b:4b82:b0:2fa:562c:c1cf with SMTP id 98e67ed59e1d1-31aaaf73033mr3776711a91.1.1751627698000;
        Fri, 04 Jul 2025 04:14:58 -0700 (PDT)
Received: from r760 ([188.253.126.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9ccf8881sm4720522a91.29.2025.07.04.04.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 04:14:57 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v4 2/4] bloom: rename function operates on bloom_key
Date: Fri,  4 Jul 2025 19:14:35 +0800
Message-ID: <20250704111437.2660251-3-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.107.g33b6ec8c79
In-Reply-To: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git code style requires that functions operating on a struct S
should be named in the form S_verb. However, the functions operating
on struct bloom_key do not follow this convention. Therefore,
fill_bloom_key() and clear_bloom_key() are renamed to bloom_key_fill()
and bloom_key_clear(), respectively.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 blame.c               | 2 +-
 bloom.c               | 8 ++++----
 bloom.h               | 4 ++--
 line-log.c            | 4 ++--
 revision.c            | 6 +++---
 t/helper/test-bloom.c | 4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/blame.c b/blame.c
index 57daa45e89..459043a511 100644
--- a/blame.c
+++ b/blame.c
@@ -1310,7 +1310,7 @@ static void add_bloom_key(struct blame_bloom_data *bd,
 	}
 
 	bd->keys[bd->nr] = xmalloc(sizeof(struct bloom_key));
-	fill_bloom_key(path, strlen(path), bd->keys[bd->nr], bd->settings);
+	bloom_key_fill(path, strlen(path), bd->keys[bd->nr], bd->settings);
 	bd->nr++;
 }
 
diff --git a/bloom.c b/bloom.c
index 946c5e8c98..35ff36c31c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -221,7 +221,7 @@ static uint32_t murmur3_seeded_v1(uint32_t seed, const char *data, size_t len)
 	return seed;
 }
 
-void fill_bloom_key(const char *data,
+void bloom_key_fill(const char *data,
 		    size_t len,
 		    struct bloom_key *key,
 		    const struct bloom_filter_settings *settings)
@@ -243,7 +243,7 @@ void fill_bloom_key(const char *data,
 		key->hashes[i] = hash0 + i * hash1;
 }
 
-void clear_bloom_key(struct bloom_key *key)
+void bloom_key_clear(struct bloom_key *key)
 {
 	FREE_AND_NULL(key->hashes);
 }
@@ -500,9 +500,9 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
-			fill_bloom_key(e->path, strlen(e->path), &key, settings);
+			bloom_key_fill(e->path, strlen(e->path), &key, settings);
 			add_key_to_filter(&key, filter, settings);
-			clear_bloom_key(&key);
+			bloom_key_clear(&key);
 		}
 
 	cleanup:
diff --git a/bloom.h b/bloom.h
index a9ded1822f..edf14fef3e 100644
--- a/bloom.h
+++ b/bloom.h
@@ -78,11 +78,11 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 				 struct bloom_filter *filter,
 				 uint32_t graph_pos);
 
-void fill_bloom_key(const char *data,
+void bloom_key_fill(const char *data,
 		    size_t len,
 		    struct bloom_key *key,
 		    const struct bloom_filter_settings *settings);
-void clear_bloom_key(struct bloom_key *key);
+void bloom_key_clear(struct bloom_key *key);
 
 void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
diff --git a/line-log.c b/line-log.c
index 628e3fe3ae..a2aaf869a3 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1172,12 +1172,12 @@ static int bloom_filter_check(struct rev_info *rev,
 		return 0;
 
 	while (!result && range) {
-		fill_bloom_key(range->path, strlen(range->path), &key, rev->bloom_filter_settings);
+		bloom_key_fill(range->path, strlen(range->path), &key, rev->bloom_filter_settings);
 
 		if (bloom_filter_contains(filter, &key, rev->bloom_filter_settings))
 			result = 1;
 
-		clear_bloom_key(&key);
+		bloom_key_clear(&key);
 		range = range->next;
 	}
 
diff --git a/revision.c b/revision.c
index afee111196..49fc650ac7 100644
--- a/revision.c
+++ b/revision.c
@@ -739,14 +739,14 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	revs->bloom_keys_nr = path_component_nr;
 	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
 
-	fill_bloom_key(path, len, &revs->bloom_keys[0],
+	bloom_key_fill(path, len, &revs->bloom_keys[0],
 		       revs->bloom_filter_settings);
 	path_component_nr = 1;
 
 	p = path + len - 1;
 	while (p > path) {
 		if (*p == '/')
-			fill_bloom_key(path, p - path,
+			bloom_key_fill(path, p - path,
 				       &revs->bloom_keys[path_component_nr++],
 				       revs->bloom_filter_settings);
 		p--;
@@ -3231,7 +3231,7 @@ void release_revisions(struct rev_info *revs)
 	oidset_clear(&revs->missing_commits);
 
 	for (int i = 0; i < revs->bloom_keys_nr; i++)
-		clear_bloom_key(&revs->bloom_keys[i]);
+		bloom_key_clear(&revs->bloom_keys[i]);
 	FREE_AND_NULL(revs->bloom_keys);
 	revs->bloom_keys_nr = 0;
 }
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 6a24b6e0a6..585a107802 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -12,13 +12,13 @@ static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
 		struct bloom_key key;
 
-		fill_bloom_key(data, strlen(data), &key, &settings);
+		bloom_key_fill(data, strlen(data), &key, &settings);
 		printf("Hashes:");
 		for (size_t i = 0; i < settings.num_hashes; i++)
 			printf("0x%08x|", key.hashes[i]);
 		printf("\n");
 		add_key_to_filter(&key, filter, &settings);
-		clear_bloom_key(&key);
+		bloom_key_clear(&key);
 }
 
 static void print_bloom_filter(struct bloom_filter *filter) {
-- 
2.50.0.107.g33b6ec8c79

