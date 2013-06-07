From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 05/22] git-remote-mediawiki: Change syntax of map calls
Date: Fri,  7 Jun 2013 23:42:06 +0200
Message-ID: <1370641344-4253-6-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:43:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4RL-00081i-Ka
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab3FGVnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55290 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756423Ab3FGVnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:07 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57Lgxe7003252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:42:59 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57Lh2vC029568;
	Fri, 7 Jun 2013 23:43:02 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRg019409;
	Fri, 7 Jun 2013 23:43:01 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:42:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57Lgxe7003252
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246182.90245@Ohp5uhYtU+b+y+Y1UwXquw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226721>

Put first parameter of map inside a block, for better readability.
=46ollow BuiltinFunctions::RequireBlockMap

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index dc8dd1f..5e348cb 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -372,7 +372,7 @@ sub get_all_mediafiles {
=20
 sub get_linked_mediafiles {
 	my $pages =3D shift;
-	my @titles =3D map $_->{title}, values(%{$pages});
+	my @titles =3D map { $_->{title} } values(%{$pages});
=20
 	# The query is split in small batches because of the MW API limit of
 	# the number of links to be returned (500 links max).
@@ -400,11 +400,13 @@ sub get_linked_mediafiles {
 		while (my ($id, $page) =3D each(%{$result->{query}->{pages}})) {
 			my @media_titles;
 			if (defined($page->{links})) {
-				my @link_titles =3D map $_->{title}, @{$page->{links}};
+				my @link_titles
+				    =3D map { $_->{title} } @{$page->{links}};
 				push(@media_titles, @link_titles);
 			}
 			if (defined($page->{images})) {
-				my @image_titles =3D map $_->{title}, @{$page->{images}};
+				my @image_titles
+				    =3D map { $_->{title} } @{$page->{images}};
 				push(@media_titles, @image_titles);
 			}
 			if (@media_titles) {
@@ -834,7 +836,7 @@ sub mw_import_ref_by_pages {
 	my ($n, @revisions) =3D fetch_mw_revisions(\@pages, $fetch_from);
=20
 	@revisions =3D sort {$a->{revid} <=3D> $b->{revid}} @revisions;
-	my @revision_ids =3D map $_->{revid}, @revisions;
+	my @revision_ids =3D map { $_->{revid} } @revisions;
=20
 	return mw_import_revids($fetch_from, \@revision_ids, \%pages_hash);
 }
@@ -1247,8 +1249,8 @@ sub get_allowed_file_extensions {
 		siprop =3D> 'fileextensions'
 		};
 	my $result =3D $mediawiki->api($query);
-	my @file_extensions=3D map $_->{ext},@{$result->{query}->{fileextensi=
ons}};
-	my %hashFile =3D map {$_ =3D> 1}@file_extensions;
+	my @file_extensions =3D map { $_->{ext}} @{$result->{query}->{fileext=
ensions}};
+	my %hashFile =3D map { $_ =3D> 1 } @file_extensions;
=20
 	return %hashFile;
 }
--=20
1.7.9.5
