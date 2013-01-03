From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [RFH] NetBSD 6?
Date: Thu, 03 Jan 2013 08:58:22 -0500
Message-ID: <rmi8v8av05d.fsf@fnord.ir.bbn.com>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
	<rmipq1numzj.fsf@fnord.ir.bbn.com>
	<7vd2xnypt6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 14:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqlJm-0007BB-U5
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 14:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab3ACN6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 08:58:25 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:63483 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444Ab3ACN6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 08:58:23 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 91AC5A7B8; Thu,  3 Jan 2013 08:58:22 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130103:gitster@pobox.com::Zb8VpxiVin5EyMls:0000000000000000000000000000000000000000000014Fm
X-Hashcash: 1:20:130103:git@vger.kernel.org::Zb8VpxiVin5EyMls:0000000000000000000000000000000000000000006bDU
In-Reply-To: <7vd2xnypt6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 02 Jan 2013 18:15:49 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212582>

--=-=-=
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:

> Greg Troxel <gdt@ir.bbn.com> writes:
>
>> I realize a README.foo file for N different systems could be clutter,
>> but having these checked in would provide the concise help that people
>> on any of those platforms need.
>
> Our Makefile documents knobs people on various platforms can tweak
> (PYTHON_PATH and OLD_ICONV are two examples of them), sets default
> values for them based on $(uname -S), then includes config.mak file
> the user can optionally create to override these platform defaults.
> This infrastructure is used across platforms, not just for NetBSD.

If you have to choose a single PYTHON_PATH, the one you picked is right
(for now, and likely will be right for a long time).

But as a general rule, I think configure tests are preferable to
OS-specific variables.

> The part shown in the patch was to update the platform default for
> NetBSD.  The setting we have been shipping in our Makefile seemed to
> be different from what I needed on my NetBSD 6 install, and I was
> wondering if we have no real users of Git on the platorm (which
> would explain why we didn't get any complaints or patches to update
> this part).  Or there are some optional packages all real NetBSD
> users install, but being a NetBSD newbie I didn't, that makes the
> values I showed in the patch inappropriate for them (e.g. Perhaps
> there is a mechanism other than pkgsrc that installs perl and python
> under /usr/bin?  Perhaps an optional libi18n package that gives
> iconv(3) with new function signature?), in which case I definitely
> should not apply that patch to my tree, as it would only be an
> improvement for one person and a regression for existing users at
> the same time.

A large number of people on NetBSD use git, but almost all of them get
it via pkgsrc (which is also where they get perl, emacs, svn, and
everything else you didn't find in /usr/bin).  The exception would be
people that want to hack on git itself.

People who want gnu libiconv can install the libiconv package from
pkgsrc.  (I'm guessing OLD_ICONV means "POSIX iconv", without GNU
extensions (iconvctl?).)  The git package doesn't depend on GNU iconv,
though (perhaps it should but we tend to avoid dependencies that arren't
really needed).

There are no mechanisms to install python/perl in /usr/bin, and doing so
would be viewed as bizarre.  /usr/bin belongs to the base system,
/usr/pkg to pkgsrc and /usr/local to the user.

So, it doesn't matter too much for pkgsrc what you change, because it
can be patched anyway (once, for all users).  It's probably better to
make a straightforward build from source come out right.
But, if the build respects the PYTHON_PATH environment variable, that's
easier (and more robust against changes) than patching.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDljn4ACgkQ+vesoDJhHiXPvACggQWHjLU9s4/XD7jgwSQGxrYz
ST8AnimDaUKnDjywkms/Vf4dgcAsJPL4
=XyYJ
-----END PGP SIGNATURE-----
--=-=-=--
