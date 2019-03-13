Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34B220248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCMXdj (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:33:39 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:47175 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCMXdj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:33:39 -0400
Received: by mail-yw1-f73.google.com with SMTP id c188so4688223ywf.14
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=y3Jt/1u+DftNsOqw7dz6r517TAIoh2kerhuMHHclmRk=;
        b=IQsVxGctS+9smkyMRir6ChH0v7z7fPotU7iDhPpWKkUX30BYaU3cxMJRA2ZFZiDaJS
         loh4CTFCS+XZR3l6MzCQ14EVjk57O9niIO8nOGwHGqealvr95VbVqKz9T7brabZmCwWk
         naS7tHcnUItVrxfG0dETU/RzbVJ3JNPc9/RG0WO0VQfXntoHT1QKiOCgJQOkqeCySqQ6
         hWvWVo/NKzF7KiGj7SFAGig9ocMX/IY5/JIDWxhK2WMNolTfovs9GQa95sOec+fjlkyG
         iXg6eNuOYanFDmsUZJaVOj6B925Q1AYnfa1CBmp2pIe0FqCrp1hqX4I346z2K7gNTTye
         5cwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=y3Jt/1u+DftNsOqw7dz6r517TAIoh2kerhuMHHclmRk=;
        b=LflimnDnDPpnc9/x3sM8BhSWx424a0TMpfIC4s5bcNI/gw6GzYOBaJUCgXDAOzmpWV
         qAXN18o4E0lUl0eX+rY6xxgeBbRRvGaHI2JgFNBfSm38/aUaYtDQ00Cr2V5kW9IyQ85P
         JcvrBvfCtJxK7kOuqu/stLFERiRzhCMShFqXpxPpTsW73z73nrfqiKu81U/+HSXHG/EP
         NF1Lh9SHOWV7koWgQA1dJDBU9klrT26OjpJQY0i+4CBxbQauTUqHZIY8S0NJ+khyHFQL
         3kATmzX4B/fAOrOlQFsYvLH5MfhATLlWpTYQNHn1n29ig+yO3VVHoVW8i4ZeoTpT0jlp
         s5TQ==
X-Gm-Message-State: APjAAAUlH+IQr1KcbEJ8bZDfkLMpVIRM4tSOW3BmV5WzTHIhMa61+nbI
        9+iYFR9+RVZ2ryViqHIRVOLd/V9l+23ERe7f/5nE3h4SGMEzaDeNOHb9UF+/UhBHwNb4m73/bm2
        qfSTVbsJ+k0aME412GTNhL++eS+KOuoOAxb59VIh5e5zY5XUA/P2JgnUFIRwdFaI=
X-Google-Smtp-Source: APXvYqwcx/7inlgEaMMpBx1QI2qYsxheTcI3soT3ByHnHlnPg6tDkyYcHW5e5PWv+L00aTWwe0N8Ff2IfZv4Zg==
X-Received: by 2002:a25:fc1:: with SMTP id 184mr9527915ybp.1.1552520017829;
 Wed, 13 Mar 2019 16:33:37 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:33:29 -0700
In-Reply-To: <cover.1552519463.git.steadmon@google.com>
Message-Id: <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1552519463.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the value of a trace2 environment variable contains instances of
the string "%ISO8601%", expand them into the current UTC timestamp in
ISO 8601 format.

When the value of a trace2 environment variable is an absolute path
referring to an existing directory, write output to randomly-named
files under the given directory. If the value is an absolute path
referring to a non-existent file and ends with a dash, use the value as
a prefix for randomly named files.

The random filenames will consist of the value of the environment
variable (after potential timestamp expansion), followed by a 6
character random string such as would be produced by mkstemp(3).

This makes it more convenient to collect traces for every git
invocation by unconditionally setting the relevant trace2 envvar to a
constant directory name.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 10 +++
 t/t0210-trace2-normal.sh               | 93 ++++++++++++++++++++++++++
 trace2/tr2_dst.c                       | 86 +++++++++++++++++++++++-
 3 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 2de565fa3d..1362bf7d0b 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -109,6 +109,16 @@ values are recognized.
 
 	Enables the target, opens and writes to the file in append mode.
 
+	If the path includes any instances of the string "%ISO8601%", they will
+	be replaced with the current UTC timestamp in ISO 8601 format with
+	dashes and colons removed, e.g., "20190315T143059Z".
+
+	If (after potential timestamp expansion) the path already exists and is
+	a directory, the traces will write to randomly-named files (one per
+	process) under the given directory. If the pathname does not already
+	exist and ends with a dash, it will be used as a prefix for
+	randomly-named files (one per process).
+
 `af_unix:[<socket_type>:]<absolute-pathname>`::
 
 	Enables the target, opens and writes to a Unix Domain Socket
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 03a0aedb1d..1b992c3e61 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -80,6 +80,99 @@ test_expect_success 'normal stream, return code 1' '
 	test_cmp expect actual
 '
 
+test_expect_success 'randomized filename' '
+	test_when_finished "rm -r traces actual expect" &&
+	mkdir traces &&
+	GIT_TR2="$(pwd)/traces" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/??????)" >actual &&
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
+test_expect_success 'randomized filename with prefix' '
+	test_when_finished "rm -r traces actual expect" &&
+	mkdir traces &&
+	GIT_TR2="$(pwd)/traces/trace-" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/trace-??????)" >actual &&
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
+test_expect_success 'timestamped filename' '
+	test_when_finished "rm -r traces actual expect" &&
+	mkdir traces &&
+	GIT_TEST_DATE_NOW=1552658399 GIT_TR2="$(pwd)/traces/trace.%ISO8601%" \
+		test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <traces/trace.20190315T135959Z >actual &&
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
+test_expect_success 'multiple timestamps' '
+	test_when_finished "rm -r traces actual expect" &&
+	mkdir -p traces/20190315T135959Z &&
+	GIT_TEST_DATE_NOW=1552658399 GIT_TR2="$(pwd)/traces/%ISO8601%/trace.%ISO8601%" \
+		test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <traces/20190315T135959Z/trace.20190315T135959Z >actual &&
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
+test_expect_success 'timestamp plus randomization' '
+	test_when_finished "rm -r traces actual expect" &&
+	mkdir traces &&
+	GIT_TEST_DATE_NOW=1552658399 GIT_TR2="$(pwd)/traces/trace-%ISO8601%-" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/trace-20190315T135959Z-??????)" >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 001return 0
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+test_expect_success 'no randomization if target exists' '
+	test_when_finished "rm -r traces actual expect" &&
+	mkdir traces &&
+	touch traces/trace- &&
+	GIT_TR2="$(pwd)/traces/trace-" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <traces/trace- >actual &&
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
+
 # Verb 002exit
 #
 # Explicit exit(code) from within cmd_<verb> propagates <code>.
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index fd490a43ad..27405a92b4 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -12,6 +12,11 @@
  */
 #define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"
 
