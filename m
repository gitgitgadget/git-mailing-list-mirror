Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5251F453
	for <e@80x24.org>; Thu,  8 Nov 2018 21:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeKIGxF (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 01:53:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36000 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeKIGxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 01:53:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so113906wmf.1
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WzhURFI2ffIdoHJx7/fNuoVTVMnP1NQcj4w1eIuWLY=;
        b=sTFKNftnJ1ubLswK6Y74/zVHMKvmkNOEpBYwOzoeGxCNxLzetpAtSk3ZLTtHAwkM3b
         FNDijbubT/wz0j5FxplV1HboaKLjmPdht/CKz6noZhWXCV7IJTXnnggyQpx2pBcNA9R9
         GA9JyR78G3CVqm1dLjKyQnk6KkXcL/bH9uSMyzNo0AGOOOt6P8qZTuxcQlJ8SsskaJc9
         yh95bMkQFZiqjirEr88fDdjlcckUuXvsme0Ct7pahdz0EHTA7P2PyMhYz9+T9AXq0b7O
         n9AtjjEfwcGTA1bp/wISCbvphkr3WRMyvJRyzTlWv0Ad9otf5YwTsd18UUzZ8mBzOeSO
         LsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WzhURFI2ffIdoHJx7/fNuoVTVMnP1NQcj4w1eIuWLY=;
        b=d1jHpk+oI8sixqRdlCl7dj+EzNTHWNTzl66fOU8j2T5K9ORtXWVF4/T3PzdQhAebwF
         E9lKQ00j0Q/O+9w9Bp/Ul+0ckcUx3riJQIRqU19QeZDxbUetWxzORUSDf45ou6NQ7gDQ
         dMz3T2aeL/8eG6nZVpoS0k6FHPXxT4qzIh+Mg1nIKUL14cPTUMpHVa7w1y3/n+cLjpyz
         mOquNdFujttwXkKd9EQ9RAJo3dVeuJu3dydL0XhzZs602dPR739Sj4QJkpZRYoBZgPsJ
         zhL7qDlFmtk9+0Wj/V8tdV1VBq73VXnvVR/MUHIdm7xeoEQvO153ioMIL4+NzfGewvaZ
         xDDQ==
X-Gm-Message-State: AGRZ1gJwGA6LDLSCBSPSMAaW3OE/9jM7cmxBE8AgtsL6bD+fXlbYQfB0
        kcdctI6lsb4a+KwgmGSbTl6S0bq5
X-Google-Smtp-Source: AJdET5dsPYlqj/WOkVJCvCmMf+zUfRbvLo1zffio9/tTn5p9Pbct0r/BKUYEBpUY7AChKi9sTx2DrA==
X-Received: by 2002:a1c:4683:: with SMTP id t125-v6mr2688002wma.112.1541711743305;
        Thu, 08 Nov 2018 13:15:43 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e66-v6sm9036262wmf.40.2018.11.08.13.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 13:15:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/2] i18n: make GETTEXT_POISON a runtime option
Date:   Thu,  8 Nov 2018 21:15:29 +0000
Message-Id: <20181108211530.29017-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181101193115.32681-1-avarab@gmail.com>
References: <20181101193115.32681-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the GETTEXT_POISON compile-time + runtime GIT_GETTEXT_POISON
test parameter to only be a GIT_TEST_GETTEXT_POISON=<non-empty?>
runtime parameter, to be consistent with other parameters documented
in "Running tests with special setups" in t/README.

