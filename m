From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC] log-tree: let format-patch not indent notes
Date: Thu, 25 Sep 2014 13:56:52 -0400
Message-ID: <20140925175651.GA11673@peff.net>
References: <1411661409-24562-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Sep 25 19:57:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXDHn-0003nQ-3n
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 19:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbaIYR4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 13:56:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:51678 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752533AbaIYR4y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 13:56:54 -0400
Received: (qmail 23891 invoked by uid 102); 25 Sep 2014 17:56:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Sep 2014 12:56:54 -0500
Received: (qmail 15554 invoked by uid 107); 25 Sep 2014 17:57:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Sep 2014 13:57:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Sep 2014 13:56:52 -0400
Content-Disposition: inline
In-Reply-To: <1411661409-24562-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257485>

On Thu, Sep 25, 2014 at 06:10:09PM +0200, Uwe Kleine-K=C3=B6nig wrote:

> Commit logs as shown by git-log are usually indented by four spaces s=
o
> here it makes sense to do the same for commit notes.
>=20
> However when using format-patch to create a patch for submission via
> e-mail the commit log isn't indented and also the "Notes:" header isn=
't
> really useful. So consequently don't indent and skip the header in th=
is
> case. This also removes the empty line between the end-of-commit mark=
er
> and the start of the notes.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

I like this, though I think it is somewhat subjective, and there may be
some corner cases. This topic has come up before (this is the tip of
what I dug up, but I did not bother reading back further myself):

  http://article.gmane.org/gmane.comp.version-control.git/163144

You'd also need to consider what happens with non-default notes. If you
do "--show-notes=3Dfoo" then your header is more like:

  Notes (foo):
     blah blah blah

and your patch loses the information on the source.  You may even be
pulling in from multiple sets of notes, in which case there are multipl=
e
headers with multiple sources.

I wonder if we would need an option to say "I am showing notes, but fro=
m
just one ref and I prefer the simple three-dash format". Like
"--cover-notes[=3D<ref>]" or something. I dunno.

-Peff
