From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 8/9] remote-bzr: strip extra newline
Date: Fri, 26 Apr 2013 16:12:38 -0500
Message-ID: <1367010759-17928-9-git-send-email-felipe.contreras@gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpyV-0007ec-NM
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537Ab3DZVO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:14:29 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48153 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500Ab3DZVOT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:14:19 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so3970586obb.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=mwIxIjjT9v8IlCQupbXcw3+LDeOQVdIoOfBLF6ZQ/pI=;
        b=pvujnjSb+KZpVsvRZCBJ/LnxODqCwsDtH5xU2sG8s1IIVmazsrtVXSbAoVTOahObc9
         roVQjffjVyIHta0x/ndFF31RWZNbzoR0zcwwBbF7QD7R1awKl/dASsv6Q/09Bum2gdFg
         4m8U5Mu5iw86Qlwfanr9bEkClG1SssN/Qgr/PDyXsOiF6cFcEHrYusiolRA8y1rgkecK
         0v9o9IKfqk3G9IeOwlPeTbXD3Tla+NGK0jIioh0gqWGHKFm5oauR1Bj+ly9Wgrm+SqUb
         I86dxHaqP/zuFCdwAjVzy7gN64he6+0gH3j25kkw91qFYZ+PhEzOOzd2Bd065ZpO5nMQ
         QwpA==
X-Received: by 10.60.42.104 with SMTP id n8mr19809110oel.94.1367010858763;
        Fri, 26 Apr 2013 14:14:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wl10sm9397827obc.1.2013.04.26.14.14.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:14:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222591>

It's added by fast-export, the user didn't type it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 8617e25..9f56297 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -549,6 +549,10 @@ def parse_commit(parser):
         parents.append(parser.get_mark())
         parser.next()
 
+    # fast-export adds an extra newline
+    if data[-1] == '\n':
+        data = data[:-1]
+
     files = {}
 
     for line in parser:
-- 
1.8.2.1.1031.g2ee5873
