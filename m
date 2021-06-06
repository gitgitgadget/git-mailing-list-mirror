Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915D7C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EFB6140F
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhFFQg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 12:36:28 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42862 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhFFQg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 12:36:27 -0400
Received: by mail-pf1-f174.google.com with SMTP id s14so10387037pfd.9
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 09:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kaxIfQXJ8R7rRKvwUdljD1PJZMtIyTajQY9xC5Cjrfs=;
        b=AB0Ut1SjwEwfTT8k9fDJ7ce2eg2Kt8p1HUEJvC6Ly7dAe4wgeeQKZKrA1PmCuKoBYp
         GtSG5+K9nyLkVVChIKkSTaDxK/WORbIDpU9JUPNTgpgRP7/mr5qWcAmgYnQqrS7LQ5Lc
         ChZjShPJ3tYIRkNBn0vYsXSAgqecEVg/8DE25t107tbKw2Azr4SC3liLmhGTkx3UoLQ3
         vUJdfiz9DxgX2B0X5w4mBpvZWbPpAIt3IkAjyD/eThMfs8+6z44ZqrbNfB6gh9Y2+q/a
         g8qe4C+s6oPVgBMsf735TYQhkoIgCY/961Tw7bn6xLBeHULJvWPV9bs4iyqJ+g/iZvLx
         01IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaxIfQXJ8R7rRKvwUdljD1PJZMtIyTajQY9xC5Cjrfs=;
        b=mR73tzk21EYt5rJgjgi33r64dGhyiLwkrtwOZD7wSFTF/j8WcnXdZqVXf79A6WkkkA
         kyRi7BEdBGzTYyXAuAV3SLgbt3+2CNvdZt2r05Iv9lg1YO330MRz6Bj24jdi7Yht6tnH
         jn+4AR64tGyt4IHMvmMq30bci5wt4YPLAUhGqNWi8yuvcM+SoHHpIslcoiWdnroGglIa
         khqGaZPZz3LazKHCbyvolOPOSXhjo/Bev6GQJAjbtaDoXWjizs6g6l1HXoDod3zlE8qd
         ICQP5S8Dt2c/bkDUJ2jEZmDgBddXjIYChJYRGlHzi/C/TdJFgzyPfa9EbWY6WuIWhuYE
         YF0A==
X-Gm-Message-State: AOAM530lA9oJpYC45B7wN/G8SSTc/l/lEW8aLKZTUxTuex1iKVcvfdU2
        7zoaXDUQTjOwizGLJ7OMnCkXsQSfE8DKdg==
X-Google-Smtp-Source: ABdhPJy0YdGm6qKaYj+rKa+Xjatap3mkyr9R4Jd9qTFPVXE9gEyavLJ1c76ksfKmwcaASla3+L6k1A==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr14306854pgu.424.1622997203639;
        Sun, 06 Jun 2021 09:33:23 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id x36sm6118276pfu.39.2021.06.06.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 09:33:23 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <ttaylorr@github.com>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] t: use user-specific utf-8 locale for testing
Date:   Sun,  6 Jun 2021 23:33:16 +0700
Message-Id: <20210606163316.8630-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.5.gf3d78db977
In-Reply-To: <20210602114646.17463-1-congdanhqx@gmail.com>
References: <20210602114646.17463-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some test-cases, utf-8 locale is required. To find such locale,
we're using the first available UTF-8 locale that returned by
"locale -a".

Despite being required by POSIX, locale(1) is unavailable in some
systems, e.g. Linux with musl libc.  Some of those systems support
utf-8 locale out of the box.

However, without "locale -a", we can't guess provided UTF-8 locale.

Let's give users of those systems an option to have better test
coverage.

