From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v3 24/28] git-remote-mediawiki: Replace "unless" statements with negated "if" statements
Date: Mon, 10 Jun 2013 00:22:49 +0200
Message-ID: <1370816573-3808-25-git-send-email-celestin.matte@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 10 00:24:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulo2B-00016A-39
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 00:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab3FIWYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 18:24:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37847 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab3FIWYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 18:24:02 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r59MNo4A011041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 00:23:52 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r59MNqwm019519;
	Mon, 10 Jun 2013 00:23:52 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r59MNSHl008599;
	Mon, 10 Jun 2013 00:23:52 +0200
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 00:23:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59MNo4A011041
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371421436.64778@H2mCZAYG5+e3pz4yCyKd+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227188>

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 1cda460..bfb8a96 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -86,11 +86,11 @@ $shallow_import =3D ($shallow_import eq 'true');
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
@@ -112,7 +112,7 @@ my %basetimestamps;
 # deterministic, this means everybody gets the same sha1 for each
 # MediaWiki revision.
 my $dumb_push =3D run_git("config --get --bool remote.${remotename}.du=
mbPush");
-unless ($dumb_push) {
+if (!$dumb_push) {
 	$dumb_push =3D run_git('config --get --bool mediawiki.dumbPush');
 }
 chomp($dumb_push);
@@ -671,7 +671,7 @@ sub fetch_mw_revisions_for_page {
 			push(@page_revs, $page_rev_ids);
 			$revnum++;
 		}
-		last unless $result->{'query-continue'};
+		last if (!$result->{'query-continue'});
 		$query->{rvstartid} =3D $result->{'query-continue'}->{revisions}->{r=
vstartid};
 	}
 	if ($shallow_import && @page_revs) {
@@ -1243,7 +1243,7 @@ sub mw_push_revision {
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
@@ -1323,7 +1323,7 @@ sub get_mw_namespace_id {
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
