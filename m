From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] prune: --expire=time
Date: Sat, 20 Jan 2007 13:06:19 +0100
Message-ID: <45B205BB.7010101@fs.ei.tum.de>
References: <20070118171830.GA13521@moooo.ath.cx>	<20070118172408.GG15428@spearce.org>	<20070118174244.GA14287@moooo.ath.cx>	<20070118175134.GH15428@spearce.org>	<20070118222919.GA22060@moooo.ath.cx>	<7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>	<20070119034404.GA17521@spearce.org>	<20070119104935.GA5189@moooo.ath.cx> <7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF66167E1F2D4CE8F498305F8"
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 20 13:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8EzN-0001vk-Ix
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 13:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbXATMG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 07:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbXATMG2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 07:06:28 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:52704 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965264AbXATMG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 07:06:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id A832F280D2;
	Sat, 20 Jan 2007 13:06:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id tw-iL7cmLyRZ; Sat, 20 Jan 2007 13:06:25 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-207.dynamic.mnet-online.de [62.216.203.207])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 31F6E280A7;
	Sat, 20 Jan 2007 13:06:25 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37270>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF66167E1F2D4CE8F498305F8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
>> Things I'm not sure about, any further comments/discussion?
>> - default value for gc.pruneexpire
>> - special value(s) for gc.pruneexpire/--expire which mean 'do not
>>   check for the age', currently it is 'off'
>=20
> No single timeout value can be the right timeout for everybody,
> so a big debate is not useful here.  I think 1 day as you and
> Shawn did makes sense.

Not that I want to sabotage this discussion, but you have a very valid po=
int.  A timeout can always be crossed, and then bad things[tm] happen.

My idea is to create a marker file when creating (yet) unconnected loose =
objects, i.e. on commit/push/fetch.  After the ref was updated or on abor=
t, this marker would be removed.  Prune then can simply search for the ol=
dest marker and only remove objects older than this marker.

Of course this also can mean that a marker file somehow stays and prune f=
ails to clean properly, but that's still better than accidentially cleani=
ng too much.  In the case of dangling marker files, the admin would simpl=
y remove them.  rm .git/marker/* when the repo is quiet.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigF66167E1F2D4CE8F498305F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsgW+r5S+dk6z85oRAjubAKCDKTVmfGS8efRvnUclylIu0Jxb3ACfVDXI
8HJQJw8mjUhRnpUn8v8aqOc=
=SoXV
-----END PGP SIGNATURE-----

--------------enigF66167E1F2D4CE8F498305F8--
