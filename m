From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [TESTCASE] Failing 'git am' when core.autocrlf=true
Date: Thu, 23 Aug 2007 22:11:21 +0200
Message-ID: <46CDE9E9.8070702@trolltech.com>
References: <46CD94AB.7070709@trolltech.com> <alpine.LFD.0.999.0708230956190.30176@woody.linux-foundation.org> <alpine.LFD.0.999.0708231153150.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE6ED333FB6EC25DACD31FAB0"
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:10:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJ0J-0001Ee-GZ
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322AbXHWUKD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 16:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758169AbXHWUKB
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:10:01 -0400
Received: from esparsett.troll.no ([62.70.27.18]:57243 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758032AbXHWUKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:10:00 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 09C817422D; Thu, 23 Aug 2007 22:09:59 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id E705F7420F; Thu, 23 Aug 2007 22:09:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <alpine.LFD.0.999.0708231153150.30176@woody.linux-foundation.org>
X-Enigmail-Version: 0.95.3
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56523>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6ED333FB6EC25DACD31FAB0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> So the call-chain for this is:
>=20
> 	cmd_write_tree ->
> 	  write_tree ->
> 	    write_index ->
> 	      ce_smudge_racily_clean_entry ->=20
> 		ce_modified_check_fs ->
> 		  ce_compare_data ->
> 		    index_fd ->
> 		      convert_to_git ->
> 			** wrong answer unless auto_crlf is set **
>=20
> 		and now "ce_smudge_racily_clean_entry()" will do
> 			ce->ce_size =3D htonl(0);
>=20
> and the one-liner fix I sent out is actually the right fix.
>=20
> This was harder to find than it should have been, because it
> actually depends on the datestamp of the index file matching the
> datestamp of the file in question!

Thanks for the detailed analysis of the chain of events. It
really helps understand the inner-workings of Git.

I also tried to track this down after your initial patch, but
couldn't find it. The fact that the index is smudged at the time of
the second commit, so the third failed, made me look in the wrong
place.

How about adding a trace for the smudged case, so it's easier to
find similar issues in the future?

--
=2Emarius


=46rom b858610ff4cd42f57a05c815a3e3b43428d67f99 Mon Sep 17 00:00:00 2001
From: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
Date: Thu, 23 Aug 2007 22:03:35 +0200
Subject: [PATCH] Add a trace to more easily show that the index has been =
smudged.

Signed-off-by: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
---
 read-cache.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 849e8d6..000451c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1088,6 +1088,7 @@ static void ce_smudge_racily_clean_entry(struct cac=
he_entry *ce)
 		 * for "frotz" stays 6 which does not match the filesystem.
 		 */
 		ce->ce_size =3D htonl(0);
+		trace_printf("trace: index: Index object for '%s' smudged due to being=
 racily clean\n", ce->name);
 	}
 }
=20
--=20
1.5.3.rc4.mingw.2.3.g3318a-dirty



--------------enigE6ED333FB6EC25DACD31FAB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGzenpKzzXl/njVP8RApTzAJoDKc+jghURanz7YoxLl5NFKg36FwCg5eWZ
5hbD/yKgaL9Q2AOmAapg6pw=
=kemV
-----END PGP SIGNATURE-----

--------------enigE6ED333FB6EC25DACD31FAB0--
