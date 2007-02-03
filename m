From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Flag and skip over packfiles known to be invalid.
Date: Fri, 02 Feb 2007 21:44:08 -0800
Message-ID: <7vr6t7bxsn.fsf@assigned-by-dhcp.cox.net>
References: <dda240a4adf0511b3e1ab1eb74abdd28821358b0.1170403175.git.spearce@spearce.org>
	<20070202080010.GB21094@spearce.org>
	<7virelhsae.fsf@assigned-by-dhcp.cox.net>
	<20070202085108.GC20832@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 06:44:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDDhG-0000YX-6P
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 06:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946342AbXBCFoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 00:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946350AbXBCFoL
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 00:44:11 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:47936 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946342AbXBCFoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 00:44:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203054410.RFNC1343.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 3 Feb 2007 00:44:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jtk81W00T1kojtg0000000; Sat, 03 Feb 2007 00:44:09 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38552>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I almost submitted a patch to do that tonight, but I couldn't decide
> on behavior: should we scan known packs, then try for loose, then
> scan packs again until no object or no new pack is found?  Probably.

Hmmm.  Probably.  

But I tend to think that this particular failure scenario is
probably rare enough that plugging this in "the right way" is
not a high priority.  We should definitely revisit it post
1.5.0.

Also if we are adding a bitfield, I think pack_local should also
become one, as it currently wastes a whole word to hold one bit
(on the other hand if we do not want to add a field I think a
different negative value in pack_fd could mean "do not bother to
look at it again").
