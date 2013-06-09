From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 09/36] sequencer: remove useless indentation
Date: Sun,  9 Jun 2013 14:24:23 -0500
Message-ID: <1370805890-3453-10-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:29:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllIa-0004R2-68
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab3FIT24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:56 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:62378 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab3FIT1K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:10 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so9129899obc.13
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=orpjeyluJL/HODCto6qZkWlJbzrvN1KOtAopIdWYTbI=;
        b=vCsvrx1FFKNvPcV0QUBxo/zQCkUR4f10k8+P2sXjSdXYLZnx9djWWV7P3YrBo+a3Jz
         1O01xHXzUsOcm1TQJlk4Ry6wo5wlqEbGCo/oszsEjh9cXVgTMLBCtQQ7CWACD43N+lp6
         LT178euvpE+M+CkelkugDtCxs0PZmzKBb5u1VNq59I9482iWrNuUyA6qtt+MUd7la6dZ
         HxinCA3KXlueMwoQUmvhpjTsBywcBzrYjGfnyz476osyaSNgG9HZs0OK6c0StL0YgDVo
         IxfSWDr3MGUe8s05JD1IwiNSeSFbgj7YeAOi2hfw8GLp4PyignS+KWBadaVIGalhYfoR
         jf/w==
X-Received: by 10.60.116.202 with SMTP id jy10mr5482890oeb.82.1370806029462;
        Sun, 09 Jun 2013 12:27:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id z5sm16014175obw.4.2013.06.09.12.27.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227145>

By using good ol' goto.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index e92e039..b2c8c94 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -390,7 +390,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0;
+	int res, unborn = 0, allow;
 
 	if (opts->no_commit) {
 		/*
@@ -535,14 +535,16 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		      msg.subject);
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
-	} else {
-		int allow = allow_empty(opts, commit);
+		goto leave;
+	}
+
+	allow = allow_empty(opts, commit);
 	if (allow < 0)
 		return allow;
 	if (!opts->no_commit)
 		res = run_git_commit(defmsg, opts, allow);
-	}
 
+leave:
 	free_message(&msg);
 	free(defmsg);
 
-- 
1.8.3.698.g079b096
