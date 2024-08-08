Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CFF191466
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134843; cv=none; b=iB50jWnZ/YOZDyxKP4WirQoPir9Kc/KD3zg3NGOVcSutKcl5n5bW7bCT5wqex/DaLY4s5vRYjU/WUewM1Cy2j15EgYTOzE3aR3Q9mu1DKjqXRGl/9pUpuz9EIDo8uIGk6RRcM21E2bfC09ZhzMQWwXswggmnzDlgDszFr4oLQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134843; c=relaxed/simple;
	bh=MsrH1E/WGU6noklHawkX+POBlnScUaB1qnS13SbDS40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFfAb1p61jf0MB1AtqZiR7/Bm4fVaartHA+8AT6o7BGP897W/1f9WnscE7hlR9YenGTerzIUjA7xvK1ZrLBh3N42vU2fBYN9vhBEN9gMENeV+LlGsFRPkoNvOcxuFLEqOVExHazU9lreUmylZqpVeqcQG9rKGI0kw3Apv8MYWC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVMqYmZq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVMqYmZq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so7863325e9.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134839; x=1723739639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ig9z7FaK00EDz03L9ynFwXV2P5PuDDjA9OL8w3Kf6jg=;
        b=UVMqYmZqCJC3Ry4/Bec61u3YdsDXhrCCI5l64rh9h1yMTsqeRtfkgk6AEe2FtoDCff
         PL+C1PcXnJbDOq4qD4DJzSabJvzcJzGinHaAUI+MjlMbkvwSf79Q6Vgr4V5cf4KzlZDf
         KjO19zQLZ6S9ejYVqzg4PPiYaD2qSjw43UrgZPCYFnKprPjTkILdkVa6yN4hYwdesJLz
         tzy6UpF1X3QuCSJAkSgyccHTlnG4JyI+ZawyVJe7UCt98q/px49lFT+D07xvKLr09WCb
         z6X4RFa72qBIr0KPXp8B9AQXP2OyK2JiGHT0cmpyqlX6oF+59bHHo1wqfBEl0dxmESVr
         +8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134839; x=1723739639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ig9z7FaK00EDz03L9ynFwXV2P5PuDDjA9OL8w3Kf6jg=;
        b=MDSUuD5OTThkhaJm8M4Y8CkMLMxyVBSft+mVCyMwmlEr2miFCHwceyrCWevTVOMq6I
         KRdtphtmFhmNNcXBg3BdUcPqlI0m7BMhMuuvoj/kmyJtsL+mUv7M0WooHjh7wnFV0fGX
         zA+JAqREoJnExrtSpRBDC9X0UkGNxZ5QK/VEW5JKmaPxXwAf9MkjA6XTGQdh6bdWVDK5
         kNqQneek99GAPWU8yR+SSV8w1SmeBvnVZIudCN5sFJkYTZZtj52RrJcT4xETChRGCPS7
         QtOTMp7/7ZyLa7ygdc9XtpCiq8UaULxgNuFnKU0kHLvJhj0o777gTYv/y3JAilxS1rGj
         f41w==
X-Gm-Message-State: AOJu0YztaPaJd4kwN4I6Iiv8E5Qvins15OH2myq7GIfDQigDhbQBDz7Q
	7J+AHsRwafc0W8ZhMHFKH0b3Tx5AkVD0CZ2s3m0YP13odH2yBp9sYnBGkIU+MoU=
X-Google-Smtp-Source: AGHT+IE1sLs6NGEqttHGpwMZeIssjG+hgAgkJCf7l93ZifzlQzKEWq/vwQ015LmMVXfpaCz8M7PaVQ==
X-Received: by 2002:a05:600c:4752:b0:426:51ce:bb14 with SMTP id 5b1f17b1804b1-4290af3b9aemr17018235e9.30.1723134838651;
        Thu, 08 Aug 2024 09:33:58 -0700 (PDT)
Received: from abdobngad.. ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2415765f8f.95.2024.08.08.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:33:58 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v6 5/8] t7004: description on the same line as test_expect_success
Date: Thu,  8 Aug 2024 19:32:04 +0300
Message-ID: <20240808163302.17521-6-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808163302.17521-1-abdobngad@gmail.com>
References: <20240808163302.17521-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several tests in t7004 where the test description that
follows `test_expect_success` is on a separate line, violating our
coding style. Adapt these to be on the same line.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 249 +++++++++++++++++--------------------------------
 1 file changed, 83 insertions(+), 166 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 996020fd7c..5cbb13a603 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -154,26 +154,21 @@ test_expect_success 'listing a tag using a matching pattern should succeed' \
 test_expect_success 'listing a tag with --ignore-case' \
 	'test $(git tag -l --ignore-case MYTAG) = mytag'
 
