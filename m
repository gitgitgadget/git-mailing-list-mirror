From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 13/28] Check that "guilt header '.*'" fails.
Date: Fri, 21 Mar 2014 08:31:51 +0100
Message-ID: <1395387126-13681-14-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtyi-00045e-LR
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759932AbaCUHey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:34:54 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:47275 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049AbaCUHdU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:20 -0400
Received: by mail-la0-f52.google.com with SMTP id ec20so1372941lab.39
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4KaPcCrOhvifmR6kVqqshYkiPoeMmjYldhuspZj1FAQ=;
        b=k+0qmVMN5gnz6WtVmtz8P3pyP9j+rE67W9CDajgTTZW/9w78+uJHPufoXV9/ezTeFf
         ZqHSpbolVQTyxv5tSxtobRm8uRvs6tSvFiqa42jrBhSryWr4zyeENM/iiRI+rZ8qkw6a
         xnFJrlDVOFaumHSI6wGOv3376Xye847WPj0tg9jO3+OCofdcWaTp1YU7kEZciBNXBgnz
         gKmpTFiatYxB1223IzJJilsue0KFqJZBSN2y81oqhQCHeOogT3vY57yEsSQyeqD5YLoR
         tPuM1k9g4PlqtTU5/rQRvwaw2hIDA/xMuzjG/NIyY7K9RqCRt0LMWaX8OY5FbYnPAg3O
         aFmQ==
X-Gm-Message-State: ALoCoQl3ZPUEo90JENpaRaW/SPo7mw8EnDBcE4gr1NmTtQ899Stzphs5g0howQVmImZ3UeI88GOQ
X-Received: by 10.152.3.72 with SMTP id a8mr9109577laa.33.1395387198780;
        Fri, 21 Mar 2014 00:33:18 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244668>

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/t-028.out | 7 +++++++
 regression/t-028.sh  | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/regression/t-028.out b/regression/t-028.out
index 1564c09..ea72a3a 100644
--- a/regression/t-028.out
+++ b/regression/t-028.out
@@ -49,3 +49,10 @@ Signed-off-by: Commiter Name <commiter@email>
 
 % guilt header non-existant
 Patch non-existant is not in the series
+% guilt header .*
+.* does not uniquely identify a patch. Did you mean any of these?
+  modify
+  add
+  remove
+  mode
+  patch-with-some-desc
diff --git a/regression/t-028.sh b/regression/t-028.sh
index 88e9adb..2ce0378 100755
--- a/regression/t-028.sh
+++ b/regression/t-028.sh
@@ -31,4 +31,8 @@ done
 
 shouldfail guilt header non-existant
 
+# This is an evil variant of a non-existant patch.  However, this
+# patch name is a regexp that just happens to match an existing patch.
+shouldfail guilt header '.*'
+
 # FIXME: how do we check that -e works?
-- 
1.8.3.1
