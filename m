From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Hint at "checkout -p" in the "reset --patch <type>"
 error message
Date: Thu, 25 Nov 2010 11:14:46 -0500
Message-ID: <20101125161446.GA24426@sigill.intra.peff.net>
References: <AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
 <AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
 <AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
 <AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
 <AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>
 <87mxp086k5.fsf_-_@gmail.com>
 <20101123145921.GB3145@sigill.intra.peff.net>
 <87ipzo83o9.fsf@gmail.com>
 <4CEE2472.5020901@drmicha.warpmail.net>
 <vpqbp5diei5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	Jeenu V <jeenuv@gmail.com>, knittl <knittl89@googlemail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 25 17:15:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLeTS-0004lX-Fe
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 17:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab0KYQOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 11:14:53 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54924 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889Ab0KYQOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 11:14:51 -0500
Received: (qmail 10332 invoked by uid 111); 25 Nov 2010 16:14:50 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 25 Nov 2010 16:14:50 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Nov 2010 11:14:46 -0500
Content-Disposition: inline
In-Reply-To: <vpqbp5diei5.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162143>

On Thu, Nov 25, 2010 at 04:56:02PM +0100, Matthieu Moy wrote:

> > The man page for git-reset points at git-checkout already.
> >
> > Until we have a "verbosity level" config across all commands, I don=
't
> > favor adding a lot of hints to command error messages.
>=20
> I agree for "regular output", but this case is an error message that
> users should never see. If you see the message, it means you tried a
> command that doesn't exist, and I can't imagine a case where this
> would be disturbing to get an informative message pointing to the
> right command.

I have to agree.  When I introduced advice.*, I had initially intended
to have "advice.all" or similar, so expert users could shut off the
verbose warnings.

But I found that I didn't really want it. Most of the advice is for
messages like these that you just don't see that often, and the extra
line of output is simply not that big a deal. For messages that you _do=
_
see every day (e.g., the help in "git status"), it is not so cumbersome
to set the proper config option.

Which isn't to say I would be against "advice.all" (or even
advice.commandSuggestions) if somebody submitted a patch for it. I just
don't want it personally.

And I don't think any of this needs to hold up =C5=A0t=C4=9Bp=C3=A1n's =
patch[1]. What has
happened in the past is something like:

  1. Somebody introduces new messages. The patch makes it into next.

  2. A developer gets annoyed and creates a patch for advice.whatever.

  3. That patch goes on the appropriate topic and they make it into the
     release together.

which makes sense to me. Then we know the patch in (2) is not just
bikeshedding, but actually fixes somebody's annoyance. :)

-Peff

[1] Don't take this as an endorsement of the patch. I think the intent
is good, but I haven't reviewed it carefully to make sure "git reset -p
--mixed" actually works as advertised. Today is American Thanksgiving,
so I probably won't get to it for a few days.