-test_expect_success \
-	'listing a tag using a matching pattern should output that tag' \
+test_expect_success 'listing a tag using a matching pattern should output that tag' \
 	'test $(git tag -l mytag) = mytag'
 
-test_expect_success \
-	'listing tags using a non-matching pattern should succeed' \
+test_expect_success 'listing tags using a non-matching pattern should succeed' \
 	'git tag -l xxx'
 
-test_expect_success \
-	'listing tags using a non-matching pattern should output nothing' \
+test_expect_success 'listing tags using a non-matching pattern should output nothing' \
 	'test $(git tag -l xxx | wc -l) -eq 0'
 
 # special cases for creating tags:
 
-test_expect_success \
-	'trying to create a tag with the name of one existing should fail' \
+test_expect_success 'trying to create a tag with the name of one existing should fail' \
 	'test_must_fail git tag mytag'
 
-test_expect_success \
-	'trying to create a tag with a non-valid name should fail' '
+test_expect_success 'trying to create a tag with a non-valid name should fail' '
 	test $(git tag -l | wc -l) -eq 1 &&
 	test_must_fail git tag "" &&
 	test_must_fail git tag .othertag &&
@@ -207,8 +202,7 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 	test_must_fail git tag -d unknown-tag
 '
 
-test_expect_success \
-	'trying to delete tags without params should succeed and do nothing' '
+test_expect_success 'trying to delete tags without params should succeed and do nothing' '
 	cat >expect <<-\EOF &&
 	myhead
 	mytag
@@ -220,8 +214,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'deleting two existing tags in one command should succeed' '
+test_expect_success 'deleting two existing tags in one command should succeed' '
 	tag_exists mytag &&
 	tag_exists myhead &&
 	git tag -d mytag myhead &&
@@ -229,15 +222,13 @@ test_expect_success \
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
@@ -277,8 +268,7 @@ test_expect_success 'listing all tags should print them ordered' '
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags with substring as pattern must print those matching' '
+test_expect_success 'listing tags with substring as pattern must print those matching' '
 	cat >expect <<-\EOF &&
 	a1
 	aa1
@@ -289,8 +279,7 @@ test_expect_success \
 	test_cmp expect current
 '
 
-test_expect_success \
-	'listing tags with a suffix as pattern must print those matching' '
+test_expect_success 'listing tags with a suffix as pattern must print those matching' '
 	cat >expect <<-\EOF &&
 	v0.2.1
 	v1.0.1
@@ -299,8 +288,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags with a prefix as pattern must print those matching' '
+test_expect_success 'listing tags with a prefix as pattern must print those matching' '
 	cat >expect <<-\EOF &&
 	t210
 	t211
@@ -309,8 +297,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags using a name as pattern must print that one matching' '
+test_expect_success 'listing tags using a name as pattern must print that one matching' '
 	cat >expect <<-\EOF &&
 	a1
 	EOF
@@ -318,8 +305,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags using a name as pattern must print that one matching' '
+test_expect_success 'listing tags using a name as pattern must print that one matching' '
 	cat >expect <<-\EOF &&
 	v1.0
 	EOF
@@ -327,8 +313,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing tags with ? in the pattern should print those matching' '
+test_expect_success 'listing tags with ? in the pattern should print those matching' '
 	cat >expect <<-\EOF &&
 	v1.0.1
 	v1.1.3
@@ -337,14 +322,12 @@ test_expect_success \
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
@@ -428,8 +411,7 @@ test_expect_success 'listing tags -n in column with column.ui ignored' '
 
 # creating and verifying lightweight tags:
 
-test_expect_success \
-	'a non-annotated tag created without parameters should point to HEAD' '
+test_expect_success 'a non-annotated tag created without parameters should point to HEAD' '
 	git tag non-annotated-tag &&
 	test $(git cat-file -t non-annotated-tag) = commit &&
 	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
@@ -438,12 +420,10 @@ test_expect_success \
 test_expect_success 'trying to verify an unknown tag should fail' \
 	'test_must_fail git tag -v unknown-tag'
 
