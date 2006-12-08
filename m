X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core.  Call
 with explicit path.
Date: Fri, 08 Dec 2006 18:13:50 +0100
Message-ID: <elc6g3$v1m$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 17:14:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 366
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33708>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsjIg-0006Nq-Tj for gcvg-git@gmane.org; Fri, 08 Dec
 2006 18:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426018AbWLHROH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 12:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426034AbWLHROH
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 12:14:07 -0500
Received: from main.gmane.org ([80.91.229.2]:47166 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1426018AbWLHROC
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 12:14:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GsjIM-0000Df-7H for git@vger.kernel.org; Fri, 08 Dec 2006 18:13:58 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 08 Dec 2006 18:13:58 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006 18:13:58
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


git-sh-setup isn't a 'normal' binary, in that it should be called by
bash only and not run in a subshell. Therefore, it should not be installed
in a executable directory, but rather in $prefix/share/git-core/


From 4cefe86667d01ecc912c1f9d8b78c831c33792a1 Mon Sep 17 00:00:00 2001
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Date: Wed, 6 Dec 2006 13:27:16 +0100
Subject: 

Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
---
 Makefile            |   10 ++++++++--
 git-am.sh           |    2 +-
 git-applymbox.sh    |    2 +-
 git-applypatch.sh   |    2 +-
 git-bisect.sh       |    2 +-
 git-checkout.sh     |    2 +-
 git-clean.sh        |    2 +-
 git-commit.sh       |    2 +-
 git-fetch.sh        |    2 +-
 git-instaweb.sh     |    2 +-
 git-lost-found.sh   |    2 +-
 git-merge.sh        |    2 +-
 git-pull.sh         |    2 +-
 git-quiltimport.sh  |    2 +-
 git-rebase.sh       |    2 +-
 git-repack.sh       |    2 +-
 git-request-pull.sh |    2 +-
 git-reset.sh        |    2 +-
 git-resolve.sh      |    2 +-
 git-revert.sh       |    2 +-
 git-tag.sh          |    2 +-
 git-verify-tag.sh   |    2 +-
 22 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index a1861de..cb9b745 100644
--- a/Makefile
+++ b/Makefile
@@ -116,8 +116,10 @@ STRIP ?= strip
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+datadir = $(prefix)/share
+GIT_datadir = $(datadir)/git-core
 gitexecdir = $(bindir)
-template_dir = $(prefix)/share/git-core/templates/
+template_dir = $(GIT_datadir)/templates/
 # DESTDIR=
 
 # default configuration for gitweb
@@ -166,7 +168,7 @@ SCRIPT_SH = \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
-	git-resolve.sh git-revert.sh git-sh-setup.sh \
+	git-resolve.sh git-revert.sh \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
@@ -550,6 +552,7 @@ endif
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
+GIT_datadir_SQ = $(subst ','\'',$(GIT_datadir))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
@@ -604,6 +607,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    -e 's!@@GIT_datadir@@!$(GIT_datadir)!g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    $@.sh >$@+
 	chmod +x $@+
@@ -816,6 +820,8 @@ install: all
 			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
 	fi
 	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(GIT_datadir_SQ)'
+	$(INSTALL) -m755 git-sh-setup.sh '$(DESTDIR_SQ)$(GIT_datadir_SQ)'
 
 install-doc:
 	$(MAKE) -C Documentation install
diff --git a/git-am.sh b/git-am.sh
index afe322b..b9dfcf0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -5,7 +5,7 @@
 USAGE='[--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way]
   [--interactive] [--whitespace=<option>] <mbox>...
   or, when resuming [--skip | --resolved]'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
diff --git a/git-applymbox.sh b/git-applymbox.sh
index 5569fdc..eaab50d 100755
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -19,7 +19,7 @@
 ## git-am is supposed to be the newer and better tool for this job.
 
 USAGE='[-u] [-k] [-q] [-m] (-c .dotest/<num> | mbox) [signoff]'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
diff --git a/git-applypatch.sh b/git-applypatch.sh
index 8df2aee..7ddf5d3 100755
--- a/git-applypatch.sh
+++ b/git-applypatch.sh
@@ -12,7 +12,7 @@
 ##
 
 USAGE='<msg> <patch> <info> [<signoff>]'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 case "$#" in 3|4) ;; *) usage ;; esac
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 6da31e8..6fa92e2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -10,7 +10,7 @@ git bisect visualize            show bisect status in gitk.
 git bisect replay <logfile>	replay bisection log
 git bisect log			show bisect log.'
 
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 sq() {
 	@@PERL@@ -e '
diff --git a/git-checkout.sh b/git-checkout.sh
index 737abd0..beea113 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -2,7 +2,7 @@
 
 USAGE='[-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
 SUBDIRECTORY_OK=Sometimes
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 old_name=HEAD
 old=$(git-rev-parse --verify $old_name 2>/dev/null)
diff --git a/git-clean.sh b/git-clean.sh
index 3834323..7a7ce6e 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -13,7 +13,7 @@ LONG_USAGE='Clean untracked files from the working directory
 When optional <paths>... arguments are given, the paths
 affected are further limited to those that match them.'
 SUBDIRECTORY_OK=Yes
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 ignored=
 ignoredonly=
diff --git a/git-commit.sh b/git-commit.sh
index 81c3a0c..5a388f5 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -5,7 +5,7 @@
 
 USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>] [-u] [--amend] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 git-rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
 branch=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD)
