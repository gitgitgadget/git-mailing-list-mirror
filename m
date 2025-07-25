Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC58D2EE61C
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459564; cv=none; b=nsOshHuN/YAQPRIFnEye18dyzAjRTthALQ9ME7hLcQnqi+CPJ+c+QlQ2kbscYaiTTlsCikR0mG0w4AFFgD3pFzxPgkE5s4aXZGn4tf/cKkxJ7nxBa9j67zPRj2P+x9aSkbB3AaehQW+eXXDUr506YN6mhtu8BFzrYhES91PO5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459564; c=relaxed/simple;
	bh=Dy31fJy2Sf2UzxptRJWX5gbAlEzAwtC25j0C2sWHW88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YM7aalNjqtUf89DuA+jRN1R3I099Rp/bzP3oyKHGyzjPZ12wh8t+PeYkldluIYRMjoDZZsBOJ3RQ94kqtJs+5HaRPbSpNPvMmMjXyDfiEZ7r9Xg3zfNW9gzg8FmbXopVxo/ZbZ//MmiYoT06TBFzZnsrapPCwpxWy2FZGmMAL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8wfwFRk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8wfwFRk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a528243636so1483026f8f.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753459560; x=1754064360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tztyGDYsM0jteuR55BHhRCNoSGKrs6h321qr6J7NZyU=;
        b=X8wfwFRke6qxB4L9CSxlRQQ6KQiSB2Ah6oyLx65tv95do0qcoVka87kjcnzKP3zjux
         CpiWWVot6rzZdEF+bcKCL/daFXvMpzCuAauZwM9WWw1YWU6IpMNWiN2GoHvqFJZdwTv8
         KZWclL//bCEJHsBoSoJ2I700ZRNw+7qi/yrBm0H8g7A1o8IXK4pTxZ6OEMS8FmyfmhP0
         jbtwYOU046XsYOjwHEUtG3gCR93mCOiUIFPzbuZ7q2iEoSDZSnvDbpb7pFJfCaAcwx8Q
         I3gUlpofZQ7aVqM15l82kthQuyfneWrgEZjBP0PsdoJ+VNZSpuC73iEIqeXzGdOI1g7O
         ddHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753459560; x=1754064360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tztyGDYsM0jteuR55BHhRCNoSGKrs6h321qr6J7NZyU=;
        b=nudHZjf0pXDiQ+/hF/60Y+Y94UjxPo8NTeZVMtPAs1N7pif/U3p3bi3VtKuIqG6r5E
         oXUO93xAQQuy8vQKYqu/AakuedEcrN9KME8vBMl/7GPuspgemIYOUa6f557Iam39YFDW
         +aOzn9qakEAOiuIHKLeCtmgq/s6b4oohKxNJw9L+lOnEeceteeLmKT10v6ud6Ol24G34
         yNttSWMu6IR/eIUeM6a2W/XwH31ubv+fx3irPBPJey5S2XsE++lupOFBTOlxK1mU/F5Y
         amNx51G559vAZYmiLxC1IHPPp4aA8SKXEJv2kpMh8jPtX6T+FZAHBJc0H7QZj7geGL8N
         SVJQ==
X-Gm-Message-State: AOJu0YzEwPlmp/eJS+szUNn9Ps7DaCEXL1qFdgu9CB4Da2AJ801a+fgQ
	bB/0a0biZR7+cYlGxNB5cGysAuEWnjl76CyJMtNfZH/ms44UnhibwKg2Y0bMfg==
X-Gm-Gg: ASbGnctS2gtvItdNuJVw7CAisjUENmoQbZ8SBBQTsH/HTyQubGZdwYLvXa2l11/18Zp
	tUvQXcuqvzlvd6+NOhAjSIp2D7iyYMjbw95OOrMweq6wcWgjuXJKFwmjty+PUuiizFDgsQdyXZH
	6SPBWD4FfLNxN7cFJ7UEiJ/2g9ctWZCgKIajnw8xHD3V45wSemRK78Nw9u5LSqWzkZqR2ESy00Q
	HU+aqUXIpcyb96QNFqSEaawR0PFLVCCrWTqvMsK40HBXw8q0ofHU45iZzmE0Lw2i3C1pMWTi+Yi
	gZoMfuxN7h3SUV7IpPsxdh3z62L+ysvEY4JYnhzEZeYrpRFaJOFMePCVcOVMoctIwXztaegEMH1
	Qob7F9EXcpYhtOL5TByx7q38+WYB9wHm30GR1CoHoLTHyHAwGsBruhTQa6rjbn+AmCz5Oa64rVh
	Nilsd2
