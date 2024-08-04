Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FCC1B7FD
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722755553; cv=none; b=DAJCg7x3OsWvfv4vdph/uVjrtvnXPKVrXUXtO2tJlO85jxptUuVL5IOW/I5KHaL6lDxpHnrA93l6NqylMa8iTu5rGCveCk+yavvOtWoiJPqH+RlPuFFxQiCa7YlW9i/RCS6CutrZ5qR7bRz/XZMAa8dWjAdmXb/ReB5UCn1y9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722755553; c=relaxed/simple;
	bh=2jKAO/KOrqrQkjHh/m2kX+WJDHiM0a2frExzigIyjFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3M/kXHVW3B0S5Q8KJ5WPOydt1TOCOw0rZHw9j3XMlp79qcTdwZxlGSQp2fAM/kNcB3FrWQLCb8TsK7DEVss2sTD0ixyZWfpGPRd4g5WYGW5dMKKO0b8XvswjZFVOirOIigBN7vibXUFmEDl1MiRQM9NWYGN4gCvImd/GvQoRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQhXsp9v; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQhXsp9v"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so140706151fa.0
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722755548; x=1723360348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjPFWLuKuOAmzNQqQ5ZLKiAME4VcA7lEyje+Ub7PAUA=;
        b=ZQhXsp9v5fXN+uPppKZw0z0/WDMk7u3ZV6M9DwbgjoM/nCgIELbfMI6pxETK33oHdT
         K7BLm7HiJlNSvgnYNPlFMJ4uP8Bwad912ZPd6dyizr3yvHOOuOC+umeO/JvjaZVfrlY8
         oVdUXk7wVZNrr8BLcY2V6Ad2Vzg/kreBZuaYyepN1QMu5eEQwoBKN4G41XePegL0m0Q1
         H+XNCidRjWSxtHHWwy7WxM/3YrxCJIUotRziMp4rhWiI3cPIUdN7gyX/kfp4QEE2Xo+Q
         DiL2ZSOe0m5WC3zstVfSuSHsMyphqYciIadrGaKSMgH5Z/Tpw17c4TjQbJ2ot+GkIof9
         zmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722755548; x=1723360348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjPFWLuKuOAmzNQqQ5ZLKiAME4VcA7lEyje+Ub7PAUA=;
        b=hzJ8rZAuOujAWFlRceL7E+5AlT8jkIpgWNiuSmgQFgrms7gw1ebyxcarIWg7ueCDPU
         kqp2fLlK/DTN+W+cw1SgHlEScuE72e7tNY4pRUzqC0JnQprJa1NLo4dlJjv7jvZY3dsw
         GBnzlFnos1q5kDCujNYX9xHfJ7Yomx1oaU4BHxAK7PC/XI9nGUoLnCGJPMtG/XDK6NWk
         idVI6gOX5WEYp4P2Pxoc3o2G4brLbfgLFNcLVwS0qXk8HIhK/arDg0XfeE5q/IeqgDJB
         SwhIA6e7+RvfLM3FsVlyYDdTFnhHtTOUVpMu1MMNAwYFjrMzm4PuuYm4YsGRm8CffUeo
         cgjQ==
X-Gm-Message-State: AOJu0YyxI1JQ/SShC8Bs9IhuhhHesyRho59t03qtmrkNFuScmogK0Lqy
	m2Z1Q+MMJPWlwpFZi6JilYceNXSzWWqGrRfjz+eD50LCPNNhlsB6d9svdShXnSI=
X-Google-Smtp-Source: AGHT+IGDMokQM2/f3uXu2pL1OGzrrCIktEyZD8IC1lE7CR+zivpt4GS/WpF+OZfEAXeFVz1ODng77A==
X-Received: by 2002:a2e:9344:0:b0:2ef:2272:177f with SMTP id 38308e7fff4ca-2f15ab237d9mr52377251fa.34.1722755547697;
        Sun, 04 Aug 2024 00:12:27 -0700 (PDT)
