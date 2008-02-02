From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: [BUG?] git log picks up bad commit
Date: Sat, 2 Feb 2008 13:21:36 +0100
Message-ID: <20080202122135.GA5783@code-monkey.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 13:31:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLHWR-00057t-4m
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 13:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbYBBMa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 07:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbYBBMa1
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 07:30:27 -0500
Received: from code-monkey.de ([88.198.45.137]:42238 "EHLO code-monkey.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504AbYBBMa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 07:30:26 -0500
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2008 07:30:26 EST
Received: from brimstone (dialin-145-254-158-199.pools.arcor-ip.net [145.254.158.199])
	by code-monkey.de (Postfix) with ESMTP id 7B9A33F24D
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 13:21:38 +0100 (CET)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72274>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I think I either found a bug in git log, or I'm working with a broken
repository. I can reproduce this with current git master.

I'm trying to list the last n commits since a given commit on a given
branch like this:
  git log -n N commit.. branch
The problem is, if there are less than N commits that match the
criteria, git log also prints the very first commit of the repository.

I'm operating on a bare repository here. When I actually check out the
branch I'm interested in, git log behaves as expected.

I've uploaded the .git directory to
http://crux.nu/~tilman/broken_repo.tar.bz2 (use -C to extract!)

Reproduce like this:
mkdir /tmp/blah
cd /tmp/blah
tar xjf broken_repo.tar.bz2

git log -n 3 --abbrev-commit --pretty=3Doneline \
1dd567d596b072e3ce44ea5ad8c373871686b078.. 2.4

The output I'm getting is:

47f585a... syslinux: Updated 3.54 -> 3.60
b3444e1... lzma: 4.32.4 -> 4.32.5
d5d6fa1... Created repository

When I check out the "2.4" branch and run the git log command again, I
get the expected output:

47f585a... syslinux: Updated 3.54 -> 3.60
b3444e1... lzma: 4.32.4 -> 4.32.5

Any idea on what's going on there?

Thanks,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEARECAAYFAkekYE8ACgkQ6tx5H15YdGIYlQCcCJruiuvDumxl5CcbN/udmQPT
D3YAnRi+yKPB78gCGwVBNe2ZJX8fT1Pv
=7/Jm
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
