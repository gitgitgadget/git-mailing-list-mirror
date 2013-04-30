From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/6] sha1_name: remove no-op
Date: Tue, 30 Apr 2013 16:49:09 -0500
Message-ID: <1367358554-4257-2-git-send-email-felipe.contreras@gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 23:50:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIRg-0003Lr-9W
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785Ab3D3Vug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:50:36 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:55861 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933760Ab3D3Vuf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:50:35 -0400
Received: by mail-ye0-f170.google.com with SMTP id m4so165074yen.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=KQ+xnpeQGmVn+jBszGzICSyrar0GaVUCP5ozBZFLx2g=;
        b=FuQ2bJB8RPYBz47i3MhCtAcDzP9KZWaCqnQ6qtIDL+I0b8cs+3e5Gre6oTnpsbn//D
         eLfac9lxjEPl+9bozwzcE64tgJenplu1HO1eb+lelNZtjCvJX0nr0zluLOnk90/heesD
         ncyBoowV7evXLayufH9vlAGitOC9wtiVYlaFfFmo1HhxoVxhe2tDQa66OzMZ43dfiPF9
         T1+XZLYueNcK7j/D6Mv7a6EShE+/49Z50O2XHenhTkgYq2z8o4VgghA8upkkaFKfd5BX
         EZAoq/BsyyCwS7W8WT5Aelzi6D1WGnooThiUks6a/CB951KA40sarIHkgI2u6aqnKyq9
         uIkw==
X-Received: by 10.236.203.116 with SMTP id e80mr151011yho.109.1367358634669;
        Tue, 30 Apr 2013 14:50:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v57sm329732yhn.19.2013.04.30.14.50.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 14:50:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.395.gfe9a10d
In-Reply-To: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223014>

'at' is always 0, since we can reach this point only if
!len && reflog_len, and len=at when reflog is assigned.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..01e49a9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -464,7 +464,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		struct strbuf buf = STRBUF_INIT;
 		int ret;
 		/* try the @{-N} syntax for n-th checkout */
-		ret = interpret_branch_name(str+at, &buf);
+		ret = interpret_branch_name(str, &buf);
 		if (ret > 0) {
 			/* substitute this branch name and restart */
 			return get_sha1_1(buf.buf, buf.len, sha1, 0);
-- 
1.8.3.rc0.395.gfe9a10d
