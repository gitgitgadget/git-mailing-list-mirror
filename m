From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v3 28/28] git-remote-mediawiki: Clearly rewrite double dereference
Date: Mon, 10 Jun 2013 00:22:53 +0200
Message-ID: <1370816573-3808-29-git-send-email-celestin.matte@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 00:24:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulo1z-0000y2-V6
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab3FIWYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 18:24:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41305 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032Ab3FIWYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 18:24:03 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r59MNqVM021623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 00:23:52 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r59MNtKv019539;
	Mon, 10 Jun 2013 00:23:55 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r59MNSHp008599;
	Mon, 10 Jun 2013 00:23:55 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 00:23:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59MNqVM021623
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371421436.74929@PQaDED9LS9glYmmhTEZ5xQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227186>

@$var structures are re-written in the following way: @{$var}
It makes them more readable.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index b0e540b..e0b2fd2 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -235,7 +235,7 @@ sub get_mw_tracked_pages {
 sub get_mw_page_list {
 	my $page_list =3D shift;
 	my $pages =3D shift;
-	my @some_pages =3D @$page_list;
+	my @some_pages =3D @{$page_list};
 	while (@some_pages) {
 		my $last_page =3D SLICE_SIZE;
 		if ($#some_pages < $last_page) {
@@ -885,7 +885,7 @@ sub mw_import_revids {
 	my $n_actual =3D 0;
 	my $last_timestamp =3D 0; # Placeholer in case $rev->timestamp is und=
efined
=20
-	foreach my $pagerevid (@$revision_ids) {
+	foreach my $pagerevid (@{$revision_ids}) {
 	        # Count page even if we skip it, since we display
 		# $n/$total and $total includes skipped pages.
 		$n++;
@@ -920,7 +920,7 @@ sub mw_import_revids {
 		my $page_title =3D $result_page->{title};
=20
 		if (!exists($pages->{$page_title})) {
-			print {*STDERR} "${n}/", scalar(@$revision_ids),
+			print {*STDERR} "${n}/", scalar(@{$revision_ids}),
 				": Skipping revision #$rev->{revid} of ${page_title}\n";
 			next;
 		}
@@ -953,7 +953,7 @@ sub mw_import_revids {
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print {*STDERR} "${n}/", scalar(@$revision_ids), ": Revision #$rev->=
{revid} of $commit{title}\n";
+		print {*STDERR} "${n}/", scalar(@{$revision_ids}), ": Revision #$rev=
->{revid} of $commit{title}\n";
 		import_file_revision(\%commit, ($fetch_from =3D=3D 1), $n_actual, \%=
mediafile);
 	}
=20
--=20
1.7.9.5
