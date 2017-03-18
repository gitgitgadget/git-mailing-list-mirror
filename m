Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C8720323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbdCRKMk (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:12:40 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35191 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdCRKMg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:12:36 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so13141922pge.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P9n2Q27ZrkkZ/yI1BTOhL6+4B9UVwVcWnIwZT6b/9Hk=;
        b=TCI/FkozHanmlnnV1TbuYPKRMm/T8SYsr+Yv5kNzx/ZqDS1yWxEIJM7olZ9BsbFPsI
         oCx5a+u0bWcssqJbSn5UMI6Cu0PY4AEG6Cu+OCcNlqYx8e/g4aLJ3vX76FKYBQfieCob
         V/qy0O/Bh/X+OG6EMgdgXsKYMQd3F3ObRh70zzzsu2/XB6xkrb5BKgS3ZMeT2mEGjeAM
         clWR0ja8iwciFf6tnqU+Rr9JgimUcvUJZobojNikX2BwS4uTEaJk4MTAJv1F/aPS9mlg
         2Yp80YIRh2fd5/D1ObVlZdiXZLTb9IzA/4niN+QkWdQMFSn6xY+3hlEKIzDPuBJ65t3P
         AqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P9n2Q27ZrkkZ/yI1BTOhL6+4B9UVwVcWnIwZT6b/9Hk=;
        b=P253tSnGFxMtKrDR8mvjwAXUWpD5lxdFFyyj8DQJotPuLFWYqOz3BQK7FLh2OsqFqQ
         0fZ8ztCiePq9jNw9FEhv4l0evioOU6B3HSvPa8Lgj7ZwO94YzwOouRA3hMlxCQgCmNBp
         E98Vv4Q4G8h+3/0vjzqzR4/1DaEc0JktN7GjpTBo5p8gjXZTQJk9pKj9Gj+8yU9irqnP
         KFSmxQInNB9w0pJvdMEgSksRsxMuoAGU/MNGk9zU5QNoHHs0rhc3iQ110EsaVSSyvyCk
         eG8xNLA6Hr1fRIlaKIr6EjDzdCKg93UplHchfJW2INQVDtnBmvwbTIgsLtbTz52SPj+O
         Ca0w==
X-Gm-Message-State: AFeK/H1/1WQwZqdQjPmmEIfGzR21FGx1ghq5zc9lZJXR+YA2PjdtVudjWlFnpXlH0Ge+vA==
X-Received: by 10.84.143.195 with SMTP id 61mr26308206plz.46.1489831955405;
        Sat, 18 Mar 2017 03:12:35 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id 20sm7466748pgg.52.2017.03.18.03.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 06/12] refs: add refs_head_ref()
Date:   Sat, 18 Mar 2017 17:11:47 +0700
Message-Id: <20170318101153.6901-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 refs.c | 19 +++++++++----------
 refs.h |  2 ++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index a38149d84a..5fc47ff5f0 100644
--- a/refs.c
+++ b/refs.c
@@ -1208,27 +1208,26 @@ int refs_rename_ref_available(struct ref_store *refs,
 	return ok;
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
 
-	if (submodule) {
-		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
-			return fn("HEAD", &oid, 0, cb_data);
-
-		return 0;
-	}
-
-	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
+				oid.hash, &flag))
 		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
 }
 
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return refs_head_ref(get_submodule_ref_store(submodule), fn, cb_data);
+}
+
 int head_ref(each_ref_fn fn, void *cb_data)
 {
-	return head_ref_submodule(NULL, fn, cb_data);
+	return refs_head_ref(get_main_ref_store(), fn, cb_data);
 }
 
 /*
diff --git a/refs.h b/refs.h
index 447381d378..0572473ef7 100644
--- a/refs.h
+++ b/refs.h
@@ -233,6 +233,8 @@ typedef int each_ref_fn(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration. Returned references are sorted.
  */
+int refs_head_ref(struct ref_store *refs,
+		  each_ref_fn fn, void *cb_data);
 int refs_for_each_ref(struct ref_store *refs,
 		      each_ref_fn fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-- 
2.11.0.157.gd943d85

