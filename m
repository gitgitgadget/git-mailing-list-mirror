From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH 18/18] Clearly rewrite double dereference
Date: Thu,  6 Jun 2013 21:34:23 +0200
Message-ID: <1370547263-13558-19-git-send-email-celestin.matte@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 21:35:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukfy5-0001Cd-0P
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab3FFTfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:35:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44557 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296Ab3FFTfM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:35:12 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56JZ3Ko031996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 21:35:03 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56JZ5nb021455;
	Thu, 6 Jun 2013 21:35:05 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56JYTp7023108;
	Thu, 6 Jun 2013 21:35:05 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Jun 2013 21:35:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56JZ3Ko031996
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371152107.27964@zl/Re16HBQ285NQcnPMXKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226542>

@$var structures are re-written in the following way: @{ $var }
It makes them more readable.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 20ddccb..06e6f4d 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -233,7 +233,7 @@ sub get_mw_tracked_pages {
 sub get_mw_page_list {
 	my $page_list =3D shift;
 	my $pages =3D shift;
-	my @some_pages =3D @$page_list;
+	my @some_pages =3D @{ $page_list };
 	while (@some_pages) {
 		my $last_page =3D $SLICE_SIZE;
 		if ($#some_pages < $last_page) {
@@ -733,7 +733,7 @@ sub import_file_revision {
=20
 	print {*STDOUT} "commit refs/mediawiki/${remotename}/master\n";
 	print {*STDOUT} "mark :${n}\n";
-	print {*STDOUT} "committer ${author} <${author}\@${wiki_name}> " . $d=
ate->epoch . " +0000\n";
+	print {*STDOUT} "committer ${author} <${author}\@{ ${wiki_name} }> " =
=2E $date->epoch . " +0000\n";
 	literal_data($comment);
=20
 	# If it's not a clone, we need to know where to start from
@@ -759,7 +759,7 @@ sub import_file_revision {
 		print {*STDOUT} "reset refs/notes/${remotename}/mediawiki\n";
 	}
 	print {*STDOUT} "commit refs/notes/${remotename}/mediawiki\n";
-	print {*STDOUT} "committer ${author} <${author}\@${wiki_name}> " . $d=
ate->epoch . " +0000\n";
+	print {*STDOUT} "committer ${author} <${author}\@{ ${wiki_name} }> " =
=2E $date->epoch . " +0000\n";
 	literal_data('Note added by git-mediawiki during import');
 	if (!$full_import && $n =3D=3D 1) {
 		print {*STDOUT} "from refs/notes/${remotename}/mediawiki^0\n";
@@ -881,7 +881,7 @@ sub mw_import_revids {
 	my $n_actual =3D 0;
 	my $last_timestamp =3D 0; # Placeholer in case $rev->timestamp is und=
efined
=20
-	foreach my $pagerevid (@$revision_ids) {
+	foreach my $pagerevid (@{ $revision_ids }) {
 	        # Count page even if we skip it, since we display
 		# $n/$total and $total includes skipped pages.
 		$n++;
@@ -916,7 +916,7 @@ sub mw_import_revids {
 		my $page_title =3D $result_page->{title};
=20
 		if (!exists($pages->{$page_title})) {
-			print {*STDERR} "${n}/", scalar(@$revision_ids),
+			print {*STDERR} "${n}/", scalar(@ { $revision_ids }),
 				": Skipping revision #$rev->{revid} of ${page_title}\n";
 			next;
 		}
@@ -949,7 +949,7 @@ sub mw_import_revids {
 		# If this is a revision of the media page for new version
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
-		print {*STDERR} "${n}/", scalar(@$revision_ids), ": Revision #$rev->=
{revid} of $commit{title}\n";
+		print {*STDERR} "${n}/", scalar(@{ $revision_ids }), ": Revision #$r=
ev->{revid} of $commit{title}\n";
 		import_file_revision(\%commit, ($fetch_from =3D=3D 1), $n_actual, \%=
mediafile);
 	}
=20
--=20
1.7.9.5
