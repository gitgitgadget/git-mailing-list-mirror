From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: format-patch broken [Was: fetch and bundle don't work in
	(semi-)broken repo]
Date: Thu, 21 Oct 2010 10:12:50 +0200
Message-ID: <20101021081250.GH19834@pengutronix.de>
References: <20101019183925.GF25139@burratino> <20101019201139.GB28166@pengutronix.de> <alpine.LFD.2.00.1010191635030.2764@xanadu.home> <20101019210233.GA32029@burratino> <alpine.LFD.2.00.1010192154200.2764@xanadu.home> <20101020074122.GC28166@pengutronix.de> <alpine.LFD.2.00.1010200937200.2764@xanadu.home> <20101020150810.GE19834@pengutronix.de> <alpine.LFD.2.00.1010201301130.2764@xanadu.home> <20101021071106.GG19834@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 10:13:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8qGl-0000Ay-39
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 10:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab0JUIMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 04:12:54 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33404 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0JUIMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 04:12:51 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8qGY-0001tL-JA; Thu, 21 Oct 2010 10:12:50 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8qGY-0000jt-FR; Thu, 21 Oct 2010 10:12:50 +0200
Content-Disposition: inline
In-Reply-To: <20101021071106.GG19834@pengutronix.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159487>

Hello,

On Thu, Oct 21, 2010 at 09:11:06AM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Oct 20, 2010 at 01:05:26PM -0400, Nicolas Pitre wrote:
> > On Wed, 20 Oct 2010, Uwe Kleine-K=F6nig wrote:
> >=20
> > > On Wed, Oct 20, 2010 at 09:38:14AM -0400, Nicolas Pitre wrote:
> > > > On Wed, 20 Oct 2010, Uwe Kleine-K=F6nig wrote:
> > > >=20
> > > > > If you want I can provide you the broken repo.
> > > >=20
> > > > Yes, please.
> >=20
> > I'm trying to reproduce the exact error you get. But I'm missing so=
me=20
> > alternates for objects, and none of the trees I have locally provid=
e the=20
> > needed objects.
> >=20
> > [nico@xanadu linux-2.6]$ ! git format-patch linus/master..sectionmi=
smatches
> > 0001-wip-enable-DEBUG_SECTION_MISMATCH.patch
> > 0002-ARM-sa1111-move-__sa1111_probe-to-.devinit.text.patch
> > 0003-ARM-omap1-nokia770-mark-some-functions-__init.patch
> > fatal: unable to read destination tree (16edb8381f2f2dabec9cc59f4a3=
d8c9ead899668)
> >=20
> > What do you have in your alternate repo?
> Hmm, I just unpacked the archive in a seperate directory, removed
> .git/objects/info/alternates and then git format-patch
> linus/master..sectionmismatches fails in a different way:
>=20
> 	fatal: Invalid revision range linus/master..sectionmismatches
>=20
> I guess adding a pristine copy of Linus' tree should do the trick.
>=20
> [ ... some time later ... creating a fresh clone takes quite some tim=
e ... ]
>=20
> No, that's not enough, I will handpick some objects from the original=
=2E
>=20
> Ah, you only need 16edb8381f2f2dabec9cc59f4a3d8c9ead899668 to make
> format-patch work, but still 09b3f464a50111071f7740056b98fa8f36133347=
 is
> missing for this tree.  This doesn't hurt format-patch as it's enough
> for it to know that this entry didn't change.  So format-patch needs
> less information than bundle/fetch and it's OK that the former succee=
ds
> and the latter fails.
>=20
> [...]
>=20
> No, that's not the (only) problem,
> 40aaeb204dc04d3cf15c060133f65538b43b13b0 is needed, git format-patch =
is
> just ignorant enough and invents something different:
>=20
> 	username@hostname:~/path/linux-2.6$ git rev-list linus/master..secti=
onmismatches
> 	eb84720860a90769473b42215a4cb67ee5efe7a7
> 	2e14a5c831032fa489384763087f4a03d88607cb
> 	00b18e8058e98927e2e4eae32deae7e58f47467c
> 	1ad328f663128b5c6e6b4af1ac2da1b443dba530
> 	2a0e4c23a34c78891db685b2b4851705fd36d656
> 	089d061c26b00a5b8dbb9e70b81d36a97e1daded
> 	b7ce4ec88f1bdfbe49fa7ef12df8f985d705605a
> 	b40acb01793933cd6baaaf826f3fef6dd734f72b
> 	780e3d47d067b54b17bcac3794d62825e8e60422
> 	ce06129cf7bbf85afe4fc127afc957d36ba4e9e4
> 	c2172d687578e7eb037a232802a4a8c6de1b0eea
> 	0c23684f39714a72f54036ca2be36e8894794b66
> 	cea2a0668ee1a9dc3617a810954a41c7701a08e9
> 	2bd6ff604ac3aa4c96636dda1ad80a289205ccba
> 	7591700d538d08f2e8327bb439b6cb0488e13f3e
>=20
> 	username@hostname:~/path/linux-2.6$ git diff-tree -r 7591700d538d08f=
2e8327bb439b6cb0488e13f3e
> 	7591700d538d08f2e8327bb439b6cb0488e13f3e
> 	:100644 100644 1b4afd2e6ca089de0babdacc5781426ef118da5c 40aaeb204dc0=
4d3cf15c060133f65538b43b13b0 M	lib/Kconfig.debug
>=20
> 	commit 7591700d538d08f2e8327bb439b6cb0488e13f3e
> 	Author: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> 	Date:   Wed Aug 4 08:52:56 2010 +0200
>=20
> 	    wip: enable DEBUG_SECTION_MISMATCH
>=20
> 	diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> 	index 1b4afd2..40aaeb2 100644
> 	--- a/lib/Kconfig.debug
> 	+++ b/lib/Kconfig.debug
> 	@@ -1,1157 +0,0 @@
> 	-
> 	-config PRINTK_TIME
> 	-	bool "Show timing information on printks"
> 	-	depends on PRINTK
> 	-	help
> 	-	  Selecting this option causes timing information to be
> 	-	  included in printk output.  This allows you to measure
> 	-	  the interval between kernel operations, including bootup
> 	-	  operations.  This is useful for identifying long delays
>=20
> So format-patch assumes that lib/Kconfig.debug became empty because o=
f
> not knowing what 40aaeb204dc04d3cf15c060133f65538b43b13b0 is.
>=20
> So it's not git-bundle/git-fetch that is broken, but format-patch.
>=20
> I attached an archive with the two objects
> 16edb8381f2f2dabec9cc59f4a3d8c9ead899668 and
> 09b3f464a50111071f7740056b98fa8f36133347 and will try to recreate
> 40aaeb204dc04d3cf15c060133f65538b43b13b0 now.
That was easy:

	git hash-object -w lib/Kconfig.debug

Now git bundle works again.

Nicolas: I forgot to say, that I needed a pristine clone of Linus' repo
as alternate to get it running.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
