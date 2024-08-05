Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F41171E5F
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902394; cv=none; b=aIfABhrRkoQCBrUT9K5qkgr3IeXasGPxn/CkQT/w3YTi2ECjdtifmhp0KOv5yh8WFnOGhFfpPCwF77w3KTkrYYt6no30YrxeT9Wp+ncQEje12SXBAAL3mEHhW2198+PTnY1sgaOv/3hAJHd6jCJWALJAwdzJ/e40cJ1TeTW1D2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902394; c=relaxed/simple;
	bh=RpuHQfYY4V0BfWs8k1MU++uVI+RdqjReN+nIPYreOKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbpD+ijNN/7TXZITuE+2BBMttsn7wuMC3vXLFOPe/adhNvyNuDtvlKIfnhb34BVGNR72CIgRsA3jcOEk4R6XHL4MynlRS4g6x9SfQ1KUl3Yor1Iflggg8dwQNBDZcTgmNcLqbHrVdbETRpoTXyGhP6DW8gheg97JE+OFBNzFwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e51t8POD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e51t8POD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3685a564bafso19047f8f.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902389; x=1723507189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/L40F1LL42jix41JvUvPvCqg5ZdgSHeODzoxOGn/sc=;
        b=e51t8POD+4TBgJ/ynH+aPTBggOZEtlnDLwYmTb43QFpgP++ftOsHZSwQEAdF3uOkDT
         V+wcycfaVinizs0IStm0tImMOAX9OgJb+w4BAWKLl/mPjq9LsHmDThaonhOqL2GVNfkr
         5QBHA3o0olkv3odyMSDx+OIfW1yENqZ0U44ACwAPzo8wNhbBrVn6jMVaXMpxlCv097cL
         BWZT9Dpdj0ygI4OXWpjt8wJW573Wdh7qevFWZf3mhyIVp99Jd4eZIUOejP8d1KPVFne+
         ETR4g0T6bQsif6dFeJT3/2Myijxm1n80GQgsLlLhFmKr+ZBYUyEwIEWYjD0YuX5nFn3a
         MmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902389; x=1723507189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/L40F1LL42jix41JvUvPvCqg5ZdgSHeODzoxOGn/sc=;
        b=Mhy2HZXaA5JbgnuR1SICoR08GL3w0EGh7YRIu+wsuC2IGacJhZAVOclhKrGlhTOXkz
         nn4O2XsV14lXok5poU0x6mugro+JTCmAk8b/ETVf/97EiebhlBgLIOzI6O9YYOf8weXb
         SiGPCVOFNUBssAJ/1UBsKGOIOwHMni0UnLQAqDFgOjRltnc+K3JlwdL5g9wT+VgP2Ga+
         FK3lpwFhZyjKZ0hOY5U5vEfhj/0pURPRMGxwwJgo3rIThxVTufPkDVjDB3B8XvTfCnLc
         HTFePKeg+EBkgARAjgKThDRu9q3HewOR1TwZyNk1zil9ICEHta2JHO9Q5fnVAfn2lB+u
         xEGQ==
X-Gm-Message-State: AOJu0YwWzDa7TcdkX7DYa04dlQS27/ehuYWVNTtFiGt0zCAXwGBEn/rr
	YCeFXQMWWzXqEwlmWEyVi8EjgzMS/LvhgKCbO9IBa1Akuke0+dDeMmdWJGBL
X-Google-Smtp-Source: AGHT+IHLWiG0pajXvAj6zuOS0XPUn/gJK+0ouzrWn8RCK+41cDWk73xwCgjx7MVv36NteG4q7x9ooA==
X-Received: by 2002:a5d:64a1:0:b0:367:43ce:9c91 with SMTP id ffacd0b85a97d-36bbc0f9fb6mr10192867f8f.27.1722902388889;
        Mon, 05 Aug 2024 16:59:48 -0700 (PDT)
