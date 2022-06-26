Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEBBC43334
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiFZNKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiFZNK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:10:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB9CE08
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso4057275wml.1
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NACJRToHJP1PjjfvpsJUUgREmA7eTJdIN8BGQAEUa10=;
        b=dCt6I/RkhkTV3iJ5Dqz0oGZwVy6IlTXFe52Vf7C/H51nnMk0GSy6IDkAxnPjhq6bEH
         BWav9B6sj1tugXMXYkQChjm5ahpCit3uIh70Bo2ok3V0+f+drQMbvOA2SAnpiC1tW2hV
         HH+G9/JIwpthYjAcARBcQHlVMFK4LVzvqz3B8UogSml4VKgRPp0ZkIlkSuEXXFjbCyS7
         iIFmL/WKtGUaNU8fcEs+V77cmadhsh5ZCR9LKAlP9mdFuEOYVPVj065TiJ/7I+blaVqa
         Nyrj5pU0AbrY254P/5LBiiLCVESHAMXdQbEiTAHczlF2GvIWp+Aw5BtXolNjCXUh6WAL
         +7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NACJRToHJP1PjjfvpsJUUgREmA7eTJdIN8BGQAEUa10=;
        b=ORF3NVJCfmQOFjj5SBtomqsxYhIrySwqnNV79kAlApbS/1f2Vj/FAGjOb/rGZXjqNM
         chPC3Oome9tlM5eQb3sMxvZGWn/3sP5J8X9lPGVZDranmbHim69TP5Ik8JwtUo9V8XkX
         7Ho5D5dpndnRa7+9IrDYjNOK4TFo07Eygl3blX0IhDaLfNd/BJbPPxuBG159ZeUxOZ0i
         PMMXdYkHrcj1saaCaRkWVpVseo8VyDVp9jU+KtG8WvoOcBsC1FCh3gLPp3bjyjSnJ4Eb
         ZbFkVOuajwnEfDBuUwjv8ga4zwbUTS0eL0Y2q+8u73j+2tqv7PgDrVOH+IDMQTNYpy4N
         JSJQ==
X-Gm-Message-State: AJIora8/VQCuSfM3IezB8vBWP/afFOr2j2A4KQ7omoUas+f6LY2AiuD1
        6Lkn24vCVfHtRfPXFJeYx1h+rRA33GFEMQ==
X-Google-Smtp-Source: AGRyM1v1yly+ybs3V5YKmx4mK2yjae5Qio8P4wEx44H96Xh97luZ0lFy/6NJjgiTzcWgikTAj4Uubg==
X-Received: by 2002:a05:600c:1d17:b0:3a0:481b:f1e1 with SMTP id l23-20020a05600c1d1700b003a0481bf1e1mr2911622wms.136.1656249025059;
        Sun, 26 Jun 2022 06:10:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b002185631adf0sm7738392wre.23.2022.06.26.06.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:10:24 -0700 (PDT)
Message-Id: <96c0041688f6139c17611203f98274988ced25ab.1656249018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
        <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jun 2022 13:10:16 +0000
Subject: [PATCH v2 5/6] bitmap-lookup-table: add performance tests for lookup
 table
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Add performance tests to verify the performance of lookup table.

Lookup table makes Git run faster in most of the cases. Below is the
result of `t/perf/p5310-pack-bitmaps.sh`.`perf/p5326-multi-pack-bitmaps.sh`
gives similar result. The repository used in the test is linux kernel.

Test                                                      this tree
--------------------------------------------------------------------------
5310.4: repack to disk (lookup=false)                   295.94(250.45+15.24)
5310.5: simulated clone                                 12.52(5.07+1.40)
5310.6: simulated fetch                                 1.89(2.94+0.24)
5310.7: pack to file (bitmap)                           41.39(20.33+7.20)
5310.8: rev-list (commits)                              0.98(0.59+0.12)
5310.9: rev-list (objects)                              3.40(3.27+0.10)
5310.10: rev-list with tag negated via --not		0.07(0.02+0.04)
         --all (objects)
