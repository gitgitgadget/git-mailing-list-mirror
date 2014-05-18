From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 13/33] Check that "guilt header '.*'" fails.
Date: Sun, 18 May 2014 23:59:49 +0200
Message-ID: <1400450409-30998-14-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:06:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9EF-0004dB-6d
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbaERWGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:06:43 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:64783 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbaERWGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:06:43 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3487790lab.17
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZZJkqZEmaVLp0d/gegupPJ+/klqumM1eJr/BlC36vKg=;
        b=CdMzlmDRywDnskvS2UVEkTIPKXjQAX2NJ5HWR5EiEXTG7FGD/3K40QbxIfBLx5u5dm
         iEPFsNjAfrffozQcL3mPIGKPkG2FqXZhs946+Ku45Ekk8Os8G01hFvLitpHAgNkg6w36
         Gftug1PkGHciUsRIHPneyW/FRuqPxCJIfFV9G4YqrmkTaCmXbXyMQ5c4X1p7KzgaELXT
         nq+DW99BvDsd47s4mt1sRBki1hmWYYUmCxVFzHThD5wjoBb+dGGtKEgAFWv48DkO2S+Y
         224shRw4EE+xOwMIzWLvk3iIaj0w55nB5dxaS3e7JDo/freiskEJgPHb9CdMrGlPwgbK
         3Y3A==
X-Gm-Message-State: ALoCoQnhcl758nScxzA2j1PneHgR9gbravGwpmgsATXMZjC9il45/KjAvrZnRHStj4tW+rU5MHpG
X-Received: by 10.112.12.8 with SMTP id u8mr22320064lbb.9.1400450801985;
        Sun, 18 May 2014 15:06:41 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.06.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:06:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249528>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