Received: from abdobngad.. ([197.40.47.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd074583sm11219065f8f.108.2024.08.05.16.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:59:48 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v4 4/8] [Newcomer] t7004: Do not prepare things outside test_expect_success
Date: Tue,  6 Aug 2024 02:59:13 +0300
Message-ID: <20240805235917.190699-5-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805235917.190699-1-abdobngad@gmail.com>
References: <20240805235917.190699-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not prepare expect and other things outside test_expect_success.
Also add '\' before EOF to avoid shell interpolation and '-' to allow
indentation of the body.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 698 +++++++++++++++++++++++++------------------------
 1 file changed, 360 insertions(+), 338 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index cfe7653317..b9fe58fbee 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -131,10 +131,10 @@ test_expect_success 'listing all tags if one exists should succeed' '
 	git tag
 '
 
-cat >expect <<EOF
-mytag
-EOF
 test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
+	cat >expect <<-\EOF &&
+	mytag
+	EOF
 	git tag -l -l >actual &&
 	test_cmp expect actual &&
 	git tag --list --list >actual &&
@@ -209,12 +209,12 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 	test_must_fail git tag -d unknown-tag
 '
 
-cat >expect <<EOF
-myhead
-mytag
-EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
+	cat >expect <<-\EOF &&
+	myhead
+	mytag
+	EOF
 	git tag -l >actual &&
 	test_cmp expect actual &&
 	git tag -d &&
@@ -252,18 +252,18 @@ test_expect_success 'trying to delete an already deleted tag should fail' \
 
 # listing various tags with pattern matching:
 
-cat >expect <<EOF
-a1
-aa1
-cba
-t210
-t211
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
 test_expect_success 'listing all tags should print them ordered' '
+	cat >expect <<-\EOF &&
+	a1
+	aa1
+	cba
+	t210
+	t211
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag v1.0.1 &&
 	git tag t211 &&
 	git tag aa1 &&
@@ -279,62 +279,62 @@ test_expect_success 'listing all tags should print them ordered' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-a1
-aa1
-cba
-EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
+	cat >expect <<-\EOF &&
+	a1
+	aa1
+	cba
+	EOF
 	rm *a* &&
 	git tag -l "*a*" >current &&
 	test_cmp expect current
 '
 
-cat >expect <<EOF
-v0.2.1
-v1.0.1
-EOF
 test_expect_success \
 	'listing tags with a suffix as pattern must print those matching' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0.1
+	EOF
 	git tag -l "*.1" >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-t210
-t211
-EOF
 test_expect_success \
 	'listing tags with a prefix as pattern must print those matching' '
+	cat >expect <<-\EOF &&
+	t210
+	t211
+	EOF
 	git tag -l "t21*" >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-a1
-EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
+	cat >expect <<-\EOF &&
+	a1
+	EOF
 	git tag -l a1 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-v1.0
-EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
+	cat >expect <<-\EOF &&
+	v1.0
+	EOF
 	git tag -l v1.0 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-v1.0.1
-v1.1.3
-EOF
 test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
+	cat >expect <<-\EOF &&
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v1.?.?" >actual &&
 	test_cmp expect actual
 '
@@ -345,19 +345,25 @@ test_expect_success \
 	test_must_be_empty actual
 '
 
-cat >expect <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
 test_expect_success \
 	'listing tags using v* should print only those having v' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v*" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'tag -l can accept multiple patterns' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v1*" "v0*" >actual &&
 	test_cmp expect actual
 '
@@ -371,6 +377,12 @@ test_expect_success 'tag -l can accept multiple patterns' '
 # out if we're going to break this long-documented form of taking
 # multiple patterns.
 test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documentation previously suggested' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v1*" -l "v0*" >actual &&
 	test_cmp expect actual
 '
@@ -453,68 +465,69 @@ tagger C O Mitter <committer@example.com> $4 -0700
 EOF
 }
 
-commit=$(git rev-parse HEAD)
-time=$test_tick
-
-get_tag_header annotated-tag $commit commit $time >expect
-echo "A message" >>expect
 test_expect_success \
 	'creating an annotated tag with -m message should succeed' '
+	commit=$(git rev-parse HEAD) &&
+	time=$test_tick &&
+	get_tag_header annotated-tag $commit commit $time >expect &&
+	echo "A message" >>expect &&
 	git tag -m "A message" annotated-tag &&
 	get_tag_msg annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header annotated-tag-edit $commit commit $time >expect
-echo "An edited message" >>expect
 test_expect_success 'set up editor' '
 	write_script fakeeditor <<-\EOF
 	sed -e "s/A message/An edited message/g" <"$1" >"$1-"
 	mv "$1-" "$1"
 	EOF
 '
+
 test_expect_success \
 	'creating an annotated tag with -m message --edit should succeed' '
+	get_tag_header annotated-tag-edit $commit commit $time >expect &&
+	echo "An edited message" >>expect &&
 	GIT_EDITOR=./fakeeditor git tag -m "A message" --edit annotated-tag-edit &&
 	get_tag_msg annotated-tag-edit >actual &&
 	test_cmp expect actual
 '
 