diff --git a/git-fetch.sh b/git-fetch.sh
index 4eecf14..efe44ea 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -2,7 +2,7 @@
 #
 
 USAGE='<fetch-options> <repository> <refspec>...'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 . git-parse-remote
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 16cd351..ae9fbc1 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -6,7 +6,7 @@ USAGE='[--start] [--stop] [--restart]
   [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
   [--module-path=<path> (for Apache2 only)]'
 
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 case "$GIT_DIR" in
 /*)
diff --git a/git-lost-found.sh b/git-lost-found.sh
index b928f2c..5f612f2 100755
--- a/git-lost-found.sh
+++ b/git-lost-found.sh
@@ -2,7 +2,7 @@
 
 USAGE=''
 SUBDIRECTORY_OK='Yes'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 if [ "$#" != "0" ]
 then
diff --git a/git-merge.sh b/git-merge.sh
index a948878..b83b4b9 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -5,7 +5,7 @@
 
 USAGE='[-n] [--no-commit] [--squash] [-s <strategy>] [--reflog-action=<action>] [-m=<merge-message>] <commit>+'
 
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 LF='
 '
diff --git a/git-pull.sh b/git-pull.sh
index e23beb6..8c0f292 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -6,7 +6,7 @@
 
 USAGE='[-n | --no-summary] [--no-commit] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 strategy_args= no_summary= no_commit= squash=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 10135da..2f1e7b7 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 USAGE='--dry-run --author <author> --patches </path/to/quilt/patch/directory>'
 SUBDIRECTORY_ON=Yes
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 dry_run=""
 quilt_author=""
diff --git a/git-rebase.sh b/git-rebase.sh
index 25530df..3220291 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -27,7 +27,7 @@ Example:       git-rebase master~1 topic
        /                   -->           /
   D---E---F---G master          D---E---F---G master
 '
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 RESOLVEMSG="
 When you have resolved this problem run \"git rebase --continue\".
diff --git a/git-repack.sh b/git-repack.sh
index f150a55..e85f0b6 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -5,7 +5,7 @@
 
 USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]'
 SUBDIRECTORY_OK='Yes'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 no_update_info= all_into_one= remove_redundant=
 local= quiet= no_reuse_delta= extra=
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 4eacc3a..fd02d55 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -8,7 +8,7 @@ USAGE='<commit> <url> [<head>]'
 LONG_USAGE='Summarizes the changes since <commit> to the standard output,
 and includes <url> in the message generated.'
 SUBDIRECTORY_OK='Yes'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 revision=$1
 url=$2
diff --git a/git-reset.sh b/git-reset.sh
index c0feb44..4c4f551 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 USAGE='[--mixed | --soft | --hard]  [<commit-ish>]'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 update=
 reset_type=--mixed
diff --git a/git-resolve.sh b/git-resolve.sh
index 36b90e3..4c2d7da 100755
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -10,7 +10,7 @@ echo 'WARNING: Please use git-merge or git-pull instead.' >&2
 sleep 2
 
 USAGE='<head> <remote> <merge-message>'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 dropheads() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" \
diff --git a/git-revert.sh b/git-revert.sh
index 6eab3c7..8a30297 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -18,7 +18,7 @@ case "$0" in
 * )
 	die "What are you talking about?" ;;
 esac
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 no_commit=
 while case "$#" in 0) break ;; esac
diff --git a/git-tag.sh b/git-tag.sh
index d53f94c..a7d6223 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -3,7 +3,7 @@
 
 USAGE='-l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <tagname> [<head>]'
 SUBDIRECTORY_OK='Yes'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 message_given=
 annotate=
diff --git a/git-verify-tag.sh b/git-verify-tag.sh
index 36f171b..d265150 100755
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -2,7 +2,7 @@
 
 USAGE='<tag>'
 SUBDIRECTORY_OK='Yes'
-. git-sh-setup
+. @@GIT_datadir@@/git-sh-setup.sh
 
 verbose=
 while case $# in 0) break;; esac
-- 
1.4.4.1.gc9922-dirty


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
