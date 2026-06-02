Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016303F58E5
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420250; cv=none; b=tDezVT+3PhkHEfI3JEen/aeGEhYrhertskcWc3HKykH1+NTPW+kTTKE/8JBY0bF+UmWhibDm80tGERa2vSTiUg8lJNGskYLwOiVNYMHx6sPuPvRAZW46NWcpkcVV/sFTpCimzjAX913uVi+o+amrsIvmQE/pxINeeGc3yFW5zug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420250; c=relaxed/simple;
	bh=5KIWUcltrJf9e3rFqPneanZwKO/HHCtaDgLGetU9ZW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELeFAR5S2y0V5r+id5teVpOMlyohNRJ0BMj97w6j6z9UKsSe6hFkEcCfG2ZbptgaD3ftCDBPNfNxjd4liBltDCo60ZZ0AnsybDJY+liyMTQqu4sqbbJ2DVDpy0g1aJUJcNFDQ+0mn//MCagP0YOS/JsHiYai+PEb+bezNgoYuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+njAjeB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+njAjeB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so7882835e9.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420247; x=1781025047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9Ppbw7Mvhw0n+LOtNbpZFhHe2Dg7zlX7Ra36EcUPpo=;
        b=P+njAjeBkrmpft1nr3uJlebqKuS7MeH9xGuZXpEuJ1U++tPWEAMTFxyREB70zm3ki2
         hRUmX5iNMIa3M9E8FhDt7JXj+onDSX3iX8uUfCO4IsehW0pp9XkE5bkGGWe4pkheuvnW
         gFU/7od/4+/VlaXgQN7AqQ7f1GbSwwUsBK7k0zvYf488c2PBQPVJfcnBbRwPq6pE+hw9
         bklWke+tzdFXEnSThEEOWlVUqBVXsoVTqRhUDw1z7x/uGvu6RMSbHg5r4c4nc3T6Ohsp
         5LW/bA4SjsoqyKVS8qPnsWIVESCzaME+1YskPYEBirKRTsVC/4hYf3GMMCd4bWOTRMUb
         A+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420247; x=1781025047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9Ppbw7Mvhw0n+LOtNbpZFhHe2Dg7zlX7Ra36EcUPpo=;
        b=AlpJJITa8aPSdMGVm8LvKwf8DLvps0AcVGQ9DVky/w5s1GbpfqjPPvzQDz4/ujjqLG
         vXLxOs+SpDrcbvDtLgPnZj4MJhD2nsVXNlc9GcjyYKUCGApnQpWawobMsRynp+53yiD6
         7N3V/gwhDoXseEcEQiskxFrnukmssDrnNoqZ36lo1YOaEmZLbqVY4h18EaTWm7rC4N0q
         e7mcCCMn+XmKbYvjqUxlgqqxtBqeXl25Ql/luU93vmi3E6BgDj2hQQN5BqCKi8dwIwQ5
         LDe0MCmgWJZwKqlDsDSNf0j6SLZQr5S1LizE9BABSBV3LIGWKE8Itlf75GZlwVThTB4D
         hn9A==
X-Gm-Message-State: AOJu0Yx8toNIZoaU9ArZkH/8YgHGrv/ChxACLoTYwlwDE3EbegVJQvQe
	feZZID3sEbswmhqTuFDYOs8dfbSMF9ZDTlymK+takyMsLOl+XvpCfD+Qx4iqXuaY
X-Gm-Gg: Acq92OELet28Ka2L+EfQtczkFSfIj8DpoLd41l4Vp9cQRtVAFd6txHmfYiBQRBeqFj1
	UAZAVXqBIm61G6O908Sx/Hs8ae3sb4w/U51vESx5Qj3fRlAO0HTVf9ORqPSqi011CRRqrVk+A+h
	05DeUGIA6La8HGb/3luOU1Cm0I410JSAN8G2zgBxVFCEhnS9QZYVwuCa93N3XRnpO2lUtfrc3VB
	JQgy6owrkM+i/oM/aUKJIRz41BLnZpi/H87O7XNiefnjmTF3LtVPJfVWrUx2jEKji4XCLgwZv6x
	6NBxBriFThbpz5K6UqcVYfy6y+8vYXlFDpFTW26mokTnDsmQAIlFh++dA9m9DQ5ISfj0b96jW4Q
	Tx8Z8YKYib71htWwwR7pvG0T5BfhAdclHFAXyUaoOv1MMA/MqQAAaRbeCXM+16LoV8eTqF9ouKP
	oK7PbWVQhRbWA0HlQiYf5MatLOBeHc1V8J4FW4s258o5ZLJlcL0+27VDlwSUz7TS3mtx/M+Pw=
X-Received: by 2002:a05:600c:81c5:b0:490:3d62:eb0 with SMTP id 5b1f17b1804b1-490b509a548mr9464185e9.24.1780420247285;
        Tue, 02 Jun 2026 10:10:47 -0700 (PDT)
Received: from pop-os.localdomain ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm122904265e9.7.2026.06.02.10.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:10:46 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 1/8] environment: move "trust_ctime" into `struct repo_config_values`
Date: Tue,  2 Jun 2026 18:09:14 +0100
Message-ID: <20260602170921.35869-2-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260602170921.35869-1-belkid98@gmail.com>
References: <20260601154211.82370-1-belkid98@gmail.com>
 <20260602170921.35869-1-belkid98@gmail.com>
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
fatal errors, result in a performance regression and complicate
libification efforts. This preserves that behavior while tying the
value to the repository from which it was read, avoiding cross‑repository
state leakage and continuing the effort to reduce reliance on global
configuration state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
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

