From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] builtin-merge: missing structure bzero.
Date: Mon, 21 Jul 2008 20:18:50 +0200
Message-ID: <20080721181850.GA2718@artemis.madism.org>
References: <1216659830-22063-1-git-send-email-madcoder@debian.org> <20080721172119.GE32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ibTvN161/egqYuK8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:20:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzzK-0004Ku-K0
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYGUSSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbYGUSSx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:18:53 -0400
Received: from pan.madism.org ([88.191.52.104]:44644 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbYGUSSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:18:52 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C63723166B;
	Mon, 21 Jul 2008 20:18:51 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DEDA9E55C4; Mon, 21 Jul 2008 20:18:50 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20080721172119.GE32057@genesis.frugalware.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89378>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2008 at 05:21:19PM +0000, Miklos Vajna wrote:
> On Mon, Jul 21, 2008 at 07:03:50PM +0200, Pierre Habouzit <madcoder@debia=
n.org> wrote:
> > This cause segfaults when replacing a directory with a submodule in a
> > fast-forward.
>=20
> Thanks.
>=20
> > +test_expect_failure 'Replace a directory with a submodule, with a file=
 conflict' '
> > +	mkdir test &&
> > +	cd test &&
> > +	: create our repository with a sub/a file &&
> > +	git init &&
> > +	mkdir sub && echo a > sub/a &&
> > +	git add sub && git commit -asm"initial repository" &&
> > +	: save this state in a new branch &&
> > +	git branch temp &&
> > +	: then replace sub with it &&
> > +	git rm -rf sub &&
> > +        git submodule add -- "$(pwd)/../submodule/.git/" sub &&
> > +	git commit -asm "replace sub/ with a submodule" &&
> > +	: then try to update the "temp" branch &&
> > +	git checkout temp &&
>=20
> It seems this one fails. I guess this will be a problem in the low-level
> merge code (read-tree -m) and not in builtin-merge.

  Yeah, I saw that afterwards, the error was misleading (as it tells
about some "merge" issue), but when I tried to debug it, it was indeed
in git checkout. The easiest way to reproduce, is to have a submodule
that replace a file that was previously versionned (which is something
that will happen in real life when you take out a subdirectory of a
project to make it live into a submodule) and that you then git checkout
HEAD~1.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiE0wkACgkQvGr7W6HudhzTLwCgmGBWav6X/euBuKrBNd/1Z+v6
2hMAnje5ZmUquhRekSt9I8CDd9d6kWZd
=YKO5
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
