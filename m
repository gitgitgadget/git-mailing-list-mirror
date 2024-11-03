Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A2A31
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730641883; cv=none; b=tE5FueIKpIrdUHD1zwE4NG/wMgz1Nu8AGVPWc0cAuQ7GBGx7C9BEjM9M89ngYdlokb29RyGEde2wrnvBeMUR/i+og9DYkogdmFROVJ41y2SEDFLwsqJ+q1xVjDm5E/T3XCXgRA8LXkyvxY5NaOKpK6xDv9F68O9WNwTVodZXTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730641883; c=relaxed/simple;
	bh=F1xiRaceK7h/sugb11rhpb6j7T8mSygZC6XmCuVTjNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CS65/tHr25+bBOZo7mZECVi8JPJv2bJBfjAsCuFaQ/rh6oPYla21G9iVAg6Grh66nsmSLo8TAUmfONKTO0WimVjsY1DMlgjDBl9h+vlOvR06OOfunLfmVpQshBYKoWoIciPZE9zTLr283tyy9vnFcmXIBBViP0jAcf0tOSBHqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0CphiKN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0CphiKN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so27257535e9.3
        for <git@vger.kernel.org>; Sun, 03 Nov 2024 05:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730641880; x=1731246680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erahv5ypacb4wF2nj7NF4GcDfXTxeXdzQzBug/JoFSs=;
        b=I0CphiKN1RrU1by7Yk0heERfwRH9u494XSzQ0ko7aWnkTmYrVwYgb+lu5YP7CatSr3
         rhzDKV1bYt3GZiY0rvzEaAQTjDXNZTRgJIrUpM52VxE/TzDUew0OfNmKmq3F8rwhF6Ys
         +a8xd3X4JGYA3o5GjiHahWwuUvmrGsII5PwUK7nu41B9rKWzJ55xxbPb9dy5LAQbu/XZ
         3rEhDM9BtdxqBH0fOo1Trq0bo9e6z3Oke+ri4NoOg0nww7gj8cJKtVMGQcaLmr3vKaHL
         RE7JJ/EXhuaUd98DjOXyqRuKNhfRl5mMaNVbdtb/oQI6saKhsXqNe0fqPJBJp7ytEO9M
         Ss4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730641880; x=1731246680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Erahv5ypacb4wF2nj7NF4GcDfXTxeXdzQzBug/JoFSs=;
        b=wk0nvBKcIJ+VaRpZoLybTHv+LdZsaBPiYCR/4eqBuYEWA1jow0T8zyTj1b7Bw1cbNk
         B97Tm2PxJhrkpWQQ8wG5Q03xjFYSCqt8IGNe0AGJ9NG4jJAWNABnAdWDv9UPCL8x8PIg
         EPeUP5M9B4VTKE6CZc120AP6YKdbAJDwyuaLSRjzz9yY5PA4bAraBrpBNQQ7I7PaS0K0
         M1PAEynXfg4zUTxrJp7uRKJkVlsBD07urIXbcqmswIaJSmdwsCF/v979smX++FASMzCC
         oF6wsZ9a+6F6PupuxS12PfKHR4JwpiKe3y8fT+wXGMJEe6HxKunUYTQkrSQvgRZcm70e
         qPQw==
X-Gm-Message-State: AOJu0YzTJaJAu4/hcLJ1RwM+Qaw9Wiwuggtt3wKNk9LBu9kFhazZZ6gv
	4pDCK0CsOvx9tEziwZkhT2uhcJ9iLF3p4IsxFqFenMJsCkj+M+aT0WCNt2kz
X-Google-Smtp-Source: AGHT+IEIBoejEXCF0CK6HnldN1RkfcH0MZLjXIEE1Yiil3npliA5pyJ/U9AU5C/xomQRo7Hs5ulw3A==
X-Received: by 2002:a05:600c:45cd:b0:431:5970:806f with SMTP id 5b1f17b1804b1-4319ad34bd6mr266553115e9.34.1730641879551;
        Sun, 03 Nov 2024 05:51:19 -0800 (PST)