-cat >msgfile <<EOF
-Another message
-in a file.
-EOF
-get_tag_header file-annotated-tag $commit commit $time >expect
-cat msgfile >>expect
 test_expect_success \
 	'creating an annotated tag with -F messagefile should succeed' '
+	cat >msgfile <<-\EOF &&
+	Another message
+	in a file.
+	EOF
+	get_tag_header file-annotated-tag $commit commit $time >expect &&
+	cat msgfile >>expect &&
 	git tag -F msgfile file-annotated-tag &&
 	get_tag_msg file-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header file-annotated-tag-edit $commit commit $time >expect
-sed -e "s/Another message/Another edited message/g" msgfile >>expect
 test_expect_success 'set up editor' '
 	write_script fakeeditor <<-\EOF
 	sed -e "s/Another message/Another edited message/g" <"$1" >"$1-"
 	mv "$1-" "$1"
 	EOF
 '
+
 test_expect_success \
 	'creating an annotated tag with -F messagefile --edit should succeed' '
+	get_tag_header file-annotated-tag-edit $commit commit $time >expect &&
+	sed -e "s/Another message/Another edited message/g" msgfile >>expect &&
 	GIT_EDITOR=./fakeeditor git tag -F msgfile --edit file-annotated-tag-edit &&
 	get_tag_msg file-annotated-tag-edit >actual &&
 	test_cmp expect actual
 '
 
-cat >inputmsg <<EOF
-A message from the
-standard input
-EOF
-get_tag_header stdin-annotated-tag $commit commit $time >expect
-cat inputmsg >>expect
 test_expect_success 'creating an annotated tag with -F - should succeed' '
+	cat >inputmsg <<-\EOF &&
+	A message from the
+	standard input
+	EOF
+	get_tag_header stdin-annotated-tag $commit commit $time >expect &&
+	cat inputmsg >>expect &&
 	git tag -F - stdin-annotated-tag <inputmsg &&
 	get_tag_msg stdin-annotated-tag >actual &&
 	test_cmp expect actual
@@ -543,67 +556,67 @@ test_expect_success \
 
 # blank and empty messages:
 
-get_tag_header empty-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with an empty -m message should succeed' '
+	get_tag_header empty-annotated-tag $commit commit $time >expect &&
 	git tag -m "" empty-annotated-tag &&
 	get_tag_msg empty-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
->emptyfile
-get_tag_header emptyfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with an empty -F messagefile should succeed' '
+	>emptyfile &&
+	get_tag_header emptyfile-annotated-tag $commit commit $time >expect &&
 	git tag -F emptyfile emptyfile-annotated-tag &&
 	get_tag_msg emptyfile-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' >blanksfile
-printf '\n\t \t  \nRepeated blank lines\n' >>blanksfile
-printf '\n\n\nTrailing spaces      \t  \n' >>blanksfile
-printf '\nTrailing blank lines\n\n\t \n\n' >>blanksfile
-get_tag_header blanks-annotated-tag $commit commit $time >expect
-cat >>expect <<EOF
-Leading blank lines
+test_expect_success \
+	'extra blanks in the message for an annotated tag should be removed' '
+	printf "\n\n  \n\t\nLeading blank lines\n" >blanksfile &&
+	printf "\n\t \t  \nRepeated blank lines\n" >>blanksfile &&
+	printf "\n\n\nTrailing spaces      \t  \n" >>blanksfile &&
+	printf "\nTrailing blank lines\n\n\t \n\n" >>blanksfile &&
+	get_tag_header blanks-annotated-tag $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	Leading blank lines
 
-Repeated blank lines
+	Repeated blank lines
 
-Trailing spaces
+	Trailing spaces
 
-Trailing blank lines
-EOF
-test_expect_success \
-	'extra blanks in the message for an annotated tag should be removed' '
+	Trailing blank lines
+	EOF
 	git tag -F blanksfile blanks-annotated-tag &&
 	get_tag_msg blanks-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header blank-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with blank -m message with spaces should succeed' '
+	get_tag_header blank-annotated-tag $commit commit $time >expect &&
 	git tag -m "     " blank-annotated-tag &&
 	get_tag_msg blank-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-echo '     ' >blankfile
