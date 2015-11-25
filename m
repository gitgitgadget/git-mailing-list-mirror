From: Jeff King <peff@peff.net>
Subject: Re: [RFC] rename detection: allow more renames
Date: Wed, 25 Nov 2015 07:36:25 -0500
Message-ID: <20151125123625.GA4504@sigill.intra.peff.net>
References: <20151113163506.GD16219@inner.h.apk.li>
 <20151124233328.GA13872@sigill.intra.peff.net>
 <20151125120315.GC11192@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 13:36:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ZJJ-0005Bm-CD
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 13:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbbKYMgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 07:36:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:33860 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751428AbbKYMga (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 07:36:30 -0500
Received: (qmail 8906 invoked by uid 102); 25 Nov 2015 12:36:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 06:36:30 -0600
Received: (qmail 26313 invoked by uid 107); 25 Nov 2015 12:36:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 07:36:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 07:36:25 -0500
Content-Disposition: inline
In-Reply-To: <20151125120315.GC11192@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281707>

On Wed, Nov 25, 2015 at 01:03:15PM +0100, Andreas Krey wrote:

> On Tue, 24 Nov 2015 18:33:28 +0000, Jeff King wrote:
> ...
> > I didn't dig in the archive, but I think we discussed the "just show
> > progress for destinations" before. The problem you run into is that the
> > items aren't a good indication of the amount of work. You really are
> > doing n*m work, so if you just count "m", it can be very misleading if
> > "n" is high (and vice versa).
> 
> True, but the loops do progress indication for destinations only anyway.
> So if you only have three destinations and a zillion sources, you
> will still get only three progress updates, even if they say
> 'one zillion (33%)', 'two zillion (67%)', ...
> 
> I think as long as this is the case we can as well report the destination
> count; maybe put the source count somewhere in the progress text.

Ah, true. Though maybe that is something we should be fixing, rather
than building on. I dunno. I cannot recall the last time I saw rename
detection progress myself.

> > Might it make more sense just to move to a larger integer size?
> 
> Which would be? I'd venture into the progress code to identify
> the necessary changes.

I was thinking of uint64_t; the progress code would need to change, but
I don't see a big problem with that.

> We're somewhat close to getting there. The rename detection runs
> for several minutes in our cases.

Yikes. :)

-Peff
