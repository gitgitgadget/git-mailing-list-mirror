From: Jeff King <peff@peff.net>
Subject: Re: propagating repo corruption across clone
Date: Mon, 25 Mar 2013 11:56:00 -0400
Message-ID: <20130325155600.GA18216@sigill.intra.peff.net>
References: <20130324183133.GA11200@sigill.intra.peff.net>
 <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net>
 <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
 <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff Mitchell <jeffrey.mitchell@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 16:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK9lC-00014T-72
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 16:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565Ab3CYP4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 11:56:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39051 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758527Ab3CYP4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 11:56:04 -0400
Received: (qmail 25334 invoked by uid 107); 25 Mar 2013 15:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Mar 2013 11:57:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2013 11:56:00 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219039>

On Mon, Mar 25, 2013 at 10:31:04PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Mon, Mar 25, 2013 at 9:56 PM, Jeff King <peff@peff.net> wrote:
> > There are basically three levels of transport that can be used on a
> > local machine:
> >
> >   1. Hard-linking (very fast, no redundancy).
> >
> >   2. Byte-for-byte copy (medium speed, makes a separate copy of the
> >      data, but does not check the integrity of the original).
> >
> >   3. Regular git transport, creating a pack (slowest, but should include
> >      redundancy checks).
> >
> > Using --no-hardlinks turns off (1), but leaves (2) as an option.  I
> > think the documentation in "git clone" could use some improvement in
> > that area.
> 
> Not only git-clone. How git-fetch and git-push verify the new pack
> should also be documented. I don't think many people outside the
> contributor circle know what is done (and maybe how) when data is
> received from outside.

I think it's less of a documentation issue there, though, because they
_only_ do (3). There is no option to do anything else, so there is
nothing to warn the user about in terms of tradeoffs.

I agree that in general git's handling of corruption could be documented
somewhere, but I'm not sure where.

-Peff
