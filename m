From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 14:05:28 -0700
Message-ID: <7vhcyt81gn.fsf@assigned-by-dhcp.cox.net>
References: <45196628.9010107@gmail.com>
	<Pine.LNX.4.64.0609261629160.9789@iabervon.org>
	<20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com>
	<20060927080652.GA8056@admingilde.org>
	<Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060927113813.GC8056@admingilde.org>
	<Pine.LNX.4.63.0609271358100.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060927124413.GN1221MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed Sep 27 23:06:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSgb0-0001d4-W7
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 23:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030849AbWI0VFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 17:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030850AbWI0VFb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 17:05:31 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54967 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030849AbWI0VFa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 17:05:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927210530.INN6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 17:05:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TZ5X1V00V1kojtg0000000
	Wed, 27 Sep 2006 17:05:32 -0400
To: skimo@liacs.nl
In-Reply-To: <20060927124413.GN1221MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 27 Sep 2006 14:44:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27933>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Wed, Sep 27, 2006 at 02:01:11PM +0200, Johannes Schindelin wrote:
>
>> AFAICT this is not the idea of subprojects-in-git.
>
> As already pointed out by Daniel, there is no such thing as
> "the idea of subprojects-in-git".  There are many ideas of
> subprojects-in-git.
>
> I, for one, would want to commit the changed state of a subproject
> to the superproject explicitly.

I think this is a very good summary of the point in this entire
thread.  Different workflows call for different granularity, and
if something deserves to be called "subproject", not just "a
subdirectory of a single project", it is not unreasonable to
think that it would want to track its own state at different
pace from the other parts of the project, and at finer grain
than the project taken as the whole.

Not allowing subprojects to do so means every little change
anywhere in the project tree results in a tree-wide new commit
object; in that case, the whole thing is a single large project
from core-git's point of view.

Avoiding checking out parts of the project tree that you do not
care about while you work on such a single large project is
another interesting and useful area to think about, but I would
say at that point it is not about subproject at all -- it is
about working in a sparsely populated working tree of a single
project.

XCB team recently told us that they started from such a single
large project and now they are splitting that into separate
pieces.  Their experiences may be valuable to be shared to
discuss pros-and-cons of these two approaches.
