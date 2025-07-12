Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1E274B4E
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312971; cv=none; b=nqyvZbQI206sKYrSvj1txoxLGl3w43jXbWfMVFSyZml2eegnowHqgLGNyZbIxnPcuQHO8bFpHu1JAbZdlqg+bT/DjblDfl9ck+O52IRk7S8NZGCYENpbrYbOksp261X9yVuE2U9m9twsNvMaUm2O/DZdQGmiTUkR+rWjIRULlN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312971; c=relaxed/simple;
	bh=dZbZx5PBKOwWWLcfoAyoMQwC7XOhpnZf71uXNPqEtZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBLvNHCEzUf4rtrxNuwxHTQobvcLXSysiMWs+w1DLlrwJ9+H0pIPZGVaLEmvhGk+8XkV4m+vGXAzDrYkjwH63s/5Bd/zOOJnwiGUdUXfaObejdubVY2y9t2i59K6rPaoZnyraEnyqrbDLImLejRIaOXEXmb1qppij4jtih6Uzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt2x87z1; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt2x87z1"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7481600130eso3461532b3a.3
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752312969; x=1752917769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q13B+wyULX7kFaRx71CbfXzjuTw74ci9wdj3mX9Fo4=;
        b=Dt2x87z1gytBIZSnVfdkrcdqdOutHgMqxbF3H+nVoGmdrffvwBHac5KK55WO6W44/5
         UJRQIsfvorgpD2Uhl4kpECO5ueF4QCkwRMW92SyI27dMkvi/ghcALGDkBGoZ6c/QKJbL
         D7x0N7JB8TEMLi6aTd6tCIcL2Dh2MTGIlIhb9QtcFk8l1GtePfW8//8IAG3XGsYc7sj/
         zLFKux0PnMQuPF1/dmuZGOgZ24tgJ2VBT8+LgwUIzMTgptoGx+dDYo1WQP3L+NCqm3pM
         NLElB3+mJCOlDVJzRV3YNQNLb9iFNN4VdJJ/m4rJJeagpw5+odrC9ArxYR5VbDlh620Y
         VfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752312969; x=1752917769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q13B+wyULX7kFaRx71CbfXzjuTw74ci9wdj3mX9Fo4=;
        b=a012WPAUd+nHnxTb8uPaIAFe3E8QbFP1n+utFDYCY4i8A45IW1RO0QiQX7b2PcOr36
         U4YTZNsCdlRHlth3Z22W9nhHmuDRsE9ITq8dvIGuhyUGcv/DT+fSMbOn/QhIAgWFaEv1
         b36PNuOcjwm2nQKXJLD7pq/CG+Vhfp7HElDIdoi8wQhyKlCUrQ300xoDpI2oQpPeximS
         ACn20EwWj9S8JKTMOBFpMXl3J1ws+NzPKkSn/itLNPy3vz5I8nB3XyUfjzeK/scRamj1
         p84101NguT/YSX4GkkEjHNO3oND31R1MD4qghzR/DStRpPNBbGRY491lt4lHl4dvEqbk
         ioTw==
X-Forwarded-Encrypted: i=1; AJvYcCXeJsmd2VCA6mPfFrCA2nQXg1pm269d38HfL513F4oVHvVgr+6lcyrc8mQi/CCefeBBzsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLENclD2M0mueDWHHjf8+CDqClmBs5E+M23CgO6Oe56pBPlINK
	qL83J/FTnNbah4USGDOyw7iL02vdgZQkZzMQL+7lqqmYB7GiVBz0xqku
