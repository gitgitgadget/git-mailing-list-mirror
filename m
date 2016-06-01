From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Wed, 1 Jun 2016 12:58:43 -0400
Message-ID: <20160601165843.GA11464@sigill.intra.peff.net>
References: <20160601023159.GA5411@sigill.intra.peff.net>
 <20160601033139.GB5411@sigill.intra.peff.net>
 <20160601034413.GC5411@sigill.intra.peff.net>
 <20160601053325.GA20797@sigill.intra.peff.net>
 <20160601054048.GB20797@sigill.intra.peff.net>
 <xmqqshwx1k0p.fsf@gitster.mtv.corp.google.com>
 <20160601070425.GA13648@sigill.intra.peff.net>
 <xmqqfusx0wyj.fsf@gitster.mtv.corp.google.com>
 <20160601160735.GB9219@sigill.intra.peff.net>
 <xmqqfuswzw2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:58:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Tr-0006ra-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbcFAQ6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:58:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:47358 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750842AbcFAQ6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:58:46 -0400
Received: (qmail 18212 invoked by uid 102); 1 Jun 2016 16:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 12:58:45 -0400
Received: (qmail 2726 invoked by uid 107); 1 Jun 2016 16:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 12:58:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 12:58:43 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfuswzw2l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296135>

On Wed, Jun 01, 2016 at 09:57:06AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Maybe:
> >
> >     We sometimes get around this by using env, like:
> >
> >       test_must_fail env FOO=BAR some-program
> >
> >     But that works for test_must_fail because it further runs its
> >     arguments via the shell, so we can stick the "env" on the right-hand
> >     side of the function. It would not work to do:
> >
> >       env FOO=BAR test_must_fail some-program
> >
> >     because env does not know about our shell functions...
> >
> > is more clear?
> 
> I don't know.  What I wanted to say was that "test_must_fail env"
> pattern works _only_ when some-program is not a shell function, even
> though "test_must_fail some-program" itself without env is OK when
> some-program is a shell function.

Right, but I think that is taking it to a meta-level. We are already
talking about one shell function, test_must_fail versus test_commit.
Introducing another one in the test_must_fail to the right of "env"
obviously does not work, but that is independent of whether
test_must_fail is in use.

-Peff
