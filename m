From: Junio C Hamano <junkio@cox.net>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 23 Apr 2007 03:00:03 -0700
Message-ID: <7vd51vh0m4.fsf@assigned-by-dhcp.cox.net>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org>
	<Pine.LNX.4.64.0704161552160.5473@woody.linux-foundation.org>
	<20070417022154.GC30340@thunk.org> <f01b9g$qqc$1@sea.gmane.org>
	<Pine.LNX.4.64.0704161959230.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 12:00:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfvLZ-00035d-LE
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 12:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXDWKAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 06:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbXDWKAG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 06:00:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45355 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbXDWKAE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 06:00:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423100005.XWXB1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 23 Apr 2007 06:00:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qa031W00K1kojtg0000000; Mon, 23 Apr 2007 06:00:04 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45309>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 17 Apr 2007, Jakub Narebski wrote:
>> 
>> You have to use --abbrev-commit (--abbrev is opassed to log machinery, and
>> covers object ids), which is undocumented option (mentioned only in passing
>> in git-reflog(1)).
>
> Yeah, it's irritated me often enough that I think we should just make 
> "--abbrev" set "--abbrev-commit" too.

Hmmm.  I do not know if this breaks anything...

---

 revision.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index ce70f48..78d144b 100644
--- a/revision.c
+++ b/revision.c
@@ -1081,6 +1081,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			}
 			if (!strcmp(arg, "--abbrev")) {
 				revs->abbrev = DEFAULT_ABBREV;
+				revs->abbrev_commit = 1;
 				continue;
 			}
 			if (!prefixcmp(arg, "--abbrev=")) {
@@ -1089,6 +1090,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 					revs->abbrev = MINIMUM_ABBREV;
 				else if (revs->abbrev > 40)
 					revs->abbrev = 40;
+				else
+					revs->abbrev_commit = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--abbrev-commit")) {
