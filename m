From: Jeff King <peff@peff.net>
Subject: Re: Blobs not referenced by file (anymore) are not removed by GC
Date: Tue, 9 Dec 2014 11:11:33 -0500
Message-ID: <20141209161133.GA17756@peff.net>
References: <5485D03F.3060008@fu-berlin.de>
 <20141209141457.GA18544@peff.net>
 <CAFY1edaEG040jnfTJA4G9a0bAkFJHc3N5sHjtwOOdXmndsu9YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Scherer <m.scherer@fu-berlin.de>, git@vger.kernel.org
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 17:11:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyNO0-0003jU-QJ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 17:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbaLIQLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 11:11:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:50522 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753971AbaLIQLg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 11:11:36 -0500
Received: (qmail 6474 invoked by uid 102); 9 Dec 2014 16:11:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 10:11:36 -0600
Received: (qmail 1192 invoked by uid 107); 9 Dec 2014 16:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 11:11:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 11:11:33 -0500
Content-Disposition: inline
In-Reply-To: <CAFY1edaEG040jnfTJA4G9a0bAkFJHc3N5sHjtwOOdXmndsu9YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261129>

On Tue, Dec 09, 2014 at 04:01:50PM +0000, Roberto Tyley wrote:

> > I also don't know if BFG keeps backup refs around (filter-branch, for
> > example, writes a copy of the original refs into refs/original; you
> > would want to delete that if you're trying to slim down the repo).
> 
> The BFG reports the ref changes to the command line (and outputs a
> full list of changed object-ids in
> repo-name.git.bfg-report/[datetime]/object-id-map.old-new.txt) but
> doesn't keep refs (like refs/original) around because that would get
> in the way of the BFG's explicit intended use-case of removing
> unwanted data.

Thanks for explaining; that information may come in handy.

I actually think filter-branch's "refs/original" is a bit outdated at
this point. The information is there in the reflogs already, and
dealing with refs/original often causes confusion in my experience. It
could probably use a "git filter-branch --restore" or something to
switch each $ref to $ref@{1} (after making sure that the reflog entry
was from filter-branch, of course).

Not that I expect you to want to work on filter-branch. :) But maybe
food for thought for a BFG feature.

-Peff
