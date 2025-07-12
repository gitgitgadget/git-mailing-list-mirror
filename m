Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E31F4285
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312960; cv=none; b=iCMYAFTelg8HVNrEKwt+kHYdhCNN/bGQNnaxMdxs0CSVBiU4/ufHLLIc/fhIFVjqHTf8uEmD+eli0prDfpsIBip6whAhh8hQvkJhaDJIW6BfeYkfmybk/UaDMqdo/tMipEv9ZfXaKO1JI50J9Qz9NRdXfttVFyQ5VySAGGbPp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312960; c=relaxed/simple;
	bh=dIb17DZibuSeVOz/EL2UXhjqiir+WtYJP4VNmywp4x0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EH4D4kgSmTDMCsu/h9dryN5IAEQYQW9ExcBUdIsRVunNSeSM+cNmXU0pZ1k0lny1E8WaCs9enEYSIQ9d8DXcBipp7hZMfbR8T2ZCBGd+CEOofH0qymPXzcwjfuycUMRJnVg6ey2GRAgCSbCbGzs8MUwtP8lK0qsowW3ZbavNkYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJsldBHF; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJsldBHF"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7490cb9a892so1806467b3a.0
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752312959; x=1752917759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owz8Z0S2qmAc3+BplSKXEIsGMqgPhFJcyU5a2UbaLYw=;
        b=bJsldBHFR+woZSMG0znctNQib0urRNcKa9ZaGTpo1sNfi9h1b1fcrDLUbHll56Ihhr
         CnA64SHTq3+OFcb3oElSrVTpHaRKHckomcgsmzxDlPlPTVnpu4idjYhO4YR7oWVYzpLs
         2GVg9G5uz0QO4w/UNyfSu5nKv9WtiJXivH8F32mIsn7UugxJNpQ2+5M8Wbc1wZhmBl58
         KExpky3HQqxEzZVm5+VkdAQ4YAxzVl/ajJm1O5Zs9IcgiS1vkiEwwy0I81veR+qBO5o6
         TScX+4qdh3HrWUQYteM6rl6A3wYPQu0GKHazeg6Y9UlkgE9qFwiooL99VSrEwe7FR2sO
         9sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752312959; x=1752917759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owz8Z0S2qmAc3+BplSKXEIsGMqgPhFJcyU5a2UbaLYw=;
        b=bg1GJBTz6PqaYLQxDdJFeZeg0ioDSosCwBy7VGhIlFcGtfOzTctTfir+ksbolpOVdt
         kjjTx1+9jTjKIdIOwsi7qbuW3l1PvGr2QU2mIWeyb5eUY5GFIvwuNPmkFHtos+fAnjv4
         0weJCuo1ioqTEUCds0KTh42GQJxb2Za3tkpOMRtq8wQqHXtsRBx7KXVYZMRa5kofJ+W+
         ThXsih3N5ZysF+MDRFwRRct/ZTF8qnnVeSqxpqCl6jXp1CE+DxUPSJRkDP8whsbb2iKJ
         yuf6U2e0bsNQqSMwmdC0OhG48QC9uVGa/Y4YHpBDq9n4kY9vVHNv3d/0xOs657BPqZBl
         fRyg==
X-Forwarded-Encrypted: i=1; AJvYcCXh4VKjvCKp+UwO2eIkw9drE6pFjomymdc6dmu586HMwqtrtdeJO1gsBa6oGqH5lLF9Htw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FCZD7+90r4FMsrIpJ8IFT30KMojI8TbKQMG9uJvBEQgavwGV
	q/wnfGSSdeZK9/5yPx9e6qSi69E4G0akM/gfF8KVNSukbz2L8d0Zl3YuOTe40VyyFUk=
X-Gm-Gg: ASbGncvj/dHjNtoTokH/bDDBds73unRKN3BePpPUx/gUf4KLsF7rP8Trizgx376WoP9
	6LDtxj6JXvV2agMSiAs4A02ZCu361OyqNMu5wxG+LVeObOuW+LGQwNconNTgeEQZ0SpwMRLTRbt
	ODvtjPp9u/l16YkwPVuxeQc+a+DrqrM5CqdQR5DXyvq54pJJhvoE6c0pj5V4DxjZX2wEcgV6fSS
	FaWyHQhE5Ky58FVQp5NjtW74GWdA7NzjnXFSiA7JD+QolVJHLEfQqLnppjvwPxtqs6UaE2Ur/u/
	aMX8kBhPyn4FV5/ljOOnLe3EENGYiZ8vFVurvT6qKbjlWUX4/y+oSg6p8GcWDMNhpPEutv2ff7Q
	eCW/wU/0YJTluxeDqxciZFC2KLfwVjm5f9QorkykapyDHni86x30qRXj4xSjrTGTM7Edrxo8u+x
	L0GrYkEiM0a0jxhOLkZqxPHy4nUadhLw==
X-Google-Smtp-Source: AGHT+IFvQEvOOls3+VUVxmwaoYm1aC4mliVVC0Q74j2Ch2+BbbknWgnbei4RyGf+VjEbhhGLp1n1tA==
X-Received: by 2002:a05:6a21:6da5:b0:220:842f:2760 with SMTP id adf61e73a8af0-2311dc65197mr8882718637.4.1752312958486;
        Sat, 12 Jul 2025 02:35:58 -0700 (PDT)
Received: from localhost.localdomain (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b43dsm7126997b3a.79.2025.07.12.02.35.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Jul 2025 02:35:58 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com,
	stolee@gmail.com
Subject: [PATCH v6 2/5] bloom: rename function operates on bloom_key
Date: Sat, 12 Jul 2025 17:35:14 +0800
Message-Id: <20250712093517.17907-3-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250712093517.17907-1-yldhome2d2@gmail.com>
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250712093517.17907-1-yldhome2d2@gmail.com>
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
2.39.5 (Apple Git-154)

