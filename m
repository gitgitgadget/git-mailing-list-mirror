From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Mon, 10 Apr 2006 00:01:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604100000430.30000@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org> <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
 <Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 00:02:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FShyv-0000Vz-Bb
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 00:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWDIWBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 18:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWDIWBr
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 18:01:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:14468 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750938AbWDIWBq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 18:01:46 -0400
Received: (qmail invoked by alias); 09 Apr 2006 22:01:44 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp019) with SMTP; 10 Apr 2006 00:01:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18567>

Hi,

On Sun, 9 Apr 2006, Johannes Schindelin wrote:

> On Sun, 9 Apr 2006, Linus Torvalds wrote:
> 
> >  - keep it - for historical reasons - as a internal shorthand, and just 
> >    turn it into "git log --diff -cc"
> 
> It is "git log --cc", right?

Like this?

---

 git.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

751e205a9ffd3a55094a0c0f657735023776cf74
diff --git a/git.c b/git.c
index 8776088..3a94afa 100644
--- a/git.c
+++ b/git.c
@@ -385,6 +385,13 @@ static int cmd_log(int argc, const char 
 	return 0;
 }
 
+static int cmd_whatchanged(int argc, const char **argv, char **envp)
+{
+	memmove(argv + 2, argv + 1, argc - 1);
+	argv[1] = "--cc";
+	return cmd_log(argc + 1, argv, envp);
+}
+
 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
 	const char *cmd = argv[0];
@@ -395,6 +402,7 @@ static void handle_internal_command(int 
 		{ "version", cmd_version },
 		{ "help", cmd_help },
 		{ "log", cmd_log },
+		{ "whatchanged", cmd_whatchanged },
 	};
 	int i;
 
-- 
1.2.0.g61002-dirty
