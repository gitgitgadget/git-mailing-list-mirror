Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37942C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A792073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="F4tY0/xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbgEYUAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390398AbgEYT75 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A16EF60D0D;
        Mon, 25 May 2020 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436793;
        bh=pKT7D8FfW9+6hGmCBXYrcHQTegDW9wGONuHCaQuqves=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=F4tY0/xkTn4WN5dqEVudIm8qfepSqvlZihtv3f+SH2FKntKJZq7aalNemz3gSLee0
         UfJznd1AchDHKIIabsLwOD1D2lYTX6ubqdSMprfXLXk0vHNpyaDbl0bF5req8Ff9S2
         hh46XbytnR0jyrUuLjJ0ylU4AnVtCrOX0DiGSasccST78VIN7rrKHuE7y+nBbuN+am
         zBlwS/VXVJLWJpZHRl+f3Q4P7ghRPFdqZadpHl0UmhEs42Kxg8ie9JfYTzvSk1s2J+
         97HjCJ/DdJFRwU+7gxAfbAMeM3ZrByL7JEM0aAjuw+yQoRo94peRtWCjYZhWrbczsb
         rOY8QCCp0haSmRHM3By8HUmldLZLHxL9QeriC4r2egfTKnWzm28nuGee91btKnWBao
         qd5CtHzWWixpJISUwZH1eo5lrVWQImcvrye5OkYpCPkJhaYakmKtvfvP3ivtPCF+4K
         PlKFAEQmDu5BNKtNm2fHf0NOdPF1brTM1pUoVzoJMMi5PaFpFD+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 25/44] t5302: modernize test formatting
Date:   Mon, 25 May 2020 19:59:11 +0000
Message-Id: <20200525195930.309665-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our style these days is to place the description and the opening quote
of the body on the same line as test_expect_success (if it fits), to
place the trailing quote on a line by itself after the body, and to use
tabs.  Since we're going to be making several significant changes to
this test, modernize the style to aid in readability of the subsequent
patches.

This patch should have no functional change.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5302-pack-index.sh | 360 +++++++++++++++++++++---------------------
 1 file changed, 184 insertions(+), 176 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index ad07f2f7fc..8981c9b90e 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -7,65 +7,65 @@ test_description='pack index with 64-bit offsets and object CRC'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-     test_oid_init &&
-     rawsz=$(test_oid rawsz) &&
-     rm -rf .git &&
-     git init &&
-     git config pack.threads 1 &&
-     i=1 &&
-     while test $i -le 100
-     do
-         iii=$(printf '%03i' $i)
-	 test-tool genrandom "bar" 200 > wide_delta_$iii &&
-	 test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
-	 test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
-	 test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
-	 test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
-         echo $iii >file_$iii &&
-	 test-tool genrandom "$iii" 8192 >>file_$iii &&
-         git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
-         i=$(expr $i + 1) || return 1
-     done &&
-     { echo 101 && test-tool genrandom 100 8192; } >file_101 &&
-     git update-index --add file_101 &&
-     tree=$(git write-tree) &&
-     commit=$(git commit-tree $tree </dev/null) && {
-	 echo $tree &&
-	 git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
-     } >obj-list &&
-     git update-ref HEAD $commit
+	test_oid_init &&
+	rawsz=$(test_oid rawsz) &&
+	rm -rf .git &&
+	git init &&
+	git config pack.threads 1 &&
+	i=1 &&
+	while test $i -le 100
+	do
+		iii=$(printf '%03i' $i)
+		test-tool genrandom "bar" 200 > wide_delta_$iii &&
+		test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
+		test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+		test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
+		echo $iii >file_$iii &&
+		test-tool genrandom "$iii" 8192 >>file_$iii &&
+		git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+		i=$(expr $i + 1) || return 1
+	done &&
+	{ echo 101 && test-tool genrandom 100 8192; } >file_101 &&
+	git update-index --add file_101 &&
+	tree=$(git write-tree) &&
+	commit=$(git commit-tree $tree </dev/null) && {
+		echo $tree &&
+		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
+	} >obj-list &&
+	git update-ref HEAD $commit
 '
 