-echo ''      >>blankfile
-echo '  '    >>blankfile
-get_tag_header blankfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with blank -F messagefile with spaces should succeed' '
+	echo "     " >blankfile &&
+  echo ""      >>blankfile &&
+  echo "  "    >>blankfile &&
+  get_tag_header blankfile-annotated-tag $commit commit $time >expect &&
 	git tag -F blankfile blankfile-annotated-tag &&
 	get_tag_msg blankfile-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-printf '      ' >blanknonlfile
-get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with -F file of spaces and no newline should succeed' '
+	printf "      " >blanknonlfile &&
+  get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect &&
 	git tag -F blanknonlfile blanknonlfile-annotated-tag &&
 	get_tag_msg blanknonlfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -611,62 +624,62 @@ test_expect_success \
 
 # messages with commented lines:
 
-cat >commentsfile <<EOF
-# A comment
+test_expect_success \
+	'creating a tag using a -F messagefile with #comments should succeed' '
+	cat >commentsfile <<-\EOF &&
+	# A comment
 
-############
-The message.
-############
-One line.
+	############
+	The message.
+	############
+	One line.
 
 
-# commented lines
-# commented lines
+	# commented lines
+	# commented lines
 
-Another line.
-# comments
+	Another line.
+	# comments
 
-Last line.
-EOF
-get_tag_header comments-annotated-tag $commit commit $time >expect
-cat >>expect <<EOF
-The message.
-One line.
+	Last line.
+	EOF
+	get_tag_header comments-annotated-tag $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	The message.
+	One line.
 
-Another line.
+	Another line.
 
-Last line.
-EOF
-test_expect_success \
-	'creating a tag using a -F messagefile with #comments should succeed' '
+	Last line.
+	EOF
 	git tag -F commentsfile comments-annotated-tag &&
 	get_tag_msg comments-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header comment-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with a #comment in the -m message should succeed' '
+	get_tag_header comment-annotated-tag $commit commit $time >expect &&
 	git tag -m "#comment" comment-annotated-tag &&
 	get_tag_msg comment-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-echo '#comment' >commentfile
-echo ''         >>commentfile
-echo '####'     >>commentfile
-get_tag_header commentfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with #comments in the -F messagefile should succeed' '
+	echo "#comment" >commentfile &&
+	echo ""         >>commentfile &&
+	echo "####"     >>commentfile &&
+	get_tag_header commentfile-annotated-tag $commit commit $time >expect &&
 	git tag -F commentfile commentfile-annotated-tag &&
 	get_tag_msg commentfile-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-printf '#comment' >commentnonlfile
-get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with a file of #comment and no newline should succeed' '
+	printf "#comment" >commentnonlfile &&
+	get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect &&
 	git tag -F commentnonlfile commentnonlfile-annotated-tag &&
 	get_tag_msg commentnonlfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -848,11 +861,11 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-echo 'tag line one' >annotagmsg
-echo 'tag line two' >>annotagmsg
-echo 'tag line three' >>annotagmsg
 test_expect_success \
 	'listing many message lines of a non-signed tag should succeed' '
+	echo "tag line one" >annotagmsg &&
+  echo "tag line two" >>annotagmsg &&
+  echo "tag line three" >>annotagmsg  &&
 	git tag -F annotagmsg tag-lines &&
 
 	echo "tag-lines" >expect &&
@@ -960,20 +973,20 @@ test_expect_success GPG \
 
 # creating and verifying signed tags:
 
-get_tag_header signed-tag $commit commit $time >expect
-echo 'A signed tag message' >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG 'creating a signed tag with -m message should succeed' '
+	get_tag_header signed-tag $commit commit $time >expect &&
+	echo "A signed tag message" >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "A signed tag message" signed-tag &&
 	get_tag_msg signed-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header u-signed-tag $commit commit $time >expect
-echo 'Another message' >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG 'sign with a given key id' '
 
+	get_tag_header u-signed-tag $commit commit $time >expect &&
+	echo "Another message" >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -u committer@example.com -m "Another message" u-signed-tag &&
 	get_tag_msg u-signed-tag >actual &&
 	test_cmp expect actual
@@ -993,65 +1006,65 @@ test_expect_success GPG 'sign with an unknown id (2)' '
 
 '
 
-cat >fakeeditor <<'EOF'
-#!/bin/sh
-test -n "$1" && exec >"$1"
-echo A signed tag message
-echo from a fake editor.
-EOF
-chmod +x fakeeditor
-
-get_tag_header implied-sign $commit commit $time >expect
-./fakeeditor >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG '-u implies signed tag' '
+	cat >fakeeditor <<-\EOF &&
+	#!/bin/sh
+	test -n "$1" && exec >"$1"
+	echo A signed tag message
+	echo from a fake editor.
+	EOF
+	chmod +x fakeeditor &&
+
+	get_tag_header implied-sign $commit commit $time >expect &&
+	./fakeeditor >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	GIT_EDITOR=./fakeeditor git tag -u CDDE430D implied-sign &&
 	get_tag_msg implied-sign >actual &&
 	test_cmp expect actual
 '
 