-test_expect_success \
-	'trying to verify a non-annotated and non-signed tag should fail' \
+test_expect_success 'trying to verify a non-annotated and non-signed tag should fail' \
 	'test_must_fail git tag -v non-annotated-tag'
 
-test_expect_success \
-	'trying to verify many non-annotated or unknown tags, should fail' \
+test_expect_success 'trying to verify many non-annotated or unknown tags, should fail' \
 	'test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2'
 
 # creating annotated tags:
@@ -463,8 +443,7 @@ tagger C O Mitter <committer@example.com> $4 -0700
 EOF
 }
 
-test_expect_success \
-	'creating an annotated tag with -m message should succeed' '
+test_expect_success 'creating an annotated tag with -m message should succeed' '
 	commit=$(git rev-parse HEAD) &&
 	time=$test_tick &&
 	get_tag_header annotated-tag $commit commit $time >expect &&
@@ -481,8 +460,7 @@ test_expect_success 'set up editor' '
 	EOF
 '
 
-test_expect_success \
-	'creating an annotated tag with -m message --edit should succeed' '
+test_expect_success 'creating an annotated tag with -m message --edit should succeed' '
 	get_tag_header annotated-tag-edit $commit commit $time >expect &&
 	echo "An edited message" >>expect &&
 	GIT_EDITOR=./fakeeditor git tag -m "A message" --edit annotated-tag-edit &&
@@ -490,8 +468,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'creating an annotated tag with -F messagefile should succeed' '
+test_expect_success 'creating an annotated tag with -F messagefile should succeed' '
 	cat >msgfile <<-\EOF &&
 	Another message
 	in a file.
@@ -510,8 +487,7 @@ test_expect_success 'set up editor' '
 	EOF
 '
 
-test_expect_success \
-	'creating an annotated tag with -F messagefile --edit should succeed' '
+test_expect_success 'creating an annotated tag with -F messagefile --edit should succeed' '
 	get_tag_header file-annotated-tag-edit $commit commit $time >expect &&
 	sed -e "s/Another message/Another edited message/g" msgfile >>expect &&
 	GIT_EDITOR=./fakeeditor git tag -F msgfile --edit file-annotated-tag-edit &&
@@ -531,16 +507,14 @@ test_expect_success 'creating an annotated tag with -F - should succeed' '
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
@@ -554,16 +528,14 @@ test_expect_success \
 
 # blank and empty messages:
 
-test_expect_success \
-	'creating a tag with an empty -m message should succeed' '
+test_expect_success 'creating a tag with an empty -m message should succeed' '
 	get_tag_header empty-annotated-tag $commit commit $time >expect &&
 	git tag -m "" empty-annotated-tag &&
 	get_tag_msg empty-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'creating a tag with an empty -F messagefile should succeed' '
+test_expect_success 'creating a tag with an empty -F messagefile should succeed' '
 	>emptyfile &&
 	get_tag_header emptyfile-annotated-tag $commit commit $time >expect &&
 	git tag -F emptyfile emptyfile-annotated-tag &&
@@ -571,8 +543,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'extra blanks in the message for an annotated tag should be removed' '
+test_expect_success 'extra blanks in the message for an annotated tag should be removed' '
 	printf "\n\n  \n\t\nLeading blank lines\n" >blanksfile &&
 	printf "\n\t \t  \nRepeated blank lines\n" >>blanksfile &&
 	printf "\n\n\nTrailing spaces      \t  \n" >>blanksfile &&
@@ -592,16 +563,14 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'creating a tag with blank -m message with spaces should succeed' '
+test_expect_success 'creating a tag with blank -m message with spaces should succeed' '
 	get_tag_header blank-annotated-tag $commit commit $time >expect &&
 	git tag -m "     " blank-annotated-tag &&
 	get_tag_msg blank-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'creating a tag with blank -F messagefile with spaces should succeed' '
+test_expect_success 'creating a tag with blank -F messagefile with spaces should succeed' '
 	echo "     " >blankfile &&
 	echo ""      >>blankfile &&
 	echo "  "    >>blankfile &&
@@ -611,8 +580,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'creating a tag with -F file of spaces and no newline should succeed' '
+test_expect_success 'creating a tag with -F file of spaces and no newline should succeed' '
 	printf "      " >blanknonlfile &&
 	get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect &&
 	git tag -F blanknonlfile blanknonlfile-annotated-tag &&
