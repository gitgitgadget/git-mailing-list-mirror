From: Joachim Breitner <mail@joachim-breitner.de>
Subject: Re: git-note -C changes commit type?
Date: Wed, 12 Feb 2014 08:53:38 +0000
Message-ID: <1392195218.2546.7.camel@kirk>
References: <1392139407.12790.7.camel@kirk>
	 <CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-a9/GC/MkkhJFRqKzXzb+"
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 09:53:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDVZl-0006pP-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 09:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbaBLIxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 03:53:45 -0500
Received: from hermes.serverama.de ([78.47.178.158]:34176 "EHLO
	hermes.serverama.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbaBLIxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 03:53:44 -0500
Received: from [10.254.1.12] (helo=kirk)
	by hermes.serverama.de with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <mail@joachim-breitner.de>)
	id 1WDVZd-0000lo-In; Wed, 12 Feb 2014 09:53:42 +0100
Received: from jojo by kirk with local (Exim 4.82)
	(envelope-from <mail@joachim-breitner.de>)
	id 1WDVZd-0000tT-1l; Wed, 12 Feb 2014 08:53:41 +0000
In-Reply-To: <CALKQrgcM7JpZCk4amjo_rwg5uuuWNg-5yd1NXB5p7EtrU9WBGg@mail.gmail.com>
X-Mailer: Evolution 3.8.5-2+b1 
X-Spam-Score: -7.6 (-------)
X-Spam-Report: Status No, score=-7.6 required=5.0 bayes=0.0000 tests=ALL_TRUSTED=-1,BAYES_00=-6.599 autolearn=ham version=3.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241976>


--=-a9/GC/MkkhJFRqKzXzb+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Johan,

Am Mittwoch, den 12.02.2014, 00:52 +0100 schrieb Johan Herland:
> On Tue, Feb 11, 2014 at 6:23 PM, Joachim Breitner
> <mail@joachim-breitner.de> wrote:
> > judging from the documentation I got the impression that I can pass any
> > git object has to "git note -C <hash>" and it would stored as-is. But i=
t
> > seems the objects gets mangled somehow...
>=20
> ...well... the documentation does not say "any object", it actually
> explicitly says "blob object"... ;)

ok, my bad; guess I=E2=80=99m not fully versed with gits terminology.

> You would have a notes ref "refs/notes/history" whose tree would
> contain an entry named e1bfac434ebd3135a3784f6fc802f235098eebd0
> pointing to a _commit_ (3d7de37...). Obviously, it would not make
> sense to use refs/notes/history while displaying the commit log ("git
> log --notes=3Dhistory"), as the raw commit object would be shown in the
> log. However, more fundamentally: a tree referring to a _commit_ is
> usually how Git stores _submodule_ links (i.e. which revision of the
> named submodule is to be used by this super-repo tree), and I'm (off
> the top of my head) not at all sure that such a submodule link in a
> notes tree is handled "sanely" by Git - or even that it makes sense at
> all. For one, I'm not sure that Git requires (or even expects) the
> commit object referenced by a tree to be present in the same object
> DB. So if you share your notes, I don't know whether or not the
> fetch/push machinery will include the commit object in the shared
> notes... These are questions that should be answered before we decide
> whether using commits directly as notes makes sense.

If that is the case, then my approach is indeed flawed. The main point
of the exercise is to have a tree that follows another commit (or, as a
next-best approximation, a note attached to that commit) around.

> In that case, you might be better off using an explicit
> ref to keep that history alive; e.g. you could create
> refs/history/e1bfac4 to point to 3d7de37 ("git update-ref
> refs/history/e1bfac4 3d7de37"), and keep everything
> alive/reachable/shareable that way...

That=E2=80=99s an interesting idea; instead of relying on the notes feature
putting the hash in the ref name. But I wonder how that scales =E2=80=93 im=
agine
every second feature merged into Linux=C2=B9 also having such a history ref=
?=20

I guess having a way for a tree to reference commits in a way that is
followed by git gc, i.e. separate from submodules, would allow a less
noisy implementation, and possibly create the opportunity for many other
strange uses of git :-)

Greetings,
Joachim

=C2=B9 I=E2=80=99m not proposing for anyone else but me to use this, at the=
 moment,
don=E2=80=99t worry :-). But I am considering to use it in the context of G=
HC,
which isn=E2=80=99t a small project either.

--=20
Joachim =E2=80=9Cnomeata=E2=80=9D Breitner
  mail@joachim-breitner.de =E2=80=A2 http://www.joachim-breitner.de/
  Jabber: nomeata@joachim-breitner.de  =E2=80=A2 GPG-Key: 0x4743206C
  Debian Developer: nomeata@debian.org

--=-a9/GC/MkkhJFRqKzXzb+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlL7NpIACgkQ9ijrk0dDIGxhFQCfVqx7Edxzb8Whu5o/ozWoHkUn
R0YAoLw3+XH8+VRCA31qyarnm+aKA4vT
=TBEr
-----END PGP SIGNATURE-----

--=-a9/GC/MkkhJFRqKzXzb+--