-cat >sigmsgfile <<EOF
-Another signed tag
-message in a file.
-EOF
-get_tag_header file-signed-tag $commit commit $time >expect
-cat sigmsgfile >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with -F messagefile should succeed' '
+	cat >sigmsgfile <<-\EOF &&
+	Another signed tag
+	message in a file.
+	EOF
+	get_tag_header file-signed-tag $commit commit $time >expect &&
+	cat sigmsgfile >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F sigmsgfile file-signed-tag &&
 	get_tag_msg file-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-cat >siginputmsg <<EOF
-A signed tag message from
-the standard input
-EOF
-get_tag_header stdin-signed-tag $commit commit $time >expect
-cat siginputmsg >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG 'creating a signed tag with -F - should succeed' '
+	cat >siginputmsg <<-\EOF &&
+	A signed tag message from
+	the standard input
+	EOF
+	get_tag_header stdin-signed-tag $commit commit $time >expect &&
+	cat siginputmsg >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F - stdin-signed-tag <siginputmsg &&
 	get_tag_msg stdin-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header implied-annotate $commit commit $time >expect
-./fakeeditor >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG '-s implies annotated tag' '
+	get_tag_header implied-annotate $commit commit $time >expect &&
+	./fakeeditor >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	GIT_EDITOR=./fakeeditor git tag -s implied-annotate &&
 	get_tag_msg implied-annotate >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header forcesignannotated-implied-sign $commit commit $time >expect
-echo "A message" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'git tag -s implied if configured with tag.forcesignannotated' \
-	'test_config tag.forcesignannotated true &&
+	'get_tag_header forcesignannotated-implied-sign $commit commit $time >expect &&
+	echo "A message" >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
+	test_config tag.forcesignannotated true &&
 	git tag -m "A message" forcesignannotated-implied-sign &&
 	get_tag_msg forcesignannotated-implied-sign >actual &&
 	test_cmp expect actual
@@ -1065,44 +1078,44 @@ test_expect_success GPG \
 	test_must_fail git tag -v forcesignannotated-no-message
 '
 
-get_tag_header forcesignannotated-annotate $commit commit $time >expect
-echo "A message" >>expect
 test_expect_success GPG \
 	'git tag -a disable configured tag.forcesignannotated' \
-	'test_config tag.forcesignannotated true &&
+	'get_tag_header forcesignannotated-annotate $commit commit $time >expect &&
+	echo "A message" >>expect &&
+	test_config tag.forcesignannotated true &&
 	git tag -a -m "A message" forcesignannotated-annotate &&
 	get_tag_msg forcesignannotated-annotate >actual &&
 	test_cmp expect actual &&
 	test_must_fail git tag -v forcesignannotated-annotate
 '
 
-get_tag_header forcesignannotated-disabled $commit commit $time >expect
-echo "A message" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'git tag --sign enable GPG sign' \
-	'test_config tag.forcesignannotated false &&
+	'get_tag_header forcesignannotated-disabled $commit commit $time >expect &&
+	echo "A message" >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
+	test_config tag.forcesignannotated false &&
 	git tag --sign -m "A message" forcesignannotated-disabled &&
 	get_tag_msg forcesignannotated-disabled >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header gpgsign-enabled $commit commit $time >expect
-echo "A message" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'git tag configured tag.gpgsign enables GPG sign' \
-	'test_config tag.gpgsign true &&
+	'get_tag_header gpgsign-enabled $commit commit $time >expect &&
+	echo "A message" >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
+	test_config tag.gpgsign true &&
 	git tag -m "A message" gpgsign-enabled &&
 	get_tag_msg gpgsign-enabled>actual &&
 	test_cmp expect actual
 '
 
-get_tag_header no-sign $commit commit $time >expect
-echo "A message" >>expect
 test_expect_success GPG \
 	'git tag --no-sign configured tag.gpgsign skip GPG sign' \
-	'test_config tag.gpgsign true &&
+	'get_tag_header no-sign $commit commit $time >expect &&
+	echo "A message" >>expect &&
+	test_config tag.gpgsign true &&
 	git tag -a --no-sign -m "A message" no-sign &&
 	get_tag_msg no-sign>actual &&
 	test_cmp expect actual