Received: from abdobngad.. ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3c0b7sm88477595e9.23.2024.08.04.00.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 00:12:27 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v3 6/6] [Newcomer] t7004-tag: description on the same line as test_expect_success
Date: Sun,  4 Aug 2024 10:11:37 +0300
Message-ID: <20240804071137.30326-7-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804071137.30326-1-abdobngad@gmail.com>
References: <20240804071137.30326-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changed test_expect_success that are seperated from its name like:

   test_expect_success \
   	'trying to delete tags without params ....' '

   test_expect_success GPG \
	'trying to verify an annotated ....' '

to

   test_expect_success 'trying to delete tags without params ....' '

   test_expect_success GPG 'trying to verify an annotated.... ' '

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 280 +++++++++++++++++++------------------------------
 1 file changed, 109 insertions(+), 171 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c60167d6fd..c7674c9241 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -156,26 +156,25 @@ test_expect_success 'listing a tag using a matching pattern should succeed' \
 test_expect_success 'listing a tag with --ignore-case' \
 	'test $(git tag -l --ignore-case MYTAG) = mytag'
 
-test_expect_success \
-	'listing a tag using a matching pattern should output that tag' \
-	'test $(git tag -l mytag) = mytag'
+test_expect_success 'listing a tag using a matching pattern should output that tag' '
+	test $(git tag -l mytag) = mytag
+'
 
-test_expect_success \
-	'listing tags using a non-matching pattern should succeed' \
-	'git tag -l xxx'
+test_expect_success 'listing tags using a non-matching pattern should succeed' '
+	git tag -l xxx
+'
 
-test_expect_success \
-	'listing tags using a non-matching pattern should output nothing' \
-	'test $(git tag -l xxx | wc -l) -eq 0'
+test_expect_success 'listing tags using a non-matching pattern should output nothing' '
+	test $(git tag -l xxx | wc -l) -eq 0
+'
 
 # special cases for creating tags:
 
-test_expect_success \
-	'trying to create a tag with the name of one existing should fail' \
-	'test_must_fail git tag mytag'
+test_expect_success 'trying to create a tag with the name of one existing should fail' '
+	test_must_fail git tag mytag
+'
 
-test_expect_success \
-	'trying to create a tag with a non-valid name should fail' '
+test_expect_success 'trying to create a tag with a non-valid name should fail' '
 	test $(git tag -l | wc -l) -eq 1 &&
 	test_must_fail git tag "" &&
 	test_must_fail git tag .othertag &&
@@ -209,8 +208,7 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 	test_must_fail git tag -d unknown-tag
 '
 
-test_expect_success \
-	'trying to delete tags without params should succeed and do nothing' '
+test_expect_success 'trying to delete tags without params should succeed and do nothing' '
 	cat >expect <<-\EOF &&
 	myhead
 	mytag
@@ -222,8 +220,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'deleting two existing tags in one command should succeed' '
+test_expect_success 'deleting two existing tags in one command should succeed' '
 	tag_exists mytag &&
 	tag_exists myhead &&
 	git tag -d mytag myhead &&
@@ -231,15 +228,13 @@ test_expect_success \
 	! tag_exists myhead
 '
 
-test_expect_success \
-	'creating a tag with the name of another deleted one should succeed' '
+test_expect_success 'creating a tag with the name of another deleted one should succeed' '
 	! tag_exists mytag &&
 	git tag mytag &&
 	tag_exists mytag
 '
 
-test_expect_success \
-	'trying to delete two tags, existing and not, should fail in the 2nd' '
+test_expect_success 'trying to delete two tags, existing and not, should fail in the 2nd' '
 	tag_exists mytag &&
 	! tag_exists nonexistingtag &&
 	test_must_fail git tag -d mytag nonexistingtag &&
@@ -279,8 +274,7 @@ test_expect_success 'listing all tags should print them ordered' '
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags with substring as pattern must print those matching' '
+test_expect_success 'listing tags with substring as pattern must print those matching' '
 	cat >expect <<-\EOF &&
 	a1
 	aa1
@@ -291,8 +285,7 @@ test_expect_success \
 	test_cmp expect current
 '
 
