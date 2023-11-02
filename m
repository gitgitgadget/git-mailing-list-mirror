Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF011724
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilKSvbqZ"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADDAD7
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32daeed7771so435310f8f.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933129; x=1699537929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp+BtVj4iuer46GYfZFMjIzxrpFo8dm6uXWQ1nfzX44=;
        b=ilKSvbqZSI19LP3dgXCsNsH9bKQVzeI28zzgl34DbSgC02TJY7EQ0VrM54wB9n7Opn
         /87M6HltHECQ2sl3Sq9Svz5TSeiIxqoeAX23z5B7vJpjmHONyx1Fc9sENw/tyfcjBzgO
         AbWJ2jnChCfwCQFkB2ITLdvZsIQETa7TFrWV45wTdMT2Q4veCcscvOz78Be5sagQR95T
         MrhAo7ScJDeUNGLHdBVzHHBRNDqF3GqW60zaDvFBuax4BhaiYZkGJ6rMkl3vMKDPr0qL
         /b+oeHuvqgPZ9ScNoU8oTczxOH84bFXLWymhddSJmrgdQwtAL7HzywSnV8X44JUTcs3s
         ayEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933129; x=1699537929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp+BtVj4iuer46GYfZFMjIzxrpFo8dm6uXWQ1nfzX44=;
        b=XgYoWCW7ymonFyX9UJi6EPLN4O1ctXY9G3MmCPe7dwfo9fpIVKYRwE0FHe0bEwPMEC
         3+mTiOw4WKSxF3xCcYHS6n87lUYORGXX5FpypaXWgFOhpMOBbs8Ce9TzwKqekdae8i+A
         KRCOaIHIe488fJICUjZ1DaV9OKRY+qM1m67jjBJz6dqSF/LOqtFis7W9y45TXXMSReer
         M5fD8pPeqZYCwzURlBYrJzOozagwgceNssdS4+XMpiMSekDi9yZ99Q8QQY0LT6s4gS4X
         v92LYf+182qFIo2QmPxX2MZhdTaJx3yvXdk2ZfiAW8PWMdR3Jk+hfCL90Thtq9eZvA7N
         fdtw==
X-Gm-Message-State: AOJu0YwWDcblcMgWosYJBzYoXu5H+tvM4Q2TVbCvcpJT/GOPUQn76EWc
	jiQCUbjE6cTznzBJKQAEfkr85yxPaK8=
X-Google-Smtp-Source: AGHT+IGlVhJitx0SkW8Nhxoz8PD2JccvsFj6w6qUZ72t3TNQNnqQehGEcBRYuvc0bvw1fce4sAGkiQ==
X-Received: by 2002:a5d:4ace:0:b0:32d:9fc9:d14a with SMTP id y14-20020a5d4ace000000b0032d9fc9d14amr13037393wrs.12.1698933128923;
        Thu, 02 Nov 2023 06:52:08 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:08 -0700 (PDT)
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
Subject: [PATCH v6 01/14] t6429: remove switching aspects of fast-rebase
Date: Thu,  2 Nov 2023 14:51:38 +0100
Message-ID: <20231102135151.843758-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
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
2.42.0.496.g529a7fda40

