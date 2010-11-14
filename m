From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Multiple clients accessing git over NFS
Date: Sun, 14 Nov 2010 18:11:41 -0500
Message-ID: <rmi39r3mrf6.fsf@fnord.ir.bbn.com>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Khawaja Shams <kshams@usc.edu>
X-From: git-owner@vger.kernel.org Mon Nov 15 00:20:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHlrY-0003cL-C0
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 00:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab0KNXTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 18:19:51 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:50296 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755535Ab0KNXTu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 18:19:50 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Nov 2010 18:19:50 EST
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 10D1953C4; Sun, 14 Nov 2010 18:11:50 -0500 (EST)
X-Hashcash: 1:20:101114:git@vger.kernel.org::tiCKKTjWt0Z5Qhv3:0000000000000000000000000000000000000000000u0h
X-Hashcash: 1:20:101114:kshams@usc.edu::YmZVs9DxtaB5Ugve:0000xPg
In-Reply-To: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
	(Khawaja Shams's message of "Sun, 14 Nov 2010 13:24:01 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161459>

--=-=-=
Content-Type: text/plain


Khawaja Shams <kshams@usc.edu> writes:

> Is it a recommended practice to share a repository over NFS, where
> multiple clients can be pushing changes simultaneously?  In our
> production environment, we have a Git repository setup behind
> git-http-backend. We would like to place multiple Apache servers
> behind a load balancer to maximize availability and performance.
> Before we proceed, we wanted to check to see if this practice has a
> potential to cause repository corruption. If there are other ways
> others have solved this problem, we would be very interested in
> learning about those as well. Thank you.

NFS locking has historically been problematic, and my impression is that
most people avoid it.  Perhaps it's ok on Solaris, but without serious
testing, I'd be worried.

Can you explain what you have set up, and what your performance
situation is, and why you think adding a second or third apache over NFS
will help?  How many users?  How many pushes/day?

One option is to have a multi-core box with tons of RAM running apache;
I've done that for trac (8 core, 16G, RAID5) because trac/python is so
piggy, and buying a $3K box was cheaper than making trac go faster.
That doesn't get you into remote FS locking issues.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iEYEARECAAYFAkzgbK0ACgkQ+vesoDJhHiXrbgCfdX0D/5hmXUyg5Ml0XjAaJCAf
+ZkAn07+a4zXj1/Vg2sBlCPk8Q3N2O14
=1EJR
-----END PGP SIGNATURE-----
--=-=-=--
