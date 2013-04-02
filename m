From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/13] remote-hg: update remote bookmarks
Date: Tue,  2 Apr 2013 13:02:59 -0600
Message-ID: <1364929382-1399-11-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6WA-0007LU-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932987Ab3DBTEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:35 -0400
Received: from mail-ye0-f182.google.com ([209.85.213.182]:40101 "EHLO
	mail-ye0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965Ab3DBTEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:34 -0400
Received: by mail-ye0-f182.google.com with SMTP id r5so113204yen.13
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kkuLnhFXMOaEc2Rp1tJAjFzr+luRRWib+N8n0w/BzBA=;
        b=Ej0q2KwZYDi/ctHtHDzcqPh9135jKo+E8weNKasb63JZSav2yEUCMmH0y4e/yTak/q
         R0wSpKRwCtQGfQ3uYnCYXY7+0amnT3Oa1zHjt3Sw61t5R5aCd5tOKGPoaVUUrVvbU5ik
         VHupjIaVX1704snDDZzLIw0mvTM89ecajMnrGYqhXOA2xSPIpuaePAFIAwEzwn9ig3rN
         Cr+SboDAmMysVvyCkeO6BrSXLQ6LlowE2Eo9UX3vGlW23Van6Hnfm3H4A6OZKFo5slqm
         oNXyV/Vww/Y3b93B1caFVbwNRm5O7tZ1tIpz0kE4cLEAw9Fcabl4ij3onpkLg1F7Cg4r
         zWKw==
X-Received: by 10.236.143.147 with SMTP id l19mr16249239yhj.79.1364929473474;
        Tue, 02 Apr 2013 12:04:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id i78sm4839267yhf.14.2013.04.02.12.04.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219843>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 11162a2..160f486 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -743,6 +743,11 @@ def do_export(parser):
             print "error %s" % ref
             continue
 
+        if peer:
+            if not peer.pushkey('bookmarks', bmark, old, new):
+                print "error %s" % ref
+                continue
+
         print "ok %s" % ref
 
     print
-- 
1.8.2
