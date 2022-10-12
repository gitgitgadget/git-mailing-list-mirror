Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D96C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 12:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJLMxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJLMxC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 08:53:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A21EC90F7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e18so10362449wmq.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ye6lJQwKN7ZqHsRHUGxLWmS3tm9YC/ga6sYyrz6AN5c=;
        b=R2MysE85M/QhyQNcH58w1bHmEyvUxSr7VxOBCWAfuQ2PsIL28bjzQXYwM4APSwf0WW
         3l3w0+2DBrGJm0h6YKdJn9CkJ/saJxlbnyODqX9n9lIqTmuciGcLYlBSK3A1jgKdFx3v
         KB+HI0Zu/rbRaQn/uMt5FA5ghaayXUWFSUbTfBEslSF+P9LITgppfOf3IBGhDHF7sRt2
         olQWpd6b3P3S/VG9yObi2hQlq9gIFaCRl2UMM1ZolIvCWBfZT6PYGd//8WlT6B2ZmTRq
         32HNYcjcEqLg51IwzAyTgZqC+uIqO0EyI3p9wIWX0qA8Hgai6l4W95fmiB5X/wdGK66P
         xPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ye6lJQwKN7ZqHsRHUGxLWmS3tm9YC/ga6sYyrz6AN5c=;
        b=bYOmwB+jlaKa8OevPFqz71Qo0Y1Srj2xY+beZDVbBzvEKcBhNO+K/cxD/4sO8r/Xnd
         n9hxTO5yR01V18AHJVl5FXvTZk0hlF0CDz9F/kPdYRlmnWqRQPedv8xCAo3nEdkCC2qB
         oWBiuJePXbAEZs8i6J8EJ84SUXFjUrHV4dvb5+yFT+DDAYMr9ZsKZllpIHKmfxat0IRX
         9nF6I3vUUwb1zEmJ44UVdX6sb8fxzDR2FDZxjYlofPEa8Ag1NnMs9MkwSvude6H7XlmX
         dRsEY4hW/zCyc9YvtosJ8ZdKn59vtvAhALOb5ofDcu2EdNEQd+LNDqtUWLJOOzgHURcq
         H6CQ==
X-Gm-Message-State: ACrzQf1nGuxSkCvekxfFA2UDwluxsaLYadrePcWSv+0mJLJt0KOxIi7u
        AdJgSdhSpCwDK7RJP92vBtnBPrryVIg=
X-Google-Smtp-Source: AMsMyM4/PLzUgEeXarwG0wv0fEkTe67qlna7cJzD850syYUNGM0RLasDNZIokV/peXTxsEf8AE5xqQ==
X-Received: by 2002:a05:600c:3554:b0:3c3:fdfd:f393 with SMTP id i20-20020a05600c355400b003c3fdfdf393mr2750456wmq.188.1665579174564;
        Wed, 12 Oct 2022 05:52:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv10-20020a0560001f0a00b00228fa832b7asm13637688wrb.52.2022.10.12.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 05:52:53 -0700 (PDT)
Message-Id: <fba3a4a117e5996ba4a7e14d7391954b249b2b68.1665579160.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 12:52:37 +0000
Subject: [PATCH v5 10/12] bundle: add flags to verify_bundle()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The verify_bundle() method has a 'verbose' option, but we will want to
extend this method to have more granular control over its output. First,
replace this 'verbose' option with a new 'flags' option with a single
possible value: VERIFY_BUNDLE_VERBOSE.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c |  5 +++--
 bundle-uri.c     |  7 ++++++-
 bundle.c         |  9 +++++----
 bundle.h         | 14 ++++++++++++--
 transport.c      |  2 +-
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 2adad545a2e..7d983a238f0 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -119,7 +119,8 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 		goto cleanup;
 	}
 	close(bundle_fd);
-	if (verify_bundle(the_repository, &header, !quiet)) {
+	if (verify_bundle(the_repository, &header,
+			  quiet ? 0 : VERIFY_BUNDLE_VERBOSE)) {
 		ret = 1;
 		goto cleanup;
 	}
@@ -185,7 +186,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
 			     _("Unbundling objects"), NULL);
 	ret = !!unbundle(the_repository, &header, bundle_fd,
-			 &extra_index_pack_args) ||
+			 &extra_index_pack_args, 0) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
 cleanup:
diff --git a/bundle-uri.c b/bundle-uri.c
index 70bfd2defee..d9060be707e 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -303,7 +303,12 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
 		return 1;
 
-	if ((result = unbundle(r, &header, bundle_fd, NULL)))
+	/*
+	 * Skip the reachability walk here, since we will be adding
+	 * a reachable ref pointing to the new tips, which will reach
+	 * the prerequisite commits.
+	 */
+	if ((result = unbundle(r, &header, bundle_fd, NULL, 0)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index c277f3b9360..1f6a7f782e1 100644
--- a/bundle.c
+++ b/bundle.c
@@ -189,7 +189,7 @@ static int list_refs(struct string_list *r, int argc, const char **argv)
 
 int verify_bundle(struct repository *r,
 		  struct bundle_header *header,
-		  int verbose)
+		  enum verify_bundle_flags flags)
 {
 	/*
 	 * Do fast check, then if any prereqs are missing then go line by line
@@ -248,7 +248,7 @@ int verify_bundle(struct repository *r,
 		error("%s %s", oid_to_hex(oid), name);
 	}
 
-	if (verbose) {
+	if (flags & VERIFY_BUNDLE_VERBOSE) {
 		struct string_list *r;
 
 		r = &header->references;
@@ -617,7 +617,8 @@ err:
 }
 
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, struct strvec *extra_index_pack_args)
+	     int bundle_fd, struct strvec *extra_index_pack_args,
+	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
@@ -631,7 +632,7 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, 0))
+	if (verify_bundle(r, header, flags))
 		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
diff --git a/bundle.h b/bundle.h
index 0c052f54964..6652e819981 100644
--- a/bundle.h
+++ b/bundle.h
@@ -29,7 +29,13 @@ int read_bundle_header_fd(int fd, struct bundle_header *header,
 int create_bundle(struct repository *r, const char *path,
 		  int argc, const char **argv, struct strvec *pack_options,
 		  int version);
-int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
+
+enum verify_bundle_flags {
+	VERIFY_BUNDLE_VERBOSE = (1 << 0),
+};
+
+int verify_bundle(struct repository *r, struct bundle_header *header,
+		  enum verify_bundle_flags flags);
 
 /**
  * Unbundle after reading the header with read_bundle_header().
@@ -40,9 +46,13 @@ int verify_bundle(struct repository *r, struct bundle_header *header, int verbos
  * Provide "extra_index_pack_args" to pass any extra arguments
  * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
  * "extra_index_pack_args" (if any) will be strvec_clear()'d for you.
+ *
+ * Before unbundling, this method will call verify_bundle() with the
+ * given 'flags'.
  */
 int unbundle(struct repository *r, struct bundle_header *header,
-	     int bundle_fd, struct strvec *extra_index_pack_args);
+	     int bundle_fd, struct strvec *extra_index_pack_args,
+	     enum verify_bundle_flags flags);
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
diff --git a/transport.c b/transport.c
index 52db7a3cb09..c5d3042731a 100644
--- a/transport.c
+++ b/transport.c
@@ -178,7 +178,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args);
+		       &extra_index_pack_args, 0);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget

