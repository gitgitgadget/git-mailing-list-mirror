From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/7] tests: subshell indentation stylefix
Date: Mon, 6 Sep 2010 20:42:54 -0500
Message-ID: <20100907014254.GB1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:45:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnF7-00059x-Aj
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087Ab0IGBo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 21:44:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50352 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756035Ab0IGBoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:44:55 -0400
Received: by gyd8 with SMTP id 8so1794604gyd.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VObGOji+mFIXJgTQ/5wohK+gNsZ/K+SrU+3P5kY1hxY=;
        b=Qyiu46jX72rM3gezI80yx9kRaCcU3j1now46wx2ocPQlfJKRiYOkOnjdbz08BXs62j
         /9yZ2ff60ZRquEluiR77yM1hiSuzDPRXiPXSzVM10uHk0cvotXl/cjTsbOixaSZVZsR2
         52yjjxTDdMftfyFCU2jxJZ6aLPe93xM/chCbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UG2yIqelEFqg1+iAieutg2dt0M/U+fADC981zfpmTSDb+jljXNZCWpWZr7CWO3oDk9
         Xctqir5bCQWT+qbo0eKMAK2KDhr7QiXlkOC/VICAMF2v5orlU0SbB84oW7owhhFb4AMY
         di7GKPNlYj5PysacI6+u8cyajIHdKkMJMAuNQ=
Received: by 10.100.190.11 with SMTP id n11mr387307anf.160.1283823894286;
        Mon, 06 Sep 2010 18:44:54 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id d4sm10319984and.39.2010.09.06.18.44.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:44:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907014135.GA1182@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155658>

Format the subshells introduced by the previous patch (Several tests:
cd inside subshell instead of around, 2010-09-06) like so:

	(
		cd subdir &&
		...
	) &&

This is generally easier to read and has the nice side-effect that
this patch will show what commands are used in the subshell, making
it easier to check for lost environment variables and similar
behavior changes.

Cc: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t1020-subdirectory.sh                       |   13 +++--
 t/t1302-repo-version.sh                       |   11 +++-
 t/t3060-ls-files-with-tree.sh                 |   12 ++--
 t/t3409-rebase-preserve-merges.sh             |   13 +++--
 t/t3903-stash.sh                              |    5 +-
 t/t4041-diff-submodule-option.sh              |    7 ++-
 t/t5510-fetch.sh                              |   35 +++++++------
 t/t6050-replace.sh                            |   46 +++++++++--------
 t/t7400-submodule-basic.sh                    |   11 ++--
 t/t7401-submodule-summary.sh                  |    7 ++-
 t/t9100-git-svn-basic.sh                      |   21 ++++----
 t/t9101-git-svn-props.sh                      |   33 +++++++-----
 t/t9102-git-svn-deep-rmdir.sh                 |   13 +++--
 t/t9104-git-svn-follow-parent.sh              |   56 +++++++++++---------
 t/t9105-git-svn-commit-diff.sh                |    7 ++-
 t/t9106-git-svn-commit-diff-clobber.sh        |   30 ++++++-----
 t/t9107-git-svn-migrate.sh                    |   16 +++---
 t/t9114-git-svn-dcommit-merge.sh              |    7 ++-
 t/t9115-git-svn-dcommit-funky-renames.sh      |    7 ++-
 t/t9116-git-svn-log.sh                        |   16 +++---
 t/t9119-git-svn-info.sh                       |   69 ++++++++++++++++---------
 t/t9120-git-svn-clone-with-percent-escapes.sh |    3 +-
 22 files changed, 253 insertions(+), 185 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index c36157a..0d0da17 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -27,12 +27,13 @@ test_expect_success 'update-index and ls-files' '
 	one) echo pass one ;;
 	*) echo bad one; exit 1 ;;
 	esac &&
