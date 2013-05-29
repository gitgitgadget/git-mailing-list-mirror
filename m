From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/8] sequencer: remove useless indentation
Date: Tue, 28 May 2013 22:56:21 -0500
Message-ID: <1369799788-24803-2-git-send-email-felipe.contreras@gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXWs-0002wT-02
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934178Ab3E2D6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:13 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:41446 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab3E2D6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:12 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so11080707oag.13
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jEfLnNDlezi0vTutkR3ntMzMg68l6RTRKofUm7bELZU=;
        b=z1dihw5t75JjE2uKAeKmOalVHWnB7MkMHTgbd9LgOUjNlvSGGZE2NB3DTXKZZd49ok
         KE0KYOLoy6bCQvG+Cfp+I/FV5slQ6tkY+Q6hEKjAo4ZKH/lU6Te1nhgMCWvNIgX31Bt5
         +kckN47xz0OvUu6+avwzs9CN3D9IezMupKxqF1w85jSKq7Aa53yOeUvPg2QS/1179/CF
         AG1cz1PmEKWSpET1K2jr4GT33yVO7hOmGOAuIGGLTS1sYSTaklMS2YFqlNfoh2s90NZA
         sOd1orM+qAY0NaHICKi/5Ezl7D3B6ksduEfcbW1Q9kAWTYmGKHifJeRjCsgA5jW9z5US
         yJPA==
X-Received: by 10.60.85.74 with SMTP id f10mr533075oez.32.1369799891701;
        Tue, 28 May 2013 20:58:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm38282863obx.9.2013.05.28.20.58.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225715>

By using good ol' goto.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ab6f8a7..b4989ba 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -474,7 +474,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0;
+	int res, unborn = 0, allow;
 
 	if (opts->no_commit) {
 		/*
@@ -624,14 +624,16 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		      msg.subject);
 		print_advice(res == 1, opts);
 		rerere(opts->allow_rerere_auto);
-	} else {
-		int allow = allow_empty(opts, commit);
-		if (allow < 0)
-			return allow;
-		if (!opts->no_commit)
-			res = run_git_commit(defmsg, opts, allow);
+		goto leave;
 	}
 
+	allow = allow_empty(opts, commit);
+	if (allow < 0)
+		return allow;
+	if (!opts->no_commit)
+		res = run_git_commit(defmsg, opts, allow);
+
+leave:
 	free_message(&msg);
 	free(defmsg);
 
-- 
1.8.3.rc3.312.g47657de
