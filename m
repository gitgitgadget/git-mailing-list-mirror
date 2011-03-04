From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH v2 1/6] source_filter: fix a memory leak
Date: Fri,  4 Mar 2011 01:31:30 +0100
Message-ID: <1299198695-23215-2-git-send-email-mailings@hupie.com>
References: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 01:31:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvIvv-0005Zb-9F
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 01:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759176Ab1CDAbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 19:31:45 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:62936 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759156Ab1CDAbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 19:31:43 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 704CF58C9C0;
	Fri,  4 Mar 2011 01:31:36 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168418>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 ui-tree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/ui-tree.c b/ui-tree.c
index 0b1b531..442b6be 100644
--- a/ui-tree.c
+++ b/ui-tree.c
@@ -48,6 +48,8 @@ static void print_text_buffer(const char *name, char *buf, unsigned long size)
 		cgit_open_filter(ctx.repo->source_filter);
 		html_raw(buf, size);
 		cgit_close_filter(ctx.repo->source_filter);
+		free(ctx.repo->source_filter->argv[1]);
+		ctx.repo->source_filter->argv[1] = NULL;
 		html("</code></pre></td></tr></table>\n");
 		return;
 	}
-- 
1.7.4
