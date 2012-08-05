From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] merge-recursive: add hint for translators in handle_change_delete()
Date: Sun,  5 Aug 2012 19:55:32 +0200
Message-ID: <1344189332-27082-1-git-send-email-ralf.thielow@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Sun Aug 05 19:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy54Q-0002Gz-Bd
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 19:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab2HER4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 13:56:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43294 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2HER4A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 13:56:00 -0400
Received: by bkwj10 with SMTP id j10so769860bkw.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ZrVVi+vDsE+/7Lz0LwtIxjUdq0djgUg/HJzqTdv5YzQ=;
        b=r8sjbG2GybhRoPaB7xBsUGzjRISW9w43HkDtY+FPhbXJCvBKzIDFoSD2Hd4Yo965//
         Z6cmxyP9cK+5eHVpniKeVZ2O5qlA61g8idpiT+dcfoi0hxmE8WdXVI5QwYy6LFvYgI1F
         MyUp/aza19lmkiJ7Z7W657RlPqOmszaexFN1eCUweoNOVo2H9I+d9MdonnpFxGUVlpol
         4uOvEeLaRvxA/tlkZ16+7q05M0sGk4wx3hMQXt9uJEO16mMayEBykneuYeHeTUoXqXyB
         Xubwb2HRvFRA89rkU7sTROMNa5hFft9vV9aTAKfne25NJVWhPYw/hj2jWvt6W9KR/Bkr
         BnAQ==
Received: by 10.204.130.211 with SMTP id u19mr3053503bks.24.1344189358511;
        Sun, 05 Aug 2012 10:55:58 -0700 (PDT)
Received: from rath.fedora (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id 14sm6413328bkq.12.2012.08.05.10.55.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 10:55:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202909>

The outputs in handle_change_delete() contain a lot of placeholders.
This could end up in confusion to translators since two parts of them
are translated separately. Add a hint for translators that they can
easily understand it without study the code.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
This patch is based on a confusion on my own of the values of the
replacements. The first idea of Thomas was to remove the legos of
the static replacements. After thinking about and trying, it would
end up in a lot more of lines in this function mainly caused by the
different outputs. It might be nicer to just add a hint for translators
to describe the static replacements.

 merge-recursive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8903a73..7f661f2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1035,6 +1035,9 @@ static void handle_change_delete(struct merge_options *o,
 		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
 	} else if (!a_sha) {
 		if (!renamed) {
+			/* TRANSLATORS: The first %s will be "rename" or "modify",
+ 			   the fourth %s will be "renamed" or "modified". These replacements
+			   are translated separately. This counts for the next four messages. */
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree."),
 			       change, path, o->branch1, change_past,
-- 
1.7.12.rc1
