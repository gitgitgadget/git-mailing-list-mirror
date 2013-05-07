From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/11] sha1_name: avoid Yoda conditions
Date: Tue,  7 May 2013 16:55:08 -0500
Message-ID: <1367963711-8722-9-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpst-0008Tb-6J
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab3EGV5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:57:09 -0400
Received: from mail-gh0-f169.google.com ([209.85.160.169]:47901 "EHLO
	mail-gh0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab3EGV5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:57:05 -0400
Received: by mail-gh0-f169.google.com with SMTP id r1so214996ghr.28
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hAxJAxspfuRWOs+fmBUCGFMnNTJo5ZxkzVtODGws94c=;
        b=gOst6LyCvF3vUZruEVe/irNCgTqUNMykZJNtqQbqjzFuYJ8jzFj2VgMYic6zn8+zyN
         bY70C8d/juh017yNl6hdMHRvkCD4SJ9ICPZqUN1inzl8+K4mU9Y+9Qp4htPcy9w31S6P
         LVV8wRkJgoUwPllalBKEYzFmPGsKqgV9eX+F+kLkUVvjQ/JtP2+SvJc99wDq5HiEunBJ
         /64lZMl209PKuKrDodd5b/W/56lsPZowkMvBbPTSLih1OrF1bT++twD9vZDBRD2YdZFs
         yJf1wNdPD75DHG8taTIprQ3lAeFU3TfxE6iFB8GDHDr3IhnYVG+AxagE9VNn03gjBOM6
         V2Dw==
X-Received: by 10.236.36.17 with SMTP id v17mr3701501yha.158.1367963824627;
        Tue, 07 May 2013 14:57:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d51sm9385594yho.14.2013.05.07.14.57.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:57:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223612>

Speak in reverse we shall not; compare variable with constant, not
constant with variable.

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
1.8.3.rc0.401.g45bba44
