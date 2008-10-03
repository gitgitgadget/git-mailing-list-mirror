From: Thomas Rast <trast@student.ethz.ch>
Subject: [FYI PATCH] bash completion: alias 'g' to 'git' with completion
Date: Fri,  3 Oct 2008 18:35:05 +0200
Message-ID: <1223051705-30347-1-git-send-email-trast@student.ethz.ch>
References: <fc113d400810030825l75f9451dwc4cbf68807be0b5b@mail.gmail.com>
Cc: Rob Sanheim <rsanheim@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 18:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klndd-0004GZ-1A
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 18:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbYJCQfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 12:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbYJCQfK
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 12:35:10 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:39600 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbYJCQfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 12:35:09 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 3 Oct 2008 18:35:05 +0200
Received: from localhost.localdomain ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 3 Oct 2008 18:35:05 +0200
X-Mailer: git-send-email 1.6.0.2.771.g3967
In-Reply-To: <fc113d400810030825l75f9451dwc4cbf68807be0b5b@mail.gmail.com>
X-OriginalArrivalTime: 03 Oct 2008 16:35:05.0068 (UTC) FILETIME=[FD7822C0:01C92575]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97436>

---

Rob Sanheim wrote:
> On Thu, Oct 2, 2008 at 11:10 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > No, you'll need to alias 'g' to git in bash, and then if you still
> > want completion you'll need to also register the compgen to call
> > _git completion routine.  Its two lines:
> >
> >        alias g=git
> >        complete -o default -o nospace -F _git g
>
> Thanks, that did it.

Actually it's not enough, you need to teach fetch, pull and push to
recognise the new alias too, as in this patch.  I do wonder if there's
a better approach to those functions however, so that the "obvious"
fix suggested by Shawn would work.

- Thomas


 contrib/completion/git-completion.bash |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7284c3b..547e735 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -789,7 +789,7 @@ _git_fetch ()
 	git-fetch*,1)
 		__gitcomp "$(__git_remotes)"
 		;;
-	git,2)
+	git,2|g,2)
 		__gitcomp "$(__git_remotes)"
 		;;
 	*)
@@ -1053,7 +1053,7 @@ _git_pull ()
 	git-pull*,1)
 		__gitcomp "$(__git_remotes)"
 		;;
-	git,2)
+	git,2|g,2)
 		__gitcomp "$(__git_remotes)"
 		;;
 	*)
@@ -1075,7 +1075,7 @@ _git_push ()
 	git-push*,1)
 		__gitcomp "$(__git_remotes)"
 		;;
-	git,2)
+	git,2|g,2)
 		__gitcomp "$(__git_remotes)"
 		;;
 	*)
@@ -1717,6 +1717,7 @@ _gitk ()
 }
 
 complete -o default -o nospace -F _git git
+complete -o default -o nospace -F _git g
 complete -o default -o nospace -F _gitk gitk
 
 # The following are necessary only for Cygwin, and only are needed
-- 
1.6.0.2.771.g3967