@@ -1154,78 +1167,78 @@ test_expect_success GPG 'verifying a forged tag with --format should fail silent
 
 # blank and empty messages for signed tags:
 
-get_tag_header empty-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with an empty -m message should succeed' '
+	get_tag_header empty-signed-tag $commit commit $time >expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "" empty-signed-tag &&
 	get_tag_msg empty-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v empty-signed-tag
 '
 
->sigemptyfile
-get_tag_header emptyfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with an empty -F messagefile should succeed' '
+	>sigemptyfile &&
+	get_tag_header emptyfile-signed-tag $commit commit $time >expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F sigemptyfile emptyfile-signed-tag &&
 	get_tag_msg emptyfile-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v emptyfile-signed-tag
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' >sigblanksfile
-printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
-printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
-printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
-get_tag_header blanks-signed-tag $commit commit $time >expect
-cat >>expect <<EOF
-Leading blank lines
+test_expect_success GPG \
+	'extra blanks in the message for a signed tag should be removed' '
+	printf "\n\n  \n\t\nLeading blank lines\n" >sigblanksfile &&
+	printf "\n\t \t  \nRepeated blank lines\n" >>sigblanksfile &&
+	printf "\n\n\nTrailing spaces      \t  \n" >>sigblanksfile &&
+	printf "\nTrailing blank lines\n\n\t \n\n" >>sigblanksfile &&
+	get_tag_header blanks-signed-tag $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	Leading blank lines
 
-Repeated blank lines
+	Repeated blank lines
 
-Trailing spaces
+	Trailing spaces
 
-Trailing blank lines
-EOF
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'extra blanks in the message for a signed tag should be removed' '
+	Trailing blank lines
+	EOF
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F sigblanksfile blanks-signed-tag &&
 	get_tag_msg blanks-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v blanks-signed-tag
 '
 
-get_tag_header blank-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with a blank -m message should succeed' '
+	get_tag_header blank-signed-tag $commit commit $time >expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "     " blank-signed-tag &&
 	get_tag_msg blank-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v blank-signed-tag
 '
 
-echo '     ' >sigblankfile
-echo ''      >>sigblankfile
-echo '  '    >>sigblankfile
-get_tag_header blankfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with blank -F file with spaces should succeed' '
+	echo "     " >sigblankfile &&
+	echo ""      >>sigblankfile &&
+	echo "  "    >>sigblankfile &&
+	get_tag_header blankfile-signed-tag $commit commit $time >expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F sigblankfile blankfile-signed-tag &&
 	get_tag_msg blankfile-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v blankfile-signed-tag
 '
 
-printf '      ' >sigblanknonlfile
-get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with spaces and no newline should succeed' '
+	printf "      " >sigblanknonlfile &&
+	get_tag_header blanknonlfile-signed-tag $commit commit $time >expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
 	get_tag_msg blanknonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1245,69 +1258,69 @@ test_expect_success GPG 'signed tag with embedded PGP message' '
 
 # messages with commented lines for signed tags:
 
-cat >sigcommentsfile <<EOF
-# A comment
+test_expect_success GPG \
+	'creating a signed tag with a -F file with #comments should succeed' '
+	cat >sigcommentsfile <<-\EOF &&
+	# A comment
 
-############
-The message.
-############
-One line.
+	############
+	The message.
+	############
+	One line.
 
 
-# commented lines
-# commented lines
+	# commented lines
+	# commented lines
 
-Another line.
-# comments
+	Another line.
+	# comments
 
-Last line.
-EOF
-get_tag_header comments-signed-tag $commit commit $time >expect
-cat >>expect <<EOF
-The message.
-One line.
+	Last line.
+	EOF
+	get_tag_header comments-signed-tag $commit commit $time >expect &&
+	cat >>expect <<-\EOF &&
+	The message.
+	One line.
 
-Another line.
+	Another line.
 
-Last line.
-EOF
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with a -F file with #comments should succeed' '
+	Last line.
+	EOF
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F sigcommentsfile comments-signed-tag &&
 	get_tag_msg comments-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v comments-signed-tag
 '
 
-get_tag_header comment-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with #commented -m message should succeed' '
+	get_tag_header comment-signed-tag $commit commit $time >expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "#comment" comment-signed-tag &&
 	get_tag_msg comment-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v comment-signed-tag
 '
 
