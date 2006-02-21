From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: PATCH: fix git-fmt-merge-msg on ActiveState Perl
Date: Tue, 21 Feb 2006 16:45:47 +0100
Message-ID: <81b0412b0602210745i637692d3p5462c2b3a00df793@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_15316_2450443.1140536747288"
Cc: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 16:46:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBZi4-0003g9-N9
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 16:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWBUPpt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 10:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWBUPpt
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 10:45:49 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:49035 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932738AbWBUPps (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 10:45:48 -0500
Received: by nproxy.gmail.com with SMTP id b2so760472nfe
        for <git@vger.kernel.org>; Tue, 21 Feb 2006 07:45:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Hnu3/KCedZpvcDL0j02Fl2HB69dxtgF6UW8bvEcmEamb+EfIenL0fDPz5Jtuja7++p/mrkbPDWw+eDF0nrgK+yDIpMvkyrj8WpzSnwIVoTywpl08dZsOUnB+W880XcjHRFCrFwIPVazUvAymmdzUpGSfYcYX15jpW/evqEyZB4A=
Received: by 10.49.35.10 with SMTP id n10mr1517613nfj;
        Tue, 21 Feb 2006 07:45:47 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Tue, 21 Feb 2006 07:45:47 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16531>

------=_Part_15316_2450443.1140536747288
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

For people who stuck with ActiveState Perl, as there seem to be
no chance for it to support the list form of "open" in foreseeable future.

Working it around again.
Should be harmless, as there are only sha1s passed

---
@#$%^&* windows!!!

------=_Part_15316_2450443.1140536747288
Content-Type: text/plain; 
	name=0001-fix-git-fmt-merge-msg-on-activestate-perl.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejydrnbh
Content-Disposition: attachment; filename="0001-fix-git-fmt-merge-msg-on-activestate-perl.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Alex Riesen <raa.lkml@gmail.com>
Date: Tue Feb 21 15:53:39 2006 +0100
Subject: fix git-fmt-merge-msg on activestate perl

---

 git-fmt-merge-msg.perl |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

65ca8f2e90b9816c1748847fc406d26a56b7ad2d
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index 9071312..f4ecd13 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -33,7 +33,7 @@ sub repoconfig {
 	my $fh;
 	my $val;
 	eval {
-		open $fh, '-|', 'git-repo-config', '--get', 'merge.summary'
+		open($fh, 'git-repo-config --get  merge.summary |')
 		    or die "$!";
 		($val) = <$fh>;
 		close $fh;
@@ -43,7 +43,7 @@ sub repoconfig {
 
 sub current_branch {
 	my $fh;
-	open $fh, '-|', 'git-symbolic-ref', 'HEAD' or die "$!";
+	open($fh, 'git-symbolic-ref HEAD |') or die "$!";
 	my ($bra) = <$fh>;
 	chomp($bra);
 	$bra =~ s|^refs/heads/||;
@@ -59,8 +59,7 @@ sub current_branch {
 sub shortlog {
 	my ($tip) = @_;
 	my ($fh, @result);
-	open $fh, '-|', ('git-log', '--topo-order',
-			 '--pretty=oneline', $tip, '^HEAD')
+	open($fh, "git-log --topo-order --pretty=oneline $tip ^HEAD |")
 	    or die "$!";
 	while (<$fh>) {
 		s/^[0-9a-f]{40}\s+//;
-- 
1.2.2.g65ca8









------=_Part_15316_2450443.1140536747288--
