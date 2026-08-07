Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018E476693
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104105; cv=none; b=NIBmlMtkUMa7SZ2xyP+XOfWMT785JKMMVtq7P2qVpv1OCK/M3mEOmJhfillvptBScMZolgSOnWfcB7BKXui3g0POxosxLtwoxtvzK+U4FrPXhy8dwe4lA9OIzgut+H5QqV6Ov/Au76mpvDkVm89BhfayqTlghqE7e9xkVRV2pjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104105; c=relaxed/simple;
	bh=P9lyqRDYS1QH0rPFkm55g+QSflcEKOBxT/HS0iXZyGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV54n3pu2zi6gZh/uHOYT9Y9jw34O4mIevsOuGrXe1br3Gzbq1myg+8DopBY8cIGV4BNpJUcDKzoSjmIn5wOG3MGgf2B52thwnS5MU7oc4jO2twwdXybhWPZU+ljGjiSMYzgt077vgq/+Y/2Yq1i+ysHFHn8RLGN9cnF9/LCHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG7v9LpD; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG7v9LpD"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-669944f5ef1so3734820d50.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104077; x=1786708877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rf3UkFRNf+IZSnTQNglx2T8LmWyO7M9dd/ywnUD28Y=;
        b=jG7v9LpDCSa+gtrB+ums8ErkhCCWPnzrvtozzZUAmzlk6SaW6DAWPpBnTs6Iab9SoI
         SBH8eRQ1cKz+ubrr0LdBlXuqT1cziC4DjxViUiQ6WY+3QU66ai83KgMpa53vuavXoD2y
         1y07l7KIj4fpY7zQ4tzup5T+5zRcYVjXujDnr01CqfXEH3lNK6rdwjuF1Lvg4htpbbgP
         kEOuM5+UUgbDdCNVbB3H9L3/vtEvnpLfhl00+UqUFo/3ERNY2wXF/qpoNsaplEVvhFeZ
         shyOUuYW7exOSpdZnqdWLG6QC5CqTPGiCa5uycj0/e/C8h2TqCvf2/HxP/f2E9P5oMtQ
         HSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104077; x=1786708877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rf3UkFRNf+IZSnTQNglx2T8LmWyO7M9dd/ywnUD28Y=;
        b=O1THX/qWu6x99Nx5lpej3Vw0DSqy+llKwIcK2o4FH2CvGP5CwMiLzNloalJDmEMFsm
         wpKqEpTG+Nag93rHCQYMudAXkYfTFnWVmwyd6Jug1zw2N9HeLShj8gYguWpyRro4ZVf7
         WWowG3wMwXeBqpFCe5e1+IKKVqVX5V4uyqanAvBAyvoIpdvsId35byGR9jc4iOKKu4wp
         ycleIisAKasSnm5tOuRE9xMN0GYgoZJjkkNbd4yzqTfsNuAxhM//xoz9GUlqh2u3Rz/q
         EUYgJfH2RBDP/LAJjos86fu2vxsepM8xOw2RHOW3S41LlwjGFBX0jfh2JtZ26Vvak00P
         99nQ==
X-Gm-Message-State: AOJu0Ywyo1EHStznxTkBsl5TmlWcR8h7RvnCBxd+4/qKv4snozOZGnaC
	lbGV+1kK+PU/KN4rQsmE4g7gG2GRc/dQJyz6FBELOk6Ce8JMANGqrNclAUauAIP9540=
X-Gm-Gg: AR+sD12LP/GJj6ysaVf0m+7yQvuDyNCHQUUJ4ZdJsv14Ahnc2C1FfAkQN4pUs9gWt/u
	uYiCcQRltm/s36TWan1HxhLKPuo0ubhKsYT29HgEqn9QSwZqK7SS9blarRWw+QYz43C32lhC0Lg
	3LUbydt2dKLmUOZWhnPjOpXLJoCVrcUa987hmJfNEsK98rEobC21XM1jzeyNLV0E0OhkPFb8dDh
	LeJfQKv7YZ2anb61lrt1l7riEolirADPwrsBetS0g6NoxPc21F5Ps5XV2v7MctYZtxB5m20pNCL
	HO9nQobzMkMxMWyJvkUSDBjIQUfabZEoZ3K6ZWxDUkilF4q7H0C9xlTxAq8Nyqrkd/oFT+BoGZZ
	pWeTKGvI3orQA2QmXmKjN+hPcTpmjNQEStfFp1SYWIQ0zbTAMh7lhpsExQGQ1h4mVMUaWbqmxEq
	+YBuPG5KyWXzXNqYmsdpRVObiV1HnEjTE/SqUAEzJEG/pFrPO7wNAR5ujOoucyufQOcwXNEpSNF
	21JVrorzNo1VPjxGb5wV2RkrMVWksF95nazQO7Strv6SGE1ziz5NoFAPAz3fEIYfoWvR8cghcIR
	gtR6fszDqAo=
X-Received: by 2002:a05:690e:454d:10b0:668:1c55:4283 with SMTP id 956f58d0204a3-6699ac3f688mr10297874d50.49.1786104076494;
        Fri, 07 Aug 2026 05:01:16 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acae63149sm1048042d50.11.2026.08.07.05.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:01:16 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH 2/3] environment: align repo_config_values_init with struct declaration
Date: Fri,  7 Aug 2026 07:56:25 -0400
Message-ID: <5693baa9923afd20333c0eb016cc5949f8dfc423.1786103607.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.340.g8e2bf96aa5.dirty
In-Reply-To: <cover.1786103607.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of assignments in repo_config_values_init is chaotic and hard
to follow, especially when comparing with the struct definition to
ensure all members are initialized. As new members will be added in the
future, make it easier to validate changes by aligning the two.

Refactor assignment order with no behavioral changes.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 environment.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index 76ee65e62b..6676e6f5ae 100644
--- a/environment.c
+++ b/environment.c
@@ -745,6 +745,7 @@ int git_default_config(const char *var, const char *value,
 
 void repo_config_values_init(struct repo_config_values *cfg)
 {
+	/* section "core" config values */
 	cfg->attributes_file = NULL;
 	cfg->excludes_file = NULL;
 	cfg->editor_program = NULL;
@@ -756,20 +757,24 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->autorebase = AUTOREBASE_NEVER;
 	cfg->object_creation_mode = OBJECT_CREATION_MODE;
 	cfg->apply_sparse_checkout = 0;
-	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
-	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
-	cfg->ignore_case = 0;
-	cfg->trust_executable_bit = 1;
-	cfg->has_symlinks = platform_has_symlinks();
-	cfg->branch_track = BRANCH_TRACK_REMOTE;
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
-	cfg->sparse_expect_files_outside_of_patterns = 0;
 	cfg->warn_on_object_refname_ambiguity = 1;
+	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
+	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
+	cfg->ignore_case = 0;
+	cfg->trust_executable_bit = 1;
+	cfg->has_symlinks = platform_has_symlinks();
+
+	/* section "sparse" config values */
+	cfg->sparse_expect_files_outside_of_patterns = 0;
+
+	/* section "branch" config values */
+	cfg->branch_track = BRANCH_TRACK_REMOTE;
 }
 
 void repo_config_values_clear(struct repo_config_values *cfg)
-- 
2.55.0.340.g8e2bf96aa5.dirty