When I added GETTEXT_POISON in bb946bba76 ("i18n: add GETTEXT_POISON
to simulate unfriendly translator", 2011-02-22) I was concerned with
ensuring that the _() function would get constant folded if NO_GETTEXT
was defined, and likewise that GETTEXT_POISON would be compiled out
unless it was defined.

But as the benchmark in my [1] shows doing a one-off runtime
getenv("GIT_TEST_[...]") is trivial, and since GETTEXT_POISON was
originally added the GIT_TEST_* env variables have become the common
idiom for turning on special test setups.

So change GETTEXT_POISON to work the same way. Now the
GETTEXT_POISON=YesPlease compile-time option is gone, and running the
tests with GIT_TEST_GETTEXT_POISON=[YesPlease|] can be toggled on/off
without recompiling.

This allows for conditionally amending tests to test with/without
poison, similar to what 859fdc0c3c ("commit-graph: define
GIT_TEST_COMMIT_GRAPH", 2018-08-29) did for GIT_TEST_COMMIT_GRAPH. Do
some of that, now we e.g. always run the t0205-gettext-poison.sh test.

I did enough there to remove the GETTEXT_POISON prerequisite, but its
inverse C_LOCALE_OUTPUT is still around, and surely some tests using
it can be converted to e.g. always set GIT_TEST_GETTEXT_POISON=.

Notes on the implementation:

 * We still compile a dedicated GETTEXT_POISON build in Travis
   CI. Perhaps this should be revisited and integrated into the
   "linux-gcc" build, see ae59a4e44f ("travis: run tests with
   GIT_TEST_SPLIT_INDEX", 2018-01-07) for prior art in that area. Then
   again maybe not, see [2].

 * We now skip a test in t0000-basic.sh under
   GIT_TEST_GETTEXT_POISON=YesPlease that wasn't skipped before. This
   test relies on C locale output, but due to an edge case in how the
   previous implementation of GETTEXT_POISON worked (reading it from
   GIT-BUILD-OPTIONS) wasn't enabling poison correctly. Now it does,
   and needs to be skipped.

 * The getenv() function is not reentrant, so out of paranoia about
   code of the form:

       printf(_("%s"), getenv("some-env"));

   call use_gettext_poison() in our early setup in git_setup_gettext()
   so we populate the "poison_requested" variable in a codepath that's
   won't suffer from that race condition.

 * We error out in the Makefile if you're still saying
   GETTEXT_POISON=YesPlease to prompt users to change their
   invocation.

 * We should not print out poisoned messages during the test
   initialization itself to keep it more readable, so the test library
   hides the variable if set in $GIT_TEST_GETTEXT_POISON_ORIG during
   setup. See [3].

See also [4] for more on the motivation behind this patch, and the
history of the GETTEXT_POISON facility.

1. https://public-inbox.org/git/871s8gd32p.fsf@evledraar.gmail.com/
2. https://public-inbox.org/git/20181102163725.GY30222@szeder.dev/
3. https://public-inbox.org/git/20181022202241.18629-2-szeder.dev@gmail.com/
4. https://public-inbox.org/git/878t2pd6yu.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .travis.yml               |  2 +-
 Makefile                  |  8 +-------
 ci/lib-travisci.sh        |  4 ++--
 gettext.c                 | 11 +++++++----
 gettext.h                 |  9 +++------
 git-sh-i18n.sh            |  2 +-
 po/README                 | 13 ++++---------
 t/README                  |  6 ++++++
 t/lib-gettext.sh          |  2 +-
 t/t0000-basic.sh          |  2 +-
 t/t0205-gettext-poison.sh |  8 +++++---
 t/t3406-rebase-message.sh |  2 +-
 t/t7201-co.sh             |  6 +++---
 t/t9902-completion.sh     |  3 ++-
 t/test-lib-functions.sh   |  8 ++++----
 t/test-lib.sh             | 22 +++++++++++++++++-----
 16 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8d2499739e..a329a0add6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -24,7 +24,7 @@ addons:
 
 matrix:
   include:
-    - env: jobname=GETTEXT_POISON
+    - env: jobname=GIT_TEST_GETTEXT_POISON
       os: linux
       compiler:
       addons:
diff --git a/Makefile b/Makefile
index bbfbb4292d..f3a9995e50 100644
--- a/Makefile
+++ b/Makefile
@@ -362,11 +362,6 @@ all::
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
-# Define GETTEXT_POISON if you are debugging the choice of strings marked
-# for translation.  In a GETTEXT_POISON build, you can turn all strings marked
-# for translation into gibberish by setting the GIT_GETTEXT_POISON variable
-# (to any value) in your environment.
-#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
@@ -1452,7 +1447,7 @@ ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
 ifdef GETTEXT_POISON
-	BASIC_CFLAGS += -DGETTEXT_POISON
+$(error The GETTEXT_POISON option has been removed in favor of runtime GIT_TEST_GETTEXT_POISON. See t/README!)
 endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
@@ -2603,7 +2598,6 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	@echo GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease >>$@+
 endif
 	@echo NO_GETTEXT=\''$(subst ','\'',$(subst ','\'',$(NO_GETTEXT)))'\' >>$@+
-	@echo GETTEXT_POISON=\''$(subst ','\'',$(subst ','\'',$(GETTEXT_POISON)))'\' >>$@+
 ifdef GIT_PERF_REPEAT_COUNT
 	@echo GIT_PERF_REPEAT_COUNT=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_REPEAT_COUNT)))'\' >>$@+
 endif
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 06970f7213..69dff4d1ec 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -123,7 +123,7 @@ osx-clang|osx-gcc)
 	# Travis CI OS X
 	export GIT_SKIP_TESTS="t9810 t9816"
 	;;
-GETTEXT_POISON)
-	export GETTEXT_POISON=YesPlease
+GIT_TEST_GETTEXT_POISON)
+	export GIT_TEST_GETTEXT_POISON=YesPlease
 	;;
 esac
