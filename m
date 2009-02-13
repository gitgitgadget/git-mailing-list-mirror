From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH] Remove redundant bit clears from diff_setup()
Date: Fri, 13 Feb 2009 09:33:34 -0800
Message-ID: <1234546414-4416-1-git-send-email-keith@cs.ucla.edu>
Cc: Pierre Habouzit <madcoder@madism.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 18:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY1wa-0004Ot-AD
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 18:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbZBMRds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 12:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbZBMRdr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 12:33:47 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:39786 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbZBMRdr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 12:33:47 -0500
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n1DHXY1C004445;
	Fri, 13 Feb 2009 09:33:34 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n1DHXY4o004444;
	Fri, 13 Feb 2009 09:33:34 -0800
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109763>

All bits already clear after memset(0).
---
 diff.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index be3859e..006aa01 100644
--- a/diff.c
+++ b/diff.c
@@ -2319,29 +2319,26 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 void diff_setup(struct diff_options *options)
 {
 	memset(options, 0, sizeof(*options));
 
 	options->file = stdout;
 
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
 	options->dirstat_percent = 3;
-	DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
 	options->context = 3;
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
 	if (diff_use_color_default > 0)
 		DIFF_OPT_SET(options, COLOR_DIFF);
-	else
-		DIFF_OPT_CLR(options, COLOR_DIFF);
 	options->detect_rename = diff_detect_rename_default;
 
 	if (!diff_mnemonic_prefix) {
 		options->a_prefix = "a/";
 		options->b_prefix = "b/";
 	}
 }
 
 int diff_setup_done(struct diff_options *options)
 {
-- 
1.6.1