This change also rename t/lib-git-svn.sh:prepare_a_utf8_locale to
prepare_utf8_locale, since we no longer prepare the variable named
"a_utf8_locale" but set up a fallback value for GIT_TEST_UTF8_LOCALE
instead.  The fallback will be LC_ALL, LANG environment variable,
or the first utf-8 locale from output of "locale -a", in that order.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
Range-diff against v1:
1:  d242ce64c4 ! 1:  f299ae2239 t: use user-specific utf-8 locale for testing
    @@ Commit message
         Let's give users of those systems an option to have better test
         coverage.
     
    +    This change also rename t/lib-git-svn.sh:prepare_a_utf8_locale to
    +    prepare_utf8_locale, since we no longer prepare the variable named
    +    "a_utf8_locale" but set up a fallback value for GIT_TEST_UTF8_LOCALE
    +    instead.  The fallback will be LC_ALL, LANG environment variable,
    +    or the first utf-8 locale from output of "locale -a", in that order.
    +
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Makefile ##
    @@ Makefile: all::
      # with a different indexfile format version.  If it isn't set the index
      # file format used is index-v[23].
      #
    -+# Define GIT_TEST_UTF8_LOCALE to prefered utf-8 locale for testing.
    -+# If it isn't set, use the first utf-8 locale returned by "locale -a".
    ++# Define GIT_TEST_UTF8_LOCALE to preferred utf-8 locale for testing.
    ++# If it isn't set, fallback to $LC_ALL, $LANG or use the first utf-8
    ++# locale returned by "locale -a".
     +#
      # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
      #
    @@ Makefile: ifdef GIT_TEST_CMP
      	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
      ifdef GIT_PERF_REPEAT_COUNT
     
    + ## ci/lib.sh ##
    +@@ ci/lib.sh: linux-musl)
    + 	CC=gcc
    + 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
    + 	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
    ++	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
    + 	;;
    + esac
    + 
    +
      ## t/lib-git-svn.sh ##
     @@ t/lib-git-svn.sh: start_svnserve () {
      		 --listen-host 127.0.0.1 &
    @@ t/lib-git-svn.sh: start_svnserve () {
     -}')
     -	if test -n "$a_utf8_locale"
     +prepare_utf8_locale () {
    -+	if test -z "$GIT_TEST_UTF8_LOCALE"
    ++	if test -n "$GIT_TEST_UTF8_LOCALE"
    ++	then
    ++		: test_set_prereq UTF8
    ++	elif test -n "${LC_ALL:-$LANG}"
     +	then
    ++		case "${LC_ALL:-$LANG}" in
    ++		*.[Uu][Tt][Ff]8 | *.[Uu][Tt][Ff]-8)
    ++			GIT_TEST_UTF8_LOCALE="${LC_ALL:-$LANG}"
    ++			;;
    ++		esac
    ++	else
     +		GIT_TEST_UTF8_LOCALE=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
     +		p
     +		q

 Makefile                                 |  7 +++++++
 ci/lib.sh                                |  1 +
 t/lib-git-svn.sh                         | 24 ++++++++++++++++++------
 t/t9100-git-svn-basic.sh                 | 14 +++-----------
 t/t9115-git-svn-dcommit-funky-renames.sh |  6 +++---
 t/t9129-git-svn-i18n-commitencoding.sh   |  4 ++--
 6 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8..502e0c9a81 100644
--- a/Makefile
+++ b/Makefile
@@ -398,6 +398,10 @@ all::
 # with a different indexfile format version.  If it isn't set the index
 # file format used is index-v[23].
 #
+# Define GIT_TEST_UTF8_LOCALE to preferred utf-8 locale for testing.
+# If it isn't set, fallback to $LC_ALL, $LANG or use the first utf-8
+# locale returned by "locale -a".
+#
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
@@ -2801,6 +2805,9 @@ ifdef GIT_TEST_CMP
 endif
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
+endif
+ifdef GIT_TEST_UTF8_LOCALE
+	@echo GIT_TEST_UTF8_LOCALE=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_UTF8_LOCALE)))'\' >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
diff --git a/ci/lib.sh b/ci/lib.sh
index d848c036c5..476c3f369f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -229,6 +229,7 @@ linux-musl)
 	CC=gcc
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3 USE_LIBPCRE2=Yes"
 	MAKEFLAGS="$MAKEFLAGS NO_REGEX=Yes ICONV_OMITS_BOM=Yes"
