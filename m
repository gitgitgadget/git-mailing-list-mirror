Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1928720136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934371AbdBQOUC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:02 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33037 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934098AbdBQOT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:19:59 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so5070614pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lum3p8kIcPe8P9QzKuIbKp5dXSojp3nkn4YXtpuJWVQ=;
        b=iKH/cNFtO9ZWaRue0BjWjZSzCZEUx+Q+X+oDYvvbl/aSOhKY+JhwSmRUqf8LhYDLTk
         yaGol4Lkw61I7vm7ZYVbiUi8XndCQO3zPehRMs4lIz42W5xamFZa+egUCI3JSfjeXZWK
         0YElAUAfd6ob+9yMx5kmzi9e0WFdUwp5ii1yNWGsxFzXBjcCA8/6/wl92pihfGGuQXNM
         quQUnjyLSe61LWrYS+3hpQJGGoCsozj0fgPSphbSb68dp4i4n0ase7+07vtYtfwNK3y8
         KiJSxCKKmzUxS7VizvOS2igya3U835WTJlxwNnfUHHAq4HNlNzdpRG9UfNZApFr714RE
         EUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lum3p8kIcPe8P9QzKuIbKp5dXSojp3nkn4YXtpuJWVQ=;
        b=rmEvYkRDK3LD098tmoDHZCPb5u1v9R5EHkKN4/RJe5Baw5M2h/kUh/eWT1mi5MpaLc
         +1MTsZOcQvfiH4GktQ7q7a0qvkrx9zXbQK6zggRn0pOboNMlV6+3Wa3QL+PGmNOVzM22
         30Lvyl0smoY0y2KzJ0cKdY/WYlO4qh3a8tvFiucXKOpveyndAeWkM9fOp/VwdzYqXcVi
         0WIAhTHQIKwA5xiNRtqrbm9kNiksXaXm/tbI5+xx6Br/FebZqrT5OXdQlL4EANASoWQh
         KhW8+6NEjDDpdcI7SC4N1NL9tOzi0z4r3dy7nj8pP5LN2mXl1nQvM3K3QHnx3NI/WS4n
         26Ow==
X-Gm-Message-State: AMke39lx3ijPF+0KGFMueoMK7voLrfYUauI2HLhIHE5IxC6sXaRbXynVGtjHTvmH7bJFcQ==
X-Received: by 10.84.136.7 with SMTP id 7mr11765451plk.100.1487341198716;
        Fri, 17 Feb 2017 06:19:58 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id z4sm20126076pge.49.2017.02.17.06.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:19:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:19:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/15] refs: add refs_head_ref()
Date:   Fri, 17 Feb 2017 21:18:59 +0700
Message-Id: <20170217141908.18012-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 19 +++++++++----------
 refs.h |  1 +
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 06890db5d..26758b8cf 100644
--- a/refs.c
+++ b/refs.c
@@ -1139,27 +1139,26 @@ int rename_ref_available(const char *old_refname, const char *new_refname)
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
index 229a97f59..54c038e3c 100644
--- a/refs.h
+++ b/refs.h
@@ -573,5 +573,6 @@ int refs_read_ref_full(struct ref_store *refs,
 		       unsigned char *sha1, int *flags);
 int refs_read_ref(struct ref_store *refs,
 		  const char *refname, unsigned char *sha1);
+int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

