Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F17220248
	for <e@80x24.org>; Thu, 21 Mar 2019 00:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCUAQH (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 20:16:07 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:35417 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUAQH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 20:16:07 -0400
Received: by mail-it1-f202.google.com with SMTP id s3so979274itl.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=72dA/ngwVBNUn+4jDc9RjWX9sH1gTQzUSQVA5ApOgcA=;
        b=vu1QrBkEwrdGLack52jlnnoBKEWMCyInAdxPFFGz9nn6vIzPi+2WVWp81HEk9Exsa6
         RkB/vZo8IYh7U6i6dUBjYD1HTEBu6ACNma+59mFweojGlswZ5NSnnFIiFFPt9QUSxjBd
         aKL98uHsxXpp1FhikJQWFSTUFDJoY+kY1kg3iq2z4oWRQdF0lKL1fQvzLszDBau5Bg4r
         XP7WTSBiquIU0Vn3il5E3fWZCC5bg9I23AUSh6uMbXSfw2OXxXsAbwBok81h+pKk90s1
         kt5hEAY446xxL/r3yKUJP/ptV/UFhucCfEwMy6qg9eK6vaFM0yP2SmLVOtKk+wxWDHmt
         X8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=72dA/ngwVBNUn+4jDc9RjWX9sH1gTQzUSQVA5ApOgcA=;
        b=ZeRX0uQatSbBKVqJmD432yeyxzKXp7UkBT/93NFigD6VesmkDyvi1Oz0U84PpqphZD
         5VUlVTJRKcWkYgyF/9bWPeE1w7Qw0DmkvRHLmZ6zGWjCPlRZ8PQReb+Xjc1DZavrROjl
         A/OS7yNIfkAzDLpiwD6EprZugx3yPzxuyxBGn1nDBlwlkX87vSEYwESwnq4tGiTmaFjy
         2UK08/n6rFTMMZ1yEbbUCqiOQza1VtGIgoyqZ1t0R6eDwywMPg7yXgHAb1nNmYcuG89j
         7Ly/mDhLcGV5Qm0Yb2V3fabWOZgjyqrBWxTTJUQENtVC7csyclPKyVPOIAHcucddZVDN
         qYLg==
X-Gm-Message-State: APjAAAVGlSLaYR/gpEK5WXJLK87/tygRjpy43OjiENAbGGqeHHfCMnZA
        +RFa8FIUk/JJ+nwRoVsOXnrlzYEEs/IaVWGXiuVP8Sm4x0oZDcyYnQJA+GZW2IagLezmMP735Vz
        ty12SlAXsfdQOu9R/bGp15GK6emgWwTNCCoqJSTUfb1dygBIaM6qTP7HPvZ9HeFA=
X-Google-Smtp-Source: APXvYqyDNZvGpHzWJ9pAL4uYNrRZRlDu6mLLiOFgT8cqbdASPI3QhMuHVvtsVFZ/RSP4q+q4Pb96ZNHUREB6Xw==
X-Received: by 2002:a24:de45:: with SMTP id d66mr212438itg.7.1553127366085;
 Wed, 20 Mar 2019 17:16:06 -0700 (PDT)
Date:   Wed, 20 Mar 2019 17:16:01 -0700
In-Reply-To: <cover.1553126984.git.steadmon@google.com>
Message-Id: <59d8c6511bc8c5fd25473c282768b38c97df9e6b.1553126984.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1552519463.git.steadmon@google.com> <cover.1553126984.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v2 1/1] trace2: write to directory targets
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com, avarab@gmail.com,
        gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the value of a trace2 environment variable is an absolute path
referring to an existing directory, write output to files (one per
process) underneath the given directory. Files will be named according
to the final component of the trace2 SID, followed by a counter to avoid
potential collisions.

This makes it more convenient to collect traces for every git invocation
by unconditionally setting the relevant trace2 envvar to a constant
directory name.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt |  5 +++
 t/t0210-trace2-normal.sh               | 15 +++++++
 trace2/tr2_dst.c                       | 61 +++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 2de565fa3d..318673e8e5 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -109,6 +109,11 @@ values are recognized.
 
 	Enables the target, opens and writes to the file in append mode.
 
