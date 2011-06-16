From: Jeff King <peff@github.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Thu, 16 Jun 2011 14:57:39 -0400
Message-ID: <20110616185739.GA13616@sigill.intra.peff.net>
References: <20110616003800.GC20355@sigill.intra.peff.net>
 <7v39jai94h.fsf@alter.siamese.dyndns.org>
 <20110616065146.GA30672@sigill.intra.peff.net>
 <20110616075621.GA12413@arachsys.com>
 <20110616174653.GD6584@sigill.intra.peff.net>
 <7vtybphcym.fsf@alter.siamese.dyndns.org>
 <20110616182149.GB12689@sigill.intra.peff.net>
 <7vpqmdhb3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Webb <chris@arachsys.com>,
	Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:57:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXHlE-0001DI-Q9
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339Ab1FPS5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 14:57:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55033
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559Ab1FPS5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 14:57:41 -0400
Received: (qmail 16443 invoked by uid 107); 16 Jun 2011 18:57:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 14:57:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 14:57:39 -0400
Content-Disposition: inline
In-Reply-To: <7vpqmdhb3q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175916>

On Thu, Jun 16, 2011 at 11:42:17AM -0700, Junio C Hamano wrote:

> Jeff King <peff@github.com> writes:
> 
> > Also, since it's easy via the external helper route, should there be any
> > other builtin formats? Bzip2? It's not that big a deal for a big hosting
> > site like kernel.org to stick it in their configuration, but I wonder if
> > normal users would find it useful.
> 
> I know k.org statically prepares *.bz2 for any *.gz in /pub/software/
> hierarchy, but isn't bzip2 significantly more expensive (like taking ten
> times as much memory or four times as much CPI time to squeeze the last
> extra 15% out), making it unsuitable for one-shot online use?

I will let J.H. comment on how appropriate that is for k.org; he is the
one who mentioned bzip2 in the first place earlier in the thread.

Even if kernel.org wants it, it is a departure from what we now, though.
People who set up remote upload-archive access long ago and upgrade git
would now suddenly let anyone convince their machines to chew up a lot
of CPU. I don't mind too much doing it for gzip, which takes roughly the
same amount of time as zip, which already exists. Silently adding other
formats may be worse, though.

At the same time, it would be nice for people running git-archive
locally to avoid having to configure a bzip2 filter manually. Maybe
upload-archive should ignore these filters by default, and require a
special config variable to enable them?

-Peff