X-Gm-Gg: ASbGncv2TVkWwJQYROiy6zKaDa3uwipAy54txmSXuns+uR5Xj0dS9QwVqtPICVAmkYK
	z6xlXrxyLPnjI2xIJb9DQAvrjpMCDWS8rhXZp/SkZXqRtE0tqSHjXeTM40nvsJ5UM85DaocUuqm
	oo9h2HEDecOGQjOPo5LKAp1mUXc9Oabqa69f8At2eXSnHmsJ1NEQERXkDZ0mKCI4Bt2jVRJ0zGT
	YBq7+/mRjHVBZfOg2GQirR1OUf5eB1GZ3l7+tFzwaI4lWDomO+WNODTAtbe6rgXfy+PkDCOLK+Q
	8KFWZoLQaK6Q7GWiJSI3QiwtfZg00iuHe0wTL/TA291MWnTUeTs0WRFa//lI2B43dypq4aRK0Fd
	X5/5aDdhZZ4h/em980/ebsV2aA162srFi42jHyR5NkCAwivV7E63v9TLRh5S7d8mpu5/clbANM8
	6a+wAPMWOCBThIHMshQZxlS5RwFfwfLA==
X-Google-Smtp-Source: AGHT+IEcFp3zXckeijQhbSJGLgI8ARer92XpSwRe7OC/VFvXNW+npyP3Ydgy/WrKAe40NbTcLRNmwA==
X-Received: by 2002:a05:6a21:670d:b0:230:f020:ddf2 with SMTP id adf61e73a8af0-2311ee4b248mr9721191637.19.1752312968997;
        Sat, 12 Jul 2025 02:36:08 -0700 (PDT)
Received: from localhost.localdomain (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b43dsm7126997b3a.79.2025.07.12.02.36.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Jul 2025 02:36:08 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com,
	stolee@gmail.com
Subject: [PATCH v6 4/5] revision: make helper for pathspec to bloom keyvec
Date: Sat, 12 Jul 2025 17:35:16 +0800
Message-Id: <20250712093517.17907-5-yldhome2d2@gmail.com>
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

When preparing to use bloom filters in a revision walk, Git populates a
boom_keyvec with an array of bloom keys for the components of a path.
Before we create the ability to map multiple pathspecs to multiple
bloom_keyvecs, extract the conversion from a pathspec to a bloom_keyvec
into its own helper method. This simplifies the state that persists in
prepare_to_use_bloom_filter() as well as makes the future change much
simpler.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 revision.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/revision.c b/revision.c
index e4e0c83b0c..1614c6ce0d 100644
--- a/revision.c
+++ b/revision.c
@@ -687,13 +687,37 @@ static int forbid_bloom_filters(struct pathspec *spec)
 
 static void release_revisions_bloom_keyvecs(struct rev_info *revs);
 
-static void prepare_to_use_bloom_filter(struct rev_info *revs)
+static int convert_pathspec_to_bloom_keyvec(struct bloom_keyvec **out,
+					    const struct pathspec_item *pi,
+					    const struct bloom_filter_settings *settings)
 {
-	struct pathspec_item *pi;
 	char *path_alloc = NULL;
 	const char *path;
 	size_t len;
+	int res = 0;
+
+	/* remove single trailing slash from path, if needed */
+	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
+		path_alloc = xmemdupz(pi->match, pi->len - 1);
+		path = path_alloc;
+	} else
+		path = pi->match;
+
+	len = strlen(path);
+	if (!len) {
+		res = -1;
+		goto cleanup;
+	}
 
+	*out = bloom_keyvec_new(path, len, settings);
+
+cleanup:
+	free(path_alloc);
+	return res;
+}
+
+static void prepare_to_use_bloom_filter(struct rev_info *revs)
+{
 	if (!revs->commits)
 		return;
 
@@ -711,22 +735,12 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 	revs->bloom_keyvecs_nr = 1;
 	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
-	pi = &revs->pruning.pathspec.items[0];
 
-	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
-		path = path_alloc;
-	} else
-		path = pi->match;
-
-	len = strlen(path);
-	if (!len)
+	if (convert_pathspec_to_bloom_keyvec(&revs->bloom_keyvecs[0],
+					     &revs->pruning.pathspec.items[0],
+					     revs->bloom_filter_settings))
 		goto fail;
 
-	revs->bloom_keyvecs[0] =
-		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
-
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);
 		bloom_filter_atexit_registered = 1;
@@ -736,7 +750,6 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 
 fail:
 	revs->bloom_filter_settings = NULL;
-	free(path_alloc);
 	release_revisions_bloom_keyvecs(revs);
 }
 
-- 
2.39.5 (Apple Git-154)

