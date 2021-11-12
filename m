Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B65C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28CC61054
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhKLW4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:56:30 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:33330 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhKLW43 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:56:29 -0500
Received: by mail-lf1-f44.google.com with SMTP id bu18so25992436lfb.0
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PFE/VSKpztNV+ywXiwmJpaIR4gtSBTDcp5B/MjQEHSg=;
        b=ukh8ZOcPoDAHuOsQY8OBSG1rkx6cj4pqexx0YdqZt9Cky2H6i/MxbHqjPltcwVQmpV
         E0nL7jfIqCrqOta9j3nXwOM5Cz6JR8UOB7f0fuzjqlBvUwFjxXOTZ9zK7sEUY9kQCjbT
         XA8vgBv9EgP3RT1gjQAGTO267cCCdvufjuQUBX7TmH3VDRu0UGda8wmEaYfFFK+oHYI6
         0dS588mfqzyXCBezPxGjh+YAgOq4Gm3BWjSD74mb0OId3PyrBd/yKuqzb/gODeVGqmiR
         Dmu2IXtbaXIvs3TTJbUh5j9dzToA/s+m/64ZwPTTbtgUG5Ytul9SoagZ7qjnU3qsl2vB
         +ngA==
X-Gm-Message-State: AOAM532J8UmMYkQwdSjZ8XAzVbVnbuL6WJ3INrwRrH2ZF+xjLGOqpuZ/
        aSwx0amXDyRfMt4/iMB9ubpymBhnxRxs/g==
X-Google-Smtp-Source: ABdhPJyblYy1P1ZgmzDxr1yn7CxmrjA6kho3UuGnN0s1uQjn+zfK9C10zatAPY3utuP6YO2Egbne/g==
X-Received: by 2002:a05:6512:159d:: with SMTP id bp29mr16784955lfb.257.1636757616290;
        Fri, 12 Nov 2021 14:53:36 -0800 (PST)
Received: from localhost.localdomain (dy60ycsvq3px4-5d644gt-4.rev.dnainternet.fi. [2001:14bb:6bc:13e:2dbb:278f:e47a:c60b])
        by smtp.gmail.com with ESMTPSA id r25sm687698lfi.166.2021.11.12.14.53.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:53:35 -0800 (PST)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] Makefile, git-sh-setup.sh, t/: do not use `egrep` or `fgrep`
Date:   Sat, 13 Nov 2021 00:53:34 +0200
Message-Id: <20211112225334.1862016-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`egrep` and `fgrep` have been deprecated in GNU grep since 2007, and in
current post 3.7 Git they have been made to emit obsolescence warnings.

`grep -E` and `grep -F` on the other hand have been in POSIX and its
predecessors for decades; use them instead, and use basic regular
expressions instead of extended ones where applicable.

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 Makefile                             | 2 +-
 git-sh-setup.sh                      | 2 +-
 t/perf/run                           | 4 ++--
 t/t1304-default-acl.sh               | 4 ++--
 t/t3700-add.sh                       | 2 +-
 t/t3702-add-edit.sh                  | 2 +-
 t/t4014-format-patch.sh              | 8 ++++----
 t/t5320-delta-islands.sh             | 2 +-
 t/t7003-filter-branch.sh             | 4 ++--
 t/t7701-repack-unpack-unreachable.sh | 4 ++--
 t/t9001-send-email.sh                | 8 ++++----
 t/t9133-git-svn-nested-git-repo.sh   | 6 +++---
 t/t9134-git-svn-ignore-paths.sh      | 8 ++++----
 t/t9140-git-svn-reset.sh             | 4 ++--
 t/t9147-git-svn-include-paths.sh     | 8 ++++----
 t/t9814-git-p4-rename.sh             | 2 +-
 t/t9815-git-p4-submit-fail.sh        | 4 ++--
 t/test-lib-functions.sh              | 2 +-
 18 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/Makefile b/Makefile
index 12be39ac49..bef3580155 100644
--- a/Makefile
+++ b/Makefile
@@ -306,7 +306,7 @@ all::
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
 # Define SANE_TEXT_GREP to "-a" if you use recent versions of GNU grep
