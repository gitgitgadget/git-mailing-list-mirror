From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/4] tmp: run-command: code to exercise check_command
Date: Tue,  2 Apr 2013 04:31:49 -0600
Message-ID: <1364898709-21583-5-git-send-email-felipe.contreras@gmail.com>
References: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 12:33:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMyWw-0002Y8-5I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 12:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762018Ab3DBKdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 06:33:00 -0400
Received: from mail-ye0-f180.google.com ([209.85.213.180]:49581 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761062Ab3DBKc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 06:32:59 -0400
X-Greylist: delayed 45907 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2013 06:32:59 EDT
Received: by mail-ye0-f180.google.com with SMTP id q11so22433yen.11
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=StYZHUKZInwz4mJXmU4lCI6AcivyqhpEl2v2oif16H8=;
        b=baVcQ/qhdQ4dqm2WiubjbnMOIymFjEymJFaZ2kd43oscqbvBwgDqs8TaY/izLSLoOF
         rB8Gl6x9NFXLR1oLf4sFbXW9gPBh7MiGUrl2Vw6wxChpWMToqYBBt6cFckmuRGtOqJBw
         3LqNNhr5jL3iJah1Q1UL05B5+YILXOkKLOqKu1wvbJ5JBxLEM+JkquFnpHx7P0iTaxDy
         y++LxIoQqXNlTWcnqLaq/Q6IStmDzuE2xXno+xPVtguDXKDhhGwaikofeBfrPdu3oIZh
         ORHJtel93smHKDykHggEijshb0wT+u/f/fWYvstxKlolm3WIMF4BHZ+6eS7sDkFBq8Xr
         p6fw==
X-Received: by 10.236.164.168 with SMTP id c28mr14088637yhl.164.1364898778961;
        Tue, 02 Apr 2013 03:32:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id b7sm2000237yhl.10.2013.04.02.03.32.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 03:32:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219766>

Do not merge!

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 run-command.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/run-command.c b/run-command.c
index b900c6e..2bb3dcf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -246,6 +246,11 @@ static int wait_or_whine(struct child_process *cmd, pid_t pid, const char *argv0
 	pid_t waiting;
 	int failed_errno = 0;
 
+	do {
+		if (!check_command(cmd))
+			break;
+	} while(1);
+
 	waiting = persistent_waitpid(cmd, pid, &status);
 
 	if (waiting < 0) {
-- 
1.8.2
