From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 13/29] Check that "guilt header '.*'" fails.
Date: Tue, 13 May 2014 22:30:49 +0200
Message-ID: <1400013065-27919-14-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJQQ-0004n2-0x
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbaEMUfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:35:41 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:60867 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbaEMUfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:35:39 -0400
Received: by mail-lb0-f175.google.com with SMTP id l4so706968lbv.20
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4KaPcCrOhvifmR6kVqqshYkiPoeMmjYldhuspZj1FAQ=;
        b=NlAPtdovfpV7qzn5/KMi3Kb0+NrtdkswOoCqPbI5pOZCEL9pupOmXVYf0UGAMsZYWw
         Li/sWEjW51V1wJGCixQdavGD/UJBBUAcA6tLmneRT9iNS+J8sB5UKYez5/ai2gqZX7Gk
         yucasvRNUc+9wnx5uc5xk8t2XYqf37g/4IRURyI7okib9lLxrkGlPnspJ6l5RwzJ1xV1
         vpIliB/2dZ8iiNph69Dv7yltukeofOJMU2x6/zAgEIYacHMiCiqgVMZXO32R2jNddYS4
         FqFxew1AF/pnZE+3vMaBTzLrVbIGajakB2w5oK1o4JT4bVRKxPOXKI5EvFr61WeCsYV0
         JdQQ==
X-Gm-Message-State: ALoCoQnravlh9x1o/RDUPvVY0AewIPfKyAkZFqek7PexPVdd4lhZtxNOZV7OEYR2t8otaN4U8H2S
X-Received: by 10.112.67.35 with SMTP id k3mr29901653lbt.17.1400013337670;
        Tue, 13 May 2014 13:35:37 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.35.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:35:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248827>

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
