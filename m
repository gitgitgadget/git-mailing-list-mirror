From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 03/20] remote-hg: properly report errors on bookmark pushes
Date: Mon,  8 Apr 2013 12:13:17 -0500
Message-ID: <1365441214-21096-4-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:15:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFf5-0004EZ-1x
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934775Ab3DHROw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:14:52 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:38205 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934710Ab3DHROu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:14:50 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp18so5297114obc.28
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6RnqPkOzcSu/6IgaZeg8/+MHi2o/J089wvX3sg7PyhQ=;
        b=tK2LitWeq70vEhV06R6KPHl19SWJBbC7UL7rHQu6Aowed1s/am0ReoKaWpnIA649jC
         XjZYRPj/hAjzFrPej+byRQjTkL/uRrVblEMZhfOWs+QsGdfCCQ7t+XCL3hf/eVl2Dihs
         eS/JspSUBDEa+Z69UC6vrD0JeElTT70vBtojQqqw3dRF5v6lUzp9J38mcZPJzjE17Cca
         76H/vmVkX9WA/wujIsKQJJsUml4WTkxqLEvD2UgMekblHhM91VJUVdmKSG/liTMgwa7o
         cF4vDB2sn0h4YWegE0qDtFBtLk/85E83t4PCjT4y7QzOqf9U85LfCBRLB17OblUKaP/D
         fYPg==
X-Received: by 10.60.59.131 with SMTP id z3mr16217597oeq.96.1365441290461;
        Mon, 08 Apr 2013 10:14:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s8sm4894714obf.2.2013.04.08.10.14.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:14:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220445>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 844ec50..19eb4db 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -710,6 +710,7 @@ def do_export(parser):
             else:
                 old = ''
             if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
+                print "error %s" % ref
                 continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
-- 
1.8.2
