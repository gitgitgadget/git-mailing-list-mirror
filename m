From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [RFH] NetBSD 6?
Date: Tue, 08 Jan 2013 13:53:08 -0500
Message-ID: <rmiobgz4icr.fsf@fnord.ir.bbn.com>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
	<rmipq1numzj.fsf@fnord.ir.bbn.com>
	<7vd2xnypt6.fsf@alter.siamese.dyndns.org>
	<rmi8v8av05d.fsf@fnord.ir.bbn.com>
	<7vvcbew895.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:53:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TseIk-0001E8-8d
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940Ab3AHSxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:53:10 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:55603 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756641Ab3AHSxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:53:09 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id B2C25AE89; Tue,  8 Jan 2013 13:53:08 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130108:git@vger.kernel.org::IOk9Bi98dD7XXNhn:0000000000000000000000000000000000000000000GtI
X-Hashcash: 1:20:130108:gitster@pobox.com::IOk9Bi98dD7XXNhn:00000000000000000000000000000000000000000000317X
In-Reply-To: <7vvcbew895.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 03 Jan 2013 08:17:58 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212996>

--=-=-=
Content-Type: text/plain


Junio C Hamano <gitster@pobox.com> writes:

>>  [OLD_ICONV]

> It refers to the type of the second parameter to iconv(); OLD_ICONV
> makes it take "const char *", as opposed to "char *", the latter of
> which matches
>
>   http://pubs.opengroup.org/onlinepubs/9699919799/functions/iconv.html

I just wanted to follow up on this.  It turns out that the old POSIX
standard was buggy (header file and function spec were different), and
they resolved it in favor of non-const.  NetBSD followed the const way,
and just now documented that with links to the standards email archives.

Interestingly, GNU iconv 1.14 seems to define it as const also:

  https://www.gnu.org/savannah-checkouts/gnu/libiconv/documentation/libiconv-1.14/iconv.3.html

(which matches man/iconv.3 in the tarball).

When I build libiconv-1.14, it produces a .h with const.  But it has a
configure test to check if there is a host include file with const, and
puts the const in the built header file or not to match!
In include/iconv.h.in, there is:

  extern size_t iconv (iconv_t cd,
      @ICONV_CONST@ char* * inbuf, size_t *inbytesleft,
       char* * outbuf, size_t *outbytesleft);

Someday, it would be nice to have the configure test not fail an iconv
implementation just because of the const, unless the presence of const
is causing a real problem.  But I can understand that no one thinks
that's important enough to get around to.



--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDsaxQACgkQ+vesoDJhHiUqHQCgi17AS9+sXBPS0q3YcvTSMcDd
DRsAn1ktpF2ZFMSR+RvlLuVrB+pirBkF
=nvEl
-----END PGP SIGNATURE-----
--=-=-=--
