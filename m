From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 06/31] git-remote-mediawiki: Change syntax of map calls
Date: Fri, 14 Jun 2013 15:50:14 +0200
Message-ID: <1371217839-23017-7-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:53:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnURP-0002gj-Si
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab3FNNu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:50:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44528 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab3FNNu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:50:56 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDorid020549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:50:53 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDot5p013338;
	Fri, 14 Jun 2013 15:50:55 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqfw016142;
	Fri, 14 Jun 2013 15:50:55 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 14 Jun 2013 15:50:54 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227857>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

Put first parameter of map inside a block, for better readability.
=46ollow BuiltinFunctions::RequireBlockMap

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index aa526b7..3d1a324 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -371,7 +371,7 @@ sub get_all_mediafiles {
=20
 sub get_linked_mediafiles {
 	my $pages =3D shift;
-	my @titles =3D map $_->{title}, values(%{$pages});
+	my @titles =3D map { $_->{title} } values(%{$pages});
=20
 	# The query is split in small batches because of the MW API limit of
 	# the number of links to be returned (500 links max).
@@ -399,11 +399,13 @@ sub get_linked_mediafiles {
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
@@ -833,7 +835,7 @@ sub mw_import_ref_by_pages {
 	my ($n, @revisions) =3D fetch_mw_revisions(\@pages, $fetch_from);
=20
 	@revisions =3D sort {$a->{revid} <=3D> $b->{revid}} @revisions;
-	my @revision_ids =3D map $_->{revid}, @revisions;
+	my @revision_ids =3D map { $_->{revid} } @revisions;
=20
 	return mw_import_revids($fetch_from, \@revision_ids, \%pages_hash);
 }
@@ -1246,8 +1248,8 @@ sub get_allowed_file_extensions {
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
1.8.3.rc3.49.g4e74807
