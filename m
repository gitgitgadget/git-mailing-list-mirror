From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Fri, 03 Aug 2007 01:57:43 -0700
Message-ID: <7vir7xngfs.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
	<7v1wemxnkk.fsf@assigned-by-dhcp.cox.net>
	<vpqzm1a2l72.fsf@bauges.imag.fr>
	<7vy7gtvhgc.fsf@assigned-by-dhcp.cox.net>
	<20070803070407.GA17287@coredump.intra.peff.net>
	<7vr6mlnj4g.fsf@assigned-by-dhcp.cox.net>
	<20070803082435.GA15475@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 10:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGsyi-0007gq-O4
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 10:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbXHCI5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 04:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755714AbXHCI5p
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 04:57:45 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43855 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597AbXHCI5o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 04:57:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803085743.CMUJ14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 3 Aug 2007 04:57:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XLxj1X0041kojtg0000000; Fri, 03 Aug 2007 04:57:43 -0400
In-Reply-To: <20070803082435.GA15475@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 3 Aug 2007 04:24:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54694>

Jeff King <peff@peff.net> writes:

> Without making a partial commit, how would you split the
> bugfix changes from the working changes?  Or do you manually
> pull the bugfix into another branch or working tree?

I typically stash the WIP away with "git diff HEAD >P.diff &&
git reset --hard" (I should learn to use "git stash" these
days), and switch to an appropriate branch for bugfix (if it is
generally applicable) or stay on the branch (if it is a fix-up
for an earlier patch for the topic) to work on the fix.  Then
unstash to continue where I left off.

> In your workflow, how do you
> remind yourself that there are untracked files that need to be added? Do
> you just wait until you see the commit template at the end?

I do not leave files that need to be added untracked for a long
time.  Also, I tend to be picky about making sure that (1)
things build from scratch, and that (2) "make clean" removes all
crufts.  Because of this, I run "make clean" followed by "git
clean -n" more often than other people.  The latter picks them
up if I forget to add them when I created them.
