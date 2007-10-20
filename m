From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH-resent] gitk: fix in procedure drawcommits
Date: Sat, 20 Oct 2007 20:35:33 +0200
Message-ID: <20071020183533.GC8887@efreet.light.src>
References: <20071019052823.GI14735@spearce.org> <200710191544.22228.barra_cuda@katamail.com> <18201.54648.707559.480169@cargo.ozlabs.ibm.com> <200710201802.48111.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, pdmef@gmx.net
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 20:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjJAv-0006Zm-3Z
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 20:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757185AbXJTSfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 14:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757071AbXJTSfl
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 14:35:41 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:44554 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968AbXJTSfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 14:35:40 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id ABD40572DA;
	Sat, 20 Oct 2007 20:35:39 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 4Umo8gJVLquw; Sat, 20 Oct 2007 20:35:37 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 15B7E57244;
	Sat, 20 Oct 2007 20:35:37 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IjJAb-0004eB-RV; Sat, 20 Oct 2007 20:35:33 +0200
Content-Disposition: inline
In-Reply-To: <200710201802.48111.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61848>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 20, 2007 at 18:02:47 +0200, Michele Ballabio wrote:
> IIRC, I just cloned mutt's hg repo:
>   hg clone http://dev.mutt.org/hg/mutt
> then imported it in git with the scripts at
>   http://repo.or.cz/w/fast-export.git
> with
>   hg-fast-export.sh -r ../mutt
> [...]
>=20
> Here is the culprit (or so I think). One of the guilty commits is:
>=20
> 	commit a3b4383d69e0754346578c85ba8ff7c05bd88705
> 	tree 1bf99cd22abe97c59f8c0b7ad6b8244f0854b8af
> 	parent 6d919fccf603aba995035fa0fb507aa2bd3bf0ae
> 	parent 6d919fccf603aba995035fa0fb507aa2bd3bf0ae
> 	author Brendan Cully <brendan@kublai.com> 1179646159 -0700
> 	committer Brendan Cully <brendan@kublai.com> 1179646159 -0700
> =09
> 	    Forget SMTP password if authentication fails.
> 	    Thanks to Gregory Shapiro for the initial patch (I've moved the reset
> 	    from smtp_auth_sasl up to smtp_auth, and used the account API
> 	    instead of twiddling account bits by hand). Closes #2872.

Judging from the symptoms, I would suspect hg-fast-export. Either mercurial
sometimes stores two same hashes instead of the hash and 0 (in which case
hg-fast-import should probably be ready to deal with it), or hg-fast-import
does something wrong when it sees the 0 parent.

> This commit (and many others) has two parents, but the two parents
> have the same hash. So gitk tries to unset the same variable twice,
> hence the error. At this point, the fix for gitk should be either to
> check if the parents have the same hash when reading the commit or
> avoiding to unset two times the same variable.
>=20
> This explanation makes sense to me, now the problem is: have I messed
> up the import myself, the scripts/commands used are to blame, or is
> it entirely the original repo's fault?
>=20
> Since I've redone the import and the error remains, I guess
> that's not my fault :)

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGkp1Rel1vVwhjGURAtJWAKDaQPWha3m//+kz0rqmzfBl9PA9DACdF9Qo
B8B+J732xLTTlQ72S1b3poo=
=RhVP
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
