From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use "-script" postfix for scripts
Date: Fri, 12 Aug 2005 08:32:08 -0700
Message-ID: <7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 17:33:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3bW3-00073U-PL
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 17:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVHLPcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 11:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVHLPcN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 11:32:13 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16817 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750833AbVHLPcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 11:32:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812153209.RQTM17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 11:32:09 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 12 Aug 2005 15:28:27 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For consistency reasons, the names of all scripts should end in "-script".
>
> This may be a bit controversial (people might find it unnecessary). 
> Subject to discussion.

I have never liked the original -script name convention.  It
only meant that they are implemented as scripts (as opposed to
those on the $(PROG) Makefile variable), but the end users who
end up typing their names from the command line, and to a lesser
degree the people who use them in their scripts, should not care
how they are implemented to begin with.

And to cope with long names and make things look a bit more
familiar to CVS migrants, "git" wrapper was invented to supply
the -script suffix to grok "git whatever", but just in case if
something was _not_ implemented as a script, it ends up needing
to try "git-whatever" in addition to "git-whatever-script".  The
patch alleviates the "git" problem for "git-whatchanged" and
friends whose names currently do not end with -script, but it
still does not help "git apply", for example.  I like the
general direction of making things consistent, but I wonder if
we can become consistent by losing -script suffix, not adding to
the ones that lack it.

And as you imply, this kind of change inevitable breaks people's
scripts.  But I do agree with you that we should do something
about it, so it may be better to break them sooner rather than
later, as long as we make sure we break them just once.
