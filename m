From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH v2 2/6] new_filter: correctly initialise all arguments for a new filter
Date: Fri,  4 Mar 2011 01:31:31 +0100
Message-ID: <1299198695-23215-3-git-send-email-mailings@hupie.com>
References: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 01:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvIwG-0005if-Ny
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 01:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759174Ab1CDAbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 19:31:44 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:62943 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759135Ab1CDAbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 19:31:43 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 8B05058C9C2;
	Fri,  4 Mar 2011 01:31:36 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299198695-23215-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168420>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 cgit.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/cgit.c b/cgit.c
index 412fbf0..4440feb 100644
--- a/cgit.c
+++ b/cgit.c
@@ -28,6 +28,7 @@ void add_mimetype(const char *name, const char *value)
 
 struct cgit_filter *new_filter(const char *cmd, int extra_args)
 {
+	int i = 0;
 	struct cgit_filter *f;
 
 	if (!cmd || !cmd[0])
@@ -36,8 +37,10 @@ struct cgit_filter *new_filter(const char *cmd, int extra_args)
 	f = xmalloc(sizeof(struct cgit_filter));
 	f->cmd = xstrdup(cmd);
 	f->argv = xmalloc((2 + extra_args) * sizeof(char *));
-	f->argv[0] = f->cmd;
-	f->argv[1] = NULL;
+	f->argv[i++] = f->cmd;
+	while (i < (2 + extra_args)) {
+	  f->argv[i++] = NULL;
+	}
 	return f;
 }
 
-- 
1.7.4
