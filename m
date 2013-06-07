From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v2 18/22] git-remote-mediawiki: Replace "unless" statements with negated "if" statements
Date: Fri,  7 Jun 2013 23:42:19 +0200
Message-ID: <1370641344-4253-19-git-send-email-celestin.matte@ensimag.fr>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 23:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4Rm-0008Pr-NS
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 23:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403Ab3FGVnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 17:43:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55309 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756680Ab3FGVnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 17:43:19 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r57LhBoM003308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 23:43:11 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r57LhEqn029630;
	Fri, 7 Jun 2013 23:43:14 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r57LgqRt019409;
	Fri, 7 Jun 2013 23:43:14 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 23:43:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57LhBoM003308
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371246193.00378@UBw/muTpFHBL6L6QSu0Tjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226729>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 1024de1..123730f 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -87,11 +87,11 @@ $shallow_import =3D ($shallow_import eq 'true');
 # - by_rev: perform one query per new revision on the remote wiki
 # - by_page: query each tracked page for new revision
 my $fetch_strategy =3D run_git("config --get remote.${remotename}.fetc=
hStrategy");
-unless ($fetch_strategy) {
+if (!$fetch_strategy) {
 	$fetch_strategy =3D run_git('config --get mediawiki.fetchStrategy');
 }
 chomp($fetch_strategy);
-unless ($fetch_strategy) {
+if (!$fetch_strategy) {
 	$fetch_strategy =3D 'by_page';
 }
=20
@@ -113,7 +113,7 @@ my %basetimestamps;
 # deterministic, this means everybody gets the same sha1 for each
 # MediaWiki revision.
 my $dumb_push =3D run_git("config --get --bool remote.${remotename}.du=
mbPush");
-unless ($dumb_push) {
+if (!$dumb_push) {
 	$dumb_push =3D run_git('config --get --bool mediawiki.dumbPush');
 }
 chomp($dumb_push);
@@ -670,7 +670,7 @@ sub fetch_mw_revisions_for_page {
 			push(@page_revs, $page_rev_ids);
 			$revnum++;
 		}
-		last unless $result->{'query-continue'};
+		last if (!$result->{'query-continue'});
 		$query->{rvstartid} =3D $result->{'query-continue'}->{revisions}->{r=
vstartid};
 	}
 	if ($shallow_import && @page_revs) {
@@ -1242,7 +1242,7 @@ sub mw_push_revision {
 				die("Unknown error from mw_push_file()\n");
 			}
 		}
-		unless ($dumb_push) {
+		if (!$dumb_push) {
 			run_git(qq(notes --ref=3D${remotename}/mediawiki add -f -m "mediawi=
ki_revision: ${mw_revision}" ${sha1_commit}));
 			run_git(qq(update-ref -m "Git-MediaWiki push" refs/mediawiki/${remo=
tename}/master ${sha1_commit} ${sha1_child}));
 		}
@@ -1322,7 +1322,7 @@ sub get_mw_namespace_id {
 	my $ns =3D $namespace_id{$name};
 	my $id;
=20
-	unless (defined $ns) {
+	if (!defined $ns) {
 		print {*STDERR} "No such namespace ${name} on MediaWiki.\n";
 		$ns =3D {is_namespace =3D> 0};
 		$namespace_id{$name} =3D $ns;
--=20
1.7.9.5