@@ -622,8 +590,7 @@ test_expect_success \
 
 # messages with commented lines:
 
-test_expect_success \
-	'creating a tag using a -F messagefile with #comments should succeed' '
+test_expect_success 'creating a tag using a -F messagefile with #comments should succeed' '
 	cat >commentsfile <<-\EOF &&
 	# A comment
 
@@ -655,16 +622,14 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'creating a tag with a #comment in the -m message should succeed' '
+test_expect_success 'creating a tag with a #comment in the -m message should succeed' '
 	get_tag_header comment-annotated-tag $commit commit $time >expect &&
 	git tag -m "#comment" comment-annotated-tag &&
 	get_tag_msg comment-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'creating a tag with #comments in the -F messagefile should succeed' '
+test_expect_success 'creating a tag with #comments in the -F messagefile should succeed' '
 	echo "#comment" >commentfile &&
 	echo ""         >>commentfile &&
 	echo "####"     >>commentfile &&
@@ -674,8 +639,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'creating a tag with a file of #comment and no newline should succeed' '
+test_expect_success 'creating a tag with a file of #comment and no newline should succeed' '
 	printf "#comment" >commentnonlfile &&
 	get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect &&
 	git tag -F commentnonlfile commentnonlfile-annotated-tag &&
@@ -794,8 +758,7 @@ test_expect_success 'bad editor causes panic when only --trailer is given' '
 
 # listing messages for annotated non-signed tags:
 
-test_expect_success \
-	'listing the one-line message of a non-signed tag should succeed' '
+test_expect_success 'listing the one-line message of a non-signed tag should succeed' '
 	git tag -m "A msg" tag-one-line &&
 
 	echo "tag-one-line" >expect &&
@@ -834,8 +797,7 @@ test_expect_success 'The -n 100 invocation means -n --list 100, not -n100' '
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing the zero-lines message of a non-signed tag should succeed' '
+test_expect_success 'listing the zero-lines message of a non-signed tag should succeed' '
 	git tag -m "" tag-zero-lines &&
 
 	echo "tag-zero-lines" >expect &&
@@ -859,8 +821,7 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-test_expect_success \
-	'listing many message lines of a non-signed tag should succeed' '
+test_expect_success 'listing many message lines of a non-signed tag should succeed' '
 	echo "tag line one" >annotagmsg &&
 	echo "tag line two" >>annotagmsg &&
 	echo "tag line three" >>annotagmsg  &&
@@ -951,20 +912,17 @@ test_expect_success 'git tag --format with ahead-behind' '
 
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
@@ -1021,8 +979,7 @@ test_expect_success GPG '-u implies signed tag' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'creating a signed tag with -F messagefile should succeed' '
+test_expect_success GPG 'creating a signed tag with -F messagefile should succeed' '
 	cat >sigmsgfile <<-\EOF &&
 	Another signed tag
 	message in a file.
@@ -1057,8 +1014,7 @@ test_expect_success GPG '-s implies annotated tag' '
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'git tag -s implied if configured with tag.forcesignannotated' \
+test_expect_success GPG 'git tag -s implied if configured with tag.forcesignannotated' \
 	'get_tag_header forcesignannotated-implied-sign $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
@@ -1068,16 +1024,14 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'lightweight with no message when configured with tag.forcesignannotated' \
+test_expect_success GPG 'lightweight with no message when configured with tag.forcesignannotated' \
 	'test_config tag.forcesignannotated true &&
 	git tag forcesignannotated-lightweight &&
 	tag_exists forcesignannotated-lightweight &&
 	test_must_fail git tag -v forcesignannotated-no-message
 '
 
-test_expect_success GPG \
-	'git tag -a disable configured tag.forcesignannotated' \
+test_expect_success GPG 'git tag -a disable configured tag.forcesignannotated' \
 	'get_tag_header forcesignannotated-annotate $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	test_config tag.forcesignannotated true &&
@@ -1087,8 +1041,7 @@ test_expect_success GPG \
 	test_must_fail git tag -v forcesignannotated-annotate
 '
 
-test_expect_success GPG \
-	'git tag --sign enable GPG sign' \
+test_expect_success GPG 'git tag --sign enable GPG sign' \
 	'get_tag_header forcesignannotated-disabled $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
