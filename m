From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/16] remote-helpers: avoid has_key
Date: Mon, 22 Apr 2013 16:55:09 -0500
Message-ID: <1366667724-567-2-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Dusty Phillips <dusty@linux.ca>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:57:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOjz-0001Cs-I7
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab3DVV5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:57:08 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:53419 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab3DVV5G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:57:06 -0400
Received: by mail-oa0-f41.google.com with SMTP id g12so5644613oah.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=G8Ar5MFLY32wE6W7z36Suvm468YqLGdONJQLYuaGy6Y=;
        b=SK0xjhWhcYwz6e92X1noKCxYbPGevfmKVRtWzyNqX9dAKCiB1CqRBzx7Bs7EBy6fCP
         R5+0r8UqW0PXPmitpgPbC0P7UWJ/rddgXfNViP8Np+xCzNsspUs4eQ5Efg8DaFjhy2GT
         FliOAGM3Z07bhQ5rwSZhEJtmD5vGlW89mVRr2GWT3FyH2KS4HE3pAXPVUxMc5lmhJ6K/
         sTertFa9tFDspLfSDj38G8N2vCTKWNtwbfyMVP8zxlGM/DCzG5rNLF/XzY8Vc24QlAjV
         CdFQ3Kou3LbwlOXxGPrk/RbafF+ZViaEqI5qbCr4tKjFbOX/wnwgX+LMQXnEAURTzKux
         yDgw==
X-Received: by 10.182.44.227 with SMTP id h3mr13327600obm.16.1366667825160;
        Mon, 22 Apr 2013 14:57:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id fl7sm19108496obb.0.2013.04.22.14.56.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:57:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222098>

From: Dusty Phillips <dusty@linux.ca>

It is deprecated.

[fc: do the same in remote-bzr]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 +-
 contrib/remote-helpers/git-remote-hg  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index aa7bc97..cc6609b 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -94,7 +94,7 @@ class Marks:
         return self.last_mark
 
     def is_marked(self, rev):
-        return self.marks.has_key(rev)
+        return str(rev) in self.marks
 
     def new_mark(self, rev, mark):
         self.marks[rev] = mark
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 5481331..2cd1996 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -129,7 +129,7 @@ class Marks:
         self.last_mark = mark
 
     def is_marked(self, rev):
-        return self.marks.has_key(str(rev))
+        return str(rev) in self.marks
 
     def get_tip(self, branch):
         return self.tips.get(branch, 0)
-- 
1.8.2.1.790.g4588561
