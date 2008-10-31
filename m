From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 00:33:18 +0100
Message-ID: <20081031233317.GA29036@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="EVF5PPMfhYS0aIcm";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:34:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3Vq-0001fn-JN
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbYJaXd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbYJaXd3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:33:29 -0400
Received: from pan.madism.org ([88.191.52.104]:33150 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbYJaXd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:33:28 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B188E3B764;
	Sat,  1 Nov 2008 00:33:24 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7B6D55EE243; Sat,  1 Nov 2008 00:33:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7viqr873x7.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99679>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 11:14:44PM +0000, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
>=20
> > My favorite license for a library is the GPL with the gcc exception,
> > i.e. what libraries coming with gcc are using.  They're GPL but with an=
=20
> > exception allowing them to be linked with anything.
>=20
> Although I'd be Ok with either GPL + gcc exception on whatever core-ish
> (i.e. what will be necessary for libgit2; "blame" would not count) pieces
> I have in C-git codebase, "can be linked with anything" allows a gaping
> hole to the library, which I'm a bit hesitant to swallow without thinking.

Well I wasn't thinking about anything else than what is needed for the
libgit2. I love BSDish for libraries, though like GPL for the actual
_tools_ I write with it.

> E.g.  our read_object() may look like this:
>=20
>          void *read_object(const object_name_t sha1,
>                            enum object_type *type,
>                            size_t *size)
>          {
>                  ...
>          }
>=20
>=20
> but an extension a closed-source person may sell you back may do:
>=20
>         +typedef void *read_object_fn(const object_name_t,
>         +                             enum object_type *,
>         +                             size_t *);
>         +read_object_fn read_object_custom =3D NULL;
>          void *read_object(const object_name_t sha1,
>                            enum object_type *type,
>                            size_t *size)
>          {
>         +       if (read_object_custom !=3D NULL)
>         +               return read_object_custom(sha1, type, size);
>                 ...
>          }
>=20
> I.e. use the supplied custom function to do proprietary magic, such as
> reading the object lazily from elsewhere over the network.  And we will
> never get that magic bit back.

Well, for one "we're" not supposed to accept any patch that does that,
and I don't expect that the people who end up maintaining libgit2 will
become rogue. Though if such bits of APIs do exist one day, then well, I
see no license except the GPL that can prevent you from that.


My idea of trying to be able to reuse git.git code is not a necessity,
a new implementation from scratch is likely to be possible. Though we
all know that if the core git contributors don't contribute and
eventually use libgit2 this will not fly. That's why we must think about
it.

I assume given your answer that if libgit2 is BSD you may not be as
motivated to contribute code to it as you are to git.git, and this IMHO
would be a big no-go, like shawn said in another mail.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLlb0ACgkQvGr7W6HudhwNPwCcCsfjzl9d4JSo1yAtnRn8NHJA
LDQAnjsu7zbbfvpiDn0WXhYA5Qs/r5h1
=KYU8
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
