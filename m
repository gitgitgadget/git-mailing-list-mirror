From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 14 Apr 2009 13:27:51 -0700
Message-ID: <20090414T202206Z@curie.orbis-terrarum.net>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OY4z34RctfP64Hws"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtpGB-0003kW-1C
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZDNU2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZDNU17
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:27:59 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:46950 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752443AbZDNU17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 16:27:59 -0400
Received: (qmail 9091 invoked from network); 14 Apr 2009 20:27:54 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 14 Apr 2009 20:27:54 +0000
Received: (qmail 18250 invoked by uid 10000); 14 Apr 2009 13:27:51 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116568>


--OY4z34RctfP64Hws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2009 at 04:17:55PM -0400, Nicolas Pitre wrote:
> WRT the HTTP protocol, I was questioning git's ability to resume the=20
> transfer of a pack in the middle if such transfer is interrupted without=
=20
> redownloading it all. And Mike Hommey says this is actually the case.
With rsync:// it was helpful to split the pack, and resume there worked
reasonably (see my other mail about the segfault that turns up
sometimes).

More recent discussions raised the possibility of using git-bundle to
provide a more ideal initial download that they CAN resume easily, as
well as being able to move on from it.

So, from the Gentoo side right now, we're looking at this:
1. Setup git-bundle for initial downloads.
2. Disallow initial clones over git:// (allow updates ONLY)
3. Disallow git-over-http, git-over-rsync.

This also avoids the wait time with the initial clone. Just grab the
bundle with your choice of rsync or http, check it's integrity, throw it
into your repo, and update to the latest tree.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--OY4z34RctfP64Hws
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknk8ccACgkQPpIsIjIzwiz+iwCeNuLEaNcWD5s77MZqEBuOuJru
WCcAn2MrIHO4b++M3uk6UDNEY3saAnEm
=9uC+
-----END PGP SIGNATURE-----

--OY4z34RctfP64Hws--
