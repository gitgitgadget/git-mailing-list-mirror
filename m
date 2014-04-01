From: Florian Bruhin <me@the-compiler.org>
Subject: [BUG?] git-revert ignores --no-commit on conflicts
Date: Tue, 1 Apr 2014 15:24:54 +0200
Message-ID: <20140401132454.GQ9499@lupin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_mehl.schokokeks.org-24703-1396358696-0001-2"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 15:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUylQ-0002aF-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 15:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaDAN37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 09:29:59 -0400
Received: from mehl.schokokeks.org ([46.4.40.247]:35121 "EHLO
	mehl.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbaDAN36 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 09:29:58 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Apr 2014 09:29:58 EDT
Received: from lupin (the-compiler.org [2001:41d0:2:6c11::1])
  (AUTH: PLAIN me@the-compiler.org, TLS: TLSv1/SSLv3,256bits,AES256-GCM-SHA384)
  by mehl.schokokeks.org with ESMTPSA; Tue, 01 Apr 2014 15:24:56 +0200
  id 000000000000000F.00000000533ABE28.0000607F
Content-Disposition: inline
Accept-Language: de, en
X-URL: http://www.the-compiler.org/
X-Operating-System: Arch Linux
X-Editor: vim 7.4
X-PGP-Key: http://www.the-compiler.org/pubkey.asc
OpenPGP: id=FD55A072; url=http://www.the-compiler.org/pubkey.asc;
 preference=signencrypt
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245589>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_mehl.schokokeks.org-24703-1396358696-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I found something which seems to be a bug to me (or well, maybe I'm
doing something wrong...). When I revert a commit with -n/--no-commit
and there's a conflict, when doing "git revert --continue" I get an
editor, even though I wouldn't expect that to happen.

Example:

    $ git init
    Initialized empty Git repository in [...]
    $ echo foo > file
    $ git add file
    $ git commit -m "Initial commit"
    [master (root-commit) 9f8e5fb] Initial commit
     1 file changed, 1 insertion(+)
     create mode 100644 file
    $ echo bar > file
    $ git commit -am "foo -> bar"
    [master e53d99f] foo -> bar
     1 file changed, 1 insertion(+), 1 deletion(-)
    $ echo baz > file
    $ git commit -am "bar -> baz"
    [master fa3c23f] bar -> baz
     1 file changed, 1 insertion(+), 1 deletion(-)
    $ git revert -n HEAD  # this works as expected
    $ git revert --abort
    $ git revert -n e53d99f  # reverting the middle commit to provoke a con=
flict
    error: could not revert e53d99f... foo -> bar
    hint: after resolving the conflicts, mark the corrected paths
    hint: with 'git add <paths>' or 'git rm <paths>'
    $ echo fish > file
    $ git add file
    $ git revert --continue  # here my editor opens
    Aborting commit due to empty commit message.

Tested using git 1.9.1 and 1.9.0.msysgit.0.

Florian

--=20
() ascii ribbon campaign - stop html mail    www.asciiribbon.org
/\ www.the-compiler.org  | I love long mails http://email.is-not-s.ms/
Love is never asking why?=20

--=_mehl.schokokeks.org-24703-1396358696-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOr4mAAoJEJFusMj9VaByT6cP/RU5GaQzKc5Heg2i93zIHb00
VRZiK8fFkniO1AdcD/Vc11H5jY+F8GgaVjd3unBxLqVTsGhtC7X8umTZ3fYQhF1j
OCjoLAwpiGgpa14BcJI+AHWaVAe72vHIkmeKFfDlDMkq7P3yqsPGWP04eqjHGPBp
83mfcR5VzKB7bY74y6bPrj0nS7xKXWB0Kpttr5aQrajj5cWuiencCKSuYhBVtQA6
09nV+9XD5nNx1rpQWnsF4nrQ/pi7FwAlRigWJbIjSa06KdGj96knVh0mYlK2mBnc
wji3TtPgNgDseoNCQDQAyQjmHeYnKonIicXJHHL977Kw0q3n2eCQlRyP3V4tAiy6
VxnHOWoLujGX+4u3zp/qpABNjckulip/LcjStcHw8Y2uckfu0Mr8Q39LTRMVFVcw
zR1+rLSOrs0L3owkiduohqGsA4TQ5bcwA1uAVu6BGMkLz7Ks3k24xEu7eakJ1glF
NmUBcJphRRcDFMG7Xei6mmPsZau6QNcxkCF4xCHliFVR9kXdNemTE5JsX9peWOnL
FRaxUAL+X9qJFNS50ZbY0GhEcNWjOAF2S6lhn9NAHgQRp7GNuJzjP3dtIU63RbQr
DOFEGX04jQUGc8gNiEDtXserfkS4gBO6usQgPUvCoctDkqvMge6nzsgRXTDUd4XR
iRJvHBvbYMRqBCyx6b7A
=O5nr
-----END PGP SIGNATURE-----

--=_mehl.schokokeks.org-24703-1396358696-0001-2--
