Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17EC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928C0613EA
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhEXULj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhEXULj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 16:11:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80087C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:10:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g21-20020aa787550000b02902db9841d2a1so16428229pfo.15
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=TUsEdGChUY7Suj6JTokQ0KGT3NyTx2sRw/OQwNY6Pp4=;
        b=ICch/pfqovuKqVeR6+16cC5S6YufBZMJg6CIZH+wA2GjAYLn0N3nrrNVdHJCU5Raeo
         9nVjnwzYFVfAygahUFG14Xwk3RVc1o4B3+uq5UkAISiyXIL3kJt5d270zZzJ9YJfKanU
         lAg2reeP5OvKgKOpUeq3uUM1R+LCtaxSCKoPDIn/A8jPIaczhSsx994/YUFYxzaF6ZEe
         L5XRKP3CXaKz9N1IJpAk5p5d5p1hQq8/djLpNYJvpbi6apM+i02ULlYA0PrBSRlxVF5h
         rGIMybbpqmzlSxaYDiknn4Zx/vrrXoi3KNhormczv3hibgGtFYS9WWsuDSLdx3UcJM78
         TrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=TUsEdGChUY7Suj6JTokQ0KGT3NyTx2sRw/OQwNY6Pp4=;
        b=DqgD8fdBnYtR9B2Ce9AyCpKsTjFP/pA8hvUaMDomXRFKnInmdTiyQafQdkHSsBs2kb
         UsrqRH5r7ys0LxSPX4hKrepl6aKg5PcFEIRgASEdZjsi8Sm7FSe/SqpWpZca9NSK+rSS
         HKN0B/VjMdeO9QrshWWPmThRnGjjpaQj8NdgwX6K/YoTZ1f9XO54KHRiq+BrdwMftEUv
         s88lQ+Y2xAwxI9L6gwIFh//fS8Erbyr8CmwcEdReMKkBOFyarjl2Y0Mq1VtwSpvKH+oo
         +eQlTWdncKV9/xM+iiBPLmKEqdoUqCdW4JYEgJWRSUBio5Umlh05oR2Y18CwDwy/ddJi
         z/oQ==
X-Gm-Message-State: AOAM531aS69g2gtBKU/5vzRW1dNy5M3WS7A6mszK+b9z7p5kTLmx9IEg
        xaX7D8HbFql6K/y4WtGVp+28LG34rir383eOvX/D1GunJdTi+8ZKzzzIWq/Uc2gYPfGdaqdVbnL
        4EKzIPEt/GybJhT6QbHSQJXAVLkMgXge/qPj7UH/EyLePFtQzfjhhjMGHCzN40yCmW7miFE1MTA
        ==
X-Google-Smtp-Source: ABdhPJwslC9cswTOdLJvf0nv9sHa2HdFusBpjor7SH3EHJotOSJpV+imrNzT516ok+fFFRGs1mLP+nEXacz57+BKe/c=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:cd8d:2ee1:d1a9:b26c])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90a:4216:: with SMTP id
 o22mr897688pjg.3.1621887009899; Mon, 24 May 2021 13:10:09 -0700 (PDT)
Date:   Mon, 24 May 2021 13:10:07 -0700
In-Reply-To: <20210520210546.4129620-1-emilyshaffer@google.com>
Message-Id: <20210524201007.115124-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v3] tr2: log parent process name
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be useful to tell who invoked Git - was it invoked manually by a
user via CLI or script? By an IDE?  In some cases - like 'repo' tool -
we can influence the source code and set the GIT_TRACE2_PARENT_SID
environment variable from the caller process. In 'repo''s case, that
parent SID is manipulated to include the string "repo", which means we
can positively identify when Git was invoked by 'repo' tool. However,
identifying parents that way requires both that we know which tools
invoke Git and that we have the ability to modify the source code of
those tools. It cannot scale to keep up with the various IDEs and
wrappers which use Git, most of which we don't know about. Learning
which tools and wrappers invoke Git, and how, would give us insight to
decide where to improve Git's usability and performance.

Unfortunately, there's no cross-platform reliable way to gather the name
of the parent process. If procfs is present, we can use that; otherwise
we will need to discover the name another way. However, the process ID
should be sufficient to look up the process name on most platforms, so
that code may be shareable.

Git for Windows gathers similar information and logs it as a "data_json"
event. However, since "data_json" has a variable format, it is difficult
to parse effectively in some languages; instead, let's pursue a
dedicated "cmd_ancestry" event to record information about the ancestry
of the current process and a consistent, parseable way.

