From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] tests: fix autostash
Date: Fri,  7 Jun 2013 18:45:14 -0500
Message-ID: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 01:47:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul6ND-0003s5-E8
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 01:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445Ab3FGXrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 19:47:06 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:62902 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3FGXrF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 19:47:05 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so3848118oah.40
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Imct4LLVfNP/T09GkkC+/7ON5jFLQ07X2Yu33/pcijk=;
        b=c2dIEsP1lk58AQuo1wz7dqOGbXvlvVllNbZv12YgLoB5KyrSeQuV52SJlaZ9hL9agq
         5PkrmlbkhVy3EZPMOn19GMctuwMbzB+7CDkxSR8YsQ7PwjtBifZrVWWjIbeFIbCrhjWF
         Dgcb5ggWcA4bbkTmZrk6cTE4iMcgqUPUMgV+zkVJIYr+V7HuKEIxHX37AGaMFA/fEDh4
         E680r2JfFrb4IyeccQtOeSrhn1qoGviFWe3UomdLfSi1KWDykkjSKcE6bv3no33xSsUn
         +9tljDKZM6Cia1tMJeKRdeVqHYCN3cjlvQBCVjMGzF71rXiiT+YHBdeGWGyWM7FTY5V0
         Tm4g==
X-Received: by 10.182.128.106 with SMTP id nn10mr675552obb.72.1370648824376;
        Fri, 07 Jun 2013 16:47:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm1538274obc.3.2013.06.07.16.47.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:47:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226766>

We should call 'git rebase --abort', like a normal user would do.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3420-rebase-autostash.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index a5e69f3..ff370a3 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -71,8 +71,7 @@ testrebase() {
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
 		! grep dirty file3 &&
-		rm -rf $dotest &&
-		git reset --hard &&
+		git rebase --abort &&
 		git checkout feature-branch
 	'
 
-- 
1.8.3.698.g079b096
