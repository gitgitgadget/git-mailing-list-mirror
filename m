From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: Can Git push only first parent history commits?
Date: Sun, 7 Dec 2008 22:03:20 -0600
Message-ID: <200812072203.24996.bss03@volumehost.net>
References: <402F4B33D9C9DE4083DB96B416549FAF9E12@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3943094.7L4HhZJl7F";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Li Frank" <Frank.Li@freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 05:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9XN6-0007Vo-FX
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 05:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbYLHED6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 23:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbYLHED6
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 23:03:58 -0500
Received: from eastrmmtao101.cox.net ([68.230.240.7]:34263 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414AbYLHED5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 23:03:57 -0500
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081208040356.WKRJ3950.eastrmmtao101.cox.net@eastrmimpo02.cox.net>;
          Sun, 7 Dec 2008 23:03:56 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo02.cox.net with bizsmtp
	id oU3v1a0052i4SyG02U3vbR; Sun, 07 Dec 2008 23:03:56 -0500
X-Authority-Analysis: v=1.0 c=1 a=ye3gwVpF5TkA:10 a=_pSJdreVZcEA:10
 a=nEQGfrJnAAAA:8 a=6Dc_-6f-jyVTjfcroNIA:9 a=3jnCehz7lQSBH1_7FWV1a92D1uoA:4
 a=gDjHQkheYgsA:10 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10
 a=CBQOs93cSQYmsbwfAQoA:9 a=7gfrpzORI3bJZ3v03YzkNBCdXggA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss03@volumehost.net>)
	id 1L9XLG-0002Fo-1H; Sun, 07 Dec 2008 22:03:30 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <402F4B33D9C9DE4083DB96B416549FAF9E12@zch01exm23.fsl.freescale.net>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102526>

--nextPart3943094.7L4HhZJl7F
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 07 December 2008, "Li Frank" <Frank.Li@freescale.com> wrote=20
about 'Can Git push only first parent history commits?':
>        The commit history is:
>        origin/master
>              Commit1..Commit2..Commit3(T1 branch).
>
>        I want to combined Commit1, Commit2 and Commit3 to one commit_X
>and push to origin master and keep old T1 branch history.  So I can't
>use rebase.  T1 branch history will be lost after rebase.

I'm pretty sure you want to do something like this:
git branch T2 T1
git rebase -i master T2
# Editor opens
# Edit commit list to squash 3 commits into 1.
git push origin T2:master
git fetch origin

At the end, you'll have a history that looks like:
*--> origin/master (T2)
 \
  -> C1 --> C2 --> C3 (T1)

I'm not sure why you'd want to do this though.  If the commits don't stand=
=20
alone well, they should be squashed on T1 before pushing.  If the commits=20
do stand alone well, the history should preserve them on master as well.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss03@volumehost.net                      ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.org/                      \_/    =20

--nextPart3943094.7L4HhZJl7F
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk8nIgACgkQ55pqL7G1QFl4EQCfSmOo2zZMucPAYhLMgnFDNDIk
9XoAnioBJqKLvb06+YAwJQmyzzoSKUX0
=GKXo
-----END PGP SIGNATURE-----

--nextPart3943094.7L4HhZJl7F--
