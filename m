From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 06/11] replace: bypass the type check if -f option is used
Date: Sat, 31 Aug 2013 21:12:09 +0200
Message-ID: <20130831191215.26699.25627.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqcB-00015H-Vs
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab3HaTNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:40 -0400
Received: from [194.158.98.15] ([194.158.98.15]:48172 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752775Ab3HaTNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id EB87E6B;
	Sat, 31 Aug 2013 21:12:53 +0200 (CEST)
X-git-sha1: a687c5f54eede130ee5a413565cf68dfb1f0626a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233538>

If -f option, which means '--force', is used, we can allow an object
to be replaced with one of a different type, as the user should know
what (s)he is doing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 9a94769..95736d9 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -103,7 +103,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
-	if (obj_type != repl_type)
+	if (!force && obj_type != repl_type)
 		die("Objects must be of the same type.\n"
 		    "'%s' points to a replaced object of type '%s'\n"
 		    "while '%s' points to a replacement object of type '%s'.",
-- 
1.8.4.rc1.31.g530f5ce.dirty