5310.11: rev-list with negative tag (objects)           0.23(0.16+0.06)
5310.12: rev-list count with blob:none                  0.26(0.18+0.07)
5310.13: rev-list count with blob:limit=1k              6.45(5.94+0.37)
5310.14: rev-list count with tree:0                     0.26(0.18+0.07)
5310.15: simulated partial clone                        4.99(3.19+0.45)
5310.19: repack to disk (lookup=true)                   269.67(174.70+21.33)
5310.20: simulated clone                                11.03(5.07+1.11)
5310.21: simulated fetch                                0.79(0.79+0.17)
5310.22: pack to file (bitmap)                          43.03(20.28+7.43)
5310.23: rev-list (commits)                             0.86(0.54+0.09)
5310.24: rev-list (objects)                             3.35(3.26+0.07)
5310.25: rev-list with tag negated via --not		0.05(0.00+0.03)
	 --all (objects)
5310.26: rev-list with negative tag (objects)           0.22(0.16+0.05)
5310.27: rev-list count with blob:none                  0.22(0.16+0.05)
5310.28: rev-list count with blob:limit=1k              6.45(5.87+0.31)
5310.29: rev-list count with tree:0                     0.22(0.16+0.05)
5310.30: simulated partial clone                        5.17(3.12+0.48)

