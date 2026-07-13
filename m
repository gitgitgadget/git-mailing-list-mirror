Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241D43C04A
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961052; cv=none; b=Zn+GOfK6COmY/Yo51mFZLofS48AjFCOZlTbYsGiNQcXHyOYVT3+TLUjN4LHkN+XZi04ro+UB1vIVHiMHJ4wlHfDoP+Yw0MW+ITN0Xrl3vH+bOkF0u0kc+03osMhv0tcpkmApDJYgv4L1gih0VAZsIj9BylcouoOTziRgpMK1FSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961052; c=relaxed/simple;
	bh=oGPB7wZJYvjOfl+rROVvfmIfjJxnaXCVKf460ug8c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDl2wTT+7z7PtWuGMje/XMb8GZ/gAk+tCVNhQTRB8xEAACQylZ/v/mBzuPC7N+wrTBVPktirm001pZFr4/6/fZK3Tk6OLCR142TS+SlbGgpLXVInLVwL8BWVdaXWfl2DaCDLmK7VpUpzBGGT3SQf5xMRWXFp5by4SPeN5PkiDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptBIAtby; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptBIAtby"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c19bad03so30948165e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961049; x=1784565849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M7uo5WJY7aNgnmxE9BWqwy3jq2/Z65g0xXT02gH5pPA=;
        b=ptBIAtby+0obp2vcozRsMdRmLH4thLj6QSbTUURV3Jd/6NVBT1+fYYh46W3sdK5VxV
         H6OR/he4NeQzHsWqZ0BQmrjZgTD4tDaIp71O2Nv00vAJQRzkane8YlxaoPyHi+nTm813
         OKNwOHoV0ACzsM6+ayLiyqbk7PUMQVMmqeJwctUqkL7zaKciUui2EFRATjE2UpjQVL2E
         Yln1AMi+k81iD12peJN6h/Oq3dRqwpVKUG1j3MMrNNTbiprTerl/8xggFDir24J0AGuW
         ehXCvUn3Kr2gsQI12jGBYUMganIfW4dl3/W9tth+Xe3C+dWqtU8cCsjRiSsE5vrvDZ00
         7HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961049; x=1784565849;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7uo5WJY7aNgnmxE9BWqwy3jq2/Z65g0xXT02gH5pPA=;
        b=hmrcoCDaPG7Nl/eloccW09SAxM1Ecd19bD/uX4cnPSMwccrXPMSbm5tkhgQktbwr3J
         W168bMc4Q09XyvJlZIpxcRU4cEXSAZRj3ds23RYUkm0mgKKbgktwI+Uupab4XQ+Jy4m5
         ChHK4fxRyk7RpnINd5DO11pcMA+ffeGEheC6rWuJJUjyDofbzBTQLjdMiHYvIuj5yD5P
         iVM4cXWsB7xOxosz1uFpzbJbHnsHhZ1DTLAqxOV/WDdctfi0g+CMc0aVJa8XBkAACKgR
         HO83Z4cp4LUPKQ59Nxs9A/sSBxi9WRN+TvDrRKUKQVrCgxGAlt+1Snpe3Tdds4UMjzUi
         9G5g==
X-Gm-Message-State: AOJu0YzZepNESDaBnt3MtmSekEnH/1MgZEVciNli9gPod4jvjouB6jNb
	fcY5WlXIf258YB1kiG7t4MKvjI0K1l8z4TY3ihUaDX4C/Tj+aXIYVXA8b4Q8hR7C
X-Gm-Gg: AfdE7cnBomfb2DwgUDJgd+EK/crAucvfSyQj9usbPMPqenKkZJgyxcIj70MEgYm+RLS
	/q7DK4zgULuSLyzantF99rgpEaN2NSFwOT0BR7ASMd8dEViltk0+tA2eTYeSIIalFx9i6Up9Wr3
	prCGgPU7zRU5wStGrsfyjrxWlea1Ri6m0DDaL4sQ9eNdfMEfH3xD9eYXNZlEXxGFeKRh1oPg2I+
	gqzqgA5J4cZAczquNSh66fTCD1RSzxPgMTYXTbUsm+f6US9P992CuRXLmCJpWt/J/e5rafgv7Hy
	J2CeCsjD8V0inX5nhT0VXj2mt4trcqzM4LKgpSbd3Js9vhp1jmhx8ySywojYtAkpnoLySHwiYZf
	SuJaER1UPa17c2Po9WZp6Ngi+ZhP33ZroYRFtrmPddFlXVw8TWtkXlbTCAnqfIJPSCJ07UdYi3K
	+jXWY74FPiOIVyfR7xCeEXyLDpyPnVdD4lL8cSgDhig7T4nCQve5Tfa3RF+w6Q2zM4SWHQyCGeA
	DbunoetMBvnueYTPN5v12hWv489ra8rTMRzyU9rRT+QTSypSWjwmBztGq/ck7+Nfrztivplo6LK
	ci4ElTCmeOKKF1atoxwUJWsZkwA1XVzJhgy1yZShO1pDpnAb1kjAJHsqAQrocaXXPkwJfRmaMcc
	CkmzwJzSQ/Pl2ndX2gra2
