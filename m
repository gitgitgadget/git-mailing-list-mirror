From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] remote-bzr: convert all unicode keys to str
Date: Fri,  3 May 2013 19:22:36 -0500
Message-ID: <1367626957-13858-2-git-send-email-felipe.contreras@gmail.com>
References: <1367626957-13858-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYQH1-0000qj-Oi
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763256Ab3EDAYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:24:13 -0400
Received: from mail-ye0-f182.google.com ([209.85.213.182]:36820 "EHLO
	mail-ye0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762722Ab3EDAYA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:24:00 -0400
Received: by mail-ye0-f182.google.com with SMTP id m15so390471yen.27
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=79dUDkSjbqLEzj71oBsLVOGXFNyBQX/v8lWDu9TKqzg=;
        b=Ns8R5Y8ZepzP5USysQU7fGs2P9O6C0IKaBHxsKohD50Y8jHWunDEhcpeOCII44ZRgi
         iN4JVbFJNoKztW8X5XoSSuykaMDpDdv1SYTstG60o8fBGBAX69z6ER1NjP3CRoc2VBLt
         TL79qWS4IYcXFU9uixRvFGoLklg58+KmSrdMQ6xPzC29ZpHybnnNLW9xBO7/IPy6M9JK
         1CrOmwkXqSFYIO9U6VxTfI/ApqaERaMl0JAC32EIah4ZJlmpPJ7NsHjsy/KBa8HcbIF6
         A1irZ2rehsjcaBp9heY4B+zZmGYLL9c2FLhv4wc/5yaN6V9q7k4T+GL9Nv5mQpPRGM8U
         rG7Q==
X-Received: by 10.236.148.162 with SMTP id v22mr11039451yhj.131.1367627039703;
        Fri, 03 May 2013 17:23:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h68sm24849066yhj.24.2013.05.03.17.23.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:23:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367626957-13858-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223342>

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