Test 4-15 are tested without using lookup table. Same tests are
repeated in 16-30 (using lookup table).

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/perf/p5310-pack-bitmaps.sh       | 77 ++++++++++++++-----------
 t/perf/p5326-multi-pack-bitmaps.sh | 93 ++++++++++++++++--------------
 2 files changed, 94 insertions(+), 76 deletions(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 7ad4f237bc3..6ff42bdd391 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -16,39 +16,48 @@ test_expect_success 'setup bitmap config' '
 	git config pack.writebitmaps true
 '
 
-# we need to create the tag up front such that it is covered by the repack and
-# thus by generated bitmaps.
-test_expect_success 'create tags' '
-	git tag --message="tag pointing to HEAD" perf-tag HEAD
-'
-
-test_perf 'repack to disk' '
-	git repack -ad
-'
-
-test_full_bitmap
-
-test_expect_success 'create partial bitmap state' '
-	# pick a commit to represent the repo tip in the past
-	cutoff=$(git rev-list HEAD~100 -1) &&
-	orig_tip=$(git rev-parse HEAD) &&
-
-	# now kill off all of the refs and pretend we had
-	# just the one tip
-	rm -rf .git/logs .git/refs/* .git/packed-refs &&
-	git update-ref HEAD $cutoff &&
-
-	# and then repack, which will leave us with a nice
-	# big bitmap pack of the "old" history, and all of
-	# the new history will be loose, as if it had been pushed
-	# up incrementally and exploded via unpack-objects
-	git repack -Ad &&
-
-	# and now restore our original tip, as if the pushes
-	# had happened
-	git update-ref HEAD $orig_tip
-'
-
-test_partial_bitmap
+test_bitmap () {
+    local enabled="$1"
+
+	# we need to create the tag up front such that it is covered by the repack and
+	# thus by generated bitmaps.
+	test_expect_success 'create tags' '
+		git tag --message="tag pointing to HEAD" perf-tag HEAD
+	'
+
+	test_expect_success "use lookup table: $enabled" '
+		git config pack.writeBitmapLookupTable '"$enabled"'
+	'
+
+	test_perf "repack to disk (lookup=$enabled)" '
+		git repack -ad
+	'
+
+	test_full_bitmap
+
+    test_expect_success "create partial bitmap state (lookup=$enabled)" '
+		# pick a commit to represent the repo tip in the past
+		cutoff=$(git rev-list HEAD~100 -1) &&
+		orig_tip=$(git rev-parse HEAD) &&
+
+		# now kill off all of the refs and pretend we had
+		# just the one tip
+		rm -rf .git/logs .git/refs/* .git/packed-refs &&
+		git update-ref HEAD $cutoff &&
+
+		# and then repack, which will leave us with a nice
+		# big bitmap pack of the "old" history, and all of
+		# the new history will be loose, as if it had been pushed
+		# up incrementally and exploded via unpack-objects
+		git repack -Ad &&
+
+		# and now restore our original tip, as if the pushes
+		# had happened
+		git update-ref HEAD $orig_tip
+    '
+}
+
+test_bitmap false
+test_bitmap true
 
 test_done
diff --git a/t/perf/p5326-multi-pack-bitmaps.sh b/t/perf/p5326-multi-pack-bitmaps.sh
index f2fa228f16a..d67e7437493 100755
--- a/t/perf/p5326-multi-pack-bitmaps.sh
+++ b/t/perf/p5326-multi-pack-bitmaps.sh
@@ -6,47 +6,56 @@ test_description='Tests performance using midx bitmaps'
 
 test_perf_large_repo
 
-# we need to create the tag up front such that it is covered by the repack and
-# thus by generated bitmaps.
-test_expect_success 'create tags' '
-	git tag --message="tag pointing to HEAD" perf-tag HEAD
-'
-
-test_expect_success 'start with bitmapped pack' '
-	git repack -adb
-'
-
-test_perf 'setup multi-pack index' '
-	git multi-pack-index write --bitmap
-'
-
-test_expect_success 'drop pack bitmap' '
-	rm -f .git/objects/pack/pack-*.bitmap
-'
-
-test_full_bitmap
-
-test_expect_success 'create partial bitmap state' '
-	# pick a commit to represent the repo tip in the past
-	cutoff=$(git rev-list HEAD~100 -1) &&
-	orig_tip=$(git rev-parse HEAD) &&
-
-	# now pretend we have just one tip
-	rm -rf .git/logs .git/refs/* .git/packed-refs &&
-	git update-ref HEAD $cutoff &&
-
-	# and then repack, which will leave us with a nice
-	# big bitmap pack of the "old" history, and all of
-	# the new history will be loose, as if it had been pushed
-	# up incrementally and exploded via unpack-objects
-	git repack -Ad &&
-	git multi-pack-index write --bitmap &&
-
-	# and now restore our original tip, as if the pushes
-	# had happened
-	git update-ref HEAD $orig_tip
-'
-
-test_partial_bitmap
+test_bitmap () {
+    local enabled="$1"
+
+	# we need to create the tag up front such that it is covered by the repack and
+	# thus by generated bitmaps.
+	test_expect_success 'create tags' '
+		git tag --message="tag pointing to HEAD" perf-tag HEAD
+	'
+
+	test_expect_success "use lookup table: $enabled" '
+		git config pack.writeBitmapLookupTable '"$enabled"'
+	'
+
+	test_expect_success "start with bitmapped pack (lookup=$enabled)" '
+		git repack -adb
+	'
+
+	test_perf "setup multi-pack index (lookup=$enabled)" '
+		git multi-pack-index write --bitmap
+	'
+
+	test_expect_success "drop pack bitmap (lookup=$enabled)" '
+		rm -f .git/objects/pack/pack-*.bitmap
+	'
+
+	test_full_bitmap
+
+    test_expect_success "create partial bitmap state (lookup=$enabled)" '
+		# pick a commit to represent the repo tip in the past
+		cutoff=$(git rev-list HEAD~100 -1) &&
+		orig_tip=$(git rev-parse HEAD) &&
+
+		# now pretend we have just one tip
+		rm -rf .git/logs .git/refs/* .git/packed-refs &&
+		git update-ref HEAD $cutoff &&
+
+		# and then repack, which will leave us with a nice
+		# big bitmap pack of the "old" history, and all of
+		# the new history will be loose, as if it had been pushed
+		# up incrementally and exploded via unpack-objects
+		git repack -Ad &&
+		git multi-pack-index write --bitmap &&
+
+		# and now restore our original tip, as if the pushes
+		# had happened
+		git update-ref HEAD $orig_tip
+    '
+}
+
+test_bitmap false
+test_bitmap true
 
 test_done
-- 
gitgitgadget

