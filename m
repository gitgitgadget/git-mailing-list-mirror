From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 09/19] builtin/tag: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:28 -0700
Message-ID: <2931e950153369cbdc6ee583cd987129dd608726.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7w6-0000oZ-Kw
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbaFIWU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:57 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:53484 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:57 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so5524322pbc.30
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=g3Hy/qqTM6If+eb5XD1GyEyJsNyfD1M3xAiepVgeEe0=;
        b=xiG9QxSJHilELU38AuPz2NYN/gYh0KWbA4vZkPHyfEyN6b0pa0RKb9MTlPirFLlO+K
         wEtgPqtR+lcUIUtVqQWJx0YSQTYy8ahnjwV5k/K0FGNup47FcGX/VhJI/g3ttkoOeqvk
         2SC3hAwApVbdxeW2Lttfbcr8aYXqGxfRzfC2OVozB9D+9L+yvTD7sxngRLGHP4RHdTT+
         LP9CSxpitofqGG20Qe+aoB/DKxpyMJkzIQfOnxMmyf7R4m6CYnYqIV1X/yGZAannxMjW
         5FYpIXvFFYoCx8E5vl4l0HQjx9bJ2SkjecGSHVI8pM5vbfbCb2pJNJCIPnD/F3Mq+JtO
         Rguw==
X-Received: by 10.66.66.225 with SMTP id i1mr1320238pat.0.1402352456743;
        Mon, 09 Jun 2014 15:20:56 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xk3sm65784950pbb.65.2014.06.09.15.20.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:55 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:52 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251117>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/tag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..b545c21 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -496,8 +496,7 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	if (name[0] == '-')
 		return -1;
 
-	strbuf_reset(sb);
-	strbuf_addf(sb, "refs/tags/%s", name);
+	strbuf_setf(sb, "refs/tags/%s", name);
 
 	return check_refname_format(sb->buf, 0);
 }
-- 
2.0.0.592.gf55b190
