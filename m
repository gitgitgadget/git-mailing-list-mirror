Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D551DF985
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890561; cv=none; b=RdGGQ8otE+UhIPFufO0n11R1j1MGDDlwQehWWb7A8ayjKSlLuBbPVB1e3CG5hxuycaea/hW4cr7eEkKVPauKhEGG/qnF40lVHoakezDYiOhv+EPePFy1k/T3MtsWQfEIR9+DeMkTkt5rgoz1fpc1mLxkiZ29MtxsGFC/QCOLMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890561; c=relaxed/simple;
	bh=hj6wYHz2+h3Obi2afptyUslYN38YypwrdEXX7hzBXDc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JJHlLuIvrqMuzQeB8SALydUqaaFHkrvNYFVRSsFCe0OgEc6PtY0CO4oFC/Gez0cFQXc2xC9Wx6P6A2qeogJGeUEjCMlihu9tCv69HEbCldBgg2+8m+SrTdHY3EMc8bQwlrpmcjo1CQAIAvHAnVCmG0VwaG3c4zrDRulS7/0Qm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTmpAmJj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTmpAmJj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a361b8a664so4625260f8f.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748890558; x=1749495358; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DT7V7ylko8TlQTE3Y4kkY4DPqAWqqG6ut19C2EhP8E=;
        b=BTmpAmJjGzNi/20cNNkh7R3FqDCRImeQKrzSi5Zgfsq4wwhcgILWIu0v9urE5PC+7m
         Bv5Wm/8vpkA0KKpuyEkwBenxLvaRK7nXhaJPf9Vv2vZL/u4hfJR8rXS/QToOcrgazKS2
         vyxGc5kGKSJZVlkGdfb0rj1ecjIKFxWbWH8HD0sDcwyxSX749yzy+sUDk4pr9Z42E00o
         sPsGb0L6OWNsrLKfLN2USdjosk0D6XGPtLss/la5jXJJMjt+84ccMRBwQ84KXamauCFD
         WCLivhz859AatlwwtD0M93VDk0sV/6Pk25gSZue9N/J6FbG0soaYtvuiF2aolNCM2vHw
         Kt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748890558; x=1749495358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DT7V7ylko8TlQTE3Y4kkY4DPqAWqqG6ut19C2EhP8E=;
        b=Bcw+d4tgXne1V1xIYcEwajK3SCOY4/sVri5XCFjNztK7WaorNmc6xq9Xri3oxDzhNY
         j3Lgl5fbHnXGRROBdQyN3Zc6KnAhRR1jpLupoUruHPmUc//5G94HQr0Jhviymo+aWOzX
         o3oy/OcIqatr4Adf4x3TkWqCM0VcQfx2jE2okUTVDKkCbgH7o55IS1hOkVboqoibGTmV
         qaUN4TpMWvrMe2+kta0yk22ZB05XE5Ex1RWaA0F82mUGJodGyoA+p4ZdEMo2Y/UXDkXa
         fPQeBUc0SVljwboAGtSCfuq9e3n1kqD92rA0VUHskWqa+b23y2O1Nz8/K2fAHMSMZqp8
         ykRQ==
X-Gm-Message-State: AOJu0Yw7hJoOYhujU/2i0U+b4389xu0NrsdoJRVWIBA+OhDweHM7r9km
	AtySP7KLT5Pp0KP7Qddg6US7zmx25ZFmZl+R6tte3vQD7dORPZ0hU2sgC2y2OQ==
X-Gm-Gg: ASbGncuWrxBARo6rn+dtQfXplKY/PsnMlTVZSH6rg/Ieeg8ISeVCccjUfgKuWICOOPx
	A/k2+0qR6Jyw16nzIFCw6267jVScaaT21Ii23ZQVk9t3Knigqpb3pxR25bmjDYYbSoWUtKqbOkA
	XvOWWHwuvjsKYGnFzYimauCh3MfTD9n0rhczEotpOdY3uqL/IaOdL8UWE79X1bf/ZInYAMfcgoa
	qzF78wz/qIds8fw1C6K9iJtZOkt8T7DG/3F0i2YfZGkp7WjhDcgqexhS9c1JEm3OusIng4R8p5K
	mCaPE0NXttSkpg5zUvuWQQQVlVxkvqVvfSI1wfvBdwwNmV+m+Nqc