@@ -1098,8 +1051,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'git tag configured tag.gpgsign enables GPG sign' \
+test_expect_success GPG 'git tag configured tag.gpgsign enables GPG sign' \
 	'get_tag_header gpgsign-enabled $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
@@ -1109,8 +1061,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'git tag --no-sign configured tag.gpgsign skip GPG sign' \
+test_expect_success GPG 'git tag --no-sign configured tag.gpgsign skip GPG sign' \
 	'get_tag_header no-sign $commit commit $time >expect &&
 	echo "A message" >>expect &&
 	test_config tag.gpgsign true &&
@@ -1119,8 +1070,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'trying to create a signed tag with non-existing -F file should fail' '
+test_expect_success GPG 'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists nosigtag &&
 	test_must_fail git tag -s -F nonexistingfile nosigtag &&
@@ -1133,8 +1083,7 @@ test_expect_success GPG 'verifying a signed tag should succeed' \
 test_expect_success GPG 'verifying two signed tags in one command should succeed' \
 	'git tag -v signed-tag file-signed-tag'
 
-test_expect_success GPG \
-	'verifying many signed and non-signed tags should fail' '
+test_expect_success GPG 'verifying many signed and non-signed tags should fail' '
 	test_must_fail git tag -v signed-tag annotated-tag &&
 	test_must_fail git tag -v file-annotated-tag file-signed-tag &&
 	test_must_fail git tag -v annotated-tag \
@@ -1165,8 +1114,7 @@ test_expect_success GPG 'verifying a forged tag with --format should fail silent
 
 # blank and empty messages for signed tags:
 
-test_expect_success GPG \
-	'creating a signed tag with an empty -m message should succeed' '
+test_expect_success GPG 'creating a signed tag with an empty -m message should succeed' '
 	get_tag_header empty-signed-tag $commit commit $time >expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "" empty-signed-tag &&
@@ -1175,8 +1123,7 @@ test_expect_success GPG \
 	git tag -v empty-signed-tag
 '
 
-test_expect_success GPG \
-	'creating a signed tag with an empty -F messagefile should succeed' '
+test_expect_success GPG 'creating a signed tag with an empty -F messagefile should succeed' '
 	>sigemptyfile &&
 	get_tag_header emptyfile-signed-tag $commit commit $time >expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
@@ -1186,8 +1133,7 @@ test_expect_success GPG \
 	git tag -v emptyfile-signed-tag
 '
 
-test_expect_success GPG \
-	'extra blanks in the message for a signed tag should be removed' '
+test_expect_success GPG 'extra blanks in the message for a signed tag should be removed' '
 	printf "\n\n  \n\t\nLeading blank lines\n" >sigblanksfile &&
 	printf "\n\t \t  \nRepeated blank lines\n" >>sigblanksfile &&
 	printf "\n\n\nTrailing spaces      \t  \n" >>sigblanksfile &&
@@ -1209,8 +1155,7 @@ test_expect_success GPG \
 	git tag -v blanks-signed-tag
 '
 
-test_expect_success GPG \
-	'creating a signed tag with a blank -m message should succeed' '
+test_expect_success GPG 'creating a signed tag with a blank -m message should succeed' '
 	get_tag_header blank-signed-tag $commit commit $time >expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "     " blank-signed-tag &&
@@ -1219,8 +1164,7 @@ test_expect_success GPG \
 	git tag -v blank-signed-tag
 '
 
-test_expect_success GPG \
-	'creating a signed tag with blank -F file with spaces should succeed' '
+test_expect_success GPG 'creating a signed tag with blank -F file with spaces should succeed' '
 	echo "     " >sigblankfile &&
 	echo ""      >>sigblankfile &&
 	echo "  "    >>sigblankfile &&
@@ -1232,8 +1176,7 @@ test_expect_success GPG \
 	git tag -v blankfile-signed-tag
 '
 
-test_expect_success GPG \
-	'creating a signed tag with spaces and no newline should succeed' '
+test_expect_success GPG 'creating a signed tag with spaces and no newline should succeed' '
 	printf "      " >sigblanknonlfile &&
 	get_tag_header blanknonlfile-signed-tag $commit commit $time >expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
@@ -1256,8 +1199,7 @@ test_expect_success GPG 'signed tag with embedded PGP message' '
 
 # messages with commented lines for signed tags:
 
