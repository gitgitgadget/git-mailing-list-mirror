From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/44] request-pull: trivial simplification
Date: Sat, 28 Sep 2013 17:03:32 -0500
Message-ID: <1380405849-13000-8-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iX-0002uM-Ef
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab3I1WKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:20 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:61499 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab3I1WKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:17 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3060526oag.27
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0WhaLzg5q2R+ueOQP445uc6Bhmur3CkPJSYzhlfShZg=;
        b=QA/lZagx60OkGfD9hk+vTog1CzbS/GfwyrGsgFrgP1BbUDWpbqKJGX2CzzpL3q+9ni
         S3nA2PE1q6NfocsFIdnt08SZbHWyBv7mKW/Xvxyadm0mjCjjD4r2BIooxXNQv4GLap61
         u59CcYfkubqs3RbUhuP9sl0dlVn8X06RdyX8y5BJp0o8rRyHer243ATlnLle+QYBdpIU
         +aV5CwwhHFX0VLvVy52TbQguwuBSbEHPKnoz4AMsLFAhi/Aal+y27PEThCWmWx/Bp9Li
         8InfCKILQIwDZR7DZk1ihEHpJLct7qMa7Xwx/P8GfZP2HjgPSMiJEi0XQepPheE4bG+r
         8NqA==
X-Received: by 10.60.174.75 with SMTP id bq11mr12305511oec.17.1380406216503;
        Sat, 28 Sep 2013 15:10:16 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id j9sm25406799oef.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235527>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index c970244..d8b4c3c 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -86,25 +86,19 @@ find_matching_ref='
 		}
 	}
 
-	my ($tagged, $branch, $found);
+	my ($found);
 	while (<STDIN>) {
 		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
 		next unless ($sha1 eq $ARGV[1]);
 		$found = abbr($ref);
 		if ($deref && $ref eq "refs/tags/$ARGV[2]") {
-			$tagged = $found;
 			last;
 		}
 		if ($ref eq $ARGV[0]) {
-			$exact = $found;
 			last;
 		}
 	}
-	if ($tagged) {
-		print "$tagged\n";
-	} elsif ($exact) {
-		print "$exact\n";
-	} elsif ($found) {
+	if ($found) {
 		print "$found\n";
 	}
 '
-- 
1.8.4-fc
