From: William Pursell <bill.pursell@gmail.com>
Subject: [PATCH 1/5] Change separator from '/' to ',' in add --patch
Date: Thu, 27 Nov 2008 21:10:11 +0000
Message-ID: <492F0CB3.7010506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:11:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5o9F-0004Uv-IY
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYK0VK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbYK0VKZ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:10:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:1808 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbYK0VKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:10:16 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1824194ugf.37
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 13:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Ajo/yqbwYremoqtaxHLEqhtJXBPNagm9G80iN94788A=;
        b=gGVJnfXoM6uFW+fBqkLPG7XSSDIRO9r20VG7AhUG8mWaA2cSN0AY8O6aU4p46NO+Xn
         UXuZlUvKi1TvQ8htTnhzA4J18Y9puORpEzr0CY3xWE445gqmaek5nVs0bd9Xmm9X3iTV
         C5sfL5mutJaWwOQI8vBcFY/4OBlx+fKm1ijHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=MC52EqR4j/FRO06EkU6wyrDwt4Md2LRYmvgMNPJKmlCPL6czLA4V6fEiY2BGv/TiCv
         Phb9BNf7oMST7Dy2e8T0WsKQWeFAduzwAlev71WPLdU1aVZi4/wNt96nU06IFVBUpDx/
         g9t5TopK8QsZKTzF3qC7vJ22jrgp2NJzeGqVM=
Received: by 10.210.28.6 with SMTP id b6mr7964412ebb.68.1227820214558;
        Thu, 27 Nov 2008 13:10:14 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id q9sm294617gve.6.2008.11.27.13.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 13:10:13 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101825>



This also simplifies the code some by localizing the
separator to the join at line 923.
---
  git-add--interactive.perl |   17 +++++++++--------
  1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b0223c3..6e474d0 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -879,7 +879,7 @@ sub patch_update_file {

  	while (1) {
  		my ($prev, $next, $other, $undecided, $i);
-		$other = '';
+		$other = 'ynad';

  		if ($num <= $ix) {
  			$ix = 0;
@@ -887,22 +887,22 @@ sub patch_update_file {
  		for ($i = 0; $i < $ix; $i++) {
  			if (!defined $hunk[$i]{USE}) {
  				$prev = 1;
-				$other .= '/k';
+				$other .= 'k';
  				last;
  			}
  		}
  		if ($ix) {
-			$other .= '/K';
+			$other .= 'K';
  		}
  		for ($i = $ix + 1; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
  				$next = 1;
-				$other .= '/j';
+				$other .= 'j';
  				last;
  			}
  		}
  		if ($ix < $num - 1) {
-			$other .= '/J';
+			$other .= 'J';
  		}
  		for ($i = 0; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
@@ -913,13 +913,14 @@ sub patch_update_file {
  		last if (!$undecided);

  		if (hunk_splittable($hunk[$ix]{TEXT})) {
-			$other .= '/s';
+			$other .= 's';
  		}
-		$other .= '/e';
+		$other .= 'e?';
  		for (@{$hunk[$ix]{DISPLAY}}) {
  			print;
  		}
-		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
+		print colored $prompt_color, "Stage this hunk [" .
+			 join (",", split( '', $other)) . "]? ";
  		my $line = <STDIN>;
  		if ($line) {
  			if ($line =~ /^y/i) {
-- 
1.6.0.4.782.geea74.dirty


-- 
William Pursell
