From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 03 Jun 2007 08:59:18 -0400
Message-ID: <878xb19ot5.fsf@graviton.dyn.troilus.org>
References: <20070603114843.GA14336@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 15:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huq3F-0002it-Ke
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbXFCNXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbXFCNXQ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:23:16 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:36648
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753759AbXFCNXP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jun 2007 09:23:15 -0400
X-Greylist: delayed 1436 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jun 2007 09:23:15 EDT
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id A7FDE89C046; Sun,  3 Jun 2007 08:59:18 -0400 (EDT)
In-Reply-To: <20070603114843.GA14336@artemis> (Pierre Habouzit's message of "Sun\, 3 Jun 2007 13\:48\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48991>

Pierre Habouzit writes:

>   Hi, I'm currently trying to think about a bug tracking system that
> would be tightly integrated with git, meaning that it would have to be
> somehow decentralized.
>
>   Though there is a few design issues I have, that block me from doing
> first decisions about how to implement some kind of Proof of Concept. My
> main problem is: should I put this bug tracking system in the repository
> it tracks bugs for, or not.
>
>   I mean, the immediate idea is to have some .bugs/ directories (or
> alike). This has many good properties, e.g. for projects like the linux
> kernel with its many subsystems or driver, it would make sense to have
> per driver/subsystems/... bug packs, and move bugs from one pack to
> another would be the way of assigning bugs to different modules.
>
>   Also, a good thing is that when you "report" a bug, it gets commited
> in the repository, and taints all the commit chilren, until you commit
> the closing patch. This allow a release manager to rapidly _see_ if his
> stable branch has this or this bug.
>
>   OTOH it comes with many problems. First, and most obvious IMHO, it's
> that it'll mean bugs will have to be pulled into the mainlines. Let's
> take example with the linux repository, I'm not sure Linus would be
> really keen on doing rounds of bugs pulls, not to mention it'll bloat
> the repository somehow.
>
>   The other problem I see is that at the time a bug gets reported, the
> user knows it's found at a commit say 'X'. But it could in fact have
> been generated at a commit Y, with this pattern:
>
>   --o---o---Y---o---o---o---o---X---o---o--> master
>                      \
>                       o---o---o---o---o---o--> branch B

Mainly for that reason, I would suggest having it outside the code
base's namespace: probably a different root in the same $GIT_DIR, but
I can see people wanting to have a separate $GIT_DIR.  If the database
tracks bugs by what commit(s) introduce or expose the bug -- at least
once that is known -- then you get nearly free tracking of which
branches have the bug without having to check out largely redundant
trees.

Michael Poole