Received: from void.void ([141.226.12.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca7ebsm154622355e9.42.2024.11.03.05.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 05:51:19 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2] t1016: clean up style
Date: Sun,  3 Nov 2024 15:50:42 +0200
Message-ID: <20241103135111.13508-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.229.g8f8d6eee53
In-Reply-To: <20241102165534.17112-1-algonell@gmail.com>
References: <20241102165534.17112-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Documentation/CodingGuidelines:
  - Whitespace and redirect operator.
  - Case arms indentation.
  - Tabs for indentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
v2:
  - Base on: "The seventh batch".
  - Remove the extra line in between functions.
  - Elaborate on the changes (thank you, Kristoffer).

 t/t1016-compatObjectFormat.sh | 262 +++++++++++++++++-----------------
 1 file changed, 130 insertions(+), 132 deletions(-)

diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 8341a2fe83..32e0af392e 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -24,84 +24,83 @@ TEST_PASSES_SANITIZE_LEAK=true
 # the commit is identical to the commit in the other repository.
 
 compat_hash () {
-    case "$1" in
-    "sha1")
-	echo "sha256"
-	;;
-    "sha256")
-	echo "sha1"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "sha256"
+		;;
+	"sha256")
+		echo "sha1"
+		;;
+	esac
 }
 
 hello_oid () {
-    case "$1" in
-    "sha1")
-	echo "$hello_sha1_oid"
-	;;
-    "sha256")
-	echo "$hello_sha256_oid"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "$hello_sha1_oid"
+		;;
+	"sha256")
+		echo "$hello_sha256_oid"
+		;;
+	esac
 }
 
 tree_oid () {
-    case "$1" in
-    "sha1")
-	echo "$tree_sha1_oid"
-	;;
-    "sha256")
-	echo "$tree_sha256_oid"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "$tree_sha1_oid"
+		;;
+	"sha256")
+		echo "$tree_sha256_oid"
+		;;
+	esac
 }
 
 commit_oid () {
-    case "$1" in
-    "sha1")
-	echo "$commit_sha1_oid"
-	;;
-    "sha256")
-	echo "$commit_sha256_oid"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "$commit_sha1_oid"
+		;;
+	"sha256")
+		echo "$commit_sha256_oid"
+		;;
+	esac
 }
 
 commit2_oid () {
-    case "$1" in
-    "sha1")
-	echo "$commit2_sha1_oid"
-	;;
-    "sha256")
-	echo "$commit2_sha256_oid"
-	;;
-    esac
+	case "$1" in
+	"sha1")
+		echo "$commit2_sha1_oid"
+		;;
+	"sha256")
+		echo "$commit2_sha256_oid"
+		;;
+	esac
 }
 
 del_sigcommit () {
-    local delete="$1"
-
-    if test "$delete" = "sha256" ; then
-	local pattern="gpgsig-sha256"
-    else
-	local pattern="gpgsig"
-    fi
-    test-tool delete-gpgsig "$pattern"
+	local delete="$1"
+
+	if test "$delete" = "sha256" ; then
+		local pattern="gpgsig-sha256"
+	else
+		local pattern="gpgsig"
+	fi
+	test-tool delete-gpgsig "$pattern"
 }
 
-
 del_sigtag () {
-    local storage="$1"
-    local delete="$2"
-
-    if test "$storage" = "$delete" ; then
-	local pattern="trailer"
-    elif test "$storage" = "sha256" ; then
-	local pattern="gpgsig"
-    else
-	local pattern="gpgsig-sha256"
-    fi
-    test-tool delete-gpgsig "$pattern"
+	local storage="$1"
+	local delete="$2"
+
+	if test "$storage" = "$delete" ; then
+		local pattern="trailer"
+	elif test "$storage" = "sha256" ; then
+		local pattern="gpgsig"
+	else
+		local pattern="gpgsig-sha256"
+	fi
+	test-tool delete-gpgsig "$pattern"
 }
 
 base=$(pwd)
@@ -146,9 +145,9 @@ do
 	'
 	test_expect_success "create a $hash branch" '
 		git checkout -b branch $(commit_oid $hash) &&
-		echo "More more more give me more!" > more &&
+		echo "More more more give me more!" >more &&
 		eval more_${hash}_oid=$(git hash-object more) &&
-		echo "Another and another and another" > another &&
+		echo "Another and another and another" >another &&
 		eval another_${hash}_oid=$(git hash-object another) &&
 		git update-index --add more another &&
 		git commit -m "Add more files!" &&
@@ -165,15 +164,15 @@ do
 	'
 	test_expect_success GPG2 "create additional $hash signed commits" '
 		git commit --gpg-sign --allow-empty -m "This is an additional signed commit" &&
-		git cat-file commit HEAD | del_sigcommit sha256 > "../${hash}_signedcommit3" &&
-		git cat-file commit HEAD | del_sigcommit sha1 > "../${hash}_signedcommit4" &&
+		git cat-file commit HEAD | del_sigcommit sha256 >"../${hash}_signedcommit3" &&
+		git cat-file commit HEAD | del_sigcommit sha1 >"../${hash}_signedcommit4" &&
 		eval signedcommit3_${hash}_oid=$(git hash-object -t commit -w ../${hash}_signedcommit3) &&
 		eval signedcommit4_${hash}_oid=$(git hash-object -t commit -w ../${hash}_signedcommit4)
 	'
 	test_expect_success GPG2 "create additional $hash signed tags" '
 		git tag -s -m "This is an additional signed tag" signedtag34 HEAD &&
