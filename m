From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Question about git-merge-stupid
Date: Thu, 3 Jul 2008 14:33:14 +0200
Message-ID: <20080703123314.GS4729@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45kFsbCJmK9J4C/8"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:36:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEO31-0007XG-6i
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916AbYGCMdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757572AbYGCMdT
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:33:19 -0400
Received: from virgo.iok.hu ([193.202.89.103]:53453 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755690AbYGCMdS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:33:18 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 01EDD1B24FC;
	Thu,  3 Jul 2008 14:33:16 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A496A44698;
	Thu,  3 Jul 2008 14:03:17 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5DDF911901F1; Thu,  3 Jul 2008 14:33:14 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87279>


--45kFsbCJmK9J4C/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm trying to understand what is the difference between different merge
strategies. git-merge-stupid is something I failed to understand from
the git history/code/documentation, so I'm asking here.

1) From git history:

It seems git-merge-stupid was created by 2276aa6 when Junio renamed
-resolve to -stupid and let -resolve use read-tree. Actually

        git show 2276aa6:git-merge-stupid.sh

says -stupid uses read-tree as well.

2) From code:

It seems -stupid is better than -resolve when there are multiple bases.
-resolve just passes all bases to read-tree, while -stupid tries to find
the best one. It does it by counting unmerged entries and the less one
is a better.

Here is what I tried:

A - B - C
      X   \
  \ D - E - F

(Where 'A' adds 'a.c' while the contents 'a', etc.)

$ git reset --hard e
$ git merge -s resolve c
Trying simple merge.
Merge made by resolve.

So it seems resolve does not completely fail if there are multiple
bases, either.

I would like to write a testcase that ensures git-merge-stupid really
picks the best base, but I don't know exactly in what situation can the
number of unmerged entires differ.

3) From documentation:

Actually -stupid is missing from Documentation/merge-strategies.txt. I
plan to send a patch to add it, once I understnad what it does. :-)

Thanks.

[ Writing to Linus as suggested by Dscho, adding Junio to CC as -
according to git log - both strategy created by him. ]

--45kFsbCJmK9J4C/8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhsxwoACgkQe81tAgORUJbIVwCfXwMsAGd0BUCysLWXtNZGfm/h
ilAAn2UNspdEdOObItJme6R4GKIwfAyu
=J6h/
-----END PGP SIGNATURE-----

--45kFsbCJmK9J4C/8--
