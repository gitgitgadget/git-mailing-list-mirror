From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 4/9] user-manual: Mention 'git remote add' for remote branch
 config
Date: Sun, 17 Feb 2013 19:15:56 -0500
Message-ID: <1ef8fd5d7754ef65a9aaf26250b7b9f0488ff59c.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EPe-0000ZK-0Z
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab3BRAQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:27 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:34158 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3BRAQY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:24 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE003P83EVDC50@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:09 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id A71B788565E; Sun,
 17 Feb 2013 19:16:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146567; bh=jdxw5B0RUFODoIEHCmQwDXaJYFZWFoRCOekliWkWXyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=XHoydyk1m0+EkwYCuex85o7H3rweOj8L+YOC3zM81UMcjfPKVKbS3xPEl0FVaU5NG
 tg5DunKrsUVh8rZfY4XtasE3MM7feYU6+HAu9/W1DrVLn9srRE1ER2GVHxElR3Wg2Y
 nMEjSsUDFVtNBh3RXy0Fh5xSH3wuhF4RGj3xJ8rw=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216414>

From: "W. Trevor King" <wking@tremily.us>

I hardly ever setup remote.<name>.url using 'git config'.  While it
may be instructive to do so, we should also point out 'git remote
add'.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ba06b7e..91f1822 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2878,48 +2878,34 @@ branch.master.merge=refs/heads/master
 
 If there are other repositories that you also use frequently, you can
 create similar configuration options to save typing; for example,
-after
 
 -------------------------------------------------
-$ git config remote.example.url git://example.com/proj.git
+$ git remote add example git://example.com/proj.git
 -------------------------------------------------
 
-then the following two commands will do the same thing:
+adds the following to `.git/config`:
 
 -------------------------------------------------
-$ git fetch git://example.com/proj.git master:refs/remotes/example/master
-$ git fetch example master:refs/remotes/example/master
+[remote "example"]
+	url = git://example.com/proj.git
+	fetch = +refs/heads/*:refs/remotes/example/*
 -------------------------------------------------
 
-Even better, if you add one more option:
-
--------------------------------------------------
-$ git config remote.example.fetch master:refs/remotes/example/master
--------------------------------------------------
+Also note that the above configuration can be performed by directly
+editing the file `.git/config` instead of using linkgit:git-remote[1].
 
-then the following commands will all do the same thing:
+After configuring the remote, the following two commands will do the
+same thing:
 
 -------------------------------------------------
-$ git fetch git://example.com/proj.git master:refs/remotes/example/master
-$ git fetch example master:refs/remotes/example/master
+$ git fetch git://example.com/proj.git +refs/heads/*:refs/remotes/example/*
+$ git fetch example +refs/heads/*:refs/remotes/example/*
 $ git fetch example
 -------------------------------------------------
 
-You can also add a "+" to force the update each time:
-
--------------------------------------------------
-$ git config remote.example.fetch +master:refs/remotes/example/master
--------------------------------------------------
-
-Don't do this unless you're sure you won't mind "git fetch" possibly
-throwing away commits on 'example/master'.
-
-Also note that all of the above configuration can be performed by
-directly editing the file .git/config instead of using
-linkgit:git-config[1].
-
 See linkgit:git-config[1] for more details on the configuration
-options mentioned above.
+options mentioned above and linkgit:git-fetch[1] for more details on
+the refspec syntax.
 
 
 [[git-concepts]]
-- 
1.8.1.336.g94702dd