-test_expect_success \
-	'listing tags with a suffix as pattern must print those matching' '
+test_expect_success 'listing tags with a suffix as pattern must print those matching' '
 	cat >expect <<-\EOF &&
 	v0.2.1
 	v1.0.1
@@ -301,8 +294,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags with a prefix as pattern must print those matching' '
+test_expect_success 'listing tags with a prefix as pattern must print those matching' '
 	cat >expect <<-\EOF &&
 	t210
 	t211
@@ -311,8 +303,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags using a name as pattern must print that one matching' '
+test_expect_success 'listing tags using a name as pattern must print that one matching' '
 	cat >expect <<-\EOF &&
 	a1
 	EOF
@@ -320,8 +311,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags using a name as pattern must print that one matching' '
+test_expect_success 'listing tags using a name as pattern must print that one matching' '
 	cat >expect <<-\EOF &&
 	v1.0
 	EOF
@@ -329,8 +319,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags with ? in the pattern should print those matching' '
+test_expect_success 'listing tags with ? in the pattern should print those matching' '
 	cat >expect <<-\EOF &&
 	v1.0.1
 	v1.1.3
@@ -339,14 +328,12 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags using v.* should print nothing because none have v.' '
+test_expect_success 'listing tags using v.* should print nothing because none have v.' '
 	git tag -l "v.*" >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_success \
-	'listing tags using v* should print only those having v' '
+test_expect_success 'listing tags using v* should print only those having v' '
 	cat >expect <<-\EOF &&
 	v0.2.1
 	v1.0
@@ -430,23 +417,23 @@ test_expect_success 'listing tags -n in column with column.ui ignored' '
 
 # creating and verifying lightweight tags:
 
-test_expect_success \
-	'a non-annotated tag created without parameters should point to HEAD' '
+test_expect_success 'a non-annotated tag created without parameters should point to HEAD' '
 	git tag non-annotated-tag &&
 	test $(git cat-file -t non-annotated-tag) = commit &&
 	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
 '
 
-test_expect_success 'trying to verify an unknown tag should fail' \
-	'test_must_fail git tag -v unknown-tag'
+test_expect_success 'trying to verify an unknown tag should fail' '
+	test_must_fail git tag -v unknown-tag
+'
 
-test_expect_success \
-	'trying to verify a non-annotated and non-signed tag should fail' \
-	'test_must_fail git tag -v non-annotated-tag'
+test_expect_success 'trying to verify a non-annotated and non-signed tag should fail' '
+	test_must_fail git tag -v non-annotated-tag
+'
 
-test_expect_success \
-	'trying to verify many non-annotated or unknown tags, should fail' \
-	'test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+test_expect_success 'trying to verify many non-annotated or unknown tags, should fail' '
+	test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2
+'
 
 # creating annotated tags:
 
@@ -470,8 +457,7 @@ time=$test_tick
 
 get_tag_header annotated-tag $commit commit $time >expect
 echo "A message" >>expect
-test_expect_success \
-	'creating an annotated tag with -m message should succeed' '
+test_expect_success 'creating an annotated tag with -m message should succeed' '
 	git tag -m "A message" annotated-tag &&
 	get_tag_msg annotated-tag >actual &&
 	test_cmp expect actual
@@ -485,8 +471,7 @@ test_expect_success 'set up editor' '
 	mv "$1-" "$1"
 	EOF
 '
-test_expect_success \
-	'creating an annotated tag with -m message --edit should succeed' '
+test_expect_success 'creating an annotated tag with -m message --edit should succeed' '
 	GIT_EDITOR=./fakeeditor git tag -m "A message" --edit annotated-tag-edit &&
 	get_tag_msg annotated-tag-edit >actual &&
 	test_cmp expect actual
@@ -498,8 +483,7 @@ in a file.
 EOF
 get_tag_header file-annotated-tag $commit commit $time >expect
 cat msgfile >>expect
-test_expect_success \
-	'creating an annotated tag with -F messagefile should succeed' '
+test_expect_success 'creating an annotated tag with -F messagefile should succeed' '
 	git tag -F msgfile file-annotated-tag &&
 	get_tag_msg file-annotated-tag >actual &&
 	test_cmp expect actual