X-Received: by 2002:a05:600c:4e94:b0:493:e57d:4f58 with SMTP id 5b1f17b1804b1-493f883b7f3mr106375985e9.36.1783961048563;
        Mon, 13 Jul 2026 09:44:08 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm653768f8f.24.2026.07.13.09.44.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 09:44:08 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v11 1/7] lib-log-graph: move check_graph function
Date: Mon, 13 Jul 2026 18:43:58 +0200
Message-ID: <20260713-ps-pre-commit-indent-v11-1-dcb65bc4ba99@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
References: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
 <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

check_graph is a function shared in the test files t4215 and t6016 used
to format the output graph, but instead of being in a file called by
both test, the function code is repeated in each file.

Move check_graph to lib-log-graph.sh file which both tests already
import graph functions from, renaming it to lib_test_check_graph.

This function is needed for the following commit which includes graph
tests in a new file and requires check_graph.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-log-graph.sh                         |  5 +++++
 t/t4215-log-skewed-merges.sh               | 33 +++++++++++++-----------------
 t/t6016-rev-list-graph-simplify-history.sh | 25 +++++++++-------------
 3 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
index bf952ef920..1eae8f60c2 100644
--- a/t/lib-log-graph.sh
+++ b/t/lib-log-graph.sh
@@ -26,3 +26,8 @@ lib_test_cmp_colored_graph () {
 	test_decode_color <output.colors.raw | sed "s/ *\$//" >output.colors &&
 	test_cmp expect.colors output.colors
 }
+
+lib_test_check_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --format=%s "$@"
+}
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 1612f05f1b..eebab71039 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -5,11 +5,6 @@ test_description='git log --graph of skewed merges'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
-check_graph () {
-	cat >expect &&
-	lib_test_cmp_graph --format=%s "$@"
-}
-
 test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
 	git checkout --orphan _p &&
 	test_commit A &&
@@ -21,7 +16,7 @@ test_expect_success 'log --graph with merge fusing with its left and right neigh
 	git checkout _p && git merge --no-ff _r -m G &&
 	git checkout @^^ && git merge --no-ff _p -m H &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   H
 	|\
 	| *   G
@@ -49,7 +44,7 @@ test_expect_success 'log --graph with left-skewed merge' '
 	git checkout 0_p && git merge --no-ff 0_s -m 0_G &&
 	git checkout @^ && git merge --no-ff 0_q 0_r 0_t 0_p -m 0_H &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*-----.   0_H
 	|\ \ \ \
 	| | | | * 0_G
@@ -83,7 +78,7 @@ test_expect_success 'log --graph with nested left-skewed merge' '
 	git checkout 1_p && git merge --no-ff 1_r -m 1_G &&
 	git checkout @^^ && git merge --no-ff 1_p -m 1_H &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   1_H
 	|\
 	| *   1_G
@@ -115,7 +110,7 @@ test_expect_success 'log --graph with nested left-skewed merge following normal
 	git checkout -b 2_s @^^ && git merge --no-ff 2_q -m 2_J &&
 	git checkout 2_p && git merge --no-ff 2_s -m 2_K &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   2_K
 	|\
 	| *   2_J
@@ -151,7 +146,7 @@ test_expect_success 'log --graph with nested right-skewed merge following left-s
 	git checkout 3_p && git merge --no-ff 3_r -m 3_H &&
 	git checkout @^^ && git merge --no-ff 3_p -m 3_J &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   3_J
 	|\
 	| *   3_H
@@ -182,7 +177,7 @@ test_expect_success 'log --graph with right-skewed merge following a left-skewed
 	git merge --no-ff 4_p -m 4_G &&
 	git checkout @^^ && git merge --no-ff 4_s -m 4_H &&
 
-	check_graph --date-order <<-\EOF
+	lib_test_check_graph --date-order <<-\EOF
 	*   4_H
 	|\
 	| *   4_G
@@ -218,7 +213,7 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
 	git checkout 5_r &&
 	git merge --no-ff 5_s -m 5_H &&
 
-	check_graph <<-\EOF
+	lib_test_check_graph <<-\EOF
 	*   5_H
 	|\
 	| *-.   5_G
@@ -257,7 +252,7 @@ test_expect_success 'log --graph with multiple tips' '
 	git checkout 6_1 &&
 	git merge --no-ff 6_2 -m 6_I &&
 
-	check_graph 6_1 6_3 6_5 <<-\EOF
+	lib_test_check_graph 6_1 6_3 6_5 <<-\EOF
 	*   6_I
 	|\
 	| | *   6_H
@@ -334,7 +329,7 @@ test_expect_success 'log --graph with multiple tips' '
 	git checkout -b M_7 7_1 &&
 	git merge --no-ff 7_2 7_3 -m 7_M4 &&
 
-	check_graph M_1 M_3 M_5 M_7 <<-\EOF
+	lib_test_check_graph M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
@@ -371,7 +366,7 @@ test_expect_success 'log --graph with multiple tips' '
 '
 
 test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
