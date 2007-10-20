From: Jeff King <peff@peff.net>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:31:17 -0400
Message-ID: <20071020063117.GB30388@coredump.intra.peff.net>
References: <1192859753.13347.147.camel@g4mdd.entnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: Ari Entlich <lmage11@twcny.rr.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:31:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7rv-0005n2-Jl
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbXJTGbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbXJTGbU
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:31:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2298 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbXJTGbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:31:20 -0400
Received: (qmail 18968 invoked by uid 111); 20 Oct 2007 06:31:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 20 Oct 2007 02:31:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2007 02:31:17 -0400
Content-Disposition: inline
In-Reply-To: <1192859753.13347.147.camel@g4mdd.entnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61792>

On Sat, Oct 20, 2007 at 01:55:53AM -0400, Ari Entlich wrote:

> git-stash has been suggested to me numerous times, but I really feel
> that there's no need to use it in this case - if the git mv command gave
> adequate control to the user, it would be unnecessary.

Yes, now that I understand what you're doing, git-stash is probably
overkill. It's great if you really want to put aside your current state
and do some other, totally unrelated work.

But in this case, you are talking about tools for managing the index
correctly, which is a totally different use case.

> > git mv --cached foo bar
> Are you talking about REALLY only changing the index? I can't think of
> why you'd want to do this either... After all, wouldn't there be no bar
> file to do git add --interactive on? In addition, I don't think giving
> --interactive a filename is meaningful...

Originally I had thought git-mv --cached would be useful (and a nice
orthogonal design), but it really _does_ seem useless, since it's
awkward to get your working tree changes into the index without actually
moving the working tree file.

> It might be interesting to do some sort of survey of whether people
> depend on this behavior. It seems pretty inconsistent with how git works
> otherwise, and I'd be surprised if a lot of people expect it (kinda like
> the Spanish Inquisition :-P).

The best way to get comments is to make a patch.

As for inconsitency of git-mv, it has always been a bit of an odd duck.
I'm fairly certain neither Linus nor Junio actually use it, preferring
instead to make all changes to the working tree and then update the
index manually. I even seem to recall Linus arguing that git-mv was
stupid and unnecessary a long time ago, but I could be wrong.

-Peff
