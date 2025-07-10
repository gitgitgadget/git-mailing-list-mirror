Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D7156F4A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137333; cv=none; b=SWfjvvJ5EvY7F4ibR+AlXJOKl1+FrkoBkg8xzIL4zozKkH1ZskSRnyh7RRsQ0tiRgybxUsp9kvlOGSurYQbqIu999gSPWCwKzfFyy0p3WzQU9glABJByAzW+Z+jah6WXx+WHMPna8ZXlEQBstTLjGlir1oeY5v5z0bi1IZHcLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137333; c=relaxed/simple;
	bh=J2Ny7u+5RaSblFhsSESymvhK/gAdZVYXrpZszn2lFnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO/p8HNVjBeW5xtQIzjhiHksWKkH3tAl7lFpnF3M4rkoKdt1osxzUWWTspOzvCbZCLKJ/DjLbyVmvNkaf7+jiAN3ds85XsQd3j3OlzSqGpGZl5ftlLPKKms2SRhxjHerYqhYYdY7prXo71zMkakaCYX37k1LkRrWWz+JRhx155o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHvcmpAJ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHvcmpAJ"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso684807b3a.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137331; x=1752742131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLwxjvwaH2nPuLLBlxGjEEvl3dCaseeftdv7VjZZoQw=;
        b=YHvcmpAJ2m08AovhP75Txj51atxdOtHyNcmW1rvcGaY9rgQX+XO6R5OJ46ylRSjVDa
         dpREOMCcBQdZ3hg6gRbUANeGlwBgT5TJlegbGyuXtBesQgKROWosoYemMh6e3+7DDh0/
         ATWQWgpdsRLWx6knvrimUU0KMAdsh2e2B4XWK1TwRJCVgaqBrmUuNEIEgRpRycSFEd2V
         qk6MlS1LmsAZB5iSmzAie5iXSKBikF0iXWomzw7RPqwRFc3mTwq9Mr93RUq+gLVzeaf9
         1YaVgkGOen3s2KXEIAfe8Vd9l1S8QHFYZ8R7Ew45yA3Qy74Uvdr0xYr8Fz10yP1ZZk8p
         xYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137331; x=1752742131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLwxjvwaH2nPuLLBlxGjEEvl3dCaseeftdv7VjZZoQw=;
        b=YC+Bfv3oZKlLQlNNGlRAANIuUw0orw9eVxjmFnVt1J5vW3kRn4YKCPSWTOEcOh4L6i
         C3zerEvpbDh9qRp7mX4yEZq0XlsymKIv3vhSH+vRGtUUIAgrpHPIlBNMg3oLV2wTnk8o
         mE/k1sHCKHNsOvUeLy/huUIFil0P7w5n+ztW/OY2ClUj2oa/KlJCZlxxnDO2bFFCzvls
         54GpzdxSI+AQOOXn7z7M9Afq2DJVrWDFlrgxtvwd3eZU76NmH2mqaX1zmfX43MZOIAe3
         OLVorMxLUyQ9tDJRGEwIqBe6GvtQWyWkkS9VyG751R/N0lGZH3YECyQZfSYGi2SF2Fys
         h+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWLuF2YzF7F1TYBIKPdy+qx+5mfOhWe1cn0hd+QPlJuVqCtM0JUMEj4uXUPZaCdU7tOuhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMe/oRGovWWdLEGnOhY3Rqe0h/HzqhuZ6koILjic74XRsVDio
	p08ldbCH5xwfCjRWvPXi9dJw0jspUG6xA8pb525N0WwbvDxwMT1YQr5m
X-Gm-Gg: ASbGncvickvR5vgbUIUV1omUs2NGkBzKmFGcrxUVb/XAij3idStLpqUAI75byvI0yEB
	L9Q/wYdMdbVvaubrtp0Xpxbw1CdQgslN5+vL1tsP2+VwgEc0GnlNz7MvQKuWfSksnUJiCza7pF/
	Mx4A/knVWhFS7EDN1vO2WSVzKWXWGqLztryAvoXEayqoTIeIv5P3PcAhjkND/4ad9+MJ+xapm/U
	LMEv3gsBjrjyXTOTksOW//bxfJJ1VBIXjABgkU4zJBDuHHTESFKPjgElaNn8HjgsXzyIfDrTbN4
	n2hUJzxaJquChVkxPAZcAZvIqtpJMs8mySjYE7YqxsFQwRZOuzFCelqHifIUgZ5jcahr
X-Google-Smtp-Source: AGHT+IFmWn9ZQZ+Qbi5uNszrRvux2nPRVmuBIXBHCFHN+JJd8uF/iEYYv5rZeHM3EhpyN16zZrghUg==
X-Received: by 2002:a05:6a00:138c:b0:742:a0cf:7753 with SMTP id d2e1a72fcca58-74eb8e8a787mr3210626b3a.3.1752137331165;
        Thu, 10 Jul 2025 01:48:51 -0700 (PDT)
