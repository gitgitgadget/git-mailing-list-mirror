From: Roger Leigh <rleigh@codelibre.net>
Subject: git mailinfo strips important context from patch subjects
Date: Sun, 28 Jun 2009 20:38:58 +0100
Message-ID: <20090628193858.GA29467@codelibre.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 21:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML0LP-0002e1-G3
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 21:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZF1TrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 15:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752398AbZF1TrD
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 15:47:03 -0400
Received: from nagini.codelibre.net ([80.68.93.164]:38223 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbZF1TrC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 15:47:02 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jun 2009 15:47:02 EDT
Received: by nagini.codelibre.net (Postfix, from userid 107)
	id 86DF118223; Sun, 28 Jun 2009 20:39:03 +0100 (BST)
Received: from hardknott (unknown [78.149.59.55])
	by nagini.codelibre.net (Postfix) with ESMTPSA id 747FA18044
	for <git@vger.kernel.org>; Sun, 28 Jun 2009 20:38:58 +0100 (BST)
Received: by hardknott (Postfix, from userid 1000)
	id 91982120C1; Sun, 28 Jun 2009 20:38:58 +0100 (BST)
Content-Disposition: inline
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 20:09:49 up  2:40,  2 users,  load average: 0.77, 0.25, 0.14
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122418>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[I'm not currently subscribed to the list; I'd appreciate a CC
on any replies, thanks!]

Hi,

In most of the projects I work on, the git commit message has
the affected subsystem or component in square brackets, such as

  [foo] change bar to baz

For example, with a single patch from a series produced by
git format-patch:

% head -n4 /tmp/patches/0005-sbuild-chroot_mountable-Don-t-derive-from-chro=
ot.patch
=46rom f01579584f1e7d77cf1e9c3306601a4cccff8c55 Mon Sep 17 00:00:00 2001
=46rom: Roger Leigh <rleigh@debian.org>
Date: Fri, 10 Apr 2009 19:43:15 +0100
Subject: [PATCH 05/15] [sbuild] chroot_mountable: Don't derive from chroot

% git mailinfo </tmp/patches/0005-sbuild-chroot_mountable-Don-t-derive-from=
-chroot.patch /dev/null /dev/null
Author: Roger Leigh
Email: rleigh@debian.org
Subject: chroot_mountable: Don't derive from chroot
Date: Fri, 10 Apr 2009 19:43:15 +0100

The [sbuild] prefix has been dropped from the Subject, so an
important bit of context about the patch has been lost.

It's a bit of a bug that you can't round trip from a git-format-patch
to import with git-am and then not be able to produce the exact same
patch set with git-format-patch again (assuming preparing and applying
to the same point, of course).

Would it be possible to change the git-mailinfo logic to use a less
greedy pattern match so it leaves everything after
([PATCH( [0-9/])+])+ in the subject?  AFAICT this is cleanup_subject in
builtin-mailinfo.c?  Could this rather complex function not just do a
simple regex match which can also take care of stripping ([Rr]e:) ?


Thanks,
Roger

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkpHxtIACgkQVcFcaSW/uEgkowCgpXpQNkGcrx/1jGHQm9/uDldG
1ZMAn1glmSnH935eEYwT3vfzd+5Cekoy
=SqRE
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
