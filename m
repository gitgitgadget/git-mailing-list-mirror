From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/7] remote-bzr: remove files before modifications
Date: Fri,  5 Apr 2013 21:49:18 -0600
Message-ID: <1365220163-13581-3-git-send-email-felipe.contreras@gmail.com>
References: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 20:08:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSD-0001b9-GC
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162335Ab3DFDvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 23:51:10 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:65194 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab3DFDvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 23:51:09 -0400
Received: by mail-ob0-f179.google.com with SMTP id tb18so492808obb.24
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 20:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uxiw5lsWuniu3e6+BeaGcye07P/s5kqJ2UeWaph0N7Y=;
        b=B2nE78jaVy7FpQww+Ne7iGPoVA3/YnW6dA6VJSMSPvMhaKGYipecBe2mffQXbiY+7P
         L/4fiXXd53fuNihrc4SdCC4JZ3/fAcdP3LyOi5Lbkup8t5k2Yz7UQ2tCW135CpnfhUFK
         iSuvyR97QJFVfXyjMmenjaUExCyg2zwcnE2J0VP8ZIvxLQX/8RFIFc1G6v6CKUtdMgoE
         Iy/0y3YqwJDFFT/TX0OSR/B6MtcVNQbk8ddr1TkPnn6BopQyesxN7V/2jr+90hjVLjSv
         LnifDtLM2DzAcvSbK1LGL+OyWMzVBoJtaEB+4hBFZf8o8QSoCvszyeDExHIGzlytNqKE
         Oo8A==
X-Received: by 10.182.188.69 with SMTP id fy5mr10143988obc.14.1365220268322;
        Fri, 05 Apr 2013 20:51:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id xz9sm15193080oeb.5.2013.04.05.20.51.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 20:51:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220255>

From: Christophe Simonis <christophe@kn.gl>

Allow re-add of a deleted file in the same commit.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index a7d041b..f818e93 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -303,10 +303,10 @@ def export_branch(branch, name):
             else:
                 print "merge :%s" % m
 
+        for f in removed:
+            print "D %s" % (f,)
         for f in modified_final:
             print "M %s :%u %s" % f
-        for f in removed:
-            print "D %s" % (f)
         print
 
         count += 1
-- 
1.8.2
