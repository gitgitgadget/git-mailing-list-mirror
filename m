Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC31C4727D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4CB2076E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Cucnxk/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIVWuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIVWuw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:50:52 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF97C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:51 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so10395741qvb.13
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pnjvx5nwJkdEA5uoqvN7tjpCjIhkVeUGZe2ysSBLLsA=;
        b=Cucnxk/AblIz7aAOQpsjuhBqoibRc2y8xkZK4zHnBMl8JeqArIotgS1+W9/T+G+v5W
         DyeKnuxUCAS+8YT/F41uIdssW2kKlI9Ku0bO0mEQ4pwp3LAON+3mj4GrRQ5dvO+ZrQdn
         iXi4TNq/duy/TSlH1zRrfhOesVfr97uRF2OuEkbJGqY1/TjZn0uQXv3lyPYWVzq7aBG4
         OQ+4IkiTByGH1GzzqifEYRgmDkvVJuuOnmSnDXMI5LlGKTp3buR54XNSMwceyfesLkZA
         rd+uLiWpV2VPjqJMgNAC/rHW7FhL8/umurVnjY+/G6yjG9n5L4oWNL2VJ4rAyisBRzrt
         28gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pnjvx5nwJkdEA5uoqvN7tjpCjIhkVeUGZe2ysSBLLsA=;
        b=JxmdMD0GEV+EPlafMmFKMKMOZ8q4DffVi11N6D9eot42Tn8oPAlUusMPxQC/dwUD9c
         HJoF4vJp3bQv2TWyzXSV2EDuH58xO4XrxL5LWxxUPkXhPD5yMc4dNKqzupJzVHUxE90Z
         ZdQevB6vQRfWlfIPuDG82xPfn639CCH0y1GaMFUrluKDljgYovQyKQaUPAZiA8NVA0L/
         dkrvfX1B7aLvriQGDznoKETXboZaelr/Xqiy4tr2ewQeFi4yt9r4buVFR23606hzMttI
         poqzIB85vT+a7g/RVNea8EhtB/6F9WYPJWyH8Sg/UHoU7rk/+CubdU/3WSTCcDcigxDL
         2GyQ==
X-Gm-Message-State: AOAM531DC10gB2tLmhaiUE5LaOqi1WVt5iUtPK0BfaBf8mYcSvOv3hTf
        pKuSYsn2nADHbzHPRGidaWkCMnp8yIJcjA==
X-Google-Smtp-Source: ABdhPJw0jJsxKInqwFtMhvwnV7oFSTYoJ6QWGLNyS/VscyG4OOdrm4KzBt34R0YfvTxiIFr5099UuA==
X-Received: by 2002:ad4:544a:: with SMTP id h10mr8450449qvt.35.1600815050824;
        Tue, 22 Sep 2020 15:50:50 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:50 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 06/19] entry: make fstat_output() and read_blob_entry() public
Date:   Tue, 22 Sep 2020 19:49:20 -0300
Message-Id: <dbee09e9366ee802306eba3cd598c62c64ef7e5f.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two functions will be used by the parallel checkout code, so let's
make them public. Note: fstat_output() is renamed to
fstat_checkout_output(), now that it has become public, seeking to avoid
future name collisions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 8 ++++----
 entry.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index b0b8099699..b36071a610 100644
--- a/entry.c
+++ b/entry.c
@@ -84,7 +84,7 @@ static int create_file(const char *path, unsigned int mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
-static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
+void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
 {
 	enum object_type type;
 	void *blob_data = read_object_file(&ce->oid, &type, size);
@@ -109,7 +109,7 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
 	}
 }
 
-static int fstat_output(int fd, const struct checkout *state, struct stat *st)
+int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
 {
 	/* use fstat() only when path == ce->name */
 	if (fstat_is_reliable() &&
@@ -132,7 +132,7 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 		return -1;
 
 	result |= stream_blob_to_fd(fd, &ce->oid, filter, 1);
-	*fstat_done = fstat_output(fd, state, statbuf);
+	*fstat_done = fstat_checkout_output(fd, state, statbuf);
 	result |= close(fd);
 
 	if (result)
@@ -346,7 +346,7 @@ static int write_entry(struct cache_entry *ce,
 
 		wrote = write_in_full(fd, new_blob, size);
 		if (!to_tempfile)
-			fstat_done = fstat_output(fd, state, &st);
+			fstat_done = fstat_checkout_output(fd, state, &st);
 		close(fd);
 		free(new_blob);
 		if (wrote < 0)
diff --git a/entry.h b/entry.h
index 2d69185448..f860e60846 100644
--- a/entry.h
+++ b/entry.h
@@ -37,5 +37,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
  * removal, such that empty directories get removed.
  */
 void unlink_entry(const struct cache_entry *ce);
+void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
+int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
 
 #endif /* ENTRY_H */
-- 
2.28.0

