From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Separate the raw diff and patch with a newline
Date: Tue, 11 Apr 2006 13:30:46 +0200
Message-ID: <20060411113045.12117.10948.stgit@machine.or.cz>
References: <7vr7456jb4.fsf@assigned-by-dhcp.cox.net>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 11 13:31:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTH6B-0004u3-SS
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 13:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWDKLay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 07:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWDKLah
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 07:30:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48831 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750767AbWDKLaf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 07:30:35 -0400
Received: (qmail 12133 invoked from network); 11 Apr 2006 13:30:46 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 11 Apr 2006 13:30:46 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7456jb4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18610>

More friendly for human reading I believe, and possibly friendlier to some
parsers (although only by an epsilon).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 combine-diff.c |    1 +
 diff.c         |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 748dc30..0e25788 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -867,6 +867,7 @@ const char *diff_tree_combined_merge(con
 					header = NULL;
 			}
 			opt->output_format = DIFF_FORMAT_PATCH;
+			putchar(opt->line_termination);
 		}
 		for (p = paths; p; p = p->next) {
 			if (show_combined_diff(p, num_parent, dense,
diff --git a/diff.c b/diff.c
index 00c79aa..86e4251 100644
--- a/diff.c
+++ b/diff.c
@@ -1322,6 +1322,7 @@ void diff_flush(struct diff_options *opt
 			struct diff_filepair *p = q->queue[i];
 			flush_one_pair(p, DIFF_FORMAT_RAW, options);
 		}
+		putchar(options->line_termination);
 	}
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
