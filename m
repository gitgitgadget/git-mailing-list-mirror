Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766801F405
	for <e@80x24.org>; Tue, 18 Dec 2018 07:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeLRHZx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 02:25:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45440 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRHZx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 02:25:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so13256999ljd.12
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 23:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dHhS5L56ogl2LVxjQH3RHOMZnyWybCL1qQEDbZ/Zts=;
        b=clm7j9Tt5GJIJYwzbjKFozNxJLr0x04eqv8dUX8HKlbeHH7WC63nHubPRhPAJ56M/s
         rSTnBlwfAeSynTFomggzTRBNA+wPBy9UIVf6YaoyG8q26nZRcRbdwFTxvLphumL/Wl2w
         s+TxE6MtBiiqvu3UPs6GhiaCoRfzn3LeDyFfbRCgOIIHOOYp3sjdi6JL7mBIHZhSVRJ1
         F50gEnEPWwUixrjoFbAbR29jZmnXBh4NEYWh/YyUf3vrvIWXLRu57LK3dbqIRcp0RBp6
         q2Pv8W7wn1JBaIuPsY8vgF9NwnCt5BX/vMRVijfgKsvUA72OhG33c22oSr8cA+PgmLbL
         zrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dHhS5L56ogl2LVxjQH3RHOMZnyWybCL1qQEDbZ/Zts=;
        b=QXiJDXh4NFWpEKJMa7xTN+2JrqYMWgcKKi23pfYrvOubddyO0DQYx73zIUh9q0XeoN
         69Rc4K1k3awhussGOvFX/FW8Hq0CQ5ELidzlYLTW5VQgfd7ejZlJZhEYPKuZKVgD2kv8
         yQpLmp5karJQ6uExk9ddqEqwAGRyWi7PHKI8etsw8wKXqdw7qJrXxiSTjzRZnN5D/dCh
         OPa0sIAy4DuDzWwepJmRk618oUplUAPNfBQMFek+PDhSiJF/zp7TlTNFdE6x6uZlOQP1
         hTrfjsjL4QCyE97k56nruk708Q15sf9E8IS/gPdYxDSyvy+iNKu3KoPSrAk+RCo3JaUI
         yJZA==
X-Gm-Message-State: AA+aEWaLiQ70/4CTNH/NOszNQZBONIurtWP04BwgE1I+z/+Ca6bZ7jo5
        PXr9QT0EBp3+jQ+q/+uZZjz+DBL/
X-Google-Smtp-Source: AFSGD/VrfOVJjax1F+q6dzcwltDpT7uBTdGp90WAGKMqVrZADyuCb6crebGCnt7kZ/LVnyFjCYBGdA==
X-Received: by 2002:a2e:b04f:: with SMTP id d15-v6mr10418318ljl.3.1545117950478;
        Mon, 17 Dec 2018 23:25:50 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id f11sm3142441lfi.12.2018.12.17.23.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 23:25:49 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/3] setup: drop return value from `read_repository_format()`
Date:   Tue, 18 Dec 2018 08:25:26 +0100
Message-Id: <20181218072528.3870492-2-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218072528.3870492-1-martin.agren@gmail.com>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No-one looks at the return value, so we might as well drop it. It's
still available as `format->version`.

In v1 of what became commit 2cc7c2c737 ("setup: refactor repo format
reading and verification", 2016-03-11), this function actually had
return type "void", but that was changed in v2. Almost three years
later, no-one has used this return value.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 I only discovered the full history after writing the patch. Had I known
 it from the beginning, maybe I'd have just skipped this step, but I was
 sufficiently disturbed by the redundant and unused return value that I
 dropped it before working on the actual meat of this series.

 cache.h | 7 +++----
 setup.c | 3 +--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index ca36b44ee0..8b9e592c65 100644
--- a/cache.h
+++ b/cache.h
@@ -974,11 +974,10 @@ struct repository_format {
 
 /*
  * Read the repository format characteristics from the config file "path" into
- * "format" struct. Returns the numeric version. On error, -1 is returned,
- * format->version is set to -1, and all other fields in the struct are
- * undefined.
+ * "format" struct. On error, format->version is set to -1, and all other
+ * fields in the struct are undefined.
  */
-int read_repository_format(struct repository_format *format, const char *path);
+void read_repository_format(struct repository_format *format, const char *path);
 
 /*
  * Verify that the repository described by repository_format is something we
diff --git a/setup.c b/setup.c
index 1be5037f12..27747af7a3 100644
--- a/setup.c
+++ b/setup.c
@@ -509,7 +509,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	return 0;
 }
 
-int read_repository_format(struct repository_format *format, const char *path)
+void read_repository_format(struct repository_format *format, const char *path)
 {
 	memset(format, 0, sizeof(*format));
 	format->version = -1;
@@ -517,7 +517,6 @@ int read_repository_format(struct repository_format *format, const char *path)
 	format->hash_algo = GIT_HASH_SHA1;
 	string_list_init(&format->unknown_extensions, 1);
 	git_config_from_file(check_repo_format, path, format);
-	return format->version;
 }
 
 int verify_repository_format(const struct repository_format *format,
-- 
2.20.1