X-Google-Smtp-Source: AGHT+IFrs4Six5jl+Z94UHtFArDnK+QWB0lGqjWKvXon8nQlmQuuLPm8Odk7alTldAgOJ07ZSGVtcA==
X-Received: by 2002:a05:6000:18ab:b0:3a4:fb33:85ce with SMTP id ffacd0b85a97d-3a4fb3388bbmr10135344f8f.46.1748890557535;
        Mon, 02 Jun 2025 11:55:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b892sm16071894f8f.17.2025.06.02.11.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 11:55:57 -0700 (PDT)
Message-Id: <e05c5bea7143d54a5cdb2d9cbfe944409c891797.1748890555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Jun 2025 18:55:53 +0000
Subject: [PATCH 1/3] t1006: update 'run_tests' to test generic object
 specifiers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: peff@peff.net,
    gitster@pobox.com,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update the 'run_tests' test wrapper so that the first argument may refer to
any specifier that uniquely identifies an object (e.g. a ref name,
'<OID>:<path>', '<OID>^{<type>}', etc.), rather than only a full object ID.

Also add tests that use non-OID identifiers, ensuring appropriate parsing in
'cat-file'. The identifiers used in some of the added tests include a space,
which is incompatible with the '%(rest)' atom. To accommodate that without
removing the test case, use 'test_expect_failure' when 'object_name'
includes a space.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1006-cat-file.sh | 56 +++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 317da6869c88..7c9512a6b439 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -113,53 +113,54 @@ strlen () {
 
 run_tests () {
     type=$1
-    oid=$2
+    object_name="$2"
     size=$3
     content=$4
     pretty_content=$5
+    oid=${6:-"$object_name"}
 
     batch_output="$oid $type $size
 $content"
 
     test_expect_success "$type exists" '
-	git cat-file -e $oid
+	git cat-file -e "$object_name"
     '
 
     test_expect_success "Type of $type is correct" '
 	echo $type >expect &&
-	git cat-file -t $oid >actual &&
+	git cat-file -t "$object_name" >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Size of $type is correct" '
 	echo $size >expect &&
-	git cat-file -s $oid >actual &&
+	git cat-file -s "$object_name" >actual &&
 	test_cmp expect actual
     '
 
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
 	echo_without_newline "$content" >expect &&
-	git cat-file $type $oid >actual &&
+	git cat-file $type "$object_name" >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "Pretty content of $type is correct" '
 	echo_without_newline "$pretty_content" >expect &&
-	git cat-file -p $oid >actual &&
+	git cat-file -p "$object_name" >actual &&
 	test_cmp expect actual
     '
 
     test -z "$content" ||
     test_expect_success "--batch output of $type is correct" '
 	echo "$batch_output" >expect &&
-	echo $oid | git cat-file --batch >actual &&
+	echo "$object_name" | git cat-file --batch >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "--batch-check output of $type is correct" '
 	echo "$oid $type $size" >expect &&
-	echo_without_newline $oid | git cat-file --batch-check >actual &&
+	echo_without_newline "$object_name" | git cat-file --batch-check >actual &&
 	test_cmp expect actual
     '
 
@@ -168,13 +169,13 @@ $content"
 	test -z "$content" ||
 		test_expect_success "--batch-command $opt output of $type content is correct" '
 		echo "$batch_output" >expect &&
-		test_write_lines "contents $oid" | git cat-file --batch-command $opt >actual &&
+		test_write_lines "contents $object_name" | git cat-file --batch-command $opt >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "--batch-command $opt output of $type info is correct" '
 		echo "$oid $type $size" >expect &&
-		test_write_lines "info $oid" |
+		test_write_lines "info $object_name" |
 		git cat-file --batch-command $opt >actual &&
 		test_cmp expect actual
 	'
@@ -182,19 +183,28 @@ $content"
 
     test_expect_success "custom --batch-check format" '
 	echo "$type $oid" >expect &&
-	echo $oid | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
+	echo "$object_name" | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
 
     test_expect_success "custom --batch-command format" '
 	echo "$type $oid" >expect &&
-	echo "info $oid" | git cat-file --batch-command="%(objecttype) %(objectname)" >actual &&
+	echo "info $object_name" | git cat-file --batch-command="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
 
-    test_expect_success '--batch-check with %(rest)' '
+    # FIXME: %(rest) is incompatible with object names that include whitespace,
+    # e.g. HEAD:path/to/a/file with spaces. Use the resolved OID as input to
+    # test this instead of the raw object name.
+    if echo "$object_name" | grep " "; then
+	test_rest=test_expect_failure
+    else
+	test_rest=test_expect_success
+    fi
+
+    $test_rest '--batch-check with %(rest)' '
 	echo "$type this is some extra content" >expect &&
-	echo "$oid    this is some extra content" |
+	echo "$object_name    this is some extra content" |
 		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
 	test_cmp expect actual
     '
@@ -205,7 +215,7 @@ $content"
 		echo "$size" &&
 		echo "$content"
 	} >expect &&
-	echo $oid | git cat-file --batch="%(objectsize)" >actual &&
+	echo "$object_name" | git cat-file --batch="%(objectsize)" >actual &&
 	test_cmp expect actual
     '
 
@@ -215,7 +225,7 @@ $content"
 		echo "$type" &&
 		echo "$content"
 	} >expect &&
