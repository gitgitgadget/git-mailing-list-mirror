From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] remote-bzr: convert all unicode keys to str
Date: Fri,  3 May 2013 19:31:06 -0500
Message-ID: <1367627467-15132-2-git-send-email-felipe.contreras@gmail.com>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:32:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYQP6-0008BC-8F
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763273Ab3EDAcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:32:33 -0400
Received: from mail-gg0-f176.google.com ([209.85.161.176]:45887 "EHLO
	mail-gg0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762943Ab3EDAc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:32:28 -0400
Received: by mail-gg0-f176.google.com with SMTP id o5so332855ggn.21
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=79dUDkSjbqLEzj71oBsLVOGXFNyBQX/v8lWDu9TKqzg=;
        b=Cy0hQPqNL5UqwxsDLt7xBDlgqE+KeWynJYWfJ12C5uCqGB0Qd2vuAaR02iHHnct5Zr
         pAlxmtqpAXULutolh0qC/2MTRbLwUffDWDLAB6xHSHkRrGVXXghCEatNheM76OaKwU4r
         z1N/v61Rj1I8S6ABIVpdPhopIXOks9ANapRvPFM/9viBbqVx+M2FSx6ZTuw/FgMkoBBJ
         YtJrRqYi/E4gMUGlvt/ju9JEklWrStowSrAEyp9+Z7HiUXxDfJOG957Goo1ekijvYqVV
         WBZBnaXVGwnc/NbwkpGAbd8szH9bpkL1rqYh0JsBB4NiHkPddTzNn2Z+UYHHcBdO63bo
         7l1A==
X-Received: by 10.236.122.171 with SMTP id t31mr11376535yhh.5.1367627548445;
        Fri, 03 May 2013 17:32:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id a66sm16534448yhq.19.2013.05.03.17.32.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:32:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223345>

Otherwise some versions of bazaar might barf.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 161f831..bbaaa8f 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -95,7 +95,7 @@ class Marks:
         return self.marks[rev]
 
     def to_rev(self, mark):
-        return self.rev_marks[mark]
+        return str(self.rev_marks[mark])
 
     def next_mark(self):
         self.last_mark += 1
@@ -621,7 +621,7 @@ def parse_commit(parser):
         files[path] = f
 
     committer, date, tz = committer
-    parents = [str(mark_to_rev(p)) for p in parents]
+    parents = [mark_to_rev(p) for p in parents]
     revid = bzrlib.generate_ids.gen_revision_id(committer, date)
     props = {}
     props['branch-nick'] = branch.nick
-- 
1.8.3.rc0.401.g45bba44
