From: Jeff King <peff@peff.net>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Wed, 30 May 2012 21:19:11 -0400
Message-ID: <20120531011911.GC5488@sigill.intra.peff.net>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
 <7vehq18c82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Lanny Ripple <lanny@spotinfluence.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 03:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZu2p-0003xF-4j
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 03:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab2EaBTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 May 2012 21:19:15 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36695
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173Ab2EaBTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 21:19:14 -0400
Received: (qmail 12874 invoked by uid 107); 31 May 2012 01:19:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 21:19:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 21:19:11 -0400
Content-Disposition: inline
In-Reply-To: <7vehq18c82.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198855>

On Wed, May 30, 2012 at 04:45:33PM -0700, Junio C Hamano wrote:

> Lanny Ripple <lanny@spotinfluence.com> writes:
>=20
> >   lanny;~> echo "R=C3=A9mi Leblond" | LANG=3DC LC_ALL=3DC sed -ne '=
s/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
> >   GIT_AUTHOR_NAME=3D'R'=C3=A9mi Leblond
>=20
> So in C locale where each byte is supposed to be a single character,
> that implementation of "sed" refuses to match a byte with high-bit
> set when given a pattern '.'?
>=20
> That is a surprising breakage, I would have to say.

It should not be too surprising, since we discussed it a few months ago=
:

  http://thread.gmane.org/gmane.comp.version-control.git/192218

Thomas provided a gross but workable solution here:

  http://article.gmane.org/gmane.comp.version-control.git/192237

and we also talked about eventually having a shell-quoting mechanism fo=
r
pretty placeholders.  Then the discussion rambled into "this sed is
horribly broken, and the user should get a better sed" territory. Maybe
we need to revisit that decision, since this is now two bug reports.

-Peff
