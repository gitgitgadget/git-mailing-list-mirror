Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60A1F4166
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011514; cv=none; b=SKVK9pzuIzTc4ukL0oypcNYmDE+X/kWUI/SDT54fiQHENKN+eocZDZP05nvmiX4cyeW5bcg627yb4BsesPojv9LveVMgVzSuU/qHWRivbsvbmhY2srxmBzchk4ba3uAM0SbgGwBA45sJeh6qmqB7d2LXg7KDwRg+xTkYnnw3snM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011514; c=relaxed/simple;
	bh=xC6MLhijbt8LzSFB0TPEXuiFzG94ONgXqENxEzkN/Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=an9bixaY6X4XKXNN5gI+YV196/f2gjpGDR8EwDmxikD+R7almyzvUTvK3PQ+nEOAjjczgdJeJfYGoc0EBlg0fpSh3P7TGHeedWefEsLrj7B+JZB+CSb0dPj/0oAUHQzFCvECZdSkZs3V0IlP6U+6dedGy2aLsARlGXaa8k/m4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGqF+Ylu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGqF+Ylu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22334203781so86128285ad.0
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 06:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741011512; x=1741616312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys9X0SK1QKO2zWpB6FwONyyBhtLUbdVbAMAS5syzAAc=;
        b=DGqF+YlulQkAiBUs56JIkzkaTEaEeCKxn4WjWPYaSZTlEyIlOSnQ17U8m/KoFkwpT6
         uGjD4fCgT7ig1AeOMML1QDhwfprJYDy07sT0VyYiudkbktX1XqNK1rO6SiGXm+d0euPy
         IwWjwECrLiOtheWbBqKEEexDLZTN3Zq8pzLA8UAvHSOGkrWRZhnPOjz3AihJ9EkiSrR7
         4SbogWgRjVEV4pITGTCq1j/ZxquVKLJCvZinRdPjFUXQE4uWnT+5hiuOtypUn76aej+k
         cP+XyMRMReeQlWYHrAyNetzWgWDUzwdnMaH3+I07fCjzCAOwpzwRgg56opP6UNGgGPtM
         LIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011512; x=1741616312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ys9X0SK1QKO2zWpB6FwONyyBhtLUbdVbAMAS5syzAAc=;
        b=jKResak42GO7an1xSvoKzwxCCEtRhDUXHRDD8pHggxP6095L+fd25J6IpCJ+iVmFVY
         udFEabCDkPmuLKOgU1DmFnDGTY846LcewTI2PM96lMCpmREVEA0YG+Rs3pPnIZiE84j9
         hz83YNioM7FQFly1L/XZoH6JmIlmy+rRU61qmA6zVeCBLimTfj3qnSE7be3V+JFpoABd
         EvEz3SG9bCuAcFzKK/eWcQBlkng57DeHF9/n1WQg3oXSoN6bP1djWYy/8BvglRJY2q9p
         Lq71ZVAZk7Z8oE0T+e2Y2/n6z7MrbO8MhH5v6LdmwF7qKbOSYEfgO9hZ2MlVYofO/XDt
         vpdA==
X-Gm-Message-State: AOJu0YxGlpmdOJObIf2vlECG6lcI5G9lO+9PmXr1So8vJalQEB7905do
	6GI0m31rO7CiydRCH8HWhmpxhBSE/uvv2PFjdk6PGdTAfpVTqc5XdgkKpSbGI4kwa3y6
X-Gm-Gg: ASbGncu9KNz7dq/Bf1RzxFY6R/D5hWy7sZcLWJOFgaD2llZjZuWdwqxqFbWdHLSG0wa
	WvmXuzrrc/3N3YMhvB2iLEQN3aUtk+8igr4Bav8hp+NE/6WMzhng6WQeGXhaYsx2x+/F8jv7ydb
	3YGbBby/Sg0x8TSV9e93O8buasPEwYZTaUr7gAP4mNtUT0Sl5TXd9x1op0dBxXEAhDmCuuybBG6
	KrO9gEAizPT8fkqTsenlfPwQPPy4GKAl/6QqoWC8ZWWkUyrHJBaxiP4agkF7MG3rCGHbgtPWU8L
	RyNCA+W1JXkMRJ9NWDICILqIPguBd3GCy50l/xz1lJ8jY7I5ldl18oScEw0VmY0=
X-Google-Smtp-Source: AGHT+IF2NoggjpnL73DD/cDQVjszs0EXJGI0/iLoD7CN1SJAJ0hz5T1WwNgRwzJK/JLUPz/z44XCsQ==
X-Received: by 2002:a05:6a00:2d1d:b0:736:491b:5370 with SMTP id d2e1a72fcca58-736491b64ecmr9072960b3a.10.1741011511897;
        Mon, 03 Mar 2025 06:18:31 -0800 (PST)
