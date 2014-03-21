From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 11/28] test suite: remove pointless redirection.
Date: Fri, 21 Mar 2014 08:31:49 +0100
Message-ID: <1395387126-13681-12-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQty0-00035m-8B
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759824AbaCUHdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:31 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:45366 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809AbaCUHdR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:17 -0400
Received: by mail-la0-f50.google.com with SMTP id y1so1370011lam.37
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bed7oVQHVNSAUdeVdKFONvolZs6x0OJeJWyJ9bc9rjY=;
        b=cD2HIhppdYMyavKS/nmSGekpyDL2/G2hZklUgpdSfbUYzDlkb6+wyG6u4uu/nNOjJM
         bc/CNY0q3aldPyDN+YkZZWeNJG4jSFS0Gn8OqeT6H/h7KL+7o/yMNTSTyALz6BLSyNkD
         jDxTyztk+PPR+UIUhcDGevpCP3lG/Impn0tV+eS2hUvdiNjnHBpxPs/vIBE8Q7rGpg4n
         CEMSKXorX/8GjCgdvqJk+5sF7xtVrxzb876NXt7CBfvaw7p8rwMhBRAsaps94b/Hez7s
         r9RsFMq5tHJtcirZYEeHjj95eLmS+L6MenBq9ntD/UCIJCU/oDBZzwRraPI4SNRP3aez
         4IDw==
X-Gm-Message-State: ALoCoQmibL+5Qf8SVr+fOH3hvlWcpocpKz6FnQbMo6tLTY38s4W60l17x1kkm8dnir6riQ2sTtoz
X-Received: by 10.152.36.73 with SMTP id o9mr869112laj.30.1395387195786;
        Fri, 21 Mar 2014 00:33:15 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244658>

The shouldfail function already redirects stderr to stdout, so there
is no need to do the same in t-028.sh and t-021.sh.

Signed-off-by: Per Cederqvist <cederp@opera.com>
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
