From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 3/3] ident: cleanup wrt ident's source
Date: Fri, 5 Feb 2016 14:24:13 -0500
Message-ID: <20160205192413.GB7245@sigill.intra.peff.net>
References: <1454658148-3031-1-git-send-email-alonid@gmail.com>
 <1454658148-3031-4-git-send-email-alonid@gmail.com>
 <xmqqsi17c70w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Dan Aloni <alonid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:24:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRlzQ-0007Cq-CI
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbcBETYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:24:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:38313 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751411AbcBETYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:24:15 -0500
Received: (qmail 28865 invoked by uid 102); 5 Feb 2016 19:24:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 14:24:15 -0500
Received: (qmail 17348 invoked by uid 107); 5 Feb 2016 19:24:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 14:24:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2016 14:24:13 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsi17c70w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285597>

On Fri, Feb 05, 2016 at 11:05:19AM -0800, Junio C Hamano wrote:

> Dan Aloni <alonid@gmail.com> writes:
> 
> > This change condenses the variables that tells where we got the user's
> > ident into single enum, instead of a collection of booleans.
> >
> > In addtion, also have {committer,author}_ident_sufficiently_given
> > directly probe the environment and the afformentioned enum instead of
> > relying on git_{committer,author}_info to do so.
> >
> > Signed-off-by: Dan Aloni <alonid@gmail.com>
> > Helped-by: Jeff King <peff@peff.net>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  ident.c | 126 ++++++++++++++++++++++++++++++++++++++++------------------------
> >  1 file changed, 80 insertions(+), 46 deletions(-)
> 
> Peff what do you think?  I am asking you because personally I do not
> find this particularly easier to read than the original, but since
> you stared at the code around here recently much longer than I did
> when doing the 1/3, I thought you may be a better judge than I am.

I'm not sure it is really worth it unless we are going to expose this to
the user, and let them say "I am OK with IDENT_SOURCE_GUESSED, but not
IDENT_SOURCE_GUESSED_BOGUS" or similar.

Without that, I think it is probably just making things a bit more
brittle.

-Peff
