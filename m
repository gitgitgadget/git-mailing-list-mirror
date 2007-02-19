From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive.
Date: Mon, 19 Feb 2007 03:02:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702190257250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1171838852534-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702190126220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7iuedif9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 03:02:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIxr8-00023J-Cw
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 03:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbXBSCCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 21:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbXBSCCP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 21:02:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:59295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752710AbXBSCCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 21:02:14 -0500
Received: (qmail invoked by alias); 19 Feb 2007 02:02:13 -0000
X-Provags-ID: V01U2FsdGVkX19MhGlJCPdMbFZEqFl/dtgQBchZx84Fz6cqYVCcYu
	gV0Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v7iuedif9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40092>

Hi,

On Sun, 18 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Sorry to be such a PITA, but I really, really think that it is wrong to 
> > make a tar dependency here. You said your cygwin has problems with binary 
> > files. Could you please try this:
> >
> > 	$ echo -ne '\x1a\x1b\x15\x10\0abc' | cat | wc
> 
> It might be just me, but "echo -e" makes me feel much more
> uneasy than explicitly saying "Sorry, we require GNU tar in
> this little corner of the system".

Hey, this was meant as a _test_ on why it fails for Mark, not as the end 
result!

> >> +            bfile=$1
> >
> > This can contain spaces (you are working on Windows, right? Windows users 
> > _love_ spaces in their filenames).
> 
> Which is fine.  Try var1=$var2 with something with SP or TAB in var2
> and later try running
> 
> 	$ echo "<$var1>"
> 
> to see what happens.

Okay, I did not know that.

> >> +    gitrevargs=$(git-rev-parse --symbolic --revs-only $args) || exit 1
> >
> > Here, you rely again on the refs not containing spaces.
> 
> Which probably is fine, as refs cannot contain spaces ;-).

Ah! As we allow so many things in refnames, I assumed that spaces are 
allowed also.

> >> +    # git-rev-list cannot determine edge objects if a date restriction is
> >> +    # given...  we do things a slow way if max-age or min-age are given
> >
> > Might make sense to teach max-age about boundary commits instead...
> 
> You are talking about a rather extensive change, but could be
> done.  But that is a separate issue, I think.

I don't think it's so hard.

Ciao,
Dscho
