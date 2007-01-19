From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 11:10:46 +0100
Message-ID: <45B09926.5060306@fs.ei.tum.de>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>	 <45B07875.9030506@fs.ei.tum.de>	 <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>	 <45B07C26.4000008@fs.ei.tum.de>	 <81b0412b0701190032w686c9403uacd9b3e1e44be307@mail.gmail.com>	 <45B0898B.5040804@fs.ei.tum.de> <81b0412b0701190133o70ab9da3ga0441e9ca16991a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDDC21F1DC428C37D6E44BB73"
Cc: Junio C Hamano <junkio@cox.net>,
	Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 11:11:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7qi3-0007eh-DP
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 11:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbXASKKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 05:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbXASKKy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 05:10:54 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:34063 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965048AbXASKKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 05:10:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id A9F5228177;
	Fri, 19 Jan 2007 11:10:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ctJoZiPrFStO; Fri, 19 Jan 2007 11:10:50 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-208-62.dynamic.mnet-online.de [62.216.208.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id BECBC28120;
	Fri, 19 Jan 2007 11:10:49 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701190133o70ab9da3ga0441e9ca16991a9@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37171>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDC21F1DC428C37D6E44BB73
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Alex Riesen wrote:
>> >> i would claim .git to be off limits and unrelated to the working di=
r
>> >> (file-wise).  if you want to list files there, do a find . or so.
>> >>  After all you wouldn't expect cd /usr && git-ls-files -o work ther=
e
>> >> unless you have a /.git or /usr/.git, right?
>> > Right, just see no practical point changing ls-file for that.
>> right.  .git should be forbidden in higher layers already.
>=20
> That's where I disagree. git-clean shouldn't clean it, but
> git-ls-files will do no harm to the directory

of course git-ls-files will do no harm.  but "fixing" every consumer of g=
it-ls-files seems wrong to me.

okay, what do I expect when doing cd .git && git-ls-files?  Either listin=
g *all files* in the repo (like git-ls-files from the repo root) or no fi=
les at all, or failure (".git is private").

To add some facts to it:

GIT-LS-FILES(1)                                                GIT-LS-FIL=
ES(1)

NAME
       git-ls-files - Information about files in the index/working direct=
ory

That's pretty clear to me.  Working directory.  .git is *not* part of the=
 working directory.


>> > I can imagine keeping hooks under git control.
>> > In this case path(pwd) does contain .git component
>> > (as in .hg example).
>>
>> doesn't work either:
>>
>> % cd .git/hooks
>> % git add *
>> fatal: unable to add .git/hooks/applypatch-msg to index
>=20
> cd .git
> git init
> git add .
> git commit
>=20
> Works. And the path contains .git component. And git-clean
> here is ok. The test should check if we are in $GIT_DIR
> and probably $GIT_DIR/{objects,refs,logs}, not just below
> .git (with ".git" anywhere in pwd, which the mercurial
> example seem to suggest).

No, the path does *not* contain a .git component.  You just committed to =
the root of the *inside* repo.

Of course I don't say "refuse operation if there is .git in the path".  W=
hat I mean is, "refuse operation if there is $GIT_DIR in the path".  Mayb=
e my example was not complete enough.  With mercurial, you can as well ha=
ve a .hg in .hg.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigDDC21F1DC428C37D6E44BB73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsJkor5S+dk6z85oRAjIiAKD272mq/3FwGE35p6RkwWOHbe+X4wCgqN3y
49sN5bqFTnlr1J1go9z3ozY=
=pbxn
-----END PGP SIGNATURE-----

--------------enigDDC21F1DC428C37D6E44BB73--
