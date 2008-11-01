From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 18:30:42 +0100
Message-ID: <20081101173042.GE26229@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="3XA6nns4nE4KvaS/";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 18:32:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwKKM-00044E-T3
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 18:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYKARaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYKARap
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 13:30:45 -0400
Received: from pan.madism.org ([88.191.52.104]:55951 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbYKARap (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 13:30:45 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E1E423B7FC;
	Sat,  1 Nov 2008 18:30:43 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 98CD75EE245; Sat,  1 Nov 2008 18:30:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031184154.GV14786@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99750>


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 06:41:54PM +0000, Shawn O. Pearce wrote:
> How about this?
>=20
> http://www.spearce.org/projects/scm/libgit2/apidocs/CONVENTIONS

FWIW I've read what you say about types, while this is good design to
make things abstract, accessors are slower _and_ disallow many
optimizations as it's a function call and that it may clobber all your
pointers values.

For types that _will_ be in the tight loops, we must make the types
explicit or it'll bite us hard performance-wise. I'm thinking what is
"struct object" or "struct commit" in git.git. It's likely that we will
loose a *lot* of those types are opaque.

struct object in git has not changed since 2006.06. struct commit hasn't
since 2005.04 if you ignore { unsigned int indegree; void *util; } that
if I'm correct are annotations, and is a problem we (I think) have to
address differently anyways (I gave my proposal on this, I'm eager to
hear about what other think on the subject). So if in git.git that _is_
a moving target we have had a 2 year old implementation for those types,
it's that they're pretty well like this.

It's IMNSHO on the matter that core structures of git _will_ have to be
made explicit. I'm thinking objects and their "subtypes" (commits,
trees, blobs). Maybe a couple of things on the same vein.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkMkkIACgkQvGr7W6HudhzkcwCfcVvg9HiDWZHaZhVvPz5UrDvs
fKkAoItFW9QmwTzIyOeKnNcwWnIhm2QV
=hcct
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
