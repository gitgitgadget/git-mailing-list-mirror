Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E948D158520
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054964; cv=none; b=QNgjIyP9tBH+KSg5Bwq/JSOY7fvKhO5mDBJeXSj79gn40GMmjS+4f7ZQPmhP6/4XBVG4+glWztukCuTqraM5GHbpwpIrQHx5WgSQ37KjgpphOQFYuGkFNCCbgEvXfSjYielFpRHMsDeOVM8oZmCqYK+rv0ORnblui1CoCPv2N3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054964; c=relaxed/simple;
	bh=I8WM+KTcA9UTXEbZMBpPkw8ADde6bhwY5HUct9kFoQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdOQA9eKMXdfssUoQT4/oBEMvVsN/+UKz+tff7OazIGfHahg/QE/+sc9dHpXRSa0hoSaM5DM5L+fpBOQcTLTWgS9csbAZSXt6ZgvPcBDvGMRTM0Py51AcqlgK1j0bmrG4toOOjxxeq+shNcaZoVoO/B45l+Ynj0QgkCeXe2Eajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVoD8lij; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVoD8lij"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4a43e277198so31347361cf.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 23:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750054961; x=1750659761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQOc3JGMS2sq3XhrBUujZltRqa4JtjMAIZXyhaAAglk=;
        b=dVoD8lijri7l36I46ShFuEyy9tcCePqpwovShmns+9Ife5gPRNuztcnBQ7zyExmAQN
         NQqrtF+3zZJ062v5zBf4Zngz8R6YfuJF1leg7Vx/tj6iqBVNWQ38Kuawhx6/bnhgUEXX
         16gItyaxY3Z4DNeeIWBSe7jAyHZfD6ttbE5YV2mj6cs5uzi2o7I/jvFXr2zNgqZ9mPri
         GZWyTbr/1ptIeYXD2OcjpxWt6tSBzlByqhfUPiYNOQWSy1rxurbesP5ATv6VfH/XUgRD
         qpswC3YpUGgcS2iEL8aqylRH9+USSVZspDX/w3slEMoRoPxQM9bF/NS7RMJmjyvlGpV0
         bjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750054961; x=1750659761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQOc3JGMS2sq3XhrBUujZltRqa4JtjMAIZXyhaAAglk=;
        b=o1n05/gPgHmfK6txlKZqz9YnthQX92jBmQNhc0y/ZXVGrI8hM6c/NPiGXn6rf193MN
         AY0p3W5Va+34uOiOtv6TnFRjTp/ZzGUGFiWez7SZOVSu6y+l/fhBqPeRyRPPTVIdmrNo
         4dOzxpDxUVc3HMxUZikesxM0XfEV7bP0909/Hccbj5Shz50rp4uAaJijTuMUMn+61kHD
         QYxuyN7QJvYKpg2hyI9Kmr4unP17LJfjAqkPstVH9og/N12Ee9RUOd8L9In9ERn3+h3r
         OC1ewOP+T4p803/0MvKciUo1wdzBR7ZMSYzW2KOvncCtHroCdYQq36od11V967ccYfKg
         hWmw==
X-Gm-Message-State: AOJu0YyH7eJda9n0HOmBrBT4NSUpK+EH46HZsH3EbguJ5TM2x9o6bBcc
	LZMzm8Un9cjRX00Rz5oWYV0cuNG4GxtAxHHJkznRfOB+h47XTT0e5VQTbuYCZRK+VJW2R4/L
X-Gm-Gg: ASbGncuP3hM/gV0PW1oN+Yi3P5FC/udfuw/mONr2tIqXvpUR4OdXRcgRTCeenZzkMqZ
	HwRzHsrpB0Br4Yd3z7oTaRQtBmUMUSbqXjVwHIpPed741TjC60Bq30dwknUyC0zVRhKGDDdHXRJ
	gcoI7GQD7XBoXB/6vcPGGtp3gZKbZFgPwr1ifZT8D7nofGw7gFq5b4a+hSX0YoIQAuqdhE57FOr
	kR5kVi/pbKzGC6sTD0a/Hnnucs525wOHpAJuObDmMBZOtpVqWzXZw3EyUGCGZTmiIMU4rJ9cF96
	P97aB574hwABdDQ8jGOJQQ+9bAzvDW09Tj74AFJHC297NK3pOPm+qLzkZcQuEfabE4+E
X-Google-Smtp-Source: AGHT+IHQyr86WvomCSvck+PM2fiS/hzaJMoLoTxk8Hxrgks43bTgi8AhRvGaIFfXVJx9QVGRTT1MvQ==
X-Received: by 2002:a05:622a:14a:b0:4a6:e7f7:5742 with SMTP id d75a77b69052e-4a73c58fd3amr140500021cf.33.1750054961141;
        Sun, 15 Jun 2025 23:22:41 -0700 (PDT)
Received: from r760 ([188.253.126.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a4e717esm45761261cf.65.2025.06.15.23.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 23:22:40 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
	ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] git.c: remove the_repository dependence in run_builtin()
Date: Mon, 16 Jun 2025 14:22:33 +0800
Message-ID: <20250616062233.1589172-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0-rc1
In-Reply-To: <20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
References: <20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_builtin() takes a repo parameter, so the use of the_repository
is no longer necessary. Removed the usage of the_repository.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 git.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 77c4359522..8525ede550 100644
--- a/git.c
+++ b/git.c
@@ -462,12 +462,12 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	precompose_argv_prefix(argc, argv, NULL);
 	if (use_pager == -1 && run_setup &&
 		!(p->option & DELAY_PAGER_CONFIG))
-		use_pager = check_pager_config(the_repository, p->cmd);
+		use_pager = check_pager_config(repo, p->cmd);
 	if (use_pager == -1 && p->option & USE_PAGER)
 		use_pager = 1;
 	if (run_setup && startup_info->have_repository)
 		/* get_git_dir() may set up repo, avoid that */
-		trace_repo_setup(the_repository);
+		trace_repo_setup(repo);
 	commit_pager_choice();
 
 	if (!help && p->option & NEED_WORK_TREE)
-- 
2.50.0-rc1

