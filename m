From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/33] refs: document do_for_each_ref() and do_one_ref()
Date: Sun, 14 Apr 2013 14:54:18 +0200
Message-ID: <1365944088-10588-4-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 15:02:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMZg-0003gC-99
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 15:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3DNNCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 09:02:23 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:59312 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751402Ab3DNNCW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 09:02:22 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2013 09:02:22 EDT
X-AuditID: 1207440d-b7fd06d000000905-1c-516aa738793a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 53.1F.02309.837AA615; Sun, 14 Apr 2013 08:55:20 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk0007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:19 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqGuxPCvQ4NhMNYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M5o+sFZ8ImrYvWdGSwNjE84uhg5OSQETCT6TmxhhrDFJC7cW8/WxcjFISRwmVHix94e
	VgjnLJNE960OJpAqNgFdiUU9zUA2B4eIQLbE7rXyIGFmAQeJzZ8bGUFsYQEPiStftoGVswio
	SpyYvJkdxOYVcJE4tek2E8QyBYnj27eB1XMKuEpMf34MrEYIqGbW5tmsExh5FzAyrGKUS8wp
	zdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICSjeHYz/18kcYhTgYFTi4X3BmBUoxJpY
	VlyZe4hRkoNJSZS3ZxlQiC8pP6UyI7E4I76oNCe1+BCjBAezkgivYytQjjclsbIqtSgfJiXN
	waIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwft6KVCjYFFqempFWmZOCUKaiYMTRHCBbOAB
	2vAWpJC3uCAxtzgzHaLoFKOilDhvCshZAiCJjNI8uAGw2H/FKA70jzDvU5B2HmDagOt+BTSY
	CWiwz950kMEliQgpqQbGiRM2uPJpSkWfuDfxqMzMBM/XsmW6DzfN/bJbWVvcICuz9bLXWiX7
	X2E7Js84dUJ/2us99sXbLp6cfPTaM64TnmeDzb1jjrnc5ThwtD181soFM91WpbRYrVzvkFi8
	+nxmlILjX9GNnYt//c3hyma4cGmCIPdiEyOVd3sivLaY7lH4L/L60Y8mDyWW4oxE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221129>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1df1ccd..f503ec4 100644
--- a/refs.c
+++ b/refs.c
@@ -525,10 +525,14 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-#define DO_FOR_EACH_INCLUDE_BROKEN 01
+/* Include broken references in a do_for_each_ref*() iteration: */
+#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
 static struct ref_entry *current_ref;
 
+/*
+ * Handle one reference in a do_for_each_ref*()-style iteration.
+ */
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		      int flags, void *cb_data, struct ref_entry *entry)
 {
@@ -1338,6 +1342,13 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
+/*
+ * Call fn for each reference in the specified submodule for which the
+ * refname begins with base.  If trim is non-zero, then trim that many
+ * characters off the beginning of each refname before passing the
+ * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
+ * broken references in the iteration.
+ */
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
-- 
1.8.2.1
