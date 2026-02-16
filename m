Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71760299948
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262444; cv=none; b=SEOaTV+chudDN2aS32SiRmE8VQAMzyffPS7Wcm4/xxAvH4bnpQDgcA7zG4/tfLCf1s3NwE5znWk9rZkU+5nQPefbiAGqQMWII8xgzSN4Mh2QXTlb5uNc0+BR22VlvIHCVL28naHcWpk9zVb2rTT2hfCgpaaxYI7bWHwy9YYlbgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262444; c=relaxed/simple;
	bh=2cp3FU8fOMbKycGWPhVx0n0ng0EDhnz6+4VgRwP+UrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/j8yFSZGI71nvqNRJW0NH78khQ8NtYhMncGG/ho/ES9k6TmgRZGonXQSQsZSmh6vBygRnmtpkuZImJpCwrucJdtk6V5ygwoSAJK6cGHdzkilEsqbE4q240CWFuDFtw2da/VJu8XFnpq36t9RsE2jJS9JblEd7k5xii4F9N9UKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT28kgxZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT28kgxZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-354bf10f057so311144a91.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771262442; x=1771867242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LBO+1Gm6rq45g9/FykDnqQ/EKRQZ+/HlszHTRDPbbI=;
        b=WT28kgxZbY/G82mtDxuSesXugPOj8kcsweDz+UYCIYj8vkACSAQDilw0oDnqGq/710
         T4aG4+TL65VoRYD9OR8frRz76L618kjEsEHMXvhK2Ecu/1GXgD7WnuHbVeRpIpPKzuXw
         dTgvKg8vcVsqu3Rf8nmrs4prLDk/ddMKDOqchuWjnFcApuDjESwQWIKQIVeuFSyvmC76
         36lTnfUJe/8uqUsm/VD5VK29qLocImj9sc+gYbwEE9K9H8Kt2N2K/8Z0KJENpRPDlIIr
         YAbECuWUyjsBSonHi0pVKctm26gZ/EDEsuzLJUiYGwpHNp0RadTkswDYFuga2nQe3mg6
         XwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262442; x=1771867242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LBO+1Gm6rq45g9/FykDnqQ/EKRQZ+/HlszHTRDPbbI=;
        b=InPCBIS5Wa3RAKl9RqJlIDm0SRalo/43kAuf9VNxLGSa042keh4O5Gey4raE4kpjYl
         AGAB8p6HSG1MgFTgeAG1SZlcscks0mMp6rwHmMb2C/jLtOIUQXz5MH5ZgzlQP/yd/wET
         4Lm1Fe2zVnFMI4PdK3k6+pS7pY4s9ZQzjJUkPlgWviNJKDkFtDPhy8rnz9NI9S/kfw+Z
         0sWOGvBlgg+/9lE6D2fBm0gNS+tVDOscc5neTvNGb4b2+GKflU4p8hT8y0+HoCvZQzZS
         Pqk50hdZF5VqgW+UA8KLetlBlg1zILX4X+Yjd6x/xATmb3D5lSc4/4ITMfkFRmSCkuUq
         +HHQ==
X-Gm-Message-State: AOJu0YzbiHB5mxfBQzFzRI7pO5G8sF1FUxzWz2P9jOp64QViIiYw0upM
	ylnbtlT4rW/hfSpYTsISYNnp29k96SBFnLsBuQsBQYGSS12QFaaM5wG7d1NysiKo
X-Gm-Gg: AZuq6aLeqeG6XlAeiyaliu0nWW1M5vTzgfLlwScZFWQO+x3mY7bb7gJ/UnPFjlgRwuL
	ghoA39VmlssboIKHvWKYsYqZXsAUUR5FB0sjIJiIHq2FX9xKgpcJYvmHBYAo/zawGqx6jM9F6OR
	LNUrKrlRtTyi+vIsjoIurNBfi4FSPNpaJ+6/ZmNhBTQUQW4JK+zdDNF/wqCD7gr1MojLXibi1d9
	6KElR7InYy056EnB/Ts26ZaxY8AYBBONoRAdJo5KjrWEHZ/z7lJ11yHyTf0rm48IWIW+Ri25x1b
	94kNt1JlXCAJcPEGrF4dk3Sau1UUSO5qaWBFYStXdA4HMxzKs6FYdVu1Ms4DyAhzSDmFnaMcJiR
	sxxGO4E21ZG+SePjZPfpbHEs0OlyzE1SvskUa8EyYXxA9CI9xlINoeRDPXeJP2XuxAWmE57rCyo
	gw0JKDxM/2iNM01estAf6g+U996ellf86g3EKBiw4=
X-Received: by 2002:a17:90b:534e:b0:352:e721:4f04 with SMTP id 98e67ed59e1d1-356a708e422mr8453428a91.0.1771262442134;
        Mon, 16 Feb 2026 09:20:42 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e6c0dbsm20063580a91.6.2026.02.16.09.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:20:41 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v3 1/1] symlinks: use unsigned int for flags
Date: Tue, 17 Feb 2026 01:20:28 +0800
Message-ID: <20260216172028.140525-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqzf66u9jj.fsf@gitster.g>
References: <xmqqzf66u9jj.fsf@gitster.g>
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

Change these fields from 'int' to 'unsigned int' to match our usage
patterns.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>

---
Changes in v3:

The commit message.
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

