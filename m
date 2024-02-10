Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [88.99.235.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACA51C4F
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.235.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707595322; cv=none; b=SZ1rGbKXaXVNHS2xaTCJv+LJ45zqRqm++EZyqY5bREcQydPwKFlXx8vVCK+mcWLLZZDL8Yu3K1rRPYcespBV2d6w7JwtMrf2we/6za500skCRISSCsWBm7GucMk9BAOxNltY2eCiYvhTBFnpWbjJ2gDSRH+wYiSHJ4fpRLAHBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707595322; c=relaxed/simple;
	bh=DFU9v0itplzikoumtr3KhaMTTfV9zKvT3Fg7NCbzT3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F05KuYpa44/ra4cBUVbUmNSPa7pqcrmQWdH9YO+ye+FpR0BGcZStUg1X9xTwYLG1mp7m2ji2GKyRQ/+hpphK/5SIYHsucPlcXK5T//HbiNNvnKp4W3pwhYavrVAgiaXaO3gOW+M4ivg3z5exSTIJboDt3yY/mTLD2KFHCm6RDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=eworm.de; arc=none smtp.client-ip=88.99.235.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eworm.de
Received: from leda.eworm.net (p200300Cf2F303c0070a407264768c153.dip0.t-ipconnect.de [IPv6:2003:cf:2f30:3c00:70a4:726:4768:c153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 99D8324803C;
	Sat, 10 Feb 2024 21:01:56 +0100 (CET)
Date: Sat, 10 Feb 2024 21:01:55 +0100
From: Christian Hesse <list@eworm.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>, Git Mailing List
 <git@vger.kernel.org>, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <20240210210155.71fa163d@leda.eworm.net>
In-Reply-To: <xmqqeddlckqa.fsf@gitster.g>
References: <20240209222622.102208-1-list@eworm.de>
	<xmqqil2xcl9e.fsf@gitster.g>
	<xmqqeddlckqa.fsf@gitster.g>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2c=Y8xJxk47OEbtS_v1S=mw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2c=Y8xJxk47OEbtS_v1S=mw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Fri, 2024/02/09 14:54:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Christian Hesse <list@eworm.de> writes:
> > =20
> >> From: Christian Hesse <mail@eworm.de>
> >>
> >> We had this fixed in 3307f7dde2ae8f5281d0782f7291a073c9b1cdc2,
> >> and it broke again in eea0e59ffbed6e33d171ace5be13cde9faa41639. =20
> >
> > Thanks, already reported and fixed, I believe? =20
>=20
> Oops, missing link:
>=20
> https://lore.kernel.org/git/pull.1664.git.git.1706833113569.gitgitgadget@=
gmail.com/

Sorry, missed that... Probably because the breakage went into 2.43.1, but t=
he
upstream fix did not. So sorry for the noise.

Anyway... does it make sense to move the include into the condition?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/2c=Y8xJxk47OEbtS_v1S=mw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmXH1jMACgkQiUUh18yA
9HaLowf6At5l/vXKNaRx79gbSf/UIKk3klJu739+jX2OGkm5ZrtugAVby1jd5yMw
RUMD3hn5Wyqy+b7gCJJQj4qT4qUUD+llwpQu47ZSlpjJ1rvsbd664eiNU5sWA6U6
GJhpBGPdy2sL84TuFvVoa3nxApln99FRGXp0wUvYQwUHZHZrU9sNTS7Z/WuH9PjM
mSYgd4g04JEr1RpYk1xfASbcpz1JJrCX7KV3+0axXWFeXALNzra9WVH7RG/2aYcJ
cHFuhmIighmjHrs00MhkYl34AtBZZAJNCYYKlmlp5fObezF7hXWZ1fY+j1yVuABF
ygQEGbciJrrIRBGwdhMMABH7PGv7zg==
=sa3E
-----END PGP SIGNATURE-----

--Sig_/2c=Y8xJxk47OEbtS_v1S=mw--
