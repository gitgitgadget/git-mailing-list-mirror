From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 08/31] git-remote-mediawiki: Remove useless regexp modifier (m)
Date: Wed, 12 Jun 2013 17:43:25 +0200
Message-ID: <1371051828-12866-9-git-send-email-celestin.matte@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:46:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnFi-0008WJ-8x
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156Ab3FLPqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:46:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43420 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811Ab3FLPoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:44:14 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFiAqh028663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:44:11 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFiCko014998;
	Wed, 12 Jun 2013 17:44:12 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu5r014096;
	Wed, 12 Jun 2013 17:44:12 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 17:44:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227652>

m// and // is used randomly. It is better to use the m modifier only wh=
en
needed, e.g., when the regexp uses another separator than //.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 2db6467..7ce640f 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -761,7 +761,7 @@ sub get_more_refs {
 	my @refs;
 	while (1) {
 		my $line =3D <STDIN>;
-		if ($line =3D~ m/^$cmd (.*)$/) {
+		if ($line =3D~ /^$cmd (.*)$/) {
 			push(@refs, $1);
 		} elsif ($line eq "\n") {
 			return @refs;
@@ -1167,11 +1167,11 @@ sub mw_push_revision {
 		my @local_ancestry =3D split(/\n/, run_git("rev-list --boundary --pa=
rents $local ^$parsed_sha1"));
 		my %local_ancestry;
 		foreach my $line (@local_ancestry) {
-			if (my ($child, $parents) =3D $line =3D~ m/^-?([a-f0-9]+) ([a-f0-9 =
]+)/) {
+			if (my ($child, $parents) =3D $line =3D~ /^-?([a-f0-9]+) ([a-f0-9 ]=
+)/) {
 				foreach my $parent (split(' ', $parents)) {
 					$local_ancestry{$parent} =3D $child;
 				}
-			} elsif (!$line =3D~ m/^([a-f0-9]+)/) {
+			} elsif (!$line =3D~ /^([a-f0-9]+)/) {
 				die "Unexpected output from git rev-list: $line";
 			}
 		}
--=20
1.8.3.rc3.18.g21a7b2c