-test_expect_success \
-    'pack-objects with index version 1' \
-    'pack1=$(git pack-objects --index-version=1 test-1 <obj-list) &&
-     git verify-pack -v "test-1-${pack1}.pack"'
+test_expect_success 'pack-objects with index version 1' '
+	pack1=$(git pack-objects --index-version=1 test-1 <obj-list) &&
+	git verify-pack -v "test-1-${pack1}.pack"
+'
 
-test_expect_success \
-    'pack-objects with index version 2' \
-    'pack2=$(git pack-objects --index-version=2 test-2 <obj-list) &&
-     git verify-pack -v "test-2-${pack2}.pack"'
+test_expect_success 'pack-objects with index version 2' '
+	pack2=$(git pack-objects --index-version=2 test-2 <obj-list) &&
+	git verify-pack -v "test-2-${pack2}.pack"
+'
 
-test_expect_success \
-    'both packs should be identical' \
-    'cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"'
+test_expect_success 'both packs should be identical' '
+	cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"
+'
 
-test_expect_success \
-    'index v1 and index v2 should be different' \
-    '! cmp "test-1-${pack1}.idx" "test-2-${pack2}.idx"'
+test_expect_success 'index v1 and index v2 should be different' '
+	! cmp "test-1-${pack1}.idx" "test-2-${pack2}.idx"
+'
 
-test_expect_success \
-    'index-pack with index version 1' \
-    'git index-pack --index-version=1 -o 1.idx "test-1-${pack1}.pack"'
+test_expect_success 'index-pack with index version 1' '
+	git index-pack --index-version=1 -o 1.idx "test-1-${pack1}.pack"
+'
 
-test_expect_success \
-    'index-pack with index version 2' \
-    'git index-pack --index-version=2 -o 2.idx "test-1-${pack1}.pack"'
+test_expect_success 'index-pack with index version 2' '
+	git index-pack --index-version=2 -o 2.idx "test-1-${pack1}.pack"
+'
 
-test_expect_success \
-    'index-pack results should match pack-objects ones' \
-    'cmp "test-1-${pack1}.idx" "1.idx" &&
-     cmp "test-2-${pack2}.idx" "2.idx"'
+test_expect_success 'index-pack results should match pack-objects ones' '
+	cmp "test-1-${pack1}.idx" "1.idx" &&
+	cmp "test-2-${pack2}.idx" "2.idx"
+'
 
 test_expect_success 'index-pack --verify on index version 1' '
 	git index-pack --verify "test-1-${pack1}.pack"
@@ -75,13 +75,13 @@ test_expect_success 'index-pack --verify on index version 2' '
 	git index-pack --verify "test-2-${pack2}.pack"
 '
 
-test_expect_success \
-    'pack-objects --index-version=2, is not accepted' \
-    'test_must_fail git pack-objects --index-version=2, test-3 <obj-list'
+test_expect_success 'pack-objects --index-version=2, is not accepted' '
+	test_must_fail git pack-objects --index-version=2, test-3 <obj-list
+'
 
-test_expect_success \
-    'index v2: force some 64-bit offsets with pack-objects' \
-    'pack3=$(git pack-objects --index-version=2,0x40000 test-3 <obj-list)'
+test_expect_success 'index v2: force some 64-bit offsets with pack-objects' '
+	pack3=$(git pack-objects --index-version=2,0x40000 test-3 <obj-list)
+'
 
 if msg=$(git verify-pack -v "test-3-${pack3}.pack" 2>&1) ||
 	! (echo "$msg" | grep "pack too large .* off_t")
@@ -91,21 +91,21 @@ else
 	say "# skipping tests concerning 64-bit offsets"
 fi
 
-test_expect_success OFF64_T \
-    'index v2: verify a pack with some 64-bit offsets' \
-    'git verify-pack -v "test-3-${pack3}.pack"'
+test_expect_success OFF64_T 'index v2: verify a pack with some 64-bit offsets' '
+	git verify-pack -v "test-3-${pack3}.pack"
+'
 
-test_expect_success OFF64_T \
-    '64-bit offsets: should be different from previous index v2 results' \
-    '! cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"'
+test_expect_success OFF64_T '64-bit offsets: should be different from previous index v2 results' '
+	! cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"
+'
 