-		git cat-file tag signedtag34 | del_sigtag "${hash}" sha256 > ../${hash}_signedtag3 &&
-		git cat-file tag signedtag34 | del_sigtag "${hash}" sha1 > ../${hash}_signedtag4 &&
+		git cat-file tag signedtag34 | del_sigtag "${hash}" sha256 >../${hash}_signedtag3 &&
+		git cat-file tag signedtag34 | del_sigtag "${hash}" sha1 >../${hash}_signedtag4 &&
 		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
 		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
 	'
@@ -181,81 +180,80 @@ done
 cd "$base"
 
 compare_oids () {
-    test "$#" = 5 && { local PREREQ="$1"; shift; } || PREREQ=
-    local type="$1"
-    local name="$2"
-    local sha1_oid="$3"
-    local sha256_oid="$4"
-
-    echo ${sha1_oid} > ${name}_sha1_expected
-    echo ${sha256_oid} > ${name}_sha256_expected
-    echo ${type} > ${name}_type_expected
-
-    git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} > ${name}_sha1_sha256_found
-    git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha256_sha1_found
-    local sha1_sha256_oid="$(cat ${name}_sha1_sha256_found)"
-    local sha256_sha1_oid="$(cat ${name}_sha256_sha1_found)"
-
-    test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
-	git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
-	test_cmp ${name}_sha1 ${name}_sha1_expected
-'
-
-    test_expect_success $PREREQ "Verify ${type} ${name}'s sha256 oid" '
-	git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} > ${name}_sha256 &&
-	test_cmp ${name}_sha256 ${name}_sha256_expected
-'
+	test "$#" = 5 && { local PREREQ="$1"; shift; } || PREREQ=
+	local type="$1"
+	local name="$2"
+	local sha1_oid="$3"
+	local sha256_oid="$4"
+
+	echo ${sha1_oid} >${name}_sha1_expected
+	echo ${sha256_oid} >${name}_sha256_expected
+	echo ${type} >${name}_type_expected
+
+	git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} >${name}_sha1_sha256_found
+	git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} >${name}_sha256_sha1_found
+	local sha1_sha256_oid="$(cat ${name}_sha1_sha256_found)"
+	local sha256_sha1_oid="$(cat ${name}_sha256_sha1_found)"
+
+	test_expect_success $PREREQ "Verify ${type} ${name}'s sha1 oid" '
+		git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} >${name}_sha1 &&
+		test_cmp ${name}_sha1 ${name}_sha1_expected
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha1 type" '
-	git --git-dir=repo-sha1/.git cat-file -t ${sha1_oid} > ${name}_type1 &&
-	git --git-dir=repo-sha256/.git cat-file -t ${sha256_sha1_oid} > ${name}_type2 &&
-	test_cmp ${name}_type1 ${name}_type2 &&
-	test_cmp ${name}_type1 ${name}_type_expected
-'
+	test_expect_success $PREREQ "Verify ${type} ${name}'s sha256 oid" '
+		git --git-dir=repo-sha1/.git rev-parse --output-object-format=sha256 ${sha1_oid} >${name}_sha256 &&
+		test_cmp ${name}_sha256 ${name}_sha256_expected
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha256 type" '
-	git --git-dir=repo-sha256/.git cat-file -t ${sha256_oid} > ${name}_type3 &&
-	git --git-dir=repo-sha1/.git cat-file -t ${sha1_sha256_oid} > ${name}_type4 &&
-	test_cmp ${name}_type3 ${name}_type4 &&
-	test_cmp ${name}_type3 ${name}_type_expected
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha1 type" '
+		git --git-dir=repo-sha1/.git cat-file -t ${sha1_oid} >${name}_type1 &&
+		git --git-dir=repo-sha256/.git cat-file -t ${sha256_sha1_oid} >${name}_type2 &&
+		test_cmp ${name}_type1 ${name}_type2 &&
+		test_cmp ${name}_type1 ${name}_type_expected
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha1 size" '
-	git --git-dir=repo-sha1/.git cat-file -s ${sha1_oid} > ${name}_size1 &&
-	git --git-dir=repo-sha256/.git cat-file -s ${sha256_sha1_oid} > ${name}_size2 &&
-	test_cmp ${name}_size1 ${name}_size2
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha256 type" '
+		git --git-dir=repo-sha256/.git cat-file -t ${sha256_oid} >${name}_type3 &&
+		git --git-dir=repo-sha1/.git cat-file -t ${sha1_sha256_oid} >${name}_type4 &&
+		test_cmp ${name}_type3 ${name}_type4 &&
+		test_cmp ${name}_type3 ${name}_type_expected
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha256 size" '
-	git --git-dir=repo-sha256/.git cat-file -s ${sha256_oid} > ${name}_size3 &&
-	git --git-dir=repo-sha1/.git cat-file -s ${sha1_sha256_oid} > ${name}_size4 &&
-	test_cmp ${name}_size3 ${name}_size4
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha1 size" '
+		git --git-dir=repo-sha1/.git cat-file -s ${sha1_oid} >${name}_size1 &&
+		git --git-dir=repo-sha256/.git cat-file -s ${sha256_sha1_oid} >${name}_size2 &&
+		test_cmp ${name}_size1 ${name}_size2
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha1 pretty content" '
-	git --git-dir=repo-sha1/.git cat-file -p ${sha1_oid} > ${name}_content1 &&
-	git --git-dir=repo-sha256/.git cat-file -p ${sha256_sha1_oid} > ${name}_content2 &&
-	test_cmp ${name}_content1 ${name}_content2
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha256 size" '
+		git --git-dir=repo-sha256/.git cat-file -s ${sha256_oid} >${name}_size3 &&
+		git --git-dir=repo-sha1/.git cat-file -s ${sha1_sha256_oid} >${name}_size4 &&
+		test_cmp ${name}_size3 ${name}_size4
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha256 pretty content" '
-	git --git-dir=repo-sha256/.git cat-file -p ${sha256_oid} > ${name}_content3 &&
-	git --git-dir=repo-sha1/.git cat-file -p ${sha1_sha256_oid} > ${name}_content4 &&
-	test_cmp ${name}_content3 ${name}_content4
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha1 pretty content" '
+		git --git-dir=repo-sha1/.git cat-file -p ${sha1_oid} >${name}_content1 &&
+		git --git-dir=repo-sha256/.git cat-file -p ${sha256_sha1_oid} >${name}_content2 &&
+		test_cmp ${name}_content1 ${name}_content2
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha1 content" '
-	git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_oid} > ${name}_content5 &&
-	git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_sha1_oid} > ${name}_content6 &&
-	test_cmp ${name}_content5 ${name}_content6
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha256 pretty content" '
+		git --git-dir=repo-sha256/.git cat-file -p ${sha256_oid} >${name}_content3 &&
+		git --git-dir=repo-sha1/.git cat-file -p ${sha1_sha256_oid} >${name}_content4 &&
+		test_cmp ${name}_content3 ${name}_content4
+	'
 
