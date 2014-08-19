From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 22/23] refs-be-files.c: add methods for head_ref*
Date: Tue, 19 Aug 2014 09:30:46 -0700
Message-ID: <1408465847-30384-23-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKd-0002zZ-Bh
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbaHSQbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:49 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:55181 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so1439974oif.4
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=beHXJHl04tAPB1h48aPznJft1Z/mjoNREjCEaJtFNas=;
        b=o2ICwdE2+oZrbQLNePINVp52xQ6DJcq9+cozKbnw7c6i+oQbVcnMQ8k5/srcHlZzSM
         IFniX/XaVzPDyHXukWN3kqqVczJkAF0k0g0nB9TmJTe/9X0e3Kyj6tr1ohsoMShxbNdr
         JptL0J3m5mzLEJtw+mrHpYgzywvNwOj3Q5sQWnIXSCaEwZXU7bTTpcvFHM3k0W8ajraT
         L1xLBLdQUnZqZOFtaqK0aAzut8/TWq7LOAf3Wz7l0MgdVHbv7xAbQEmk18EXQJfsClWW
         MXmj0VTsBbWITRLfow+3OIAztufCeurkpg4KDZ0exWqyHIkZ2iFsPboebtOtj/tTaiXr
         fTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=beHXJHl04tAPB1h48aPznJft1Z/mjoNREjCEaJtFNas=;
        b=ICDQQFlhmgGNSf7WlGTqIHXT9xlK7vqIL65Meh2en6esIEpRoVYwe02ntXcsLs4C2y
         mx4SJRg3IujUEi7dJnvU6aF7j70k9BzR/o2ZEsqqJJkddddfiuWNqJX25cZnD3DvT0qn
         WeRlJynYKjBBgME1ZiOEiIRUYAnDYRt93LjdV3IQAp8K/yCBljg88PSDqSHskcaOOgjS
         jsW8mKOj0yDHPqBKUpnFel12Rm1UoLDwny5G+W/ZMxFht7nVL/J/YvbCflqUr7/mVOlx
         M2WflGwT+P2hN9uNkTNzXl+/WLTIvub6cISC1MOkA99pip0eNm2Loc/837lwHJycG8Ni
         rdSw==
X-Gm-Message-State: ALoCoQlmqlr3b5NMvc3SGH4qLRW3kXwPDfL7dgT4fNIiWM4I8H1zeAeBVjAyaV+tHTZC+JJ6RWos
X-Received: by 10.182.130.168 with SMTP id of8mr23445080obb.27.1408465853696;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h42si332683yhj.3.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 875B531C53B;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5883CE1CF6; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255495>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c |  7 +++++--
 refs.c          | 10 ++++++++++
 refs.h          |  5 +++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index b09f0fc..910663b 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1603,12 +1603,13 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+static int files_head_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(NULL, fn, cb_data);
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_head_ref_submodule(const char *submodule, each_ref_fn fn,
+				    void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
 }
@@ -3315,6 +3316,8 @@ struct ref_be refs_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_resolve_gitlink_ref,
+	files_head_ref,
+	files_head_ref_submodule,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.c b/refs.c
index 60b6241..841d905 100644
--- a/refs.c
+++ b/refs.c
@@ -921,3 +921,13 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return refs->resolve_gitlink_ref(path, refname, sha1);
 }
+
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs->head_ref(fn, cb_data);
+}
+
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return refs->head_ref_submodule(submodule, fn, cb_data);
+}
diff --git a/refs.h b/refs.h
index 5257437..92f8f44 100644
--- a/refs.h
+++ b/refs.h
@@ -394,6 +394,9 @@ typedef int (*create_symref_fn)(const char *ref_target,
 				const char *logmsg);
 typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
 				      unsigned char *sha1);
+typedef int (*head_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*head_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
+				     void *cb_data);
 
 struct ref_be {
 	transaction_begin_fn transaction_begin;
@@ -415,6 +418,8 @@ struct ref_be {
 	peel_ref_fn peel_ref;
 	create_symref_fn create_symref;
 	resolve_gitlink_ref_fn resolve_gitlink_ref;
+	head_ref_fn head_ref;
+	head_ref_submodule_fn head_ref_submodule;
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.552.g1af257a
