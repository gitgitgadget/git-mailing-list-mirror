From: Jeff King <peff@peff.net>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 14:19:31 -0500
Message-ID: <20080225191931.GA19666@sigill.intra.peff.net>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <20080225183413.GA15131@sigill.intra.peff.net> <vpqoda43lva.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:20:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTis1-00026m-UJ
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779AbYBYTTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756721AbYBYTTg
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:19:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4368 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756332AbYBYTTf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:19:35 -0500
Received: (qmail 12158 invoked by uid 111); 25 Feb 2008 19:19:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 25 Feb 2008 14:19:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2008 14:19:31 -0500
Content-Disposition: inline
In-Reply-To: <vpqoda43lva.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75050>

On Mon, Feb 25, 2008 at 07:57:13PM +0100, Matthieu Moy wrote:

> Yes, but a sane default address to send to can be given by the
> repository you make your original clone from.
>
> The really nice thing with the way darcs does it is that it makes it
> extremely easy for an occasional contribution. If the maintainer
> configured his stuff correctly, it's really "darcs get; ... ; darcs
> record; darcs send". git-send-email is nice, but harder to use for a
> first-timer.

I agree that this is useful, especially for smaller projects where it
really _is_ just one address.

> >   - this information could be shipped as part of the repo (i.e., under
> >     version control like the rest of the project, as it changes with the
> >     project)
> 
> True, but for the case of multiple maintainers, that would break
> merging between maintainers on that particular part.
> 
> You can have a maintainer A advertizing for A@domain.com, and a
> "sub-maintainer" B advertizing for B@domain.com. If A merges from B,
> he doesn't want his advertized adress to become the one of B.

I think there are advantages and drawbacks to both methods.
Version-controlled information is better for a project that has multiple
official maintainers, and those maintainers want to submit a patch
saying "and here's my contacat information." But it's worse for people
who are saying "here's somebody else's repo with my patches, but email
me about it".

Worse, you may want to do either in a particular repo, depending on what
your patches are. If I publish a repo with patches on top of git.git,
then you want to email me for patches specific to my repo, but probably
the regular git list and subsystem maintainers for patches that are
generally applicable.

So I'm not sure you will be able to write a tool that will always just
do the right thing.

> >   - this information can potentially be inferred from git shortlog
> >     and/or blame; this addresses the problem of data becoming stale
> 
> Yes and no. git@vger.kernel.org won't appear anywhere in these for
> example.

Yes, there would need to be some tool that combines:
  - per-repo patch submitting policy (i.e., mail me because I am your
    upstream)
  - per-project patch submitting policy (i.e., mail git@vger for git
    patches)
  - per-patch policy (e.g., this patch touches foo.c: who is
    interested in foo.c?)

-Peff
