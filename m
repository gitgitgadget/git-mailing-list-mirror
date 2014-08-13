From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 21/23] refs.c: add methods for head_ref*
Date: Wed, 13 Aug 2014 13:15:05 -0700
Message-ID: <1407960907-18189-22-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexK-0008Ln-7s
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbaHMUP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:29 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:39248 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbaHMUPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:12 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so85306pab.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=06p8kyZBqPDAlV+5AiuGupOMEEVMJgTnrFAMrtk8Izc=;
        b=kF3Lw/+RZ2hVWEAG8H5DrMnjUj8IN9LiDSQO8/o/Eq7mcT2B/0M114jTeMXIzeW0ka
         wg2vz/w32aXxD/4Rm9qlTpAed2O5KyaGkuaP6sWTYQnHjS8+owI4KjwwsHB/bFIq6E4B
         m3n7lmWrrhUjkKwh2YWOZzOdD1d7b5jKyuoMXeblEPuDu8UlUpmM1CsrbwBp009pSj5F
         lkEhkvWDkNugEnPpHXvW/UA2SlkQE3/mf+7eTfAd+0KCdA1mhZDATT8+tYQYyWer0Hql
         ROtpGV9NMfcNKlhxYbBuKppPpfR12W/fpQC3JeFXr6M9o5lOtyhxLLlpuamMMQJrsFuw
         raWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=06p8kyZBqPDAlV+5AiuGupOMEEVMJgTnrFAMrtk8Izc=;
        b=Wk1xdpbe8wwPrC0n6Z7kBuXinKycf+0nLg/mQVQo3Wq5MjNhTaV5hpTD3OD4qSafWo
         ZnBFu/5wa3ggMlC8BOsE+T0f9V6DCVAIjEEVLMtnEIvxr5rZesFWCHepepNN9/7fjOGa
         AB3FfMIoIl+8EUQd11n4W/CZd+VzVbOomOK/0wFrlHTkrifjKH7Z0uZOexULi7DjPcaI
         eGgkTaJ9XeyF+lZYRPl58PsBNgzA7xG6tK4z4OZK/9+yGdDu6O0DFz5N4d8V0847WtlK
         b/HOxCUF2nVDZRUK8enhgw2aF7zTY4mSftiTjL4OXjPn8zM3NYTAZ/BjFjxOckfq17to
         pzXA==
X-Gm-Message-State: ALoCoQmEJ6A5WcpXBdASCz1Bhn2s2hlxCcl/wcvKY1bxdrh8eI3/ADvt9/6VJexEI+T/ulaWyUIL
X-Received: by 10.68.222.194 with SMTP id qo2mr3541014pbc.6.1407960911024;
        Wed, 13 Aug 2014 13:15:11 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si207802yhp.6.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D1A2C31C3D9;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B1713E0C3A; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255232>

Add methods for the head_ref* functions.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 10 ++++++++++
 refs.c        |  6 ++++--
 refs.h        |  6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index d9688e2..f19402b 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -918,3 +918,13 @@ int resolve_gitlink_ref(const char *path, const char *refname,
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
diff --git a/refs.c b/refs.c
index 9439809..7ad07f1 100644
--- a/refs.c
+++ b/refs.c
@@ -1600,12 +1600,12 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+static int files_head_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(NULL, fn, cb_data);
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
 }
@@ -3309,6 +3309,8 @@ struct ref_be refs_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_resolve_gitlink_ref,
+	files_head_ref,
+	files_head_ref_submodule,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index ab120c5..420e9b5 100644
--- a/refs.h
+++ b/refs.h
@@ -397,6 +397,10 @@ typedef int (*create_symref_fn)(const char *ref_target,
 typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
 				      unsigned char *sha1);
 
+typedef int (*head_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*head_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
+				     void *cb_data);
+
 struct ref_be {
 	transaction_begin_fn transaction_begin;
 	transaction_update_sha1_fn transaction_update_sha1;
@@ -417,6 +421,8 @@ struct ref_be {
 	peel_ref_fn peel_ref;
 	create_symref_fn create_symref;
 	resolve_gitlink_ref_fn resolve_gitlink_ref;
+	head_ref_fn head_ref;
+	head_ref_submodule_fn head_ref_submodule;
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.556.g3edca4c
