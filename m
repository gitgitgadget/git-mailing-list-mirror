From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Thu, 18 May 2006 15:36:39 -0700
Message-ID: <7vzmhfm03s.fsf@assigned-by-dhcp.cox.net>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
	<Pine.LNX.4.64.0605181435230.10823@g5.osdl.org>
	<7viro3nh07.fsf@assigned-by-dhcp.cox.net>
	<20060518222045.GB6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 00:36:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgr6q-0004aL-Jg
	for gcvg-git@gmane.org; Fri, 19 May 2006 00:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWERWgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 18:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWERWgl
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 18:36:41 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:53643 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750843AbWERWgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 18:36:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518223640.JTQC27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 18:36:40 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060518222045.GB6535@nowhere.earth> (Yann Dirson's message of
	"Fri, 19 May 2006 00:20:45 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20312>

Yann Dirson <ydirson@altern.org> writes:

> I'm not sure I understand what you're saying.

Please don't; I was asleep when I typed it -- sorry.

I was hoping fsck was doing the right thing for a very low level
tool -- verify commit objects itself, without relying on the
object parser machinery which does funky things like grafts.

Apparently it doesn't -- which is mostly good.  You can safely
remove commits you wanted to discard by grafting it away like
your test did, and you can keep unrelated history you grafted to
the back of your real root commit.

For the "clone without propagating grafts" issue, I think we
need to have a way to communicate grafts across repositories.
As you say, grafts is a local policy issue, but when you start
cloning you _are_ sharing that local policy across repositories.
Futzing fsck to honor and ignore grafts at the same time sounds
like a band-aid to me.
