From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 3/3] git-p4: Change p4 command invocation
Date: Wed, 25 Jan 2012 23:48:24 +0000
Message-ID: <1327535304-11332-4-git-send-email-vitor.hda@gmail.com>
References: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 00:48:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqCaD-0002PC-8b
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 00:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab2AYXss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 18:48:48 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:40803 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab2AYXsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 18:48:46 -0500
Received: by werb13 with SMTP id b13so4239096wer.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Onk5Hs90mPXd5D5XsyvRqFj9zGtsGTs7n6OdThYvqBs=;
        b=kPvbhKPp6tdIcLXgSw7ZG99IQRjmy1x6jG23fg+7UUYYsJE5aev+Fb/U6FDKVd20vM
         X3YEvkGJZcHTRJX3FNue6LjsbIYYlJrbQjuPc0WR5Vr2+Anf31i3yu0sdlunSTVxxvnW
         E2OMDFN+qCPEDIoaYA6JlrzpyaU57SJTmGkiw=
Received: by 10.216.139.204 with SMTP id c54mr8142148wej.13.1327535324799;
        Wed, 25 Jan 2012 15:48:44 -0800 (PST)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id df2sm2551041wib.4.2012.01.25.15.48.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 15:48:44 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1327535304-11332-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189135>

From: Pete Wyckoff <pw@padd.com>

Change p4 command invocation to avoid going through the shell. This
allows names with spaces and wildcards to work.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 584cc41..74d3613 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1975,7 +1975,7 @@ class P4Sync(Command, P4UserMap):
     def importChanges(self, changes):
         cnt = 1
         for change in changes:
-            description = p4Cmd("describe %s" % change)
+            description = p4Cmd(["describe", str(change)])
             self.updateOptionDict(description)
 
             if not self.silent:
-- 
1.7.8.3