-test_expect_success OFF64_T \
-    'index v2: force some 64-bit offsets with index-pack' \
-    'git index-pack --index-version=2,0x40000 -o 3.idx "test-1-${pack1}.pack"'
+test_expect_success OFF64_T 'index v2: force some 64-bit offsets with index-pack' '
+	git index-pack --index-version=2,0x40000 -o 3.idx "test-1-${pack1}.pack"
+'
 
-test_expect_success OFF64_T \
-    '64-bit offsets: index-pack result should match pack-objects one' \
-    'cmp "test-3-${pack3}.idx" "3.idx"'
+test_expect_success OFF64_T '64-bit offsets: index-pack result should match pack-objects one' '
+	cmp "test-3-${pack3}.idx" "3.idx"
+'
 
 test_expect_success OFF64_T 'index-pack --verify on 64-bit offset v2 (cheat)' '
 	# This cheats by knowing which lower offset should still be encoded
@@ -120,135 +120,143 @@ test_expect_success OFF64_T 'index-pack --verify on 64-bit offset v2' '
 # returns the object number for given object in given pack index
 index_obj_nr()
 {
-    idx_file=$1
-    object_sha1=$2
-    nr=0
-    git show-index < $idx_file |
-    while read offs sha1 extra
-    do
-      nr=$(($nr + 1))
-      test "$sha1" = "$object_sha1" || continue
-      echo "$(($nr - 1))"
-      break
-    done
+	idx_file=$1
+	object_sha1=$2
+	nr=0
+	git show-index < $idx_file |
+	while read offs sha1 extra
+	do
+	  nr=$(($nr + 1))
+	  test "$sha1" = "$object_sha1" || continue
+	  echo "$(($nr - 1))"
+	  break
+	done
 }
 
 # returns the pack offset for given object as found in given pack index
 index_obj_offset()
 {
-    idx_file=$1
-    object_sha1=$2
-    git show-index < $idx_file | grep $object_sha1 |
-    ( read offs extra && echo "$offs" )
+	idx_file=$1
+	object_sha1=$2
+	git show-index < $idx_file | grep $object_sha1 |
+	( read offs extra && echo "$offs" )
 }
 
-test_expect_success \
-    '[index v1] 1) stream pack to repository' \
-    'git index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
-     git prune-packed &&
-     git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
-     cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
-     cmp "test-1-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
+test_expect_success '[index v1] 1) stream pack to repository' '
+	git index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
+	git prune-packed &&
+	git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
+	cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
+	cmp "test-1-${pack1}.idx"	".git/objects/pack/pack-${pack1}.idx"
+'
 
 test_expect_success \
-    '[index v1] 2) create a stealth corruption in a delta base reference' \
-    '# This test assumes file_101 is a delta smaller than 16 bytes.
-     # It should be against file_100 but we substitute its base for file_099
-     sha1_101=$(git hash-object file_101) &&
-     sha1_099=$(git hash-object file_099) &&
-     offs_101=$(index_obj_offset 1.idx $sha1_101) &&
-     nr_099=$(index_obj_nr 1.idx $sha1_099) &&
-     chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
-     recordsz=$((rawsz + 4)) &&
-     dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
-        if=".git/objects/pack/pack-${pack1}.idx" \
-        skip=$((4 + 256 * 4 + $nr_099 * recordsz)) \
-        bs=1 count=$rawsz conv=notrunc &&
-     git cat-file blob $sha1_101 > file_101_foo1'
+	'[index v1] 2) create a stealth corruption in a delta base reference' '
+	# This test assumes file_101 is a delta smaller than 16 bytes.
+	# It should be against file_100 but we substitute its base for file_099
+	sha1_101=$(git hash-object file_101) &&
+	sha1_099=$(git hash-object file_099) &&
+	offs_101=$(index_obj_offset 1.idx $sha1_101) &&
+	nr_099=$(index_obj_nr 1.idx $sha1_099) &&
+	chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
+	recordsz=$((rawsz + 4)) &&
+	dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
+	       if=".git/objects/pack/pack-${pack1}.idx" \
+	       skip=$((4 + 256 * 4 + $nr_099 * recordsz)) \
+	       bs=1 count=$rawsz conv=notrunc &&
+	git cat-file blob $sha1_101 > file_101_foo1
+'
 
 test_expect_success \
