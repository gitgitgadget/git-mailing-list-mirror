X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [RFC/PATCH 2/2] git-svn: rename 'commit' command to 'set-tree'
Date: Fri, 15 Dec 2006 23:58:08 -0800
Message-ID: <11662558902535-git-send-email-normalperson@yhbt.net>
References: <m28xh8amxa.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 16 Dec 2006 07:58:25 +0000 (UTC)
Cc: seth@hand.yhbt.net, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
X-Mailer: git-send-email 1.4.4.2.g0817
In-Reply-To: <m28xh8amxa.fsf@ziti.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34592>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvUQz-0003vU-Vz for gcvg-git@gmane.org; Sat, 16 Dec
 2006 08:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030710AbWLPH6O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 02:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030711AbWLPH6O
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 02:58:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58677 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1030710AbWLPH6M
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 02:58:12 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 7FAAE7DC031; Fri, 15 Dec 2006 23:58:10 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 15 Dec 2006
 23:58:10 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

'set-tree' probably accurately describes what the command
formerly known as 'commit' does.

I'm not entirely sure that 'dcommit' should be renamed to 'commit'
just yet...  Perhaps 'push' or 'push-changes'?

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt     |   20 ++++++++++----------
 git-svn.perl                  |   12 ++++++------
 t/t9100-git-svn-basic.sh      |   22 +++++++++++-----------
 t/t9101-git-svn-props.sh      |    2 +-
 t/t9102-git-svn-deep-rmdir.sh |    2 +-
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c589a98..f5f57e8 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -64,7 +64,7 @@ manually joining branches on commit.
 	against the latest changes in the SVN repository.
 	An optional command-line argument may be specified as an
 	alternative to HEAD.
-	This is advantageous over 'commit' (below) because it produces
+	This is advantageous over 'set-tree' (below) because it produces
 	cleaner, more linear history.
=20
 'log'::
