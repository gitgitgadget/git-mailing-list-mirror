From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Wed, 12 Jan 2011 19:19:37 +0100
Message-ID: <20110112181937.GK24920@pengutronix.de>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <20110112091130.GC24920@pengutronix.de>
 <20110112174600.GB31747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 12 19:19:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd5IO-0002v2-Nt
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 19:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab1ALSTk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 13:19:40 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49732 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab1ALSTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 13:19:39 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pd5IH-00033N-KO; Wed, 12 Jan 2011 19:19:37 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pd5IH-0003Ml-Es; Wed, 12 Jan 2011 19:19:37 +0100
Content-Disposition: inline
In-Reply-To: <20110112174600.GB31747@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165023>

Hi,

On Wed, Jan 12, 2011 at 12:46:00PM -0500, Jeff King wrote:
> On Wed, Jan 12, 2011 at 10:11:30AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > So working copy and cache are at refs/tags/sgu/mxs-amba-uart, H=
EAD
> > > > points to refs/heads/sgu/mxs-amba-uart
> > >=20
> > > Yeah, we generally resolve ambiguities in favor of the tag (and t=
hat
> > > warning comes from deep within get_sha1_basic). So the real bug h=
ere is
> > > that it still said "Switched to branch", which is totally wrong.
> > I wonder how I can resolve the ambiguity when calling checkout.  (W=
ell
> > apart from changing either branch name or tag name)
> >=20
> > git checkout refs/heads/sgu/mxs-amba-uart results in a detached HEA=
D.
>=20
> You can't disambiguate to the branch without going to a detached HEAD=
 in
> the current code; it's just broken[1].
>=20
> With the patch here:
>=20
>   http://article.gmane.org/gmane.comp.version-control.git/164986
>=20
> it will disambiguate to the branch by default, and if you want the ta=
g,
> you can do:
>=20
>   git checkout tags/sgu/mxs-amba-uart
that's fine.

> [1]: You can't do it with checkout, that is. You can still hack aroun=
d
>      it with:
>=20
>         branch=3Drefs/heads/sgu/mxs-amba-uart
>         git read-tree -m -u $branch &&
>         git symbolic-ref HEAD $branch
I did

	git checkout refs/heads/sgu/mxs-amba-uart
	git symbolic-ref HEAD refs/heads/sgu/mxs-amba-uart

:-)

Uwe
>=20
>      which is a simplified version of what checkout is doing.
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
