From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] remote-hg: fix for files with spaces
Date: Wed, 28 Nov 2012 02:01:32 +0100
Message-ID: <1354064495-23171-2-git-send-email-felipe.contreras@gmail.com>
References: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 02:02:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdW2a-0001oe-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab2K1BB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:01:56 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54402 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab2K1BBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:01:55 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5441611bkw.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oqKytG/5Yzh9TuyaC2CpjtgKb0StDp3fNFIZ4ab0Nj0=;
        b=tBPB4vrdhaJRrdsb9kubGbzUA2ji8vthgdTtgR8o06itSLzod4H6SkCUf4DJQ16A80
         3TntBqj556QeKDfzrTfd5SPg28vTIltxBeSJPAmZm3hxwegCvQe0OS1F5LYnCeUyNTms
         N4NGkPXnMdDi80tDlznikzAXzyK2JiqkmpXEV/a8CVnILT049+ijyMlxBmpKDz+IxdAe
         vpmxhwdae0BzK0W4wFFdnDmb0Uzjdd4JhNI7YSWV6PJY9gkUUldnONdcZEzRmXmyVrYO
         D9Go3JMqRwRreIPo4k+pDbUOBGV51KWdtY38QJ6l6bmo1Cq1Ab8njImj9/qxIwLLxucx
         JGPQ==
Received: by 10.204.147.6 with SMTP id j6mr5045088bkv.61.1354064514929;
        Tue, 27 Nov 2012 17:01:54 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id y11sm11483768bkw.8.2012.11.27.17.01.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 17:01:54 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1354064495-23171-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210648>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 07754bd..62c39db 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -565,7 +565,7 @@ def parse_commit(parser):
 
     for line in parser:
         if parser.check('M'):
-            t, m, mark_ref, path = line.split(' ')
+            t, m, mark_ref, path = line.split(' ', 3)
             mark = int(mark_ref[1:])
             f = { 'mode' : hgmode(m), 'data' : blob_marks[mark] }
         elif parser.check('D'):
-- 
1.8.0