@@ -89,7 +89,7 @@ manually joining branches on commit.
=20
 	Any other arguments are passed directly to `git log'
=20
-'commit'::
+'set-tree'::
 	You should consider using 'dcommit' instead of this command.
 	Commit specified commit or tree objects to SVN.  This relies on
 	your imported fetch data being up-to-date.  This makes
@@ -172,7 +172,7 @@ This can allow you to make partial mirrors when run=
ning fetch.
 -::
 --stdin::
=20
-Only used with the 'commit' command.
+Only used with the 'set-tree' command.
=20
 Read a list of commits from stdin and commit them in reverse
 order.  Only the leading sha1 is read from each line, so
@@ -180,7 +180,7 @@ git-rev-list --pretty=3Doneline output can be used.
=20
 --rmdir::
=20
-Only used with the 'dcommit', 'commit' and 'commit-diff' commands.
+Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
=20
 Remove directories from the SVN tree if there are no files left
 behind.  SVN can version empty directories, and they are not
@@ -193,7 +193,7 @@ repo-config key: svn.rmdir
 -e::
 --edit::
=20
-Only used with the 'dcommit', 'commit' and 'commit-diff' commands.
+Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
=20
 Edit the commit message before committing to SVN.  This is off by
 default for objects that are commits, and forced on when committing
@@ -204,7 +204,7 @@ repo-config key: svn.edit
 -l<num>::
 --find-copies-harder::
=20
-Only used with the 'dcommit', 'commit' and 'commit-diff' commands.
+Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
=20
 They are both passed directly to git-diff-tree see
 gitlink:git-diff-tree[1] for more information.
@@ -276,7 +276,7 @@ ADVANCED OPTIONS
=20
 -b<refname>::
 --branch <refname>::
-Used with 'fetch', 'dcommit' or 'commit'.
+Used with 'fetch', 'dcommit' or 'set-tree'.
=20
 This can be used to join arbitrary git branches to remotes/git-svn
 on new commits where the tree object is equivalent.
@@ -392,11 +392,11 @@ REBASE VS. PULL
 ---------------
=20
 Originally, git-svn recommended that the remotes/git-svn branch be
-pulled from.  This is because the author favored 'git-svn commit B'
-to commit a single head rather than the 'git-svn commit A..B' notation
+pulled from.  This is because the author favored 'git-svn set-tree B'
+to commit a single head rather than the 'git-svn set-tree A..B' notati=
on
 to commit multiple commits.
=20
-If you use 'git-svn commit A..B' to commit several diffs and you do no=
t
+If you use 'git-svn set-tree A..B' to commit several diffs and you do =
not
 have the latest remotes/git-svn merged into my-branch, you should use
 'git rebase' to update your work branch instead of 'git pull'.  'pull'
 can cause non-linear history to be flattened when committing into SVN,
diff --git a/git-svn.perl b/git-svn.perl
index 077e920..07748bc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -107,7 +107,12 @@ my %cmd =3D (
 	init =3D> [ \&init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
 			  \%init_opts ],
-	commit =3D> [ \&commit, "Commit git revisions to SVN",
+	dcommit =3D> [ \&dcommit, 'Commit several diffs to merge with upstrea=
m',
+			{ 'merge|m|M' =3D> \$_merge,
+			  'strategy|s=3Ds' =3D> \$_strategy,
+			  'dry-run|n' =3D> \$_dry_run,
+			%cmt_opts } ],
+	'set-tree' =3D> [ \&commit, "Set an SVN repository to a git tree-ish"=
,
 			{	'stdin|' =3D> \$_stdin, %cmt_opts, %fc_opts, } ],
 	'show-ignore' =3D> [ \&show_ignore, "Show svn:ignore listings",
 			{ 'revision|r=3Di' =3D> \$_revision } ],
@@ -150,11 +155,6 @@ my %cmd =3D (
 			  'file|F=3Ds' =3D> \$_file,
 			  'revision|r=3Ds' =3D> \$_revision,
 			%cmt_opts } ],
-	dcommit =3D> [ \&dcommit, 'Commit several diffs to merge with upstrea=
m',
-			{ 'merge|m|M' =3D> \$_merge,
-			  'strategy|s=3Ds' =3D> \$_strategy,
-			  'dry-run|n' =3D> \$_dry_run,
-			%cmt_opts } ],
 );
=20
 my $cmd;
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 0fc462e..0edf19e 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -56,7 +56,7 @@ git update-index --add --remove dir/a/b/c/d/e/file di=
r/file file
 git commit -m "$name"
=20
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybr=
anch &&
+    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch &&
      svn up $SVN_TREE &&
      test -d $SVN_TREE/dir && test ! -d $SVN_TREE/dir/a"
=20
@@ -70,7 +70,7 @@ git update-index --add dir/file/file
 git commit -m "$name"
=20
 test_expect_failure "$name" \
-    'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybr=
anch' \
+    'git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch' \
     || true
=20
=20
@@ -85,7 +85,7 @@ git update-index --add -- bar
 git commit -m "$name"
=20
 test_expect_failure "$name" \
-    'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybr=
anch2' \
+    'git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch2' \
     || true
=20
=20
@@ -100,7 +100,7 @@ git-update-index --add bar/zzz/yyy
 git commit -m "$name"
=20
 test_expect_failure "$name" \
-    'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybr=
anch3' \
+    'git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch3' \
     || true
=20
=20
@@ -115,7 +115,7 @@ git update-index --add -- dir
 git commit -m "$name"
=20
 test_expect_failure "$name" \
-    'git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybr=
anch4' \
+    'git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch4' \
     || true
=20
=20
@@ -127,7 +127,7 @@ git update-index exec.sh
 git commit -m "$name"
=20
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybr=
anch5 &&
+    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch5 &&
      svn up $SVN_TREE &&
      test ! -x $SVN_TREE/exec.sh"
=20
@@ -138,7 +138,7 @@ git update-index exec.sh
 git commit -m "$name"
=20
 test_expect_success "$name" \
-    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybr=
anch5 &&
+    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..my=
branch5 &&
      svn up $SVN_TREE &&
      test -x $SVN_TREE/exec.sh"
=20
@@ -153,7 +153,7 @@ then
 	git commit -m "$name"
=20
 	test_expect_success "$name" \
-	    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..myb=
ranch5 &&
+	    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..m=
ybranch5 &&
 	     svn up $SVN_TREE &&
 	     test -L $SVN_TREE/exec.sh"
=20
@@ -164,7 +164,7 @@ then
 	git commit -m "$name"
=20
 	test_expect_success "$name" \
-	    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..myb=
ranch5 &&
+	    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..m=
ybranch5 &&
 	     svn up $SVN_TREE &&
 	     test -x $SVN_TREE/bar/zzz &&
 	     test -L $SVN_TREE/exec-2.sh"
@@ -177,7 +177,7 @@ then
 	git commit -m "$name"
=20
 	test_expect_success "$name" \
-	    "git-svn commit --find-copies-harder --rmdir remotes/git-svn..myb=
ranch5 &&
+	    "git-svn set-tree --find-copies-harder --rmdir remotes/git-svn..m=
ybranch5 &&
 	     svn up $SVN_TREE &&
 	     test -f $SVN_TREE/exec-2.sh &&
 	     test ! -L $SVN_TREE/exec-2.sh &&
@@ -192,7 +192,7 @@ then
 	git update-index exec-2.sh
 	git commit -m '=C3=A9=C3=AF=E2=88=8F'
 	export LC_ALL=3D"$GIT_SVN_LC_ALL"
-	test_expect_success "$name" "git-svn commit HEAD"
+	test_expect_success "$name" "git-svn set-tree HEAD"
 	unset LC_ALL
 else
 	echo "UTF-8 locale not set, test skipped ($GIT_SVN_LC_ALL)"
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index a5a235f..5543b07 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -74,7 +74,7 @@ test_expect_success "$name" \
 	'git checkout -b mybranch remotes/git-svn &&
 	echo Hi again >> kw.c &&
 	git commit -a -m "test keywoards ignoring" &&
-	git-svn commit remotes/git-svn..mybranch &&
+	git-svn set-tree remotes/git-svn..mybranch &&
 	git pull . remotes/git-svn'
=20
 expect=3D'/* $Id$ */'
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir=
=2Esh
index d693d18..572aaed 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -21,7 +21,7 @@ test_expect_success 'mirror via git-svn' "
 test_expect_success 'Try a commit on rmdir' "
 	git rm -f deeply/nested/directory/number/2/another &&
 	git commit -a -m 'remove another' &&
-	git-svn commit --rmdir HEAD &&
+	git-svn set-tree --rmdir HEAD &&
 	svn ls -R $svnrepo | grep ^deeply/nested/directory/number/1
 	"
=20
--=20
1.4.4.2.g0817
