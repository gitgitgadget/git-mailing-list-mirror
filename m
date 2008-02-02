From: "Stefan (metze) Metzmacher" <metze@samba.org>
Subject: Strange behavior with git rebase (-i)
Date: Sat, 02 Feb 2008 11:44:04 +0100
Message-ID: <47A44974.7050907@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1DDBBE82E28DD04315894E1A"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 12:13:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLGJH-0002Sl-Mh
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 12:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbYBBLMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 06:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbYBBLMv
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 06:12:51 -0500
Received: from ip-217-172-181-76.mx-netz.de ([217.172.181.76]:34410 "EHLO
	mail.mx-netz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbYBBLMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 06:12:50 -0500
X-Greylist: delayed 1661 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2008 06:12:50 EST
Received: from [172.30.76.9] (unknown [172.30.76.9])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(SASL METHOD:[PLAIN] USERNAME:[metze])
	by mail.mx-netz.de (SMTP-MAIL-SERVER) with ESMTP id 5CF9820C54C
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 11:45:04 +0100 (CET)
User-Agent: Thunderbird 1.5.0.14 (X11/20060911)
X-Enigmail-Version: 0.94.4.0
OpenPGP: id=0E53083F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72261>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DDBBE82E28DD04315894E1A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I just hit a really strange thing:

I was on a branch called 'v4-0-test',
then I did a git rebase -i orgin/v4-0-test
and removed some patches and prefixed all others
with 'edit'.
Then:

git commit --amend
git rebase --continue
git commit --amend
git rebase --continue
git commit --amend
git commit --amend (again)
git branch
 * v4-0-test
git log
 (this showed what I wanted)
git show -p --stat
 (to really make sure that the top revision is the one I want)
git push origin v4-0-test
 And this pushed the top revision BEFORE the rebase!!!
 Because I forgot a 'git rebase --continue' to finalize the rebase.

In the end it's my fault, because I forgot the last rebase --continue,
but I think it's bad that git behaves that way.

Would it be possible to disable some operations while others
are unfinished, git am (-i) might have similar effects.

I was using git 1.5.3.2

Could it be that 6fd2f5e60d4d574ff9e5dd8ce1e229328c785d69 was
created to fix a similar problem?

metze

http://gitweb.samba.org/?p=3Dsamba.git;a=3Dcommit;h=3Dec0ee2aa5f4bef32f09=
a426d91c28c985f843038
and the 10 commits before...:-(



--------------enig1DDBBE82E28DD04315894E1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHpEl5m70gjA5TCD8RAte3AJ4wKPMELvs1J6UUW3ZFSHubziCYkwCgom04
EPK1kkJTB5ArCmQFFyM6jb8=
=KsM/
-----END PGP SIGNATURE-----

--------------enig1DDBBE82E28DD04315894E1A--
