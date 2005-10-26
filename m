From: Junio C Hamano <junkio@cox.net>
Subject: Re: Towards CVS code-exchange and gateways
Date: Tue, 25 Oct 2005 17:25:00 -0700
Message-ID: <7vr7a9azvn.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510251357l23886747s8024a4326ad4e392@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 02:26:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUZ6K-00060A-48
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 02:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVJZAZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 20:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVJZAZE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 20:25:04 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35579 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932505AbVJZAZC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 20:25:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026002439.KCQL4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 20:24:39 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510251357l23886747s8024a4326ad4e392@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 26 Oct 2005 09:57:14 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10642>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Is there anyone working on a git -> cvs gateway or similar scripts?

Working on, no, but I was thinking about something like that at
work (today is my non-git day but I use git on top of CVS to
track my private changes in my CVS work tree which is my git
repo there).

I maintain at 'cvs' and 'master' branch (and other git branches)
there, and always 'git-checkout cvs' before doing 'cvs update',
and do 'git-commit' to slurp in the changes to the cvs side.
Then 'git checkout master ; git pull . cvs' to sync the master
side, work on a bit, commit.  Showing what I've done to the CVS
side, currently I do something like this:

      $ git-checkout cvs
      $ git pull . master
      $ git log ORIG_HEAD.. >L
      $ cvs commit -F L

This isn't that bad because I do not care much about how the
development history on the CVS side looks like.  But propagating
each git commit separately to CVS side would be much better, and
what you outlined should work nicely.
