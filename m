Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAA01F453
	for <e@80x24.org>; Fri, 21 Sep 2018 01:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbeIUHaX (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 03:30:23 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:35435 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIUHaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 03:30:23 -0400
Received: by mail-oi0-f74.google.com with SMTP id v4-v6so10554696oix.2
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7zKw0egsy+x7+rdsaWS05YoLfNTl4N5cl/+AFEkaWC0=;
        b=ekWPVP7ewyJPQBxv8EUtTQ5Fv4C6jzNDJq3CRlBTey9hk4r9XlqapOJ7WKM9d9D1++
         8xQMRJNoYps6IXoNYZ2RH8wv36eNQbu9ueKFNMkwNEGkrIomibn3M6HE6NBw2uGZ9yNP
         wygK4NiV440uv0ZIz6dnN8KsPe92q6XoTLzrHJbTYtPAmrRbR2eYZRWK/s9YxAiK0wmO
         tvOibcoRTo4VFQxg/Bdg18Cnwm1GCrGkg/UzupHSu5C9jlCJuWL/0mkqwtF8ZXFuDq+t
         HCbAwisMlU3Wm3aOAXTs8JY7Jj8BOaG4cTU5R/caw1w+A4SZmvgJrpixS6TuPO+Hvx/P
         XNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7zKw0egsy+x7+rdsaWS05YoLfNTl4N5cl/+AFEkaWC0=;
        b=CQCs7nnTT1F9zDGqj6CtQUJ/PKYaXiPYNjysKOdfhwFk4Lg+W8zQMUkLq8tAB7YUSs
         tl9TZyf4rmjqFQvcBqSemjqYodvUvBydJbznGaMKY/yWHgXX8qeypilHWSMHq9KxR0j1
         iRG6QWzEf8oEEhX3wA0kQ7XQK18u/c50wE6YiNH8GsIYLEgrU7c1Bmuzyrum79Oymk3D
         dHgBD8qywLKY7KYmzHx/JQiDdaLRqMVaMwxFHlBcbvB4e+WcrlkpBuF6f3MLpvFR69Fj
         PZkV0GLikb3qKepB1yeqOWNH3xTslnJOHt/P7uqHtJjvhyFtTNlQVfxUBZ7Ud23M7icM
         +qWA==
X-Gm-Message-State: APzg51DC6pSIB3uxQOR3lXngNgJQUZiSLL/zVA6e87j/66P4numPPRc4
        5X7jStSm+7LZ5T8Tf2x4haHzCddfLo+StRwupbDTUU4gQ7/U7jOwuHW+HqJ04l3t/dIbMMVw1IR
        sIzfsh9BWJuMHkKzpQmUMw//1cMSalyI7bni4UVehOoWM1KncUzgGwWyFAgo=
X-Google-Smtp-Source: ANB0VdbpqkWEW17VlHfUQPj02jG+s5jM0tAx9+jHl6di+dr5RxJs9i2q8rkzEydL5CD7krcgjtinWc9cGSyc
X-Received: by 2002:aca:d5cf:: with SMTP id m198-v6mr44969533oig.26.1537494237951;
 Thu, 20 Sep 2018 18:43:57 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:43:30 -0700
In-Reply-To: <cover.1537493611.git.matvore@google.com>
Message-Id: <e61bc462dab95a2ef964b7913766e777e971a800.1537493611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537493611.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v3 4/5] tests: don't swallow Git errors upstream of pipes
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some pipes in tests lose the exit code of git processes, which can mask
unexpected behavior like crashes. Split these pipes up so that git
commands are only at the end of pipes rather than the beginning or
middle.

The violations fixed in this patch were found in the process of fixing
pipe placement in a prior patch.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 t/t5317-pack-objects-filter-objects.sh | 156 +++++++++++++------------
 t/t5616-partial-clone.sh               |  14 ++-
 t/t6112-rev-list-filters-objects.sh    | 103 ++++++++--------
 t/t9101-git-svn-props.sh               |   3 +-
 4 files changed, 143 insertions(+), 133 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index c093eb891..2e718f0bd 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -20,8 +20,9 @@ test_expect_success 'setup r1' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
