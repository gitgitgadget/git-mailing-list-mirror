From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 07/16] When debug==1, start fast-import with "--stats" instead of "--quiet"
Date: Mon, 20 Aug 2012 23:52:13 +0200
Message-ID: <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZuZ-0008Es-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab2HTVxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:19 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57659 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab2HTVxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:16 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so5688635wgb.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SHYBBb9eJVC6ubjii3SRbkaozBrchg0+ExQYaICg+UU=;
        b=vZEeY0iV3kIQHVppzbn5JOUzwmskAXSSKyBfpR3r3L5IDF5uHo4vcrqCORv1btpP7A
         gphEVeAbMkzcYQKWMxACA6oIcXYlfliuKSQue2EMqivOBPXeWcHGRq9BQWZ9AAonz4Ka
         7elmIIdJP5pK0Ykbb84ASEwTvPHJWUnhtmoWttPV/2wOULsiDdBvniPN68GIKx/ZEhi1
         49niV7WwVCsIrgvMvNdhj2IjX/r5qT8d8G7TnNcgmc7qqFDa/cnj6K3+FUOHm7zzfNTh
         mDColb6Knz1RtdaBFBdagdZq/zDCh0pQ8Lm5TV1qmB7dkV3xLQs+zs14hrvNVBmlnzgS
         hbdg==
Received: by 10.216.198.10 with SMTP id u10mr7940181wen.80.1345499595766;
        Mon, 20 Aug 2012 14:53:15 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.14
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203883>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 3523f1f..4713b69 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -385,7 +385,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	argv_array_push(&argv, "fast-import");
-	argv_array_push(&argv, "--quiet");
+	argv_array_push(&argv, debug ? "--stats" : "--quiet");
 
 	if (data->bidi_import) {
 		cat_blob_fd = xdup(helper->in);
-- 
1.7.9.5