+	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 esac
 
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 547eb3c31a..83efc17661 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -121,12 +121,24 @@ start_svnserve () {
 		 --listen-host 127.0.0.1 &
 }
 
-prepare_a_utf8_locale () {
-	a_utf8_locale=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
-	p
-	q
-}')
-	if test -n "$a_utf8_locale"
+prepare_utf8_locale () {
+	if test -n "$GIT_TEST_UTF8_LOCALE"
+	then
+		: test_set_prereq UTF8
+	elif test -n "${LC_ALL:-$LANG}"
+	then
+		case "${LC_ALL:-$LANG}" in
+		*.[Uu][Tt][Ff]8 | *.[Uu][Tt][Ff]-8)
+			GIT_TEST_UTF8_LOCALE="${LC_ALL:-$LANG}"
+			;;
+		esac
+	else
+		GIT_TEST_UTF8_LOCALE=$(locale -a | sed -n '/\.[uU][tT][fF]-*8$/{
+		p
+		q
+	}')
+	fi
+	if test -n "$GIT_TEST_UTF8_LOCALE"
 	then
 		test_set_prereq UTF8
 	else
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 1d3fdcc997..d5563ec35f 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -4,21 +4,13 @@
 #
 
 test_description='git svn basic tests'
-GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-git-svn.sh
 
-case "$GIT_SVN_LC_ALL" in
-*.UTF-8)
-	test_set_prereq UTF8
-	;;
-*)
-	say "# UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
-	;;
-esac
+prepare_utf8_locale
 
 test_expect_success 'git svn --version works anywhere' '
 	nongit git svn --version
@@ -187,8 +179,8 @@ test_expect_success POSIXPERM,SYMLINKS "$name" '
 	test ! -h "$SVN_TREE"/exec-2.sh &&
 	test_cmp help "$SVN_TREE"/exec-2.sh'
 
-name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
-LC_ALL="$GIT_SVN_LC_ALL"
+name="commit with UTF-8 message: locale: $GIT_TEST_UTF8_LOCALE"
+LC_ALL="$GIT_TEST_UTF8_LOCALE"
 export LC_ALL
 # This test relies on the previous test, hence requires POSIXPERM,SYMLINKS
 test_expect_success UTF8,POSIXPERM,SYMLINKS "$name" "
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 9b44a44bc1..743fbe1fe4 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,9 +93,9 @@ test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
 # > ... All of the above characters, except for the backslash, are converted
 # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
 # > "Private use area") when creating or accessing files.
-prepare_a_utf8_locale
+prepare_utf8_locale
 test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 new file on dcommit' '
-	LC_ALL=$a_utf8_locale &&
+	LC_ALL=$GIT_TEST_UTF8_LOCALE &&
 	export LC_ALL &&
 	neq=$(printf "\201\202") &&
 	git config svn.pathnameencoding cp932 &&
@@ -107,7 +107,7 @@ test_expect_success UTF8,!MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 new
 
 # See the comment on the above test for setting of LC_ALL.
 test_expect_success !MINGW,!UTF8_NFD_TO_NFC 'svn.pathnameencoding=cp932 rename on dcommit' '
-	LC_ALL=$a_utf8_locale &&
+	LC_ALL=$GIT_TEST_UTF8_LOCALE &&
 	export LC_ALL &&
 	inf=$(printf "\201\207") &&
 	git config svn.pathnameencoding cp932 &&
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 2c213ae654..01e1e8a8f7 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -14,12 +14,12 @@ compare_git_head_with () {
 	test_cmp current "$1"
 }
 
-prepare_a_utf8_locale
+prepare_utf8_locale
 
 compare_svn_head_with () {
 	# extract just the log message and strip out committer info.
 	# don't use --limit here since svn 1.1.x doesn't have it,
-	LC_ALL="$a_utf8_locale" svn log $(git svn info --url) | perl -w -e '
+	LC_ALL="$GIT_TEST_UTF8_LOCALE" svn log $(git svn info --url) | perl -w -e '
 		use bytes;
 		$/ = ("-"x72) . "\n";
 		my @x = <STDIN>;
-- 
2.32.0.rc3.5.gf3d78db977

