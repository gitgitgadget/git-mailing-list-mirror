From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 11/31] test suite: remove pointless redirection.
Date: Fri, 16 May 2014 16:45:58 +0200
Message-ID: <1400251578-17221-12-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:50:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJTK-0005Td-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416AbaEPOup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:50:45 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:60409 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206AbaEPOun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:50:43 -0400
Received: by mail-lb0-f172.google.com with SMTP id l4so2036049lbv.31
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V9QNoPfs00mkEAEEkxoj2id8ytYkcuWgerF/LGxLU9I=;
        b=bxasCEOUhwr9P8G4WlwZtOo5NKFJAv1ds+X83wn7DF3FBJjeJY7qPH/42OrAv4zOG7
         ooDN/W5uRXO8gRMAla5RBgYsK+hx14sRjD8JAZrGBymWFJbNXmVoiiml7TaRCIRVqjf7
         zLKSldueg3JoppGijDCUROUPRRMkR1w1/W1FUOwc83YxqRwNpEbJzHb+zYjQIynV/IPH
         z81eoZcJsJAt0XaJaH3FPjd7zS+bW/ni6kCg+I1me5mnNr3L1Qh4Jg8YXvgghp+1cdoB
         O9vQSGB+WHJJLEOjfK6+4OXQVSF5rrDzMrxAdP0HLsTLcSOwHrOHBSVPhJDkebNwS9kE
         WewQ==
X-Gm-Message-State: ALoCoQmqrR8BnkZNCHoCipdK51iA+2ldufIip4EuhE4GsF5j0SiWa6C8NhJGifgQ9yONc/hy6bTt
X-Received: by 10.112.189.103 with SMTP id gh7mr11752883lbc.35.1400251841993;
        Fri, 16 May 2014 07:50:41 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.50.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:50:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249319>

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
