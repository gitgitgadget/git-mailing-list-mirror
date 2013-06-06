From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/9] sequencer: remove useless indentation
Date: Thu,  6 Jun 2013 03:58:56 -0500
Message-ID: <1370509144-31974-2-git-send-email-felipe.contreras@gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW4r-0006f3-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460Ab3FFJBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:01:45 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33830 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab3FFJA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:00:57 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so4308998obb.29
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tHigQ9S/6bEHTAp7WNuQ2mkfELy80d3tbDbNbReAZGA=;
        b=Yw/mOwr02Tlce5ORJxHcnVyWXptOcse2fcFJwisK/AP02V8GJot/gmMIaZdbbcj+ja
         UlHbmUicg90Prqd7gd90MA+S3S1iMex7mIWUHHSMtAsxHlxcqsq3XvY8dqp6R4fm+UAg
         PUErPPUCDHZxHYXCfRC1KG+lNf4Dj5T41NIvrO1kqRvGTsUtqKpNlwSk0CWr0+NKbpZV
         H/mxaob+pkTM5bDg6Z9GSHHVy0yWb6f1fB3OrXCa39Tooviri7918XxISrv1/6lSu39E
         bO7AVClS4WOzGnwyB0g37CaW4E6GaQa+W71vjaVq0Di3b5tz64nI8GOlTfCUl/BYsDCd
         Rc/A==
X-Received: by 10.182.215.133 with SMTP id oi5mr176065obc.83.1370509257351;
        Thu, 06 Jun 2013 02:00:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm57242229oby.12.2013.06.06.02.00.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:00:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226497>

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
1.8.3.698.g079b096
