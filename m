Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076A37BE71
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868506; cv=none; b=i/WB+bu64RKREgHfqxKLcJ2BdW7V4mrqvTMrn0+cBugVQX4qlpmjgnVvo/gcqz6nLWOeu+buRFcbQh5a8Wk49wWHiMp0Ovb+TH2/mV61qKIIqYQCH0y/C5+4/ATNSQ3MWugaPhit/Q0zDmYUj91Dr2YnN4qHv48XdEejSW4p9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868506; c=relaxed/simple;
	bh=HKmr/z8nftrgn6Kovld9F6VUOTvlPDVGlRKMABxvnsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILXU3igHiCVOEHmrkC5Dc8fX6cGMdm7CU341H05TL+yNpPg1z6ydJR3cdyJqVwu6JcdE8sX5YRNxfGamFTM4qTSFAGAP6H8afPjZFw4EFjWyaDsVwR/c5qE2SJLOutUS2zOUv98D2wxbmSdzf+m6hBHG9hRiltfFcBXRw+dcaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JbzqbPze; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deEGPtVC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JbzqbPze";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deEGPtVC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1D487A01A5;
	Fri, 19 Jun 2026 07:28:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 19 Jun 2026 07:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868504;
	 x=1781954904; bh=N3h+jvMoyQezf1dNzeIk57yfHMHj/79mI/UTFN71egw=; b=
	JbzqbPzevbmJFyVD4CK6vxYsC41fApMeYucbDtGtSDM9nWEBIuDpD1W3f8I2VbeI
	U/udIP4Ku2NphdwZU+GQANUR4S0+3nMnylZAKcWPcNdwCYGjIZvCJ20uEWGBuua1
	oXJTIwsdlK+SaQ3umIbcMf+08Re+oR0tJ8CXMBAx0yFXajqIDv+EUUaHHLAEwQgK
	sTM6rbrYRqf4ZlyRUSjFd+qNRumR127J8IcbCgXFUQF7EdJ+F4lmGe4Hi4ha/dNv
	EVMzAhyjK2HWTaYC2HFgkjgm0TSpx1Dc77xEwPB0Eh7MNN6Hl4QD0zJh4FQxJZC6
	f1nWYzxPnfU04ZWFrX9Qlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868504; x=
	1781954904; bh=N3h+jvMoyQezf1dNzeIk57yfHMHj/79mI/UTFN71egw=; b=d
	eEGPtVCEyd4IIEElBr+LgZQJnI75ZS5+cG6uDGZearDw8kyrvxkbcatiQhvvHf3u
	7zfHsUVV7qxvsIxtR4dlvgXq8lyKTwUnDVUdF6pzYtwRS71qqPdKr+OI8LmzuBUd
	ti1CbTGwfLQiMUQBWmwEIrnMiIv4cQ1F3kMLF59c+qgGsd0XyoLvzyfXN1jnl8Op
	A0oyMwES0LSvc32H2OL3PuR4+AXO1IY4rNpRo2qkER51pHoGB66ki4Z4kcqXe3KO
	+ZzXafZJGB2IbIu1rgEAc4DgzWLD1b0cOhYiYTRdH53/tc9oMDtWiJfAXVH8X3ZY
	ny2f2kp4YIdz/hmuFSdSA==
X-ME-Sender: <xms:2Cc1ajk2tXRfRl9g-6N1_yc26P9gvBZwK2gDOajpuOHgXY3lnTp1Cg>
    <xme:2Cc1at0Mmk06akbUV36FfMoxhayxOExrPixmzVuKqw_PYF5abSj5XI_McTZ-2bPQR
    GJ5IX9uOSA0r4LlVhhPldjfoJ8-2tju8JKU74RmF2w-CQq5kxhipQ>
X-ME-Received: <xmr:2Cc1auoVzGE2zL06WnjLKIFJVKMK5k6rPdOUx1yGSMLlAlRkhZnSs5frD-pQrlPjlePB3W4ABSfySJ8c9M3zYZyczD0o-vaQaSF5pm0FEyQ>
X-ME-Proxy-Cause: dmFkZTGJMU9C8aWdt+HT2E9Csd5fvIGoXuKeS6N/eLDbH20Ipsuk2OuQ/qBibkscT73Z9+
    rW94WqBzQQOwo/R2uSaM2NFc/3X0LZvdpxe4o9NDv5NaEl3LACY7rFQ+Uc4zVZVp1zqVl5
    eR92+h73qA64GqL4PuQdNMCIHdCarag8xKD7xDKFoE1gqQNbIzchmrR5i0zzXXZtBqD6Iv
    UiG77/VvNwChQmfmhsDjrr0jYfjr+QPnfi92kmEvmA3SqOPDsOqagF+cciwf0rY8J83Yrr
    oPazzVCuCPjpyvfnXM+HBvgNVn6V1AzkiBH/nJYv4XwSI8Lfa33QbsY8cTm6F8NWA7KLgq
    +qv842F2H78pz0WyxTP+f08BLZSVEuYUeLkYHnbFFv3g3cYXnCczP3WpFMKldK2rN7DtB4
    epwJ9u3aEAz1Nl9kIH7pevEHfSG53/XU/lfReNz04a+M3WNoR7u7Nujfj7SpcB3hC9jqqo
    N07Cxx78y2+BnkukSwHAaBkJu9sjoKbQGx1wM0sAHdQUUXCafm9XklfQLCVKPCzBmOAwt+
    D2peAOr+PhUoDqP0JKqAl7+YmwZl7htJxrO98JmTAYnqHXqmK/zi/k8uGh76OOA0XAx3Dc
    RtAoaIUUav1+DCGWSdgGK8CeMzSJinCVur3MIE9U6H5dllw0bvLtRPKuJKjw
