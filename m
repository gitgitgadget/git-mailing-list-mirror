From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save'
 is omitted
Date: Tue, 18 Aug 2009 19:06:32 -0400
Message-ID: <20090818230632.GA4436@sigill.intra.peff.net>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr>
 <vpqws51l1hb.fsf@bauges.imag.fr>
 <20090818174509.GA27518@coredump.intra.peff.net>
 <alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de>
 <20090818223028.GB31176@coredump.intra.peff.net>
 <alpine.DEB.1.00.0908190041200.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 01:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdXlJ-0005t7-5l
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZHRXGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZHRXGd
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:06:33 -0400
Received: from peff.net ([208.65.91.99]:40903 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbZHRXGc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 19:06:32 -0400
Received: (qmail 15263 invoked by uid 107); 18 Aug 2009 23:06:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 18 Aug 2009 19:06:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 19:06:32 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908190041200.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126480>

On Wed, Aug 19, 2009 at 12:46:27AM +0200, Johannes Schindelin wrote:

> So if I say "git stash -q" by mistake, but wanted to say "git stash drop 
> -q", then I am borked?
> 
> Bah!  I say: bah!

Yep, though it is only one of many borkings that currently exist. Try:

  # oops, what was the name of that option?
  git stash save --index

  # does apply take --patch, too?
  git stash apply --patch

Still, other parts of the option parsing being awful aren't an excuse to
mess this one up. So I see your point.

> You're basically reintroducing at least part of the DWIMery that was 
> reverted in 9488e875 and I have the distinct feeling that some people in 
> this thread do not think hard enough about what would adher to the 
> principle of least surprise even in the future (or even for people 
> introducing other stash save options).

I don't think it is quite as bad as that, as arbitrary crap will not get
passed through, only crap that looks like options. Which is perhaps a
step up, but it is debatable how much.

I think Matthieu's proposal to be strict about matching the options, but
to take multiple options is probably the best bet for now. As it is now,
accepting "git stash -k" or "git stash -p" but not "git stash -k -p" is
pretty counterintuitive. But with explicit matching it should be no less
safe than it is now.

> Well, you just go ahead and push through your patch, and I do what I 
> promised on my blog.

I don't know why you need to be so confrontational. I don't even have a
patch to "push through". I just said "I don't see the problem", and I'm
glad you brought up the previous stash behavior, because I had forgotten
the pain it caused. And that is why discussing on a public forum is
nice; it lets people contribute things that others might have missed.

-Peff
