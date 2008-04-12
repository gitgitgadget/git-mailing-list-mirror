From: sgala@hisitech.com
Subject: [PATCH] make --color-words separate word on ispunct
Date: Sat, 12 Apr 2008 12:33:41 +0200
Message-ID: <1207996421-29651-1-git-send-email-sgala@apache.org>
Cc: Santiago Gala <sgala@apache.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 13:31:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkdxd-0000kw-JF
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 13:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757460AbYDLLbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757410AbYDLLbN
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 07:31:13 -0400
Received: from 233.Red-81-33-31.staticIP.rima-tde.net ([81.33.31.233]:1719
	"EHLO mail.hisitech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756899AbYDLLbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 07:31:12 -0400
Received: by mail.hisitech.com (Postfix, from userid 65534)
	id 323F415CD87; Sat, 12 Apr 2008 13:02:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on
	webserver2.intranet.hisitech.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_20,
	NO_REAL_NAME autolearn=ham version=3.1.9
Received: from hisitech.com (unknown [172.27.70.188])
	by mail.hisitech.com (Postfix) with SMTP id A602715CE0C;
	Sat, 12 Apr 2008 12:33:42 +0200 (CEST)
Received: by hisitech.com (sSMTP sendmail emulation); Sat, 12 Apr 2008 12:33:41 +0200
X-Mailer: git-send-email 1.5.5.44.gdfa65.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79347>

Note that this may actually be harmful when trying to spot punctuation
changes, but for this use case I don't think color-words is helping
now either.

Signed-off-by: Santiago Gala <sgala@apache.org>
---
 diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 8022e67..d301fcc 100644
--- a/diff.c
+++ b/diff.c
@@ -448,7 +448,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	minus.ptr = xmalloc(minus.size);
 	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
 	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
+		if (isspace(minus.ptr[i]) || ispunct(minus.ptr[i]))
 			minus.ptr[i] = '\n';
 	diff_words->minus.current = 0;
 
@@ -456,7 +456,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	plus.ptr = xmalloc(plus.size);
 	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
 	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
+		if (isspace(plus.ptr[i]) || ispunct(plus.ptr[i]))
 			plus.ptr[i] = '\n';
 	diff_words->plus.current = 0;
 
-- 
1.5.5.44.gdfa65.dirty
