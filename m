From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 1/3] cache: modify for "cat-file --literally -t"
Date: Thu,  5 Mar 2015 23:48:19 +0530
Message-ID: <1425579499-18780-1-git-send-email-karthik.188@gmail.com>
References: <54F89D90.6090505@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 19:18:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTaMD-0003w5-LO
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 19:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbbCESSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 13:18:45 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:46016 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbbCESSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 13:18:44 -0500
Received: by padbj1 with SMTP id bj1so10946370pad.12
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 10:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Aup98FKT1XovolQNdKqvl89nSseIdt/30S0HZcNsSI=;
        b=OJ7Y/5aq93SS8wlIn1OCUK69XsA8+d40axbCbc4VCfPH1h5ZG6cbF3ReIvL/IYS7d3
         SDJKBdidhpGJT9+p0Za5BBRlVckD7Ep3AvA3wT5/McZPH/JFKJmSWjAmNiK4Cm7GveCu
         K215ppFPKD7swxFdigEgIJe/7uCj35Yk+1Xg4tTs1GOkJuStPhC/uQoAZyDiw72b9vpb
         kfwFJvlaKsNY9Twlri4SVzIK1R+n1vkGEtYiWwm9HVKLt57+3YAop14I1Qz0RGBEtPzx
         CosNvHq8XNknBUbB8qA+LWbm0RFaZz1yN9o2FBA1VTd+0hBxDJ/JZhI5J/foh5MSwewe
         Rfkg==
X-Received: by 10.70.96.145 with SMTP id ds17mr17771630pdb.153.1425579523899;
        Thu, 05 Mar 2015 10:18:43 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id x11sm2576293pbt.65.2015.03.05.10.18.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2015 10:18:42 -0800 (PST)
X-Mailer: git-send-email 2.3.1.167.g7f4ba4b.dirty
In-Reply-To: <54F89D90.6090505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264854>

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
2.3.1.167.g7f4ba4b.dirty
