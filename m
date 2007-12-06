From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Soft aliases: add "less" and minimal documentation
Date: Wed, 5 Dec 2007 23:50:46 -0500
Message-ID: <20071206045046.GE5499@coredump.intra.peff.net>
References: <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <7vzlwps8zf.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0712051131120.27959@racer.site> <7vd4tlorho.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 05:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J08hY-0000qB-LO
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 05:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbXLFEut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 23:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbXLFEus
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 23:50:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2610 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbXLFEus (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 23:50:48 -0500
Received: (qmail 27629 invoked by uid 111); 6 Dec 2007 04:50:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 05 Dec 2007 23:50:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2007 23:50:46 -0500
Content-Disposition: inline
In-Reply-To: <7vd4tlorho.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67236>

On Wed, Dec 05, 2007 at 11:45:23AM -0800, Junio C Hamano wrote:

> I actually regret to have suggested "git less".  Not only because you
> can always say "git show" instead, but because the error message you
> would get with usage string will _not_ say "git-less", but some other
> command's name if you say "git less nonsense".
> 
> I on the other hand find the "view" alias moderately less problematic.
> As long as the future direction for the "view" alias is to allow it to
> notice user preference and launch something other than the default
> "gitk", iow, it is crystal clear that "git view" is just a short-hand
> for launching a history browser and the users are free to choose
> whichever viewer available, it won't feel inconsistent if underlying
> "gitk" barfed on malformed input using its own name.

The pattern I see here is that we get into trouble when we _pretend_
that builtin aliases are real commands, and not just handy shortcuts for
the real commands.

IOW, if a user is told that "git less" is the command to look at
objects, then they will:

  1. get confused when "git less" claims to be "git cat-file" or "git
     show" in error messages
  2. get confused when there is no "git less" manpage
  3. get confused when their coworker's "git less" behaves completely
     differently

OTOH, if a user is told that "git less" is an alias for the user's
preferred method for viewing objects, that the default is "git show",
and that they can customize it themselves using alias.less, then I don't
think any of the above will be surprising.

So I think it is a bad idea to use such aliases to satisfy user requests
for simple commands, even when they can obviously be implemented as such
an alias.

That being said...

> By extension to this reasoning, I am not too keen on adding "update",
> "up", "checkin", "ci", nor "co".  I do not think of any alternative

I think "checkin", "ci", and "co" are well-understood as aliases (and
will be doubly so if they are presented in the documentation as such).

After all, they come from CVS, which treats them this way:

$ cvs co
cvs checkout: No CVSROOT specified!  Please use the `-d' option
    ^^^^^^^^

-Peff
