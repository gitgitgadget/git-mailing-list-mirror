Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D737D137
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963341; cv=none; b=eBhUEguF2xqeSH1Pfts1RvOShbC9T+tbxKNet091EOX95/g+Kln/CebApEfWuSSsUma3SM1wrJdpyg5C7sC4wlBXx3g2LnQh7ve5Yub2vsiZDsWuPSIusEdH9Z/F0SeTwab8y0UgkoEKmfDMVOarL1UhQvDNHi6ERI3YzJXa7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963341; c=relaxed/simple;
	bh=w+EW+oQAuEuNM+HkMAj5X0dmsHZoHJJyOg448dl2/dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH8XR9N3goBc/isWYkCsQ9+6PGRAGh44PBqc2KMY7L2t5dQqOIEn+jE2mH/AFznuDGMCsVCHpiwDbE2njsxeupVVoXg8jyioXMWVK9MR9efwGLwGzlM5SYxzYSXRCSdQUnQS0HM3+QjtVrwcoWz+VhP6zw7Y9PDWxY9toVf/hbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW/DVRdY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW/DVRdY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso64441365e9.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963337; x=1777568137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4esusnYDgewkinA+cOvLaR/HdyBLjeU9/oTq/pKvsY=;
        b=cW/DVRdYFfyrp7SwkSCt2XanQnREFQ6e/BcGFLIN4Y8qqmPa4Kynj2NQVEPe9Jqu6I
         U6F3kAHY1cSpKOyG5qVtoZkxr8MvPlJSR2J35rj6r5qilcILdFnL0F6fANNpwZ9Snm5w
         CL0u5Y0L/FoVCAo1sc8OFCRSpOe0Q4erjxplwHdxLxyr/K9dkjQfmd7i1H7JphCZyTQE
         5Nxt+LKyqIS1F5l/VwizGHT/Bklqa+u3ao9+UowfXoLFxrM2z061/2ek9z2mGUBUmWOM
         NzYH1ptzONlRFmia9jjRdQzSxGtwPHxJ6bfew3QiiNxWC69HT2MEWfWUp7FQAt9X8sIl
         az4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963337; x=1777568137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4esusnYDgewkinA+cOvLaR/HdyBLjeU9/oTq/pKvsY=;
        b=N04Z+p3FmWzCtoSAW5CDpsNo0idGRb8ThPY57dXJtWBCTjZG53e2VUU6LNHkTQg2qf
         gYyqBeWCJ+3uHsCjCuosoxc0XPzt3YxZTX98zFQbW+J/FbcYkzcSw2iXLl7ZM6OHaW95
         MxI98pB+jyWEDx5HZomkzgy4g5F54TXl+GaCHaj4S0Aia9eeGKINGlDd1hz6LiiRmTdA
         jPTlOQOYAZSs2Zw1RzZwD7X7RifMohVl1G/moCYMDDtXDhSu8es1QrVfuWlSSmxyises
         22zJV/Q7yYGLIt79yAuRN0gNT6+dTkBEWngmusQVjlmZbU4LOSXF848n+DqXJcV64Y9i
         OIHQ==
X-Gm-Message-State: AOJu0YxzbZoGyGRwM/j0X7gEW4y2tDesp9TpZtl+sawTrJoE1DHRIfSS
	OzOYLVENBscNqY5iy6gcTkpgP9xlqT7ODokjFFXYlPpEpbLffYabGjFbppvGMFck
X-Gm-Gg: AeBDies7i+jDwKulgjHDT4id6IV9YTSs64FOmQsFJdOIk9svWYdaCt1Y3HnPcOP2Pb7
	U+fxcaA4t1txXW97ZhI+i0bxZCviqpIXx+jEmJ+ChZBEMxCKmc7WBFDAfj9lRVp+vD7GqFP0a55
	7YnCU33VgC0jqdKLsnUKFPN8QheODdF3ebAtvSd5Tw/LvTHuN4j731L8+/PLg3R60R79+SVmuRY
	akT0A17TdG+cuB9ZN7hfHgDC1BJ8NKT8wn2QfjUx///J5Yiv4ZhQNNMwBXFmbqEoCqsdxHwi3ro
	++F4fyy06yl74j6SNSfUCgOdubZbma+nWM0t294vUM088Srskpfo9v0LRcOhwOjMQ0qR6495oAF
	Rrtc6Y0Cgw1VHHiMcR/tReKt2GHK5drr6obemLl62f9KIcU/qMN3AnlncM6rV0zl9RBVP00q+qE
	d1lgwTnTygYVYVzXfozgj5rXPfHfl2PQvPUZAGyilwZOvheGIXkKnKSqnTo5hC8vYZ4cK3Hg==
X-Received: by 2002:a05:600c:a117:b0:48a:58ae:992f with SMTP id 5b1f17b1804b1-48a58ae9ec5mr106997545e9.16.1776963336967;
        Thu, 23 Apr 2026 09:55:36 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm353431995e9.13.2026.04.23.09.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:55:36 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 1/8] environment: move "trust_ctime" into `struct repo_config_values`
Date: Thu, 23 Apr 2026 17:54:25 +0100
Message-ID: <20260423165432.143598-2-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423165432.143598-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423165432.143598-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `core.trustctime` configuration is currently stored in the global
variable `trust_ctime`, which makes it shared across repository
instances in a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `core.trustctime` is parsed eagerly
because it is used in low‑level stat‑matching functions
(`match_stat_data()`), where a lazy parse could cause unexpected
fatal errors and complicate libification efforts. This preserves
that behavior while tying the value to the repository from which it
was read, avoiding cross‑repository state leakage and continuing the
effort to reduce reliance on global configuration state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 environment.c | 4 ++--
 environment.h | 2 +-
 statinfo.c    | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index fc3ed8bb1c..0a9067729e 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ static int pack_compression_seen;
 static int zlib_compression_seen;
 
 int trust_executable_bit = 1;
-int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
@@ -309,7 +308,7 @@ int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "core.trustctime")) {
-		trust_ctime = git_config_bool(var, value);
+		cfg->trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "core.checkstat")) {
@@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->attributes_file = NULL;
 	cfg->apply_sparse_checkout = 0;
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
+	cfg->trust_ctime = 1;
 }
diff --git a/environment.h b/environment.h
index 123a71cdc8..64d537686e 100644
--- a/environment.h
+++ b/environment.h
@@ -91,6 +91,7 @@ struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
 	int apply_sparse_checkout;
+	int trust_ctime;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -161,7 +162,6 @@ extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
-extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
diff --git a/statinfo.c b/statinfo.c
index 30a164b0e6..4fc12053f4 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "statinfo.h"
+#include "repository.h"
 
 /*
  * Munge st_size into an unsigned int.
@@ -63,17 +64,18 @@ void fake_lstat_data(const struct stat_data *sd, struct stat *st)
 int match_stat_data(const struct stat_data *sd, struct stat *st)
 {
 	int changed = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (cfg->trust_ctime && check_stat &&
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
 	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (cfg->trust_ctime && check_stat &&
 	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
-- 
2.53.0.155.g9f36b15afa