-test_expect_success GPG \
-	'creating a signed tag with a -F file with #comments should succeed' '
+test_expect_success GPG 'creating a signed tag with a -F file with #comments should succeed' '
 	cat >sigcommentsfile <<-\EOF &&
 	# A comment
 
@@ -1291,8 +1233,7 @@ test_expect_success GPG \
 	git tag -v comments-signed-tag
 '
 
-test_expect_success GPG \
-	'creating a signed tag with #commented -m message should succeed' '
+test_expect_success GPG 'creating a signed tag with #commented -m message should succeed' '
 	get_tag_header comment-signed-tag $commit commit $time >expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "#comment" comment-signed-tag &&
@@ -1301,8 +1242,7 @@ test_expect_success GPG \
 	git tag -v comment-signed-tag
 '
 
-test_expect_success GPG \
-	'creating a signed tag with #commented -F messagefile should succeed' '
+test_expect_success GPG 'creating a signed tag with #commented -F messagefile should succeed' '
 	echo "#comment" >sigcommentfile &&
 	echo ""         >>sigcommentfile &&
 	echo "####"     >>sigcommentfile &&
@@ -1314,8 +1254,7 @@ test_expect_success GPG \
 	git tag -v commentfile-signed-tag
 '
 
-test_expect_success GPG \
-	'creating a signed tag with a #comment and no newline should succeed' '
+test_expect_success GPG 'creating a signed tag with a #comment and no newline should succeed' '
 	printf "#comment" >sigcommentnonlfile &&
 	get_tag_header commentnonlfile-signed-tag $commit commit $time >expect &&
 	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
@@ -1327,8 +1266,7 @@ test_expect_success GPG \
 
 # listing messages for signed tags:
 
-test_expect_success GPG \
-	'listing the one-line message of a signed tag should succeed' '
+test_expect_success GPG 'listing the one-line message of a signed tag should succeed' '
 	git tag -s -m "A message line signed" stag-one-line &&
 
 	echo "stag-one-line" >expect &&
@@ -1352,8 +1290,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'listing the zero-lines message of a signed tag should succeed' '
+test_expect_success GPG 'listing the zero-lines message of a signed tag should succeed' '
 	git tag -s -m "" stag-zero-lines &&
 
 	echo "stag-zero-lines" >expect &&
@@ -1377,8 +1314,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'listing many message lines of a signed tag should succeed' '
+test_expect_success GPG 'listing many message lines of a signed tag should succeed' '
 	echo "stag line one" >sigtagmsg &&
 	echo "stag line two" >>sigtagmsg &&
 	echo "stag line three" >>sigtagmsg &&
@@ -1423,8 +1359,7 @@ test_expect_success GPG \
 
 # tags pointing to objects different from commits:
 
-test_expect_success GPG \
-	'creating a signed tag pointing to a tree should succeed' '
+test_expect_success GPG 'creating a signed tag pointing to a tree should succeed' '
 	tree=$(git rev-parse HEAD^{tree}) &&
 	get_tag_header tree-signed-tag $tree tree $time >expect &&
 	echo "A message for a tree" >>expect &&
@@ -1434,8 +1369,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'creating a signed tag pointing to a blob should succeed' '
+test_expect_success GPG 'creating a signed tag pointing to a blob should succeed' '
 	blob=$(git rev-parse HEAD:foo) &&
 	get_tag_header blob-signed-tag $blob blob $time >expect &&
 	echo "A message for a blob" >>expect &&
@@ -1445,8 +1379,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'creating a signed tag pointing to another tag should succeed' '
+test_expect_success GPG 'creating a signed tag pointing to another tag should succeed' '
 	tag=$(git rev-parse signed-tag 2>/dev/null) &&
 	get_tag_header tag-signed-tag $tag tag $time >expect &&
 	echo "A message for another tag" >>expect &&
@@ -1458,8 +1391,7 @@ test_expect_success GPG \
 
 # usage with rfc1991 signatures
 
-test_expect_success GPG,RFC1991 \
-	'creating a signed tag with rfc1991' '
+test_expect_success GPG,RFC1991 'creating a signed tag with rfc1991' '
 	get_tag_header rfc1991-signed-tag $commit commit $time >expect &&
 	echo "RFC1991 signed tag" >>expect &&
 	echo "-----BEGIN PGP MESSAGE-----" >>expect &&