X-Google-Smtp-Source: AGHT+IHvUo/uC99BptUC/drRlBmMj952/V5Rfd5GmrgOI4spdV2M8BpVsozd3ImJLAWZTdf9JFQAlQ==
X-Received: by 2002:a05:6000:4382:b0:3a5:7991:ff6 with SMTP id ffacd0b85a97d-3b7765e5a6bmr2633279f8f.1.1753459559938;
        Fri, 25 Jul 2025 09:05:59 -0700 (PDT)
Received: from christian--20230123--2G7D3 (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f03436sm272756f8f.51.2025.07.25.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:05:59 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] t9350: redirect input to only fast-import
Date: Fri, 25 Jul 2025 18:05:36 +0200
Message-ID: <20250725160536.2909011-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.50.1.439.g97e14d99f6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of tests in "t9350-fast-export.sh" are using sub-shells to
redirect content to a number of commands instead of only
`git fast-import`.

This is confusing and possibly error-prone, so let's change those tests
so that no sub-shell is used and the content goes only to
`git fast-import`.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

This addresses some leftover work discussed in:

https://lore.kernel.org/git/CABPp-BHM5afgiUf7GsTPWmrf_tm6mWnvHWMKiZPxApJzN-U8gg@mail.gmail.com/


t/t9350-fast-export.sh | 215 +++++++++++++++++------------------------
 1 file changed, 91 insertions(+), 124 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 46700dbc40..8f85c69d62 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -48,12 +48,11 @@ test_expect_success 'fast-export | fast-import' '
 	mkdir new &&
 	git --git-dir=new/.git init &&
 	git fast-export --all >actual &&
-	(cd new &&
-	 git fast-import &&
-	 test $MAIN = $(git rev-parse --verify refs/heads/main) &&
-	 test $REIN = $(git rev-parse --verify refs/tags/rein) &&
-	 test $WER = $(git rev-parse --verify refs/heads/wer) &&
-	 test $MUSS = $(git rev-parse --verify refs/tags/muss)) <actual
+	git -C new fast-import <actual &&
+	test $MAIN = $(git -C new rev-parse --verify refs/heads/main) &&
+	test $REIN = $(git -C new rev-parse --verify refs/tags/rein) &&
+	test $WER = $(git -C new rev-parse --verify refs/heads/wer) &&
+	test $MUSS = $(git -C new rev-parse --verify refs/tags/muss)
 
 '
 
@@ -87,13 +86,11 @@ test_expect_success 'fast-export --mark-tags ^muss^{commit} muss' '
 test_expect_success 'fast-export main~2..main' '
 
 	git fast-export main~2..main >actual &&
-	sed "s/main/partial/" actual |
-		(cd new &&
-		 git fast-import &&
-		 test $MAIN != $(git rev-parse --verify refs/heads/partial) &&
-		 git diff --exit-code main partial &&
-		 git diff --exit-code main^ partial^ &&
-		 test_must_fail git rev-parse partial~2)
+	sed "s/main/partial/" actual | git -C new fast-import &&
+	test $MAIN != $(git -C new rev-parse --verify refs/heads/partial) &&
+	git -C new diff --exit-code main partial &&
+	git -C new diff --exit-code main^ partial^ &&
+	test_must_fail git -C new rev-parse partial~2
 
 '
 
@@ -102,10 +99,8 @@ test_expect_success 'fast-export --reference-excluded-parents main~2..main' '
 	git fast-export --reference-excluded-parents main~2..main >actual &&
 	grep commit.refs/heads/main actual >commit-count &&
 	test_line_count = 2 commit-count &&
-	sed "s/main/rewrite/" actual |
-		(cd new &&
-		 git fast-import &&
-		 test $MAIN = $(git rev-parse --verify refs/heads/rewrite))
+	sed "s/main/rewrite/" actual | git -C new fast-import &&
+	test $MAIN = $(git -C new rev-parse --verify refs/heads/rewrite)
 '
 
 test_expect_success 'fast-export --show-original-ids' '
