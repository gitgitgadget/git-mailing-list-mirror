From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [BUG?] fail to svn clone debian's kernel repository
Date: Wed, 10 Jun 2009 20:42:56 +0200
Message-ID: <20090610184256.GA11507@pengutronix.de>
References: <20090610160524.GA24435@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 20:43:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MESlN-0006Rj-Hm
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 20:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbZFJSm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 14:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbZFJSmz
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 14:42:55 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33152 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbZFJSmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 14:42:54 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MESlE-0002Zu-O7
	for git@vger.kernel.org; Wed, 10 Jun 2009 20:42:56 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MESlE-0002Qo-Lz
	for git@vger.kernel.org; Wed, 10 Jun 2009 20:42:56 +0200
Content-Disposition: inline
In-Reply-To: <20090610160524.GA24435@pengutronix.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121292>

Hello,

> using git v1.6.3.1 from Debian I fail to successfully run
>=20
> 	git svn clone svn://svn.debian.org/kernel/dists/trunk/linux-2.6
>=20
> It runs for some time and then ends in:
>=20
> 	...
> 	r4695 =3D f552d98386b301cbeaa3b5a20f9e9d5d3c9c4886 (git-svn)
> 		M	debian/arch/alpha/defines
> 	r4696 =3D 18c0a37de057d24955b66e8f49db0791f6018288 (git-svn)
> 	Found possible branch point: svn://svn.debian.org/kernel/dists/sid/l=
inux-2.6 =3D> svn://svn.debian.org/kernel/dists/trunk/linux-2.6, 4731
> 	Initializing parent: git-svn@4731
> 	W: Ignoring error from SVN, path probably does not exist: (160013): =
=46ilesystem has no item: File not found: revision 101, path '/dists/si=
d/linux-2.6'
> 	W: Do not be alarmed at the above message git-svn is just searching =
aggressively for old history.
> 	This may take a while on large repositories
> 	Found possible branch point: svn://svn.debian.org/kernel/dists/sid/k=
ernel/linux-2.6 =3D> svn://svn.debian.org/kernel/dists/sid/linux-2.6, 4=
094
> 	Initializing parent: git-svn@4094
> 	Found branch parent: (git-svn@4731) e71da640593b63647fb23f915acee03f=
02fbaa98
> 	Following parent with do_switch
> 	Invalid filesystem path syntax: Cannot replace a directory from with=
in at /usr/lib/git-core/git-svn line 4388
I debugged this a bit by adding a print just before line 4388.  There w=
e
have:

	rev_a=3D4090
	rev_b=3D4095
	path=3D""
	full_url=3Dsvn://svn.debian.org/kernel/dists/sid/kernel/linux-2.6
	old_url=3Dsvn://svn.debian.org/kernel/dists/sid/kernel/linux-2.6

Mmh, these are really heavy commits it seems.  The commitlog suggests
that trunk was moved there, and websvn dies with ENOMEM when trying to
show the diff.

I will try to start cloning at a later revision.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
