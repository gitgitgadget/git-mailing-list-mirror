From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 07/10] remote-hg: don't push fake 'master' bookmark
Date: Mon, 13 May 2013 18:11:57 -0500
Message-ID: <1368486720-2716-8-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:14:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1xG-0007WF-BT
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556Ab3EMXOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:14:46 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:37512 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483Ab3EMXOp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:14:45 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so8116384oag.25
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=g4o47Or1l3Y6bNRBQ2UFmtJg56xcn8xIHa1wfpc3KSI=;
        b=OuFD6A8UnujKroC4qfPAGVzirpwVEkEawnrQ6MhEeJy6xXVmW3F/4S0NEGDGPMGetc
         rBPf30LgWanRd0omhAVrl/vPFwX88cWWdoq/oLtalYfxxrTmfnN1zKe7HXTBMsToarc+
         YjcqTBmU+UOZs++8BMtXAgIzXEMFkTvpqCCSC4shLzJGbeEl+PQnGVx3E51oNluOuwug
         AtFf5eZnOwRnnli9cxAuOkTWBNmWp0Bp4nx2ObL47k4dIvO52ArVYsu6a/omXLw5CoFi
         lmgP0REVQf+o7cLrM/B9wpXDhUTnLFuMGEILzRt98HI6HkiZrlK1OD7XZKr9l1AuSbNc
         UN9w==
X-Received: by 10.60.57.103 with SMTP id h7mr14253790oeq.108.1368486885233;
        Mon, 13 May 2013 16:14:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p9sm19220007oeq.7.2013.05.13.16.14.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:14:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224225>

We skip it locally, but not for the remote, so let's do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 53412dd..beb864b 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -873,7 +873,8 @@ def do_export(parser):
 
         if bmark == 'master' and 'master' not in parser.repo._bookmarks:
             # fake bookmark
-            pass
+            print "ok %s" % ref
+            continue
         elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
             # updated locally
             pass
-- 
1.8.3.rc1.579.g184e698
