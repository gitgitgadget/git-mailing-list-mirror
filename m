From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 08:57:58 -0700
Message-ID: <7vejx6k54p.fsf@assigned-by-dhcp.cox.net>
References: <20060625184757.f8273820.tihirvon@gmail.com>
	<E1FuX8l-0001H5-2z@moooo.ath.cx>
	<Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1FueYh-0004XE-Fg@moooo.ath.cx>
	<20060629222009.GA9310@cip.informatik.uni-erlangen.de>
	<7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
	<7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
	<E1FwDiI-0007Xp-2s@moooo.ath.cx>
	<7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
	<E1FwGgm-0006Nc-9a@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 17:58:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwLNg-00078O-Bz
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 17:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWF3P6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 11:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWF3P6A
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 11:58:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:12434 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932219AbWF3P6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 11:58:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630155759.DHPA27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 11:57:59 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FwGgm-0006Nc-9a@moooo.ath.cx> (Matthias Lederhofer's message
	of "Fri, 30 Jun 2006 12:57:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22995>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano wrote:
>> I see you are trying hard to think of a way to justify your
>> original prefix "--and" (or --FOO) implementation, but I simply
>> do not see much point in that.  I doubt changing the default
>> operator from --or to --and is less confusing than changing the
>> precedence for the users, so you would hear the same "I
>> personally feel FOO should not even exist" objection from me.
>
> It just happens to make more sense to me and I don't see a reason not to
> add this. If no one else is interested in this I'll just stop arguing :)
> Here again an overview of the arguments if anyone is interested:
> - Less to type for common searches using only AND (or more ANDs than
>   ORs).
> - Easy to implement (both with and without extended expressions).
> - AND/* is the normal implicit operator in other contexts than grep
>   (math).
> - The high precedence operator (AND) should be implicit rather than
>   the low precedence one (OR) (so this is only fulfilled when the
>   option is used).

Side note.  It would be interesting to have a slightly different
form of --and called --near.  You would use it like this:

	git grep -C -e AND --near -e OR

to find lines that has AND on it, and within the context
distance there is a line that has OR on it.  The lines that are
hit with such a query are still the ones that have AND on them
(in other words, a line that has OR is used to further filter
out the results so it will be prefixed with '-', not ':', unless
that line happens to also have AND on it).

With your syntax perhaps this is spelled as "--near -C -e AND -e
OR".