@@ -513,8 +497,7 @@ test_expect_success 'set up editor' '
 	mv "$1-" "$1"
 	EOF
 '
-test_expect_success \
-	'creating an annotated tag with -F messagefile --edit should succeed' '
+test_expect_success 'creating an annotated tag with -F messagefile --edit should succeed' '
 	GIT_EDITOR=./fakeeditor git tag -F msgfile --edit file-annotated-tag-edit &&
 	get_tag_msg file-annotated-tag-edit >actual &&
 	test_cmp expect actual
@@ -532,16 +515,14 @@ test_expect_success 'creating an annotated tag with -F - should succeed' '
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'trying to create a tag with a non-existing -F file should fail' '
+test_expect_success 'trying to create a tag with a non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists notag &&
 	test_must_fail git tag -F nonexistingfile notag &&
 	! tag_exists notag
 '
 
-test_expect_success \
-	'trying to create tags giving both -m or -F options should fail' '
+test_expect_success 'trying to create tags giving both -m or -F options should fail' '
 	echo "message file 1" >msgfile1 &&
 	! tag_exists msgtag &&
 	test_must_fail git tag -m "message 1" -F msgfile1 msgtag &&
@@ -556,8 +537,7 @@ test_expect_success \
 # blank and empty messages:
 
 get_tag_header empty-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with an empty -m message should succeed' '
+test_expect_success 'creating a tag with an empty -m message should succeed' '
 	git tag -m "" empty-annotated-tag &&
 	get_tag_msg empty-annotated-tag >actual &&
 	test_cmp expect actual
@@ -565,8 +545,7 @@ test_expect_success \
 
 >emptyfile
 get_tag_header emptyfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with an empty -F messagefile should succeed' '
+test_expect_success 'creating a tag with an empty -F messagefile should succeed' '
 	git tag -F emptyfile emptyfile-annotated-tag &&
 	get_tag_msg emptyfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -586,16 +565,14 @@ Trailing spaces
 
 Trailing blank lines
 EOF
-test_expect_success \
-	'extra blanks in the message for an annotated tag should be removed' '
+test_expect_success 'extra blanks in the message for an annotated tag should be removed' '
 	git tag -F blanksfile blanks-annotated-tag &&
 	get_tag_msg blanks-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
 get_tag_header blank-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with blank -m message with spaces should succeed' '
+test_expect_success 'creating a tag with blank -m message with spaces should succeed' '
 	git tag -m "     " blank-annotated-tag &&
 	get_tag_msg blank-annotated-tag >actual &&
 	test_cmp expect actual
@@ -605,8 +582,7 @@ echo '     ' >blankfile
 echo ''      >>blankfile
 echo '  '    >>blankfile
 get_tag_header blankfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with blank -F messagefile with spaces should succeed' '
+test_expect_success 'creating a tag with blank -F messagefile with spaces should succeed' '
 	git tag -F blankfile blankfile-annotated-tag &&
 	get_tag_msg blankfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -614,8 +590,7 @@ test_expect_success \
 
 printf '      ' >blanknonlfile
 get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with -F file of spaces and no newline should succeed' '
+test_expect_success 'creating a tag with -F file of spaces and no newline should succeed' '
 	git tag -F blanknonlfile blanknonlfile-annotated-tag &&
 	get_tag_msg blanknonlfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -649,16 +624,14 @@ Another line.
 
 Last line.
 EOF
-test_expect_success \
-	'creating a tag using a -F messagefile with #comments should succeed' '
+test_expect_success 'creating a tag using a -F messagefile with #comments should succeed' '
 	git tag -F commentsfile comments-annotated-tag &&
 	get_tag_msg comments-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
 get_tag_header comment-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with a #comment in the -m message should succeed' '
+test_expect_success 'creating a tag with a #comment in the -m message should succeed' '
 	git tag -m "#comment" comment-annotated-tag &&
 	get_tag_msg comment-annotated-tag >actual &&
 	test_cmp expect actual
