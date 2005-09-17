From: Junio C Hamano <junkio@cox.net>
Subject: Re: deprecating more
Date: Fri, 16 Sep 2005 22:28:28 -0700
Message-ID: <7vfys4e003.fsf@assigned-by-dhcp.cox.net>
References: <7vd5n8fqso.fsf@assigned-by-dhcp.cox.net>
	<7vzmqceayd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509161856260.26803@g5.osdl.org>
	<7vr7boe8a8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509161938580.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Sep 17 07:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGVFe-0005c6-97
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 07:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVIQF2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 01:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVIQF2c
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 01:28:32 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:25259 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750936AbVIQF2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 01:28:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050917052831.NPIE17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Sep 2005 01:28:31 -0400
To: tony.luck@intel.com
In-Reply-To: <Pine.LNX.4.58.0509161938580.26803@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 16 Sep 2005 19:50:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8754>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 16 Sep 2005, Junio C Hamano wrote:
>
>> What do you think about the other commands I mentioned?
>
> I think they can all go. I think some old scripts migth still use 
> git-rev-tree, but it really is clearly inferior in every way to 
> git-rev-list that such scripts should be fixed anyway. Fixing them should 
> be pretty easy.

I found one in our source.  Tony, is the following change
acceptable to you?

------------
[PATCH] Use git-rev-list not git-rev-tree where appropriate.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/Documentation/howto/using-topic-branches.txt b/Documentation/howto/using-topic-branches.txt
--- a/Documentation/howto/using-topic-branches.txt
+++ b/Documentation/howto/using-topic-branches.txt
@@ -245,7 +245,7 @@ gb=$(tput setab 2)
 rb=$(tput setab 1)
 restore=$(tput setab 9)
 
-if [ `git-rev-tree release ^test | wc -c` -gt 0 ]
+if [ `git-rev-list release ^test | wc -c` -gt 0 ]
 then
 	echo $rb Warning: commits in release that are not in test $restore
 	git-whatchanged release ^test
@@ -262,7 +262,7 @@ do
 	status=
 	for ref in test release linus
 	do
-		if [ `git-rev-tree $branch ^$ref | wc -c` -gt 0 ]
+		if [ `git-rev-list $branch ^$ref | wc -c` -gt 0 ]
 		then
 			status=$status${ref:0:1}
 		fi