Git for Windows also gathers information about more than one parent. In
Linux further ancestry info can be gathered with procfs, but it's
unwieldy to do so. In the interest of later moving Git for Windows
ancestry logging to the 'cmd_ancestry' event, and in the interest of
later adding more ancestry to the Linux implementation - or of adding
this functionality to other platforms which have an easier time walking
the process tree - let's make 'cmd_ancestry' accept an array of
parentage.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Since v2, only some nits fixed - a few brace placements and some update
to the commit message language. Thanks Jeff, Junio, and Randall for
looking through the patch more thoroughly.

This iteration also has passing CI:
https://github.com/nasamuffin/git/actions/runs/872341549

I personally think it's ready to go; Jeff H mentioned adding more
parents but later said there's value in confirming we can get the info
we want from just one parent, first, which matches my intent too. I see
room for additional work, but it can happen later - adding more parents
to the Linux impl if we want, and logging the Windows impl to the same
cmd_ancestry event if we want.

 - Emily



 Makefile                  |  5 ++++
 compat/procinfo.c         | 51 +++++++++++++++++++++++++++++++++++++++
 config.mak.uname          |  1 +
 git-compat-util.h         |  6 +++++
 t/t0210/scrub_normal.perl |  6 +++++
 t/t0211/scrub_perf.perl   |  5 ++++
 t/t0212/parse_events.perl |  5 +++-
 trace2.c                  | 13 ++++++++++
 trace2.h                  | 12 ++++++++-
 trace2/tr2_tgt.h          |  3 +++
 trace2/tr2_tgt_event.c    | 21 ++++++++++++++++
 trace2/tr2_tgt_normal.c   | 19 +++++++++++++++
 trace2/tr2_tgt_perf.c     | 16 ++++++++++++
 13 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100644 compat/procinfo.c

diff --git a/Makefile b/Makefile
index 93664d6714..330e4fa011 100644
--- a/Makefile
+++ b/Makefile
@@ -1889,6 +1889,11 @@ ifneq ($(PROCFS_EXECUTABLE_PATH),)
 	BASIC_CFLAGS += '-DPROCFS_EXECUTABLE_PATH="$(procfs_executable_path_SQ)"'
 endif
 
+ifdef HAVE_PROCFS_LINUX
+	BASIC_CFLAGS += -DHAVE_PROCFS_LINUX
+	COMPAT_OBJS += compat/procinfo.o
+endif
+
 ifdef HAVE_NS_GET_EXECUTABLE_PATH
 	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
 endif
diff --git a/compat/procinfo.c b/compat/procinfo.c
new file mode 100644
index 0000000000..0e92fb8b7c
--- /dev/null
+++ b/compat/procinfo.c
@@ -0,0 +1,51 @@
+#include "cache.h"
+
+#include "strbuf.h"
+#include "trace2.h"
+
+char *get_process_name(int pid)
+{
+#ifdef HAVE_PROCFS_LINUX
+	struct strbuf procfs_path = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	/* try to use procfs if it's present. */
+	strbuf_addf(&procfs_path, "/proc/%d/comm", pid);
+	if (!strbuf_read_file(&out, procfs_path.buf, 0)) {
+		/* All done with file reads, clean up early */
+		strbuf_release(&procfs_path);
+		return strbuf_detach(&out, NULL);
+	}
+#endif
+
+	/* NEEDSWORK: add non-procfs implementations here. */
+	return NULL;
+}
+
+void trace2_collect_process_info(enum trace2_process_info_reason reason)
+{
+	if (!trace2_is_enabled())
+		return;
+
+	/* someday we may want to write something extra here, but not today */
+	if (reason == TRACE2_PROCESS_INFO_EXIT)
+		return;
+
+	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
+		/*
+		 * NEEDSWORK: we could do the entire ptree in an array instead,
+		 * see compat/win32/trace2_win32_process_info.c.
+		 */
+		char *names[2];
+		names[0] = get_process_name(getppid());
+		names[1] = NULL;
+
+		if (!names[0])
+			return;
+
+		trace2_cmd_ancestry((const char**)names);
+
+		free(names[0]);
+	}
+
+	return;
+}
diff --git a/config.mak.uname b/config.mak.uname
index cb443b4e02..7ad110a1d2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -58,6 +58,7 @@ ifeq ($(uname_S),Linux)
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	BASIC_CFLAGS += -DHAVE_SYSINFO
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
+	HAVE_PROCFS_LINUX = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a3..cc7d5d8a2a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1382,4 +1382,10 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 
 void sleep_millisec(int millisec);
 
