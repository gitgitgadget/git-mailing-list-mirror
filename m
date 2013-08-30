From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] branch: trivial cleanup
Date: Fri, 30 Aug 2013 17:59:42 -0500
Message-ID: <1377903583-3550-2-git-send-email-felipe.contreras@gmail.com>
References: <1377903583-3550-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 01:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFXk3-0006Xi-5o
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 01:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab3H3XEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 19:04:24 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36917 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab3H3XEY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 19:04:24 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so2470859obb.37
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHVgHFy7LH/REBJau99EIZSp3BfNJlbBO5ebYIga7eI=;
        b=aqUjq4Hm9bISIHkEF8hq69F8GYjWn4UsXzNwZY60oL74qzOjYCMx0QTN9TYeLkaqRM
         ePSgdccG15MNpRyZ+aKytrCMAZzK8RMyk9LobYa4qnH6uZ+XpstzHQQkSmcV55OR6UOt
         TnxHGGB55rlVHwzcBMZ/pRDX0+FtoKq10JD6rqIic0Qpy0DrYn3OR5jPCOrhoyb9RkHL
         ILJqgnY2oTEcHj87G+IdR/o3ztpP2PNLv7ENXEuGmTxBcwPPWC6OOs04WnvUqBqt/CDq
         gQgxWsy+B8eYtLM9TI6P/GAi2rsx5vGnOWxxgCdZR1S9iV/Y6RtDMsXAUQp8HYLByQl1
         n5YA==
X-Received: by 10.182.237.44 with SMTP id uz12mr8751884obc.11.1377903863530;
        Fri, 30 Aug 2013 16:04:23 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm410747obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 16:04:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377903583-3550-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233481>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..ac17b18 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -425,16 +425,15 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	struct strbuf fancy = STRBUF_INIT;
 
 	if (!stat_tracking_info(branch, &ours, &theirs)) {
-		if (branch && branch->merge && branch->merge[0]->dst &&
-		    show_upstream_ref) {
-			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
-			if (want_color(branch_use_color))
-				strbuf_addf(stat, "[%s%s%s] ",
-						branch_get_color(BRANCH_COLOR_UPSTREAM),
-						ref, branch_get_color(BRANCH_COLOR_RESET));
-			else
-				strbuf_addf(stat, "[%s] ", ref);
-		}
+		if (!branch || !branch->merge || !branch->merge[0]->dst || !show_upstream_ref)
+			return;
+		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+		if (want_color(branch_use_color))
+			strbuf_addf(stat, "[%s%s%s] ",
+					branch_get_color(BRANCH_COLOR_UPSTREAM),
+					ref, branch_get_color(BRANCH_COLOR_RESET));
+		else
+			strbuf_addf(stat, "[%s] ", ref);
 		return;
 	}
 
-- 
1.8.4-fc
