Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75501534F2
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168401; cv=none; b=e+BiTAdvk/j5u6c6X0PUUzyI97qfcRTMZ965Db6XiEVD3gGPQOeSIrXIOtk2GLh0jdFS892Lo5u6XISx0Wn/WCCaJF7135UaeD3NzvBTPNzTh3gz4A1Gv2cOGoAx4ihzIxXYsUUPrpL8dC//zr78gBYJwPoIHnm4yIP2kejhHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168401; c=relaxed/simple;
	bh=ESmU9tfPvg6Kw2UMM1WcI3ca+tQBJe8qfRDveDq6pTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKY7hUGYXW0U26NoCIbs25SI+fR0AXM8iPQ0Dnq3rOOjFyD9Ya42vWHOyjc6k1bNxDI+3mqQhPg80CaX0iM8fwgv/+soy+LC4RBeGS17+2PwwM/bmz871mCnoaZOqGv5H7jubs/LZJM3pSsEu/+zkpx1w+9vhSY6P3W5jFoaNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIuhN0JC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIuhN0JC"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1def89f0cfdso9880655ad.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712168399; x=1712773199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKQ3uX4nE2tPWHe4KN4B4eb12Y+RutE5nRhQrpfioMA=;
        b=EIuhN0JC4VtA6wLukOJk3M7YOv08zI1BkyNT7lI8lLAyB7XeYyUpt1PNQxgmrmLaWz
         ihRwW2EOObHnnRz1iFd088Kf+o1JXC9bNBsMWlX+3F07Yn0E8T4KbeFjXVx8/4TfbUWC
         xn6hmQ2ZWAwwVbaadw96aZrrcQen4q+xzMDhnPVhCuQtclPoqcD81re+fzlwic+VBVaj
         ePsyA7Ockp+MVJYhh5F/P4XoudbIjL8kyO8AxdVskxAaTKHNHnrJxoSViZuowURFV3n4
         euW8BYJ+iFBV2Yy5mznq10wM2SpeuFvaLDsDEVuLf8EUyiPWkwQP6/5E9C+YLMVCM/w+
         wktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168399; x=1712773199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKQ3uX4nE2tPWHe4KN4B4eb12Y+RutE5nRhQrpfioMA=;
        b=HKv3kkTl/9GFTk1hnmedDXk033pTS+oYuIWQI+XepGz18tILkAifAvVr2ql6cuwPhP
         EAAApSD00LWDlQm/m8kRwH4sx5r6SAuPLNuNCZmObf4fDGZKtvmhWRkV43n1rUwjjVRK
         qemY4gNs0rTe0q5DFRtqVLH6f3ndIaJPoOvrUJBmzi/gPdUDLyPuNhSnghx/ZGiTtPHx
         LqDtr0ulRwSdSMG99lxWBqdjWYh+D51M8A4XZdKH6nW6MAxj0oMuCsUU1Ax07Ye8sP4C
         fm6zG4EO/rsJbbqImPHSScLAp1IO5w/XcQ9ShThDfWPNj98GE6DyF5zWr+4Ei6AItRTd
         MlCA==
X-Gm-Message-State: AOJu0YzgkFaOBtEh51viURs4MPn0bxTjihCyBfKkJ8uEDNIdSGqt4Xzi
	oB+k3wkVJWwvKVfT/ml5oh1o8P2eQW9xMSjMqTVACKvgFJYqp85tBxypZ3aq
X-Google-Smtp-Source: AGHT+IG/HFYZckBqZ4dsch1CzOP4HcivYMaTd9MxOc/lmnlZqVdvXpIu3M/HA+XnFEKPhr8OOX1Aiw==
X-Received: by 2002:a17:903:2b08:b0:1dd:a3e2:de77 with SMTP id mc8-20020a1709032b0800b001dda3e2de77mr750945plb.20.1712168398479;
        Wed, 03 Apr 2024 11:19:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903120b00b001dddaa7d046sm13661758plh.29.2024.04.03.11.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:19:58 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 3/3] builtin/add: error out when passing untracked path with -u
Date: Wed,  3 Apr 2024 23:44:52 +0530
Message-ID: <20240403181531.59505-8-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402213640.139682-2-shyamthakkar001@gmail.com>
References: <20240402213640.139682-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When passing untracked path with -u option, it silently succeeds.
There is no error message and the exit code is zero. This is
inconsistent with other instances of git commands where the expected
argument is a known path. In those other instances, we error out when
the path is not known.

Fix this by passing a character array to add_files_to_cache() to
collect the pathspec matching information and report the error if a
pathspec does not match any cache entry. Also add a testcase to cover
this scenario.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/add.c         |  9 ++++++++-
 t/t2200-add-update.sh | 10 ++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index dc4b42d0ad..1937c19097 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -370,6 +370,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 
 	git_config(add_config, NULL);
@@ -549,13 +550,18 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	begin_odb_transaction();
 
+	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
 	else
 		exit_status |= add_files_to_cache(the_repository, prefix,
-						  &pathspec, NULL,
+						  &pathspec, ps_matched,
 						  include_sparse, flags);
 
+	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
+	    report_path_error(ps_matched, &pathspec))
+		exit(128);
+
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
 
@@ -568,6 +574,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write new index file"));
 
+	free(ps_matched);
 	dir_clear(&dir);
 	clear_pathspec(&pathspec);
 	return exit_status;
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index c01492f33f..df235ac306 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -65,6 +65,16 @@ test_expect_success 'update did not touch untracked files' '
 	test_must_be_empty out
 '
 
+test_expect_success 'error out when passing untracked path' '
+	git reset --hard &&
+	echo content >>baz &&
+	echo content >>top &&
+	test_must_fail git add -u baz top 2>err &&
+	test_grep -e "error: pathspec .baz. did not match any file(s) known to git" err &&
+	git diff --cached --name-only >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'cache tree has not been corrupted' '
 
 	git ls-files -s |
-- 
2.44.0

