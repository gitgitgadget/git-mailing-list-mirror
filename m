From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: quote TRASH_DIRECTORY
Date: Fri, 4 Mar 2016 08:09:39 -0500
Message-ID: <20160304130939.GA15375@sigill.intra.peff.net>
References: <cover.1457088499.git.git@drmicha.warpmail.net>
 <a07529d116612bcd1c411a697f8f8e37d7c18d3f.1457088499.git.git@drmicha.warpmail.net>
 <20160304115127.GA8355@sigill.intra.peff.net>
 <56D98793.9000708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 14:09:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abpUR-0006Nn-PR
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 14:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582AbcCDNJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 08:09:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:54723 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758520AbcCDNJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 08:09:42 -0500
Received: (qmail 2068 invoked by uid 102); 4 Mar 2016 13:09:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 08:09:41 -0500
Received: (qmail 15295 invoked by uid 107); 4 Mar 2016 13:09:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 08:09:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2016 08:09:39 -0500
Content-Disposition: inline
In-Reply-To: <56D98793.9000708@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288256>

On Fri, Mar 04, 2016 at 02:03:15PM +0100, Michael J Gruber wrote:

> >> -test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
> >> +test ! -z "$debug" || remove_trash="$TRASH_DIRECTORY"
> > 
> > I don't think this does anything. The shell doesn't do whitespace
> > splitting on the right-hand side of a variable assignment:
> > 
> >   $ foo='lots of spaces and "!'\'' funky chars'
> >   $ bar=$foo
> >   $ echo "$bar"
> >   lots of spaces and "!' funky chars
> > 
> > Of course we _do_ need quotes when we refer to $remove_trash as an
> > argument (as with "$bar" above), but it looks like we do so correctly
> > everywhere.
> 
> I'm used to that behavior, yes, but:
> 
> - Is this true for every shell that we support?

It better be, because we rely on it all through our scripts. :)

But yes, it is in POSIX, and I think any shell which did not respect it
would be broken enough to be unusable (I don't have a copy of Solaris
/bin/sh handy, but that's usually our go-to for "unusably broken").

> - Having quotes there, too, is a good reminder to have it also where
> necessary.

We do already quote variable assignments unnecessarily in lots of
places, so I don't mind it too much (it's definitely not _wrong_ to do
so).

-Peff