-echo '#comment' >sigcommentfile
-echo ''         >>sigcommentfile
-echo '####'     >>sigcommentfile
-get_tag_header commentfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with #commented -F messagefile should succeed' '
+	echo "#comment" >sigcommentfile &&
+	echo ""         >>sigcommentfile &&
+	echo "####"     >>sigcommentfile &&
+	get_tag_header commentfile-signed-tag $commit commit $time >expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F sigcommentfile commentfile-signed-tag &&
 	get_tag_msg commentfile-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v commentfile-signed-tag
 '
 
-printf '#comment' >sigcommentnonlfile
-get_tag_header commentnonlfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with a #comment and no newline should succeed' '
+	printf "#comment" >sigcommentnonlfile &&
+	get_tag_header commentnonlfile-signed-tag $commit commit $time >expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
 	get_tag_msg commentnonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1366,11 +1379,11 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-echo 'stag line one' >sigtagmsg
-echo 'stag line two' >>sigtagmsg
-echo 'stag line three' >>sigtagmsg
 test_expect_success GPG \
 	'listing many message lines of a signed tag should succeed' '
+	echo "stag line one" >sigtagmsg &&
+	echo "stag line two" >>sigtagmsg &&
+	echo "stag line three" >>sigtagmsg &&
 	git tag -s -F sigtagmsg stag-lines &&
 
 	echo "stag-lines" >expect &&
@@ -1412,60 +1425,59 @@ test_expect_success GPG \
 
 # tags pointing to objects different from commits:
 
-tree=$(git rev-parse HEAD^{tree})
-blob=$(git rev-parse HEAD:foo)
-tag=$(git rev-parse signed-tag 2>/dev/null)
-
-get_tag_header tree-signed-tag $tree tree $time >expect
-echo "A message for a tree" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag pointing to a tree should succeed' '
+	tree=$(git rev-parse HEAD^{tree}) &&
+	get_tag_header tree-signed-tag $tree tree $time >expect &&
+	echo "A message for a tree" >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
 	get_tag_msg tree-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header blob-signed-tag $blob blob $time >expect
-echo "A message for a blob" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag pointing to a blob should succeed' '
+	blob=$(git rev-parse HEAD:foo) &&
+	get_tag_header blob-signed-tag $blob blob $time >expect &&
+	echo "A message for a blob" >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
 	get_tag_msg blob-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header tag-signed-tag $tag tag $time >expect
-echo "A message for another tag" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag pointing to another tag should succeed' '
+	tag=$(git rev-parse signed-tag 2>/dev/null) &&
+	get_tag_header tag-signed-tag $tag tag $time >expect &&
+	echo "A message for another tag" >>expect &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect &&
 	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
 	get_tag_msg tag-signed-tag >actual &&
 	test_cmp expect actual
 '
 
 # usage with rfc1991 signatures
-get_tag_header rfc1991-signed-tag $commit commit $time >expect
-echo "RFC1991 signed tag" >>expect
-echo '-----BEGIN PGP MESSAGE-----' >>expect
+
 test_expect_success GPG,RFC1991 \
 	'creating a signed tag with rfc1991' '
+	get_tag_header rfc1991-signed-tag $commit commit $time >expect &&
+	echo "RFC1991 signed tag" >>expect &&
+	echo "-----BEGIN PGP MESSAGE-----" >>expect &&
 	echo "rfc1991" >gpghome/gpg.conf &&
 	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
 	get_tag_msg rfc1991-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-cat >fakeeditor <<'EOF'
-#!/bin/sh
-cp "$1" actual
-EOF
-chmod +x fakeeditor
-
 test_expect_success GPG,RFC1991 \
 	'reediting a signed tag body omits signature' '
+	cat >fakeeditor <<-\EOF &&
+	#!/bin/sh
+	cp "$1" actual
+	EOF
+	chmod +x fakeeditor &&
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
@@ -1490,10 +1502,9 @@ test_expect_success GPG,RFC1991 \
 	test_cmp expect actual
 '
 
-rm -f gpghome/gpg.conf
-
 test_expect_success GPG,RFC1991 \
 	'verifying rfc1991 signature without --rfc1991' '
+	rm -f gpghome/gpg.conf &&
 	git tag -v rfc1991-signed-tag
 '
 
@@ -1561,10 +1572,11 @@ test_expect_success GPGSM \
 
 # try to verify without gpg:
 
-rm -rf gpghome
 test_expect_success GPG \
 	'verify signed tag fails when public key is not present' \
