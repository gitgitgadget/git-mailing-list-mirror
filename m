From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 1/3] Change prompt separater from / to , in add --patch.
Date: Thu, 27 Nov 2008 04:07:52 +0000
Message-ID: <492E1D18.2090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 05:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5YBo-0005Dg-Df
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 05:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbYK0EH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 23:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYK0EH7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 23:07:59 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:50691 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbYK0EH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 23:07:58 -0500
Received: by ey-out-2122.google.com with SMTP id 6so344172eyi.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 20:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=q2CG/GqekfiqTH8y0OKjGHC3JZV99j6CvTDW/FcYDJg=;
        b=cs3MaZzxIiA8RmBHmsM80gTpmyqferc1FaORgLFa2L6FsBIo4AGGRMU9Gxj9GzONw2
         dGJW6xZ1ryGnMFk54rwiVD0jZeerBM2r3gRtm9HkTfjk+0o7YoNDY9jdmnUdQw/a1WBR
         qRBQY+5yT9CP2dDeXJ2kb2+QqOGbGtF0ECEB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=DrneT+arDSNw1F1MfMAXuJwhqOYE7Xot5Ief5UbYLI7z+lkBYzNx8noFJdtQ1kdeky
         nD5AmNNq2Lk3AtlmvNLEdszt19NT+WeyeVPiFZMtctKqirYzi4HihsMxiMilNAhM5r0x
         TOQO/4EYkJbTt1pNJEf43R8dI2EsOLm//CM34=
Received: by 10.210.117.1 with SMTP id p1mr1335837ebc.82.1227758876274;
        Wed, 26 Nov 2008 20:07:56 -0800 (PST)
Received: from clam.local (5ad934ac.bb.sky.com [90.217.52.172])
        by mx.google.com with ESMTPS id d24sm4296923nfh.16.2008.11.26.20.07.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Nov 2008 20:07:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101788>


To enable adding the '/' command as an option, it is advisable
not to use '/' as the command separater.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
  git-add--interactive.perl |   14 +++++++-------
  1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b0223c3..f20b880 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -887,22 +887,22 @@ sub patch_update_file {
  		for ($i = 0; $i < $ix; $i++) {
  			if (!defined $hunk[$i]{USE}) {
  				$prev = 1;
-				$other .= '/k';
+				$other .= ',k';
  				last;
  			}
  		}
  		if ($ix) {
-			$other .= '/K';
+			$other .= ',K';
  		}
  		for ($i = $ix + 1; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
  				$next = 1;
-				$other .= '/j';
+				$other .= ',j';
  				last;
  			}
  		}
  		if ($ix < $num - 1) {
-			$other .= '/J';
+			$other .= ',J';
  		}
  		for ($i = 0; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
@@ -913,13 +913,13 @@ sub patch_update_file {
  		last if (!$undecided);

  		if (hunk_splittable($hunk[$ix]{TEXT})) {
-			$other .= '/s';
+			$other .= ',s';
  		}
-		$other .= '/e';
+		$other .= ',e';
  		for (@{$hunk[$ix]{DISPLAY}}) {
  			print;
  		}
-		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored $prompt_color, "Stage this hunk [y,n,a,d$other,?]? ";
  		my $line = <STDIN>;
  		if ($line) {
  			if ($line =~ /^y/i) {
-- 
1.6.0.4.782.geea74.dirty


-- 
William Pursell
