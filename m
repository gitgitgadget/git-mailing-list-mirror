From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 05/10] diffcore-pickaxe.c: set up funcname pattern
Date: Thu, 27 Mar 2014 14:50:51 -0400
Message-ID: <d284b297c4ac277f883b9468755d24adcd82830b.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFOx-0004xo-Ic
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218AbaC0Svc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43576 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757211AbaC0Sv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:29 -0400
X-AuditID: 1207440c-f79656d000003eba-6d-53347330ec4f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A5.32.16058.03374335; Thu, 27 Mar 2014 14:51:28 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TN013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:27 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsUixO6iqGtQbBJscLZB3mLuyiYmiy/nbrFZ
	dF3pZrI4s7Wf2eJHSw+zA6vH3/cfmDyazhxl9njWu4fR4/MmOY/bz7axBLBGcdmkpOZklqUW
	6dslcGVcP/qUuWAjV8XTq2vYGhhvcnQxcnJICJhIrPr/gR3CFpO4cG89WxcjF4eQwGVGicOz
	b7CCJIQEVjJJ/FrlAWKzCThLbPq1nwnEFhEQl3h7fCY7SAOzwEJGibd7JjODJIQFnCRu7tjH
	BmKzCKhK3Fj1A2wDr0CUxMqeXiaIbQYSn56dAavnFHCQmDx/I5DNAbTMXuLjUluIcLTE662L
	2SBuiAKyT7JMYORfwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyMkBHl2
	MH5bJ3OIUYCDUYmH18HCJFiINbGsuDL3EKMEB7OSCO/cAqAQb0piZVVqUX58UWlOavEhRmkO
	FiVxXtUl6n5CAumJJanZqakFqUUwWSYOTqkGxlqJfrY4zZX2TQ1LVt64NaVjv87d/vBaXu1k
	rdcBi+9uP/Utp7+saFaPj5vs1pzXimu9JKe9sD95bVXJo5VVpa/nCgdN+HzFIWXz1fVfXrev
	f7/Ds33lmaqtqnPNy8NmX459Hbwj0DBbOPr1npv/0r7Fvrs7/ZfM0oo7K9WSN19eXvWxzcHj
	1gIlluKMREMt5qLiRACzfwNSPQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245313>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

We use userdiff_funcname to make the filetype-dependent function name
pattern available to pickaxe functions.

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 diffcore-pickaxe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 7e65095..103fe6c 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -7,10 +7,12 @@
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
+#include "userdiff.h"
 
 struct fn_options {
 	regex_t *regex;
 	kwset_t kws;
+	const struct userdiff_funcname *funcname_pattern;
 };
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
@@ -224,6 +226,13 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	if (textconv_one == textconv_two && diff_unmodified_pair(p))
 		return 0;
 
+	const struct userdiff_funcname *funcname_pattern;
+	funcname_pattern = diff_funcname_pattern(p->one);
+	if (!funcname_pattern)
+		funcname_pattern = diff_funcname_pattern(p->two);
+
+	fno->funcname_pattern = funcname_pattern;
+
 	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
 
-- 
1.7.12.4 (Apple Git-37)
