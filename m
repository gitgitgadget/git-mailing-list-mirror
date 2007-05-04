From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Have git-revert, git-cherry-pick cleanup ./.msg upon successful completion.
Date: Fri, 4 May 2007 14:32:10 +0000
Message-ID: <20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 16:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjyp9-0002zB-7Z
	for gcvg-git@gmane.org; Fri, 04 May 2007 16:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbXEDObu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 10:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755358AbXEDObu
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 10:31:50 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:48694 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1755357AbXEDObt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 10:31:49 -0400
Received: (qmail 8691 invoked by uid 1000); 4 May 2007 14:32:10 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46183>

git-revert and git-cherry-pick left behind the commit message file ./.msg,
have them use the -f option to git-commit to properly cleanup the
automatically created file.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-revert.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 4ba0ee6..9acdf47 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -376,10 +376,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	if (!no_commit) {
 		if (edit)
-			return execl_git_cmd("commit", "-n", "-F", ".msg",
+			return execl_git_cmd("commit", "-n", "-f", ".msg",
 				"-e", NULL);
 		else
-			return execl_git_cmd("commit", "-n", "-F", ".msg",
+			return execl_git_cmd("commit", "-n", "-f", ".msg",
 				NULL);
 	}
 	if (reencoded_message)
-- 
1.5.1.2
