Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B80E1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754909AbeFYQmp (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:42:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39343 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754385AbeFYQmo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:42:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id b8-v6so8927783wro.6
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kZKFfoQLGOv5Y8I0ZrD1LiGPMnEgQRGoBnuuFfjKwt0=;
        b=fgKVKOJuwdOVelj8i3MGUszAZp/7OLkQdh1n4cDm46euEk9WoNJp5SjAq8sRMeTSUc
         QdnTTtwiDTPDnDRqE3qcsiSdKM6oKE7RxaU0I7dScmaBConHULjiRd/Z8RSKljouCQ4s
         PBwOcfjFlZl1cTy7/XiosOecADZ4NupliYTAvEMz2OXbQYPTr6SymghC/qLeGBYkkDxp
         5dT/FuCy337D+v3iZ18iR/YIXRZFA5h3MlIQnqIjK+frNaZ+4tiomAKw+7OwsQ6FLv9z
         r2ZXkD745j21HqKXvSIBivI3nq0KvSGrTOSEFisVIopyhlgu4hAK2aO7xT06nybdtt9J
         fBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kZKFfoQLGOv5Y8I0ZrD1LiGPMnEgQRGoBnuuFfjKwt0=;
        b=T1YuipfUxjhjn7OE7OqSkCJlSl+iyB2kLGtOQIwX10xpK+CLBprgkdRsmmPxgb/4nS
         qAx+QW05p7tNVJenL+ma0jnf1qA3WeIrJ3Mu9sRuP1p86nxzUnBlvCGcQpo6/8a65BAj
         vOYGcWKDmwZwlL4vESpFjFbfaCdjyDuhQ6kgXdOkr4RXtFcrKbbG7ifALBLqqeo/EE9o
         dozcB5jfE8gvGi2d/hwtmqNBpMTrKLFHP/SNK4S55nYGIAByGwSN+IynfZUYUz/g0+Vo
         aHKB/jLeyI6GEyZShfRJbk2LdGurcis+pJ/datvUuFnY1yU4FHS6sdxE6BcmULvXidfa
         hFVg==
X-Gm-Message-State: APt69E0hSFa4GT2VirhRf8LgQ4YBTePopW2Q+roTmeIkDwqQqhcwEgUF
        67/1BTD2bj6TPz1BAtYhTOoint5G
X-Google-Smtp-Source: ADUXVKICDBw2vg7GN4HC3ocvBKGCDyilFjq1potJnpp+UtYf5UySdMkx/HbubcFzwb3M34lO8Oagvg==
X-Received: by 2002:adf:b05c:: with SMTP id g28-v6mr10658315wra.128.1529944963400;
        Mon, 25 Jun 2018 09:42:43 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id d14-v6sm2912904wro.24.2018.06.25.09.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:42:42 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 1/4] sha1-name.c: added 'get_oidf', which acts like 'get_oid'
Date:   Mon, 25 Jun 2018 19:42:24 +0300
Message-Id: <4c1f71b067ac235c3003d58e1f3dfb07866be129.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to 'get_oid', 'get_oidf' has as parameters a
printf format string and the additional arguments. This
will help simplify the code in subsequent commits.

Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 cache.h     |  1 +
 sha1-name.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/cache.h b/cache.h
index 89a107a7f..9252a4546 100644
--- a/cache.h
+++ b/cache.h
@@ -1321,6 +1321,7 @@ struct object_context {
 	GET_OID_BLOB)
 
 extern int get_oid(const char *str, struct object_id *oid);
+extern int get_oidf(struct object_id *oid, const char *fmt, ...);
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7..80ee8f742 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1466,6 +1466,25 @@ int get_oid(const char *name, struct object_id *oid)
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
2.18.0.rc2.13.g506fc12fb

