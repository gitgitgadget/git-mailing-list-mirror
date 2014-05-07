From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 07:44:34 -0400
Message-ID: <rmiha51dd99.fsf@fnord.ir.bbn.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
	<20140505184546.GB23935@serenity.lan>
	<xmqqoazb944d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 13:50:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi0N9-0008Lh-4M
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 13:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbaEGLur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 07:50:47 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:57183 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518AbaEGLuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 07:50:46 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2014 07:50:46 EDT
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 356E0A848; Wed,  7 May 2014 07:44:34 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:140507:git@vger.kernel.org::RtUVxvXuMdTrcJIx:0000000000000000000000000000000000000000002if8
X-Hashcash: 1:20:140507:gitster@pobox.com::u6yfP8cxbHkB9fTV:000000000000000000000000000000000000000000003ily
X-Hashcash: 1:20:140507:john@keeping.me.uk::o9OOhsIoLKTrGKUF:00000000000000000000000000000000000000000005Fl7
In-Reply-To: <xmqqoazb944d.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 05 May 2014 16:50:58 -0700")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248297>

--=-=-=
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:

> You raised a good point on the issue of external dependencies may
> impact Git as a whole, even for those who are not interested in the
> particular remote helpers at all.  I'll have to think about it.

(As I'm sure you know, but starting from the beginning.)  There are
basically two ways that a program can be built.  One is by a user on a
particular system.  There, checking to see if various libraries are
installed and if so enabling some additional feature (that isn't that
hard/time-consuming to build) is entirely reasonable.

In a packaging system, dependencies are much more troublesome.
Dependencies have to be declared, and the build limited to use only
those declared dependencies, in order to get repeatable builds and
binary packages that can be used on other systems.  Dependencies that
really are required are fine.  But optional dependencies are a problem,
because e.g. one doesn't want to require the presence of qt to build
something (that isn't already enormous).   So if git needs mercurial and
subversion installed, plus perhaps 5 other things for less popular
remote helpers, that starts to be a real burden.

(I realize some packaging systems have a style where the union of the
possible dependencies must be present to build, and then the resulting
binaries are allocated to split packages.  But that's not universal, and
it still requires large amounts of unnecessary dependencies to build a
package from source.)

Ideally, the core of git would have a small set of dependencies, and
optional language bindings or remote helpers could be built
independently (by running a different build, after git proper was built
and installed).  It seems more likely that the property of independent
builds of optional components will be preserved if the various git-foo
pieces are in seaprate trees.  But if they are in subdirs of the main
git tree, and build by "./configure && make && make install" in the
subdir, that's arguably equivalent.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlNqHKIACgkQ+vesoDJhHiW28ACeLnyEDJqaCyT3/O1wAzcdM6Iv
vicAn1I2MdHs06n+70JV3L3QEBzS59es
=R7i1
-----END PGP SIGNATURE-----
--=-=-=--
