Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7EE1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 07:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeLRH0G (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 02:26:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33955 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRH0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 02:26:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so2588027lje.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 23:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UU/np2Zlc8d9b9YQNH6kCuGloWL7zkbWUMVwJoMfab4=;
        b=CNfQVzUaRepdyoe9tR/Kt/FLjMZmZCpbYGxR5Zdd2uIl+1O8sVdxvg99/q5yIGf+3e
         a13oJTfSwngJjUbZv7TADxqqPHJe9yWfHS4p0k/6MIW/24/VidACzf8Z04e/3NeuOMcL
         5QChlp+S4YVLtxGfUT/UKI5ddqpiiNx3AXf1u+8UQwzXe8cZTfkeTYUMj4iLlPIcCZwV
         YF5EBzJ+mBoAUiuN6RgbI2fHjaVznXmd69fKFtE26qRXIAsf0Y11zTYhoua5Ib0dnH6o
         ZOvBoKZJAX/saKXBnbsV6CVE2TkkZ70H2frVOAO+rtRQzV4B7CEo8BQDVwHebGjnYfnY
         60Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UU/np2Zlc8d9b9YQNH6kCuGloWL7zkbWUMVwJoMfab4=;
        b=Xlcu2f9oytUQPR5klgP4+Z9BBo31uestrERY6ucSWnhcGkOXV10L18XUrNX+GtiYEg
         00tiJ1vSFBxscj+NSyH1hCyiqd2g6Mz8wztcIjFOEQhts66GKgLFylfLOpYeSL9jBNWV
         zQWEcOCWI6xA/SwnibMTogF8en2odqcZehDCbDSduYDEiTHyxgq2Uq8TGAsCU+Qsjxz3
         eWoF6Ep99TLT8O5h0Dx7MOFYNtnS9v1Pk5Q2Oi1kZiUSzQsvSZBzxSiCDcJ8jbx9LHEw
         iJuzfI0GAPY/DvPJ+mkgq9p8v6wvuWX28aqT3aOzMSh8DvfBHuQ08bVHaXZHIo5diwPu
         V/vw==
X-Gm-Message-State: AA+aEWZGbayJItRkKPl3ey8PkVTojBcD09kF5y4q6lFBqIl0+j3lclEm
        64y35xOXWoJtBQnvbV6mkHHNASiH
X-Google-Smtp-Source: AFSGD/WCKsMgLj5EEgZXmfuCdtJGT8U+Q99Pc/fr0gHCEs6DEOmuoWxfIIcQhPugmDR5nTYGE4roMA==
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr10264602lja.111.1545117962975;
        Mon, 17 Dec 2018 23:26:02 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id f11sm3142441lfi.12.2018.12.17.23.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 23:26:02 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/3] setup: add `clear_repository_format()`
Date:   Tue, 18 Dec 2018 08:25:28 +0100
Message-Id: <20181218072528.3870492-4-martin.agren@gmail.com>
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

After we set up a `struct repository_format`, it owns various pieces of
allocated memory. We then either use those members, because we decide we
want to use the "candidate" repository format, or we discard the
candidate / scratch space. In the first case, we transfer ownership of
the memory to a few global variables. In the latter case, we just
silently drop the struct and end up leaking memory.

Introduce a function `clear_repository_format()` which frees the memory
the struct holds on to. Call it in the code paths where we currently
leak the memory. Also call it in the error path of
`read_repository_format()` to clean up any partial result.

For hygiene, we need to at least set the pointers that we free to NULL.
For future-proofing, let's zero the entire struct instead. It just means
that in the error path of `read_...()` we need to restore the error
sentinel in the `version` field.

We could take this opportunity to stop claiming that all fields except
`version` are undefined in case of an error. On the other hand, having
them defined as zero is not much better than having them undefined. We
could define them to some fallback configuration (`is_bare = -1` and
`hash_algo = GIT_HASH_SHA1`?), but "clear()" and/or "read()" seem like
the wrong places to enforce fallback configurations. Let's leave things
as "undefined" instead to encourage users to check `version`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 The error state can always be defined later. Defining it now, then
 trying to backpedal, is probably not so fun. Filling the struct with
 non-zero values might help flush out bugs like the one fixed in the
 previous patch, but I'm wary of going that far in this patch.

 cache.h      |  6 ++++++
 repository.c |  1 +
 setup.c      | 14 ++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/cache.h b/cache.h
index 8b9e592c65..53ac01efa7 100644
--- a/cache.h
+++ b/cache.h
@@ -979,6 +979,12 @@ struct repository_format {
  */
 void read_repository_format(struct repository_format *format, const char *path);
 
+/*
+ * Free the memory held onto by `format`, but not the struct itself.
+ * (No need to use this after `read_repository_format()` fails.)
+ */
+void clear_repository_format(struct repository_format *format);
+
 /*
  * Verify that the repository described by repository_format is something we
  * can read. If it is, return 0. Otherwise, return -1, and "err" will describe
diff --git a/repository.c b/repository.c
index 5dd1486718..efa9d1d960 100644
--- a/repository.c
+++ b/repository.c
@@ -159,6 +159,7 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
+	clear_repository_format(&format);
 	return 0;
 
 error:
diff --git a/setup.c b/setup.c
index 52c3c9d31f..babe5ea156 100644
--- a/setup.c
+++ b/setup.c
@@ -517,6 +517,18 @@ void read_repository_format(struct repository_format *format, const char *path)
 	format->hash_algo = GIT_HASH_SHA1;
 	string_list_init(&format->unknown_extensions, 1);
 	git_config_from_file(check_repo_format, path, format);
+	if (format->version == -1) {
+		clear_repository_format(format);
+		format->version = -1;
+	}
+}
+
+void clear_repository_format(struct repository_format *format)
+{
+	string_list_clear(&format->unknown_extensions, 0);
+	free(format->work_tree);
+	free(format->partial_clone);
+	memset(format, 0, sizeof(*format));
 }
 
 int verify_repository_format(const struct repository_format *format,
@@ -1043,9 +1055,11 @@ int discover_git_directory(struct strbuf *commondir,
 		strbuf_release(&err);
 		strbuf_setlen(commondir, commondir_offset);
 		strbuf_setlen(gitdir, gitdir_offset);
+		clear_repository_format(&candidate);
 		return -1;
 	}
 
+	clear_repository_format(&candidate);
 	return 0;
 }
 
-- 
2.20.1

