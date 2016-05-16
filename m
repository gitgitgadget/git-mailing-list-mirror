From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] difftool: initialize variables for readability
Date: Mon, 16 May 2016 11:05:36 -0700
Message-ID: <20160516180537.22212-1-davvid@gmail.com>
Cc: Jan Smets <jan@smets.cx>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 16 20:05:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Mtl-0005O2-J1
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbcEPSFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:05:41 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33244 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbcEPSFk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:05:40 -0400
Received: by mail-pa0-f68.google.com with SMTP id gh9so15109204pac.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jyYo4Zs574vzJaP4e9Vv+vNN1XImXsSU39osogLCTu0=;
        b=ZekOIxECaWPRV5cFH5Gci+8A3O690yTiMK9B9333sh3Va8CQdeQD//fz7sE0Y0iFE9
         FtuAo5G5agUTBGEaVusCFRwJWZX67/AofqpO7klhpoCSHWihfv5YNntlPldZQhq+qpow
         2L9OYm5pZckCJDHYqX366G7Bs3nxniwN1wwnuX+rsmRBwNZE3F6PXJXqOeb9QkkNaLa1
         gyNtLl66h0mFQMZNj4u8/1sNH3L3gtX2bqNtfbxQejIPF5Zo3MqdUNWgJ6x+xVrkQFWH
         Pb/alSoAvsUt3fwLslXAuHmooHS/0YhXvg2BVHR9lZEwRDtWsGZ0U8Eq2vPer0iqKVEe
         KUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jyYo4Zs574vzJaP4e9Vv+vNN1XImXsSU39osogLCTu0=;
        b=hcgg7bX2p5FbpuFFyvChi3LK7PriJb6KvGwwRrNe0CNKm39GpJ3Js7dqfKsLjzFeRs
         DebjnqYogxzhOOpeolSvYWIdbQVOhcF3kwdob36yHymmxI0KKWKTIhOQ6fGxPvN95mP7
         Y2qr7vGOTUpAprKe6CmVSsfvRlC4grccxX1oJNzxC5HY7rQUetH8FyJ5JzXUdAA+erg0
         1zzLt2rIa1lyUp2A/aH0y3M5V7ngEvD5f1gW2KwXx5o0KYqdwQvK70JeMzHWtYF0sv13
         1KLJciBLFyLtt+XI+nMNq1AuwIxEervIISB6NagAhUX3Txy/yS+87WEORYPm0VRzaoWd
         MKWg==
X-Gm-Message-State: AOPr4FVoK/yzPw9sVMxtbmPnIO6GYa70H9oSCS4TzMYbHu7YynUlgBBmevi57JUjnbXDnQ==
X-Received: by 10.66.186.238 with SMTP id fn14mr46368322pac.6.1463421939358;
        Mon, 16 May 2016 11:05:39 -0700 (PDT)
Received: from raptor.fas.fa.disney.com. (wdas-1.disneyanimation.com. [198.187.190.1])
        by smtp.gmail.com with ESMTPSA id yl5sm48873119pac.38.2016.05.16.11.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 May 2016 11:05:38 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.404.gdfc6a507
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294766>

The code always goes into one of the two conditional blocks but make it
clear that not doing so is an error condition by setting $ok to 0.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 488d14b..8cf0040 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -273,7 +273,7 @@ EOF
 	# temporary file to both the left and right directories to show the
 	# change in the recorded SHA1 for the submodule.
 	for my $path (keys %submodule) {
-		my $ok;
+		my $ok = 0;
 		if (defined($submodule{$path}{left})) {
 			$ok = write_to_file("$ldir/$path",
 				"Subproject commit $submodule{$path}{left}");
@@ -289,7 +289,7 @@ EOF
 	# shows only the link itself, not the contents of the link target.
 	# This loop replicates that behavior.
 	for my $path (keys %symlink) {
-		my $ok;
+		my $ok = 0;
 		if (defined($symlink{$path}{left})) {
 			$ok = write_to_file("$ldir/$path",
 					$symlink{$path}{left});
-- 
2.8.2.404.gdfc6a507
