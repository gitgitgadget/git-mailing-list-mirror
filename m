From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How to bypass the post-commit hook?
Date: Mon, 31 Dec 2007 10:31:52 +0100
Message-ID: <20071231093152.GC20098@efreet.light.src>
References: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com> <20071230215008.GB20098@efreet.light.src> <46dff0320712302108i61f3b868obb93f89c1c24062c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 10:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9H0U-0007As-GS
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 10:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbXLaJcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 04:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbXLaJcB
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 04:32:01 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:50665 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbXLaJcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 04:32:00 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 4D2F2572A9;
	Mon, 31 Dec 2007 10:31:59 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id EFiib9Z2UPsQ; Mon, 31 Dec 2007 10:31:56 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id B4FB257287;
	Mon, 31 Dec 2007 10:31:55 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J9Gzw-0002GD-2F; Mon, 31 Dec 2007 10:31:52 +0100
Content-Disposition: inline
In-Reply-To: <46dff0320712302108i61f3b868obb93f89c1c24062c@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69395>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 31, 2007 at 13:08:05 +0800, Ping Yin wrote:
> On Dec 31, 2007 5:50 AM, Jan Hudec <bulb@ucw.cz> wrote:
> >
> > On Sun, Dec 30, 2007 at 23:12:12 +0800, Ping Yin wrote:
> > > --no-verify can bypass pre-commit hook? Then how to bypass post-commi=
t hook?
> > >
> > > Usually I want post-commit take effect. However, in the middle of
> > > git-rebase, i want to bypass post-commit when 'git-commit --amend'
> > > since my post-commit hooks will modify the working directory and so
> > > make following rebase troubesome.
> >
> > There does not seem to be an option to do it, but you can always tempor=
arily
> > disable it (unset the executable permission on it).
> >
> > By the way, what is your post-commit hook doing anyway? Modifying the w=
ork
> > tree *after* a commit does not sound like a common thing to do.
> >
> I have already considered disabling hook temporarily, but it is a
> little annoying.

Well, I guess noone thought it would be useful to disable it.

> I use post-commit because i don't find a better way to update imported
> css version automatically
>=20
> $ cat foo.css
> @import url(bar.css?57e708)
> ...
>=20
> When i modify bar.css and then commit it ( with blob sha1 bf7059)=EF=BC=
=8CI
> use post-commit to modify foo.css
> $ cat foo.css
> @import url(bar.css?bf7059)
> ...

But that file is not versioned, is it?

Because if it is, you want to commit it in the very same commit as bar.css
and therefore want to do it in the *pre*-commit hook. Since obviously the
foo.css wants to include the current version of bar.css, not the previous
one.

Note, that while you don't know the commit sha1 before the commit, you do
know the *blob* sha1s. So you can do this change in pre-commit hook.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHeLcIRel1vVwhjGURApSDAKC+7ndIgy/SxZ73HN6B/usVYIIjtwCfUJBd
aXj4dfOdZ4SuPPZy2dKKYIs=
=kQrh
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
