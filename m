From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 3/5] git p4: Ignore P4EDITOR if it is empty
Date: Tue, 24 Apr 2012 09:33:21 +0100
Message-ID: <1335256403-22162-4-git-send-email-luke@diamand.org>
References: <1335256403-22162-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:34:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMbC9-0008GQ-Tw
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab2DXIdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:33:43 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55972 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756302Ab2DXIdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:33:38 -0400
Received: by wibhq7 with SMTP id hq7so410436wib.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=cz5qExkqDIcAKuJSjAtymgZ70yWCcWBoMQzJexfYiRs=;
        b=m+fY5GSx/22prXA1DOjUJCVkvYrDzXArNweLeFb3iHSFQS5CT2VGvU/3TaZZW8n5sN
         iMcYjWebhz5mg01yk+8SiZsb5fvpX5VkHKtXIsrEH9eAg0+xRWizp3LmJh94Vgy3B8Cm
         nmGzl7PssHg1cNirZ8mMOp9SbrhqvC6Lzej5fB8Whl71EhitZ6ckyNOwcIBctFQ8m5pc
         bfqA0ZRn8TQ19qfSfn8n09+qpdsuIVRGcYhqNh2bs7TvE8xARD7KVRHigLNnb6ORdgyY
         4VBf0/4FYwH/Zlr2graZkZh9ZtCdNRzfMxYfVw+sUOYuAEIYGvhgcFYg/DdS6ILXG0ls
         NEBA==
Received: by 10.180.104.230 with SMTP id gh6mr28806456wib.22.1335256413755;
        Tue, 24 Apr 2012 01:33:33 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fz9sm28534467wib.3.2012.04.24.01.33.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:33:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.8.g12781
In-Reply-To: <1335256403-22162-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQnIiM2NKv86FzMWtPqODZG+PdFPRNL+XB4Oxc24zbBNslEsoC69yvm1/RzmPnkoLvpz1rbN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196215>

p4 itself treats an empty value for P4EDITOR as the same as
having P4EDITOR unset. Do the same for "git p4".

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index f910d5a..ead0c44 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -970,7 +970,7 @@ class P4Submit(Command, P4UserMap):
         mtime = os.stat(template_file).st_mtime
 
         # invoke the editor
-        if os.environ.has_key("P4EDITOR"):
+        if os.environ.has_key("P4EDITOR") and (os.environ.get("P4EDITOR") != ""):
             editor = os.environ.get("P4EDITOR")
         else:
             editor = read_pipe("git var GIT_EDITOR").strip()
-- 
1.7.10.8.g12781
