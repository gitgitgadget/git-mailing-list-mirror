From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH 1/6] source_filter: fix a memory leak
Date: Thu, 17 Feb 2011 22:11:04 +0100
Message-ID: <1297977069-21884-2-git-send-email-mailings@hupie.com>
References: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 22:11:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqB8P-0007Wi-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035Ab1BQVLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:11:16 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:57496 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755896Ab1BQVLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:11:11 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 75E6158C998;
	Thu, 17 Feb 2011 22:11:09 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167118>

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