+/*
+ * Convert PID to process name (as would show in top/task manager). Returns
+ * NULL if unimplemented - be sure to check for NULL at callsite.
+ */
+char *get_process_name(int pid);
+
 #endif
diff --git a/t/t0210/scrub_normal.perl b/t/t0210/scrub_normal.perl
index c65d1a815e..7cc4de392a 100644
--- a/t/t0210/scrub_normal.perl
+++ b/t/t0210/scrub_normal.perl
@@ -42,6 +42,12 @@
 	# so just omit it for testing purposes.
 	# print "cmd_path _EXE_\n";
     }
+    elsif ($line =~ m/^cmd_ancestry/) {
+	# 'cmd_ancestry' is not implemented everywhere, so for portability's
+	# sake, skip it when parsing normal.
+	#
+	# print "$line";
+    }
     else {
 	print "$line";
     }
diff --git a/t/t0211/scrub_perf.perl b/t/t0211/scrub_perf.perl
index 351af7844e..d164b750ff 100644
--- a/t/t0211/scrub_perf.perl
+++ b/t/t0211/scrub_perf.perl
@@ -44,6 +44,11 @@
 	# $tokens[$col_rest] = "_EXE_";
 	goto SKIP_LINE;
     }
+    elsif ($tokens[$col_event] =~ m/cmd_ancestry/) {
+	# 'cmd_ancestry' is platform-specific and not implemented everywhere,
+	# so skip it.
+	goto SKIP_LINE;
+    }
     elsif ($tokens[$col_event] =~ m/child_exit/) {
 	$tokens[$col_rest] =~ s/ pid:\d* / pid:_PID_ /;
     }
diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
index 6584bb5634..b6408560c0 100644
--- a/t/t0212/parse_events.perl
+++ b/t/t0212/parse_events.perl
@@ -132,7 +132,10 @@
 	# just omit it for testing purposes.
 	# $processes->{$sid}->{'path'} = "_EXE_";
     }
-    
+    elsif ($event eq 'cmd_ancestry') {
+	# 'cmd_ancestry' is platform-specific and not implemented everywhere, so
+	# just skip it for testing purposes.
+    }
     elsif ($event eq 'cmd_name') {
 	$processes->{$sid}->{'name'} = $line->{'name'};
 	$processes->{$sid}->{'hierarchy'} = $line->{'hierarchy'};
diff --git a/trace2.c b/trace2.c
index 256120c7fd..b9b154ac44 100644
--- a/trace2.c
+++ b/trace2.c
@@ -260,6 +260,19 @@ void trace2_cmd_path_fl(const char *file, int line, const char *pathname)
 			tgt_j->pfn_command_path_fl(file, line, pathname);
 }
 
