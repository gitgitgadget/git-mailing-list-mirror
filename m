From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/2] git-diff: complain about >=8 consecutive spaces in
 initial indent
Date: Tue, 13 Nov 2007 15:37:54 -0800
Message-ID: <473A3552.3060907@freedesktop.org>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org> <7vr6j95c84.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig817F0CEACD726ED8BEF24A79"
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>,
	dsymonds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5RZ-0004nQ-Eg
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbXKMXpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755439AbXKMXpF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:45:05 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:48662 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbXKMXpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:45:04 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2007 18:45:04 EST
Received: (qmail 3439 invoked from network); 13 Nov 2007 23:38:23 -0000
Received: from host-241-99.resnet.pdx.edu (HELO [131.252.241.99]) (josh@[131.252.241.99])
          (envelope-sender <josh@freedesktop.org>)
          by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <gitster@pobox.com>; 13 Nov 2007 23:38:23 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.6 (X11/20071009)
In-Reply-To: <7vr6j95c84.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64908>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig817F0CEACD726ED8BEF24A79
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[CCing David Symonds, because the same comment also applies to his
patches.]

Junio C Hamano wrote:
> This introduces a new whitespace error type, "indent-with-non-tab".
> The error is about starting a line with 8 or more SP, instead of
> indenting it with a HT.
>=20
> This is not enabled by default, as some projects employ an
> indenting policy to use only SPs and no HTs.
>=20
> The kernel folks and git contributors may want to enable this
> detection with:
>=20
> 	[core]
> 		whitespace =3D indent-with-non-tab

This seems somewhat broken, whether a project uses tabs for
indentation or not.  Lines can still legitimately start with many
spaces.  Tab-based indentation should only use tabs to line up with
other tabs, not with characters.  (Unfortunately most editors get this
wrong when indenting with tabs.  I use spaces, not because I
ideologically oppose tabs, but because I can't get any editor I want
to use to do the right thing with tabs.)

My standard test case for this:

fprintf("some very long string",
        arguments);

Type the first line, and press enter.  A good editor should indent to
the open parenthesis.  However, it should not use a tab, because it
needs to match up with the length of "fprintf(".  All the editors I
know of use a tab; they just blindly replace a tab-width worth of
spaces with a tab in initial indentation.

That statement would normally appear indented in a function, so the
continuation line should have tabs up to the indentation level of the
fprintf, and then 8 spaces.  An example more likely to appear at the
start of the line, where this indent-with-non-tab heuristic would flag
it:

#define macro(arg1, arg2) macro_content \
                          more_macro_content

Another example:

some_type function_name(arg1, arg2, argred, argblue,
                        argmore, argless)

Again, the indentation should use spaces if it wants to line up after
the open parenthesis, whether the project uses tabs or spaces for indenta=
tion.

(Those examples may or may not match all coding styles; some just
indent the continuation lines by a fixed number of tabs, and also
treat the first line as a continuation line to keep the indentation
consistent.  Just presenting them as examples.)

- Josh Triplett


--------------enig817F0CEACD726ED8BEF24A79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHOjVcGJuZRtD+evsRAqqgAJsG/xjoVySvlnntvXtP36sOYk7HugCgkUFt
dTt38S5ogsHvsDP5pCtoOcA=
=yK/b
-----END PGP SIGNATURE-----

--------------enig817F0CEACD726ED8BEF24A79--
