From: Keith Packard <keithp@keithp.com>
Subject: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 00:17:58 -0700
Message-ID: <1150269478.20536.150.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sjeqSSAEFaKDzX6WSHuW"
Cc: keithp@keithp.com
X-From: git-owner@vger.kernel.org Wed Jun 14 09:18:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqPe9-0003UJ-NP
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 09:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWFNHS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 03:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWFNHS0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 03:18:26 -0400
Received: from home.keithp.com ([63.227.221.253]:35602 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932219AbWFNHSZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 03:18:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 0CC6813001F;
	Wed, 14 Jun 2006 00:18:25 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26906-02; Wed, 14 Jun 2006 00:18:24 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 78CAF13001E; Wed, 14 Jun 2006 00:18:24 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 2876914001;
	Wed, 14 Jun 2006 00:18:24 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 7AFB76AC439; Wed, 14 Jun 2006 00:18:00 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21830>


--=-sjeqSSAEFaKDzX6WSHuW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

parsecvs scans every ,v file and creates a blob for every revision of
every file right up front. Once these are created, it discards the
actual file contents and deals solely with the hash values.

The problem is that while this is going on, the repository consists
solely of disconnected objects, and I can't make git-repack put those
into pack objects. This leaves the directories bloated, and operations
within the tree quite sluggish. I'm importing a project with 30000 files
and 30000 revisions (the CVS repository is about 700MB), and after
scanning the files, and constructing (in memory) a complete revision
history, the actual construction of the commits is happening at about 2
per second, and about 70% of that time is in the kernel, presumably
playing around in the repository.

I'm assuming that if I could get these disconnected blobs all neatly
tucked into a pack object, things might go a bit faster.
--=20
keith.packard@intel.com

--=-sjeqSSAEFaKDzX6WSHuW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEj7gmQp8BWwlsTdMRAoPVAJ9/DnUYZKdRdpfdcRy78a9GlsZ/ZACgtaLN
qmYo0qDBxNqxI9MtfN9oGmQ=
=NqT7
-----END PGP SIGNATURE-----

--=-sjeqSSAEFaKDzX6WSHuW--