Received: from r760 ([188.253.126.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f22d93sm1535777b3a.89.2025.07.10.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:48:50 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com
Subject: [PATCH v5 2/4] bloom: rename function operates on bloom_key
Date: Thu, 10 Jul 2025 16:48:27 +0800
Message-ID: <20250710084829.2171855-3-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.110.g198a7da17c
In-Reply-To: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
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
 blame.c               |  2 +-
 bloom.c               | 10 ++++------
 bloom.h               |  6 ++----
 line-log.c            |  5 +++--
 revision.c            |  8 ++++----
 t/helper/test-bloom.c |  4 ++--
 6 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/blame.c b/blame.c
index 57daa45e89..811c6d8f9f 100644
--- a/blame.c
+++ b/blame.c
@@ -1310,7 +1310,7 @@ static void add_bloom_key(struct blame_bloom_data *bd,
 	}
 
 	bd->keys[bd->nr] = xmalloc(sizeof(struct bloom_key));
-	fill_bloom_key(path, strlen(path), bd->keys[bd->nr], bd->settings);
+	bloom_key_fill(bd->keys[bd->nr], path, strlen(path), bd->settings);
 	bd->nr++;
 }
 
diff --git a/bloom.c b/bloom.c
index 946c5e8c98..5523d198c8 100644
--- a/bloom.c
+++ b/bloom.c
@@ -221,9 +221,7 @@ static uint32_t murmur3_seeded_v1(uint32_t seed, const char *data, size_t len)
 	return seed;
 }
 
-void fill_bloom_key(const char *data,
-		    size_t len,
-		    struct bloom_key *key,
+void bloom_key_fill(struct bloom_key *key, const char *data, size_t len,
 		    const struct bloom_filter_settings *settings)
 {
 	int i;
@@ -243,7 +241,7 @@ void fill_bloom_key(const char *data,
 		key->hashes[i] = hash0 + i * hash1;
 }
 
-void clear_bloom_key(struct bloom_key *key)
+void bloom_key_clear(struct bloom_key *key)
 {
 	FREE_AND_NULL(key->hashes);
 }
@@ -500,9 +498,9 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
-			fill_bloom_key(e->path, strlen(e->path), &key, settings);
+			bloom_key_fill(&key, e->path, strlen(e->path), settings);
 			add_key_to_filter(&key, filter, settings);
-			clear_bloom_key(&key);
+			bloom_key_clear(&key);
 		}
 
 	cleanup:
diff --git a/bloom.h b/bloom.h
index a9ded1822f..603bc1f90f 100644
--- a/bloom.h
+++ b/bloom.h
@@ -78,11 +78,9 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 				 struct bloom_filter *filter,
 				 uint32_t graph_pos);
 
-void fill_bloom_key(const char *data,
-		    size_t len,
-		    struct bloom_key *key,
+void bloom_key_fill(struct bloom_key *key, const char *data, size_t len,
 		    const struct bloom_filter_settings *settings);
-void clear_bloom_key(struct bloom_key *key);
+void bloom_key_clear(struct bloom_key *key);
 
 void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
diff --git a/line-log.c b/line-log.c
index 628e3fe3ae..07f2154e84 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1172,12 +1172,13 @@ static int bloom_filter_check(struct rev_info *rev,
 		return 0;
 
 	while (!result && range) {
-		fill_bloom_key(range->path, strlen(range->path), &key, rev->bloom_filter_settings);
+		bloom_key_fill(&key, range->path, strlen(range->path),
+			       rev->bloom_filter_settings);
 
 		if (bloom_filter_contains(filter, &key, rev->bloom_filter_settings))
 			result = 1;
 
-		clear_bloom_key(&key);
+		bloom_key_clear(&key);
 		range = range->next;
 	}
 
diff --git a/revision.c b/revision.c
index afee111196..a7eadff0a5 100644
--- a/revision.c
+++ b/revision.c
@@ -739,15 +739,15 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	revs->bloom_keys_nr = path_component_nr;
 	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
 
-	fill_bloom_key(path, len, &revs->bloom_keys[0],
+	bloom_key_fill(&revs->bloom_keys[0], path, len,
 		       revs->bloom_filter_settings);
 	path_component_nr = 1;
 
 	p = path + len - 1;
 	while (p > path) {
 		if (*p == '/')
-			fill_bloom_key(path, p - path,
-				       &revs->bloom_keys[path_component_nr++],
+			bloom_key_fill(&revs->bloom_keys[path_component_nr++],
+				       path, p - path,
 				       revs->bloom_filter_settings);
 		p--;
 	}
@@ -3231,7 +3231,7 @@ void release_revisions(struct rev_info *revs)
 	oidset_clear(&revs->missing_commits);
 
 	for (int i = 0; i < revs->bloom_keys_nr; i++)
-		clear_bloom_key(&revs->bloom_keys[i]);
+		bloom_key_clear(&revs->bloom_keys[i]);
 	FREE_AND_NULL(revs->bloom_keys);
 	revs->bloom_keys_nr = 0;
 }
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 6a24b6e0a6..3283544bd3 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -12,13 +12,13 @@ static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
 		struct bloom_key key;
 
-		fill_bloom_key(data, strlen(data), &key, &settings);
+		bloom_key_fill(&key, data, strlen(data), &settings);
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