-	awk -f print_2.awk |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		>ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r1 pack-objects --rev --stdout >all.pack <<-EOF &&
@@ -29,8 +30,8 @@ test_expect_success 'verify blob count in normal packfile' '
 	EOF
 	git -C r1 index-pack ../all.pack &&
 
-	git -C r1 verify-pack -v ../all.pack |
-	grep blob |
+	git -C r1 verify-pack -v ../all.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -43,8 +44,8 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	EOF
 	git -C r1 index-pack ../filter.pack &&
 
-	git -C r1 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r1 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -53,13 +54,13 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 '
 
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
-	git -C r1 verify-pack -v ../all.pack |
-	grep -E "commit|tree" |
+	git -C r1 verify-pack -v ../all.pack >verify_result &&
+	grep -E "commit|tree" verify_result |
 	awk -f print_1.awk |
 	sort >expected &&
 
-	git -C r1 verify-pack -v ../filter.pack |
-	grep -E "commit|tree" |
+	git -C r1 verify-pack -v ../filter.pack >verify_result &&
+	grep -E "commit|tree" verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -82,8 +83,8 @@ test_expect_success 'setup r2' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r2 pack-objects --rev --stdout >all.pack <<-EOF &&
@@ -91,8 +92,8 @@ test_expect_success 'verify blob count in normal packfile' '
 	EOF
 	git -C r2 index-pack ../all.pack &&
 
-	git -C r2 verify-pack -v ../all.pack |
-	grep blob |
+	git -C r2 verify-pack -v ../all.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -105,8 +106,8 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	EOF
 	git -C r2 index-pack ../filter.pack &&
 
-	git -C r2 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -120,8 +121,8 @@ test_expect_success 'verify blob:limit=1000' '
 	EOF
 	git -C r2 index-pack ../filter.pack &&
 
-	git -C r2 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -130,8 +131,8 @@ test_expect_success 'verify blob:limit=1000' '
 '
 
 test_expect_success 'verify blob:limit=1001' '
-	git -C r2 ls-files -s large.1000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.1000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1001 >filter.pack <<-EOF &&
@@ -139,8 +140,8 @@ test_expect_success 'verify blob:limit=1001' '
 	EOF
 	git -C r2 index-pack ../filter.pack &&
 
-	git -C r2 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -148,8 +149,8 @@ test_expect_success 'verify blob:limit=1001' '
 '
 
 test_expect_success 'verify blob:limit=10001' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=10001 >filter.pack <<-EOF &&
@@ -157,8 +158,8 @@ test_expect_success 'verify blob:limit=10001' '
 	EOF
 	git -C r2 index-pack ../filter.pack &&
 
-	git -C r2 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -166,8 +167,8 @@ test_expect_success 'verify blob:limit=10001' '
 '
 
 test_expect_success 'verify blob:limit=1k' '
-	git -C r2 ls-files -s large.1000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.1000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
@@ -175,8 +176,8 @@ test_expect_success 'verify blob:limit=1k' '
 	EOF
 	git -C r2 index-pack ../filter.pack &&
 
-	git -C r2 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -184,8 +185,8 @@ test_expect_success 'verify blob:limit=1k' '
 '
 
 test_expect_success 'verify explicitly specifying oversized blob in input' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1k >filter.pack <<-EOF &&
@@ -194,8 +195,8 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 	EOF
 	git -C r2 index-pack ../filter.pack &&
 
-	git -C r2 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -203,8 +204,8 @@ test_expect_success 'verify explicitly specifying oversized blob in input' '
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r2 pack-objects --rev --stdout --filter=blob:limit=1m >filter.pack <<-EOF &&
@@ -212,8 +213,8 @@ test_expect_success 'verify blob:limit=1m' '
 	EOF
 	git -C r2 index-pack ../filter.pack &&
 
-	git -C r2 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -221,13 +222,13 @@ test_expect_success 'verify blob:limit=1m' '
 '
 
 test_expect_success 'verify normal and blob:limit packfiles have same commits/trees' '
-	git -C r2 verify-pack -v ../all.pack |
-	grep -E "commit|tree" |
+	git -C r2 verify-pack -v ../all.pack >verify_result &&
+	grep -E "commit|tree" verify_result |
 	awk -f print_1.awk |
 	sort >expected &&
 