@@ -668,8 +641,7 @@ echo '#comment' >commentfile
 echo ''         >>commentfile
 echo '####'     >>commentfile
 get_tag_header commentfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with #comments in the -F messagefile should succeed' '
+test_expect_success 'creating a tag with #comments in the -F messagefile should succeed' '
 	git tag -F commentfile commentfile-annotated-tag &&
 	get_tag_msg commentfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -677,8 +649,7 @@ test_expect_success \
 
 printf '#comment' >commentnonlfile
 get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with a file of #comment and no newline should succeed' '
+test_expect_success 'creating a tag with a file of #comment and no newline should succeed' '
 	git tag -F commentnonlfile commentnonlfile-annotated-tag &&
 	get_tag_msg commentnonlfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -795,8 +766,7 @@ test_expect_success 'bad editor causes panic when only --trailer is given' '
 
 # listing messages for annotated non-signed tags:
 
-test_expect_success \
-	'listing the one-line message of a non-signed tag should succeed' '
+test_expect_success 'listing the one-line message of a non-signed tag should succeed' '
 	git tag -m "A msg" tag-one-line &&
 
 	echo "tag-one-line" >expect &&
@@ -835,8 +805,7 @@ test_expect_success 'The -n 100 invocation means -n --list 100, not -n100' '
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing the zero-lines message of a non-signed tag should succeed' '
+test_expect_success 'listing the zero-lines message of a non-signed tag should succeed' '
 	git tag -m "" tag-zero-lines &&
 
 	echo "tag-zero-lines" >expect &&
@@ -863,8 +832,7 @@ test_expect_success \
 echo 'tag line one' >annotagmsg
 echo 'tag line two' >>annotagmsg
 echo 'tag line three' >>annotagmsg
-test_expect_success \
-	'listing many message lines of a non-signed tag should succeed' '
+test_expect_success 'listing many message lines of a non-signed tag should succeed' '
 	git tag -F annotagmsg tag-lines &&
 
 	echo "tag-lines" >expect &&
@@ -952,20 +920,17 @@ test_expect_success 'git tag --format with ahead-behind' '
 
 # trying to verify annotated non-signed tags:
 
-test_expect_success GPG \
-	'trying to verify an annotated non-signed tag should fail' '
+test_expect_success GPG 'trying to verify an annotated non-signed tag should fail' '
 	tag_exists annotated-tag &&
 	test_must_fail git tag -v annotated-tag
 '
 
-test_expect_success GPG \
-	'trying to verify a file-annotated non-signed tag should fail' '
+test_expect_success GPG 'trying to verify a file-annotated non-signed tag should fail' '
 	tag_exists file-annotated-tag &&
 	test_must_fail git tag -v file-annotated-tag
 '
 
-test_expect_success GPG \
-	'trying to verify two annotated non-signed tags should fail' '
+test_expect_success GPG 'trying to verify two annotated non-signed tags should fail' '
 	tag_exists annotated-tag file-annotated-tag &&
 	test_must_fail git tag -v annotated-tag file-annotated-tag
 '
@@ -1029,8 +994,7 @@ EOF
 get_tag_header file-signed-tag $commit commit $time >expect
 cat sigmsgfile >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with -F messagefile should succeed' '
+test_expect_success GPG 'creating a signed tag with -F messagefile should succeed' '
 	git tag -s -F sigmsgfile file-signed-tag &&
 	get_tag_msg file-signed-tag >actual &&
 	test_cmp expect actual
@@ -1061,17 +1025,15 @@ test_expect_success GPG '-s implies annotated tag' '
 get_tag_header forcesignannotated-implied-sign $commit commit $time >expect
 echo "A message" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'git tag -s implied if configured with tag.forcesignannotated' \
-	'test_config tag.forcesignannotated true &&
+test_expect_success GPG 'git tag -s implied if configured with tag.forcesignannotated' '
+	test_config tag.forcesignannotated true &&
 	git tag -m "A message" forcesignannotated-implied-sign &&
 	get_tag_msg forcesignannotated-implied-sign >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'lightweight with no message when configured with tag.forcesignannotated' \
