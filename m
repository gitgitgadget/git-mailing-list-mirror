From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/7] remote-bzr: remove files before modifications
Date: Mon,  8 Apr 2013 12:27:11 -0500
Message-ID: <1365442036-25732-3-git-send-email-felipe.contreras@gmail.com>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFrt-0001Hy-C3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934607Ab3DHR2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:28:25 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:56371 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934447Ab3DHR2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:28:23 -0400
Received: by mail-ob0-f182.google.com with SMTP id ef5so6060579obb.13
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uxiw5lsWuniu3e6+BeaGcye07P/s5kqJ2UeWaph0N7Y=;
        b=hHR8JAm7goCJz3by7xu8APLcqLGe/NRaBB8iJXFJu7n2gq+vI+bJSvFEsZwWo3qsyv
         3kUV68MLJF8qMXZyhsKj2/W6URERplgA9u8Kl29sQu64JjtyYVybGK/MFmH45SJNrp0B
         W3BMn8J5XuEwZC4+17PZvT5YxJLcPFg4WO7QKqPmOgzmE5iaox329iObj8G1al3CT/DX
         ZWLkpBsEAjq7dpzqBfkv1XmtKjxMRt/WiKoOfid6l0xKMs4OJYRE/h7NCcSyo22ijVPc
         PDudKZYmJVmwSfNprc56W6uvIMA+l7oxrRxsJruF73On1IXXSHtTW/VdXVH27BxA75MS
         T56g==
X-Received: by 10.60.63.73 with SMTP id e9mr15984250oes.87.1365442103205;
        Mon, 08 Apr 2013 10:28:23 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id zc8sm25050916obc.8.2013.04.08.10.28.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:28:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220466>

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
