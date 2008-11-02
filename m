From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sun, 02 Nov 2008 10:19:02 +0100
Message-ID: <20081102091902.GB4066@artemis>
References: <20081031170704.GU14786@spearce.org> <490CAB6D.90209@op5.se> <20081101204259.GC15463@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="2B/JsCI69OhZNC5r";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:20:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZ8G-0002TO-2x
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYKBJTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbYKBJTJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:19:09 -0500
Received: from pan.madism.org ([88.191.52.104]:59456 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbYKBJTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:19:07 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 103AB3B7E2;
	Sun,  2 Nov 2008 10:19:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id D9C6E373C2; Sun,  2 Nov 2008 10:19:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081101204259.GC15463@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99824>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 08:42:59PM +0000, Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
> > Shawn O. Pearce wrote:
> >> During the GitTogether we were kicking around the idea of a ground-up
> >> implementation of a Git library.
> >
> > Having looked briefly at the code, I've got a couple of comments:
> > * GIT_EXTERN() does nothing. Ever. It's noise and should be removed.
>=20
> I feel the same way.
>=20
> But I was also under the impression that the brilliant engineers
> who work for Microsoft decided that on their platform special
> annotations have to be inserted on functions that a DLL wants to
> export to applications.
>=20
> Hence any cross-platform library that I have seen annotates their
> exported functions this way, with the macro being empty on POSIX
> and expanding to some magic keyword on Microsoft's OS.  I think it
> goes between the return type and the function name too...
>=20
> >  Instead it would be better to have GIT_PRIVATE(),
>=20
> I can see why you said this; needing GIT_PRIVATE() is a lot more
> rare than needing GIT_EXTERN().  Only a handful of cross-module,
> but private, functions are likely to exist, so it makes sense to
> mark the smaller subset.  But see above.  *sigh*

Not only there is the windows thing, but the *best* way to design a
library is to make _everything_ by default and only show what you mean
to.

GIT_EXTERN allow us to do just that with
__attribute__((visibility("default"))) on GNU-ld/GCC.

Of course we can achieve the same using nothing on public symbols and
__attribute__((visibility("hidden"))) on the private ones, but it's way
more cumbersome and there's always a chance to forget one. It's bad
design IMHO.


FWIW GIT_EXTERN(...) prototype(arguments); isn't unredable to me,
everyone does that, it doesn't break tags, it's _good_. And you can ask
doxygen to substitute this GIT_EXTERN(x) with x so that it doesn't shows
up in the documentation at all (it can include these kind of partially
preprocessed headers in the documentation) for the people who are really
annoyed with them.

But it's definitely a necessary evil.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkNcIYACgkQvGr7W6Hudhw4vQCgj+HeBmo9ArsFMbNufHaEjsoU
ejsAnRb0q73HPlAcRvVrjJDIDv0dAvZm
=wHst
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
