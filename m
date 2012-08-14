From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 16/16] Add a test script for remote-svn.
Date: Tue, 14 Aug 2012 21:13:18 +0200
Message-ID: <1344971598-8213-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:18:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Mcq-0004JY-TV
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab2HNTRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785Ab2HNTRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:46 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2B9LbJ3PxRXHdjGFwIsj35rtAWWTDqq49pa6SJG+yTw=;
        b=iwGWC5F+GRggufXCTcclNH+ZB+TUQaeJ2qGkAZgVzvNKyWrI37VbooHjWI6cwhekHK
         rvieNZn5Ne+QH7xkPrkeNN2ZTrnLLkry8aRUY6ZWyyQRdAMF9snJKRQvrkn+jrc9eZ+U
         1VDsZTX8fG1H7+p6DTW2OKNHGqkFKvezMkQOy8mA5ZiDIhk1jAUZFBw0z2dztJWuXxkj
         tnYz+mR9Cs1G5/cappctA07yivDO+129vbGQvXwuT26iU3hcgyOZAvkwtYylEgBHIjEE
         bW5DY4p1Nj/2orZGc7oMRILsd4D2jXfUerY5mrpW+mE1f3T1YqfB64Dh51zRTkditt3r
         uVpg==
Received: by 10.204.147.65 with SMTP id k1mr6826489bkv.29.1344971865549;
        Tue, 14 Aug 2012 12:17:45 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.42
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203440>

Use svnrdump_sim.py to emulate svnrdump without an svn server.
Tests fetching, incremental fetching, fetching from file://,
and the regeneration of fast-import's marks file.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 t/t9020-remote-svn.sh |   69 +++++++++++++++++++++++++++++++++++++++++++++++++
 transport-helper.c    |   15 ++++++-----
 2 files changed, 77 insertions(+), 7 deletions(-)
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
diff --git a/transport-helper.c b/transport-helper.c
index 47db055..a363f2c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -17,6 +17,7 @@ static int debug;
 struct helper_data {
 	const char *name;
 	struct child_process *helper;
+	struct argv_array argv;
 	FILE *out;
 	unsigned fetch : 1,
 		import : 1,
@@ -103,7 +104,6 @@ static void do_take_over(struct transport *transport)
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
-	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
 	const char **refspecs = NULL;
@@ -125,10 +125,11 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->in = -1;
 	helper->out = -1;
 	helper->err = 0;
-	argv_array_pushf(&argv, "git-remote-%s", data->name);
-	argv_array_push(&argv, transport->remote->name);
-	argv_array_push(&argv, remove_ext_force(transport->url));
-	helper->argv = argv.argv;
+	argv_array_init(&data->argv);
+	argv_array_pushf(&data->argv, "git-remote-%s", data->name);
+	argv_array_push(&data->argv, transport->remote->name);
+	argv_array_push(&data->argv, remove_ext_force(transport->url));
+	helper->argv = data->argv.argv;
 	helper->git_cmd = 0;
 	helper->silent_exec_failure = 1;
 
@@ -143,8 +144,6 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->helper = helper;
 	data->no_disconnect_req = 0;
-	free((void*) helper_env[1]);
-	argv_array_clear(&argv);
 
 	/*
 	 * Open the output as FILE* so strbuf_getline() can be used.
@@ -247,6 +246,8 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
+		free((void*) data->helper->env[1]);
+		argv_array_clear(&data->argv);
 		free(data->helper);
 		data->helper = NULL;
 	}
-- 
1.7.9.5
