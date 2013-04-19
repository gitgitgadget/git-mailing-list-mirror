From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 11/11] contrib: cc-cmd: ignore chunks with no original lines
Date: Fri, 19 Apr 2013 14:30:31 -0500
Message-ID: <1366399831-5964-12-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2t-0005Hs-LM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab3DSTcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:24 -0400
Received: from mail-qe0-f48.google.com ([209.85.128.48]:59346 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab3DSTcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:32:19 -0400
Received: by mail-qe0-f48.google.com with SMTP id 9so770978qea.7
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jIKFSX34eAts3X72QME5rvcKMiKnnytjdOxetPShdPE=;
        b=qSqt2+5+AlZcuO9/NJ6S7nk/b0NeEAuySlY0y9um+q9bj2Nv1Tg+nm8Wua5a3eatXV
         rFCyaMlfUjheYLEU5bxrLu0lxzG/nsENn8uSmdbEYrQTcD9+5RUwd97SoWQOZcIhn2qb
         yBx8XOcCBasWtdOZD9pdx0ix/LvSfco8OjcYK5IJ506jWwTIbiRcsxVNuJpmUVO/Dtrw
         3Vqwen+SrQxNtGD204W+5zqLBH2LbIBxPRaDp4zWDqiuYSS30NNmq9EcVwvV22OsgrCs
         eBRGPVtErAezXTqDqDZPYvIQuGQSWvjGjv9Zhy2XR8kHXapcdBh2wpQhFM0lIusU/vr/
         ghYA==
X-Received: by 10.224.80.4 with SMTP id r4mr14941623qak.95.1366399939299;
        Fri, 19 Apr 2013 12:32:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id kn10sm18696317qeb.8.2013.04.19.12.32.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:32:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221806>

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 9a2d2fd..02841c4 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -125,7 +125,7 @@ class Commits
   end
 
   def get_blame(source, start, offset, from)
-    return unless source
+    return unless source and offset
     File.popen(['git', 'blame', '--incremental', '-C',
                '-L', '%u,+%u' % [start, offset],
                '--since', $since, from + '^',
-- 
1.8.2.1.790.g4588561