-	'test_config tag.forcesignannotated true &&
+test_expect_success GPG 'lightweight with no message when configured with tag.forcesignannotated' '
+	test_config tag.forcesignannotated true &&
 	git tag forcesignannotated-lightweight &&
 	tag_exists forcesignannotated-lightweight &&
 	test_must_fail git tag -v forcesignannotated-no-message
@@ -1079,9 +1041,8 @@ test_expect_success GPG \
 
 get_tag_header forcesignannotated-annotate $commit commit $time >expect
 echo "A message" >>expect
-test_expect_success GPG \
-	'git tag -a disable configured tag.forcesignannotated' \
-	'test_config tag.forcesignannotated true &&
+test_expect_success GPG 'git tag -a disable configured tag.forcesignannotated' '
+	test_config tag.forcesignannotated true &&
 	git tag -a -m "A message" forcesignannotated-annotate &&
 	get_tag_msg forcesignannotated-annotate >actual &&
 	test_cmp expect actual &&
@@ -1091,9 +1052,8 @@ test_expect_success GPG \
 get_tag_header forcesignannotated-disabled $commit commit $time >expect
 echo "A message" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'git tag --sign enable GPG sign' \
-	'test_config tag.forcesignannotated false &&
+test_expect_success GPG 'git tag --sign enable GPG sign' '
+	test_config tag.forcesignannotated false &&
 	git tag --sign -m "A message" forcesignannotated-disabled &&
 	get_tag_msg forcesignannotated-disabled >actual &&
 	test_cmp expect actual
@@ -1102,9 +1062,8 @@ test_expect_success GPG \
 get_tag_header gpgsign-enabled $commit commit $time >expect
 echo "A message" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'git tag configured tag.gpgsign enables GPG sign' \
-	'test_config tag.gpgsign true &&
+test_expect_success GPG 'git tag configured tag.gpgsign enables GPG sign' '
+	test_config tag.gpgsign true &&
 	git tag -m "A message" gpgsign-enabled &&
 	get_tag_msg gpgsign-enabled>actual &&
 	test_cmp expect actual
@@ -1112,30 +1071,29 @@ test_expect_success GPG \
 
 get_tag_header no-sign $commit commit $time >expect
 echo "A message" >>expect
-test_expect_success GPG \
-	'git tag --no-sign configured tag.gpgsign skip GPG sign' \
-	'test_config tag.gpgsign true &&
+test_expect_success GPG 'git tag --no-sign configured tag.gpgsign skip GPG sign' '
+	test_config tag.gpgsign true &&
 	git tag -a --no-sign -m "A message" no-sign &&
 	get_tag_msg no-sign>actual &&
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'trying to create a signed tag with non-existing -F file should fail' '
+test_expect_success GPG 'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists nosigtag &&
 	test_must_fail git tag -s -F nonexistingfile nosigtag &&
 	! tag_exists nosigtag
 '
 
-test_expect_success GPG 'verifying a signed tag should succeed' \
-	'git tag -v signed-tag'
+test_expect_success GPG 'verifying a signed tag should succeed' '
+	git tag -v signed-tag
+'
 
-test_expect_success GPG 'verifying two signed tags in one command should succeed' \
-	'git tag -v signed-tag file-signed-tag'
+test_expect_success GPG 'verifying two signed tags in one command should succeed' '
+	git tag -v signed-tag file-signed-tag
+'
 
-test_expect_success GPG \
-	'verifying many signed and non-signed tags should fail' '
+test_expect_success GPG 'verifying many signed and non-signed tags should fail' '
 	test_must_fail git tag -v signed-tag annotated-tag &&
 	test_must_fail git tag -v file-annotated-tag file-signed-tag &&
 	test_must_fail git tag -v annotated-tag \
@@ -1168,8 +1126,7 @@ test_expect_success GPG 'verifying a forged tag with --format should fail silent
 
 get_tag_header empty-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with an empty -m message should succeed' '
+test_expect_success GPG 'creating a signed tag with an empty -m message should succeed' '
 	git tag -s -m "" empty-signed-tag &&
 	get_tag_msg empty-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1179,8 +1136,7 @@ test_expect_success GPG \
 >sigemptyfile
 get_tag_header emptyfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with an empty -F messagefile should succeed' '
