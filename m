From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 13:19:31 +0200
Message-ID: <20080723111931.GF15243@artemis.madism.org>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="xs+9IvWevLaxKUtW";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 13:20:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLcOZ-0004bq-T6
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 13:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbYGWLTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 07:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbYGWLTf
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 07:19:35 -0400
Received: from pan.madism.org ([88.191.52.104]:53766 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbYGWLTe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 07:19:34 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 21D443A5DA;
	Wed, 23 Jul 2008 13:19:32 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9C9BF15432E; Wed, 23 Jul 2008 13:19:31 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89631>


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 10:49:04AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 23 Jul 2008, Bj=C3=B6rn Steinbrink wrote:
>=20
> > On 2008.07.23 01:17:45 +0200, Pierre Habouzit wrote:
> > >   Hi, here is a manual painful down-secting (opposed to a bisect ;P) I
> > > did, since git in next cannot fetch on a regular basis for me. The
> > > culprit seems to be commit  92392b4:
> > >=20
> > >     =E2=94=8C=E2=94=80(1:11)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4.=
=2E..>=E2=94=80=E2=94=80
> > >     =E2=94=94[artemis] git fetch
> > >     remote: Counting objects: 461, done.
> > >     remote: Compressing objects: 100% (141/141), done.
> > >     remote: Total 263 (delta 227), reused 155 (delta 121)
> > >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> > >     fatal: Out of memory, malloc failed
> > >     fatal: index-pack failed
> > >     [2]    16674 abort (core dumped)  git fetch
> > >=20
> > >     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 92392b4.=
=2E..>=E2=94=80=E2=94=80
> > >     =E2=94=94[artemis] git checkout -m HEAD~1; make git-index-pack
> > >     Previous HEAD position was 92392b4... index-pack: Honor core.delt=
aBaseCacheLimit when resolving deltas
> > >     HEAD is now at 03993e1... index-pack: Track the object_entry that=
 creates each base_data
> > >     GIT_VERSION =3D 1.5.6.3.3.g03993
> > > 	CC index-pack.o
> > > 	LINK git-index-pack
> > >=20
> > >     =E2=94=8C=E2=94=80(1:12)=E2=94=80=E2=94=80<~/dev/scm/git 03993e1.=
=2E..>=E2=94=80=E2=94=80
> > >     =E2=94=94[artemis] git fetch
> > >     remote: Counting objects: 461, done.
> > >     remote: Compressing objects: 100% (141/141), done.
> > >     remote: Total 263 (delta 227), reused 155 (delta 121)
> > >     Receiving objects: 100% (263/263), 95.55 KiB, done.
> > >     Resolving deltas: 100% (227/227), completed with 153 local object=
s.
> > >     From git://git.kernel.org/pub/scm/git/git
> > >        5ba2c22..0868a30  html       -> origin/html
> > >        2857e17..abeeabe  man        -> origin/man
> > >        93310a4..95f8ebb  master     -> origin/master
> > >        559998f..e8bf351  next       -> origin/next
> > >=20
> > > You can see the commit sha's in the prompt. 03993e1 is fine, 92392b4 =
is
> > > broken, I've absolutely no clue about what happens.
> > >=20
> > > All I can say is that at some point in get_data_from_pack, obj[1].idx
> > > points to something that is *not* a sha so it's probably corrupted.
> > > (from index-pack.c).
> >=20
> > Here's how to reproduce:
>=20
> Funny.  That does not reproduce the bug here at all.
>=20
> But then, it is unsurprising, since both Pierre and me did something=20
> similar yesterday, fetching _just_ the pre-fetch refs into a freshly=20
> initted Git repository, and then fetching from kernel.org.
>=20
> Tested on x86_64.

I can reproduce on x86_64 here. And I think I get the problem, and IMHO
the pruning thing is flawed. We need more than *one* base to be kept at
a time, pruning is too aggressive, and we still keep pointers to
actually pruned data.

This patch makes the issue non reproducible for me. The rationale is
that get_base_data will already prune and is called as often, and in
safer places.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/index-pack.c b/index-pack.c
index ac20a46..5440e43 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -245,7 +245,6 @@ static void link_base_data(struct base_data *base, stru=
ct base_data *c)
 	c->base =3D base;
 	c->child =3D NULL;
 	base_cache_used +=3D c->size;
-	prune_base_data(c);
 }
=20
 static void unlink_base_data(struct base_data *c)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

*But* I'm absolutely not sure it's enough. This should be written using
reference counting instead of the "retain" hack, and prune should not
free() anything that isn't with a 0 reference counter. The current code
is brittle, it makes my head explode when I try to understand if the
get_base_data() we temporarily keep pointers too may be harmed or not.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHE8MACgkQvGr7W6HudhzzqwCeJ449u80Wy45BqMezIxsVjj0M
rvgAn1Icneh0vCSibAuo/zOrXAzagPQJ
=iQee
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
