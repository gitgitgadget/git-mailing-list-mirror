From: Jeff King <peff@peff.net>
Subject: Re: Pushing with --mirror over HTTP?
Date: Mon, 19 Dec 2011 12:12:11 -0500
Message-ID: <20111219171211.GA20844@sigill.intra.peff.net>
References: <20068.19089.303108.950233@winooski.ccs.neu.edu>
 <20110907213950.GI13364@sigill.intra.peff.net>
 <20072.12104.965815.994761@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Dec 19 18:12:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcgl9-0000A2-OK
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 18:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab1LSRMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 12:12:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45909
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab1LSRMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 12:12:14 -0500
Received: (qmail 397 invoked by uid 107); 19 Dec 2011 17:18:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 12:18:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 12:12:11 -0500
Content-Disposition: inline
In-Reply-To: <20072.12104.965815.994761@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187460>

On Wed, Sep 07, 2011 at 10:58:16PM -0400, Eli Barzilay wrote:

> 5 hours ago, Jeff King wrote:
> > On Mon, Sep 05, 2011 at 12:05:37AM -0400, Eli Barzilay wrote:
> > 
> > > Is there anything broken with pushing with mirror over HTTP?  I'm
> > > trying that with a github url, and I get a broken-looking error
> > > message:
> > > 
> > >   remote part of refspec is not a valid name in :.have
> > 
> > It's probably nothing to do with http, but rather with alternate
> > object databases on the server (which GitHub uses heavily). The
> > server hands out fake ".have" refs telling you it has some other
> > branch tips to base packs off of. So I suspect the "push --mirror"
> > code is simply wrong for trying to update those refs (it may be
> > exacerbated by using http, though, as the remote helper code seems
> > to have some extra checks).

Sorry for the very delayed response on your bug, but at least I have
good news. :)

It should be fixed by:

  http://article.gmane.org/gmane.comp.version-control.git/187373

(I was trying to fix another bug there, but see my followup for a
discussion of .have).

-Peff