@@ -133,20 +128,19 @@ test_expect_success ICONV 'reencoding iso-8859-7' '
 	echo rosten >file &&
 	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
 	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
-	sed "s/wer/i18n/" iso-8859-7.fi |
-		(cd new &&
-		 git fast-import &&
-		 # The commit object, if not re-encoded, would be 200 bytes plus hash.
-		 # Removing the "encoding iso-8859-7\n" header drops 20 bytes.
-		 # Re-encoding the Pi character from \xF0 (\360) in iso-8859-7
-		 # to \xCF\x80 (\317\200) in UTF-8 adds a byte.  Check for
-		 # the expected size.
-		 test $(($(test_oid hexsz) + 181)) -eq "$(git cat-file -s i18n)" &&
-		 # ...and for the expected translation of bytes.
-		 git cat-file commit i18n >actual &&
-		 grep $(printf "\317\200") actual &&
-		 # Also make sure the commit does not have the "encoding" header
-		 ! grep ^encoding actual)
+	sed "s/wer/i18n/" iso-8859-7.fi | git -C new fast-import &&
+
+	# The commit object, if not re-encoded, would be 200 bytes plus hash.
+	# Removing the "encoding iso-8859-7\n" header drops 20 bytes.
+	# Re-encoding the Pi character from \xF0 (\360) in iso-8859-7
+	# to \xCF\x80 (\317\200) in UTF-8 adds a byte.  Check for
+	# the expected size.
+	test $(($(test_oid hexsz) + 181)) -eq "$(git -C new cat-file -s i18n)" &&
+	# ...and for the expected translation of bytes.
+	git -C new cat-file commit i18n >actual &&
+	grep $(printf "\317\200") actual &&
+	# Also make sure the commit does not have the "encoding" header
+	! grep ^encoding actual
 '
 
 test_expect_success 'aborting on iso-8859-7' '
@@ -165,20 +159,19 @@ test_expect_success 'preserving iso-8859-7' '
 	echo rosten >file &&
 	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
 	git fast-export --reencode=no wer^..wer >iso-8859-7.fi &&
-	sed "s/wer/i18n-no-recoding/" iso-8859-7.fi |
-		(cd new &&
-		 git fast-import &&
-		 # The commit object, if not re-encoded, is 200 bytes plus hash.
-		 # Removing the "encoding iso-8859-7\n" header would drops 20
-		 # bytes.  Re-encoding the Pi character from \xF0 (\360) in
-		 # iso-8859-7 to \xCF\x80 (\317\200) in UTF-8 adds a byte.
-		 # Check for the expected size...
-		 test $(($(test_oid hexsz) + 200)) -eq "$(git cat-file -s i18n-no-recoding)" &&
-		 # ...as well as the expected byte.
-		 git cat-file commit i18n-no-recoding >actual &&
-		 grep $(printf "\360") actual &&
-		 # Also make sure the commit has the "encoding" header
-		 grep ^encoding actual)
+	sed "s/wer/i18n-no-recoding/" iso-8859-7.fi | git -C new fast-import &&
+
+	# The commit object, if not re-encoded, is 200 bytes plus hash.
+	# Removing the "encoding iso-8859-7\n" header would drops 20
+	# bytes.  Re-encoding the Pi character from \xF0 (\360) in
+	# iso-8859-7 to \xCF\x80 (\317\200) in UTF-8 adds a byte.
+	# Check for the expected size...
+	test $(($(test_oid hexsz) + 200)) -eq "$(git -C new cat-file -s i18n-no-recoding)" &&
+	# ...as well as the expected byte.
+	git -C new cat-file commit i18n-no-recoding >actual &&
+	grep $(printf "\360") actual &&
+	# Also make sure the commit has the "encoding" header
+	grep ^encoding actual
 '
 
 test_expect_success 'encoding preserved if reencoding fails' '
@@ -188,18 +181,17 @@ test_expect_success 'encoding preserved if reencoding fails' '
 	echo rosten >file &&
 	git commit -s -F "$TEST_DIRECTORY/t9350/broken-iso-8859-7-commit-message.txt" file &&
 	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
