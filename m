From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Uniquify usage of subroutine prototypes
Date: Tue, 25 Mar 2008 13:11:54 +0100
Message-ID: <1206447114-29349-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 13:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je81J-00053K-C8
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 13:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbYCYMMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 08:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbYCYMMG
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 08:12:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:48374 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbYCYMMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 08:12:05 -0400
Received: by ug-out-1314.google.com with SMTP id z38so2355428ugc.16
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=4NVpCiGQoKjCyyIma8bqpHPWb0SJiRj85esZBKmWy1w=;
        b=HlvyqzKxD/IopCXySlOLzGiuGV5sYC2L8B6l0YPNWn8+bTONS3JwhjBHTMoS7SkNv1k08E4nPSOt72+q3MzxwvHTzLxVtncsvvRCCyYDvaU56lndUdnEv6LnmnYsIBhCrgTSrls6LGKxNbcI4OxeRLe0itz2LoHike1FDcuUFrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kgmE+w0FCCrsGKqa70ZYj30dII/NKRDUTnVcKoaxdE2RALkK3Svwx1sAGgMZE3L7UCU0X972nvjUkTPoNtjihudQs7FUZETQk0NSiPl+Gy03qRQmqAc2ct7CVXUwpMUntn236+uIJp48/1DGASF3xsADdNlF0CuRsdY6HeevuJk=
Received: by 10.67.116.9 with SMTP id t9mr480334ugm.77.1206447123324;
        Tue, 25 Mar 2008 05:12:03 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.226.89])
        by mx.google.com with ESMTPS id e5sm456800ugf.8.2008.03.25.05.12.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Mar 2008 05:12:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2PCBtcH029371;
	Tue, 25 Mar 2008 13:11:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2PCBsoh029369;
	Tue, 25 Mar 2008 13:11:54 +0100
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78183>

The idea is NOT to use subroutine prototypes to create new syntax;
prototypes are to be purely informational and optional.  Subroutine
prototypes are meant in gitweb to mark untypical parameters, like
having hash as an argument, or using hash for last parameter to pass
extra options to subroutine.

(Truth to be told this change was caused by the fact that CPerl mode,
Perl mode for GNU Emacs, got confused in presence of "sub name($) {"
prototype...)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec73cb1..ee5cbd6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -587,7 +587,7 @@ exit;
 ## ======================================================================
 ## action links
 
-sub href(%) {
+sub href (%) {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
 	my $href = $params{-full} ? $my_url : $my_uri;
@@ -740,7 +740,7 @@ sub esc_html ($;%) {
 }
 
 # quote control characters and escape filename to HTML
-sub esc_path {
+sub esc_path ($;%) {
 	my $str = shift;
 	my %opts = @_;
 
@@ -754,7 +754,7 @@ sub esc_path {
 }
 
 # Make control characters "printable", using character escape codes (CEC)
-sub quot_cec {
+sub quot_cec ($;%) {
 	my $cntrl = shift;
 	my %opts = @_;
 	my %es = ( # character escape codes, aka escape sequences
@@ -780,7 +780,7 @@ sub quot_cec {
 
 # Alternatively use unicode control pictures codepoints,
 # Unicode "printable representation" (PR)
-sub quot_upr {
+sub quot_upr ($;%) {
 	my $cntrl = shift;
 	my %opts = @_;
 
@@ -982,7 +982,7 @@ use constant {
 };
 
 # submodule/subproject, a commit object reference
-sub S_ISGITLINK($) {
+sub S_ISGITLINK {
 	my $mode = shift;
 
 	return (($mode & S_IFMT) == S_IFGITLINK)
-- 
1.5.4.4
