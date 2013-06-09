From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/45] sequencer: remove useless indentation
Date: Sun,  9 Jun 2013 11:40:21 -0500
Message-ID: <1370796057-25312-10-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UliiI-0006Yj-0E
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388Ab3FIQnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52207 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3FIQnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:17 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so8902269obb.5
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=orpjeyluJL/HODCto6qZkWlJbzrvN1KOtAopIdWYTbI=;
        b=ZUgbnUAZPUfkbtYLmYZHQk2nI+CklrfoInGb7KL1ah9nnssUoAqMT/fNV1KwIacR3m
         bSwexn55j5A/zmukFF3SXMqvBfxjbP08Mxl9TiGXlXffCXOtOKJ8jWzlB9ROOHSsamNP
         rKt3CSpRv/+vTKiGewCp9gUre/tfQ4LSgBmSXQH8wi+nhKLRSQTxLHwlq/Z7UMkJs0wD
         4o+Auuep1KSbMiY1ve//BWZ2UiGrWe7/o1s61sE6VRdMxM0h12V4PhdVZK+tBD0xO9/m
         Rr3UFi8gZGJv4hLLbx5N2MYC+poUONsTFn9ywXBoMJZYiwHmhMHoTrLHIT3KT/KIngZo
         gUZg==
X-Received: by 10.182.45.231 with SMTP id q7mr5275132obm.58.1370796197022;
        Sun, 09 Jun 2013 09:43:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm14970938obc.0.2013.06.09.09.43.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226981>

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
