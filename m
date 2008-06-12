From: Jeff King <peff@peff.net>
Subject: Re: To graft or not to graft... (Re: Recovering from repository
	corruption)
Date: Thu, 12 Jun 2008 03:47:53 -0400
Message-ID: <20080612074752.GA507@sigill.intra.peff.net>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com> <20080611232126.GA9054@cuci.nl> <alpine.LFD.1.10.0806111635200.3101@woody.linux-foundation.org> <200806120914.22083.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Denis Bueno <dbueno@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6hYB-0008AI-DL
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbYFLHr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbYFLHr5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:47:57 -0400
Received: from peff.net ([208.65.91.99]:3292 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878AbYFLHr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:47:57 -0400
Received: (qmail 15372 invoked by uid 111); 12 Jun 2008 07:47:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 12 Jun 2008 03:47:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2008 03:47:53 -0400
Content-Disposition: inline
In-Reply-To: <200806120914.22083.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84733>

On Thu, Jun 12, 2008 at 09:14:21AM +0200, Johan Herland wrote:

> > The grafts file isn't part of the object stream and refs, and clones (and
> > fetches) very much just copy the object database.
> 
> AFAICS, there's already a perfectly fine way to distribute grafted history:
> 1. Add a grafts file
> 2. Run git-filter-branch
> 3. Remove grafts file
> 4. Distribute repo
> 5. Profit!
> 
> Since git-filter-branch turns grafted parentage into _real_ parentage,
> there's no point in ever having a grafts file at all (except transiently
> for telling git-filter-branch what to do).

But then you have rewritten all of the later commits, so you can no
longer talk to other people about them.

The kernel repo is split into "historical" and active repos. You can
graft the historical repo and get more far-reaching answers to things
like "git log" and "git blame". But if you run filter-branch, you can't
share development on that repo via push / pull to people who _don't_ use
the graft, since they don't share your history (and they probably don't
want to, because of the extra resources required to pull in the
historical chunk).

That being said, I don't know how common such a setup is. And you did
mention a "follow-grafts" config option for such people.

-Peff