diff --git a/gettext.c b/gettext.c
index 7272771c8e..d4021d690c 100644
--- a/gettext.c
+++ b/gettext.c
@@ -7,6 +7,7 @@
 #include "gettext.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "config.h"
 
 #ifndef NO_GETTEXT
 #	include <locale.h>
@@ -46,15 +47,15 @@ const char *get_preferred_languages(void)
 	return NULL;
 }
 
-#ifdef GETTEXT_POISON
 int use_gettext_poison(void)
 {
 	static int poison_requested = -1;
-	if (poison_requested == -1)
-		poison_requested = getenv("GIT_GETTEXT_POISON") ? 1 : 0;
+	if (poison_requested == -1) {
+		const char *v = getenv("GIT_TEST_GETTEXT_POISON");
+		poison_requested = v && strlen(v) ? 1 : 0;
+	}
 	return poison_requested;
 }
-#endif
 
 #ifndef NO_GETTEXT
 static int test_vsnprintf(const char *fmt, ...)
@@ -164,6 +165,8 @@ void git_setup_gettext(void)
 	if (!podir)
 		podir = p = system_path(GIT_LOCALE_PATH);
 
+	use_gettext_poison(); /* getenv() reentrancy paranoia */
+
 	if (!is_directory(podir)) {
 		free(p);
 		return;
diff --git a/gettext.h b/gettext.h
index 7eee64a34f..71255e503e 100644
--- a/gettext.h
+++ b/gettext.h
@@ -28,12 +28,15 @@
 
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
 
+extern int use_gettext_poison(void);
+
 #ifndef NO_GETTEXT
 extern void git_setup_gettext(void);
 extern int gettext_width(const char *s);
 #else
 static inline void git_setup_gettext(void)
 {
+	use_gettext_poison(); /* getenv() reentrancy paranoia */
 }
 static inline int gettext_width(const char *s)
 {
@@ -41,12 +44,6 @@ static inline int gettext_width(const char *s)
 }
 #endif
 
-#ifdef GETTEXT_POISON
-extern int use_gettext_poison(void);
-#else
-#define use_gettext_poison() 0
-#endif
-
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 {
 	if (!*msgid)
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 9d065fb4bf..e1d917fd27 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,7 +17,7 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "$GIT_GETTEXT_POISON"
+if test -n "$GIT_TEST_GETTEXT_POISON"
 then
 	GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
 elif test -n "@@USE_GETTEXT_SCHEME@@"
diff --git a/po/README b/po/README
index fef4c0f0b5..aa704ffcb7 100644
--- a/po/README
+++ b/po/README
@@ -289,16 +289,11 @@ something in the test suite might still depend on the US English
 version of the strings, e.g. to grep some error message or other
 output.
 
-To smoke out issues like these Git can be compiled with gettext poison
-support, at the top-level:
+To smoke out issues like these, Git tested with a translation mode that
+emits gibberish on every call to gettext. To use it run the test suite
+with it, e.g.:
 
-    make GETTEXT_POISON=YesPlease
-
-That'll give you a git which emits gibberish on every call to
-gettext. It's obviously not meant to be installed, but you should run
-the test suite with it:
-
-    cd t && prove -j 9 ./t[0-9]*.sh
+    cd t && GIT_TEST_GETTEXT_POISON=YesPlease prove -j 9 ./t[0-9]*.sh
 
 If tests break with it you should inspect them manually and see if
 what you're translating is sane, i.e. that you're not translating
diff --git a/t/README b/t/README
index 2e9bef2852..bb2db49615 100644
--- a/t/README
+++ b/t/README
@@ -302,6 +302,12 @@ that cannot be easily covered by a few specific test cases. These
 could be enabled by running the test suite with correct GIT_TEST_
 environment set.
 
+GIT_TEST_GETTEXT_POISON=<non-empty?> turns all strings marked for
+translation into gibberish if non-empty (think "test -n"). Used for
+spotting those tests that need to be marked with a C_LOCALE_OUTPUT
+prerequisite when adding more strings for translation. See "Testing
+marked strings" in po/README for details.
+
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index eec757f104..755f421431 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -12,7 +12,7 @@ export GIT_TEXTDOMAINDIR GIT_PO_PATH
 
 . "$GIT_BUILD_DIR"/git-sh-i18n
 
-if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
+if test_have_prereq GETTEXT && test_have_prereq C_LOCALE_OUTPUT
 then
 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
 	is_IS_locale=$(locale -a 2>/dev/null |
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4d23373526..b6566003dd 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -274,7 +274,7 @@ test_expect_success 'pretend we have a mix of all possible results' "
 	EOF
 "
 
-test_expect_success 'test --verbose' '
+test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 	test_must_fail run_sub_test_lib_test \
 		test-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
index 438e778d6a..a06269f38a 100755
--- a/t/t0205-gettext-poison.sh
+++ b/t/t0205-gettext-poison.sh
@@ -5,13 +5,15 @@
 
 test_description='Gettext Shell poison'
 
+GIT_TEST_GETTEXT_POISON=YesPlease
+export GIT_TEST_GETTEXT_POISON
 . ./lib-gettext.sh
 
-test_expect_success GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
+test_expect_success 'sanity: $GIT_INTERNAL_GETTEXT_SH_SCHEME" is poison' '
     test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" = "poison"
 '
 
-test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback has poison semantics' '
+test_expect_success 'gettext: our gettext() fallback has poison semantics' '
     printf "# GETTEXT POISON #" >expect &&
     gettext "test" >actual &&
     test_cmp expect actual &&
@@ -20,7 +22,7 @@ test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback has poison s
     test_cmp expect actual
 '
 
-test_expect_success GETTEXT_POISON 'eval_gettext: our eval_gettext() fallback has poison semantics' '
+test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semantics' '
     printf "# GETTEXT POISON #" >expect &&
     eval_gettext "test" >actual &&
     test_cmp expect actual &&
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 0392e36d23..2bdcf83808 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -77,7 +77,7 @@ test_expect_success 'rebase -n overrides config rebase.stat config' '
 #     "Does not point to a valid commit: invalid-ref"
 #
 # NEEDSWORK: This "grep" is fine in real non-C locales, but
-# GETTEXT_POISON poisons the refname along with the enclosing
+# GIT_TEST_GETTEXT_POISON poisons the refname along with the enclosing
 # error message.
 test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 826987ca80..72b9b375ba 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -254,9 +254,9 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
-	git checkout renamer^ 2>messages &&
-	test_i18ngrep "HEAD is now at 7329388" messages &&
-	(test_line_count -gt 1 messages || test -n "$GETTEXT_POISON") &&
+	GIT_TEST_GETTEXT_POISON= git checkout renamer^ 2>messages &&
+	grep "HEAD is now at 7329388" messages &&
+	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 175f83d704..3c6b185b60 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1697,7 +1697,8 @@ test_expect_success 'sourcing the completion script clears cached commands' '
 	verbose test -z "$__git_all_commands"
 '
 
-test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
+test_expect_success 'sourcing the completion script clears cached merge strategies' '
+	GIT_TEST_GETTEXT_POISON= &&
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..2f42b3653c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -755,16 +755,16 @@ test_cmp_bin() {
 
 # Use this instead of test_cmp to compare files that contain expected and
 # actual output from git commands that can be translated.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
+# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ncmp () {
-	test -n "$GETTEXT_POISON" || test_cmp "$@"
+	! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
 }
 
 # Use this instead of "grep expected-string actual" to see if the
 # output from a git command that can be translated either contains an
 # expected string, or does not contain an unwanted one.  When running
-# under GETTEXT_POISON this pretends that the command produced expected
+# under GIT_TEST_GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ngrep () {
 	eval "last_arg=\${$#}"
@@ -779,7 +779,7 @@ test_i18ngrep () {
 		error "bug in the test script: too few parameters to test_i18ngrep"
 	fi
 
-	if test -n "$GETTEXT_POISON"
+	if test_have_prereq !C_LOCALE_OUTPUT
 	then
 		# pretend success
 		return 0
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 47a99aa0ed..b50f934dcd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -95,6 +95,16 @@ PAGER=cat
 TZ=UTC
 export LANG LC_ALL PAGER TZ
 EDITOR=:
+
+# GIT_TEST_GETTEXT_POISON should not influence git commands executed
+# during initialization of test-lib and the test repo. Back it up,
+# unset and then restore after initialization is finished.
+if test -n "$GIT_TEST_GETTEXT_POISON"
+then
+	GIT_TEST_GETTEXT_POISON_ORIG=$GIT_TEST_GETTEXT_POISON
+	unset GIT_TEST_GETTEXT_POISON
+fi
+
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
@@ -1104,13 +1114,15 @@ test -n "$USE_LIBPCRE1" && test_set_prereq LIBPCRE1
 test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
+if test -n "$GIT_TEST_GETTEXT_POISON_ORIG"
+then
+	GIT_TEST_GETTEXT_POISON=$GIT_TEST_GETTEXT_POISON_ORIG
+	unset GIT_TEST_GETTEXT_POISON_ORIG
+fi
+
 # Can we rely on git's output in the C locale?
-if test -n "$GETTEXT_POISON"
+if test -z "$GIT_TEST_GETTEXT_POISON"
 then
-	GIT_GETTEXT_POISON=YesPlease
-	export GIT_GETTEXT_POISON
-	test_set_prereq GETTEXT_POISON
-else
 	test_set_prereq C_LOCALE_OUTPUT
 fi
 
-- 
2.19.1.930.g4563a0d9d0