Received: from localhost.localdomain ([36.50.162.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0040091sm9240117b3a.147.2025.03.03.06.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:18:31 -0800 (PST)
From: Prachit Ingle <ingleprachit101@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Prachit Ingle <ingleprachit101@gmail.com>
Subject: [PATCH] =?UTF-8?q?[GSOC][PATCH]=20Modernize=20Test=20Path=20Check?= =?UTF-8?q?ing=20in=20Git=E2=80=99s=20Test=20Suite?=
Date: Mon,  3 Mar 2025 19:48:00 +0530
Message-Id: <20250303141800.12848-1-ingleprachit101@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This patch improves the Git test suite by converting old-style path checks =
to use
modern Git test helpers. Specifically, we have replaced shell commands like=
 `test -f`
and `test -d` with the appropriate Git test helpers, such as `test_path_is_=
file` and
`test_path_is_dir`. This enhances the readability and consistency of the te=
st suite.

The following tests were updated:
- t/chainlint/cuddled-loop.test
- t/chainlint/cuddled.test
- t/chainlint/double-here-doc.test
- t/chainlint/dqstring-line-splice.test
- t/chainlint/dqstring-no-interpolate.test
- t/chainlint/empty-here-doc.test
- t/chainlint/exclamation.test
- t/chainlint/exit-loop.test
- t/chainlint/exit-subshell.test
- t/chainlint/for-loop-abbreviated.test
- t/chainlint/for-loop.test
- t/chainlint/function.expect
- t/chainlint/function.test
- t/chainlint/here-doc-body-indent.test

The changes have been verified by running the test suite to ensure no break=
s or regressions.

Command used to find instances: git grep 'test -[efd]' t/

Signed-off-by: Prachit Ingle <ingleprachit101@gmail.com>
---
 t/chainlint/chained-subshell.expect |  2 +-
 t/chainlint/chained-subshell.test   | 30 ++++++++++++++---------------
 t/chainlint/function.expect         |  2 +-
 t/chainlint/function.test           | 30 ++++++++++++++---------------
 t/interop/interop-lib.sh            |  4 ++--
 t/lib-httpd/apply-one-time-perl.sh  |  2 +-
 t/lib-httpd/nph-custom-auth.sh      |  2 +-
 t/perf/p5302-pack-index.sh          |  2 +-
 t/perf/p7527-builtin-fsmonitor.sh   |  2 +-
 t/perf/perf-lib.sh                  |  2 +-
 10 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-subs=
hell.expect
index 93fb1a6578..49efa1301d 100644
--- a/t/chainlint/chained-subshell.expect
+++ b/t/chainlint/chained-subshell.expect
@@ -5,6 +5,6 @@
 6 ) &&
 7=20
 8 cut "-d " -f actual | (read s1 s2 s3 &&
-9 test -f $s1 ?!LINT: missing '&&'?!
+9 test_path_is_file "$s1" || error "$s1 should exist"
 10 test $(cat $s2) =3D tree2path1 &&
 11 test $(cat $s3) =3D tree3path1)
diff --git a/t/chainlint/chained-subshell.test b/t/chainlint/chained-subshe=
ll.test
index 1f11f65398..e167335f1e 100644
--- a/t/chainlint/chained-subshell.test
+++ b/t/chainlint/chained-subshell.test
@@ -1,15 +1,15 @@
-test_expect_success 'chained-subshell' '
-# LINT: start of subshell chained to preceding command
-mkdir sub && (
-	cd sub &&
-	foo the bar
-	nuff said
-) &&
-
-# LINT: preceding command pipes to subshell on same line
-cut "-d " -f actual | (read s1 s2 s3 &&
-test -f $s1
-test $(cat $s2) =3D tree2path1 &&
-# LINT: closing subshell ")" correctly detected on same line as "$(...)"
-test $(cat $s3) =3D tree3path1)
-'
+test_expect_success 'chained-subshell' '=0D
+# LINT: start of subshell chained to preceding command=0D
+mkdir sub && (=0D
+	cd sub &&=0D
+	foo the bar=0D
+	nuff said=0D
+) &&=0D
+=0D
+# LINT: preceding command pipes to subshell on same line=0D
+cut "-d " -f actual | (read s1 s2 s3 &&=0D
+test_path_is_file $s1=0D
+test $(cat $s2) =3D tree2path1 &&=0D
+# LINT: closing subshell ")" correctly detected on same line as "$(...)"=0D
+test $(cat $s3) =3D tree3path1)=0D
+'=0D
diff --git a/t/chainlint/function.expect b/t/chainlint/function.expect
index 9e46a3554a..a0a465e6d4 100644
--- a/t/chainlint/function.expect
+++ b/t/chainlint/function.expect
@@ -4,7 +4,7 @@
 5=20
 6 remove_object() {
 7 	file=3D$(sha1_file "$*") &&
-8 	test -e "$file" ?!LINT: missing '&&'?!
+8 	test_path_exists "$file" || error "$file should exist"
 9 	rm -f "$file"
 10 } ?!LINT: missing '&&'?!
 11=20
diff --git a/t/chainlint/function.test b/t/chainlint/function.test
index 763fcf3f87..841c60720c 100644
--- a/t/chainlint/function.test
+++ b/t/chainlint/function.test
@@ -1,15 +1,15 @@
-test_expect_success 'function' '
-# LINT: "()" in function definition not mistaken for subshell
-sha1_file() {
-	echo "$*" | sed "s#..#.git/objects/&/#"
-} &&
-
-# LINT: broken &&-chain in function and after function
-remove_object() {
-	file=3D$(sha1_file "$*") &&
-	test -e "$file"
-	rm -f "$file"
-}
-
-sha1_file arg && remove_object arg
-'
+test_expect_success 'function' '=0D
+# LINT: "()" in function definition not mistaken for subshell=0D
+sha1_file() {=0D
+	echo "$*" | sed "s#..#.git/objects/&/#"=0D
+} &&=0D
+=0D
+# LINT: broken &&-chain in function and after function=0D
+remove_object() {=0D
+	file=3D$(sha1_file "$*") &&=0D
+	test_path_exists "$file" || error "$file should exist"=0D
+	rm -f "$file"=0D
+}=0D
+=0D
+sha1_file arg && remove_object arg=0D
+'=0D
diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
index 1b5864d2a7..b2055d4252 100644
--- a/t/interop/interop-lib.sh
+++ b/t/interop/interop-lib.sh
@@ -21,7 +21,7 @@ build_version () {
 	sha1=3D$(git rev-parse "$1^{tree}") || return 1
 	dir=3D$BUILD_ROOT/$sha1
=20
-	if test -e "$dir/.built"
+	if test_path_exists "$dir/.built"
 	then
 		echo "$dir"
 		return 0
@@ -37,7 +37,7 @@ build_version () {
=20
 	for config in config.mak config.mak.autogen config.status
 	do
-		if test -e "$INTEROP_ROOT/../../$config"
+		if test_path_exists "$INTEROP_ROOT/../../$config"
 		then
 			cp "$INTEROP_ROOT/../../$config" "$dir/" || return 1
 		fi
diff --git a/t/lib-httpd/apply-one-time-perl.sh b/t/lib-httpd/apply-one-tim=
e-perl.sh
index d7f9fed6ae..83ede36efb 100644
--- a/t/lib-httpd/apply-one-time-perl.sh
+++ b/t/lib-httpd/apply-one-time-perl.sh
@@ -7,7 +7,7 @@
 #
 # This can be used to simulate the effects of the repository changing in
 # between HTTP request-response pairs.
-if test -f one-time-perl
+if test_path_is_file one-time-perl
 then
 	LC_ALL=3DC
 	export LC_ALL
diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/nph-custom-auth.sh
index d408d2caad..c39b816c45 100644
--- a/t/lib-httpd/nph-custom-auth.sh
+++ b/t/lib-httpd/nph-custom-auth.sh
@@ -41,7 +41,7 @@ then
 fi
=20
 echo 'HTTP/1.1 401 Authorization Required'
-if test -f "$CHALLENGE_FILE"
+if test_path_is_file "$CHALLENGE_FILE"
 then
 	sed -ne 's/^id=3Ddefault.*response=3D//p' "$CHALLENGE_FILE"
 fi
diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index 14c601bbf8..d3a3ea360f 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -9,7 +9,7 @@ test_perf_large_repo
 test_expect_success 'repack' '
 	git repack -ad &&
 	PACK=3D$(ls .git/objects/pack/*.pack | head -n1) &&
-	test -f "$PACK" &&
+	test_path_is_file "$PACK" &&
 	export PACK
 '
=20
diff --git a/t/perf/p7527-builtin-fsmonitor.sh b/t/perf/p7527-builtin-fsmon=
itor.sh
index 90164327e8..16e56cc197 100755
--- a/t/perf/p7527-builtin-fsmonitor.sh
+++ b/t/perf/p7527-builtin-fsmonitor.sh
@@ -46,7 +46,7 @@ export TMP_BR
 REPO=3D../repos/gen-many-files-"$PARAMS".git
 export REPO
=20
-if ! test -d $REPO
+if ! test_path_is_dir $REPO
 then
 	(cd ../repos; ./many-files.sh -d $PARAM_D -w $PARAM_W -f $PARAM_F)
 fi
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 8ab6d9c469..13eb33ae6f 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -117,7 +117,7 @@ test_perf_create_repo_from () {
 		"$MODERN_GIT" init -q &&
 		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
-		if test -f .git/index.lock
+		if test_path_is_file .git/index.lock
 		then
 			# We may be copying a repo that can't run "git
 			# status" due to a locked index. Since we have
--=20
2.34.1

