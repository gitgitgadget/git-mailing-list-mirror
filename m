From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Wed, 08 Feb 2006 22:47:54 -0800
Message-ID: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 09 07:48:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F75ax-0002E0-8T
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 07:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWBIGr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 01:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWBIGr4
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 01:47:56 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58542 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422829AbWBIGrz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 01:47:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209064504.TTLK17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 01:45:04 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15792>

I haven't heard major breakage around the new features scheduled
for 1.2.0 so far, except for the two-tree "diff-tree --cc" Linus
has already fixed, so the previous "What's new" is pretty much
unchanged.

One *major* change I am thinking about doing is to change my
workflow a bit.  So far, the proposed updates branch "pu" was
almost impossible to follow unless you are really a devoted git
developer, because it is always rebased to the latest master and
then topic branches are merged onto it.  While that keeps the
number of unnecessary merge nodes between master and pu to the
minimum, it actively discouraged for the branch to be followed
by developers.

I would like to rectify that.

So I have created another branch, "next".  This is managed quite
differently from "pu".  I'd promise these things:

 * It is to contain planned updates and merge from topic
   branches, just like "pu" currently does.  However, the topics
   merged there will not contain majorly whacky / unproven ones
   like bind commits and shallow clones, until the basic part
   proves sound during the list discussion.

 * I will not rewind or rebase the "next" branch.  Also I will
   not rebase the topic branches that are merged into it.

 * It would occasionally merge from "master" if only to prevent
   conflicts.

 * If there are patches sent to improve a topic branch in it,
   they will be applied to the topic branch, and then the topic
   branch is merged into "next", without any funny rewinding or
   rebasing of "next".  This will make the "next" branch
   cluttered with repeated merges from the same topic branch,
   but that is OK.  "next" will not be merged into "master",
   ever.

 * Once a topic is fully cooked, the topic branch will be merged
   into "master".

What this means is that "next" should be as easy to follow as
"master", but still is slightly ahead of "master" with not so
wildly experimental features.

Although there theoretically is no reason not to follow the
above principles I set for "next" to manage "pu", it will stay
wild for now until I get more comfortable with this workflow.

Now, what's in "next"?  Currently I have two topic branches
merged to it.

    * jc/nostat:
      ls-files: debugging aid for CE_VALID changes.
      "Assume unchanged" git: do not set CE_VALID with --refresh
      "Assume unchanged" git

    * jc/empty-commit:
      t6000: fix a careless test library add-on.
      Do not allow empty name or email.
