Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCCE1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeLTTov (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:44:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36201 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTTov (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so3506981wmc.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jaSb88dotPeBZdS7GCYPpQb9XgbCmyqG/iQIZacjNcc=;
        b=SNnaoyVWYtHQpBNz+CYTv60yKChOI9NN6/ZG60l2PfCeAhwS2cul1OEzYsRjs2UgDy
         Txgostak2RFgAYp70vBXlfczt8MYsiEg8Kfh3Q5VRhiOL5hfH69OiHvXhNqj259gmzYB
         OaCp63rtt+ikj9vTScEYdawnHOZ++D7ZyLOFlFGPWCWCFIdM6vW/BLPlBSmYscdGGBOy
         tVzH3njReIMgDMDNgW5pwqDR0jZ6D+/Ugy8FGT16Ytbjt/moXFs/hl1ZZ2nsrynlu8RB
         DNybQSD8D3YmsUNnbc0P8CkYi+PhGFvZFSbk/RYpqnGsoUVMQDkhV7d5KtAxDVRt769N
         iemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaSb88dotPeBZdS7GCYPpQb9XgbCmyqG/iQIZacjNcc=;
        b=Ft2m9EFBStYuzFlSZXDInWlFtq95QB/bDoKMXRKVd5D3Q6XgbBxpI6u9tuaozMbeNP
         SXTAyvUhDTADDbIxbQuquDiXl5HCgbmJJ8SfnOlGcN3YN0QXKxaYAc15X5pNpiYHjYlZ
         WD1AiZ95LB9uFo3GR0qUiA5O2EQmRLalPIls9zBb2p5Wzd0vuHolWc2u84UbRVlAOgqp
         aAAYq0GCcnrexBZGUtUcrwikxtZhZJpEedal3Ge2WSp1Ff8yooXxaO3fsw7vWmral93C
         WS7AVrBIEA2vmsn6wjk2jn469FMhMF0VPsiWu0tXvzWwtiyXlyxV2XZ8GaA/SlRLb7bK
         EYPA==
X-Gm-Message-State: AJcUukevxZVLTJ12f39LwWmWwwTw4QJKDBsE/KbPCEunwcckEQNvAIsb
        vbOsJeXYAzCN+w3EAJ03obvcUVA97CU=
X-Google-Smtp-Source: AFSGD/UWComrxlLCc8f3bMPQKkLEuDyTFwQEpAM/v6zxFN4bID4kmDbLuQ2+Nij1PCOG+FcDP0/Skw==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr18714wmi.58.1545335089465;
        Thu, 20 Dec 2018 11:44:49 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:48 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 01/26] sha1-name.c: add `get_oidf()` which acts like `get_oid()`
Date:   Thu, 20 Dec 2018 21:44:17 +0200
Message-Id: <6b3308038a727e27930f95b208dd3f2c94085375.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
index b7acd81d2e..28ccc97e10 100644
--- a/cache.h
+++ b/cache.h
@@ -1335,6 +1335,7 @@ struct object_context {
 	GET_OID_BLOB)
 
 extern int get_oid(const char *str, struct object_id *oid);
+extern int get_oidf(struct object_id *oid, const char *fmt, ...);
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index b24502811b..9524a09525 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1516,6 +1516,25 @@ int get_oid(const char *name, struct object_id *oid)
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
2.20.1.441.g764a526393

