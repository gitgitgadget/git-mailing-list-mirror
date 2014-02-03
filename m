From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [WIP/PATCH 7/9] submodule: teach unpack_trees() to remove
 submodule contents
Date: Mon, 3 Feb 2014 12:10:52 -0800
Message-ID: <20140203201052.GB16057@odin.tremily.us>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
 <52CC3E16.4060909@web.de>
 <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
 <52EFF25E.6080306@web.de>
 <52EFF391.7040503@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:11:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPr9-00027V-KW
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbaBCUKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:10:55 -0500
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:41278
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaBCUKy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Feb 2014 15:10:54 -0500
Received: from omta08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id Mr7A1n0030Fqzac54wAuoD; Mon, 03 Feb 2014 20:10:54 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta08.westchester.pa.mail.comcast.net with comcast
	id MwAs1n00i152l3L3UwAtg0; Mon, 03 Feb 2014 20:10:54 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 65FA1FC4A72; Mon,  3 Feb 2014 12:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1391458252; bh=bZGQ2UCTNGPK6hbOrp4zlLoc6KkKNKEKZi6SoFwrkRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BmU/Rb1w3yDV21o2ezDRww/P0aPtQBXpmjlKrIXR/iJQ3P/IIvJ3eLLr/OE4+2yEC
	 GqJKDpJNYce6vc8hYrR06CTva7YA+zJKXM7Taj8SOA5urrFC38Yq0CT0bhIQT6VV6s
	 4AJW2UZGyxi1EsX6GgtlhYqn5xKd8xnuG1k3hOBs=
Content-Disposition: inline
In-Reply-To: <52EFF391.7040503@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1391458254;
	bh=mX50CM1hsXxMdhvh4eE5j1rKS9bDSLNz44X11tJwyys=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=YLibwnw3dMlrwiezF9epbhtx1268h7N/yWd/o1wIDXmh2/dvq5Yoe9QSLg4KEEwaT
	 sil5qYGOSZ2Q6Zt8jEe+cMgQ/bNYGbi+Kpx5p8H0jnw/lfo04+dskLQb6VvIlnc0DO
	 HdzurcWu9dNNnKol7HOKD+KWNLbiRJ8ldLeYlPKfJzo3SkeHNBd2BZ/vq8Ag6iOeBG
	 YyzfDHUQ1Gs7EspuYPqY8xlBsBU70hCv6AECKlJTdeCeuWw4Kxp4DXnyfyzToIlesE
	 SgYcc/tXK3K4slM0bFUsv4lP3s1IeegE7pmuQULQjizoLqy9zIFwa67y9hJM2ilOxZ
	 L9ZRXZDJFcIBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241470>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2014 at 08:52:49PM +0100, Jens Lehmann wrote:
> Implement the functionality needed to enable work tree manipulating
> commands to that a deleted submodule should not only affect the index
> (leaving all the files of the submodule in the work tree) but also to
> remove the work tree of the superproject (including any untracked
> files).
>=20
> That will only work properly when the submodule uses a gitfile instead of
> a .git directory and no untracked files are present. Otherwise the removal
> will fail with a warning (which is just what happened until now).

I'm having trouble parsing this one.  How about:

  Add a depopulate_submodule helper which removes the submodule
  working directory without touching the index.  This will only work
  properly when the submodule uses a gitfile=E2=80=A6

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7/fLAAoJEKKfehoaNkbtGrkP/A8IxrKnaIlezm1xzYCfC+ZU
QnGrhn1BDL8fnJwrueY/J0k/ruRYLjsiHfGMCPwcMntwq/PxzhHPAeQTj6pOlvBG
4bftIIKWk8H6qVUjcMKAYBjTwuExcIMRxlnLzWHLNlEsabnMJgxE6YlBEKWwHwLX
VkM+WZJkf2zTykB3kEH2cGK1KaiCZarP+ys9YUkySp+XXAi1KzYurC2ADEAIC3kR
R6IONyg0BZ6iK0AvDC0i86zH5YXF+Km5K+lDrUez2j5Jp1O2pvfOhUPEL984apuK
T+hbPjxCRihLLXbZ9yeiezzXYnCWNbGCEHOlF16/tVbkx313Oze6/7oMJXeN7YG3
FqcrdYUjUZVqL0KcensS0w15Cm/gd2+GXJ2vFACMSY58tx4nNH+lU7rAX8JdbZMg
2phCGzeX00m+ayx1rOn6Y9pzF7WQcuWzz3zzc5ed8zsnPj0/FebcoPxFsLjr+3K8
RAD0erGXbHBPvCn29v/IFOe2tXBk3pvcI2YJ0HV+heJm5Aw5Rq5LZIZmaG0CPNFT
IXrl+QCmiNPYSI2ggqi/dVDelTedAy1PasVzGQn5b6+6hftMOQ1cHXgepXM/r8Ux
3dicotXgwD/O8b7zHU35EWelyPBk5V/s5xuZjVAzeTGyHgDETO6K8oZqVIyEJIZO
EYoq5D5Zqn05YCodmS3F
=Yjaj
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
