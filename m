From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 47/47] remote-hg: remove files before modifications
Date: Mon, 13 May 2013 23:37:10 -0500
Message-ID: <1368506230-19614-48-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc73H-0005A8-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab3ENElV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:21 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:42288 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab3ENElO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:41:14 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so101024oag.23
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uzivdxyONCd+l/z8ZFbVcidxYGveT0qJJizdQSWucHA=;
        b=LnuC7jB5UGqn+kaA9hbL1lNc/MCn8kASnyA/xiJG9IzsFHqPs5fG1E67vOsIFWJYEl
         Ej05obdfUoaB7rbyZ2EEogLp8nXpclAQ0jKlagQcsCK6LY75eAVLjD/sWISBvVRa4IiW
         T2bpZJzh8fe9mQYkTO1son4veKaA5J1xoKGCbQ9zhwZq6uMdyibxZu8mgk+3TNZwH4E+
         FxypmQIHHtc3RjwaEoRM1h5p8M+0fDAjvqkcl3EFSDFyTcRMUGJ/kkjhOrIhUVByXvsL
         LgjpjR/t17AQ7STaN9T8oBPa1wS6X1GP7kzD7Hpq1KUFF1DS8W4KkLqD6zWqT/xP1SwA
         xPUA==
X-Received: by 10.60.33.138 with SMTP id r10mr1937811oei.20.1368506474406;
        Mon, 13 May 2013 21:41:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm9280680obb.11.2013.05.13.21.41.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:41:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224277>

Otherwise replacing a file with a directory doesn't work.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 24100df..6c7439e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -491,10 +491,10 @@ def export_ref(repo, name, kind, head):
             if len(parents) > 1:
                 print "merge :%s" % (rev_to_mark(parents[1]))
 
-        for f in modified_final:
-            print "M %s :%u %s" % f
         for f in removed:
             print "D %s" % (fix_file_path(f))
+        for f in modified_final:
+            print "M %s :%u %s" % f
         print
 
         progress = (rev - tip)
-- 
1.8.3.rc1.579.g184e698
