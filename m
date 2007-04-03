From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: A few minor fixes to Git User's Manual
Date: Tue, 03 Apr 2007 12:03:48 -0700
Message-ID: <7vlkh9xotn.fsf@assigned-by-dhcp.cox.net>
References: <11756176481314-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYoIL-0004aM-6O
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbXDCTDu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbXDCTDu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:03:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:35513 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422657AbXDCTDt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:03:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403190349.RVRG25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 15:03:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ij3o1W0021kojtg0000000; Tue, 03 Apr 2007 15:03:48 -0400
In-Reply-To: <11756176481314-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Tue, 3 Apr 2007 18:27:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43639>

Jakub Narebski <jnareb@gmail.com> writes:

> * no "detached head" feature (since 1.5.0.5 at least)

That is a 1.5.0 feature.

Care to volunteer to write that section?  I think illustrating
what you would want to achieve by detaching your HEAD would be
useful, and I offhand know of two different uses:

 - Sightseeing.  You do not intend to build on, but seek around
   to see what was there in the past.  Checking out a tag or a
   remote branch falls into this.

 - Rebuilding history.  When you want to futz with a commit 5
   revs ago, you would detach your HEAD to that commit, fix it
   up, and rebase the original branch on top of that detached
   HEAD.

I am sure people may have invented more creative ways to use it.
The topic probably belongs to "advanced user's manual", though.

> * uses ssh://host/path syntax instead of scp-like host:path
>   (which one is preferred? documentation has URL-like first)

My impression is that site:path is preferred.

> * no mention of receive.denyNonFastForwards (in about push)

I think the "Setting up a shared repository" section refers most
of the material to cvs-migration.txt, so you probably want to
add a sentence to "Advanced Shared Repository Management"
section in the latter.

> * inconsistent use of header levels

I am not sure what you are getting at.  

> * no git rebase --merge (e.g. renames)
> * git cherry-pick --no-commit + git commit, instead of
>   git cherry-pick + git commit --amend

It usually is not a good idea for a manual to show two ways to
do the same thing without explaining pros and cons.

I typically use rebase *without* --merge because it tends to be
faster (recently 'mailinfo' was broken for i18n contents, and I
had to use "rebase --merge" until it was fixed; now I can go
back to my old ways of running it without --merge ;-)).  I think
the only reason to use --merge is when you want the rename thing
in merge-recursive.

I do not think "cherry-pick -n + commit" vs "cherry-pick +
commit --amend" is an interesting contrast for a single commit.
Squashing more than one commit is why you would want to pick
without committing, which you cannot do with the latter.  So
they are not "instead of" -- they serve different purposes.

> * legitimate use of multiple root commits: joining projects
>   (e.g. git = git-core + git-tools (mail) + gitk + gitweb + git-gui)

I am not sure if you would even need to talk about it.  As long
as the document does not say "you shouldn't have more than one
root", I think we are Ok.
