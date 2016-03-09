From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Possible bug: --ext-diff ignored with --cc in git log
Date: Wed, 9 Mar 2016 18:43:10 +0100
Message-ID: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="924894213-41-1457545390=:12660"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 19:15:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adidT-0008Ly-C1
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933500AbcCISOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 13:14:52 -0500
Received: from sunset.tt-solutions.com ([82.240.17.225]:47640 "EHLO
	smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933814AbcCISOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:14:49 -0500
X-Greylist: delayed 1878 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Mar 2016 13:14:48 EST
Received: from [192.168.17.86] (helo=Twilight)
	by smtp.tt-solutions.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <vz-git@zeitlins.org>)
	id 1adi8q-0005NJ-4G
	for git@vger.kernel.org; Wed, 09 Mar 2016 18:43:24 +0100
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
X-VZ-SMTP-Helo: Twilight
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288543>

--924894213-41-1457545390=:12660
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

 Hello,

 I use a combination of git attributes and a custom diff driver to ignore
the changes to the generated files (that we unfortunately need to keep in
our repository) from appearing in "git diff" and "git log" output, i.e.:

	% cat .gitattributes
	# Use a custom diff driver for bakefile generated files
	# This allows ignoring them in git diff for example by doing
	#     $ git config diff.generated.command true
	# pass --no-ext-diff to git diff to ignore the custom driver
	*.sln              diff=generated
	*.vcproj           diff=generated
	*.vcxproj          diff=generated
	*.vcxproj.filters  diff=generated
	% git config diff.generated.command
	echo Diff of generated file "$1" suppressed; true

 This works quite nicely most of the time provided you use "--ext-diff"
with "git log", but not when showing the merges with "--cc". I.e. the
command "git log --ext-diff -p --cc" still outputs the real diff even for
the generated files, as if "--ext-diff" were not given. If I use "git log
--ext-diff -p -m", the generated files are ignored, which is nice, but the
diff for the other files becomes much more verbose and less readable and
I'd really like to combine "--ext-diff" with "--cc" if possible.

 Is the current behaviour intentional? I see it with all the git versions I
tried (1.7.10, 2.1.0, 2.7.0 and v2.8.0-rc1), but I don't really see why
would it need to work like this, so I hope it's an oversight and could be
corrected.

 Or is there perhaps some other way to do what I want already?

 Thanks in advance for any help,
VZ

--924894213-41-1457545390=:12660
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAlbgYK4ACgkQBupB3k9sHoZugQCdFdTiK2o89GahF286One5m0kq
3FoAn2IFyk6bmFhGziAEhe64Woxj+ayf
=ftvz
-----END PGP SIGNATURE-----

--924894213-41-1457545390=:12660--