-# and egrep that are pickier when their input contains non-ASCII data.
+# that is pickier when its input contains non-ASCII data.
 #
 # The TCL_PATH variable governs the location of the Tcl interpreter
 # used to optimize git-gui for your system.  Only used if NO_TCLTK
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 960982f9d5..a479c7b4f0 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -178,7 +178,7 @@ sane_grep () {
 }
 
 sane_egrep () {
-	GREP_OPTIONS= LC_ALL=C egrep @@SANE_TEXT_GREP@@ "$@"
+	GREP_OPTIONS= LC_ALL=C grep -E @@SANE_TEXT_GREP@@ "$@"
 }
 
 is_bare_repository () {
diff --git a/t/perf/run b/t/perf/run
index 55219aa405..e8ac9a9009 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -229,10 +229,10 @@ then
 	)
 elif test -n "$GIT_PERF_SUBSECTION"
 then
-	egrep "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names >/dev/null ||
+	grep -E "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names >/dev/null ||
 		die "subsection '$GIT_PERF_SUBSECTION' not found in '$GIT_PERF_CONFIG_FILE'"
 
-	egrep "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names | while read -r subsec
+	grep -E "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names | while read -r subsec
 	do
 		(
 			GIT_PERF_SUBSECTION="$subsec"
diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 335d3f3211..c69ae41306 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -18,7 +18,7 @@ test_expect_success 'checking for a working acl setup' '
 	if setfacl -m d:m:rwx -m u:root:rwx . &&
 	   getfacl . | grep user:root:rwx &&
 	   touch should-have-readable-acl &&
-	   getfacl should-have-readable-acl | egrep "mask::?rw-"
+	   getfacl should-have-readable-acl | grep -E "mask::?rw-"
 	then
 		test_set_prereq SETFACL
 	fi
@@ -34,7 +34,7 @@ check_perms_and_acl () {
 	getfacl "$1" > actual &&
 	grep -q "user:root:rwx" actual &&
 	grep -q "user:${LOGNAME}:rwx" actual &&
-	egrep "mask::?r--" actual > /dev/null 2>&1 &&
+	grep -E "mask::?r--" actual > /dev/null 2>&1 &&
 	grep -q "group::---" actual || false
 }
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 283a66955d..6708d0d319 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -263,7 +263,7 @@ test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
 	git reset --hard &&
 	touch fo\[ou\]bar foobar &&
 	git add '\''fo\[ou\]bar'\'' &&
-	git ls-files fo\[ou\]bar | fgrep fo\[ou\]bar &&
+	git ls-files fo\[ou\]bar | grep -F fo\[ou\]bar &&
 	! ( git ls-files foobar | grep foobar )
 '
 
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 6c676645d8..7b7d53b443 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -98,7 +98,7 @@ EOF
 
 echo "#!$SHELL_PATH" >fake-editor.sh
 cat >> fake-editor.sh <<\EOF
-egrep -v '^index' "$1" >orig-patch &&
+grep -v '^index' "$1" >orig-patch &&
 mv -f patch "$1"
 EOF
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 712d4b5ddf..a43161e373 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1391,7 +1391,7 @@ append_signoff()
 	C=$(git commit-tree HEAD^^{tree} -p HEAD) &&
 	git format-patch --stdout --signoff $C^..$C >append_signoff.patch &&
 	sed -n -e "1,/^---$/p" append_signoff.patch |
-		egrep -n "^Subject|Sign|^$"
+		grep -En "^Subject|Sign|^$"
 }
 
 test_expect_success 'signoff: commit with no body' '
@@ -2208,10 +2208,10 @@ test_expect_success 'format-patch --base with --attach' '
 test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
 	test_when_finished "rm -fr patches" &&
 	git format-patch -o patches --cover-letter --attach=mimemime --base=HEAD~ -1 &&
-	! egrep "^--+mimemime" patches/0000*.patch &&
-	egrep "^--+mimemime$" patches/0001*.patch >output &&
+	! grep -E "^--+mimemime" patches/0000*.patch &&
+	grep -E "^--+mimemime$" patches/0001*.patch >output &&
 	test_line_count = 2 output &&
-	egrep "^--+mimemime--$" patches/0001*.patch >output &&
+	grep -E "^--+mimemime--$" patches/0001*.patch >output &&
 	test_line_count = 1 output
 '
 
