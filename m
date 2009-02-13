From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 14:37:39 +0100
Message-ID: <200902131437.49293.trast@student.ethz.ch>
References: <1234529920-9694-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0902131418230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2041670.eWBGxQlXPn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Adeodato =?utf-8?q?Sim=C3=B3?= <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 13 14:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXyGM-0002KX-9V
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 14:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZBMNh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 08:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbZBMNh7
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 08:37:59 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:19401 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbZBMNh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 08:37:58 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 14:37:55 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 14:37:54 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0902131418230.10279@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 13 Feb 2009 13:37:55.0040 (UTC) FILETIME=[466B5600:01C98DE0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109747>

--nextPart2041670.eWBGxQlXPn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Fri, 13 Feb 2009, Thomas Rast wrote:
[...]
> >  log-tree.c               |   19 ++++++++++++++-----
> >  log-tree.h               |    3 +++
>=20
> I am slightly worried that you overshoot here, as log-tree.c has plumbing=
=20
> users, too, no?
>=20
> How about making this an option, and passing it in rev_opts instead?  Thi=
s=20
> option could then be defaulted to in git-log, when the user said=20
> --abbrev-commit.

But the 'git_config(git_log_config, NULL);' that sets the new variable
to false is only called from cmd_{log,show,whatchanged,reflog}.  I
should have indicated this in the commit messaged, sorry.

The real problem with stuffing it in rev_opts (actually rev_info :-)
is that it seems inconsistent to not change the 'Merge: blah' line's
format.  But that is generated in pretty.c, in add_merge_info via
pp_header from pretty_print_commit, which has a bunch of users in
various 'builtin-*.c'.

So do I sacrifice symmetry (abbrev_commit is indeed stored in
rev_info), or touch the other ~7 users of pretty_print_commit too?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2041670.eWBGxQlXPn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmVd60ACgkQqUud07tmzP29AwCfb6szSB6OhPcFI7fDHXwgfD3L
cJcAoJQu5EiN/VdXOKo0GljvWw0L2Qqc
=C2my
-----END PGP SIGNATURE-----

--nextPart2041670.eWBGxQlXPn--
