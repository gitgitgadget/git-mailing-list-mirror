From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 14:27:47 -0800
Message-ID: <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net>
References: <20070211084030.GE2082@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 23:27:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNAm-0002jR-Cu
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 23:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbXBKW1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 17:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbXBKW1s
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 17:27:48 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62338 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbXBKW1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 17:27:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211222748.ZKFN21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 17:27:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NNTn1W00d1kojtg0000000; Sun, 11 Feb 2007 17:27:47 -0500
In-Reply-To: <20070211084030.GE2082@spearce.org> (Shawn O. Pearce's message of
	"Sun, 11 Feb 2007 03:40:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39315>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> One of my goals for git-gui is to get it merged into core Git, so
> there is a GUI tool available out-of-the-box for commit creation,
> (some) branch manipulation, basic merging, and pushing/fetching
> changes.

I do not have objection per-se, but I have two choices on the
procedure, and I hate having choices this close to the final
release ;-).

(1) I can do the usual 'no common ancestor' merge, and treat it
    just like gitk.  I would probably place git-gui as a
    subdirectory in git.git (just like I did to gitweb/), and
    tweak the main Makefile to chdir down to git-gui, and let
    the git-gui/Makefile (the toplevel Makefile from your point
    of view) do its work.  Your current git-gui repository that
    does not have rest of git.git will _remain_ git-less.  In
    addition, git-gui repository remains to be the authoritative
    place its improvements take place.  git.git pull from there
    from time to time to get updates.

(2) After the 'no common ancestor' merge above, you fast forward
    git-gui to git.git and two repositories can cross pull from
    each other from that point on.

I have a suspicion that doing the former may turn out to be a
good demonstration that git supports subprojects already.  The
toplevel project _knows_ about subproject, but the subproject
does not have to be aware of the toplevel project.  Granted, the
toplevel project knows which specific version of the subproject
is bound to each of its commit, which is tighter integration
than what usually is desired, but still it is a form of
subproject support that may be useful.

I was actually hoping I can do so with Kay, but from his point
of view merging gitweb to git.git was so that he does not have
to worry about it anymore, so it did not work well.