-	echo $oid | git cat-file --batch="%(objecttype)" >actual &&
+	echo "$object_name" | git cat-file --batch="%(objecttype)" >actual &&
 	test_cmp expect actual
     '
 }
@@ -230,6 +240,8 @@ test_expect_success "setup" '
 	git config extensions.compatobjectformat $test_compat_hash_algo &&
 	echo_without_newline "$hello_content" > hello &&
 	git update-index --add hello &&
+	echo_without_newline "$hello_content" > "path with spaces" &&
+	git update-index --add --chmod=+x "path with spaces" &&
 	git commit -m "add hello file"
 '
 
@@ -269,13 +281,17 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 
 tree_oid=$(git write-tree)
 tree_compat_oid=$(git rev-parse --output-object-format=$test_compat_hash_algo $tree_oid)
-tree_size=$(($(test_oid rawsz) + 13))
-tree_compat_size=$(($(test_oid --hash=compat rawsz) + 13))
-tree_pretty_content="100644 blob $hello_oid	hello${LF}"
-tree_compat_pretty_content="100644 blob $hello_compat_oid	hello${LF}"
+tree_size=$((2 * $(test_oid rawsz) + 13 + 24))
+tree_compat_size=$((2 * $(test_oid --hash=compat rawsz) + 13 + 24))
+tree_pretty_content="100644 blob $hello_oid	hello${LF}100755 blob $hello_oid	path with spaces${LF}"
+tree_compat_pretty_content="100644 blob $hello_compat_oid	hello${LF}100755 blob $hello_compat_oid	path with spaces${LF}"
 
 run_tests 'tree' $tree_oid $tree_size "" "$tree_pretty_content"
 run_tests 'tree' $tree_compat_oid $tree_compat_size "" "$tree_compat_pretty_content"
+run_tests 'blob' "$tree_oid:hello" $hello_size "" "$hello_content" $hello_oid
+run_tests 'blob' "$tree_compat_oid:hello" $hello_size "" "$hello_content" $hello_compat_oid
+run_tests 'blob' "$tree_oid:path with spaces" $hello_size "" "$hello_content" $hello_oid
+run_tests 'blob' "$tree_compat_oid:path with spaces" $hello_size "" "$hello_content" $hello_compat_oid
 
 commit_message="Initial commit"
 commit_oid=$(echo_without_newline "$commit_message" | git commit-tree $tree_oid)
-- 
gitgitgadget

