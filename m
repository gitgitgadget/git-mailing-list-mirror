From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 22/22] git-remote-mediawiki: Clearly rewrite double dereference
Date: Fri,  7 Jun 2013 23:42:23 +0200
Message-ID: <1370641344-4253-23-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:43:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4Ra-0008G4-32
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab3FGVnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52008 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756553Ab3FGVnU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:20 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r57LhF0Z026141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:15 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57LhIR3029651;
	Fri, 7 Jun 2013 23:43:18 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRx019409;
	Fri, 7 Jun 2013 23:43:17 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Jun 2013 23:43:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57LhF0Z026141
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246195.77289@ok0d8l5WCG7drOIJfHNHYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226725>

@$var structures are re-written in the following way: @{$var}
It makes them more readable.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index be860c8..a13c33f 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -234,7 +234,7 @@ sub get_mw_tracked_pages {
 sub get_mw_page_list {
 	my $page_list =3D shift;
 	my $pages =3D shift;
-	my @some_pages =3D @$page_list;
+	my @some_pages =3D @{$page_list};
 	while (@some_pages) {
 		my $last_page =3D $SLICE_SIZE;
 		if ($#some_pages < $last_page) {
@@ -736,7 +736,7 @@ sub import_file_revision {
=20
 	print {*STDOUT} "commit refs/mediawiki/${remotename}/master\n";
 	print {*STDOUT} "mark :${n}\n";
-	print {*STDOUT} "committer ${author} <${author}\@${wiki_name}> " . $d=
ate->epoch . " +0000\n";
+	print {*STDOUT} "committer ${author} <${author}\@{${wiki_name}}> " . =
$date->epoch . " +0000\n";
 	literal_data($comment);
=20
 	# If it's not a clone, we need to know where to start from
@@ -762,7 +762,7 @@ sub import_file_revision {
 		print {*STDOUT} "reset refs/notes/${remotename}/mediawiki\n";
 	}
 	print {*STDOUT} "commit refs/notes/${remotename}/mediawiki\n";
-	print {*STDOUT} "committer ${author} <${author}\@${wiki_name}> " . $d=
ate->epoch . " +0000\n";
+	print {*STDOUT} "committer ${author} <${author}\@{${wiki_name}}> " . =
$date->epoch . " +0000\n";
 	literal_data('Note added by git-mediawiki during import');
 	if (!$full_import && $n =3D=3D 1) {
 		print {*STDOUT} "from refs/notes/${remotename}/mediawiki^0\n";
@@ -884,7 +884,7 @@ sub mw_import_revids {
 	my $n_actual =3D 0;
 	my $last_timestamp =3D 0; # Placeholer in case $rev->timestamp is und=
efined
=20
-	foreach my $pagerevid (@$revision_ids) {
+	foreach my $pagerevid (@{$revision_ids}) {
 	        # Count page even if we skip it, since we display
 		# $n/$total and $total includes skipped pages.
 		$n++;
@@ -919,7 +919,7 @@ sub mw_import_revids {
 		my $page_title =3D $result_page->{title};
=20
 		if (!exists($pages->{$page_title})) {
-			print {*STDERR} "${n}/", scalar(@$revision_ids),
+			print {*STDERR} "${n}/", scalar(@{$revision_ids}),
 				": Skipping revision #$rev->{revid} of ${page_title}\n";
 			next;
 		}
@@ -952,7 +952,7 @@ sub mw_import_revids {
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
