From: William Giokas <1007380@gmail.com>
Subject: Re: [PATCH] clone: allow cloning local paths with colons in them
Date: Sat, 27 Apr 2013 15:08:42 -0500
Message-ID: <20130427200842.GA14994@WST420>
References: <20130422153516.GB11886@sigill.intra.peff.net>
 <1367033778-13923-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:08:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBQX-0005rn-DI
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab3D0UIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:08:52 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:32985 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab3D0UIv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:08:51 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so4480601iar.2
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KCHFF0zVpAB9AtqiMP0uBMB0elcbUvyjgCtlatrvzuU=;
        b=y6cMicch+5Be70ywZoMys+WonT2laJy/73yxHGC3bhzTnJhHmr9Qi3wCMD0Y/CF/eA
         n2kjAKcPD9TjPwHfBp0LVI+F/7tduD+okqHKZcpuardRx6KZUrIwJzwC8dgLcHDAndLE
         f6vT7DOVok9Q0Klai2FP36geUC6pDCZEie4TVjQ3QJ8Q6G/kfY3HvXwIheo3aLlnAqJN
         oOYKwjHqKUhg3CKUdo7ZkyfijY05poQlhy4MN4qEyIimo3+ukSHw8tzWw90fKzec1cqi
         TOEdB8R1ib2GVkpE1LBVYccyPtcskq4jPKDm06Y3H7hkDRme0cdSit/M6F+x4QpObWDZ
         OdGw==
X-Received: by 10.43.114.8 with SMTP id ey8mr26693897icc.6.1367093331477;
        Sat, 27 Apr 2013 13:08:51 -0700 (PDT)
Received: from localhost (adsl-99-141-239-27.dsl.emhril.sbcglobal.net. [99.141.239.27])
        by mx.google.com with ESMTPSA id ve9sm10258706igb.3.2013.04.27.13.08.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:08:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1367033778-13923-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222681>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2013 at 10:36:18AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> Usually "foo:bar" is interpreted as an ssh url. This patch allows to
> clone from such paths by putting at least one slash before the colon
> (i.e. /path/to/foo:bar or just ./foo:bar).
>=20
> file://foo:bar should also work, but local optimizations are off in
> that case, which may be unwanted. While at there, warn the users about
> --local being ignored in this case.
>=20
> Reported-by: William Giokas <1007380@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---

Working fine at the moment for the local clones (thank you). It looks
nice and clean, to me, and doesn't break any existing functionality I
have.=20

Though I did notice that if it is a local file, then you don't actually
need a `/` anywhere at all, because I think git looks to see that it is
a local file first. (This is totally fine, though.)

>  On Mon, Apr 22, 2013 at 10:35 PM, Jeff King <peff@peff.net> wrote:
>  > So I think one reasonable path would be:
>  >
>  > =C2=A0 1. Do not treat "host:path" as ssh if "host" has a slash, which=
 should
>  > =C2=A0 =C2=A0 =C2=A0not regress anybody. It does not allow unadorned r=
elative paths
>  > =C2=A0 =C2=A0 =C2=A0with colons, but it lets you use absolute paths or=
 "./" to
>  > =C2=A0 =C2=A0 =C2=A0disambiguate.
>  >
>  > =C2=A0 2. Teach git-clone to ask the transport code to parse the sourc=
e repo
>  > =C2=A0 =C2=A0 =C2=A0spec, and decide from that whether it is local or =
not. That would
>  > =C2=A0 =C2=A0 =C2=A0harmonize the implementations and avoid errors whe=
n you _did_ mean
>  > =C2=A0 =C2=A0 =C2=A0to use ssh, but "host:path" happens to exist in yo=
ur filesystem. I
>  > =C2=A0 =C2=A0 =C2=A0also would not be surprised if there are problems =
with
>  > =C2=A0 =C2=A0 =C2=A0URL-encoding, but maybe clone handles that properl=
y (I didn't
>  > =C2=A0 =C2=A0 =C2=A0check).
>  >
>  > And the "host contains slash" rule is pretty easy to explain in the
>  > documentation, which is good.
>=20
>  I totally agree with this. But doing #2 seems to require a bit of
>  code reorganization. How about just this for now?
>
>  Documentation/urls.txt | 6 ++++++
>  builtin/clone.c        | 2 ++
>  connect.c              | 7 +++++--
>  t/t5601-clone.sh       | 5 +++++
>  4 files changed, 18 insertions(+), 2 deletions(-)

Thank you,
--=20
William Giokas | KaiSforza
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRfDBKAAoJEGkCBthzzQnP/UIQAMkAHWBBKKJDB4dfnS38x9Tv
s+ZAvPiJHpHruKfKew7K+PhS+AAEqZrUgTrSrPKlK1N55HvUnIFI6xUOTG7JK58i
NIhJJJZNt/4Ay+MCd1CHQ5DCTEetn3KkZmwcpL+4v2tRTKCToV+BwM9pbXGrKFXA
EENEkjYIA6UkUCLm9Ira7JC5N4+nehyfehaSSsyjipeX9PHo2Y/iwJ7InA+E1/zd
WfNfBzptzgPatOVlCEvulvAeXKv68XJsoxmdnH4UxmakpVxxuWoQg9DJFHUfIxM7
evOgyftJq/kbhhCCC71qQAxCB90jsD9PjbvRyy1Sg8ggeIQaILgwvuVKU/jY1tje
Il26ear1czY6Gm0596hQPaSlSYVkG0R79cGbu6dMJ9WNB5BM7FRkKINw8/sGvdAr
U4W4BBxgb1SKp8ZHSRQ+IwKVwUIh+F2nf/zMhaiwGudrc1NrmkR1FGH0tdfWHE+i
EVXd4tala5qZStHmn4KgeWMSifGFbn7l2a4/oylJH3yQ3K3WCKp3tj8olMMnA+9b
feQzNDSNpODqD45jfvDI3M2bExyOBNLy+nwH8Z0go86fQ0HbxS/O1Frzjs7I6AkT
jQdcx5KsSJj+bdC8/Fdtk1rynlspPIQ6ruAE6dIE5fQFGrg0UU4RrUwIrPT/Cm+W
x4pjHDYNo/PU3Bx9AuD9
=rlzL
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
