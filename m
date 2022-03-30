Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D5C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiC3FHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbiC3FHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3F66213
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso2704973wmz.4
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f/ZbN5quD6ggV2+4j9lRbjM6zktg3vb1d35PK4/3tT4=;
        b=CRxoiIULfFKgVM5bIjkDlyfXOsp56IVxfY4TNnUPuG7X9w05jYMK16rUQKGIbhnH5i
         AroW7RAi+g86v0CAYG7cpFWkScoLelDZWJq2R7QTaEFPhRqXT5ZQ/G8XaaG0/v0Ix3PJ
         cZZ2gMcEESxVXQruJMmixBcP3/M4riIOks99Of5P+dG9sLS1ydCBea1UJIPlb14twi3q
         Ok33EKIeCsEhUTEJethtHpYXcSG9SEzus7ZNmnUsOQPET/+tQEcACKmjEcVLWGIvZF4N
         Ct5RxqTyoHVpReGD61X1mUsBjm/KYODsYVSnuAGlL3JeWUfMCNeu0ZaAqhqfaLwYRLkE
         ylrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f/ZbN5quD6ggV2+4j9lRbjM6zktg3vb1d35PK4/3tT4=;
        b=dyeNCXR8fI2ys5rOAC3IPFrhrS1g9HGEfOq3WAcgkfJU1I2Ujyrb1GtvFQZF2z+J3y
         X+CT5vT82d0guufSEH0IB2r6DAOn4WLFBWsjmAM+Iy71Ed4cODP6cR7bkdElFWLF/PXJ
         ueU9qfRrdFmhlejEV+RsORRFib0/KORQIwzzS/7p4gble44HaV1L9yei4wTyvQAcZfIa
         GPvuu9NYswaFJcs90FIU7V1Jg/bXUwi/qiQBgOgixCKm7KTWbQKopjkHlO0BpykvCy/k
         kFjx75+l9Gu2hsDpiFdPvaSquldh0kcBOOd17hnQ+k1LwTC8vzdSUuue6kFKFOA5OHxu
         9Qaw==
X-Gm-Message-State: AOAM532wvGg6DnfQuZYZ/xO+Xuv4kAvriVB2bRHbhYWcfgQ+9fup8Gj3
        7vKmMVS2YOkByqzpoUZpdmXuyekkZxU=
X-Google-Smtp-Source: ABdhPJwOTloCXdp/x2NkpadXrEOUnn7lEsRT1+pwTIcxHWftVAFOIsYKQL4LivgxWKQkABLWZou/Mw==
X-Received: by 2002:a7b:cf03:0:b0:38e:38c0:be27 with SMTP id l3-20020a7bcf03000000b0038e38c0be27mr141760wmg.150.1648616745693;
        Tue, 29 Mar 2022 22:05:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm3730371wmj.34.2022.03.29.22.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:45 -0700 (PDT)
Message-Id: <4de7300a7b0061c1399738c66ce05bfbbe2db1d0.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:28 +0000
Subject: [PATCH v5 10/14] test-lib-functions: add parsing helpers for ls-files
 and ls-tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Several tests use awk to parse OIDs from the output of 'git ls-files
--stage' and 'git ls-tree'. Introduce helpers to centralize these uses
of awk.

Update t5317-pack-objects-filter-objects.sh to use the new ls-files
helper so that it has some usages to review. Other updates are left for
the future.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/t5317-pack-objects-filter-objects.sh | 91 +++++++++++++-------------
 t/test-lib-functions.sh                | 10 +++
 2 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 33b740ce628..bb633c9b099 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -10,9 +10,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 # Test blob:none filter.
 
 test_expect_success 'setup r1' '
-	echo "{print \$1}" >print_1.awk &&
-	echo "{print \$2}" >print_2.awk &&
-
 	git init r1 &&
 	for n in 1 2 3 4 5
 	do
@@ -22,10 +19,13 @@ test_expect_success 'setup r1' '
 	done
 '
 
+parse_verify_pack_blob_oid () {
+	awk '{print $1}' -
+}
+
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r1 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -35,7 +35,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r1 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -54,12 +54,12 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
 	git -C r1 verify-pack -v ../all.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >expected &&
 
 	git -C r1 verify-pack -v ../filter.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -123,8 +123,8 @@ test_expect_success 'setup r2' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -134,7 +134,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r2 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -161,8 +161,8 @@ test_expect_success 'verify blob:limit=1000' '
 '
 
 test_expect_success 'verify blob:limit=1001' '
-	git -C r2 ls-files -s large.1000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
@@ -172,15 +172,15 @@ test_expect_success 'verify blob:limit=1001' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=10001' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
@@ -190,15 +190,15 @@ test_expect_success 'verify blob:limit=10001' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1k' '
-	git -C r2 ls-files -s large.1000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
@@ -208,15 +208,15 @@ test_expect_success 'verify blob:limit=1k' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify explicitly specifying oversized blob in input' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	echo HEAD >objects &&
@@ -226,15 +226,15 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r2 ls-files -s large.1000 large.10000 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r2 pack-objects --revs --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
@@ -244,7 +244,7 @@ test_expect_success 'verify blob:limit=1m' '
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -253,12 +253,12 @@ test_expect_success 'verify blob:limit=1m' '
 test_expect_success 'verify normal and blob:limit packfiles have same commits/trees' '
 	git -C r2 verify-pack -v ../all.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >expected &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -289,9 +289,8 @@ test_expect_success 'setup r3' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r3 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -301,7 +300,7 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r3 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -342,9 +341,8 @@ test_expect_success 'setup r4' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 pack-objects --revs --stdout >all.pack <<-EOF &&
@@ -354,19 +352,19 @@ test_expect_success 'verify blob count in normal packfile' '
 
 	git -C r4 verify-pack -v ../all.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=OID' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 ls-files -s pattern >staged &&
-	oid=$(awk -f print_2.awk staged) &&
+	oid=$(test_parse_ls_files_stage_oids <staged) &&
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=$oid >filter.pack <<-EOF &&
 	HEAD
 	EOF
@@ -374,15 +372,15 @@ test_expect_success 'verify sparse:oid=OID' '
 
 	git -C r4 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
 '
 
 test_expect_success 'verify sparse:oid=oid-ish' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	git -C r4 pack-objects --revs --stdout --filter=sparse:oid=main:pattern >filter.pack <<-EOF &&
@@ -392,7 +390,7 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 
 	git -C r4 verify-pack -v ../filter.pack >verify_result &&
 	grep blob verify_result |
-	awk -f print_1.awk |
+	parse_verify_pack_blob_oid |
 	sort >observed &&
 
 	test_cmp expected observed
@@ -402,9 +400,8 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 # This models previously omitted objects that we did not receive.
 
 test_expect_success 'setup r1 - delete loose blobs' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
-		>ls_files_result &&
-	awk -f print_2.awk ls_files_result |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	test_parse_ls_files_stage_oids |
 	sort >expected &&
 
 	for id in `cat expected | sed "s|..|&/|"`
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index a027f0c409e..e6011409e2f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1782,6 +1782,16 @@ test_oid_to_path () {
 	echo "${1%$basename}/$basename"
 }
 
+# Parse oids from git ls-files --staged output
+test_parse_ls_files_stage_oids () {
+	awk '{print $2}' -
+}
+
+# Parse oids from git ls-tree output
+test_parse_ls_tree_oids () {
+	awk '{print $3}' -
+}
+
 # Choose a port number based on the test script's number and store it in
 # the given variable name, unless that variable already contains a number.
 test_set_port () {
-- 
gitgitgadget

