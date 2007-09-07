From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 11:41:20 +0200
Message-ID: <20070907094120.GA27754@artemis.corp>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="EeQfGwPcQSOJBaQU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 11:41:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITaLA-0005F3-8u
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 11:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbXIGJlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 05:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbXIGJlX
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 05:41:23 -0400
Received: from pan.madism.org ([88.191.52.104]:40782 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965007AbXIGJlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 05:41:22 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 791511E6ED;
	Fri,  7 Sep 2007 11:41:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8391B1135; Fri,  7 Sep 2007 11:41:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fbqmdu$udg$1@sea.gmane.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58011>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2007 at 05:09:26AM +0000, Walter Bright wrote:
> Linus Torvalds wrote:
> >And if you want a fancier language, C++ is absolutely the worst one to=
=20
> >choose. If you want real high-level, pick one that has true high-level=
=20
> >features like garbage collection or a good system integration, rather=20
> >than something that lacks both the sparseness and straightforwardness of=
=20
> >C, *and* doesn't even have the high-level bindings to important=20
> >concepts. IOW, C++ is in that inconvenient spot where it doesn't help=20
> >make things simple enough to be truly usable for prototyping or simple=
=20
> >GUI programming, and yet isn't the lean system programming language that=
=20
> >C is that actively encourags you to use simple and direct constructs.
>=20
> The D programming language is a different take than C++ has on growing C.=
=20
> I'm curious what your thoughts on that are (D has garbage collection,=20
> while still retaining the ability to directly manage memory). Can you=20
> enumerate what you feel are the important concepts?

  Well, to me D has two significant drawbacks to be "ready to use". The
first one is that it doesn't has bit-fields. I often deal with bit-fields
on structures that have a _lot_ of instances in my program, and the
bit-field is chosen for code readability _and_ structure size efficiency.
I know you pretend that using masks manually often generates better
code. But in my case, speed does not matter _that_ much. I mean it does,
but not that this micro-level as access to the bit-field is not my
inner-loop.

  The other second issue I have, is that there is no way to do:
  import (C) "foo.h"

  And this is a big no-go (maybe not for git, but as a general issue)
because it impedes the use of external libraries with a C interface a
_lot_. E.g. I'd really like to use it to use some GNU libc extensions,
but I can't because it has too many dependencies (some async getaddrinfo
interface, that need me to import all the signal events and so on
extensions in the libc, with bitfields, wich send us back to the first
point).


  I also have a third, but non critical issue, I absolutely don't like
phobos :) Though I'm obviously free to chose another library. D has
definitely many many many real advances over C (like the .init, .size,
=2E.. and so on fields, known types, and whatever portability nightmare
the C impose us). In fact I like to use D like I code in C, using
modules and functions, and very few classes, as few as I can. And even
(under- ?) using D like this, it is a real pleasure to work with. I'm
really eager to see gdc be more stable.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4RzAvGr7W6HudhwRAvZeAKCU/sf0RS92dpcUU8ZA4yp7FLu+TgCgjSFP
GzalopR6BZ+fyB8cpSLRa4k=
=gb1i
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