+/* Constant string used for timestamp replacement in output destination
+ * filenames. See tr2_replace_timestamp_templates() below.
+ */
+static const char *iso_timestamp_tmpl = "%ISO8601%";
+
 static int tr2_dst_want_warning(void)
 {
 	static int tr2env_dst_debug = -1;
@@ -55,6 +60,64 @@ static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
 	return dst->fd;
 }
 
+static void tr2_replace_timestamp_templates(const char *path,
+					    struct strbuf *modified_path)
+{
+	char *iso_ptr;
+
+	strbuf_addstr(modified_path, path);
+
+	iso_ptr = strstr(modified_path->buf, iso_timestamp_tmpl);
+	if (iso_ptr) {
+		struct timeval tv;
+		struct tm tm;
+		size_t iso_len = strlen(iso_timestamp_tmpl);
+		struct strbuf timestamp = STRBUF_INIT;
+
+		get_time(&tv);
+		gmtime_r(&tv.tv_sec, &tm);
+		strbuf_addftime(&timestamp, "%Y%m%dT%H%M%SZ", &tm, 0, 0);
+
+		while (iso_ptr) {
+			strbuf_splice(modified_path,
+				      iso_ptr - modified_path->buf, iso_len,
+				      timestamp.buf, timestamp.len);
+
+			iso_ptr = strstr(modified_path->buf,
+					 iso_timestamp_tmpl);
+		}
+
+		strbuf_release(&timestamp);
+	}
+}
+
+static int tr2_dst_try_random_path(struct tr2_dst *dst, struct strbuf *path)
+{
+	int fd;
+	char last_path_char;
+
+	last_path_char = path->buf[path->len - 1];
+	if (!is_dir_sep(last_path_char) && last_path_char != '-')
+		strbuf_addch(path, '/');
+
+	strbuf_addstr(path, "XXXXXX");
+
+	fd = mkstemp(path->buf);
+	if (fd == -1) {
+		if (tr2_dst_want_warning())
+			warning("trace2: could not open '%s' for '%s' tracing: %s",
+				path->buf, dst->env_var_name, strerror(errno));
+		tr2_dst_trace_disable(dst);
+		return 0;
+	}
+
+	dst->fd = fd;
+	dst->need_close = 1;
+	dst->initialized = 1;
+
+	return dst->fd;
+}
+
 #ifndef NO_UNIX_SOCKETS
 #define PREFIX_AF_UNIX "af_unix:"
 #define PREFIX_AF_UNIX_STREAM "af_unix:stream:"
@@ -177,6 +240,7 @@ static void tr2_dst_malformed_warning(struct tr2_dst *dst,
 int tr2_dst_get_trace_fd(struct tr2_dst *dst)
 {
 	const char *tgt_value;
+	struct stat st;
 
 	/* don't open twice */
 	if (dst->initialized)
@@ -202,8 +266,26 @@ int tr2_dst_get_trace_fd(struct tr2_dst *dst)
 		return dst->fd;
 	}
 
-	if (is_absolute_path(tgt_value))
-		return tr2_dst_try_path(dst, tgt_value);
+	if (is_absolute_path(tgt_value)) {
+		int fd;
+		struct strbuf modified_path = STRBUF_INIT;
+
+		tr2_replace_timestamp_templates(tgt_value, &modified_path);
+
+		/*
+		 * Randomize the path if it is an existing directory, or if the
+		 * path does not exist and ends with '-'.
+		 */
+		if (is_directory(modified_path.buf) ||
+		    (stat(modified_path.buf, &st) == -1 && errno == ENOENT &&
+		     modified_path.buf[modified_path.len - 1] == '-'))
+			fd = tr2_dst_try_random_path(dst, &modified_path);
+		else
+			fd = tr2_dst_try_path(dst, modified_path.buf);
+
+		strbuf_release(&modified_path);
+		return fd;
+	}
 
 #ifndef NO_UNIX_SOCKETS
 	if (starts_with(tgt_value, PREFIX_AF_UNIX))
-- 
2.21.0.360.g471c308f928-goog

