From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 15:36:39 -0400
Message-ID: <20120620193638.GA32418@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
 <20120620102750.GB4579@burratino>
 <20120620163714.GB12856@sigill.intra.peff.net>
 <20120620182855.GA26948@sigill.intra.peff.net>
 <CAFzf2Xw3TdvZCFLvbqKY5F9b+0hTzTQEEfmqjL9u=uvyc7mZ5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQhq-0000Z0-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939Ab2FTTgn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 15:36:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39155
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757919Ab2FTTgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:36:42 -0400
Received: (qmail 28366 invoked by uid 107); 20 Jun 2012 19:36:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 15:36:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 15:36:39 -0400
Content-Disposition: inline
In-Reply-To: <CAFzf2Xw3TdvZCFLvbqKY5F9b+0hTzTQEEfmqjL9u=uvyc7mZ5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200342>

On Wed, Jun 20, 2012 at 02:30:40PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
>=20
> > Here's an updated series that drops these lines and I hope will add=
ress
> > the commit message issues you brought up:
> >
> > =C2=A0[01/11]: Makefile: sort LIB_H list
> > =C2=A0[02/11]: Makefile: fold MISC_H into LIB_H
>=20
> Please no.  Progress would be teaching the remaining compilers to
> autocompute header dependencies so there would be no need to maintain
> a master header list at all. I would understand if the headers had
> been falling out of date and this were a way of saying "we give up",
> but given that that is not happening, why would this change be a good
> thing?

Did you read the argument in patch 2? They are almost certainly not
helping anyone, anyway. Forward progress would be to split all of LIB_H
out into specific targets. But keeping that up to date manually is
insanity, so we have this silly half-hearted attempt.

I would much rather "include header-deps.mk", and then periodically
rebuild and commit it using "gcc -M" (and cleaning up and canonicalizin=
g
the result) for the benefit of those without access to a compiler that
can do header dependencies.

In an ideal world, all compilers could do it, but I am not volunteering
to patch MSVC. ;)

> My comments were only about explaining what I found hard to understan=
d
> in the commit message. The patch was good. Please don't retaliate thi=
s
> way. :)

:) The revised commit message in patch 4 should make sense with or
without these patches, so it really is a separate issue.

-Peff
