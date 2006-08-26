From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: git_annotate didn't expect negative numeric timezone
Date: Sat, 26 Aug 2006 02:13:05 +0200
Message-ID: <200608260213.06176.jnareb@gmail.com>
References: <200608260147.10880.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 26 02:13:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGlnP-0000Na-Gf
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 02:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422936AbWHZAND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 20:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422940AbWHZAND
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 20:13:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:50392 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422936AbWHZANB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 20:13:01 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1024637ugc
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 17:13:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R3b8HKJn7pG1Tdy13564MwAY3XEfERBOA1KGj2Bg5dVM3mfnwdgDUt3qa7Ghd/WsFvecxwrbhAOCP16DFvTk9LOD31qAh3eCGAgwB6onU0T+v7KfmJX6ygFKPGlXEJb3y7sR71G69jo/GfYTde0aP+VOucD0h4lEDsETZiHES3s=
Received: by 10.67.89.5 with SMTP id r5mr2240614ugl;
        Fri, 25 Aug 2006 17:13:00 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id y1sm3932888uge.2006.08.25.17.12.59;
        Fri, 25 Aug 2006 17:12:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608260147.10880.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26020>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This fixes error in git_annotate mentioned in parent post.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6344263..e5a0db5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2298,7 +2298,7 @@ HTML
 		chomp $line;
 		$line_class_num = ($line_class_num + 1) % $line_class_len;
 
-		if ($line =~ m/^([0-9a-fA-F]{40})\t\(\s*([^\t]+)\t(\d+) \+\d\d\d\d\t(\d+)\)(.*)$/) {
+		if ($line =~ m/^([0-9a-fA-F]{40})\t\(\s*([^\t]+)\t(\d+) [+-]\d\d\d\d\t(\d+)\)(.*)$/) {
 			$long_rev = $1;
 			$author   = $2;
 			$time     = $3;
-- 
1.4.1.1
