From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 16/16] Add a test script for remote-svn
Date: Wed, 22 Aug 2012 21:16:01 +0200
Message-ID: <1345662961-9587-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:17:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQk-0002J7-6M
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030Ab2HVTRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:17:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965064Ab2HVTRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:17:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so449679bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QOjmIW8GaMbq8ClIal17mxRh6Jf6Lj86/J0HJr3kjWI=;
        b=vd4dTzH3/Jfyu/1M78b9e4zYuIVYIbDgUKEr8aomH9rCiMjCshQM+zYUmXiDcFjMmn
         5LugWMSAekSfx4Eq8YnGVsdJa3vVn7zjf1xCQLoEfP9w+Q2TAuawIbIxdO3bFn9XxPyw
         Xg4Wk1qq5pYBQFQ01A2r14Sp9VR2p6a75kTz7ODglIclAvz5fsUoiewW3xU7NIpayjml
         wG7xK5j6eWbB1Aqi9sEqDe/i9agOoKQ9MTuLl9rhAe4fDBYtpG8Cf7doh5jUTQQQXB1t
         UqJ2pl3Bll7POGNSGYscR9ia67OELU0tpdHTGAedJkvsVnoLnXYk8R0U2sz6Ilsou7Rj
         2SyA==
Received: by 10.204.157.135 with SMTP id b7mr6878852bkx.61.1345663020440;
        Wed, 22 Aug 2012 12:17:00 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.58
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204080>

Use svnrdump_sim.py to emulate svnrdump without an svn server.
Tests fetching, incremental fetching, fetching from file://,
and the regeneration of fast-import's marks file.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9020-remote-svn.sh |   76 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100755 t/t9020-remote-svn.sh

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
new file mode 100755
index 0000000..9ae9997
--- /dev/null
+++ b/t/t9020-remote-svn.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='tests remote-svn'
+
+. ./test-lib.sh
+
+# We override svnrdump by placing a symlink to the svnrdump-emulator in .
+export PATH="$HOME:$PATH"
+ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
+
+init_git () {
+	rm -fr .git &&
+	git init &&
+	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.svnrdump
+	# let's reuse an exisiting dump file!?
+	git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9154/svn.dump
+	git remote add svnfile testsvn::file:///$TEST_DIRECTORY/t9154/svn.dump
+}
+
+if test -e "$GIT_BUILD_DIR/git-remote-testsvn"
+then
+	test_set_prereq REMOTE_SVN
+fi
+
+test_debug '
+	git --version
+	which git
+	which svnrdump
+'
+
+test_expect_success REMOTE_SVN 'simple fetch' '
+	init_git &&
+	git fetch svnsim &&
+	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
+	cp .git/refs/remotes/svnsim/master master.good
+'
+
+test_debug '
+	cat .git/refs/svn/svnsim/master
+	cat .git/refs/remotes/svnsim/master
+'
+
+test_expect_success REMOTE_SVN 'repeated fetch, nothing shall change' '
+	git fetch svnsim &&
+	test_cmp master.good .git/refs/remotes/svnsim/master
+'
+
+test_expect_success REMOTE_SVN 'fetch from a file:// url gives the same result' '
+	git fetch svnfile
+'
+
+test_expect_failure REMOTE_SVN 'the sha1 differ because the git-svn-id line in the commit msg contains the url' '
+	test_cmp .git/refs/remotes/svnfile/master .git/refs/remotes/svnsim/master
+'
+
+test_expect_success REMOTE_SVN 'mark-file regeneration' '
+	# filter out any other marks, that can not be regenerated. Only up to 3 digit revisions are allowed here
+	grep ":[0-9]\{1,3\} " .git/info/fast-import/remote-svn/svnsim.marks > .git/info/fast-import/remote-svn/svnsim.marks.old &&
+	rm .git/info/fast-import/remote-svn/svnsim.marks &&
+	git fetch svnsim &&
+	test_cmp .git/info/fast-import/remote-svn/svnsim.marks.old .git/info/fast-import/remote-svn/svnsim.marks
+'
+
+test_expect_success REMOTE_SVN 'incremental imports must lead to the same head' '
+	export SVNRMAX=3 &&
+	init_git &&
+	git fetch svnsim &&
+	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
+	unset SVNRMAX &&
+	git fetch svnsim &&
+	test_cmp master.good .git/refs/remotes/svnsim/master
+'
+
+test_debug 'git branch -a'
+
+test_done
-- 
1.7.9.5