-	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
-		(cd new &&
-		 git fast-import &&
-		 git cat-file commit i18n-invalid >actual &&
-		 # Make sure the commit still has the encoding header
-		 grep ^encoding actual &&
-		 # Verify that the commit has the expected size; i.e.
-		 # that no bytes were re-encoded to a different encoding.
-		 test $(($(test_oid hexsz) + 212)) -eq "$(git cat-file -s i18n-invalid)" &&
-		 # ...and check for the original special bytes
-		 grep $(printf "\360") actual &&
-		 grep $(printf "\377") actual)
+	sed "s/wer/i18n-invalid/" iso-8859-7.fi | git -C new fast-import &&
+	git -C new cat-file commit i18n-invalid >actual &&
+
+	# Make sure the commit still has the encoding header
+	grep ^encoding actual &&
+	# Verify that the commit has the expected size; i.e.
+	# that no bytes were re-encoded to a different encoding.
+	test $(($(test_oid hexsz) + 212)) -eq "$(git -C new cat-file -s i18n-invalid)" &&
+	# ...and check for the original special bytes
+	grep $(printf "\360") actual &&
+	grep $(printf "\377") actual
 '
 
 test_expect_success 'import/export-marks' '
@@ -316,12 +308,9 @@ test_expect_success GPG 'signed-commits=verbatim' '
 	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
 	test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
 	grep "encoding ISO-8859-1" output &&
-	(
-		cd new &&
-		git fast-import &&
-		STRIPPED=$(git rev-parse --verify refs/heads/commit-signing) &&
-		test $COMMIT_SIGNING = $STRIPPED
-	) <output
+	git -C new fast-import <output &&
+	STRIPPED=$(git -C new rev-parse --verify refs/heads/commit-signing) &&
+	test $COMMIT_SIGNING = $STRIPPED
 
 '
 
@@ -331,12 +320,9 @@ test_expect_success GPG 'signed-commits=warn-verbatim' '
 	test_grep -E "^gpgsig $GIT_DEFAULT_HASH openpgp" output &&
 	grep "encoding ISO-8859-1" output &&
 	test -s err &&
-	(
-		cd new &&
-		git fast-import &&
-		STRIPPED=$(git rev-parse --verify refs/heads/commit-signing) &&
-		test $COMMIT_SIGNING = $STRIPPED
-	) <output
+	git -C new fast-import <output &&
+	STRIPPED=$(git -C new rev-parse --verify refs/heads/commit-signing) &&
+	test $COMMIT_SIGNING = $STRIPPED
 
 '
 
@@ -345,12 +331,9 @@ test_expect_success GPG 'signed-commits=strip' '
 	git fast-export --signed-commits=strip --reencode=no commit-signing >output &&
 	! grep ^gpgsig output &&
 	grep "^encoding ISO-8859-1" output &&
-	sed "s/commit-signing/commit-strip-signing/" output | (
-		cd new &&
-		git fast-import &&
-		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
-		test $COMMIT_SIGNING != $STRIPPED
-	)
+	sed "s/commit-signing/commit-strip-signing/" output | git -C new fast-import &&
+	STRIPPED=$(git -C new rev-parse --verify refs/heads/commit-strip-signing) &&
+	test $COMMIT_SIGNING != $STRIPPED
 
 '
 
@@ -360,12 +343,9 @@ test_expect_success GPG 'signed-commits=warn-strip' '
 	! grep ^gpgsig output &&
 	grep "^encoding ISO-8859-1" output &&
 	test -s err &&
-	sed "s/commit-signing/commit-strip-signing/" output | (
-		cd new &&
-		git fast-import &&
-		STRIPPED=$(git rev-parse --verify refs/heads/commit-strip-signing) &&
-		test $COMMIT_SIGNING != $STRIPPED
-	)
+	sed "s/commit-signing/commit-strip-signing/" output | git -C new fast-import &&
+	STRIPPED=$(git -C new rev-parse --verify refs/heads/commit-strip-signing) &&
+	test $COMMIT_SIGNING != $STRIPPED
 
 '
 
@@ -386,14 +366,11 @@ test_expect_success GPGSM 'round-trip X.509 signed commit' '
 
 	git fast-export --signed-commits=verbatim x509-signing >output &&
 	test_grep -E "^gpgsig $GIT_DEFAULT_HASH x509" output &&