+void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	if (!trace2_enabled)
+		return;
+
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_command_ancestry_fl)
+			tgt_j->pfn_command_ancestry_fl(file, line, parent_names);
+}
+
 void trace2_cmd_name_fl(const char *file, int line, const char *name)
 {
 	struct tr2_tgt *tgt_j;
diff --git a/trace2.h b/trace2.h
index ede18c2e06..23743ac62b 100644
--- a/trace2.h
+++ b/trace2.h
@@ -133,6 +133,16 @@ void trace2_cmd_path_fl(const char *file, int line, const char *pathname);
 
 #define trace2_cmd_path(p) trace2_cmd_path_fl(__FILE__, __LINE__, (p))
 
+/*
+ * Emit an 'ancestry' event with the process name of the current process's
+ * parent process.
+ * This gives post-processors a way to determine what invoked the command and
+ * learn more about usage patterns.
+ */
+void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names);
+
+#define trace2_cmd_ancestry(v) trace2_cmd_ancestry_fl(__FILE__, __LINE__, (v))
+
 /*
  * Emit a 'cmd_name' event with the canonical name of the command.
  * This gives post-processors a simple field to identify the command
@@ -492,7 +502,7 @@ enum trace2_process_info_reason {
 	TRACE2_PROCESS_INFO_EXIT,
 };
 
-#if defined(GIT_WINDOWS_NATIVE)
+#if ( defined(GIT_WINDOWS_NATIVE) || defined(HAVE_PROCFS_LINUX) )
 void trace2_collect_process_info(enum trace2_process_info_reason reason);
 #else
 #define trace2_collect_process_info(reason) \
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 7b90469212..1f66fd6573 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -27,6 +27,8 @@ typedef void(tr2_tgt_evt_error_va_fl_t)(const char *file, int line,
 
 typedef void(tr2_tgt_evt_command_path_fl_t)(const char *file, int line,
 					    const char *command_path);
+typedef void(tr2_tgt_evt_command_ancestry_fl_t)(const char *file, int line,
+						const char **parent_names);
 typedef void(tr2_tgt_evt_command_name_fl_t)(const char *file, int line,
 					    const char *name,
 					    const char *hierarchy);
@@ -108,6 +110,7 @@ struct tr2_tgt {
 	tr2_tgt_evt_atexit_t                    *pfn_atexit;
 	tr2_tgt_evt_error_va_fl_t               *pfn_error_va_fl;
 	tr2_tgt_evt_command_path_fl_t           *pfn_command_path_fl;
+	tr2_tgt_evt_command_ancestry_fl_t	*pfn_command_ancestry_fl;
 	tr2_tgt_evt_command_name_fl_t           *pfn_command_name_fl;
 	tr2_tgt_evt_command_mode_fl_t           *pfn_command_mode_fl;
 	tr2_tgt_evt_alias_fl_t                  *pfn_alias_fl;
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 6353e8ad91..578a9a5287 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -261,6 +261,26 @@ static void fn_command_path_fl(const char *file, int line, const char *pathname)
 	jw_release(&jw);
 }
 
+static void fn_command_ancestry_fl(const char *file, int line, const char **parent_names)
+{
+	const char *event_name = "cmd_ancestry";
+	const char *parent_name = NULL;
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_inline_begin_array(&jw, "ancestry");
+
+	while ((parent_name = *parent_names++))
+		jw_array_string(&jw, parent_name);
+
+	jw_end(&jw); /* 'ancestry' array */
+	jw_end(&jw); /* event object */
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 static void fn_command_name_fl(const char *file, int line, const char *name,
 			       const char *hierarchy)
 {
@@ -584,6 +604,7 @@ struct tr2_tgt tr2_tgt_event = {
 	fn_atexit,
 	fn_error_va_fl,
 	fn_command_path_fl,
+	fn_command_ancestry_fl,
 	fn_command_name_fl,
 	fn_command_mode_fl,
 	fn_alias_fl,
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 31b602c171..a5751c8864 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -160,6 +160,24 @@ static void fn_command_path_fl(const char *file, int line, const char *pathname)
 	strbuf_release(&buf_payload);
 }
 
+static void fn_command_ancestry_fl(const char *file, int line, const char **parent_names)
+{
+	const char *parent_name = NULL;
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	/* cmd_ancestry parent <- grandparent <- great-grandparent */
+	strbuf_addstr(&buf_payload, "cmd_ancestry ");
+	while ((parent_name = *parent_names++)) {
+		strbuf_addstr(&buf_payload, parent_name);
+		/* if we'll write another one after this, add a delimiter */
+		if (parent_names && *parent_names)
+			strbuf_addstr(&buf_payload, " <- ");
+	}
+
+	normal_io_write_fl(file, line, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
 static void fn_command_name_fl(const char *file, int line, const char *name,
 			       const char *hierarchy)
 {
@@ -306,6 +324,7 @@ struct tr2_tgt tr2_tgt_normal = {
 	fn_atexit,
 	fn_error_va_fl,
 	fn_command_path_fl,
+	fn_command_ancestry_fl,
 	fn_command_name_fl,
 	fn_command_mode_fl,
 	fn_alias_fl,
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index a8018f18cc..af4d65a0a5 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -253,6 +253,21 @@ static void fn_command_path_fl(const char *file, int line, const char *pathname)
 	strbuf_release(&buf_payload);
 }
 
+static void fn_command_ancestry_fl(const char *file, int line, const char **parent_names)
+{
+	const char *event_name = "cmd_ancestry";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addstr(&buf_payload, "ancestry:[");
+	/* It's not an argv but the rules are basically the same. */
+	sq_append_quote_argv_pretty(&buf_payload, parent_names);
+	strbuf_addch(&buf_payload, ']');
+
+	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL, NULL,
+			 &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
 static void fn_command_name_fl(const char *file, int line, const char *name,
 			       const char *hierarchy)
 {
@@ -532,6 +547,7 @@ struct tr2_tgt tr2_tgt_perf = {
 	fn_atexit,
 	fn_error_va_fl,
 	fn_command_path_fl,
+	fn_command_ancestry_fl,
 	fn_command_name_fl,
 	fn_command_mode_fl,
 	fn_alias_fl,
-- 
2.31.1.818.g46aad6cb9e-goog

