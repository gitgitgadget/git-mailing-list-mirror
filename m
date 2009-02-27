From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: topgit patches
Date: Fri, 27 Feb 2009 20:42:52 +0100
Message-ID: <20090227194252.GB24054@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de> <20090225212309.GM12275@machine.or.cz> <20090225231550.GA19741@pengutronix.de> <20090226060652.GA16251@lapse.rw.madduck.net> <20090226141548.GA32439@pengutronix.de> <20090227123731.GA22696@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 20:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8dB-00056o-9I
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbZB0Tm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 14:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756830AbZB0Tm5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:42:57 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46140 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbZB0Tm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:42:56 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Ld8bl-0005Um-GF; Fri, 27 Feb 2009 20:42:53 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Ld8bk-0006OA-L2; Fri, 27 Feb 2009 20:42:52 +0100
Content-Disposition: inline
In-Reply-To: <20090227123731.GA22696@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111702>

On Fri, Feb 27, 2009 at 01:37:31PM +0100, martin f krafft wrote:
> also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009=
=2E02.26.1515 +0100]:
> > If you need help, I'm also interested to co-maintain the debian
> > package. Just an offer ...  (I don't know the exact way to become
> > a maintainer, if I need to meet a Debian developer, that's no
> > problem, I know one.)
>=20
> The Debian package is pretty trivial to maintain on top of upstream
> (thanks to topgit), and I am using it a bit as a test-case for
> workflow experiments. However, if you are interested in packaging,
> by all means, join me. In that case I'd suggest that you make the
> 0.6-1 Debian package after 0.6 is out, and I give you some hints up
> front and then simply stand by to help out.
Great.

> >  1 move all or most topgit-topic-branches to a private namespace, s=
ay
> >    refs/top-heads because the patch branches pollute the output of =
git
> >    branch.
>=20
> But aren't the topic branches essentially also plain Git branches?
Yes, sure, but in my workflow I usually have "patch branches" that
really introduce a change and "topic branches" that don't introduce own
changes but only collect "patch branches" in .topdeps.  For me it would
be enough to let the "topic branches" appear in the output of
git-branch.  Currently I have 144 (non-remote) branches in my linux
repo:

	-   3 branches are exported topgit developments;
	-   1 master branch (don't know off-hand what it contains);
	-   9 topgit topic branches; and
	- 131 topgit patch branches.

Skipping the 131 patch branches would greatly improve usability.

> >  2 export method that works like the existing linearize but creates
> >    branches for topgit branches living in refs/heads and merges the=
se
> >    properly without linearisation.
> >    (obviously depends on 1)
>=20
> I am not sure I understand what you are trying to do.
=46or example I collect arm-linux related patches that are ready for
upstream in a branch called t/armmisc-master, and patches that are not
ready in t/armmisc-pu.  t/armmisc-pu depends on t/armmisc-master.  When
I export t/armmisc-pu (usually to armmisc-pu) I want that a branch
armmisc-master is created that is an ancestor of armmisc-pu that just
contains the patches in t/armmisc-master.

Another scenario is if I'm working on a platform, say imx, I have
several upstreams: arm, i2c, mtd etc.  Here I want to have a topic
branch that contains all my imx patches and provides proper branches to
pull for my upstreams.  So the involved topgit topic branches are named=
:

	t/imx-master
	t/imx/arm-master
	t/imx/i2c-master
	t/imx/mtd-master

and the exported result has to look like this:

	                 arm-patch1 -- arm-patch2 ... arm-patchK
	               /                                        \
	              /                                          \
	linus/master  -- i2c-patch1 -- i2c-patch2 ... i2c-patchL-- imx-master
	              \                                          /
	               \                                        /
	                 mtc-patch1 -- mtd-patch2 ... mtd-patchM

and arm-patchK, i2c-patchL and mtd-patchM are the heads of the branches
imx/arm-master, imx/i2c-master and imx/mtd-master respectively.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
