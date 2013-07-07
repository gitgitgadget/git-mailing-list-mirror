From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 01/22] t2104: Don't fail for index versions other than [23]
Date: Sun,  7 Jul 2013 10:11:39 +0200
Message-ID: <1373184720-29767-2-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:12:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5V-0005m8-HE
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab3GGIMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:12:33 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:62466 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab3GGIM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:26 -0400
Received: by mail-ea0-f181.google.com with SMTP id a15so2302518eae.12
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5KuRsHzD2SjHeKWyKqHgwSBGWw0IzCAy+O/+Z5AiyrA=;
        b=e242Wo2pV/HTb1hvbiu81LE6aHkfAbUEhguInMwS5emqGM36P5S96t6zFHXaYRe7wR
         h7jomIUoPCtDWLi9YQZm3caFQogXubZjsbXhbI3+T+JIsSod8nl4dxUJT3aeaE8krcxW
         +yi7OiBoj3KJU6qdT+WoCEYWxbmGPJT8wOV2HUqiScsINyIp/VNqNJwB+crPIJm5/5TP
         2yigvntUkz1mTo/Wf8t1zcYlfzOjQazbiArmOnEFqX8aRpzcOc8ZGl+eWfwKm08doHMT
         2M2EidW43ShIDZ3BTRObaze55CyB4LzcRvbfdiCUfXs7u9mAc7g/hLwzIsbmNWPuYWGo
         O/lQ==
X-Received: by 10.14.216.73 with SMTP id f49mr19429430eep.119.1373184745403;
        Sun, 07 Jul 2013 01:12:25 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id b3sm30702682eev.10.2013.07.07.01.12.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229733>

t2104 currently checks for the exact index version 2 or 3,
depending if there is a skip-worktree flag or not. Other
index versions do not use extended flags and thus cannot
be tested for version changes.

Make this test update the index to version 2 at the beginning
of the test. Testing the skip-worktree flags for the default
index format is still covered by t7011 and t7012.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 1d0879b..bd9644f 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -22,6 +22,7 @@ H sub/2
 EOF
 
 test_expect_success 'setup' '
+	git update-index --index-version=2 &&
 	mkdir sub &&
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
-- 
1.8.3.453.g1dfc63d