-	'test_must_fail git tag -v signed-tag'
+	'rm -rf gpghome &&
+	test_must_fail git tag -v signed-tag
+'
 
 test_expect_success \
 	'git tag -a fails if tag annotation is empty' '
@@ -1590,10 +1602,10 @@ test_expect_success \
 	test_must_be_empty rest.actual
 '
 
-get_tag_header reuse $commit commit $time >expect
-echo "An annotation to be reused" >>expect
 test_expect_success \
 	'overwriting an annotated tag should use its previous body' '
+	get_tag_header reuse $commit commit $time >expect &&
+	echo "An annotation to be reused" >>expect &&
 	git tag -a -m "An annotation to be reused" reuse &&
 	GIT_EDITOR=true git tag -f -a reuse &&
 	get_tag_msg reuse >actual &&
@@ -1622,47 +1634,57 @@ test_expect_success 'filename for the message is relative to cwd' '
 
 # create a few more commits to test --contains
 
-hash1=$(git rev-parse HEAD)
-
 test_expect_success 'creating second commit and tag' '
+	hash1=$(git rev-parse HEAD) &&
 	echo foo-2.0 >foo &&
 	git add foo &&
 	git commit -m second &&
 	git tag v2.0
 '
 
-hash2=$(git rev-parse HEAD)
-
 test_expect_success 'creating third commit without tag' '
+	hash2=$(git rev-parse HEAD) &&
 	echo foo-dev >foo &&
 	git add foo &&
 	git commit -m third
 '
 
-hash3=$(git rev-parse HEAD)
-
 # simple linear checks of --continue
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-EOF
-
 test_expect_success 'checking that first commit is in all tags (hash)' "
+	hash3=$(git rev-parse HEAD) &&
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
 "
 
 # other ways of specifying the commit
 test_expect_success 'checking that first commit is in all tags (tag)' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --contains v1.0 v* >actual &&
 	test_cmp expected actual
 "
 
 test_expect_success 'checking that first commit is in all tags (relative)' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --contains HEAD~2 v* >actual &&
 	test_cmp expected actual
 "
@@ -1683,23 +1705,21 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 	test_must_be_empty actual
 "
 
-cat >expected <<EOF
-v2.0
-EOF
-
 test_expect_success 'checking that second commit only has one tag' "
+	cat >expected <<-\EOF &&
+	v2.0
+	EOF
 	git tag -l --contains $hash2 v* >actual &&
 	test_cmp expected actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
-
 test_expect_success 'inverse of the last test, with --no-contains' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l --no-contains $hash2 v* >actual &&
 	test_cmp expected actual
 "
@@ -1709,15 +1729,14 @@ test_expect_success 'checking that third commit has no tags' "
 	test_must_be_empty actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-EOF
-
 test_expect_success 'conversely --no-contains on the third commit lists all tags' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
@@ -1732,26 +1751,23 @@ test_expect_success 'creating simple branch' '
 	git tag v3.0
 '
 
-hash4=$(git rev-parse HEAD)
-
-cat >expected <<EOF
-v3.0
-EOF
-
-test_expect_success 'checking that branch head only has one tag' "
+test_expect_success 'checking that branch head only has one tag' '
+	hash4=$(git rev-parse HEAD) &&
+	cat >expected <<-\EOF &&
+	v3.0
+	EOF
 	git tag -l --contains $hash4 v* >actual &&
 	test_cmp expected actual
-"
-
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-EOF
+'
 
 test_expect_success 'checking that branch head with --no-contains lists all but one tag' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --no-contains $hash4 v* >actual &&
 	test_cmp expected actual
 "
@@ -1761,45 +1777,51 @@ test_expect_success 'merging original branch into this branch' '
         git tag v4.0
 '
 
-cat >expected <<EOF
-v4.0
-EOF
-
 test_expect_success 'checking that original branch head has one tag now' "
+	cat >expected <<-\EOF &&
+	v4.0
+	EOF
 	git tag -l --contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-v3.0
-EOF
-
 test_expect_success 'checking that original branch head with --no-contains lists all but one tag now' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
 
-cat >expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-v3.0
-v4.0
-EOF
-
 test_expect_success 'checking that initial commit is in all tags' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	v4.0
+	EOF
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
 "
 
 test_expect_success 'checking that --contains can be used in non-list mode' '
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	v4.0
+	EOF
 	git tag --contains $hash1 v* >actual &&
 	test_cmp expected actual
 '
-- 
2.43.0

