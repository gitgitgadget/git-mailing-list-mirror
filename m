From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 11/33] test suite: remove pointless redirection.
Date: Sun, 18 May 2014 23:59:47 +0200
Message-ID: <1400450409-30998-12-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:06:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Dl-0003PG-IC
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbaERWGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:06:14 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:51727 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaERWGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:06:13 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so3450407lab.2
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V9QNoPfs00mkEAEEkxoj2id8ytYkcuWgerF/LGxLU9I=;
        b=YKzthbGAFNEbMmk4oBQi0kEmrlU7r8UzWBpBYYBZKTN4J7BYa5juOJqu8REKiJBbVF
         2zhrhnSJJj12jp5cTq8B+6qnvx1//nRWRqCI2Os2R/uDt9cN2xb9HvvWe63HDsaQHI0g
         v+VX/ECAUwp9/r5lGZXombLrJ1zvgOmUwphXNtZOTaQ1rFtUaXYnUbTQatL54Xhnty5W
         n/ybRRkqmPeszs/Eu+P9TV/b3290Cj5mn1DfXkh4O5UjBj2ZSvNS+oe5gXKAM5KrdRwg
         PeZf6RE5LVLe+PlUwiq11h1WOHz33CvKXK36FssiftvC+njBwsLR1uQagPLZQzyp50g/
         uL+w==
X-Gm-Message-State: ALoCoQmbW1FOGic0+S4R7GSUU/AngTx8bgrMPiw2So27Z+JEyvKEhPnFs13dM9y/FCFyU47p7KK0
X-Received: by 10.112.146.234 with SMTP id tf10mr21980578lbb.1.1400450771828;
        Sun, 18 May 2014 15:06:11 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.06.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:06:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249526>

The shouldfail function already redirects stderr to stdout, so there
is no need to do the same in t-028.sh and t-021.sh.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 regression/t-021.sh | 2 +-
 regression/t-025.sh | 2 +-
 regression/t-028.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/regression/t-021.sh b/regression/t-021.sh
index 6337d7b..614e870 100755
--- a/regression/t-021.sh
+++ b/regression/t-021.sh
@@ -61,7 +61,7 @@ for n in `_seq -2 $npatches`; do
 	if [ $n -gt 0 ]; then
 		cmd guilt pop -n $n
 	else
-		shouldfail guilt pop -n $n 2>&1
+		shouldfail guilt pop -n $n
 	fi
 
 	cmd list_files
diff --git a/regression/t-025.sh b/regression/t-025.sh
index 3824608..985fed4 100755
--- a/regression/t-025.sh
+++ b/regression/t-025.sh
@@ -44,7 +44,7 @@ shouldfail guilt new "white space"
 cmd list_files
 
 for pname in prepend mode /abc ./blah ../blah abc/./blah abc/../blah abc/. abc/.. abc/ ; do
-	shouldfail guilt new "$pname" 2>&1
+	shouldfail guilt new "$pname"
 
 	cmd list_files
 done
diff --git a/regression/t-028.sh b/regression/t-028.sh
index 8480100..88e9adb 100755
--- a/regression/t-028.sh
+++ b/regression/t-028.sh
@@ -29,6 +29,6 @@ guilt series | while read n; do
 	cmd guilt header $n
 done
 
-shouldfail guilt header non-existant 2>&1
+shouldfail guilt header non-existant
 
 # FIXME: how do we check that -e works?
-- 
1.8.3.1
