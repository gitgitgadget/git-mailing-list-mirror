From: Pierre Habouzit <madcoder@artemis.madism.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 13:08:51 +0100
Message-ID: <20071211120851.GK30948@artemis.madism.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com> <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com> <7vlk82hrdt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.99999.0712102225240.555@xanadu.home> <85bq8xlc8w.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="it/zdz3K1bH9Y8/E";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 13:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J23vL-0003yV-OJ
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 13:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbXLKMI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 07:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbXLKMIz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 07:08:55 -0500
Received: from pan.madism.org ([88.191.52.104]:55656 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbXLKMIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 07:08:54 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 515322F4DA;
	Tue, 11 Dec 2007 13:08:52 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D660B2BCA64; Tue, 11 Dec 2007 13:08:51 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@artemis.madism.org>,
	David Kastrup <dak@gnu.org>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <85bq8xlc8w.fsf@lola.goethe.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67842>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 11:08:47AM +0000, David Kastrup wrote:
> Nicolas Pitre <nico@cam.org> writes:
>=20
> > On Mon, 10 Dec 2007, Junio C Hamano wrote:
> >
> >> "Jon Smirl" <jonsmirl@gmail.com> writes:
> >>=20
> >> > 95%   530  2.8G - 1,420 total to here, previous was 1,983
> >> > 100% 1390 2.85G
> >> > During the writing phase RAM fell to 1.6G
> >> > What is being freed in the writing phase??
> >>=20
> >> entry->delta_data is the only thing I can think of that are freed
> >> in the function that have been allocated much earlier before entering
> >> the function.
> >
> > Yet all ->delta-data instances are limited to 256MB according to Jon's=
=20
> > config.
>=20
> Maybe address space fragmentation is involved here?  malloc/free for
> large areas works using mmap in glibc.  There must be enough
> _contiguous_ space for a new allocation to succeed.

  Well, that's interesting, but there is a way to know for sure instead
of taking bets. Just use valgrind --tool=3Dmassif and look at the pretty
picture, it'll tell what was going on very accurately.

  Note that I find your explanation unlikely: glibc uses mmap for sizes
over 128k by default (IIRC), and as soon as you use mmaps, that's the
kernel that deals with the address space, and it's not necessarily
contiguous, that's only true for the heap.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXn3TvGr7W6HudhwRAntBAJkBfQfIA2qiNrfePMAhI47ILbSd8ACgm9nr
abh91fg9HVqteRhOUmML0nw=
=/dRz
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