-	(
-		cd new &&
-		git fast-import &&
-		git cat-file commit refs/heads/x509-signing >actual &&
-		grep "^gpgsig" actual &&
-		IMPORTED=$(git rev-parse refs/heads/x509-signing) &&
-		test $X509_COMMIT = $IMPORTED
-	) <output
+	git -C new fast-import <output &&
+	git -C new cat-file commit refs/heads/x509-signing >actual &&
+	grep "^gpgsig" actual &&
+	IMPORTED=$(git -C new rev-parse refs/heads/x509-signing) &&
+	test $X509_COMMIT = $IMPORTED
 
 '
 
@@ -414,14 +391,11 @@ test_expect_success GPGSSH 'round-trip SSH signed commit' '
 
 	git fast-export --signed-commits=verbatim ssh-signing >output &&
 	test_grep -E "^gpgsig $GIT_DEFAULT_HASH ssh" output &&
-	(
-		cd new &&
-		git fast-import &&
-		git cat-file commit refs/heads/ssh-signing >actual &&
-		grep "^gpgsig" actual &&
-		IMPORTED=$(git rev-parse refs/heads/ssh-signing) &&
-		test $SSH_COMMIT = $IMPORTED
-	) <output
+	git -C new fast-import <output &&
+	git -C new cat-file commit refs/heads/ssh-signing >actual &&
+	grep "^gpgsig" actual &&
+	IMPORTED=$(git -C new rev-parse refs/heads/ssh-signing) &&
+	test $SSH_COMMIT = $IMPORTED
 
 '
 
@@ -461,14 +435,13 @@ test_expect_success 'submodule fast-export | fast-import' '
 	mkdir new &&
 	git --git-dir=new/.git init &&
 	git fast-export --signed-tags=strip --all >actual &&
-	(cd new &&
-	 git fast-import &&
-	 test "$SUBENT1" = "$(git ls-tree refs/heads/main^ sub)" &&
-	 test "$SUBENT2" = "$(git ls-tree refs/heads/main sub)" &&
-	 git checkout main &&
-	 git submodule init &&
-	 git submodule update &&
-	 cmp sub/file ../sub/file) <actual
+	git -C new fast-import <actual &&
+	test "$SUBENT1" = "$(git -C new ls-tree refs/heads/main^ sub)" &&
+	test "$SUBENT2" = "$(git -C new ls-tree refs/heads/main sub)" &&
+	git -C new checkout main &&
+	git -C new submodule init &&
+	git -C new submodule update &&
+	cmp new/sub/file sub/file
 
 '
 
@@ -510,10 +483,8 @@ test_expect_success 'fast-export -C -C | fast-import' '
 	git --git-dir=new/.git init &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
 	grep "^C file2 file4\$" output &&
-	cat output |
-	(cd new &&
-	 git fast-import &&
-	 test $ENTRY = $(git rev-parse --verify refs/heads/copy))
+	git -C new fast-import <output &&
+	test $ENTRY = $(git -C new rev-parse --verify refs/heads/copy)
 
 '
 
@@ -986,21 +957,17 @@ test_expect_success GPG 'export and import of doubly signed commit' '
 	git -C explicit-sha256 fast-export --signed-commits=verbatim dual-signed >output &&
 	test_grep -E "^gpgsig sha1 openpgp" output &&
 	test_grep -E "^gpgsig sha256 openpgp" output &&
-
-	(
-		cd new &&
-		git fast-import &&
-		git cat-file commit refs/heads/dual-signed >actual &&
-		test_grep -E "^gpgsig " actual &&
-		test_grep -E "^gpgsig-sha256 " actual &&
-		IMPORTED=$(git rev-parse refs/heads/dual-signed) &&
-		if test "$GIT_DEFAULT_HASH" = "sha1"
-		then
-			test $SHA1_B = $IMPORTED
-		else
-			test $SHA256_B = $IMPORTED
-		fi
-	) <output
+	git -C new fast-import <output &&
+	git -C new cat-file commit refs/heads/dual-signed >actual &&
+	test_grep -E "^gpgsig " actual &&
+	test_grep -E "^gpgsig-sha256 " actual &&
+	IMPORTED=$(git -C new rev-parse refs/heads/dual-signed) &&
+	if test "$GIT_DEFAULT_HASH" = "sha1"
+	then
+		test $SHA1_B = $IMPORTED
+	else
+		test $SHA256_B = $IMPORTED
+	fi
 '
 
 test_done
-- 
2.50.1.439.g97e14d99f6