@@ -1469,8 +1401,7 @@ test_expect_success GPG,RFC1991 \
 	test_cmp expect actual
 '
 
-test_expect_success GPG,RFC1991 \
-	'reediting a signed tag body omits signature' '
+test_expect_success GPG,RFC1991 'reediting a signed tag body omits signature' '
 	cat >fakeeditor <<-\EOF &&
 	#!/bin/sh
 	cp "$1" actual
@@ -1482,14 +1413,12 @@ test_expect_success GPG,RFC1991 \
 	test_cmp expect actual
 '
 
-test_expect_success GPG,RFC1991 \
-	'verifying rfc1991 signature' '
+test_expect_success GPG,RFC1991 'verifying rfc1991 signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG,RFC1991 \
-	'list tag with rfc1991 signature' '
+test_expect_success GPG,RFC1991 'list tag with rfc1991 signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
@@ -1500,14 +1429,12 @@ test_expect_success GPG,RFC1991 \
 	test_cmp expect actual
 '
 
-test_expect_success GPG,RFC1991 \
-	'verifying rfc1991 signature without --rfc1991' '
+test_expect_success GPG,RFC1991 'verifying rfc1991 signature without --rfc1991' '
 	rm -f gpghome/gpg.conf &&
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG,RFC1991 \
-	'list tag with rfc1991 signature without --rfc1991' '
+test_expect_success GPG,RFC1991 'list tag with rfc1991 signature without --rfc1991' '
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1517,22 +1444,19 @@ test_expect_success GPG,RFC1991 \
 	test_cmp expect actual
 '
 
-test_expect_success GPG,RFC1991 \
-	'reediting a signed tag body omits signature' '
+test_expect_success GPG,RFC1991 'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
 '
 
 # try to sign with bad user.signingkey
-test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured (bad key)' \
+test_expect_success GPG 'git tag -s fails if gpg is misconfigured (bad key)' \
 	'test_config user.signingkey BobTheMouse &&
 	test_must_fail git tag -s -m tail tag-gpg-failure'
 
 # try to produce invalid signature
-test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured (bad signature format)' \
+test_expect_success GPG 'git tag -s fails if gpg is misconfigured (bad signature format)' \
 	'test_config gpg.program echo &&
 	 test_must_fail git tag -s -m tail tag-gpg-failure'
 
@@ -1555,34 +1479,29 @@ test_expect_success GPG 'git verifies tag is valid with double signature' '
 '
 
 # try to sign with bad user.signingkey
-test_expect_success GPGSM \
-	'git tag -s fails if gpgsm is misconfigured (bad key)' \
+test_expect_success GPGSM 'git tag -s fails if gpgsm is misconfigured (bad key)' \
 	'test_config user.signingkey BobTheMouse &&
 	 test_config gpg.format x509 &&
 	 test_must_fail git tag -s -m tail tag-gpg-failure'
 
 # try to produce invalid signature
-test_expect_success GPGSM \
-	'git tag -s fails if gpgsm is misconfigured (bad signature format)' \
+test_expect_success GPGSM 'git tag -s fails if gpgsm is misconfigured (bad signature format)' \
 	'test_config gpg.x509.program echo &&
 	 test_config gpg.format x509 &&
 	 test_must_fail git tag -s -m tail tag-gpg-failure'
 
 # try to verify without gpg:
 
-test_expect_success GPG \
-	'verify signed tag fails when public key is not present' \
+test_expect_success GPG 'verify signed tag fails when public key is not present' \
 	'rm -rf gpghome &&
 	test_must_fail git tag -v signed-tag
 '
 
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
 
@@ -1593,15 +1512,13 @@ test_expect_success 'message in editor has initial comment: first line' '
 	test_cmp first.expect first.actual
 '
 
-test_expect_success \
-	'message in editor has initial comment: remainder' '
+test_expect_success 'message in editor has initial comment: remainder' '
 	# remove commented lines from the remainder -- should be empty
 	sed -e 1d -e "/^#/d" <actual >rest.actual &&
 	test_must_be_empty rest.actual
 '
 
-test_expect_success \
-	'overwriting an annotated tag should use its previous body' '
+test_expect_success 'overwriting an annotated tag should use its previous body' '
 	get_tag_header reuse $commit commit $time >expect &&
 	echo "An annotation to be reused" >>expect &&
 	git tag -a -m "An annotation to be reused" reuse &&
-- 
2.43.0

