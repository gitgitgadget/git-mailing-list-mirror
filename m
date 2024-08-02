Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865A3A1B5
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722581270; cv=none; b=FFWAoXvSAQYl84H1bmRqiGYwsOWPK+btUrVzX/qNpx6/l0BhaFtfMjmc4+Yc5EXNAZ/TtwxkHlVBVOf4iuxUeyKreOj9K7RyV+Bz6uYsNSSotm1QMnF30SZIl7TO1RvyvowSyzWkwMTD31xCG4z+5w/jz2eY4T+e/l+pMsR3PFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722581270; c=relaxed/simple;
	bh=zFt/5mqToZnJZvy+0xBTzq0ezWUrhKqpuN0rexFWx/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fLwoUsCNLgdcnSJIkjuhyFwyJkws6KWncKoBegwnNYSgpmmPpPYJeshxUixgUvphHdES+KpetXd2Dm6Ew7ZvjFrthizgjFW/NJ+CjKTJxY7qdnxnaepckbd02bA3fYQt46OwzK7CP14Qtxz2JehwT8JqPlGE0HHeF7d1RfqIIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBoQ3eCj; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBoQ3eCj"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso118296731fa.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 23:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722581266; x=1723186066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0oYkeQQovup8wxTSrg5Vch/rRizoqMurx0BKkimlug=;
        b=UBoQ3eCji6AMfuTkYhNJm+mruEe+9KN89DIe8dji32Qt5LSd3kMROZT6PWx9/Mp72j
         gjHZxB8iuMxugdX9rJw45qoHSEQHH3Mn3KuxFF4vLLy0U12faIUauVF6OFWGrf/uNsA/
         4BMXJG08sWbBxISTVv8qH9R1oXiT+ReLubROsE4ewzfkfOkoMheUAZXsJASZzSYmv3eM
         KZErhW0gRjU2vhjRG27nvoQMNDtuuZWuBF8PlaG4Ux1Wu6Hvb+fdXfqlecuqLTxZOK7Y
         gzjgEqIulwPHjazvoD/N6UuQTvWbuaeMoCKn8YjXkJW2PAqlPbLTZvm2VP9958F9zGCL
         f8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722581266; x=1723186066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0oYkeQQovup8wxTSrg5Vch/rRizoqMurx0BKkimlug=;
        b=oti/zrbnCHyHXxoZgIIGjf/1wirbeCE1L/6cC385iagUNmE/faon0TjCPftiivAD8+
         emXhtcAhK6QGE4RioN0syKiX6cfIpifRu8r1KlnSW/wYni+1iko7uCFM2AP527Son7Y6
         mCwPJ6uhhXCRSUX3QzqownXEITzbEBcZ4dY0e7dPapaaXcuJqz+hBRB0obDzwAoZKAjp
         oroMSsgUX5m+632R6h2ljptTFrMm0YUqcwlEEpQSE6KNYXOGQ5K9J64212QIz+/bJEe9
         d3aOW0GIcj94bbTY34EkOTLq1yI6tdiEXXHSECpd8f7Q+iP8JyH2NgyOje2BJMK+fcm1
         zofg==
X-Gm-Message-State: AOJu0Yyj3ZgL0n6XAEEH6j0GoF95+uQyfJ/ykRB/O+mJI+cX4ofNwdIy
	G7ExNA1vniPT0Y4Nk4srVb7ILNi864QSw/E0X4lhWy82fL12cNliThoS7mGMb1nhYQ==
X-Google-Smtp-Source: AGHT+IFxgvx/c/yPb75lq4522RpERkLkPKcX5Wj5Epf0i/LbWiuQtJ2R9muwerHAYNqPJnxo0LmMyQ==
X-Received: by 2002:a2e:b70a:0:b0:2f1:561e:c329 with SMTP id 38308e7fff4ca-2f15aac4fb2mr20724281fa.26.1722581265671;
        Thu, 01 Aug 2024 23:47:45 -0700 (PDT)
