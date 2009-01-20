From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the reflogs twice
Date: Tue, 20 Jan 2009 01:11:32 +0100
Message-ID: <200901200111.38917.trast@student.ethz.ch>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11522168.8XUrEB3N94";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 01:13:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP4Em-0003S8-Eu
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 01:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762693AbZATAL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 19:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764045AbZATAL0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 19:11:26 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21953 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762715AbZATALY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 19:11:24 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Jan 2009 01:11:23 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Jan 2009 01:11:22 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.18-0.2-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 20 Jan 2009 00:11:22.0615 (UTC) FILETIME=[A05F4870:01C97A93]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106416>

--nextPart11522168.8XUrEB3N94
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > > You can have quite a many reflog entries, but you typically won't rec=
all
> > > which branch you were on after switching branches for more than sever=
al
> > > times.
>=20
> This, together with a removal of the hard-coded limit of 16 could be=20
> squashed with this patch:

You know, I'm quite puzzled as to why we had working code that could
read the reflog backwards earlier in this thread, but it got shot down
solely based on impact and line counts, and you now have to jump
through hoops to work around the lack of this exact functionality.

So how about I resurrect the part about for_each_reflog_ent() and
_backward(), without touching read_ref_at().  This would actually
avoid the worst (hard to check) part of the patch since the
refactoring of for_each_reflog_ent()'s error checking is quite trivial
and IMHO actually results in more readable code.

I'm just asking because I'm not particularly inclined to do it first
and get rejected _again_.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart11522168.8XUrEB3N94
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl1FroACgkQqUud07tmzP0EuwCePYYxoXndugd03xsa33KJLLTq
gd8AniNfxa1aPxB9xRgyUYbpxTIguXqt
=Lbtn
-----END PGP SIGNATURE-----

--nextPart11522168.8XUrEB3N94--
