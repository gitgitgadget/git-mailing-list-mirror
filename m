From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 19:58:52 -0500
Message-ID: <20071130005852.GA12224@coredump.intra.peff.net>
References: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:59:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuDr-0000Dn-1u
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbXK3A64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbXK3A64
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:58:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2172 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759614AbXK3A6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:58:55 -0500
Received: (qmail 30685 invoked by uid 111); 30 Nov 2007 00:58:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 19:58:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 19:58:52 -0500
Content-Disposition: inline
In-Reply-To: <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66586>

On Thu, Nov 29, 2007 at 04:49:26PM -0800, Junio C Hamano wrote:

> I understand your point was primarily "git-a<tab>".  I think it has been
> solved for bash and zsh but not for other shells.  I think possible and
> sensible avenues are (1) punt -- cvs, svn nor hg people do not seem to
> have problem with it, or (2) implement completion in your other favorite
> shells.

My point is that (2) is already implemented for every program (shell or
no) which understands filename completion, and there is a proposal for
taking it away. I would consider that, except I haven't see any claimed
advantages except that the hardlinks are awful under Windows.

I am proposing to have those dashed forms on platforms where it makes
sense, but to treat them as second-class citizens (by putting them in
$(libexecdir), which will address consistency problems.

> And I think the following from Linus makes sense.
> 
> > And from a consistency standpoint, that would be a *good* thing. There are 
> > many reasons why the git-xyz format *cannot* be the "consistent" form
> > (ranging from the flags like --bare and -p to just aliases), so 
> > encouraging people to move to "git xyz" is just a good idea.
> >
> > Yeah, yeah, the man-pages need the "git-xyz" form, but on the other hand, 
> > rather than "man git-xyz", you can just do "git help xyz" instead, and now 
> > you're consistently avoiding the dash again!
> 
> but I am feeling quite feverish today so I may be missing something
> obvious.

I thought Linus' point was that moving the subcommands was sufficient
for dealing with the consistency issue (i.e., all scripts would move to
"git foo" and only those people who really wanted to would put the
dashed forms in their path). From the same email you quoted, but just
above:

> On Thu, 29 Nov 2007, Jeff King wrote:
> >
> > Yes, I am fine with the user having to go to extra lengths to use the
> > dash forms (like adding $(libexecdir) to their path), which I think
> > should address your consistency concern.
> 
> I agree. If we actually start moving the subcommands into a separate
> directory, I suspect scripts will be fixed up soon enough. Of course
> people *can* do it by just adding the path, but more likely, we'll just
> see people start doign "git xyz" instead of "git-xyz".

But now we are arguing about what Linus meant like it is scripture. ;)

-Peff
