Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2652E653
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drxc/S95"
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A620818A
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:47 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c83ffcdbe3so49004711fa.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058825; x=1700663625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXjSLyezDw+VbVROY77kA+o1krDhTHXoiLhpC+E5xkQ=;
        b=Drxc/S95NY80GuCSNmMUhRwHv1nY39nniDlm8drPoXemNIm/BcL7hiGb/J2SW34BDm
         0151OwgaUEM/H2sbESx6nW4CgqWjXocWgxO5ehHOTrbgCZl8px651+VCVActbulp6gqH
         k2No8IcBk4wX0P/m5hCqzNVpmGQxxkaQ1FCmF2MAPwvbECFO/L6W7KFh7YyEEAm84dYf
         G6m9ZsYHa503pw6OzLgRNTtUTVPzL0rUjqRMIPXqOAHVS1kKRVlj2TAfes7iOWduX+DD
         XK/136gPIi7s7T2Zs5x+/DbX1MfosBkZlppChi8lUQAA87XR5XG7VTkLs7RI9fdRHzwW
         /o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058825; x=1700663625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXjSLyezDw+VbVROY77kA+o1krDhTHXoiLhpC+E5xkQ=;
        b=Z4kNsXbXYREcyjHYxQKgSJfaJqtDYyxNzNn9e/nSHcfxSHSawGXVCoWKIRzrmePO5+
         KV0YZ+zFs/MZdDe9slx+cdloNo0Hipx7zJYLAVZk1MDIDqodjsglzECxxuF84Hxjog3M
         Ut1XpJ4KBB78TE6i0cLiMUx1/WPU975DmpzfrwizoTqn1L0Aguh26I0X275+nNTNMhW3
         +nJ9xaEQfBmT90BfiTSaVvgPB2RnXRfeSSxTqh1DpGdRtrcwGJsartL5tao+UHH+RT80
         Ur/681GtClsuPIZc4KidXZcA+XFSDVxUHrCrVhzD0iMP4+83vf5NDu8J4POYXh5udPnz
         BT6g==
X-Gm-Message-State: AOJu0YxgQR7TTEfDsufe183SbYLoFhh3+FDWt4yHUX4rsTZD3+U6bXGn
	dQVIYNRA3qXWatM+ZAJKtAzBZ/fK5fo=
X-Google-Smtp-Source: AGHT+IGU4PdAHnQ9yyDOPFUuTWC1WJ0kDZk4B0JM7P+HzQU2w+NOB99WEvpmdlYPZCJf2vtxqtao/Q==
X-Received: by 2002:a2e:8512:0:b0:2c6:ee98:de83 with SMTP id j18-20020a2e8512000000b002c6ee98de83mr3992804lji.46.1700058824715;
        Wed, 15 Nov 2023 06:33:44 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:44 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 01/14] t6429: remove switching aspects of fast-rebase
Date: Wed, 15 Nov 2023 15:33:14 +0100
Message-ID: <20231115143327.2441397-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

At the time t6429 was written, merge-ort was still under development,
did not have quite as many tests, and certainly was not widely deployed.
Since t6429 was exercising some codepaths just a little differently, we
thought having them also test the "merge_switch_to_result()" bits of
merge-ort was useful even though they weren't intrinsic to the real
point of these tests.

However, the value provided by doing extra testing of the
"merge_switch_to_result()" bits has decreased a bit over time, and it's
actively making it harder to refactor `test-tool fast-rebase` into `git
replay`, which we are going to do in following commits.  Dispense with
these bits.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/helper/test-fast-rebase.c              | 9 +--------
 t/t6429-merge-sequence-rename-caching.sh | 9 +++++++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index cac20a72b3..2bfab66b1b 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -194,7 +194,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 		last_commit = create_commit(result.tree, commit, last_commit);
 	}
 
-	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
+	merge_finalize(&merge_opt, &result);
 
 	if (result.clean < 0)
 		exit(128);
@@ -213,9 +213,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
-
-		prime_cache_tree(the_repository, the_repository->index,
-				 result.tree);
 	} else {
 		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
@@ -228,10 +225,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 			die("Failed to update %s", argv[4]);
 		}
 	}
-	if (write_locked_index(&the_index, &lock,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		die(_("unable to write %s"), get_index_file());
-
 	ret = (result.clean == 0);
 cleanup:
 	strbuf_release(&reflog_msg);
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index d02fa16614..75d3fd2dba 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -72,6 +72,7 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 		git switch upstream &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream~1..topic
 
 		git ls-files >tracked-files &&
@@ -200,6 +201,7 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream~1..topic &&
 
 		git ls-files >tracked &&
@@ -277,6 +279,7 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream~1..topic &&
 
 		git ls-files >tracked &&
@@ -356,8 +359,6 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 		test_must_fail test-tool fast-rebase --onto HEAD upstream~1 topic >output &&
 		#git cherry-pick upstream..topic &&
 
-		grep CONFLICT..rename/rename output &&
-
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls
 	)
@@ -456,6 +457,7 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
@@ -522,6 +524,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
@@ -624,6 +627,7 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
@@ -682,6 +686,7 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		export GIT_TRACE2_PERF &&
 
 		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git reset --hard topic &&
 		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
-- 
2.43.0.rc1.15.g29556bcc86

