From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 1/8] branch: trivial cleanup
Date: Sat, 12 Oct 2013 02:05:57 -0500
Message-ID: <1381561561-20459-5-git-send-email-felipe.contreras@gmail.com>
References: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtPe-0006XV-QN
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3JLHOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:54 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:41627 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab3JLHMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:12 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so3457775obc.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHVgHFy7LH/REBJau99EIZSp3BfNJlbBO5ebYIga7eI=;
        b=tYuht1lr6uYgPT/HaLE5TxtoLeTkeW3pUKDB82wwx32JKuuKR6hCF7ZD2zBJYzFexN
         rNxIx0uXGLUuQh7uLdv3PunUOYA+TPcMGjompXTvI4V/Mvhlv3Dnq+AVyPeTdzQyMPCf
         I/JnOxl2AEgHusXJ06eZmtz8AZk0AYJT2Dvc9oKpIeUeI54Mv1xJH3TEN2OoOA/8zP46
         MSrs/ksvkTUdpLB+CUvcAH8Q4bKrK6dXZJH2VijU/kFrYL9VXsQRM94LGZupRvurKecj
         J8bespI6mCmUZQUsZJLTvYRdckGqdF86L7H9rAN2lXcBCVvjIURZ1Mr/mv+UkQa56iJK
         a6JA==
X-Received: by 10.182.49.166 with SMTP id v6mr17526158obn.13.1381561932551;
        Sat, 12 Oct 2013 00:12:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d8sm101377961oeu.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236036>

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
