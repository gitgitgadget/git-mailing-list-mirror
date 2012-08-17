From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 16/16] Add a test script for remote-svn.
Date: Fri, 17 Aug 2012 22:25:57 +0200
Message-ID: <1345235157-702-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T9X-0007Ci-ON
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab2HQU1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:27:51 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60603 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758909Ab2HQU1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:27:15 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so2687336wey.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=V585IhgJ//72S6XdBjd5HUGjRe9UWcj68+gUcmTETXA=;
        b=TRivnDdfKjtJqKVjFQbYhUO84QYDffXyjwXqL6JLT9OUNx9GygaVBXLeYI0H4kEwqT
         +VMuWiiUoCNmNxGdDTYDloTPpZySZpamDRfH04K2U+WeRqPNrTcFmLCAE0FcV41s9wRO
         1h9cAPZNRFrIT3hwYqpmtNZuaBLlV/KbFhJZ7sbhS7vXzD+SHskLbSDcJOP7BJfZf/DA
         yfOJDzmwN4PtiyTKXk6a4IUwKDnDlSeO360xnP1SIRclp5gXvpqRduq7F+0ETYBDR9jE
         DS1PEPpo3qScxXSEJZ5Rf2FdofCIwdLOfPQIXG/erY7R9qYjwbodEVLIh+E2Ilc8CMqy
         xfuQ==
Received: by 10.180.104.200 with SMTP id gg8mr7755053wib.14.1345235234870;
        Fri, 17 Aug 2012 13:27:14 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.27.12
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:27:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203656>

Use svnrdump_sim.py to emulate svnrdump without an svn server.
Tests fetching, incremental fetching, fetching from file://,
and the regeneration of fast-import's marks file.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 t/t9020-remote-svn.sh |   69 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 t/t9020-remote-svn.sh

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
new file mode 100755
index 0000000..afec1ca
--- /dev/null
+++ b/t/t9020-remote-svn.sh
@@ -0,0 +1,69 @@
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
+	#git remote add svnsim svn::sim:///$TEST_DIRECTORY/t9020/example.svnrdump
+	# let's reuse an exisiting dump file!?
+	git remote add svnsim svn::sim:///$TEST_DIRECTORY/t9154/svn.dump
+	git remote add svnfile svn::file:///$TEST_DIRECTORY/t9154/svn.dump
+}
+
+test_debug '
+	git --version
+	which git
+	which svnrdump
+'
+
+test_expect_success 'simple fetch' '
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
+test_expect_success 'repeated fetch, nothing shall change' '
+	git fetch svnsim &&
+	test_cmp master.good .git/refs/remotes/svnsim/master
+'
+
+test_expect_success 'fetch from a file:// url gives the same result' '
+	git fetch svnfile 
+'
+
+test_expect_failure 'the sha1 differ because the git-svn-id line in the commit msg contains the url' '
+	test_cmp .git/refs/remotes/svnfile/master .git/refs/remotes/svnsim/master
+'
+
+test_expect_success 'mark-file regeneration' '
+	mv .git/info/fast-import/remote-svn/svnsim.marks .git/info/fast-import/remote-svn/svnsim.marks.old &&
+	git fetch svnsim &&
+	test_cmp .git/info/fast-import/remote-svn/svnsim.marks.old .git/info/fast-import/remote-svn/svnsim.marks
+'
+
+test_expect_success 'incremental imports must lead to the same head' '
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
