From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add a diff-files command
Date: Thu, 28 Apr 2005 09:34:25 -0700
Message-ID: <7vr7gu97xq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0504271701080.14033@localhost.localdomain>
	<7vr7gvevpv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0504272031330.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 18:30:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRBsz-000642-Fq
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 18:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVD1Qei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 12:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVD1Qei
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 12:34:38 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:155 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262159AbVD1Qe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 12:34:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428163427.WXOE22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 12:34:27 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0504272031330.14033@localhost.localdomain> (Nicolas
 Pitre's message of "Wed, 27 Apr 2005 21:02:48 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

Having thought about it more, although I praise your enthusiasm
to improve git, I suspect your diff-files is a solution to a
problem that does not exist.

NP> It also has the ability to accept exclude file patterns with
NP> -x and even a file containing a list of patterns to exclude
NP> with -X.  This is especially useful to use the famous
NP> dontdiff file when looking for uncommitted files in a
NP> compiled kernel tree.

If you want to see if working tree has some junk other than
those listed in dontdiff, wouldn't this be sufficient?

  $ show-files --others | grep -f dontdiff

NP> First, show-diff doesn't handle files in the work tree which
NP> are not listed in the cache.

That's the whole point of git (and show-diff).  If it is not
listed in the cache, it does not exist.

NP> ...  So trust me it _is_ pretty damn useful, unless you
NP> always run "make clean" on your kernel tree before checking
NP> for potentially uncommitted files then recompile everything
NP> afterwards which is a hassle.

Why do you need to "make clean"?  Is it because otherwise you
would get lots of output for things that are listed in dontdiff
but not listed in the cache, and the uncommitted but not listed
in dontdiff file that you care about would get lost in the
noise?

Earlier you complained show-diff does _not_ look at what are not
listed in the cache.  Now you want to exclude garbage that comes
out of it because you have tons of stuff that are not listed in
the cache, which implies show-diff _does_ look at what are not
listed in the cache.  Either you are contradicting yourself or I
am confused.

The truth is, as you said earlier, show-diff does not look at
them, so I do not understand what problem you are trying to
describe here.

Again, "checking for potentially uncommitted" files is what
you use show-files --others for, not show-diff.

