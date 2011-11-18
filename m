From: Zheng Liu <gnehzuil.liu@gmail.com>
Subject: [PATCH] Use macro define to replace magic character
Date: Fri, 18 Nov 2011 09:43:06 +0800
Message-ID: <1321580586-19247-1-git-send-email-wenqing.lz@taobao.com>
Cc: Zheng Liu <wenqing.lz@taobao.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 02:41:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRDSS-0006dV-NA
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 02:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab1KRBl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 20:41:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38391 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab1KRBlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 20:41:24 -0500
Received: by iage36 with SMTP id e36so2974339iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 17:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=VzkzuaHEAXlt530p1/hD2uD6apa1lpgaFIWJ1fkuEYg=;
        b=qQM/YCmRIXt18aSx4zNXgWWX0rMLFLJo4BCTpaA/UKrTtFDE1dedwf9DcA3tZaoTzL
         3a/MIlG5vOfFipdqcWXcTqwK/gDtBPJB7FicnX0Xuv2jI3FCSjElmMBvxN70lU6thQw2
         xfUlILLFGsZ+YPbQ5AF/yZxQ9BH+B/QVridMQ=
Received: by 10.50.169.38 with SMTP id ab6mr1036939igc.26.1321580484382;
        Thu, 17 Nov 2011 17:41:24 -0800 (PST)
Received: from localhost.localdomain ([182.92.247.2])
        by mx.google.com with ESMTPS id ft1sm24163444igc.3.2011.11.17.17.41.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 17:41:23 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185621>

We should use macro define rather than magic character to make more readable

Signed-off-by: Zheng Liu <wenqing.lz@taobao.com>
---
 merge-recursive.c |    2 +-
 tree-diff.c       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cc664c3..96457bc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -503,7 +503,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
-		if (pair->status != 'R') {
+		if (pair->status != DIFF_STATUS_RENAMED) {
 			diff_free_filepair(pair);
 			continue;
 		}
diff --git a/tree-diff.c b/tree-diff.c
index b3cc2e4..d52c440 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -225,7 +225,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 		 * diff_queued_diff, we will also use that as the path in
 		 * the future!
 		 */
-		if ((p->status == 'R' || p->status == 'C') &&
+		if ((p->status == DIFF_STATUS_RENAMED || p->status == DIFF_STATUS_COPIED) &&
 		    !strcmp(p->two->path, opt->pathspec.raw[0])) {
 			/* Switch the file-pairs around */
 			q->queue[i] = choice;
-- 
1.7.5.4
