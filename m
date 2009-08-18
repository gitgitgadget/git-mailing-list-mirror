From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] stash: accept options also when subcommand 'save'
 is omitted
Date: Tue, 18 Aug 2009 18:30:28 -0400
Message-ID: <20090818223028.GB31176@coredump.intra.peff.net>
References: <1250599567-31428-1-git-send-email-Matthieu.Moy@imag.fr>
 <vpqws51l1hb.fsf@bauges.imag.fr>
 <20090818174509.GA27518@coredump.intra.peff.net>
 <alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 00:30:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdXCO-0003Jl-Iq
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 00:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbZHRWa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 18:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbZHRWa1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 18:30:27 -0400
Received: from peff.net ([208.65.91.99]:34481 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbZHRWa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 18:30:27 -0400
Received: (qmail 13956 invoked by uid 107); 18 Aug 2009 22:30:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 Aug 2009 18:30:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Aug 2009 18:30:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0908182337200.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126474>

On Tue, Aug 18, 2009 at 11:42:58PM +0200, Johannes Schindelin wrote:

> > I think yours is nicer, especially as we have just added the
> > '-p|--patch' option, as well. With what is there now, you can do "git
> > stash -p", but not "git stash -p -k".
> 
> But it is sloppy, in that it blindly accepts options that might be valid 
> for several subcommands, not just "save".
> 
> That was the reason I did not implement it this way.
> 
> But we do not have such ambiguous options yet.
> 
> Or do we?  Look at what "list" accepts!
> 
> So please register my objection.

I don't see the problem. Either the option works for "stash save" or it
does not.  If I say "git stash --quiet", then it _must_ be "git stash
save --quiet", and not "git stash pop --quiet", because "save" is the
only default command.  If I say "git stash --foobar", it is translated
to "git stash save --foobar", which should generate an error (it doesn't
right now, but that is a separate issue). I don't see any confusion:
"save" is always the default command, unless one is given as the first
argument.

The place where I would see a potential problem is if stash grew any
"global" options (e.g., in the same way that "git" can take options
before its subcommand name).

-Peff
