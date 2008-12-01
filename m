From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] Modified the default git help message to be grouped by
	topic
Date: Mon, 1 Dec 2008 09:30:37 -0800
Message-ID: <20081201173037.GA41967@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 18:32:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Ccp-0000rG-4i
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 18:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbYLARam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 12:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbYLARam
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 12:30:42 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:18170 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbYLARal (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 12:30:41 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2753248wfd.4
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 09:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=K0cIwwE3WrAk6cKfKHDV7LR7+HtKtpral/WsmN3Sd3A=;
        b=YzFk5KzVLg2ns8HfN3zRa0WNSXwDSVWZyg53OSX6ptr1lPExf9FLZCxwyKEyAWVNf3
         3mK5v04CT4T3NzAkQHVFpPOS4kXxmFrQQzLV9tTlI+L7IAtkIOa4kTrHypJB4/Tk31KH
         3cC0461RIlc3D4Bt/dW0GBowx6XFebwi+koV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=WHLJ0AVw31dr4C1SznecbLtxmksi8E0jIhqDPKxRQm+9TKG/TCIO09mOfv0VkMrqtL
         D8ib4K6yO6vDYvby81dsghkR1AFVhe93NBXb0FmFm48a/Lkg7wOzJ22oVWzhBTvTg02K
         6ITL5TFBON+hL39tvub2HcSoDmcfi80NenPMw=
Received: by 10.114.145.1 with SMTP id s1mr6648141wad.118.1228152640480;
        Mon, 01 Dec 2008 09:30:40 -0800 (PST)
Received: from @ (adsl-76-254-71-52.dsl.pltn13.sbcglobal.net [76.254.71.52])
        by mx.google.com with ESMTPS id m29sm5071054poh.15.2008.12.01.09.30.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 09:30:39 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102066>

It's difficult to process 21 commands (which is what is output
by default for git when no command is given).  I've re-grouped
them into 4 groups of 5 or 6 commands each, which I think is
clearer and easier for new users to process.

As discussed at the GitTogether.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---

This makes the 'git' (with no arguments) command look like this:
http://gist.github.com/20553

This won't automatically update with the common-commands.txt file,
but I think it is easier to parse for the command you may be looking
for.

 builtin-help.c |   42 +++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index f076efa..562d5d1 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -277,19 +277,35 @@ static struct cmdnames main_cmds, other_cmds;
 
 void list_common_cmds_help(void)
 {
-	int i, longest = 0;
-
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest = strlen(common_cmds[i].name);
-	}
-
-	puts("The most commonly used git commands are:");
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
-	}
+	puts("The most commonly used git commands are:\n\
+\n\
+Basic Commands\n\
+  init       Create an empty git repository or reinitialize an existing one\n\
+  add        Add file contents to the staging area\n\
+  status     Show the working tree and staging area status\n\
+  commit     Record changes in the staging area to the repository\n\
+  rm         Remove files from the working tree and from the index\n\
+  mv         Move or rename a file, a directory, or a symlink\n\
+\n\
+History Commands\n\
+  log        Show commit log history\n\
+  diff       Show changes between commits, commit and working tree, etc\n\
+  grep       Print lines in git tracked files matching a pattern\n\
+  reset      Reset current HEAD to the specified state\n\
+  show       Show various types of objects\n\
+\n\
+Branch Commands\n\
+  checkout   Checkout a branch or paths to the working tree\n\
+  branch     List, create, or delete branches\n\
+  merge      Join two or more development histories together\n\
+  rebase     Apply changes introduced in one branch onto another\n\
+  tag        Create, list, delete or verify a tag object signed with GPG\n\
+\n\
+Remote Commands\n\
+  clone      Clone a repository into a new directory\n\
+  fetch      Download objects and refs from another repository\n\
+  pull       Fetch from and merge with another repository or a local branch\n\
+  push       Update remote refs along with associated objects");
 }
 
 static int is_git_command(const char *s)
-- 
1.6.0.8.gc9c8
