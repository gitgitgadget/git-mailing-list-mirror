From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/24] refs.c: don't expose the internal struct ref_lock in the header file
Date: Fri, 12 Dec 2014 09:57:02 +0100
Message-ID: <1418374623-5566-24-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:57:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM2s-0004eU-Nl
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965410AbaLLI5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:57:50 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59932 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965336AbaLLI5n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:43 -0500
X-AuditID: 12074414-f797f6d000004084-02-548aae070500
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 64.13.16516.70EAA845; Fri, 12 Dec 2014 03:57:43 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nX023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:42 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqMu+rivEYMFDTouuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xoqLu9gKNnFWfH/UwNjAuIu9i5GTQ0LAROL1qplMELaYxIV769m6GLk4hAQu
	M0rMePyPFSQhJHCMSeLcmXgQm01AV2JRTzNYg4iAmsTEtkMsIDazwAlGidkNISC2sECcxI7r
	U8HiLAKqElefLgSzeQVcJI6sfQzUywG0TE5i6zpvkDAnUPhiyxMWiFXOEltXdLJOYORdwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMksER2MB45KXeIUYCDUYmH90Vq
	V4gQa2JZcWXuIUZJDiYlUd7vk4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHj/RgHleFMSK6tS
	i/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeI+uAWoULEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB8VFfDEwMkBSPEB72daC7C0uSMwFikK0nmJUlBLnPQ0yVwAkkVGa
	BzcWli5eMYoDfSnMawjSzgNMNXDdr4AGMwENXr6lA2RwSSJCSqqBUfl3vEyT4qe8eUsdxLb+
	a7nxpkGFue7EAa6VRzc/vWc/65DNdz0t1qtL2m0/qCuaLLC0PPN2G58O6+prL5i/FWfdvh8+
	s+12c/Xla4UG3fKZpeqCSntuf27e3Kyp9uD08fzUnum35bndg99FN1sd+TZL5LYx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261331>

From: Stefan Beller <sbeller@google.com>

Now the struct ref_lock is used completely internally, so let's
remove it from the header file.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 +++++++++
 refs.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 166c0f6..582a051 100644
--- a/refs.c
+++ b/refs.c
@@ -6,6 +6,15 @@
 #include "dir.h"
 #include "string-list.h"
 
+struct ref_lock {
+	char *ref_name;
+	char *orig_ref_name;
+	struct lock_file *lk;
+	unsigned char old_sha1[20];
+	int lock_fd;
+	int force_write;
+};
+
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index 28e7834..fc88ba6 100644
--- a/refs.h
+++ b/refs.h
@@ -1,15 +1,6 @@
 #ifndef REFS_H
 #define REFS_H
 
-struct ref_lock {
-	char *ref_name;
-	char *orig_ref_name;
-	struct lock_file *lk;
-	unsigned char old_sha1[20];
-	int lock_fd;
-	int force_write;
-};
-
 /*
  * A ref_transaction represents a collection of ref updates
  * that should succeed or fail together.
-- 
2.1.3
