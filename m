Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735E3C38
	for <git@vger.kernel.org>; Wed, 21 May 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816560; cv=none; b=G05pLD5pPeDkb5jjbIOIEBPLilqZV0VIWWcO0dunCpz2BUU0YsZeQuRD8Y+n4HWWkPFly9cqC02FydRxY3LqF5XV7OrS70m0PAUu3onkf9k+fzEeJtWSUHRq0MaFevUep0V3qDrwvY0phlFGfvoQdtKyrTEWrBchbW/blmZi40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816560; c=relaxed/simple;
	bh=XT1WRk1bUn6WQVkwCQrF7nrSZWSgWT0G6OBKZqJ0/is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSk/8r/Q2BGq2+2AWR1aUAxq+cj5oOoIpl7tOcUlpGgS3/c+my+XGVzmKyAapdUI5SsH5N1wL0fwGxn9wECRbRr6eAAlH9ObgB2kEZ8zJzlL9lkPA5yoUGUdTBXwCeFLsKFEpCcO6SH+wPplnl7ixgJv4A36gnz3d2s0rui3W/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=djaZ2oa8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="djaZ2oa8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231e011edfaso55381145ad.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747816557; x=1748421357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DfBw3b5oC0NYRKdhBQPRiQBT+rBZmSG4c+kldbnHcA=;
        b=djaZ2oa8hdKu68cxlXNMI0ksPg2oSxkMPBfp4t8tRKwY3n0y9r+eovSO4tXEB3FC3o
         G5FTiShCOnYiGxtY2HK9ThySYnVlwJ9eBYlTBAhkwmGRN/AtUtzLh8NL+THXA670A5AC
         IyshPefzLozqv8fIvElBAHRS5UbZhkAY/4QMyoWGN5vH/F7gfn4hsElKKuTCCoLa/n8Z
         3hw1mKdyX35xdjc+Xfr+ZYrYw2dTCIiJa+mK7Y3pQJCiMlHqwZFg6vGZyVNEzVjXDSvG
         Nn8gHM8j0Yx7OIA1SvKE63AfARecOvT5ftzAQZqepd4MqycLkYKM3G/YMTwXHDUFQ8xN
         af6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747816557; x=1748421357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DfBw3b5oC0NYRKdhBQPRiQBT+rBZmSG4c+kldbnHcA=;
        b=lUL77doOXIAA+ZVeL+5LMkoFdjIygTuUcFg0NTUpNyIH2V5md7argzmC8yFoU1lIEP
         gsjN1wuAHCoRW1nAxdJKMYH2C/T86tA/wY6dpfX3gEvdVMavSvvPJbdbcxoKMOB9Lbov
         u9yP1PnudAYkSmcJiYrhs/0cd8zmtq3JqI2iLQDP4rQ+aX63slca3WRlrkXAXcX+cLU3
         uZRkROjSOfyUup8FEM7eeQ953pQhpHSsc1OBC8U4XvJ/UGEsOhsW4ySwNTqf4V003ebA
         0JF8ShNVw9JkuF6k9V90dKJQ8M2MthhhNNzLe8bZtK7MwEFd1ErBf9W+4evRIffHsLYH
         BkEw==
X-Gm-Message-State: AOJu0YwwOT6jcmUrGLDI6QKcvEcJ5/Wfew5U9PnKWCzqgGivzhwJyoDt
	Z4wLEENAPcE8oqwS/T3IT4cE6NC6M4gZ7e3hYOEZtV4d3sTeR2rFYNEa25EtghHOV04ec+xAy2l
	kxw2H
X-Gm-Gg: ASbGnctVQQ4LSi4XbgXCMH8Qny/izBs9FdiRQRa+oEjrz8xEe6+7zANE2qMfVSRFZRs
	mfwIhvp7DkU9mV//Y2ZOtCdUXpBcSZhJM5ymQa+qmy/XY5Hrocc+MRi+OE35W/4s35Qbn6JwgVn
	/F/LgjIA+0Xacjwh+l6ISBMr4KAAIsD2IP7xnvehOoY0WPJ4wMM7GntIHkmNHsI+yH5lgVfXfl5
	eCgbxpkctGDoJUJ8IUD8Ooad1gYgFNGcI3Rin3j3vtw9VyIVexXIFKZ5wWns+uQyo9OwogvBpEU
	nGaKh83QB757xOH5e8qPrVxlWKCm+0PueuWgmB7NFW5Wdu9d8kIYCJ2BWM7haa93FNaY+ursfJF
	Vq6jd52Lu
X-Google-Smtp-Source: AGHT+IFLQynJGRrQ5wBFs4I4TddcF0iDH/ThJ0BoYFPU6WpgdTsFwB9XJBCjheNhHcWtjNCUBVF48w==
X-Received: by 2002:a17:903:32cf:b0:22e:3f1e:a106 with SMTP id d9443c01a7336-231d43dc9bcmr290099905ad.5.1747816557408;
        Wed, 21 May 2025 01:35:57 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231f04e75bdsm78308495ad.216.2025.05.21.01.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 01:35:56 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 2/2] read-cache: unify write index error message
Date: Wed, 21 May 2025 16:35:21 +0800
Message-ID: <20250521083521.6552-3-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521083521.6552-1-hanyang.tony@bytedance.com>
References: <20250521083521.6552-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are ten uses of "could not write index", two uses of
"unable to write index file" and two uses of "Unable to write index.".
Change them to the most Change them to the most common phrase.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 builtin/am.c         | 2 +-
 builtin/commit.c     | 2 +-
 builtin/merge.c      | 2 +-
 merge-ort-wrappers.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e32a3b4c97..69f24df5c0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1816,7 +1816,7 @@ static void am_run(struct am_state *state, int resume)
 
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL) < 0)
-		die(_("unable to write index file"));
+		die(_("could not write index"));
 
 	if (repo_index_has_changes(the_repository, NULL, &sb)) {
 		write_state_bool(state, "dirtyindex", 1);
diff --git a/builtin/commit.c b/builtin/commit.c
index 66bd91fd52..f60f85ea36 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -415,7 +415,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				repo_get_git_dir(the_repository));
 		if (cache_tree_update(the_repository->index, WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
-				die(_("unable to write index file"));
+				die(_("could not write index"));
 			if (write_locked_index(the_repository->index, &index_lock, 0))
 				die(_("unable to update temporary index"));
 		} else
diff --git a/builtin/merge.c b/builtin/merge.c
index ce90e52fe4..876a2e04f3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -736,7 +736,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
 					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
 					 NULL) < 0)
-		die(_("Unable to write index."));
+		die(_("could not write index"));
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
 	    !strcmp(strategy, "ort")) {
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index c54d56b344..666ed27437 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -128,7 +128,7 @@ int merge_ort_generic(struct merge_options *opt,
 
 	if (write_locked_index(opt->repo->index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		return error(_("Unable to write index."));
+		return error(_("could not write index"));
 
 	return clean ? 0 : 1;
 }
-- 
2.48.1

