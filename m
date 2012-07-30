From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 16/16] Add a test script for remote-svn.
Date: Mon, 30 Jul 2012 16:31:23 +0200
Message-ID: <1343658683-10713-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr8S-00086y-0D
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab2G3Ojn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:43 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53245 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab2G3Ojl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:41 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859181bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Q4dqXHKKz+4tUOG5VuPMf+Z1B4LK70MeNKtyEF9KDs0=;
        b=Cgm4R5gmf/+qAP15jSrYH5ie9Q39WDMXVtc1hfa32qHeTSZvMmBxBF9HwybmRJzZMb
         A8WfilAFM2BKlmSkWWUvpRUHYNXKmv21T4RNbbjfPw6jAZZ6xsiuRxdp3SyRSxETSeZO
         dLPyh5yL8UN4VNrge6414MMklKmo3XUmFlrBiLoFz4CPazFbooLdS+QWGEMnYUuCoXW/
         YfRsI7mm0mgTcWqGsPbHo9xXVnIunhpeXqGyKip2u81nlFr2d2juH8+LoHS/Z2jPRvih
         mGurwyWcmRTNSEHyiiu46c2fr8g6FOWBSD35MoTVBGayoVJkrChoyf+Uh+jFvj31x2La
         FM2A==
Received: by 10.205.139.6 with SMTP id iu6mr4128585bkc.20.1343659180492;
        Mon, 30 Jul 2012 07:39:40 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.39
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202558>

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
index 0000000..a0c6a21
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
+	mv .git/info/fast-import/marks/svnsim .git/info/fast-import/marks/svnsim.old &&
+	git fetch svnsim &&
+	test_cmp .git/info/fast-import/marks/svnsim.old .git/info/fast-import/marks/svnsim
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
