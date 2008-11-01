From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 18:01:58 +0100
Message-ID: <20081101170158.GB26229@artemis.corp>
References: <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org> <20081101001300.GE14786@spearce.org> <alpine.LFD.2.00.0810312106310.13034@xanadu.home> <20081101011910.GH14786@spearce.org> <alpine.LFD.2.00.0810312135190.13034@xanadu.home> <20081101015217.GJ14786@spearce.org> <alpine.DEB.1.00.0811010320370.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081101110120.GA3819@artemis.corp> <alpine.LFD.2.00.0811010944000.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wq9mPyueHGvFACwf";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 18:03:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwJse-00045z-Gz
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 18:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbYKARCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 13:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYKARCF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 13:02:05 -0400
Received: from pan.madism.org ([88.191.52.104]:46953 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbYKARCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 13:02:03 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C4DE73B199;
	Sat,  1 Nov 2008 18:01:59 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 666D65EE245; Sat,  1 Nov 2008 18:01:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811010944000.13034@xanadu.home>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99747>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 01:50:45PM +0000, Nicolas Pitre wrote:
> On Sat, 1 Nov 2008, Pierre Habouzit wrote:
>=20
> > Well, you can't return _sanely_ an error through a pointer. The &1
> > method is broken as soon as you return a char* (there is an alignment
> > requirement for malloc, not for any pointer out there), hence shall not
> > be used, as it would not be the sole way to test for error.
> >=20
> > Another option, that is _theorically_ not portable, but is ttbomk on all
> > the platforms we intend to support (IOW POSIX-ish and windows), is to
> > use "small" values of the pointers for errors. [NULL .. (void *)(PAGE_S=
IZE - 1)[
> > cannot exist, which gives us probably always 512 different errors, and
>=20
> 4095 actually.  You don't need to align error codes.

Sure, I'm just not sure there isn't an arch where a page would be 512
octets. And you really have 4096 errors, from 0 to 4095 *included* :)

> > the test is ((uintptr_t)ptr < (PAGE_SIZE)) which is cheap. It's butt
> > ugly, but encoding errors into pointers is butt ugly in the first place.
>=20
> Or use "negative" pointers.  Again, please have a look at=20
> include/linux/err.h.  The pointer range from 0xffffffff (or=20
> 0xffffffffffffffff on 64-bit machines) down to the range you want is for=
=20
> errors, and the top of the address range is almost certain to never be=20
> valid in user space either.

Indeed.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkMi4YACgkQvGr7W6HudhwfuQCfQg8YceyXKqI7t9Pk53qkkwtE
NlIAnj8UAscqRlXJ+wZ3kypnF9yCsp2s
=cdCB
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
