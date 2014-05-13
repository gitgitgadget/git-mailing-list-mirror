From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 11/29] test suite: remove pointless redirection.
Date: Tue, 13 May 2014 22:30:47 +0200
Message-ID: <1400013065-27919-12-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:35:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJQ4-00048D-3R
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbaEMUfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:35:21 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:51578 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132AbaEMUfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:35:15 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so712800lab.2
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V9QNoPfs00mkEAEEkxoj2id8ytYkcuWgerF/LGxLU9I=;
        b=Fg0KUc9zTswTjiaX5SA9aVTNeEevA+hX1vw1Al3WqcjLujhgnW7ff2RZaOF7H8fBA3
         ax83YNZ6v8m+j96gVR9exS2AdE8StIUB7wvtgu3Vxzd6Vaik6MbL2T7XHqbX0RU6TIoY
         ZdIH91R2iGg1SSjocicTGNiIAL/e/BwZkxsOC+3Y98heF5HXnZcmh/XqS+fOU9uPLcZl
         9Zuc4Z1SnxhghEPIgJosE1He4qkeYBLim/y6cjO5v9F2xdOFP3xqbhycqAhB9ihYmfU2
         qrJeu3xcWDJYBTW44uwNbDTc+TyRje6jyYg77Cng+skwvjIPJi9oCAWFrq+MX83rvnT9
         2Kkg==
X-Gm-Message-State: ALoCoQlCnwHeG4U1qege7QmdRjTAdt+/AI6CUUFh7ha8e2oRBnm6N6TP1GQc1vdyirJNltdZHdiM
X-Received: by 10.152.20.194 with SMTP id p2mr19451912lae.13.1400013314118;
        Tue, 13 May 2014 13:35:14 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.35.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:35:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248826>

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
