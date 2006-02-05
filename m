From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 05 Feb 2006 15:10:24 -0800
Message-ID: <7voe1le71b.fsf@assigned-by-dhcp.cox.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
	<7v64ntindq.fsf@assigned-by-dhcp.cox.net> <43E67745.2080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 06 00:10:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5t1g-0000DR-Ju
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 00:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWBEXKd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 18:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWBEXKd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 18:10:33 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49393 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750779AbWBEXKc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 18:10:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205230853.ZDKY20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 18:08:53 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <43E67745.2080302@gmail.com> (Marco Costalba's message of "Sun,
	05 Feb 2006 23:08:05 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15643>

Marco Costalba <mcostalba@gmail.com> writes:

> Because when, at last, you will switch the default to
> '--only', this option could be removed. So it's a temporary
> option with, peraphs, a temporary documentation, and a
> temporary user training to use it: IMHO has a meaning if the
> transition period is long enough.

Hmph, actually I was planning to leave --only in forever if we
go that route.  Peoples' scripts would need to explicitly ask
for --only during the transition if they want that semantics,
and removing that support afterwards would mean they would then
need to remove --only from their scripts again.

I was hoping that, once people get used to --include and --only,
they start to "revel in the index" (as Linus puts it), and
realize that defaulting to --only is not such a good idea after
all.  When that happens, I could leave --include as the
default without getting complaints from them ;-).

The net effect, if we end up doing so, would be that we gained
an extra flag --only that the user can use to explicitly ask for
a partial commit when they want one, without disrupting the
established workflow of old timers.

The --only semantics is a useful thing in many situations, while
the --include semantics is also a useful thing in many other
cases.  The latter might be a better match to the way the git
internal works, but both are equally useful options that support
different workflows.  I do not see an inherent reason to declare
one over the other to be "the default".  So we could instead
have no defaults at all (i.e. you have to explicitly say which
kind you want if you use paths...).