-	git -C r2 verify-pack -v ../filter.pack |
-	grep -E "commit|tree" |
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep -E "commit|tree" verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -255,8 +256,9 @@ test_expect_success 'setup r3' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
-	awk -f print_2.awk |
+	git -C r3 ls-files -s sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
+		>ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r3 pack-objects --rev --stdout >all.pack <<-EOF &&
@@ -264,8 +266,8 @@ test_expect_success 'verify blob count in normal packfile' '
 	EOF
 	git -C r3 index-pack ../all.pack &&
 
-	git -C r3 verify-pack -v ../all.pack |
-	grep blob |
+	git -C r3 verify-pack -v ../all.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -273,8 +275,8 @@ test_expect_success 'verify blob count in normal packfile' '
 '
 
 test_expect_success 'verify sparse:path=pattern1' '
-	git -C r3 ls-files -s dir1/sparse1 dir1/sparse2 |
-	awk -f print_2.awk |
+	git -C r3 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern1 >filter.pack <<-EOF &&
@@ -282,8 +284,8 @@ test_expect_success 'verify sparse:path=pattern1' '
 	EOF
 	git -C r3 index-pack ../filter.pack &&
 
-	git -C r3 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r3 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -291,13 +293,13 @@ test_expect_success 'verify sparse:path=pattern1' '
 '
 
 test_expect_success 'verify normal and sparse:path=pattern1 packfiles have same commits/trees' '
-	git -C r3 verify-pack -v ../all.pack |
-	grep -E "commit|tree" |
+	git -C r3 verify-pack -v ../all.pack >verify_result &&
+	grep -E "commit|tree" verify_result |
 	awk -f print_1.awk |
 	sort >expected &&
 
-	git -C r3 verify-pack -v ../filter.pack |
-	grep -E "commit|tree" |
+	git -C r3 verify-pack -v ../filter.pack >verify_result &&
+	grep -E "commit|tree" verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -305,8 +307,8 @@ test_expect_success 'verify normal and sparse:path=pattern1 packfiles have same
 '
 
 test_expect_success 'verify sparse:path=pattern2' '
-	git -C r3 ls-files -s sparse1 dir1/sparse1 |
-	awk -f print_2.awk |
+	git -C r3 ls-files -s sparse1 dir1/sparse1 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r3 pack-objects --rev --stdout --filter=sparse:path=../pattern2 >filter.pack <<-EOF &&
@@ -314,8 +316,8 @@ test_expect_success 'verify sparse:path=pattern2' '
 	EOF
 	git -C r3 index-pack ../filter.pack &&
 
-	git -C r3 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r3 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -323,13 +325,13 @@ test_expect_success 'verify sparse:path=pattern2' '
 '
 
 test_expect_success 'verify normal and sparse:path=pattern2 packfiles have same commits/trees' '
-	git -C r3 verify-pack -v ../all.pack |
-	grep -E "commit|tree" |
+	git -C r3 verify-pack -v ../all.pack >verify_result &&
+	grep -E "commit|tree" verify_result |
 	awk -f print_1.awk |
 	sort >expected &&
 
-	git -C r3 verify-pack -v ../filter.pack |
-	grep -E "commit|tree" |
+	git -C r3 verify-pack -v ../filter.pack >verify_result &&
+	grep -E "commit|tree" verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -356,8 +358,9 @@ test_expect_success 'setup r4' '
 '
 
 test_expect_success 'verify blob count in normal packfile' '
-	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 |
-	awk -f print_2.awk |
+	git -C r4 ls-files -s pattern sparse1 sparse2 dir1/sparse1 dir1/sparse2 \
+		>ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r4 pack-objects --rev --stdout >all.pack <<-EOF &&
@@ -365,8 +368,8 @@ test_expect_success 'verify blob count in normal packfile' '
 	EOF
 	git -C r4 index-pack ../all.pack &&
 
-	git -C r4 verify-pack -v ../all.pack |
-	grep blob |
+	git -C r4 verify-pack -v ../all.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -374,8 +377,8 @@ test_expect_success 'verify blob count in normal packfile' '
 '
 
 test_expect_success 'verify sparse:oid=OID' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