diff --git a/t/t5320-delta-islands.sh b/t/t5320-delta-islands.sh
index fea92a5777..8016571cbf 100755
--- a/t/t5320-delta-islands.sh
+++ b/t/t5320-delta-islands.sh
@@ -132,7 +132,7 @@ test_expect_success 'island core places core objects first' '
 	    repack -adfi &&
 	git verify-pack -v .git/objects/pack/*.pack |
 	cut -d" " -f1 |
-	egrep "$root|$two" >actual &&
+	grep -E "$root|$two" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e18a218952..a00cdba049 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -49,7 +49,7 @@ test_expect_success 'result is really identical' '
 test_expect_success 'rewrite bare repository identically' '
 	(git config core.bare true && cd .git &&
 	 git filter-branch branch > filter-output 2>&1 &&
-	! fgrep fatal filter-output)
+	! grep -F fatal filter-output)
 '
 git config core.bare false
 test_expect_success 'result is really identical' '
@@ -506,7 +506,7 @@ test_expect_success 'rewrite repository including refs that point at non-commit
 	git tag -a -m "tag to a tree" treetag $new_tree &&
 	git reset --hard HEAD &&
 	git filter-branch -f -- --all >filter-output 2>&1 &&
-	! fgrep fatal filter-output
+	! grep -F fatal filter-output
 '
 
 test_expect_success 'filter-branch handles ref deletion' '
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 937f89ee8c..b7ac4f598a 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -35,7 +35,7 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '
 	git repack -A -d -l &&
 	# verify objects are packed in repository
 	test 3 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		   egrep "^($fsha1|$csha1|$tsha1) " |
+		   grep -E "^($fsha1|$csha1|$tsha1) " |
 		   sort | uniq | wc -l) &&
 	git show $fsha1 &&
 	git show $csha1 &&
@@ -49,7 +49,7 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '
 	git repack -A -d -l &&
 	# verify objects are retained unpacked
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		   egrep "^($fsha1|$csha1|$tsha1) " |
+		   grep -E "^($fsha1|$csha1|$tsha1) " |
 		   sort | uniq | wc -l) &&
 	git show $fsha1 &&
 	git show $csha1 &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index aa0c20499b..c8df9f39c0 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1518,7 +1518,7 @@ test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	grep "do not declare a Content-Transfer-Encoding" stdout &&
 	grep email-using-8bit stdout &&
 	grep "Which 8bit encoding" stdout &&
-	egrep "Content|MIME" msgtxt1 >actual &&
+	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
@@ -1529,7 +1529,7 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
 	git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
-	egrep "Content|MIME" msgtxt1 >actual &&
+	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
@@ -1544,7 +1544,7 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding in .git/config overrides --g
 	git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
-	egrep "Content|MIME" msgtxt1 >actual &&
+	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
@@ -1556,7 +1556,7 @@ test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 			--smtp-server="$(pwd)/fake.sendmail" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
-	egrep "Content|MIME" msgtxt1 >actual &&
+	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
diff --git a/t/t9133-git-svn-nested-git-repo.sh b/t/t9133-git-svn-nested-git-repo.sh
index f894860867..d8d536269c 100755
--- a/t/t9133-git-svn-nested-git-repo.sh
+++ b/t/t9133-git-svn-nested-git-repo.sh
@@ -35,7 +35,7 @@ test_expect_success 'SVN-side change outside of .git' '
 		echo b >> a &&
 		svn_cmd commit -m "SVN-side change outside of .git" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change outside of .git"
+		svn_cmd log -v | grep -F "SVN-side change outside of .git"
 	)
 '
 
@@ -59,7 +59,7 @@ test_expect_success 'SVN-side change inside of .git' '
 		svn_cmd add --force .git &&
 		svn_cmd commit -m "SVN-side change inside of .git" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change inside of .git"
+		svn_cmd log -v | grep -F "SVN-side change inside of .git"
 	)
 '
 
@@ -82,7 +82,7 @@ test_expect_success 'SVN-side change in and out of .git' '
 		git commit -m "add a inside an SVN repo" &&
 		svn_cmd commit -m "SVN-side change in and out of .git" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change in and out of .git"
+		svn_cmd log -v | grep -F "SVN-side change in and out of .git"
 	)
 '
 
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index fff49c4100..fec244d2aa 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -43,7 +43,7 @@ test_expect_success 'init+fetch an SVN repository with ignored www directory' '
 test_expect_success 'verify ignore-paths config saved by clone' '
 	(
 	    cd g &&
-	    git config --get svn-remote.svn.ignore-paths | fgrep "www"
+	    git config --get svn-remote.svn.ignore-paths | grep -F "www"
 	)
 '
 
@@ -53,7 +53,7 @@ test_expect_success 'SVN-side change outside of www' '
 		echo b >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change outside of www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change outside of www"
+		svn_cmd log -v | grep -F "SVN-side change outside of www"
 	)
 '
 
@@ -85,7 +85,7 @@ test_expect_success 'SVN-side change inside of ignored www' '
 		echo zaq >> www/test_www.txt &&
 		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
+		svn_cmd log -v | grep -F "SVN-side change inside of www/test_www.txt"
 	)
 '
 
@@ -118,7 +118,7 @@ test_expect_success 'SVN-side change in and out of ignored www' '
 		echo ygg >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
+		svn_cmd log -v | grep -F "SVN-side change in and out of ignored www"
 	)
 '
 
diff --git a/t/t9140-git-svn-reset.sh b/t/t9140-git-svn-reset.sh
index e855904629..b3c9425d55 100755
--- a/t/t9140-git-svn-reset.sh
+++ b/t/t9140-git-svn-reset.sh
@@ -43,7 +43,7 @@ test_expect_success 'fetch fails on modified hidden file' '
 	  git svn find-rev refs/remotes/git-svn > ../expect &&
 	  test_must_fail git svn fetch 2> ../errors &&
 	  git svn find-rev refs/remotes/git-svn > ../expect2 ) &&
-	fgrep "not found in commit" errors &&
+	grep -F "not found in commit" errors &&
 	test_cmp expect expect2
 '
 
@@ -59,7 +59,7 @@ test_expect_success 'refetch succeeds not ignoring any files' '
 	( cd g &&
 	  git svn fetch &&
 	  git svn rebase &&
-	  fgrep "mod hidden" hid/hid.txt
+	  grep -F "mod hidden" hid/hid.txt
 	)
 '
 
diff --git a/t/t9147-git-svn-include-paths.sh b/t/t9147-git-svn-include-paths.sh
index d292bf9f55..6cd2e4a2c7 100755
--- a/t/t9147-git-svn-include-paths.sh
+++ b/t/t9147-git-svn-include-paths.sh
@@ -45,7 +45,7 @@ test_expect_success 'init+fetch an SVN repository with included qqq directory' '
 test_expect_success 'verify include-paths config saved by clone' '
 	(
 	    cd g &&
-	    git config --get svn-remote.svn.include-paths | fgrep "qqq"
+	    git config --get svn-remote.svn.include-paths | grep -F "qqq"
 	)
 '
 
@@ -55,7 +55,7 @@ test_expect_success 'SVN-side change outside of www' '
 		echo b >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change outside of www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change outside of www"
+		svn_cmd log -v | grep -F "SVN-side change outside of www"
 	)
 '
 
@@ -87,7 +87,7 @@ test_expect_success 'SVN-side change inside of ignored www' '
 		echo zaq >> www/test_www.txt &&
 		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
+		svn_cmd log -v | grep -F "SVN-side change inside of www/test_www.txt"
 	)
 '
 
@@ -120,7 +120,7 @@ test_expect_success 'SVN-side change in and out of included qqq' '
 		echo ygg >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
 		svn_cmd up &&
-		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
+		svn_cmd log -v | grep -F "SVN-side change in and out of ignored www"
 	)
 '
 
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 468767cbf4..e856be111a 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -216,7 +216,7 @@ test_expect_success 'detect copies' '
 # variable exists, which allows admins to disable the "p4 move" command.
 test_lazy_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW '
 	p4 configure show run.move.allow >out &&
-	egrep ^run.move.allow: out
+	grep ^run.move.allow: out
 '
 
 # If move can be disabled, turn it off and test p4 move handling
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 9779dc0d11..ce75d4debe 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -417,8 +417,8 @@ test_expect_success 'cleanup chmod after submit cancel' '
 		! p4 fstat -T action text &&
 		test_path_is_file text+x &&
 		! p4 fstat -T action text+x &&
-		ls -l text | egrep ^-r-- &&
-		ls -l text+x | egrep ^-r-x
+		ls -l text | grep ^-r-- &&
+		ls -l text+x | grep ^-r-x
 	)
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index eef2262a36..b316a32dff 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -867,7 +867,7 @@ test_path_exists () {
 test_dir_is_empty () {
 	test "$#" -ne 1 && BUG "1 param"
 	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	if test -n "$(ls -a1 "$1" | grep -Ev '^\.\.?$')"
 	then
 		echo "Directory '$1' is not empty, it contains:"
 		ls -la "$1"
-- 
2.25.1