+	If the target already exists and is a directory, the traces will be
+	written to files (one per process) underneath the given directory. They
+	will be named according to the last component of the SID followed by a
+	counter to avoid potential collisions.
+
 `af_unix:[<socket_type>:]<absolute-pathname>`::
 
 	Enables the target, opens and writes to a Unix Domain Socket
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 03a0aedb1d..26c9c1b3b8 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -80,6 +80,21 @@ test_expect_success 'normal stream, return code 1' '
 	test_cmp expect actual
 '
 
+test_expect_success 'randomized filename' '
+	test_when_finished "rm -r traces actual expect" &&
+	mkdir traces &&
+	GIT_TR2="$(pwd)/traces" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/*)" >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 001return 0
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+
 # Verb 002exit
 #
 # Explicit exit(code) from within cmd_<verb> propagates <code>.
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index fd490a43ad..0e752914dc 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "trace2/tr2_dst.h"
+#include "trace2/tr2_sid.h"
 
 /*
  * If a Trace2 target cannot be opened for writing, we should issue a
@@ -12,6 +13,11 @@
  */
 #define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"
 
+/*
+ * How many attempts we will make at creating a random trace output path.
+ */
+#define MAX_RANDOM_ATTEMPTS 10
+
 static int tr2_dst_want_warning(void)
 {
 	static int tr2env_dst_debug = -1;
@@ -36,6 +42,53 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
 	dst->need_close = 0;
 }
 
+static int tr2_dst_try_random_path(struct tr2_dst *dst, const char *tgt_prefix)
+{
+	int fd;
+	const char *last_slash, *sid = tr2_sid_get();
+	struct strbuf base_path = STRBUF_INIT, final_path = STRBUF_INIT;
+	unsigned attempt_count;
+
+	last_slash = strrchr(sid, '/');
+	if (last_slash)
+		sid = last_slash + 1;
+
+	strbuf_addstr(&base_path, tgt_prefix);
+	if (!is_dir_sep(base_path.buf[base_path.len - 1]))
+		strbuf_addch(&base_path, '/');
+	strbuf_addstr(&base_path, sid);
+
+	for (attempt_count = 0; attempt_count < MAX_RANDOM_ATTEMPTS; attempt_count++) {
+		strbuf_reset(&final_path);
+		strbuf_addbuf(&final_path, &base_path);
+		strbuf_addf(&final_path, ".%d", attempt_count);
+
+		fd = open(final_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
+		if (fd != -1)
+			break;
+	}
+
+	if (fd == -1) {
+		if (tr2_dst_want_warning())
+			warning("trace2: could not open '%s' for '%s' tracing: %s",
+				base_path.buf, dst->env_var_name, strerror(errno));
+
+		tr2_dst_trace_disable(dst);
+		strbuf_release(&base_path);
+		strbuf_release(&final_path);
+		return 0;
+	}
+
+	strbuf_release(&base_path);
+	strbuf_release(&final_path);
+
+	dst->fd = fd;
+	dst->need_close = 1;
+	dst->initialized = 1;
+
+	return dst->fd;
+}
+
 static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
 {
 	int fd = open(tgt_value, O_WRONLY | O_APPEND | O_CREAT, 0666);
@@ -202,8 +255,12 @@ int tr2_dst_get_trace_fd(struct tr2_dst *dst)
 		return dst->fd;
 	}
 
-	if (is_absolute_path(tgt_value))
-		return tr2_dst_try_path(dst, tgt_value);
+	if (is_absolute_path(tgt_value)) {
+		if (is_directory(tgt_value))
+			return tr2_dst_try_random_path(dst, tgt_value);
+		else
+			return tr2_dst_try_path(dst, tgt_value);
+	}
 
 #ifndef NO_UNIX_SOCKETS
 	if (starts_with(tgt_value, PREFIX_AF_UNIX))
-- 
2.21.0.225.g810b269d1ac-goog

