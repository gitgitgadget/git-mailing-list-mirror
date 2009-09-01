From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Make git status print a helpful death message if the disk is full
Date: Tue, 1 Sep 2009 22:35:05 +0200
Message-ID: <200909012235.10091.trast@student.ethz.ch>
References: <4A9D7B54.5020902@facebook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1640406.ORD30fppDG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 22:35:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mia4t-00014j-LQ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 22:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbZIAUfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 16:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZIAUfd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 16:35:33 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:15240 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbZIAUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 16:35:32 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 1 Sep
 2009 22:35:32 +0200
Received: from thomas.localnet (129.132.209.78) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 1 Sep
 2009 22:35:33 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.29-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <4A9D7B54.5020902@facebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127555>

--nextPart1640406.ORD30fppDG
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

David Reiss wrote:
> The old behavior just said that it failed.  Now it includes the error
> information, which makes it much easier to debug.
>=20
> There is a risk that some failure paths could result in misleading error
> messages that actually make debugging more difficult.
[...]
>  		if (write_cache(fd, active_cache, active_nr) ||
>  		    close_lock_file(&index_lock))
> -			die("unable to write new_index file");
> +			die("unable to write new_index file: %s", strerror(errno));

Junio C Hamano wrote:
> Don't we have die_errno() or something since at least 1.6.4?

Yes.  And during the conversion, I ignored call sites like this one
precisely because I did not (and still do not) have enough knowledge
of the index and lock file machinery to decide at what stage I need to
read errno to get the *real* error message.  You're of course welcome
to dig into the code to verify that the above is correct, but I am
against blindly hoping that it gives the right error.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1640406.ORD30fppDG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkqdhX4ACgkQqUud07tmzP1fPACfTY8bRGunEk5pPYUv31QslHrQ
xnMAn0vNuXvGw9p3sRnSZCgA7yEYfnac
=aF5b
-----END PGP SIGNATURE-----

--nextPart1640406.ORD30fppDG--
