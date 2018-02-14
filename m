Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84CD1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162564AbeBNTCJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:09 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:50904 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162570AbeBNTCG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:06 -0500
Received: by mail-yw0-f202.google.com with SMTP id o201so22377230ywd.17
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mCvJpfOrNiYw6DBKkRNIsAWQpCb1L8XWypSo/LrfwPQ=;
        b=m3bdw1ETcHqVv40uqbBMLJRJfdwZ5WSs1SQnRbObbx9m63U6Z/OR2QPKO+bR6a+hRx
         SCjkDyQcy1fd0EW0Fenh/F6dW56znhrt9t+QYmNpMAZlzP5n9CgyTemgNC8MT15iOII3
         dMLycEXDfPt0gCPm6E+aNyyr0EqSw3vwVtBofqI8nc4gxK4DofdiAaVGr46wHlOdApwB
         krz8hbDoHnET/3pyyhS8aNQKAMbisZPc6xfLVmiz5cH51Jbi0ZYe5f94ADRb4uCTay7s
         pPTHXCwuLxjE5SK8HWpgqeL+eZUm+N0GiwRYOMk+meKeYj8872JRT2gLtVX3l4FR24qQ
         GtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mCvJpfOrNiYw6DBKkRNIsAWQpCb1L8XWypSo/LrfwPQ=;
        b=K3v14OzCvJSmUHneyv3OxXwOF3u3rxrw0bzNk6y25XiQslmPCQVunrhXTwniUs04Sg
         +bkeshnJEJjNYdLjUaAl8TltEC1mqiacMT4vOHosxfs3gNp2i6cFZ3+RmvL/G25WMnBR
         +aZVBKv+yKcfv7McZ5o4xr8hJt6UQYN9lyTELqlK9usx7hwXWGrj3k51tU8IvqOxEweF
         xYflkcwjzyZb81tvoBllL0iE37ygQPi0NWRE6xHoknlq0nOT/iOG3ob0YryRdYlEBl31
         g6nj0yKM4UXoJjwkmk5qPhzAqIzJ4xGQiA4Kr4fbpZ6LotTL/KhlLJJocZI3A/7BNX/H
         rpsw==
X-Gm-Message-State: APf1xPAcIrZzlwH87tjYdd0+8nKVQ/UYGvbxpA0/L4rPlLRgIbeLQeXt
        JHKtDvwP3wiTWQxgLxeLSJiDpUnt9rJNRAOZdYBerPidevSEGccCkWabWBZHzVodXyYpFJ08YI+
        NCEb2FZ6YuF6GNOY13cIyOmtLKaTGYGquMTfogDZn/9sW7qIkKmJeOuO9ew==
X-Google-Smtp-Source: AH8x225aqsrNabR9tPfR3HkpbJobNCxY2X05cIwqw2kzhuN94VI2PoLpqXdU5GByICttQ0sHq0cHc2nny28=
MIME-Version: 1.0
X-Received: by 10.37.97.15 with SMTP id v15mr2950061ybb.21.1518634925611; Wed,
 14 Feb 2018 11:02:05 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:53 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-32-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 31/37] environment: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h       |  2 +-
 environment.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 69b5a3bf8..5b8d49377 100644
--- a/cache.h
+++ b/cache.h
@@ -1673,7 +1673,7 @@ struct pack_entry {
  * usual "XXXXXX" trailer, and the resulting filename is written into the
  * "template" buffer. Returns the open descriptor.
  */
-extern int odb_mkstemp(struct strbuf *template, const char *pattern);
+extern int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
 
 /*
  * Create a pack .keep file named "name" (which should generally be the output
diff --git a/environment.c b/environment.c
index 63ac38a46..98f77ea95 100644
--- a/environment.c
+++ b/environment.c
@@ -247,7 +247,7 @@ char *get_object_directory(void)
 	return the_repository->objectdir;
 }
 
-int odb_mkstemp(struct strbuf *template, const char *pattern)
+int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
 	/*
@@ -255,16 +255,16 @@ int odb_mkstemp(struct strbuf *template, const char *pattern)
 	 * restrictive except to remove write permission.
 	 */
 	int mode = 0444;
-	git_path_buf(template, "objects/%s", pattern);
-	fd = git_mkstemp_mode(template->buf, mode);
+	git_path_buf(temp_filename, "objects/%s", pattern);
+	fd = git_mkstemp_mode(temp_filename->buf, mode);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
-	/* some mkstemp implementations erase template on failure */
-	git_path_buf(template, "objects/%s", pattern);
-	safe_create_leading_directories(template->buf);
-	return xmkstemp_mode(template->buf, mode);
+	/* some mkstemp implementations erase temp_filename on failure */
+	git_path_buf(temp_filename, "objects/%s", pattern);
+	safe_create_leading_directories(temp_filename->buf);
+	return xmkstemp_mode(temp_filename->buf, mode);
 }
 
 int odb_pack_keep(const char *name)
-- 
2.16.1.291.g4437f3f132-goog

