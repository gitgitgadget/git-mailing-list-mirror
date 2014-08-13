From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 17/23] refs-common.c: move head_ref_namespaced to the common file
Date: Wed, 13 Aug 2014 13:15:01 -0700
Message-ID: <1407960907-18189-18-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexl-00009i-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbaHMUPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:42 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:49400 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-vc0-f202.google.com with SMTP id hq11so35400vcb.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PyJl8CSw/j5i4vh1v0BhT6XkfzfGV2kbYGpc7fPxw8g=;
        b=bSFzUiAQvx/J0Gb5H4DV88/bIpSK4HiM/Z0jRGE4eqP7nzeS3ZyQFp42eOplX2owUV
         fVwArxXaC3WcGboKH6sSdGyxbvG0daw5AWp7r56uCwHGOYwwAif4BiW0pV7O3VFL/cZ4
         NfbtsW6QILiJ3fne6XowP/pcdIKVCbIPrwA+3cgEhoV6uUJQmUaFcUSdLY2E/P9XTVmj
         tOtqaolBy8+nZQuhVG6ab0Yw4Ne10jVx3+9ZZ3uT223Vwc2WVUOjG+ATK6vMndqyCaM3
         iXHrlTPfHYCbMPl84IPJ5VpGZcGoRYZN9o2mINnvAL0f7hwQUjsRJorIFp5wMuFTujH5
         No4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PyJl8CSw/j5i4vh1v0BhT6XkfzfGV2kbYGpc7fPxw8g=;
        b=OQvR53hdVORYzLoT8C+ns+udcoDf7LOxpzZCxsNbaK/Pnt9uqYkP9XG1JJ0XnrhFp3
         rr9x84hQOtuxOvKfMe412SleJohmPALMfqT1ExV5SvKO5PGo+5l7dDY6q+XUEU1B6DFR
         eA0cIjiMKG+iWh9R90WnRp/ge9nICnUDRZhxjkRlweNx+RUf7zhwnxf4QT/DOUgbigj+
         EjGCAGXRA4oTdf2dt15GFNT8DPR3fhSl9iMXZUo7C11DZ6jO5JaB5atrFN+ovSfI/HwO
         P8TqyAOZ/MAQaUe4kVxf5wQFPJ0DJdQSqgIfBkx2QoSWp4ZfKEY582SS/v/5yDuquLCc
         UhdA==
X-Gm-Message-State: ALoCoQl39osexZcO7u6JWjg4bGfkY8wY4z7Y6SFh2z+3qxERGpf7mWEMCv24ZhR+t/diGA9Oj6iU
X-Received: by 10.236.230.106 with SMTP id i100mr189545yhq.27.1407960910843;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h42si209646yhj.3.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AFFB231C2D5;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8E576E107B; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255242>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 15 +++++++++++++++
 refs.c        | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 3b20db3..aafc4c8 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -570,6 +570,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+	unsigned char sha1[20];
+	int flag;
+
+	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
+	if (!read_ref_full(buf.buf, sha1, RESOLVE_REF_READING, &flag))
+		ret = fn(buf.buf, sha1, flag, cb_data);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
 int read_ref_full(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
 {
 	if (resolve_ref_unsafe(refname, sha1, flags, ref_flag))
diff --git a/refs.c b/refs.c
index 9aa88ef..e58a7e1 100644
--- a/refs.c
+++ b/refs.c
@@ -1635,21 +1635,6 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = 0;
-	unsigned char sha1[20];
-	int flag;
-
-	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, sha1, RESOLVE_REF_READING, &flag))
-		ret = fn(buf.buf, sha1, flag, cb_data);
-	strbuf_release(&buf);
-
-	return ret;
-}
-
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
2.0.1.556.g3edca4c
