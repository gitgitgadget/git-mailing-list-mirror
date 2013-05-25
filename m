From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 41/48] remote-hg: remove files before modifications
Date: Fri, 24 May 2013 21:29:57 -0500
Message-ID: <1369449004-17981-42-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:34:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Iy-0002wk-4Q
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837Ab3EYCdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:51 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:39597 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab3EYCdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:49 -0400
Received: by mail-ob0-f169.google.com with SMTP id 16so5881759obc.0
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fMcqMrhsAmFNnploS/UMNFlKDIVqGMUrtxI+mMs0+i0=;
        b=g1oRDKD5qdKl0tyqw3EifR8LyKMhGDYwSyjyLYJlw7udnGmjJyHghr2RGnvoRjCtf/
         ExbtA3MqUO5MRYlnJL2AGhAz2q/HjO9Tc5X1wT4ATxog1PYu7ujGltGx8//zikE+MTE3
         YDnaGjPzpxMYAjfCRWGdnsEgVut+BlIdEo5uHSKKfuRFXbWs3xu9tF7fIBHVdEaoVCLT
         NXI83EI3Z0cF26DpoUNbuZ4plJ/gYJsDNvBz7eIzYTIH8Zdcaplv7+1w2odR4mwKGHop
         5dn5ooyMki8Fc0aNNhw9mMEOl1/3MHF70heRaVf8gEsqZUTtoDpDzGwQVKy+GW5t9Bnt
         DPYg==
X-Received: by 10.182.32.34 with SMTP id f2mr13626139obi.86.1369449229004;
        Fri, 24 May 2013 19:33:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm20037896obb.11.2013.05.24.19.33.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225455>

Otherwise replacing a file with a directory doesn't work.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index fa76b3f..bd545aa 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -510,10 +510,10 @@ def export_ref(repo, name, kind, head):
             if len(parents) > 1:
                 print "merge :%s" % (rev_to_mark(parents[1]))
 
-        for f in modified_final:
-            print "M %s :%u %s" % f
         for f in removed:
             print "D %s" % (fix_file_path(f))
+        for f in modified_final:
+            print "M %s :%u %s" % f
         print
 
         progress = (rev - tip)
-- 
1.8.3.rc3.312.g47657de
