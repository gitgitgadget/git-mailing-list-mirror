From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 14/15] remote.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:55 +0900
Message-ID: <1401118436-66090-15-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wowvo-0005Rv-7w
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbaEZPfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:09 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48372 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbaEZPfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:35:07 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so7770508pbc.26
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J47zh+kV7wVouxgOtzb4OIqaJJwdgyQMXMWch4EkzX4=;
        b=omInhntINbqYlK1BWMHhLqOerNi2SBEqClopGOh3h/tNuJ8bHU63YsH7y+xHGeP+Nd
         axMkiDCC9ElegKRUoJopq1aGexK08Ij10ydquq1yPsSBjpc+mYGNFhBmvi/YfDnWlX4n
         x3ctq1qJwBxzck/27SVxna3299gqYYby2Ivt+1+oATXYNZiIBii/290yDBAE+pX7k79/
         ucUhevnRXErJTmqW9SOX2Q1bfhpMInka/MQ2Sn/TbIW7uMLUDvhB4lj+xIVXiNR0nvaD
         nvXJyVixQhdJIqqSRFxeo69jwVdvRLCGHjxtV4tEPp7U21rfRtuqb9oBSMRYIzxt4LPq
         N/AQ==
X-Received: by 10.68.131.227 with SMTP id op3mr28547245pbb.87.1401118506853;
        Mon, 26 May 2014 08:35:06 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.35.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:35:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250103>

xcalloc takes two arguments: the number of elements and their size.
parse_refspec_internal passes the arguments in reverse order, passing the
size of a refspec, followed by the number to allocate. Rearrgange them
so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index ebed40d..df3267b 100644
--- a/remote.c
+++ b/remote.c
@@ -523,7 +523,7 @@ static void free_refspecs(struct refspec *refspec, int nr_refspec)
 static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
-	struct refspec *rs = xcalloc(sizeof(*rs), nr_refspec);
+	struct refspec *rs = xcalloc(nr_refspec, sizeof(*rs));
 
 	for (i = 0; i < nr_refspec; i++) {
 		size_t llen;
-- 
2.0.0.rc1.543.gc8042da
