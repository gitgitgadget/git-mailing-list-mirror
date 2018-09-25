Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D831F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeIZEoG (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45151 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeIZEoF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id j2-v6so160872edp.12
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mENKfG3WNsOOCO9AadipTWZI4tfehjaQLGBREV5AMlw=;
        b=d5XvBPNXEg/9dQn0vw3ha04OxGqk+oua+Tc0gi9bgySXE/6BqzadiyILv3IjFEwfQp
         NOjwgykZKhK3cELt650NCk4lIFOYjb0E4sfQDxJq89hH1apzivZjU/9mCWsjSK/02pff
         JMHM2pWHwg5/ItclBHALLDi/EVbAqgP5AW3Ce629AEq0y6oJ67EJNlo4DsmIxM8+E4KG
         JOHxoPxTj4NKge6GShKXC+D/TIJLiCYKasLcm1UmK25XX5ppxeRW377t/0R4/qlNxHMK
         lwHZSjYmXvyPSshuZ0vrf0+eBEQ6jg8W9DiVspMI7KfVNJsqbwmecW1E/v3VrjIF7oyl
         +1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mENKfG3WNsOOCO9AadipTWZI4tfehjaQLGBREV5AMlw=;
        b=Fo3b4z2qgQACnWINNt6BAag8A7QpkuzOevMAWkfzSPTwvvwOVrVMPHwhDASY9B7gFi
         udVK3+WxhsKQp+WNPLtCfsXfy8s5UaQGn3AXKsMaj5bDF/XrCCgWf8+pJOd8DgG1hDvg
         9IS/ATofP0nvLaC/U7cPLVtJq9ARIANUQrourMf5jrrI1xEEltGozVTncGRvwOrThnFX
         084Csl59fwPCgZOT2Pr6Rc6sCvqB66yYrgv1l1XywKHeXIxJtgZsRMPIhdquaywVLo95
         iJZRWoXm+GSdAmE7r5dqi+ujaZkslzYOzOKvfr5vWMfcKMzB3W7IyJPJ7NZCVlyMLZ/y
         NbNA==
X-Gm-Message-State: ABuFfoiJ+4pg5qP/v2fHUqeWZGmkpBBh1TPjYTf66M02gNHRhfydW53V
        uNoztn0TibMtMFWrHgYr5YOXRcaF
X-Google-Smtp-Source: ACcGV631zfpd/rFt35rXfJTZjo8mwslCC+Lr0ikNtHhORbcw9mjjudLH73+e4zfZ/m3EFLO9PCabjg==
X-Received: by 2002:a50:d2d4:: with SMTP id q20-v6mr2771678edg.212.1537914859630;
        Tue, 25 Sep 2018 15:34:19 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:18 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 01/21] sha1-name.c: add `get_oidf()` which acts like `get_oid()`
Date:   Wed, 26 Sep 2018 01:33:12 +0300
Message-Id: <b21cdeb1636b679d80ff554c48bc76516aed2cf6.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to `get_oid()`, `get_oidf()` has as parameters
a pointer to `object_id`, a printf format string and
additional arguments. This will help simplify the code
in subsequent commits.

Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 cache.h     |  1 +
 sha1-name.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/cache.h b/cache.h
index b1fd3d58ab..d93b2e25a5 100644
--- a/cache.h
+++ b/cache.h
@@ -1309,6 +1309,7 @@ struct object_context {
 	GET_OID_BLOB)
 
 extern int get_oid(const char *str, struct object_id *oid);
+extern int get_oidf(struct object_id *oid, const char *fmt, ...);
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index c9cc1318b7..261b960bbd 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1471,6 +1471,25 @@ int get_oid(const char *name, struct object_id *oid)
 	return get_oid_with_context(name, 0, oid, &unused);
 }
 
+/*
+ * This returns a non-zero value if the string (built using printf
+ * format and the given arguments) is not a valid object.
+ */
+int get_oidf(struct object_id *oid, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+	struct strbuf sb = STRBUF_INIT;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	ret = get_oid(sb.buf, oid);
+	strbuf_release(&sb);
+
+	return ret;
+}
 
 /*
  * Many callers know that the user meant to name a commit-ish by
-- 
2.19.0.rc0.23.g1fb9f40d88

