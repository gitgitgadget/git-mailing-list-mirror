From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] ciabot: fix post-update hook description
Date: Mon, 29 May 2006 02:09:59 +0200
Message-ID: <20060529000959.GA2061@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 02:10:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkVKm-0007uT-VH
	for gcvg-git@gmane.org; Mon, 29 May 2006 02:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWE2AKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 20:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWE2AKF
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 20:10:05 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:34471 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751054AbWE2AKD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 20:10:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 78FE177002D;
	Mon, 29 May 2006 02:10:02 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08388-20; Mon, 29 May 2006 02:09:59 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A653677002B;
	Mon, 29 May 2006 02:09:59 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D81CF6DF88D; Mon, 29 May 2006 02:06:51 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 8BC616253D; Mon, 29 May 2006 02:09:59 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20909>

Also, improve on a few lost sentences

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

b2d8b2c5258b6585102c94f37c63dc2360092d87
 contrib/ciabot.pl |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

b2d8b2c5258b6585102c94f37c63dc2360092d87
diff --git a/contrib/ciabot.pl b/contrib/ciabot.pl
index 83a0d80..e23f5f1 100755
--- a/contrib/ciabot.pl
+++ b/contrib/ciabot.pl
@@ -14,15 +14,15 @@ #
 # The master location of this file is in the Cogito repository
 # (see http://www.kernel.org/git/).
 #
-# This program is designed to run as the .git/commit-post-hook script. It takes
-# the commit information, massaging it and mailing it to the address given below.
+# This program is designed to run as the .git/hooks/post-commit hook. It takes
+# the commit information, massages it and mails it to the address given below.
 #
-# The calling convention of the commit-post-hook script is:
+# The calling convention of the post-commit hook is:
 #
-#	commit-post-hook $commit_sha1 $branch_name
+#	.git/hooks/post-commit $commit_sha1 $branch_name
 #
 # If it does not work, try to disable $xml_rpc in the configuration section
-# below.
+# below. Also, remember to make the hook file executable.
 #
 #
 # Note that you can (and it might be actually more desirable) also use this
@@ -36,9 +36,9 @@ #	for merged in $(git-rev-list $newhead 
 #		/path/to/ciabot.pl $merged $refname
 #	done
 #
-# This is useful when you use a remote repository without working copy, where
-# you only push to - the update hook will be trigerred each time you push into
-# that repository, and the pushed commits will be reported through CIA.
+# This is useful when you use a remote repository that you only push to. The
+# update hook will be triggered each time you push into that repository, and
+# the pushed commits will be reported through CIA.
 
 use strict;
 use vars qw ($project $from_email $dest_email $noisy $rpc_uri $sendmail
@@ -78,19 +78,19 @@ # not deliver the event at all if CIA se
 # unfortunately not an uncommon condition.
 $xml_rpc = 0;
 
-# You can make this bot to totally ignore events concerning the objects
-# specified below. Each object is composed of <path>/<filename>,
+# This variable should contain a regexp, against which each file will be
+# checked, and if the regexp is matched, the file is ignored. This can be
+# useful if you do not want auto-updated files, such as e.g. ChangeLog, to
+# appear via CIA.
 #
-# This variable should contain regexp, against which will each object be
-# checked, and if the regexp is matched, the file is ignored. Therefore ie.  to
-# ignore all changes in the two files above and everything concerning module
-# 'admin', use:
+# The following example will make the script ignore all changes in two specific
+# files in two different modules, and everything concerning module 'admin':
 #
 # $ignore_regexp = "^(gentoo/Manifest|elinks/src/bfu/inphist.c|admin/)";
 $ignore_regexp = "";
 
 # It can be useful to also grab the generated XML message by some other
-# programs and ie. autogenerate some content based on it. Here you can specify
+# programs and e.g. autogenerate some content based on it. Here you can specify
 # a file to which it will be appended.
 $alt_local_message_target = "";
 
-- 
1.3.3.gd882-dirty

-- 
Jonas Fonseca