Received: from abdobngad.. ([197.40.159.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a862sm82477255e9.4.2024.08.01.23.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 23:47:45 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH][Newcomer] t7004-tag: modernize the test script
Date: Fri,  2 Aug 2024 09:47:19 +0300
Message-ID: <20240802064719.513498-1-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modernaize 't7004-tag.sh' by removing whitespace
after the redirect operators.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index fa6336edf9..3100a4c219 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -213,9 +213,9 @@ mytag
 EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l > actual && test_cmp expect actual &&
+	git tag -l >actual && test_cmp expect actual &&
 	git tag -d &&
-	git tag -l > actual && test_cmp expect actual
+	git tag -l >actual && test_cmp expect actual
 '
 
 test_expect_success \
@@ -269,9 +269,9 @@ test_expect_success 'listing all tags should print them ordered' '
 	git tag a1 &&
 	git tag v1.0 &&
 	git tag t210 &&
-	git tag -l > actual &&
+	git tag -l >actual &&
 	test_cmp expect actual &&
-	git tag > actual &&
+	git tag >actual &&
 	test_cmp expect actual
 '
 
@@ -283,7 +283,7 @@ EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
 	rm *a* &&
-	git tag -l "*a*" > current &&
+	git tag -l "*a*" >current &&
 	test_cmp expect current
 '
 
@@ -293,7 +293,7 @@ v1.0.1
 EOF
 test_expect_success \
 	'listing tags with a suffix as pattern must print those matching' '
-	git tag -l "*.1" > actual &&
+	git tag -l "*.1" >actual &&
 	test_cmp expect actual
 '
 
@@ -303,7 +303,7 @@ t211
 EOF
 test_expect_success \
 	'listing tags with a prefix as pattern must print those matching' '
-	git tag -l "t21*" > actual &&
+	git tag -l "t21*" >actual &&
 	test_cmp expect actual
 '
 
@@ -312,7 +312,7 @@ a1
 EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git tag -l a1 > actual &&
+	git tag -l a1 >actual &&
 	test_cmp expect actual
 '
 
@@ -321,7 +321,7 @@ v1.0
 EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git tag -l v1.0 > actual &&
+	git tag -l v1.0 >actual &&
 	test_cmp expect actual
 '
 
@@ -331,13 +331,13 @@ v1.1.3
 EOF
 test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
-	git tag -l "v1.?.?" > actual &&
+	git tag -l "v1.?.?" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
-	git tag -l "v.*" > actual &&
+	git tag -l "v.*" >actual &&
 	test_must_be_empty actual
 '
 
@@ -349,7 +349,7 @@ v1.1.3
 EOF
 test_expect_success \
 	'listing tags using v* should print only those having v' '
-	git tag -l "v*" > actual &&
+	git tag -l "v*" >actual &&
 	test_cmp expect actual
 '
 
@@ -1171,7 +1171,7 @@ test_expect_success GPG \
 	git tag -v emptyfile-signed-tag
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
+printf '\n\n  \n\t\nLeading blank lines\n' >sigblanksfile
 printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
 printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
 printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
@@ -1569,7 +1569,7 @@ test_expect_success \
 
 test_expect_success \
 	'message in editor has initial comment' '
-	! (GIT_EDITOR=cat git tag -a initial-comment > actual)
+	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
 '
 
 test_expect_success 'message in editor has initial comment: first line' '
@@ -1587,7 +1587,7 @@ test_expect_success \
 '
 
 get_tag_header reuse $commit commit $time >expect
-echo "An annotation to be reused" >> expect
+echo "An annotation to be reused" >>expect
 test_expect_success \
 	'overwriting an annotated tag should use its previous body' '
 	git tag -a -m "An annotation to be reused" reuse &&
@@ -1639,7 +1639,7 @@ hash3=$(git rev-parse HEAD)
 
 # simple linear checks of --continue
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1679,7 +1679,7 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 	test_must_be_empty actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v2.0
 EOF
 
@@ -1688,7 +1688,7 @@ test_expect_success 'checking that second commit only has one tag' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1705,7 +1705,7 @@ test_expect_success 'checking that third commit has no tags' "
 	test_must_be_empty actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1723,14 +1723,14 @@ test_expect_success 'conversely --no-contains on the third commit lists all tags
 test_expect_success 'creating simple branch' '
 	git branch stable v2.0 &&
         git checkout stable &&
-	echo foo-3.0 > foo &&
+	echo foo-3.0 >foo &&
 	git commit foo -m fourth &&
 	git tag v3.0
 '
 
 hash4=$(git rev-parse HEAD)
 
-cat > expected <<EOF
+cat >expected <<EOF
 v3.0
 EOF
 
@@ -1739,7 +1739,7 @@ test_expect_success 'checking that branch head only has one tag' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1757,7 +1757,7 @@ test_expect_success 'merging original branch into this branch' '
         git tag v4.0
 '
 
-cat > expected <<EOF
+cat >expected <<EOF
 v4.0
 EOF
 
@@ -1766,7 +1766,7 @@ test_expect_success 'checking that original branch head has one tag now' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1780,7 +1780,7 @@ test_expect_success 'checking that original branch head with --no-contains lists
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
-- 
2.43.0

