From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] allow '%d' pretty format specifier to show
	decoration
Date: Wed, 3 Sep 2008 15:36:15 -0400
Message-ID: <20080903193615.GA31225@coredump.intra.peff.net>
References: <20080820175325.GD27773@sigill.intra.peff.net> <20080820180034.GB32005@sigill.intra.peff.net> <alpine.DEB.1.00.0808202042260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KayAO-0004Td-Uv
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 21:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbYICTgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 15:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbYICTgU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 15:36:20 -0400
Received: from peff.net ([208.65.91.99]:3183 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbYICTgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 15:36:18 -0400
Received: (qmail 31043 invoked by uid 111); 3 Sep 2008 19:36:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 15:36:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 15:36:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808202042260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94844>

On Wed, Aug 20, 2008 at 08:43:29PM +0200, Johannes Schindelin wrote:

> Indeed.  When I posted a similar patch, there was some discussion, to=
o. =20
> But no resolution, as it seemed nobody was really interested.

I know Junio called you negative, but I actually appreciate having you
point out related work (even if I don't get around to reading it for 2
weeks!).

It is funny how similar our patches ended up, even though I didn't even
realize yours existed. It looks like the comments were not all that
different, either.

To summarize what was said then (for the benefit of Michael, who is
moving this forward):

  - Junio didn't like the expansion to include a space and enclosing
    parentheses, because then we don't know where to put the space.
    I agree with that. Though note that you will still end up with an
    extra space for a blank decoration.

  - Ren=C3=A9 suggested a comma delimeter, which Michael's patch does.

  - Ren=C3=A9 suggested a foobar2000-inspired expansion construct for d=
ealing
    with the extra parentheses and space when no decoration exists. If
    we are going to expand the expansion language I think I would prefe=
r
    something more like what show-ref uses (as Jakub suggested), but
    with "tags" expanded so that they can contain arbitrary data. So
    something like:

      %(decorate:delim=3D, :prefix=3D (:suffix=3D\))

    or even:

      %(decorate:+ (%(decorate:delim=3D, ))

    to use the more shell-ish conditional.

    But I think it is not a problem to introduce '%d' _and_ make such
    improvements later.

  - Ren=C3=A9 also suggested that he wanted a placeholder for git-descr=
ibe
    output. Logically, this would also want %d. Maybe it is worth makin=
g
    this %decorate now to avoid confusion later.

-Peff