-	(cd dir &&
-	git update-index --add two &&
-	case "`git ls-files`" in
-	two) echo pass two ;;
-	*) echo bad two; exit 1 ;;
-	esac
+	(
+		cd dir &&
+		git update-index --add two &&
+		case "`git ls-files`" in
+		two) echo pass two ;;
+		*) echo bad two; exit 1 ;;
+		esac
 	) &&
 	case "`git ls-files`" in
 	dir/two"$LF"one) echo pass both ;;
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index c948719..0da2799 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -33,8 +33,15 @@ test_expect_success 'gitdir selection on unsupported repo' '
 
 test_expect_success 'gitdir not required mode' '
 	git apply --stat test.patch &&
-	(cd test && git apply --stat ../test.patch) &&
-	(cd test2 && git apply --stat ../test.patch)'
+	(
+		cd test &&
+		git apply --stat ../test.patch
+	) &&
+	(
+		cd test2 &&
+		git apply --stat ../test.patch
+	)
+'
 
 test_expect_success 'gitdir required mode on normal repos' '
 	(git apply --check --index test.patch &&
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 25afb4f..61c1f53 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -53,13 +53,13 @@ test_expect_success setup '
 	git add .
 '
 
-# We have to run from a sub-directory to trigger prune_path
-# Then we finally get to run our --with-tree test
-
 test_expect_success 'git -ls-files --with-tree should succeed from subdir' '
-
-	(cd sub && git ls-files --with-tree=HEAD~1 >../output)
-
+	# We have to run from a sub-directory to trigger prune_path
+	# Then we finally get to run our --with-tree test
+	(
+		cd sub &&
+		git ls-files --with-tree=HEAD~1 >../output
+	)
 '
 
 test_expect_success \
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 1a362d2..74161a4 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -52,12 +52,13 @@ test_expect_success 'setup for merge-preserving rebase' \
 	git commit -m "Add different B" &&
 
 	git clone ./. clone2 &&
-	(cd clone2 &&
-	git checkout -b topic origin/topic &&
-	test_must_fail git merge origin/master &&
-	echo Resolved > B &&
-	git add B &&
-	git commit -m "Merge origin/master into topic"
+	(
+		cd clone2 &&
+		git checkout -b topic origin/topic &&
+		test_must_fail git merge origin/master &&
+		echo Resolved >B &&
+		git add B &&
+		git commit -m "Merge origin/master into topic"
 	) &&
 
 	git checkout topic &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 3f43012..bd4b288 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -69,8 +69,9 @@ test_expect_success 'apply stashed changes (including index)' '
 test_expect_success 'unstashing in a subdirectory' '
 	git reset --hard HEAD &&
 	mkdir subdir &&
-	(cd subdir &&
-	git stash apply
+	(
+		cd subdir &&
+		git stash apply
 	)
 '
 
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 737c3d9..995bdfa 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -85,9 +85,10 @@ EOF
 "
 
 commit_file sm1 &&
-head3=$(cd sm1 &&
-git reset --hard HEAD~2 >/dev/null &&
-git rev-parse --verify HEAD | cut -c1-7
+head3=$(
+	cd sm1 &&
+	git reset --hard HEAD~2 >/dev/null &&
+	git rev-parse --verify HEAD | cut -c1-7
 )
 
 test_expect_success 'modified submodule(backward)' "
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 34d59d5..7d1c866 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -21,26 +21,29 @@ test_expect_success setup '
 
 test_expect_success "clone and setup child repos" '
 	git clone . one &&
-	(cd one &&
-	echo >file updated by one &&
-	git commit -a -m "updated by one"
+	(
+		cd one &&
+		echo >file updated by one &&
+		git commit -a -m "updated by one"
 	) &&
 	git clone . two &&
-	(cd two &&
-	git config branch.master.remote one &&
-	git config remote.one.url ../one/.git/ &&
-	git config remote.one.fetch refs/heads/master:refs/heads/one
+	(
+		cd two &&
+		git config branch.master.remote one &&
+		git config remote.one.url ../one/.git/ &&
+		git config remote.one.fetch refs/heads/master:refs/heads/one
 	) &&
 	git clone . three &&
-	(cd three &&
-	git config branch.master.remote two &&
-	git config branch.master.merge refs/heads/one &&
-	mkdir -p .git/remotes &&
-	{
-		echo "URL: ../two/.git/"
-		echo "Pull: refs/heads/master:refs/heads/two"
-		echo "Pull: refs/heads/one:refs/heads/one"
-	} >.git/remotes/two
+	(
+		cd three &&
+		git config branch.master.remote two &&
+		git config branch.master.merge refs/heads/one &&
+		mkdir -p .git/remotes &&
+		{
+			echo "URL: ../two/.git/"
+			echo "Pull: refs/heads/master:refs/heads/two"
+			echo "Pull: refs/heads/one:refs/heads/one"
+		} >.git/remotes/two
 	) &&
 	git clone . bundle &&
 	git clone . seven
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 01dfa51..f5c3d7f 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -104,16 +104,17 @@ test_expect_success '"git fsck" works' '
 test_expect_success 'repack, clone and fetch work' '
      git repack -a -d &&
      git clone --no-hardlinks . clone_dir &&
-     (cd clone_dir &&
-     git show HEAD~5 | grep "A U Thor" &&
-     git show $HASH2 | grep "A U Thor" &&
-     git cat-file commit $R &&
-     git repack -a -d &&
-     test_must_fail git cat-file commit $R &&
-     git fetch ../ "refs/replace/*:refs/replace/*" &&
-     git show HEAD~5 | grep "O Thor" &&
-     git show $HASH2 | grep "O Thor" &&
-     git cat-file commit $R
+     (
+	  cd clone_dir &&
+	  git show HEAD~5 | grep "A U Thor" &&
+	  git show $HASH2 | grep "A U Thor" &&
+	  git cat-file commit $R &&
+	  git repack -a -d &&
+	  test_must_fail git cat-file commit $R &&
+	  git fetch ../ "refs/replace/*:refs/replace/*" &&
+	  git show HEAD~5 | grep "O Thor" &&
+	  git show $HASH2 | grep "O Thor" &&
+	  git cat-file commit $R
      )
 '
 
@@ -177,9 +178,10 @@ test_expect_success 'create parallel branch without the bug' '
 
 test_expect_success 'push to cloned repo' '
      git push cloned $HASH6^:refs/heads/parallel &&
-     (cd clone_dir &&
-     git checkout parallel &&
-     git log --pretty=oneline | grep $PARA2
+     (
+	  cd clone_dir &&
+	  git checkout parallel &&
+	  git log --pretty=oneline | grep $PARA2
      )
 '
 
@@ -191,19 +193,21 @@ test_expect_success 'push branch with replacement' '
      git show $HASH6~2 | grep "O Thor" &&
      git show $PARA3 | grep "O Thor" &&
      git push cloned $HASH6^:refs/heads/parallel2 &&
-     (cd clone_dir &&
-     git checkout parallel2 &&
-     git log --pretty=oneline | grep $PARA3 &&
-     git show $PARA3 | grep "A U Thor"
+     (
+	  cd clone_dir &&
+	  git checkout parallel2 &&
+	  git log --pretty=oneline | grep $PARA3 &&
+	  git show $PARA3 | grep "A U Thor"
      )
 '
 
 test_expect_success 'fetch branch with replacement' '
      git branch tofetch $HASH6 &&
-     (cd clone_dir &&
-     git fetch origin refs/heads/tofetch:refs/heads/parallel3
-     git log --pretty=oneline parallel3 | grep $PARA3
-     git show $PARA3 | grep "A U Thor"
+     (
+	  cd clone_dir &&
+	  git fetch origin refs/heads/tofetch:refs/heads/parallel3
+	  git log --pretty=oneline parallel3 | grep $PARA3
+	  git show $PARA3 | grep "A U Thor"
      )
 '
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 21b0839..782b0a3 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -413,11 +413,12 @@ test_expect_success 'submodule <invalid-path> warns' '
 
 test_expect_success 'add submodules without specifying an explicit path' '
 	mkdir repo &&
-	(cd repo &&
-	git init &&
-	echo r >r &&
-	git add r &&
-	git commit -m "repo commit 1"
+	(
+		cd repo &&
+		git init &&
+		echo r >r &&
+		git add r &&
+		git commit -m "repo commit 1"
 	) &&
 	git clone --bare repo/ bare.git &&
 	cd addtest &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index b5ad45f..2945844 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -66,9 +66,10 @@ EOF
 "
 
 commit_file sm1 &&
-head3=$(cd sm1 &&
-git reset --hard HEAD~2 >/dev/null &&
-git rev-parse --verify HEAD | cut -c1-7
+head3=$(
+	cd sm1 &&
+	git reset --hard HEAD~2 >/dev/null &&
+	git rev-parse --verify HEAD | cut -c1-7
 )
 
 test_expect_success 'modified submodule(backward)' "
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 75388f3..a1e1d27 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -22,16 +22,17 @@ esac
 test_expect_success \
     'initialize git svn' '
 	mkdir import &&
-	(cd import &&
-	echo foo > foo &&
-	ln -s foo foo.link
-	mkdir -p dir/a/b/c/d/e &&
-	echo "deep dir" > dir/a/b/c/d/e/file &&
-	mkdir bar &&
-	echo "zzz" > bar/zzz &&
-	echo "#!/bin/sh" > exec.sh &&
-	chmod +x exec.sh &&
-	svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
+	(
+		cd import &&
+		echo foo >foo &&
+		ln -s foo foo.link
+		mkdir -p dir/a/b/c/d/e &&
+		echo "deep dir" >dir/a/b/c/d/e/file &&
+		mkdir bar &&
+		echo "zzz" >bar/zzz &&
+		echo "#!/bin/sh" >exec.sh &&
+		chmod +x exec.sh &&
+		svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
 	) &&
 	rm -rf import &&
 	git svn init "$svnrepo"'
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index f53a1a9..8869f50 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -53,8 +53,9 @@ cd ..
 
 rm -rf import
 test_expect_success 'checkout working copy from svn' 'svn co "$svnrepo" test_wc'
-test_expect_success 'setup some commits to svn' \
-	'(cd test_wc &&
+test_expect_success 'setup some commits to svn' '
+	(
+		cd test_wc &&
 		echo Greetings >> kw.c &&
 		poke kw.c &&
 		svn_cmd commit -m "Not yet an Id" &&
@@ -64,7 +65,8 @@ test_expect_success 'setup some commits to svn' \
 		svn_cmd propset svn:keywords Id kw.c &&
 		poke kw.c &&
 		svn_cmd commit -m "Propset Id"
-	)'
+	)
+'
 
 test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git svn fetch'
@@ -81,13 +83,15 @@ expect='/* $Id$ */'
 got="`sed -ne 2p kw.c`"
 test_expect_success 'raw $Id$ found in kw.c' "test '$expect' = '$got'"
 
-test_expect_success "propset CR on crlf files" \
-	'(cd test_wc &&
+test_expect_success "propset CR on crlf files" '
+	(
+		cd test_wc &&
 		svn_cmd propset svn:eol-style CR empty &&
 		svn_cmd propset svn:eol-style CR crlf &&
 		svn_cmd propset svn:eol-style CR ne_crlf &&
 		svn_cmd commit -m "propset CR on crlf files"
-	 )'
+	 )
+'
 
 test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
 	'git svn fetch &&
@@ -137,19 +141,20 @@ cat > show-ignore.expect <<\EOF
 EOF
 
 test_expect_success 'test show-ignore' "
-	(cd test_wc &&
-	mkdir -p deeply/nested/directory &&
-	touch deeply/nested/directory/.keep &&
-	svn_cmd add deeply &&
-	svn_cmd up &&
-	svn_cmd propset -R svn:ignore '
+	(
+		cd test_wc &&
+		mkdir -p deeply/nested/directory &&
+		touch deeply/nested/directory/.keep &&
+		svn_cmd add deeply &&
+		svn_cmd up &&
+		svn_cmd propset -R svn:ignore '
 no-such-file*
 ' .
-	svn_cmd commit -m 'propset svn:ignore'
+		svn_cmd commit -m 'propset svn:ignore'
 	) &&
 	git svn show-ignore > show-ignore.got &&
 	cmp show-ignore.expect show-ignore.got
-	"
+"
 
 cat >create-ignore.expect <<\EOF
 /no-such-file*
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index d60a8ef..eb70f48 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -4,12 +4,13 @@ test_description='git svn rmdir'
 
 test_expect_success 'initialize repo' '
 	mkdir import &&
-	(cd import &&
-	mkdir -p deeply/nested/directory/number/1 &&
-	mkdir -p deeply/nested/directory/number/2 &&
-	echo foo > deeply/nested/directory/number/1/file &&
-	echo foo > deeply/nested/directory/number/2/another &&
-	svn_cmd import -m "import for git svn" . "$svnrepo"
+	(
+		cd import &&
+		mkdir -p deeply/nested/directory/number/1 &&
+		mkdir -p deeply/nested/directory/number/2 &&
+		echo foo >deeply/nested/directory/number/1/file &&
+		echo foo >deeply/nested/directory/number/2/another &&
+		svn_cmd import -m "import for git svn" . "$svnrepo"
 	)
 	'
 
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index d2f0e92..1e5217a 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -8,21 +8,23 @@ test_description='git svn fetching'
 
 test_expect_success 'initialize repo' '
 	mkdir import &&
-	(cd import &&
-	mkdir -p trunk &&
-	echo hello > trunk/readme &&
-	svn_cmd import -m "initial" . "$svnrepo"
+	(
+		cd import &&
+		mkdir -p trunk &&
+		echo hello >trunk/readme &&
+		svn_cmd import -m "initial" . "$svnrepo"
 	) &&
 	svn_cmd co "$svnrepo" wc &&
-	(cd wc &&
-	echo world >> trunk/readme &&
-	poke trunk/readme &&
-	svn_cmd commit -m "another commit" &&
-	svn_cmd up &&
-	svn_cmd mv trunk thunk &&
-	echo goodbye >> thunk/readme &&
-	poke thunk/readme &&
-	svn_cmd commit -m "bye now"
+	(
+		cd wc &&
+		echo world >>trunk/readme &&
+		poke trunk/readme &&
+		svn_cmd commit -m "another commit" &&
+		svn_cmd up &&
+		svn_cmd mv trunk thunk &&
+		echo goodbye >>thunk/readme &&
+		poke thunk/readme &&
+		svn_cmd commit -m "bye now"
 	)
 	'
 
@@ -85,11 +87,12 @@ test_expect_success 'follow larger parent' '
 test_expect_success 'follow higher-level parent' '
         svn mkdir -m "follow higher-level parent" "$svnrepo"/blob &&
         svn co "$svnrepo"/blob blob &&
-        (cd blob &&
+        (
+                cd blob &&
                 echo hi > hi &&
                 svn add hi &&
                 svn commit -m "hihi"
-                ) &&
+        ) &&
         svn mkdir -m "new glob at top level" "$svnrepo"/glob &&
         svn mv -m "move blob down a level" "$svnrepo"/blob "$svnrepo"/glob/blob &&
         git svn init --minimize-url -i blob "$svnrepo"/glob/blob &&
@@ -117,17 +120,22 @@ test_expect_success 'follow-parent avoids deleting relevant info' '
 	   import/trunk/subversion/bindings/swig/perl/t/larger-parent &&
 	  echo "bad delete test 2" > \
 	   import/trunk/subversion/bindings/swig/perl/another-larger &&
-	(cd import &&
-	  svn import -m "r9270 test" . "$svnrepo"/r9270
+	(
+		cd import &&
+		svn import -m "r9270 test" . "$svnrepo"/r9270
 	) &&
 	svn_cmd co "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl r9270 &&
-	(cd r9270 &&
-	  svn mkdir native &&
-	  svn mv t native/t &&
-	  for i in a b c; do svn mv $i.pm native/$i.pm; done &&
-	  echo z >> native/t/c.t &&
-	  poke native/t/c.t &&
-	  svn commit -m "reorg test"
+	(
+		cd r9270 &&
+		svn mkdir native &&
+		svn mv t native/t &&
+		for i in a b c
+		do
+			svn mv $i.pm native/$i.pm
+		done &&
+		echo z >>native/t/c.t &&
+		poke native/t/c.t &&
+		svn commit -m "reorg test"
 	) &&
 	git svn init --minimize-url -i r9270-t \
 	  "$svnrepo"/r9270/trunk/subversion/bindings/swig/perl/native/t &&
diff --git a/t/t9105-git-svn-commit-diff.sh b/t/t9105-git-svn-commit-diff.sh
index d432d83..5d0afea 100755
--- a/t/t9105-git-svn-commit-diff.sh
+++ b/t/t9105-git-svn-commit-diff.sh
@@ -6,9 +6,10 @@ test_description='git svn commit-diff'
 
 test_expect_success 'initialize repo' '
 	mkdir import &&
-	(cd import &&
-	echo hello > readme &&
-	svn_cmd import -m "initial" . "$svnrepo"
+	(
+		cd import &&
+		echo hello >readme &&
+		svn_cmd import -m "initial" . "$svnrepo"
 	) &&
 	echo hello > readme &&
 	git update-index --add readme &&
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index af367a1..f6d7ac7 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -6,9 +6,10 @@ test_description='git svn commit-diff clobber'
 
 test_expect_success 'initialize repo' '
 	mkdir import &&
-	(cd import &&
-	echo initial > file &&
-	svn_cmd import -m "initial" . "$svnrepo"
+	(
+		cd import &&
+		echo initial >file &&
+		svn_cmd import -m "initial" . "$svnrepo"
 	) &&
 	echo initial > file &&
 	git update-index --add file &&
@@ -16,10 +17,11 @@ test_expect_success 'initialize repo' '
 	'
 test_expect_success 'commit change from svn side' '
 	svn_cmd co "$svnrepo" t.svn &&
-	(cd t.svn &&
-	echo second line from svn >> file &&
-	poke file &&
-	svn_cmd commit -m "second line from svn"
+	(
+		cd t.svn &&
+		echo second line from svn >>file &&
+		poke file &&
+		svn_cmd commit -m "second line from svn"
 	) &&
 	rm -rf t.svn
 	'
@@ -44,10 +46,11 @@ test_expect_success 'dcommit fails to commit because of conflict' '
 	git svn fetch &&
 	git reset --hard refs/${remotes_git_svn} &&
 	svn_cmd co "$svnrepo" t.svn &&
-	(cd t.svn &&
-	echo fourth line from svn >> file &&
-	poke file &&
-	svn_cmd commit -m "fourth line from svn"
+	(
+		cd t.svn &&
+		echo fourth line from svn >>file &&
+		poke file &&
+		svn_cmd commit -m "fourth line from svn"
 	) &&
 	rm -rf t.svn &&
 	echo "fourth line from git" >> file &&
@@ -68,8 +71,9 @@ test_expect_success 'dcommit does the svn equivalent of an index merge' "
 
 test_expect_success 'commit another change from svn side' '
 	svn_cmd co "$svnrepo" t.svn &&
-	(cd t.svn &&
-		echo third line from svn >> file &&
+	(
+		cd t.svn &&
+		echo third line from svn >>file &&
 		poke file &&
 		svn_cmd commit -m "third line from svn"
 	) &&
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index f60b306..289fc31 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -6,14 +6,16 @@ test_description='git svn metadata migrations from previous versions'
 test_expect_success 'setup old-looking metadata' '
 	cp "$GIT_DIR"/config "$GIT_DIR"/config-old-git-svn &&
 	mkdir import &&
-	(cd import &&
-		for i in trunk branches/a branches/b \
-		         tags/0.1 tags/0.2 tags/0.3; do
-			mkdir -p $i && \
-			echo hello >> $i/README || exit 1
-		done && \
+	(
+		cd import &&
+		for i in trunk branches/a branches/b tags/0.1 tags/0.2 tags/0.3
+		do
+			mkdir -p $i &&
+			echo hello >>$i/README ||
+			exit 1
+		done &&
 		svn_cmd import -m test . "$svnrepo"
-		) &&
+	) &&
 	git svn init "$svnrepo" &&
 	git svn fetch &&
 	rm -rf "$GIT_DIR"/svn &&
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index a7d0c7d..3077851 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -37,11 +37,12 @@ EOF
 test_expect_success 'setup svn repository' '
 	svn_cmd co "$svnrepo" mysvnwork &&
 	mkdir -p mysvnwork/trunk &&
-	(cd mysvnwork &&
-		big_text_block >> trunk/README &&
+	(
+		cd mysvnwork &&
+		big_text_block >>trunk/README &&
 		svn_cmd add trunk &&
 		svn_cmd ci -m "first commit" trunk
-		)
+	)
 	'
 
 test_expect_success 'setup git mirror and merge' '
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 9fdbc9b..6a48e40 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -61,11 +61,12 @@ test_expect_success 'add a file with plus signs' '
 
 test_expect_success 'clone the repository to test rebase' '
 	git svn clone "$svnrepo" test-rebase &&
-	(cd test-rebase &&
-		echo test-rebase > test-rebase &&
+	(
+		cd test-rebase &&
+		echo test-rebase >test-rebase &&
 		git add test-rebase &&
 		git commit -m test-rebase
-		)
+	)
 	'
 
 test_expect_success 'make a commit to test rebase' '
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 244b5cd..5d477e4 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -8,14 +8,16 @@ test_description='git svn log tests'
 
 test_expect_success 'setup repository and import' '
 	mkdir import &&
-	(cd import &&
-		for i in trunk branches/a branches/b \
-		         tags/0.1 tags/0.2 tags/0.3; do
-			mkdir -p $i && \
-			echo hello >> $i/README || exit 1
-		done && \
+	(
+		cd import &&
+		for i in trunk branches/a branches/b tags/0.1 tags/0.2 tags/0.3
+		do
+			mkdir -p $i &&
+			echo hello >>$i/README ||
+			exit 1
+		done &&
 		svn_cmd import -m test . "$svnrepo"
-		) &&
+	) &&
 	git svn init "$svnrepo" -T trunk -b branches -t tags &&
 	git svn fetch &&
 	git reset --hard trunk &&
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index e3f08c4..f3f397c 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -39,9 +39,10 @@ quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"
 
 test_expect_success 'setup repository and import' '
 	mkdir info &&
-	(cd info &&
-		echo FIRST > A &&
-		echo one > file &&
+	(
+		cd info &&
+		echo FIRST >A &&
+		echo one >file &&
 		ln -s file symlink-file &&
 		mkdir directory &&
 		touch directory/.placeholder &&
@@ -49,14 +50,16 @@ test_expect_success 'setup repository and import' '
 		svn_cmd import -m "initial" . "$svnrepo"
 	) &&
 	svn_cmd co "$svnrepo" svnwc &&
-	(cd svnwc &&
-		echo foo > foo &&
+	(
+		cd svnwc &&
+		echo foo >foo &&
 		svn_cmd add foo &&
 		svn_cmd commit -m "change outside directory" &&
 		svn_cmd update
 	) &&
 	mkdir gitwc &&
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		git svn init "$svnrepo" &&
 		git svn fetch
 	) &&
@@ -138,12 +141,14 @@ test_expect_success 'info --url symlink-directory' '
 
 test_expect_success 'info added-file' "
 	echo two > gitwc/added-file &&
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		git add added-file
 	) &&
 	cp gitwc/added-file svnwc/added-file &&
 	ptouch gitwc/added-file svnwc/added-file &&
-	(cd svnwc &&
+	(
+		cd svnwc &&
 		svn_cmd add added-file > /dev/null
 	) &&
 	(cd svnwc; svn info added-file) > expected.info-added-file &&
@@ -160,10 +165,12 @@ test_expect_success 'info added-directory' "
 	mkdir gitwc/added-directory svnwc/added-directory &&
 	ptouch gitwc/added-directory svnwc/added-directory &&
 	touch gitwc/added-directory/.placeholder &&
-	(cd svnwc &&
+	(
+		cd svnwc &&
 		svn_cmd add added-directory > /dev/null
 	) &&
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		git add added-directory
 	) &&
 	(cd svnwc; svn info added-directory) \
@@ -179,11 +186,13 @@ test_expect_success 'info --url added-directory' '
 	'
 
 test_expect_success 'info added-symlink-file' "
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		ln -s added-file added-symlink-file &&
 		git add added-symlink-file
 	) &&
-	(cd svnwc &&
+	(
+		cd svnwc &&
 		ln -s added-file added-symlink-file &&
 		svn_cmd add added-symlink-file > /dev/null
 	) &&
@@ -202,11 +211,13 @@ test_expect_success 'info --url added-symlink-file' '
 	'
 
 test_expect_success 'info added-symlink-directory' "
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		ln -s added-directory added-symlink-directory &&
 		git add added-symlink-directory
 	) &&
-	(cd svnwc &&
+	(
+		cd svnwc &&
 		ln -s added-directory added-symlink-directory &&
 		svn_cmd add added-symlink-directory > /dev/null
 	) &&
@@ -230,10 +241,12 @@ test_expect_success 'info --url added-symlink-directory' '
 # simply reuses the Last Changed Date.
 
 test_expect_success 'info deleted-file' "
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		git rm -f file > /dev/null
 	) &&
-	(cd svnwc &&
+	(
+		cd svnwc &&
 		svn_cmd rm --force file > /dev/null
 	) &&
 	(cd svnwc; svn info file) |
@@ -251,10 +264,12 @@ test_expect_success 'info --url file (deleted)' '
 	'
 
 test_expect_success 'info deleted-directory' "
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		git rm -r -f directory > /dev/null
 	) &&
-	(cd svnwc &&
+	(
+		cd svnwc &&
 		svn_cmd rm --force directory > /dev/null
 	) &&
 	(cd svnwc; svn info directory) |
@@ -272,10 +287,12 @@ test_expect_success 'info --url directory (deleted)' '
 	'
 
 test_expect_success 'info deleted-symlink-file' "
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		git rm -f symlink-file > /dev/null
 	) &&
-	(cd svnwc &&
+	(
+		cd svnwc &&
 		svn_cmd rm --force symlink-file > /dev/null
 	) &&
 	(cd svnwc; svn info symlink-file) |
@@ -294,10 +311,12 @@ test_expect_success 'info --url symlink-file (deleted)' '
 	'
 
 test_expect_success 'info deleted-symlink-directory' "
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		git rm -f symlink-directory > /dev/null
 	) &&
-	(cd svnwc &&
+	(
+		cd svnwc &&
 		svn_cmd rm --force symlink-directory > /dev/null
 	) &&
 	(cd svnwc; svn info symlink-directory) |
@@ -346,7 +365,8 @@ test_expect_success 'info --url unknown-directory' '
 	'
 
 test_expect_success 'info unknown-symlink-file' "
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		ln -s unknown-file unknown-symlink-file
 	) &&
 	(cd gitwc; test_must_fail git svn info unknown-symlink-file) \
@@ -361,7 +381,8 @@ test_expect_success 'info --url unknown-symlink-file' '
 	'
 
 test_expect_success 'info unknown-symlink-directory' "
-	(cd gitwc &&
+	(
+		cd gitwc &&
 		ln -s unknown-directory unknown-symlink-directory
 	) &&
 	(cd gitwc; test_must_fail git svn info unknown-symlink-directory) \
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
index cddb9d4..1d92c05 100755
--- a/t/t9120-git-svn-clone-with-percent-escapes.sh
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -20,7 +20,8 @@ test_expect_success 'setup svnrepo' '
 
 test_expect_success 'test clone with percent escapes' '
 	git svn clone "$svnrepo/pr%20ject" clone &&
-	(cd clone &&
+	(
+		cd clone &&
 		git rev-parse refs/${remotes_git_svn}
 	)
 '
-- 
1.7.2.3
