From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/3] cache: modify for "cat-file --literally -t"
Date: Tue,  3 Mar 2015 15:41:54 +0530
Message-ID: <1425377514-25272-1-git-send-email-karthik.188@gmail.com>
References: <54F5888B.7040400@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 11:12:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSjoF-0004ii-AU
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 11:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbbCCKMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 05:12:09 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:41251 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbbCCKMI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 05:12:08 -0500
Received: by pdno5 with SMTP id o5so47294996pdn.8
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/FgUntfoO82VLfa2jJ/A/kT10D5dLf30nRVwbAaEeM=;
        b=lrfUo3CxohXyd2udZIPPlphyy1DN9DVxHR9dQL257pEtDvHooPV68jFXzvFzyddlYy
         64K0C5phpcnlMNwvQ2UcKMUi/FK5aS7RRVsApuIJY2FgeIjaZJFkeSJI9q/62h6ywgFr
         kJ9F+Mnm0SDUCg23wWfhzM0OzrYFpKvCFolo2XxJPY3yxa5j04f6teosyaQWnCOhz1Ky
         IF5EcSGDgr9Ah1M4znCidgiExtbQXVIR7cQOyB2wuXY3bYUzmhCEnZe4nt55yHipJsI4
         lWbyPPd3Qmcs7cgCCQcNtWQgty/AvwuPegoj6K4epQNCloHFXZuliFWXGxN8IaXNT3yS
         uNbg==
X-Received: by 10.68.130.233 with SMTP id oh9mr48002010pbb.61.1425377527496;
        Tue, 03 Mar 2015 02:12:07 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id z2sm405931pde.94.2015.03.03.02.12.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 02:12:06 -0800 (PST)
X-Mailer: git-send-email 2.3.1.169.ga243085.dirty
In-Reply-To: <54F5888B.7040400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264643>

Add a "struct strbuf *typename" to object_info to hold the
typename when the literally option is used. Add a flag to
notify functions when literally is used.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 cache.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cache.h b/cache.h
index 4d02efc..949ef4c 100644
--- a/cache.h
+++ b/cache.h
@@ -830,6 +830,7 @@ extern int is_ntfs_dotgit(const char *name);
 
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
+#define LOOKUP_LITERALLY 2
 extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
 static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
 {
@@ -1296,6 +1297,7 @@ struct object_info {
 	unsigned long *sizep;
 	unsigned long *disk_sizep;
 	unsigned char *delta_base_sha1;
+	struct strbuf *typename;
 
 	/* Response */
 	enum {
-- 
2.3.1.169.ga243085.dirty
