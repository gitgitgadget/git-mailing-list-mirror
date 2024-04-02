Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4D15E5C1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093978; cv=none; b=L/fkrc/+WM2xmYJ9MJdchosVDZqliICU4ZDm2UNCtFYZosksWs6drM+TpDZR/p86FGESJezxXsJ6NOJhuq05omLtOHfoZpQaKGm2aClXQmZN7pa17nHZpYNVBaQ1VEJyWDj979w5ucQiBCs8K+hqtDmCSlTVHsbaBLPGSFivKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093978; c=relaxed/simple;
	bh=4C7sF79WqnGeUGrcvNAPmsuOOAq9+ZbaxuFy7EcvxZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTtay1RgX6YbWyrhMboz4n7Ul5UWxj9rINBbHKoMdi2RmOXAJ0C+T0W6f3fm2MhXdYhAua+1IQ8I2TKZIwzsvP1MScDZH5Wxn4YcGqDSpPKc7ygevQs6fkSxc/OuQ7KpfCr4a9Kew0KuF2pZi6p7chN90ZMk+g9WQSp0fDuurDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOXf+w8X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOXf+w8X"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e223025ccbso24970515ad.3
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712093976; x=1712698776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUxAgg0pFHdF6ABLH0aTEq149qQII/y7ifo1P+qk2xQ=;
        b=aOXf+w8Xy2CjXDRthWFgKPb5tL1/VFaWg6Ax+rG92qPxhsC8ZMbxnUJqR4OTQdp+MS
         WNSiZorV2N+vfvZpUG/oYbxTSf813bh+ThbhNs+BKExE2gs8WYmiJ1A9vFS2BB7mtLky
         OO14p2SIw3g6z1MdlCEsq6cl1W1MrqZ90gq3qi9exZnxXyOMBwYR5gY7SRwRsnRR2usJ
         0bdbvilU8gs3QJ6L6zYrCSTJnRmbGpbzwKfFGGIXTkJ8Brvj9zOcijnqNbFHTXBUcW1K
         QxgHgYMZE4yoDhAjuIO9Nz/KRzmwnDvKE+NuLhHzDqDaiM8BOv9S1Asd9ET+YltDggy1
         Cisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093976; x=1712698776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUxAgg0pFHdF6ABLH0aTEq149qQII/y7ifo1P+qk2xQ=;
        b=U51QFcbKjuhVmYJpyG9TuVlOLs+QcJoC0bCHS6Cx4hSs5mj+P2Gun84JKeA3nwM914
         S9WgwGsLd5G3iT6bxTEj9zd6ZqMPEtLij9GVEIyntgmFH9bqBys4jfL97NBfrZtu8ikt
         ScTo9p+cwbh8FnY5P3QUsVHw5wsFxZ4wiJlxHEnBBBOEHBAn+dOLq+NnV7EO5xWUTHNr
         rVRzobQj7NiAOoGOKk/ufSb8oWVm5HZEkkvP0K12Ug5CMWLIrW3Ut/tPVKDcVBwopjdD
         1ltm3bAdjMQXfL6FsTBG/ofpgotupuakx+jDbarZ7tsWEnGnst34WKOLMfnS3TSd0dv2
         aoMQ==
X-Gm-Message-State: AOJu0YzZOBXhqBAL0YMnheGX6AaBF3KieTdKEJA8chJHRFTHvk18Zc0H
	cVFYixBlMHEiFZL1efGeJKafIydxlucX9hvWECwco7xBjasR7P1ycjvHa0DK
X-Google-Smtp-Source: AGHT+IH4UEqnG+E58EipYRYCj3WUzEA5V3Q9LonHo6LsegzKVAbhnk3LcldWtD9TiJeJwe4xx9NUvQ==
X-Received: by 2002:a17:903:94e:b0:1e2:68c9:e390 with SMTP id ma14-20020a170903094e00b001e268c9e390mr3810157plb.47.1712093976340;
        Tue, 02 Apr 2024 14:39:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id az3-20020a170902a58300b001e1071cf0bbsm11641513plb.302.2024.04.02.14.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:39:36 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 3/3] builtin/add: error out when passing untracked path with -u
Date: Wed,  3 Apr 2024 03:06:26 +0530
Message-ID: <20240402213640.139682-7-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
References: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
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
collect the pathspec matching information and report the error and
exit if a pathspec does not match any cache entry. Also add a testcase
to cover this scenario.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 builtin/add.c         | 11 ++++++++++-
 t/t2200-add-update.sh | 10 ++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index dc4b42d0ad..88261b0f2b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -370,6 +370,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 	char *seen = NULL;
+	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 
 	git_config(add_config, NULL);
@@ -549,13 +550,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	begin_odb_transaction();
 
+	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
 	else
 		exit_status |= add_files_to_cache(the_repository, prefix,
-						  &pathspec, NULL,
+						  &pathspec, ps_matched,
 						  include_sparse, flags);
 
+	if (take_worktree_changes && !add_renormalize &&
+	    report_path_error(ps_matched, &pathspec)) {
+		free(ps_matched);
+		exit(1);
+	}
+
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
 
@@ -568,6 +576,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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

