Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA64746B6
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130009; cv=none; b=eEXHPkbV170NC5bSnmeEctFmP6cuN5qpfLme9plGve2qeCt6k7EmLnxcA8qxm/WE3/X8UWWpBV0mazfrq3Eug7++UdrurnGG5kNHAeqMiUz/rDrQAYHIaiCSp+8XFls99Y6L81MDczU4IkRJ1rtyWbyHMLNQ7r7ECH4CH+rVK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130009; c=relaxed/simple;
	bh=j286SaUGxZO+TdpQdYPqb/WDquds95TS72Lg8KqhmH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2HdxbxGH4Alatxpkrc+I0qb2GHucbKPFRr7kaUdb05v2vb4mRm9G7Hfv2qA5fofplkJ/djOzcB67N+7wkFhFsmZEyOFEgzcz0XweiMdLigrC8pcR+3Y2R2WNO7FFMBSHaO0B/V1PFdXXRL5jtXIlLVGJ5F66MU22YJUlzlquFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo5shuqG; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo5shuqG"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c744a00edso623852d50.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789130003; x=1789734803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGcUh3hmol88G7LdJdisaci/NDkHdFviBBBVttK7UsY=;
        b=Zo5shuqGAic4gCCr3en0+o42lXinfXXdkT6xLEeajtAxADvVEqd67v5Cjfk1rvdH3f
         w8a3Ljgwl/u02AAkqQJ4l79prH3/8oMHBnhCZ6L1cu/iZas6GuaxUXE2wyc5kTMH5/vk
         wxq8yjImyugxG7NlHo0GFZ/rTmpvdcOS5XyqFP/xykpk9om2ORpK0jMiKH+iZib8neHF
         BqkurP6+JMSQGs61t/TutMGXcXB5y+k/UP8+uihs7053AZpiDG9D0I+WN6549MZsoHjK
         qrDF6l6iRJ8FKQ9KytQz9oE55qhpzHJyWzFGOnDjcFdCnH2wu5QEScq0XRxniD72dQzh
         O5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130003; x=1789734803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGcUh3hmol88G7LdJdisaci/NDkHdFviBBBVttK7UsY=;
        b=e2vEJnCPPGsWmR0Cge+W8fpMaScPR6umeTaGlG4JnjEUwo0/8jrWF9LkDMtxqdHh2O
         uuJ41rttB/Khs7+T0fBm5db5D/4aGIt8IFmxaPDGWrgHX9oPuvm4QF8C0yH8pUcrbeB9
         gkWCDwkgIavPIr96ivFTFNiwLd4VuAT4l/Or+BiSSXhMzz5DfDEwZA/R2aLngWfh3bgy
         DV46DAZpiFMLGyY1SHRfFEcCNI/D0VfHzXIytkX/ZSTrNhMBsPtdYSyq2pbXsCmZ6M2G
         IAjOv83tcfWNLQUKvL+amDlu2VQp7CF8VltpY6LetFRjYQDa7NLnSO5MCzgUQ6nlfzLs
         yYRw==
X-Gm-Message-State: AFuF++nlgWyIpeYGhsOb5dp4zMEBHjRx1OZMsTPwEwGGEBfo00gW13Jc
	Ow9qHwGSkuOtt3QYJ91bHRgMHeXjWrTd48f3EV0tqfmfPYSGD3rhrf/raPcBAw==
X-Gm-Gg: AYBFou0/hDHNXArFzn0R/NDZWpiloyHWO5bYiVKwfiq399j4p+rICCy0luPI8UysFRT
	iCwsqH5KOKEoQPe+pBxgIbIJhHkNN9bUU0aW8gyrIiqZhovia79Z52k+sD4LkTA1V9JPQ0bAxIq
	MZ4iwcDkfH4DWK/tPX4AW8TNEgnbV/FI3B9Xr8zk1oldMcwkIg4QcfPiewbJjsP2Vu5D7uDd/Uk
	5xUNaAFSzI0jycijr9TwQdrnBAZI5lqBl7RahABWFONa9tROTcxnyq1G+whfAdRlFwIftJZoiLI
	0k+y7iRIAgBsNbCNJPsndNm8Y078l9KTeYtkSNehaDElYs4/CxYUVgZ5S1E333fq3h04PbN+dyS
	3cexTTO/ffXgrVCWAP0NUMc0Sh4bRGU/qtLaQm3o3PIFtl8FunYmiScwvpgjqxPMo2f2VQcIW/G
	si2SjpVOhhcZsHiZ4ra3BT/jChAw551x5KU3JVWKBHg0CvryC6TOD2TywzXAPFBkYb+YkJJJXmw
	XDa3d80LjEDZX//EXYuyS0UaY/0GLNsYwViBK2/XpbJjzRNZph33N6Qz3hsfDlDHh/dx2zFBAZG
	Ebm3lgBuMVr/skPGySftOKBUJ5EXyAD8
X-Received: by 2002:a53:c54f:0:b0:66f:c1be:a65d with SMTP id 956f58d0204a3-6712472b813mr866761d50.79.1789130002200;
        Fri, 11 Sep 2026 05:33:22 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8848701e82fsm9785247b3.22.2026.09.11.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:33:21 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Tian Yuchen <cat@malon.dev>,
	Junio C Hamano <gitster@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 2/3] environment: align repo_config_values_init with struct declaration
Date: Fri, 11 Sep 2026 08:32:28 -0400
Message-ID: <12974e07d088c1621248296d08b6583c568ba4cf.1789129924.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699.dirty
In-Reply-To: <cover.1789129924.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1789129924.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of assignments in repo_config_values_init is chaotic and hard
to follow, especially with the definition of 'struct repo_config_values'
to ensure all members are initialized. As new members will be added in
the future, make it easier to validate changes by aligning the two.

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
2.55.0.1003.g10538fe699.dirty

