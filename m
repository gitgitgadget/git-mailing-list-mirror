From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 16/16] Add a test script for remote-svn.
Date: Thu, 26 Jul 2012 09:32:37 +0200
Message-ID: <1343287957-22040-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:35:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIbH-0005DO-17
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab2GZHfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:35:04 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab2GZHe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:56 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Q4dqXHKKz+4tUOG5VuPMf+Z1B4LK70MeNKtyEF9KDs0=;
        b=KvLqw8RhrxR5m0f9xUeCzPk/ZEjkP5fnM2GwgOTR0ZGSjJg1A95WZS60Y7GnRrH4e9
         4A3V2b7uXjy/+LgSvKKXsv/sJuEI5CUz7Ifm7pOso7inShvAmtAume0VLqUS5qYCGO5t
         geuKAq2InzfQMKp1isYsjsXHtstCTdqisjJxq3b5QbkFc3eOHMV9QXgz3jzERXCB+kn5
         ZET/8Uf3KrW+X7G6TSMUpLqfV4443KvepVHqI2lxB7ZWsVAm0mYvAqBAtFGh5p5TBMwi
         ffad1LGYmFJP+gmvomlUkzf/7/YPG7uDqSefTbEJa0a5uVEcXOr0KxGTrEcK3HQCtsXs
         B9ow==
Received: by 10.204.153.10 with SMTP id i10mr13085891bkw.67.1343288095447;
        Thu, 26 Jul 2012 00:34:55 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.53
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202245>

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
