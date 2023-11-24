Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdnnSasy"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25AD59
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b27b498c3so13185535e9.0
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824262; x=1701429062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyARrhbNMdbjF6Nydzy3xGG02enBBLS34RELcHQzCpI=;
        b=cdnnSasyX245XiLE2yPBF503wPvyXXYz5bp8QF8oRViq4M3vk7+FOPxmXb1uSPzLBA
         J7aPYTZMQkBNaFW2iVrSR78R7DneIlI+D0JbwWw0VFCF2becrqvPSKmlmor+REo3uKrS
         fKo8iTt0FehTsdwkI50K+JwL7fgbOvgijzgwRdpgN88LJuYnYJ0i7rRdQxC2lmM95ARo
         e5hW4pwizkKiuNAp4jbYvYHfqjWzxjW2hh4NBOx1h8ywji8ukmNtbNlE/8AjFTDK+2hU
         GOlvOKpfSF/tcDUK3Bi8OS4/j6bKDduw8espMiqs9Y5+f7PbjKY7Ipc0e7V9xXvmWV8R
         nq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824262; x=1701429062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyARrhbNMdbjF6Nydzy3xGG02enBBLS34RELcHQzCpI=;
        b=b0Qp8K7BSYgjwIkI4E+pdH1lo0DVcOVBxgoiSKBdpcOh8esIb0qHCo5jIppCdMtjkg
         fouZx02rNPlFrfFu5QgCFFbNt78toHox3u5qc/k+hXzTk1gT05LORz4K6F8MKZT0Fs46
         u+0IBmICd231TYMBwWQHfr7Hw9fQkqdcLNIFHozY5iK8I/gnRc/jmvyZUYVpX7kbEHar
         SSyM+IIUguWmYPXT7MoYqNHS+6jo7ujR77uPMk37XYkw+i4Uc9BDe4Syhc6nLZ4iNDeH
         jDGmhpweI7FZFTYb6qt0D1sG2jY8PTRhpieXMBvpWHkJYocui8LpBTrBO9iKfW++hhMf
         Nv1w==
X-Gm-Message-State: AOJu0YxgIrKQt76Qio8KhTHLK+mjNhzNPh3EzOKJgwiPZmdHClz6n1t6
	py9pCKJK9iIhlClds5oOX73sQWANdpM=
X-Google-Smtp-Source: AGHT+IG6t59U7lf5A5ntm1IQ1X+MeJLquOJlSrZct0n1yjV7lcFwm+0y2UbiHxxMH7gzWQGVjqu5Dw==
X-Received: by 2002:a05:600c:a06:b0:40b:38a8:6c65 with SMTP id z6-20020a05600c0a0600b0040b38a86c65mr2052092wmp.26.1700824261729;
        Fri, 24 Nov 2023 03:11:01 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:01 -0800 (PST)
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
Subject: [PATCH v8 01/14] t6429: remove switching aspects of fast-rebase
Date: Fri, 24 Nov 2023 12:10:30 +0100
Message-ID: <20231124111044.3426007-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.14.g93e034faee
In-Reply-To: <20231124111044.3426007-1-christian.couder@gmail.com>
References: <20231115143327.2441397-1-christian.couder@gmail.com>
 <20231124111044.3426007-1-christian.couder@gmail.com>
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
2.43.0.14.g93e034faee