-    '[index v1] 3) corrupted delta happily returned wrong data' \
-    'test -f file_101_foo1 && ! cmp file_101 file_101_foo1'
+	'[index v1] 3) corrupted delta happily returned wrong data' '
+	test -f file_101_foo1 && ! cmp file_101 file_101_foo1
+'
 
 test_expect_success \
-    '[index v1] 4) confirm that the pack is actually corrupted' \
-    'test_must_fail git fsck --full $commit'
+	'[index v1] 4) confirm that the pack is actually corrupted' '
+	test_must_fail git fsck --full $commit
+'
 
 test_expect_success \
-    '[index v1] 5) pack-objects happily reuses corrupted data' \
-    'pack4=$(git pack-objects test-4 <obj-list) &&
-     test -f "test-4-${pack4}.pack"'
+	'[index v1] 5) pack-objects happily reuses corrupted data' '
+	pack4=$(git pack-objects test-4 <obj-list) &&
+	test -f "test-4-${pack4}.pack"
+'
+
+test_expect_success '[index v1] 6) newly created pack is BAD !' '
+	test_must_fail git verify-pack -v "test-4-${pack4}.pack"
+'
+
+test_expect_success '[index v2] 1) stream pack to repository' '
+	rm -f .git/objects/pack/* &&
+	git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
+	git prune-packed &&
+	git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
+	cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
+	cmp "test-2-${pack1}.idx"	".git/objects/pack/pack-${pack1}.idx"
+'
 
 test_expect_success \
-    '[index v1] 6) newly created pack is BAD !' \
-    'test_must_fail git verify-pack -v "test-4-${pack4}.pack"'
+	'[index v2] 2) create a stealth corruption in a delta base reference' '
+	# This test assumes file_101 is a delta smaller than 16 bytes.
+	# It should be against file_100 but we substitute its base for file_099
+	sha1_101=$(git hash-object file_101) &&
+	sha1_099=$(git hash-object file_099) &&
+	offs_101=$(index_obj_offset 1.idx $sha1_101) &&
+	nr_099=$(index_obj_nr 1.idx $sha1_099) &&
+	chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
+	dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
+		if=".git/objects/pack/pack-${pack1}.idx" \
+		skip=$((8 + 256 * 4 + $nr_099 * rawsz)) \
+		bs=1 count=$rawsz conv=notrunc &&
+	git cat-file blob $sha1_101 > file_101_foo2
+'
 
 test_expect_success \
-    '[index v2] 1) stream pack to repository' \
-    'rm -f .git/objects/pack/* &&
-     git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
-     git prune-packed &&
-     git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
-     cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
-     cmp "test-2-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
+	'[index v2] 3) corrupted delta happily returned wrong data' '
+	test -f file_101_foo2 && ! cmp file_101 file_101_foo2
+'
 
 test_expect_success \
-    '[index v2] 2) create a stealth corruption in a delta base reference' \
-    '# This test assumes file_101 is a delta smaller than 16 bytes.
-     # It should be against file_100 but we substitute its base for file_099
-     sha1_101=$(git hash-object file_101) &&
-     sha1_099=$(git hash-object file_099) &&
-     offs_101=$(index_obj_offset 1.idx $sha1_101) &&
-     nr_099=$(index_obj_nr 1.idx $sha1_099) &&
-     chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
-     dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
-        if=".git/objects/pack/pack-${pack1}.idx" \
-        skip=$((8 + 256 * 4 + $nr_099 * rawsz)) \
-        bs=1 count=$rawsz conv=notrunc &&
-     git cat-file blob $sha1_101 > file_101_foo2'
+	'[index v2] 4) confirm that the pack is actually corrupted' '
+	test_must_fail git fsck --full $commit
+'
 
 test_expect_success \
-    '[index v2] 3) corrupted delta happily returned wrong data' \
-    'test -f file_101_foo2 && ! cmp file_101 file_101_foo2'
+	'[index v2] 5) pack-objects refuses to reuse corrupted data' '
+	test_must_fail git pack-objects test-5 <obj-list &&
+	test_must_fail git pack-objects --no-reuse-object test-6 <obj-list
+'
 
 test_expect_success \
-    '[index v2] 4) confirm that the pack is actually corrupted' \
-    'test_must_fail git fsck --full $commit'
-
-test_expect_success \
-    '[index v2] 5) pack-objects refuses to reuse corrupted data' \
-    'test_must_fail git pack-objects test-5 <obj-list &&
-     test_must_fail git pack-objects --no-reuse-object test-6 <obj-list'
-
-test_expect_success \
-    '[index v2] 6) verify-pack detects CRC mismatch' \
-    'rm -f .git/objects/pack/* &&
-     git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
-     git verify-pack ".git/objects/pack/pack-${pack1}.pack" &&
-     obj=$(git hash-object file_001) &&
-     nr=$(index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj) &&
-     chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
-     printf xxxx | dd of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
-        bs=1 count=4 seek=$((8 + 256 * 4 + $(wc -l <obj-list) * rawsz + $nr * 4)) &&
-     ( while read obj
-       do git cat-file -p $obj >/dev/null || exit 1
-       done <obj-list ) &&
-     test_must_fail git verify-pack ".git/objects/pack/pack-${pack1}.pack"
+	'[index v2] 6) verify-pack detects CRC mismatch' '
+	rm -f .git/objects/pack/* &&
+	git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
+	git verify-pack ".git/objects/pack/pack-${pack1}.pack" &&
+	obj=$(git hash-object file_001) &&
+	nr=$(index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj) &&
+	chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
+	printf xxxx | dd of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
+		bs=1 count=4 seek=$((8 + 256 * 4 + $(wc -l <obj-list) * rawsz + $nr * 4)) &&
+	 ( while read obj
+	   do git cat-file -p $obj >/dev/null || exit 1
+	   done <obj-list ) &&
+	test_must_fail git verify-pack ".git/objects/pack/pack-${pack1}.pack"
 '
 
 test_expect_success 'running index-pack in the object store' '
-    rm -f .git/objects/pack/* &&
-    cp test-1-${pack1}.pack .git/objects/pack/pack-${pack1}.pack &&
-    (
-	cd .git/objects/pack &&
-	git index-pack pack-${pack1}.pack
-    ) &&
-    test -f .git/objects/pack/pack-${pack1}.idx
+	rm -f .git/objects/pack/* &&
+	cp test-1-${pack1}.pack .git/objects/pack/pack-${pack1}.pack &&
+	(
+		cd .git/objects/pack &&
+		git index-pack pack-${pack1}.pack
+	) &&
+	test -f .git/objects/pack/pack-${pack1}.idx
 '
 
 test_expect_success 'index-pack --strict warns upon missing tagger in tag' '
-    sha=$(git rev-parse HEAD) &&
-    cat >wrong-tag <<EOF &&
+	sha=$(git rev-parse HEAD) &&
+	cat >wrong-tag <<EOF &&
 object $sha
 type commit
 tag guten tag
@@ -256,18 +264,18 @@ tag guten tag
 This is an invalid tag.
 EOF
 
-    tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
-    pack1=$(echo $tag $sha | git pack-objects tag-test) &&
-    echo remove tag object &&
-    thirtyeight=${tag#??} &&
-    rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
-    git index-pack --strict tag-test-${pack1}.pack 2>err &&
-    grep "^warning:.* expected .tagger. line" err
+	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
+	pack1=$(echo $tag $sha | git pack-objects tag-test) &&
+	echo remove tag object &&
+	thirtyeight=${tag#??} &&
+	rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
+	git index-pack --strict tag-test-${pack1}.pack 2>err &&
+	grep "^warning:.* expected .tagger. line" err
 '
 
 test_expect_success 'index-pack --fsck-objects also warns upon missing tagger in tag' '
-    git index-pack --fsck-objects tag-test-${pack1}.pack 2>err &&
-    grep "^warning:.* expected .tagger. line" err
+	git index-pack --fsck-objects tag-test-${pack1}.pack 2>err &&
+	grep "^warning:.* expected .tagger. line" err
 '
 
 test_done