-	awk -f print_2.awk |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	oid=$(git -C r4 ls-files -s pattern | awk -f print_2.awk) &&
@@ -384,8 +387,8 @@ test_expect_success 'verify sparse:oid=OID' '
 	EOF
 	git -C r4 index-pack ../filter.pack &&
 
-	git -C r4 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r4 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -393,8 +396,8 @@ test_expect_success 'verify sparse:oid=OID' '
 '
 
 test_expect_success 'verify sparse:oid=oid-ish' '
-	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 |
-	awk -f print_2.awk |
+	git -C r4 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	git -C r4 pack-objects --rev --stdout --filter=sparse:oid=master:pattern >filter.pack <<-EOF &&
@@ -402,8 +405,8 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 	EOF
 	git -C r4 index-pack ../filter.pack &&
 
-	git -C r4 verify-pack -v ../filter.pack |
-	grep blob |
+	git -C r4 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
 	awk -f print_1.awk |
 	sort >observed &&
 
@@ -414,8 +417,9 @@ test_expect_success 'verify sparse:oid=oid-ish' '
 # This models previously omitted objects that we did not receive.
 
 test_expect_success 'setup r1 - delete loose blobs' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
-	awk -f print_2.awk |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		>ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	for id in `cat expected | sed "s|..|&/|"`
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index e4d032c9d..fc7aeb1ab 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -35,8 +35,8 @@ test_expect_success 'setup bare clone for server' '
 test_expect_success 'do partial clone 1' '
 	git clone --no-checkout --filter=blob:none "file://$(pwd)/srv.bare" pc1 &&
 
-	git -C pc1 rev-list HEAD --quiet --objects --missing=print |
-	awk -f print_1.awk |
+	git -C pc1 rev-list HEAD --quiet --objects --missing=print >revs &&
+	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
 
@@ -133,16 +133,18 @@ test_expect_success 'push new commits to server for file.3.txt' '
 test_expect_success 'manual prefetch of missing objects' '
 	git -C pc1 fetch --filter=blob:none origin &&
 
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print |
-	awk -f print_1.awk |
+	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print \
+		>revs &&
+	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
 
 	test_line_count = 6 observed.oids &&
 	git -C pc1 fetch-pack --stdin "file://$(pwd)/srv.bare" <observed.oids &&
 
-	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print |
-	awk -f print_1.awk |
+	git -C pc1 rev-list master..origin/master --quiet --objects --missing=print \
+		>revs &&
+	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed.oids &&
 
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index ae4402226..b00cf6fa8 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -20,12 +20,13 @@ test_expect_success 'setup r1' '
 '
 
 test_expect_success 'verify blob:none omits all 5 blobs' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
-	awk -f print_2.awk |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		>ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none |
-	awk -f print_1.awk |
+	git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -33,12 +34,13 @@ test_expect_success 'verify blob:none omits all 5 blobs' '
 '
 
 test_expect_success 'verify emitted+omitted == all' '
-	git -C r1 rev-list HEAD --objects |
-	awk -f print_1.awk |
+	git -C r1 rev-list HEAD --objects >revs &&
+	awk -f print_1.awk revs |
 	sort >expected &&
 
-	git -C r1 rev-list HEAD --objects --filter-print-omitted --filter=blob:none |
-	awk -f print_1.awk |
+	git -C r1 rev-list HEAD --objects --filter-print-omitted --filter=blob:none \
+		>revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -62,12 +64,12 @@ test_expect_success 'setup r2' '
 '
 
 test_expect_success 'verify blob:limit=500 omits all blobs' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=500 |
-	awk -f print_1.awk |
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=500 >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -75,12 +77,12 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 '
 
 test_expect_success 'verify emitted+omitted == all' '
-	git -C r2 rev-list HEAD --objects |
-	awk -f print_1.awk |
+	git -C r2 rev-list HEAD --objects >revs &&
+	awk -f print_1.awk revs |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --objects --filter-print-omitted --filter=blob:limit=500 |
-	awk -f print_1.awk |
+	git -C r2 rev-list HEAD --objects --filter-print-omitted --filter=blob:limit=500 >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -88,12 +90,12 @@ test_expect_success 'verify emitted+omitted == all' '
 '
 
 test_expect_success 'verify blob:limit=1000' '
