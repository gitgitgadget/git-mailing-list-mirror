From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Mon, 2 Dec 2013 15:47:15 -0500
Message-ID: <20131202204715.GA18842@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <20131114124432.GJ10757@sigill.intra.peff.net>
 <87siuedhvj.fsf@thomasrast.ch>
 <20131202161208.GB24202@sigill.intra.peff.net>
 <xmqqk3fnq9bh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 21:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnaOr-0005aP-4w
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 21:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115Ab3LBUrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 15:47:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:49245 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757164Ab3LBUrS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 15:47:18 -0500
Received: (qmail 8635 invoked by uid 102); 2 Dec 2013 20:47:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Dec 2013 14:47:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Dec 2013 15:47:15 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk3fnq9bh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238652>

On Mon, Dec 02, 2013 at 12:36:34PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do wonder if at some point we should revisit our "do not use any
> > C99-isms" philosophy. It was very good advice in 2005. I don't know how
> > good it is over 8 years later (it seems like even ancient systems should
> > be able to get gcc compiled as a last resort, but maybe there really are
> > people for whom that is a burden).
> 
> Well, we are not kernel where being able to precisely control
> generated machine code matters and enforcement of acceptable
> compiler versions to achieve that goal is warranted, so I'd prefer
> to avoid anything that tells the users "go get a newer gcc".

Sorry, I was not very clear about what I said. I do not think "go get a
newer gcc" is a good thing to be telling people. But I wonder:

  a. if there are actually people on systems that have pre-c99 compilers
     in 2013

  b. if there are, do they actually _use_ the ancient system compiler,
     and not just install gcc as the first step anyway?

In other words, I am questioning whether we would have to tell anybody
"go install gcc" these days. I'm not sure of the best way to answer that
question, though.

> There are certain things outside C89 that would make our code easier
> to read and maintain (e.g. named member initialization of
> struct/union, cf. ANSI C99 s6.7.9, just to name one) that I would
> love to be able to use in our codebase, but being able to leave an
> extra comma at the list of enums is very low on that list.

Yes, I can live without trailing commas. I was musing more on the
general issue (of course, we don't _have_ to take C99 as a whole, and
can pick and choose features that even pre-C99 compilers got right, but
I was wondering mainly when it would be time to say C99 is "old enough"
that everybody supports it).

-Peff
