From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 10/31] git-remote-mediawiki: Change separator of some regexps
Date: Fri, 14 Jun 2013 15:50:18 +0200
Message-ID: <1371217839-23017-11-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnURS-0002gj-Ia
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab3FNNwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:52:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44543 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab3FNNu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:50:58 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDotnx020583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:50:55 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDouv5013356;
	Fri, 14 Jun 2013 15:50:56 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqg2016142;
	Fri, 14 Jun 2013 15:50:56 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 14 Jun 2013 15:50:55 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227869>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Use {}{} instead of /// when slashes are used inside the regexp so as n=
ot to
escape it.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 74344f6..e4d86ed 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -116,7 +116,7 @@ chomp($dumb_push);
 $dumb_push =3D ($dumb_push eq "true");
=20
 my $wiki_name =3D $url;
-$wiki_name =3D~ s/[^\/]*:\/\///;
+$wiki_name =3D~ s{[^/]*://}{};
 # If URL is like http://user:password@example.com/, we clearly don't
 # want the password in $wiki_name. While we're there, also remove user
 # and '@' sign, to avoid author like MWUser@HTTPUser@host.com
@@ -564,7 +564,7 @@ sub mediawiki_smudge {
=20
 sub mediawiki_clean_filename {
 	my $filename =3D shift;
-	$filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
+	$filename =3D~ s{@{[SLASH_REPLACEMENT]}}{/}g;
 	# [, ], |, {, and } are forbidden by MediaWiki, even URL-encoded.
 	# Do a variant of URL-encoding, i.e. looks like URL-encoding,
 	# but with _ added to prevent MediaWiki from thinking this is
@@ -578,7 +578,7 @@ sub mediawiki_clean_filename {
=20
 sub mediawiki_smudge_filename {
 	my $filename =3D shift;
-	$filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
+	$filename =3D~ s{/}{@{[SLASH_REPLACEMENT]}}g;
 	$filename =3D~ s/ /_/g;
 	# Decode forbidden characters encoded in mediawiki_clean_filename
 	$filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/g=
e;
--=20
1.8.3.rc3.49.g4e74807