-	git -C r2 ls-files -s large.1000 large.10000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.1000 large.10000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1000 |
-	awk -f print_1.awk |
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1000 >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -101,12 +103,12 @@ test_expect_success 'verify blob:limit=1000' '
 '
 
 test_expect_success 'verify blob:limit=1001' '
-	git -C r2 ls-files -s large.10000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.10000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1001 |
-	awk -f print_1.awk |
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1001 >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -114,12 +116,12 @@ test_expect_success 'verify blob:limit=1001' '
 '
 
 test_expect_success 'verify blob:limit=1k' '
-	git -C r2 ls-files -s large.10000 |
-	awk -f print_2.awk |
+	git -C r2 ls-files -s large.10000 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1k |
-	awk -f print_1.awk |
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1k >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -127,8 +129,8 @@ test_expect_success 'verify blob:limit=1k' '
 '
 
 test_expect_success 'verify blob:limit=1m' '
-	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1m |
-	awk -f print_1.awk |
+	git -C r2 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:limit=1m >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -156,12 +158,12 @@ test_expect_success 'setup r3' '
 '
 
 test_expect_success 'verify sparse:path=pattern1 omits top-level files' '
-	git -C r3 ls-files -s sparse1 sparse2 |
-	awk -f print_2.awk |
+	git -C r3 ls-files -s sparse1 sparse2 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern1 |
-	awk -f print_1.awk |
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern1 >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -169,12 +171,12 @@ test_expect_success 'verify sparse:path=pattern1 omits top-level files' '
 '
 
 test_expect_success 'verify sparse:path=pattern2 omits both sparse2 files' '
-	git -C r3 ls-files -s sparse2 dir1/sparse2 |
-	awk -f print_2.awk |
+	git -C r3 ls-files -s sparse2 dir1/sparse2 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern2 |
-	awk -f print_1.awk |
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:path=../pattern2 >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -192,14 +194,14 @@ test_expect_success 'setup r3 part 2' '
 '
 
 test_expect_success 'verify sparse:oid=OID omits top-level files' '
-	git -C r3 ls-files -s pattern sparse1 sparse2 |
-	awk -f print_2.awk |
+	git -C r3 ls-files -s pattern sparse1 sparse2 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	oid=$(git -C r3 ls-files -s pattern | awk -f print_2.awk) &&
 
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=$oid |
-	awk -f print_1.awk |
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=$oid >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -207,12 +209,12 @@ test_expect_success 'verify sparse:oid=OID omits top-level files' '
 '
 
 test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
-	git -C r3 ls-files -s pattern sparse1 sparse2 |
-	awk -f print_2.awk |
+	git -C r3 ls-files -s pattern sparse1 sparse2 >ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
-	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=master:pattern |
-	awk -f print_1.awk |
+	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=sparse:oid=master:pattern >revs &&
+	awk -f print_1.awk revs |
 	sed "s/~//" |
 	sort >observed &&
 
@@ -223,8 +225,9 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
 # This models previously omitted objects that we did not receive.
 
 test_expect_success 'rev-list W/ --missing=print' '
-	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
-	awk -f print_2.awk |
+	git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		>ls_files_result &&
+	awk -f print_2.awk ls_files_result |
 	sort >expected &&
 
 	for id in `cat expected | sed "s|..|&/|"`
@@ -232,8 +235,8 @@ test_expect_success 'rev-list W/ --missing=print' '
 		rm r1/.git/objects/$id
 	done &&
 
-	git -C r1 rev-list --quiet HEAD --missing=print --objects |
-	awk -f print_1.awk |
+	git -C r1 rev-list --quiet HEAD --missing=print --objects >revs &&
+	awk -f print_1.awk revs |
 	sed "s/?//" |
 	sort >observed &&
 
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 8a5c8dc1a..8cba331fc 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -174,7 +174,8 @@ test_expect_success 'test create-ignore' "
 	cmp ./deeply/.gitignore create-ignore.expect &&
 	cmp ./deeply/nested/.gitignore create-ignore.expect &&
 	cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
-	git ls-files -s | grep gitignore | cmp - create-ignore-index.expect
+	git ls-files -s >ls_files_result &&
+	grep gitignore ls_files_result | cmp - create-ignore-index.expect
 	"
 
 cat >prop.expect <<\EOF
-- 
2.19.0.444.g18242da7ef-goog

