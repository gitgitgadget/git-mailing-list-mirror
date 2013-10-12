From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 1/2] branch: trivial cleanup
Date: Sat, 12 Oct 2013 02:00:28 -0500
Message-ID: <1381561229-19947-2-git-send-email-felipe.contreras@gmail.com>
References: <1381561229-19947-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:06:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtHe-0001Ff-3f
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab3JLHGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:06:34 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:35746 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab3JLHGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:06:33 -0400
Received: by mail-oa0-f42.google.com with SMTP id g12so3117845oah.1
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHVgHFy7LH/REBJau99EIZSp3BfNJlbBO5ebYIga7eI=;
        b=QNDAaJfmVPaFBtej5cyMZv5kZkZmbazqsaNA1bX+YxJ4Vcv3LoGhix1tTNZHWY0yis
         YgQZG0fuAWUWwu0ZrBPp13eYfDZamAaDcvwwanBTSGuzk11pCDt3tkX++LmCzDMSW93E
         aXZN3mdo4SNsFuv++QmlkXeQRhdh1vl0H6Jwe4oWd63CpUUHA0+eVaw9vg0IrcfOWpWT
         hbNi1YKNqpwlwlFTic0GWtgU5tmMsBBeVsUQQIg4yrm8dd/ttBY3FJ3Od3p1fZQokc0e
         qWyU6nO2TdDkX4qILGuotXdVjW1DNJH+LMAuLti24V1bWxXslm1dqGwOQID0uIGfgxtG
         KtDA==
X-Received: by 10.60.63.116 with SMTP id f20mr17823010oes.29.1381561593102;
        Sat, 12 Oct 2013 00:06:33 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm28621739obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:06:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561229-19947-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235946>

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
