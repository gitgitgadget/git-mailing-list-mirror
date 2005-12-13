From: freku045@student.liu.se
Subject: [PATCH 1/11] Trivial usage string clean-up
Date: Tue, 13 Dec 2005 23:30:31 +0100
Message-ID: <11345130313731-git-send-email-freku045@student.liu.se>
References: <11345130302438-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Dec 13 23:32:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIfV-0006Sp-Vz
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVLMWam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVLMWal
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:30:41 -0500
Received: from [85.8.31.11] ([85.8.31.11]:48594 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030290AbVLMWai (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:30:38 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 5528A40FF; Tue, 13 Dec 2005 23:40:59 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1EmIfH-0001yr-00; Tue, 13 Dec 2005 23:30:31 +0100
In-Reply-To: <11345130302438-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13598>



Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

This patch contains all 'trivial' changes in this series. In
particular, there are no argument parsing changes here.

 git-add.sh           |   13 +++----------
 git-applymbox.sh     |    6 +-----
 git-checkout.sh      |    6 ++----
 git-clone.sh         |    2 +-
 git-commit.sh        |    5 +----
 git-format-patch.sh  |   25 ++++++++-----------------
 git-grep.sh          |    7 +++++--
 git-merge.sh         |    6 ++----
 git-pull.sh          |   13 ++-----------
 git-push.sh          |    7 ++-----
 git-request-pull.sh  |   12 +++++-------
 git-reset.sh         |    6 ++----
 git-resolve.sh       |    6 ++----
 git-tag.sh           |   14 +++-----------
 14 files changed, 39 insertions(+), 89 deletions(-)

50fb9150eb63cd5a4aebeae401f771bd8d1827aa
diff --git a/git-add.sh b/git-add.sh
index fdec86d..f719b4b 100755
--- a/git-add.sh
+++ b/git-add.sh
@@ -1,13 +1,8 @@
 #!/bin/sh
 
-die () {
-    echo >&2 "$*"
-    exit 1
-}
-
-usage() {
-    die "usage: git add [-n] [-v] <file>..."
-}
+USAGE='[-n] [-v] <file>...'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
 
 show_only=
 verbose=
@@ -29,8 +24,6 @@ while : ; do
   shift
 done
 
-GIT_DIR=$(git-rev-parse --git-dir) || exit
-
 if test -f "$GIT_DIR/info/exclude"
 then
 	git-ls-files -z \
diff --git a/git-applymbox.sh b/git-applymbox.sh
index c686cc8..61c8c02 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -18,13 +18,9 @@
 ##
 ## git-am is supposed to be the newer and better tool for this job.
 
+USAGE='[-u] [-k] [-q] [-m] (-c .dotest/<num> | mbox) [signoff]'
 . git-sh-setup
 
-usage () {
-    echo >&2 "applymbox [-u] [-k] [-q] [-m] (-c .dotest/<num> | mbox) [signoff]"
-    exit 1
-}
-
 keep_subject= query_apply= continue= utf8= resume=t
 while case "$#" in 0) break ;; esac
 do
diff --git a/git-checkout.sh b/git-checkout.sh
index 4cf30e2..f241d4b 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,9 +1,7 @@
 #!/bin/sh
-. git-sh-setup
 
-usage () {
-    die "usage: git checkout [-f] [-b <new_branch>] [<branch>] [<paths>...]"
-}
+USAGE='[-f] [-b <new_branch>] [<branch>] [<paths>...]'
+. git-sh-setup
 
 old=$(git-rev-parse HEAD)
 new=
diff --git a/git-clone.sh b/git-clone.sh
index 699205e..4a7aeef 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@
 unset CDPATH
 
 usage() {
-	echo >&2 "* git clone [-l [-s]] [-q] [-u <upload-pack>] [-n] <repo> [<dir>]"
+	echo >&2 "Usage: $0 [-l [-s]] [-q] [-u <upload-pack>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
diff --git a/git-commit.sh b/git-commit.sh
index 3d250ec..7e39c10 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,12 +3,9 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
+USAGE='[-a] [-s] [-v | --no-verify]  [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [<path>...]'
 . git-sh-setup
 
-usage () {
-	die 'git commit [-a] [-s] [-v | --no-verify]  [-m <message> | -F <logfile> | (-C|-c) <commit>] [-e] [<path>...]'
-}
-
 all= logfile= use_commit= no_edit= log_given= log_message= verify=t signoff=
 while case "$#" in 0) break;; esac
 do
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 921feee..01508e3 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -3,19 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-. git-sh-setup
-
-# Force diff to run in C locale.
-LANG=C LC_ALL=C
-export LANG LC_ALL
-
-usage () {
-    echo >&2 "usage: $0"' [-n] [-o dir | --stdout] [--keep-subject] [--mbox]
-    [--check] [--signoff] [-<diff options>...]
-    [--help]
-    ( from..to ... | upstream [ our-head ] )
-
-Prepare each commit with its patch since our-head forked from upstream,
+USAGE='[-n | -k] [-o <dir> | --stdout] [--signoff] [--check] [--mbox] [--diff-options] <upstream> [<our-head>]'
+LONG_USAGE='Prepare each commit with its patch since our-head forked from upstream,
 one file per patch, for e-mail submission.  Each output file is
 numbered sequentially from 1, and uses the first line of the commit
 message (massaged for pathname safety) as the filename.
@@ -28,10 +17,12 @@ as "[PATCH N/M] Subject", unless you hav
 
 When --mbox is specified, the output is formatted to resemble
 UNIX mailbox format, and can be concatenated together for processing
-with applymbox.
-'
-    exit 1
-}
+with applymbox.'
+. git-sh-setup
+
+# Force diff to run in C locale.
+LANG=C LC_ALL=C
+export LANG LC_ALL
 
 diff_opts=
 LF='
diff --git a/git-grep.sh b/git-grep.sh
index 44c1613..2ed8e95 100755
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -3,6 +3,10 @@
 # Copyright (c) Linus Torvalds, 2005
 #
 
+USAGE='<option>... <pattern> <path>...'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
 pattern=
 flags=()
 git_flags=()
@@ -40,8 +44,7 @@ while : ; do
 	shift
 done
 [ "$pattern" ] || {
-	echo >&2 "usage: 'git grep <pattern> [pathspec*]'"
-	exit 1
+	usage
 }
 git-ls-files -z "${git_flags[@]}" "$@" |
 	xargs -0 grep "${flags[@]}" -e "$pattern"
diff --git a/git-merge.sh b/git-merge.sh
index a221daa..bed1ffd 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -3,15 +3,13 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+
+USAGE='[-n] [--no-commit] [-s <strategy>]... <merge-message> <head> <remote>+'
 . git-sh-setup
 
 LF='
 '
 
-usage () {
-    die "git-merge [-n] [--no-commit] [-s <strategy>]... <merge-message> <head> <remote>+"
-}
-
 all_strategies='recursive octopus resolve stupid ours'
 default_strategies='recursive'
 use_strategies=
diff --git a/git-pull.sh b/git-pull.sh
index 3a13984..0991d5f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,19 +4,10 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEAD.
 
+USAGE='[-n | --no-summary] [--no-commit] [-s strategy]... [<fetch-options>] <repo> <head>...'
+LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 . git-sh-setup
 
-usage () {
-    echo >&2 "usage: $0"' [-n] [--no-commit] [--no-summary] [--help]
-    [-s strategy]...
-    [<fetch-options>]
-    <repo> <head>...
-
-Fetch one or more remote refs and merge it/them into the current HEAD.
-'
-    exit 1
-}
-
 strategy_args= no_summary= no_commit=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
 do
diff --git a/git-push.sh b/git-push.sh
index 140c8f8..1c5cf80 100755
--- a/git-push.sh
+++ b/git-push.sh
@@ -1,10 +1,7 @@
 #!/bin/sh
-. git-sh-setup
-
-usage () {
-    die "Usage: git push [--all] [--force] <repository> [<refspec>]"
-}
 
+USAGE='[--all] [--force] <repository> [<refspec>...]'
+. git-sh-setup
 
 # Parse out parameters and then stop at remote, so that we can
 # translate it using .git/branches information
diff --git a/git-request-pull.sh b/git-request-pull.sh
index ae6cd27..2c48bfb 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -4,13 +4,11 @@
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Linus Torvalds.
 
-usage()
-{
-	echo "$0 <commit> <url> [ <head> ]"
-	echo "  Summarizes the changes since <commit> to the standard output,"
-	echo "  and includes <url> in the message generated."
-	exit 1
-}
+USAGE='<commit> <url> [<head>]'
+LONG_USAGE='Summarizes the changes since <commit> to the standard output,
+and includes <url> in the message generated.'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
 
 revision=$1
 url=$2
diff --git a/git-reset.sh b/git-reset.sh
index 72ef303..eb44ee8 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -1,9 +1,7 @@
 #!/bin/sh
-. git-sh-setup
 
-usage () {
-	die 'Usage: git reset [--mixed | --soft | --hard]  [<commit-ish>]'
-}
+USAGE='[--mixed | --soft | --hard]  [<commit-ish>]'
+. git-sh-setup
 
 tmp=/var/tmp/reset.$$
 trap 'rm -f $tmp-*' 0 1 2 3 15
diff --git a/git-resolve.sh b/git-resolve.sh
index fcc5ad7..9263070 100755
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -4,11 +4,9 @@
 #
 # Resolve two trees.
 #
-. git-sh-setup
 
-usage () {
-	die "git-resolve <head> <remote> <merge-message>"
-}
+USAGE='<head> <remote> <merge-message>'
+. git-sh-setup
 
 dropheads() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" \
diff --git a/git-tag.sh b/git-tag.sh
index 2435a75..6d0c973 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -1,17 +1,9 @@
 #!/bin/sh
 # Copyright (c) 2005 Linus Torvalds
 
-GIT_DIR=`git-rev-parse --git-dir` || exit $?
-
-usage () {
-    echo >&2 "Usage: git-tag [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <tagname> [<head>]"
-    exit 1
-}
-
-die () {
-    echo >&2 "$*"
-    exit 1
-}
+USAGE='[-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <tagname> [<head>]'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
 
 annotate=
 signed=
-- 
0.99.9.GIT