+test_expect_success GPG 'creating a signed tag with an empty -F messagefile should succeed' '
 	git tag -s -F sigemptyfile emptyfile-signed-tag &&
 	get_tag_msg emptyfile-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1202,8 +1158,7 @@ Trailing spaces
 Trailing blank lines
 EOF
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'extra blanks in the message for a signed tag should be removed' '
+test_expect_success GPG 'extra blanks in the message for a signed tag should be removed' '
 	git tag -s -F sigblanksfile blanks-signed-tag &&
 	get_tag_msg blanks-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1212,8 +1167,7 @@ test_expect_success GPG \
 
 get_tag_header blank-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with a blank -m message should succeed' '
+test_expect_success GPG 'creating a signed tag with a blank -m message should succeed' '
 	git tag -s -m "     " blank-signed-tag &&
 	get_tag_msg blank-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1225,8 +1179,7 @@ echo ''      >>sigblankfile
 echo '  '    >>sigblankfile
 get_tag_header blankfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with blank -F file with spaces should succeed' '
+test_expect_success GPG 'creating a signed tag with blank -F file with spaces should succeed' '
 	git tag -s -F sigblankfile blankfile-signed-tag &&
 	get_tag_msg blankfile-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1236,8 +1189,7 @@ test_expect_success GPG \
 printf '      ' >sigblanknonlfile
 get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with spaces and no newline should succeed' '
+test_expect_success GPG 'creating a signed tag with spaces and no newline should succeed' '
 	git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
 	get_tag_msg blanknonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1284,8 +1236,7 @@ Another line.
 Last line.
 EOF
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with a -F file with #comments should succeed' '
+test_expect_success GPG 'creating a signed tag with a -F file with #comments should succeed' '
 	git tag -s -F sigcommentsfile comments-signed-tag &&
 	get_tag_msg comments-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1294,8 +1245,7 @@ test_expect_success GPG \
 
 get_tag_header comment-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with #commented -m message should succeed' '
+test_expect_success GPG 'creating a signed tag with #commented -m message should succeed' '
 	git tag -s -m "#comment" comment-signed-tag &&
 	get_tag_msg comment-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1307,8 +1257,7 @@ echo ''         >>sigcommentfile
 echo '####'     >>sigcommentfile
 get_tag_header commentfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with #commented -F messagefile should succeed' '
+test_expect_success GPG 'creating a signed tag with #commented -F messagefile should succeed' '
 	git tag -s -F sigcommentfile commentfile-signed-tag &&
 	get_tag_msg commentfile-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1318,8 +1267,7 @@ test_expect_success GPG \
 printf '#comment' >sigcommentnonlfile
 get_tag_header commentnonlfile-signed-tag $commit commit $time >expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with a #comment and no newline should succeed' '
+test_expect_success GPG 'creating a signed tag with a #comment and no newline should succeed' '
 	git tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
 	get_tag_msg commentnonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1328,8 +1276,7 @@ test_expect_success GPG \
 
 # listing messages for signed tags:
 
-test_expect_success GPG \
-	'listing the one-line message of a signed tag should succeed' '
+test_expect_success GPG 'listing the one-line message of a signed tag should succeed' '
 	git tag -s -m "A message line signed" stag-one-line &&
 
 	echo "stag-one-line" >expect &&
@@ -1353,8 +1300,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'listing the zero-lines message of a signed tag should succeed' '
+test_expect_success GPG 'listing the zero-lines message of a signed tag should succeed' '
 	git tag -s -m "" stag-zero-lines &&
 
 	echo "stag-zero-lines" >expect &&
@@ -1381,8 +1327,7 @@ test_expect_success GPG \
 echo 'stag line one' >sigtagmsg
 echo 'stag line two' >>sigtagmsg
 echo 'stag line three' >>sigtagmsg
-test_expect_success GPG \
-	'listing many message lines of a signed tag should succeed' '
+test_expect_success GPG 'listing many message lines of a signed tag should succeed' '
 	git tag -s -F sigtagmsg stag-lines &&
 
 	echo "stag-lines" >expect &&
