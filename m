From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/6] sha1_name: avoid Yoda conditions
Date: Tue, 30 Apr 2013 16:49:11 -0500
Message-ID: <1367358554-4257-4-git-send-email-felipe.contreras@gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 23:50:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIRh-0003Lr-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835Ab3D3Vum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:50:42 -0400
Received: from mail-gg0-f173.google.com ([209.85.161.173]:58428 "EHLO
	mail-gg0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933760Ab3D3Vum (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:50:42 -0400
Received: by mail-gg0-f173.google.com with SMTP id h3so160656gge.32
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0cIUFGaJvG54SKtVQgfrJkbLPr/csagil0hCK3+sZ30=;
        b=vgOUG/Jx5WeSnZcRE9keotGsgX2heJdIE4neFdbYPtCpDuh75f6CJuYyeZ71M8wVK3
         XhOFKDQbbFZ1QIn15/XqDiZuXmKnigAtK0ANmeQAozfnoqqb69/4NbADjh9BOI4ynSYY
         1C0jUmykrAZn7r5SCpmK2IvEiKF41sGLva7OgNpSnbNwR425TqTxaI6Wj4BvngEJtK/3
         sgKClnkaPXmlO8LenbdiN90EQ2HF8WENA0tqkuZmrEM5sbU6LVPj1QII9J28N0Xacgio
         r6N9GNvKm0VG0FiA9ozLxsVZc6h3TQYy04vr6YLZ62XO3m8AiUkM3OOa8aKJupgoKxWW
         i7jQ==
X-Received: by 10.236.141.131 with SMTP id g3mr165702yhj.93.1367358641500;
        Tue, 30 Apr 2013 14:50:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id t41sm384797yhh.11.2013.04.30.14.50.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 14:50:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.395.gfe9a10d
In-Reply-To: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223016>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6530ddd..93c4e8c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -996,9 +996,9 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 
 	if (!len)
 		return len; /* syntax Ok, not enough switches */
-	if (0 < len && len == namelen)
+	if (len > 0 && len == namelen)
 		return len; /* consumed all */
-	else if (0 < len) {
+	else if (len > 0) {
 		/* we have extra data, which might need further processing */
 		struct strbuf tmp = STRBUF_INIT;
 		int used = buf->len;
-- 
1.8.3.rc0.395.gfe9a10d
