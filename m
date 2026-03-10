Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A938B125
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144457; cv=none; b=dhj4qPI0IAkv7hf/G62p+ro0Yd8M8dDeHFxF1yVQjp7Y6PUgVzt7ms4C8FjgwVgy/R2SWe/bEmGJzR/YYfJbypqeaGsOnZ6v5bQv3be9f3puym6sBBVIn5QJO1AvyZcL8eFSvI9N0JR+UbPn5z3P/JTHs6qDrO3P4V+sSnERyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144457; c=relaxed/simple;
	bh=NdP7TypjJ35M5Pw/jBdJyL6P7C4gYw9uQ70sGE7L2i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhoievbwKlPD5mwrH5PuBl9UZWSvEzcL5tUJCTQhZ7rDx3sNgKS/43GixE67dZ9Qr3GNZpWVtJIMEJRw4674k51uV+V+ANlg72mNF3wKP81pb0mF/uBoAfnasPIzcgIv0VCGcAOttsESHuQyi28dTmfaMoogAUuTDtk4jkCPvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFpu4Q7t; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFpu4Q7t"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79901821bb0so18880807b3.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144455; x=1773749255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv67ZSalHlzzdaKtqQkbyDna82ODaIT55o/aLgYbo3U=;
        b=aFpu4Q7tpdDmG8xV4HDDwgvJylj0OsYxxojVHSTn6PO8WbMKXUuQjH71ZGmIJjHkpm
         bcR3DdJuVPs5nxaleq0DSh8NzdZkXSowmRD7UF4w2JRZFSmjeJT5iEH/T+J6M+Qf6o0M
         Q+kGkeQGYBhIuTfja9380mWsZ82UTjHAY8dVQ/vv7i4D0xNmhxMzOhOIJWLqsuDmeqba
         nu2oYjq31XzKLp/3lPMze2xXlkBiuxUOiOqA1zKEaQl2rlAgYdj1hmFA3kbcfdL1vIvR
         dvoE0z8va9LSnnMpzNAaA0SPM7KRZdn35s83/eX3BgI12GKxOfwl+3hDqFjAi+9Y0jCl
         S3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144455; x=1773749255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xv67ZSalHlzzdaKtqQkbyDna82ODaIT55o/aLgYbo3U=;
        b=r5u1ZE3Tf9GWRC1vxqvjWlQpq+98NSpOpQZfx6jj2/WGgwuj0L5jhePRcWm+xs7/y7
         qK1jS+4wZvkx/a48/o7P1Ld28uTOYBOrPurQHvSQKWj5a/FCOhvNFd7zeuJJz3OF0tK5
         2lcgrFLaftSnE1ZiEScwfCHkl0sS0s7MyV9MjorJNnareoAaBGQVECkU4pDq1itAbc9U
         cDzBa0N0wA1Rjeh5pqrm6Ns5EDWPsk9JNe/sCh1RLEauxIN1RWCEEYv39NPOP7Gtnwb+
         8qAQ2zHHvCmG4s5EcO1CTWUkNnUNyswaupQosNHZMJ9QlQdsiEwEi2Z8rLtUo3ZDHw4f
         kBkA==
X-Gm-Message-State: AOJu0YyH8POU9BGqHqvyaPuAY/9F4k1Pj0CKvKthdvea1SB7Z8ZaRO6z
	/qbIl5YgMCeh7QGFjeCRmGypc5lI4XywuEWctLWtquiyriOoBoKMDhwm9ixdUlYz5wE=
X-Gm-Gg: ATEYQzzZkNePkcbgvKShr9izJEGnGVcp3sFYf3BVFoqTycSQHRHkxXdFb3V0CL8Zgil
	YKrEilJFcvbW5GZm1pdd5qYfM4crFmRapJkWt1W+Chd4JkXE42UAZoMD/GWgolhAtDMctwKNEmO
	UOPhfXen0srIitcOH+H/ThkO0omxP5odtDBW5cHqlp+bzG2t+yDgHxKLs666lBeNxP05GQ3MrgM
	fQ+fhPGKPUn0aSZE32CZH020GLuFpaYYIkNaZDNMF/CkTKy9u3WBqio2zSqSzMuo6gEyN8fj3ep
	uFsRaeHLO3Q/JYryoVtGdzIcQjhp+8Jn3FRJ0R7xfBvSOPfoSzxeiLkkNvo2BLFDlJbcZU61x+s
	QAEK/T+ObJitRLYO5DDqZ8mDzm7yp4u8QJSTSdjYy7qg5Skb5V0LiMy0NR7L8jhy8MS6g9Xpvsv
	SFCquPW0aK2by4lD3Q8SHemKUwpO77224RoofIWw==
X-Received: by 2002:a05:690c:e3ea:b0:798:715a:c9c1 with SMTP id 00721157ae682-798dd66f2c6mr140107867b3.10.1773144455398;
        Tue, 10 Mar 2026 05:07:35 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:07:35 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 1/8] environment: move "trust_ctime" into `struct repo_config_values`
Date: Tue, 10 Mar 2026 13:06:22 +0100
Message-ID: <1188d351e62718f906cb5f49a9ac344b3d88dd3f.1773127785.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <cover.1773127785.git.belkid98@gmail.com>
References: <cover.1773127785.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `core.trustctime` configuration is currently stored in the global
variable `trust_ctime`, which makes it shared across repository
instances in a single process.

Store it instead in `repo_config_values`, so the value is tied to the
repository from which it was read. This preserves existing behavior
while avoiding cross-repository state leakage and continues the effort
to reduce reliance on global configuration state.

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

