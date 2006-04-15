From: Junio C Hamano <junkio@cox.net>
Subject: log/diff option parsing unification
Date: Sat, 15 Apr 2006 05:04:40 -0700
Message-ID: <7vk69rgi3r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 14:04:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUjWD-0006qY-MH
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 14:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWDOMEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 08:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWDOMEm
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 08:04:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27585 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932500AbWDOMEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 08:04:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415120441.OUQS18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 08:04:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18743>

Linus,

I kept your log/diff option parsing stuff with a few fixups for
about 3 hours in the "next" branch, but dropped and replaced
them with an alternative with lesser impact.  I freely admit
that what you write is nicer and cleaner than what I do 99.9% of
the time, but I think this time it is justified.  We have been
telling people that their scripts can expect certain output
format out of the lowest level Plumbing such as rev-list and
diff-tree.  I just do not want to break it, and doing things
with very unified way seemed to be too much hassle to keep
everything compatible.

On the other hand, I am much more relaxed if 'git-log' and
'git-whatchanged' output are not bit-for-bit identical to their
shell script versions.  You (not "Linus, you" but figuratively
you) would be crazy if you have been feeding their output to
your own scripts with such an expectation.  The rule-of-thumb I
apply here is that anything that has built-in pager is primarily
for human consumption, and the stability of its output format is
a fair game, especially when the modified behaviour results in
better output for humans.

I might regret this later when we try to do the internal "git
diff", but it is already tomorrow morning now, so I'll crash
first.

This option parsing unification will be post 1.3.0, but it is
important enough that I suspect it will be the first topic to be
merged and disrupt the "master" branch for a while after 1.3.0.
