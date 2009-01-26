From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase -i: correctly remember --root flag across --continue
Date: Mon, 26 Jan 2009 22:28:08 +0100
Message-ID: <200901262228.13104.trast@student.ethz.ch>
References: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org> <1232960722-17480-1-git-send-email-trast@student.ethz.ch> <7veiyp4w2m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3243281.KKAOg96Y4O";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRZ1d-0004NX-SG
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZAZV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbZAZV2Q
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:28:16 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:37325 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbZAZV2P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:28:15 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 22:28:14 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 22:28:14 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <7veiyp4w2m.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 26 Jan 2009 21:28:14.0216 (UTC) FILETIME=[FEEC6080:01C97FFC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107288>

--nextPart3243281.KKAOg96Y4O
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > +	GIT_EDITOR=3D: test_must_fail git rebase -i --root --onto master &&
>=20
> Maybe I am misrecalling things but didn't we have reports from people on
> some platforms that single-shot exporting of the environment like this one
> does not work for them?

Then that deserves a fix, though I should point out that the original
patches (now on master) have the same code in them.

[So many quirks and so little time!]

> > +sed 's/#/ /g' > expect-conflict-p <<'EOF'
> > +*   Merge branch 'third' into other
> > +|\##
> > +| * 6
> > +* |   Merge branch 'side' into other
> > +|\ \##
> > +| * | 5
> > +* | | 4
> > +|/ /##
> > +* | 3
> > +|/##
> > +* conflict
> > +* 2
> > +* 1
> > +EOF
>=20
> I do not like this very much.  Future improvements of the graph drawing
> algorithm (one obvious "flaw" you are exposing by the above is that it has
> trailing whitespaces that can be trimmed, and somebody else may be
> inclined to fix) would break the expectation this test vector has.
>=20
> Do you have to compare the topology this way, or are there other more
> reliable ways?

It would certainly be possible to test the SHA1 of the resulting
branch tip, but t/README says I shouldn't.  Or we could spell it out
as a series of 'parent of X is Y' and 'message of Y is foo' tests,
which seems rather messy.

The above approach at least has the advantage that a test failure due
to format change can be diagnosed very quickly just from the diff that
is shown with -v.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3243281.KKAOg96Y4O
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl+Ku0ACgkQqUud07tmzP1aNQCcDgCS7UR54x459O9MLN6JJdCE
zjYAn1aWgjmFj69+R7esSDf9i4kM0AXF
=uKIB
-----END PGP SIGNATURE-----

--nextPart3243281.KKAOg96Y4O--