X-ME-Proxy: <xmx:2Cc1aqeebfj54fseNlrdjHU4DZg5lsMRpjjcHO6vVfriITF3yvfZvQ>
    <xmx:2Cc1atrMawTV7u6aOeisw2oFoR2fOZZbN8TKC5FtwxFIk8L-CvJazw>
    <xmx:2Cc1arFigO_eDZmE-WKFAKwdnPCcdxwqXb17h_B18aC2jP_B_2kRJg>
    <xmx:2Cc1atsebFPpgE1yhTa8lIEcb9uLb6KNoZC_K8rIwDRPuoZoHWBY3g>
    <xmx:2Cc1ahuk0TnHx7rmV3GQ1gNv2Ce1q8Zn_Kfj-P_SqvK3ndFkzcL5K7zP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d4ecc5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:56 +0200
Subject: [PATCH v4 08/10] refs/reftable-backend: manually parse
 "core.sharedRepository"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-8-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

We're using `calc_shared_perm()` when creating a reftable repository.
This function internally uses `repo_settings_get_shared_repository()`,
which results in the same chicken-and-egg problem as mentioned in the
preceding commit.

Prepare for a fix by handling parsing of "core.sharedRepository"
manually in `reftable_be_config()` so that we have full control over how
exactly this configuration is read.

Note that this change requires a small reording in "setup.c" when
creating the repositroy, as we only write "core.sharedRepository" into
the configuration after we've already created the reference database.
This is too late though now that we parse the value directly from the
configuration, so we have to reverse the order.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c                  | 11 ++++++-----
 path.h                  |  2 +-
 refs/reftable-backend.c |  8 +++++++-
 setup.c                 |  8 ++++----
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/path.c b/path.c
index d7e17bf174..c28b057374 100644
--- a/path.c
+++ b/path.c
@@ -736,11 +736,10 @@ char *interpolate_path(const char *path, int real_home)
 	return NULL;
 }
 
-int calc_shared_perm(struct repository *repo,
-		     int mode)
+int calc_shared_perm(int shared_repo, int mode)
 {
 	int tweak;
-	int shared_repo = repo_settings_get_shared_repository(repo);
+
 	if (shared_repo < 0)
 		tweak = -shared_repo;
 	else
@@ -763,13 +762,15 @@ int adjust_shared_perm(struct repository *repo,
 		       const char *path)
 {
 	int old_mode, new_mode;
+	int shared_repository;
 
-	if (!repo_settings_get_shared_repository(repo))
+	shared_repository = repo_settings_get_shared_repository(repo);
+	if (!shared_repository)
 		return 0;
 	if (get_st_mode_bits(path, &old_mode) < 0)
 		return -1;
 
-	new_mode = calc_shared_perm(repo, old_mode);
+	new_mode = calc_shared_perm(shared_repository, old_mode);
 	if (S_ISDIR(old_mode)) {
 		/* Copy read bits to execute bits */
 		new_mode |= (new_mode & 0444) >> 2;
diff --git a/path.h b/path.h
index 0434ba5e07..1188dc4729 100644
--- a/path.h
+++ b/path.h
@@ -145,7 +145,7 @@ const char *git_path_shallow(struct repository *r);
 
 int ends_with_path_components(const char *path, const char *components);
 
-int calc_shared_perm(struct repository *repo, int mode);
+int calc_shared_perm(int shared_repository, int mode);
 int adjust_shared_perm(struct repository *repo, const char *path);
 
 char *interpolate_path(const char *path, int real_home);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5115a3f4ce..ee92bd9c70 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -362,6 +362,11 @@ static int reftable_be_config(const char *var, const char *value,
 		refs->write_options.lock_timeout_ms = lock_timeout;
 	} else if (!strcmp(var, "core.logallrefupdates")) {
 		refs->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
+	} else if (!strcmp(var, "core.sharedrepository")) {
+		mode_t mask = umask(0);
+		umask(mask);
+		refs->write_options.default_permissions = calc_shared_perm(git_config_perm(var, value),
+									   0666 & ~mask);
 	}
 
 	return 0;
@@ -412,7 +417,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	default:
 		BUG("unknown hash algorithm %d", repo->hash_algo->format_id);
 	}
-	refs->write_options.default_permissions = calc_shared_perm(repo, 0666 & ~mask);
+
+	refs->write_options.default_permissions = 0666 & ~mask;
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 	refs->write_options.lock_timeout_ms = 100;
diff --git a/setup.c b/setup.c
index 0c6efb0560..03ff359070 100644
--- a/setup.c
+++ b/setup.c
@@ -2846,10 +2846,6 @@ int init_db(struct repository *repo,
 	reinit = create_default_files(repo, template_dir, original_git_dir,
 				      &repo_fmt, init_shared_repository);
 
-	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory(repo);
-
 	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
 		/* We do not spell "group" and such, so that
@@ -2871,6 +2867,10 @@ int init_db(struct repository *repo,
 		repo_config_set(repo, "receive.denyNonFastforwards", "true");
 	}
 
+	if (!(flags & INIT_DB_SKIP_REFDB))
+		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
+	create_object_directory(repo);
+
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 

-- 
2.55.0.rc1.722.g2b3ac350e6.dirty