-    test_expect_success $PREREQ "Verify ${name}'s sha256 content" '
-	git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_oid} > ${name}_content7 &&
-	git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_sha256_oid} > ${name}_content8 &&
-	test_cmp ${name}_content7 ${name}_content8
-'
+	test_expect_success $PREREQ "Verify ${name}'s sha1 content" '
+		git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_oid} >${name}_content5 &&
+		git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_sha1_oid} >${name}_content6 &&
+		test_cmp ${name}_content5 ${name}_content6
+	'
 
+	test_expect_success $PREREQ "Verify ${name}'s sha256 content" '
+		git --git-dir=repo-sha256/.git cat-file ${type} ${sha256_oid} >${name}_content7 &&
+		git --git-dir=repo-sha1/.git cat-file ${type} ${sha1_sha256_oid} >${name}_content8 &&
+		test_cmp ${name}_content7 ${name}_content8
+	'
 }
 
 compare_oids 'blob' hello "$hello_sha1_oid" "$hello_sha256_oid"

Interdiff against v1:
  diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
  index 06449937a3..32e0af392e 100755
  --- a/t/t1016-compatObjectFormat.sh
  +++ b/t/t1016-compatObjectFormat.sh
  @@ -89,7 +89,6 @@ del_sigcommit () {
   	test-tool delete-gpgsig "$pattern"
   }
   
  -
   del_sigtag () {
   	local storage="$1"
   	local delete="$2"

Range-diff against v1:
1:  d83cddf1d3 ! 1:  e5a1dc0b77 t1016: clean up style
    @@ Metadata
      ## Commit message ##
         t1016: clean up style
     
    -    Remove whitespace after redirect operator.
    -
    -    Align mixed space/tab usages.
    +    Adhere to Documentation/CodingGuidelines:
    +      - Whitespace and redirect operator.
    +      - Case arms indentation.
    +      - Tabs for indentation.
     
         Signed-off-by: Andrew Kreimer <algonell@gmail.com>
     
    @@ t/t1016-compatObjectFormat.sh: TEST_PASSES_SANITIZE_LEAK=true
     +	test-tool delete-gpgsig "$pattern"
      }
      
    - 
    +-
      del_sigtag () {
     -    local storage="$1"
     -    local delete="$2"
-- 
2.47.0.229.g8f8d6eee53