-	check_graph --graph-lane-limit=2 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=2 M_7 <<-\EOF
 	*-.   7_M4
 	|\ \
 	| | * 7_G
@@ -388,7 +383,7 @@ test_expect_success 'log --graph --graph-lane-limit=2 limited to two lanes' '
 '
 
 test_expect_success 'log --graph --graph-lane-limit=1 truncate mid octopus merge' '
-	check_graph --graph-lane-limit=1 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=1 M_7 <<-\EOF
 	*-~  7_M4
 	|\~
 	| ~ 7_G
@@ -405,7 +400,7 @@ test_expect_success 'log --graph --graph-lane-limit=1 truncate mid octopus merge
 '
 
 test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
-	check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
@@ -441,7 +436,7 @@ test_expect_success 'log --graph --graph-lane-limit=3 limited to three lanes' '
 '
 
 test_expect_success 'log --graph --graph-lane-limit=6 check if it only shows first of 3 parent merge' '
-	check_graph --graph-lane-limit=6 M_1 M_3 M_5 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=6 M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
@@ -478,7 +473,7 @@ test_expect_success 'log --graph --graph-lane-limit=6 check if it only shows fir
 '
 
 test_expect_success 'log --graph --graph-lane-limit=7 check if it shows all 3 parent merge' '
-	check_graph --graph-lane-limit=7 M_1 M_3 M_5 M_7 <<-\EOF
+	lib_test_check_graph --graph-lane-limit=7 M_1 M_3 M_5 M_7 <<-\EOF
 	*   7_M1
 	|\
 	| | *   7_M2
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index 54b0a6f5f8..e0d9c3c1ac 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -13,11 +13,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
-check_graph () {
-	cat >expect &&
-	lib_test_cmp_graph --format=%s "$@"
-}
-
 test_expect_success 'set up rev-list --graph test' '
 	# 3 commits on branch A
 	test_commit A1 foo.txt &&
@@ -54,7 +49,7 @@ test_expect_success 'set up rev-list --graph test' '
 '
 
 test_expect_success '--graph --all' '
-	check_graph --all <<-\EOF
+	lib_test_check_graph --all <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -82,7 +77,7 @@ test_expect_success '--graph --all' '
 # that undecorated merges are interesting, even with --simplify-by-decoration
 test_expect_success '--graph --simplify-by-decoration' '
 	git tag -d A4 &&
-	check_graph --all --simplify-by-decoration <<-\EOF
+	lib_test_check_graph --all --simplify-by-decoration <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -114,7 +109,7 @@ test_expect_success 'setup: get rid of decorations on B' '
 
 # Graph with branch B simplified away
 test_expect_success '--graph --simplify-by-decoration prune branch B' '
-	check_graph --simplify-by-decoration --all <<-\EOF
+	lib_test_check_graph --simplify-by-decoration --all <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -133,7 +128,7 @@ test_expect_success '--graph --simplify-by-decoration prune branch B' '
 '
 
 test_expect_success '--graph --full-history -- bar.txt' '
-	check_graph --full-history --all -- bar.txt <<-\EOF
+	lib_test_check_graph --full-history --all -- bar.txt <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -148,7 +143,7 @@ test_expect_success '--graph --full-history -- bar.txt' '
 '
 
 test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
-	check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
+	lib_test_check_graph --full-history --simplify-merges --all -- bar.txt <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -161,7 +156,7 @@ test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
 '
 
 test_expect_success '--graph -- bar.txt' '
-	check_graph --all -- bar.txt <<-\EOF
+	lib_test_check_graph --all -- bar.txt <<-\EOF
 	* A7
 	* A5
 	* A3
@@ -172,7 +167,7 @@ test_expect_success '--graph -- bar.txt' '
 '
 
 test_expect_success '--graph --sparse -- bar.txt' '
-	check_graph --sparse --all -- bar.txt <<-\EOF
+	lib_test_check_graph --sparse --all -- bar.txt <<-\EOF
 	* A7
 	* A6
 	* A5
@@ -189,7 +184,7 @@ test_expect_success '--graph --sparse -- bar.txt' '
 '
 
 test_expect_success '--graph ^C4' '
-	check_graph --all ^C4 <<-\EOF
+	lib_test_check_graph --all ^C4 <<-\EOF
 	* A7
 	* A6
 	* A5
@@ -202,7 +197,7 @@ test_expect_success '--graph ^C4' '
 '
 
 test_expect_success '--graph ^C3' '
-	check_graph --all ^C3 <<-\EOF
+	lib_test_check_graph --all ^C3 <<-\EOF
 	* A7
 	*   A6
 	|\
@@ -220,7 +215,7 @@ test_expect_success '--graph ^C3' '
 # that important, but this test depends on it.  If the ordering ever changes
 # in the code, we'll need to update this test.
 test_expect_success '--graph --boundary ^C3' '
-	check_graph --boundary --all ^C3 <<-\EOF
+	lib_test_check_graph --boundary --all ^C3 <<-\EOF
 	* A7
 	*   A6
 	|\

-- 
2.54.0
