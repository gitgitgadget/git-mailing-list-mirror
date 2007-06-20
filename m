From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stupid quoting...
Date: Tue, 19 Jun 2007 23:19:39 -0700
Message-ID: <7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org>
	<86ir9l1ylc.fsf@lola.quinscape.zz>
	<Pine.LNX.4.64.0706190156110.4059@racer.site>
	<86sl8owfqj.fsf@lola.quinscape.zz>
	<Pine.LNX.4.64.0706191048570.4059@racer.site>
	<86645kutow.fsf@lola.quinscape.zz>
	<Pine.LNX.4.64.0706200307070.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 20 08:19:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0tXb-0000TZ-7m
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 08:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758714AbXFTGTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 02:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759505AbXFTGTm
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 02:19:42 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48663 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758423AbXFTGTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 02:19:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620061940.TRCX2558.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 Jun 2007 02:19:40 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DiKf1X0071kojtg0000000; Wed, 20 Jun 2007 02:19:40 -0400
In-Reply-To: <Pine.LNX.4.64.0706200307070.4059@racer.site> (Johannes
	Schindelin's message of "Wed, 20 Jun 2007 03:19:54 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50536>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I don't see our discourse leading anywhere: the points have been made.
>
> I would really, really, really like to see a solution. Alas, I cannot 
> think of one, other than _forcing_ the developers to use ASCII-only 
> filenames.
>
> Note that there is no convention yet in Git to state which encoding your 
> filenames are supposed to use. And in fact, we already had a fine example 
> in git.git why this is particularly difficult. MacOSX is too clever to be 
> true, in that it gladly takes filenames in one encoding, but reads those 
> filenames out in _another_ encoding. Thus, a "git add <filename>" can well 
> end up in git-status saying that a file was deleted, and another file 
> (actually the same, but in a different encoding) is untracked.

By the way, the pathname quoting done by "diff" does not even
attempt to tackle that.  I already explained why in the thread
so I would not repeat myself.

Having said that, the absolute minimum that needs to be quoted
are double-quote (because it is used by quoting as agreed with
GNU diff/patch maintainer), backslash (used to introduce C-like
quoting), newline and horizontal tab (makes "patch" confused, as
it would make it ambiguous where the pathname ends), so I am not
opposed to a patch that introduces a new mode, probably on by
default _unless_ we are generating --format=email, that does not
quote high byte values.  That would solve "My UTF-8 filenames
are unreadable on my terminal" problem.