@@ -1431,8 +1376,7 @@ tag=$(git rev-parse signed-tag 2>/dev/null)
 get_tag_header tree-signed-tag $tree tree $time >expect
 echo "A message for a tree" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag pointing to a tree should succeed' '
+test_expect_success GPG 'creating a signed tag pointing to a tree should succeed' '
 	git tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
 	get_tag_msg tree-signed-tag >actual &&
 	test_cmp expect actual
@@ -1441,8 +1385,7 @@ test_expect_success GPG \
 get_tag_header blob-signed-tag $blob blob $time >expect
 echo "A message for a blob" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag pointing to a blob should succeed' '
+test_expect_success GPG 'creating a signed tag pointing to a blob should succeed' '
 	git tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
 	get_tag_msg blob-signed-tag >actual &&
 	test_cmp expect actual
@@ -1451,8 +1394,7 @@ test_expect_success GPG \
 get_tag_header tag-signed-tag $tag tag $time >expect
 echo "A message for another tag" >>expect
 echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag pointing to another tag should succeed' '
+test_expect_success GPG 'creating a signed tag pointing to another tag should succeed' '
 	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
 	get_tag_msg tag-signed-tag >actual &&
 	test_cmp expect actual
@@ -1528,16 +1470,16 @@ test_expect_success GPG,RFC1991 \
 '
 
 # try to sign with bad user.signingkey
-test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured (bad key)' \
-	'test_config user.signingkey BobTheMouse &&
-	test_must_fail git tag -s -m tail tag-gpg-failure'
+test_expect_success GPG 'git tag -s fails if gpg is misconfigured (bad key)' '
+	test_config user.signingkey BobTheMouse &&
+	test_must_fail git tag -s -m tail tag-gpg-failure
+'
 
 # try to produce invalid signature
-test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured (bad signature format)' \
-	'test_config gpg.program echo &&
-	 test_must_fail git tag -s -m tail tag-gpg-failure'
+test_expect_success GPG 'git tag -s fails if gpg is misconfigured (bad signature format)' '
+	test_config gpg.program echo &&
+	test_must_fail git tag -s -m tail tag-gpg-failure
+'
 
 # try to produce invalid signature
 test_expect_success GPG 'git verifies tag is valid with double signature' '
@@ -1574,17 +1516,15 @@ test_expect_success GPGSM \
 # try to verify without gpg:
 
 rm -rf gpghome
-test_expect_success GPG \
-	'verify signed tag fails when public key is not present' \
-	'test_must_fail git tag -v signed-tag'
+test_expect_success GPG 'verify signed tag fails when public key is not present' '
+	test_must_fail git tag -v signed-tag
+'
 
-test_expect_success \
-	'git tag -a fails if tag annotation is empty' '
+test_expect_success 'git tag -a fails if tag annotation is empty' '
 	! (GIT_EDITOR=cat git tag -a initial-comment)
 '
 
-test_expect_success \
-	'message in editor has initial comment' '
+test_expect_success 'message in editor has initial comment' '
 	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
 '
 
@@ -1595,8 +1535,7 @@ test_expect_success 'message in editor has initial comment: first line' '
 	test_cmp first.expect first.actual
 '
 
-test_expect_success \
-	'message in editor has initial comment: remainder' '
+test_expect_success 'message in editor has initial comment: remainder' '
 	# remove commented lines from the remainder -- should be empty
 	sed -e 1d -e "/^#/d" <actual >rest.actual &&
 	test_must_be_empty rest.actual
@@ -1604,8 +1543,7 @@ test_expect_success \
 
 get_tag_header reuse $commit commit $time >expect
 echo "An annotation to be reused" >>expect
-test_expect_success \
-	'overwriting an annotated tag should use its previous body' '
+test_expect_success 'overwriting an annotated tag should use its previous body' '
 	git tag -a -m "An annotation to be reused" reuse &&
 	GIT_EDITOR=true git tag -f -a reuse &&
 	get_tag_msg reuse >actual &&
-- 
2.43.0

