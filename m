From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue, 05 Apr 2011 15:49:26 -0600
Organization: Red Hat
Message-ID: <4D9B8E66.2010408@redhat.com>
References: <1302032214-11438-1-git-send-email-eblake@redhat.com> <20110405194005.GA32427@elie> <201104052315.54375.j6t@kdbg.org> <4D9B8862.1050605@redhat.com> <20110405214114.GA13729@elie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig940BBEE311DF4118413F05D8"
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 23:49:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7E83-0004mv-5W
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab1DEVtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940Ab1DEVtc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 17:49:32 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p35LnSZj003926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 5 Apr 2011 17:49:28 -0400
Received: from [10.3.113.117] (ovpn-113-117.phx2.redhat.com [10.3.113.117])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p35LnRhK032311;
	Tue, 5 Apr 2011 17:49:27 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.9
In-Reply-To: <20110405214114.GA13729@elie>
X-Enigmail-Version: 1.1.2
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170922>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig940BBEE311DF4118413F05D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/05/2011 03:41 PM, Jonathan Nieder wrote:
> Eric Blake wrote:
>=20
>> Yeah, but then you have to 'git add -f path/to/file' them every time y=
ou
>> change them
>=20
> No, I don't believe that's true.
>=20
>  $ git add -f git.o
>  $ >git.o
>  $ git add git.o

Aha - it's that pesky dir/ vs. dir/* biting me, yet again:

$ mkdir -p /tmp/blah
$ cd /tmp/blah
$ git init
Initialized empty Git repository in /tmp/blah/.git/
$ mkdir sub
$ > sub/file
$ git add sub/file
$ git commit -a -m 'one'
[master (root-commit) 645ee5a] one
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 sub/file
$ printf 'sub/*\n!sub/file\n' > .gitignore
$ touch sub/file2
$ echo hi > sub/file
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#	modified:   sub/file
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	.gitignore
no changes added to commit (use "git add" and/or "git commit -a")
$ git add sub
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   sub/file
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	.gitignore
$ git reset
Unstaged changes after reset:
M	sub/file
$ printf 'sub/\n!sub/file\n' > .gitignore
$ git add sub
The following paths are ignored by one of your .gitignore files:
sub
Use -f if you really want to add them.
fatal: no files added
$ git add sub/file
The following paths are ignored by one of your .gitignore files:
sub
Use -f if you really want to add them.
fatal: no files added
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#	modified:   sub/file
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	.gitignore
no changes added to commit (use "git add" and/or "git commit -a")
$ git add .
$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   .gitignore
#	modified:   sub/file
#

>=20
> .gitignore only protects against starting to track a file that was
> previously untracked.

Not quite.  When filtering a directory, it also protects against changes
to tracked files in that directory.  And that is what has been throwing
me off, which is why we need a doc change (or possibly even a behavior
change).

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig940BBEE311DF4118413F05D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNm45mAAoJEKeha0olJ0NqwkEH/Ryn8EgNoBiA5b4ZYs1DDO0p
a1PuqFWlpfOMFyYsL+DTwOWVs07HzbN/zKNiHqUagEWcpxRWTI+IZrsWJPj1scvn
kcvK88IKzV7SSIJR2K9SaDpHIKizZondb1SCUqj1Zi8uyTzlEce5aMIGXi8IWT38
NDtG125w6cMXcJQ8iF7cxuQhCXK4dmD+nFdrJIaAjs2NH/QS2awV2/AqCp15KA06
sjPAe3E+e64TJzJX/YMs77bP2AbGokNQ0lor6bGwAt4GVSEBOlhGxpEUiklb+LFN
7E04zoTeex2LuYgK6UjfZJNonQZNTduA5VEP/7+cMgJJ2i27Q5jUx+aJtnQd7lU=
=fZv1
-----END PGP SIGNATURE-----

--------------enig940BBEE311DF4118413F05D8--
