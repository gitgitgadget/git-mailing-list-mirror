From: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: MIME problem when using git format-patch / git am
Date: Mon, 26 Apr 2010 01:35:49 +0200
Message-ID: <20100425233549.GA8737@triton>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Cc: sunny@sunbase.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 01:36:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6BN1-0006fl-3h
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 01:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab0DYXfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 19:35:53 -0400
Received: from smtp.domeneshop.no ([194.63.248.54]:52212 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0DYXfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 19:35:52 -0400
Received: from sfn-inkubator-70-227.hib.no ([158.37.70.227] helo=triton)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <sunny@sunbase.org>)
	id 1O6BMd-0004ju-9v; Mon, 26 Apr 2010 01:35:51 +0200
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
	git@vger.kernel.org
Content-Disposition: inline
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145774>


--l76fUT7nc3MelDdI
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a problem when using `git format-patch` and `git am` when there=20
are 8-bit (i.e. UTF-8) characters in the log message from line three and=20
below. I have attached a script (`runme.sh`) for reproducing this. It is=20
also available from <http://gist.github.com/378785> in case the=20
attachment is mangled.

My output is this:

    $ ./runme.sh
    LANG=3Den_GB.UTF-8
    LANGUAGE=3Den_GB.UTF-8
    LC_COLLATE=3DC
    LC_CTYPE=3Den_GB.utf8

    Initialized empty Git repository in /home/sunny/src/git/til_git-lista/d=
ir/.git/
    [master (root-commit) 2755112] Initial commit

    =3D=3D=3D=3D=3D=3D=3D=3D Create commits
    [master 9ab743b] First commit without 8-bit chars
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 foo.txt
    [master dd5bdf2] Second commit with =C2=A9 in first line of logmsg
     1 files changed, 1 insertions(+), 0 deletions(-)
    [master 82a445a] Third commit with no 8-bit in first line but =E2=82=AC=
uro further down
     1 files changed, 1 insertions(+), 0 deletions(-)
    [master 42881f1] Fourth commit with =C2=A9 in first line again
     1 files changed, 1 insertions(+), 0 deletions(-)

    =3D=3D=3D=3D=3D=3D=3D=3D git format-patch firstrev
    0001-First-commit-without-8-bit-chars.patch
    0002-Second-commit-with-in-first-line-of-logmsg.patch
    0003-Third-commit-with-no-8-bit-in-first-line.patch
    0004-Fourth-commit-with-in-first-line-again.patch

    =3D=3D=3D=3D=3D=3D=3D=3D Create new, empty branch and apply patches
    Switched to a new branch 'patches'
    Applying: First commit without 8-bit chars
    Applying: Second commit with =C2=A9 in first line of logmsg
    Applying: =3D?UTF-8?q?Third=3D20commit=3D20with=3D20no=3D208-bit=3D20in=
=3D20first=3D20line
    Applying: Fourth commit with =C2=A9 in first line again

    =3D=3D=3D=3D=3D=3D=3D=3D git log
    commit 58bcf14aee4b17152ae1f8bd40a24141e93897ec
    Author: =C3=98yvind A. Holm <sunny@sunbase.org>
    Date:   0 seconds ago

        Fourth commit with =C2=A9 in first line again

    commit 56e98bd6b161510687abd658728f92b3bd85baf1
    Author: =C3=98yvind A. Holm <sunny@sunbase.org>
    Date:   1 seconds ago

        =3D?UTF-8?q?Third=3D20commit=3D20with=3D20no=3D208-bit=3D20in=3D20f=
irst=3D20line

        =3D20but=3D20=3DE2=3D82=3DACuro=3D20further=3D20down?=3D
        MIME-Version: 1.0
        Content-Type: text/plain; charset=3DUTF-8
        Content-Transfer-Encoding: 8bit

    commit 55de5c9008c53a388439f0a0cdb2043d9a36ba6b
    Author: =C3=98yvind A. Holm <sunny@sunbase.org>
    Date:   1 seconds ago

        Second commit with =C2=A9 in first line of logmsg

    commit af6bf42a07208bc31d537a50562a5997f02e58cb
    Author: =C3=98yvind A. Holm <sunny@sunbase.org>
    Date:   1 seconds ago

        First commit without 8-bit chars

    commit 2755112f613687510803e45868751e7b85e3cd1e
    Author: =C3=98yvind A. Holm <sunny@sunbase.org>
    Date:   1 seconds ago

        Initial commit
    $

If it=E2=80=99s messed up (wordwrap and such), it=E2=80=99s also available =
=66rom=20
<http://gist.github.com/raw/378785/output.txt>.

In this case the log message of the third commit (56e98) is unreadable.=20
This only happens when there are characters above U+0080 in the log=20
message, but not in the first line, as that ends up as the subject. Yes,=20
I=E2=80=99ve also tried to remove the "=C3=98" from the author name, with s=
imilar=20
results.

I=E2=80=99m using `git format-patch`/`git am` as an easy way to import/expo=
rt=20
commits between repositories and directories, and I=E2=80=99m thinking that=
=20
these commands are probably not intended for that kind of use. Are there=20
any other method or some magic command line options that makes this=20
possible, or is this a bug?

    +-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.39548=C2=B0 E 5.3173=
5=C2=B0 |-+
    | OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
    | Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
    +------------| 1f818370-50c1-11df-ae95-90e6ba3022ac |-------------+

--Q68bSM7Ycu6FN28Q
Content-Type: application/x-sh
Content-Disposition: attachment; filename="runme.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Agit=3Dgit=0A=0A[ -e dir ] && { echo \"dir\" already exists. =
Remove it and try again. >&2; exit 1; }=0Aset | grep -e ^LC_ -e ^LANG=0Aech=
o=0A$git init dir=0Acd dir || { echo Cannot chdir >&2; exit 1; }=0A$git com=
mit -m "Initial commit" --allow-empty=0A$git tag firstrev=0Aecho; echo =3D=
=3D=3D=3D=3D=3D=3D=3D Create commits=0Aecho First line >foo.txt=0A$git add =
foo.txt=0A$git commit -m "First commit without 8-bit chars"=0Aecho Second l=
ine >>foo.txt=0A$git commit -m "Second commit with =C2=A9 in first line of =
logmsg" -a=0Aecho Third line >>foo.txt=0A$git commit -m "Third commit with =
no 8-bit in first line`echo; echo but =E2=82=ACuro further down`" -a=0Aecho=
 Fourth line >>foo.txt=0A$git commit -m "Fourth commit with =C2=A9 in first=
 line again" -a=0Aecho; echo =3D=3D=3D=3D=3D=3D=3D=3D $git format-patch fir=
strev=0A$git format-patch firstrev=0Aecho; echo =3D=3D=3D=3D=3D=3D=3D=3D Cr=
eate new, empty branch and apply patches=0A$git checkout -b patches firstre=
v=0A$git am 0*=0Aecho; echo =3D=3D=3D=3D=3D=3D=3D=3D $git log=0A$git log=0A
--Q68bSM7Ycu6FN28Q--

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvU0dUACgkQ+wy+6JSlBuVuPQCePZ2Jw9cImdGgkdq6poFK0915
BbAAn1z1KV1CGR5d/RkSje72pDY6yysc
=+l6E
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
