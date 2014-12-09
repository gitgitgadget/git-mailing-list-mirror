From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 15:27:38 -0500
Message-ID: <20141209202738.GC12001@peff.net>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:27:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRNp-0007Eo-4C
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbaLIU1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:27:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:50708 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751075AbaLIU1k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:27:40 -0500
Received: (qmail 19714 invoked by uid 102); 9 Dec 2014 20:27:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 14:27:40 -0600
Received: (qmail 3754 invoked by uid 107); 9 Dec 2014 20:27:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 15:27:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 15:27:38 -0500
Content-Disposition: inline
In-Reply-To: <20141209201713.GY16345@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261161>

On Tue, Dec 09, 2014 at 12:17:13PM -0800, Jonathan Nieder wrote:

> Stefan Beller wrote:
> > On Tue, Dec 9, 2014 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> >> Perhaps the API doc that currently says "Free" is the only thing
> >> that needs fixing?  And perhaps add "See $doc" at the beginning of
> >> the header and remove duplicated comments we already have in the
> >> file?
> >
> > The reason I wrote this patch originally was because I seem to forget we have
> > more than one place to document our APIs. If there are comments in the header
> > I seem to have thought it were the only place where we have documentation.
> 
> How about this patch?
> 
> -- >8 --
> Subject: put strbuf API documentation in one place
> 
> v1.8.1-rc0~61^2 (strbuf_split*(): document functions, 2012-11-04)
> added some nice API documentation for a few functions to strbuf.h, to
> complement the documentation at Documentation/technical/api-strbuf.
> That was helpful because it meant one less hop for someone reading the
> header to find API documentation.
> 
> In practice, unfortunately, it is too hard to remember that there
> is documentation in two places.  The longer documentation comments
> in the header made Documentation/technical/api-strbuf less
> discoverable.  So move the information to
> Documentation/technical/api-strbuf and drop the long comments.
> 
> Hopefully in the long term we will find a good way to
> generate well organized Documentation/technical/api-* documents
> from comments in headers and this problem will be eliminated
> completely.
> 
> Short reminders in the header file are still okay.

I somewhat feel this goes in the opposite direction of where we want to
be (all data in one place, but that place is the header). Your patch
might make api-strbuf more discoverable, but it also vastly increases
the chances of function getting out of sync with their documentation, or
new functions being added without getting documented (very often the
presence of other documentation in the comments is enough to guilt me
into writing it for new ones).

Elsewhere I mentioned a tool to extract comments and format them. But do
people actually care about the formatting step? Does anybody asciidoc
the technical/api-* files? We did not even support building them until
sometime in 2012. Personally, I only ever view them as text.

In which case can we simply start migrating api-strbuf.txt into
in-header comments, without worrying about a parsing tool?

-Peff
