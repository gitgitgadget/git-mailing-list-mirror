Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D26C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F6B61028
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhETVHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhETVHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:07:19 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96364C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:05:57 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id s11-20020ac8758b0000b029020e731296abso2646980qtq.22
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=xZEgOADpVvZPdi975laFylUMYLlZ3OH5400vJAkaoeo=;
        b=Up1RqQApvmybUmBVnWLvw2eYpkrZGiSTJnxa38L5jESdcS9JDI1knx05zYt3GCZX1z
         vzVyaEEilwaqRAHzVLqG72ia0xHaN6xD4pXs4o+nnu6nCUpRN8ifWyIA9Ay87CWH2Qlx
         2XCKaZNz0sWVl5GaqabKVTSFZiehzy5Zn4uj6JJy0zPtlNZldvm8Hakzc+xNvTT9heCc
         y6EQBGy69dmufXN5qF38i1MgWeSI/8Hvoy2VBSihzF7JyNFakvWXj+M1+5IomgodMrgy
         w5rnVmFubDlRw6NtSlc2Q3UyOK9cPl4OP6YFOyUVAHOMXEQsVgefwRg6KkJZBh+6W8wv
         7NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=xZEgOADpVvZPdi975laFylUMYLlZ3OH5400vJAkaoeo=;
        b=ZO5XtqgEqBkZcYSm1VA4lKnVoYbcIe1+Hwk6sy4PmkCi6Bzg9/n7mQL0P9WiOdLMD1
         P6xpArpxdJkpxJX5YJvwMu/NRxBAb5eqfpSsshoqt97B00AAHOHp0bKcz36YVR97oFF6
         xAWyvxo84Lcryrkcckonl0XcY48BgkF3nPRvf2JoX2h8BZXxsJ3GnWfC2cUy/je78lML
         YyPVtkLPGnJwIXI19RU87WkJomm3UCIZHPx0+I5gtCd3fdnhis4KcxVz06lwDij7sw1S
         zOSmJRrZDlOTSW2WAnqoyqi0mPwbMCBIcPrDiXYtwUl29ylX4J799DuUSXblUsVe7W8T
         DZKw==
X-Gm-Message-State: AOAM5325UttmbUqjmizDQYbIB9EK07HEGhvv1kKCytlo4oQ3XTmfEGMq
        0sPHDVw0cxYPM5VLwYSxUtdB5Ys1t8xbH7eJilBmMjInw97By11XcAVSFAFwcZ7bDBo6brCgY5B
        Rixk9F7ujtN9my6ZyJyKQTcGLYxvwdoCP74SqMoOSlQ0ZrMcA7Ap2ZSbmYb/1TFkg2zL3B0GvuQ
        ==
X-Google-Smtp-Source: ABdhPJy4yylXuVhkeRC+dah+0yDR96fbjqahT155FL3DPsWw8QEpCHeyBvbZ7UWK3Vz97jE2eyHR2U3GP/LOg40u8w4=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:8357:c9e5:a153:d09d])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:56a8:: with SMTP id
 bd8mr8164763qvb.9.1621544756620; Thu, 20 May 2021 14:05:56 -0700 (PDT)
Date:   Thu, 20 May 2021 14:05:46 -0700
In-Reply-To: <20210507002908.1495061-1-emilyshaffer@google.com>
Message-Id: <20210520210546.4129620-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2] tr2: log parent process name
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
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
should be sufficient regardless of platform.

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

Hi folks, the comments I received in v1 were of two varieties:
1) "There are better ways to make this platform-safe", and
2) "Your commit message doesn't convince me".
Since I sent v1, though, I also learned a little more about procfs, and
about the trace2 structure overall, so there are some pretty significant
differences from v1:

- I took a look at Jeff H's advice on using a "data_json" event to log
  this and decided it would be a little more flexible to add a new event
  instead. If we want, it'd be feasible to then shoehorn the GfW parent
  tree stuff into this new event too. Doing it this way is definitely
  easier to parse for Google's trace analysis system (which for now
  completely skips "data_json" as it's polymorphic), and also - I think
  - means that we can add more fields later on if we need to (thread
  info, different fields than just /proc/n/comm like exec path, argv,
  whatever).
- Jonathan N also pointed out to me that /proc/n/comm exists, and logs
  the "command name" - excluding argv, excluding path, etc. It seems
  like this is a little more safe about excluding personal information
  from the traces which take the form of "myscript.sh
  --password=hunter2", but would still be worrisome for something like
  "mysupersecretproject.sh". I'm not sure whether that means we still
  want to guard it with a config flag, though.
- I also added a lot to the commit message; hopefully it's not too
  rambly, but I hoped to explain why just setting GIT_TRACE2_PARENT_SID
  wasn't going to cut it.
- As for testing, I followed the lead of GfW's parentage info - "this
  isn't portable so writing tests for it will suck, just scrub it from
  the tests". Maybe it makes sense to do some more
  platform-specific-ness in the test suite instead? I wasn't sure.

Thanks, all.
 - Emily

 Makefile                  |  5 ++++
 compat/procinfo.c         | 53 +++++++++++++++++++++++++++++++++++++++
 config.mak.uname          |  1 +
 git-compat-util.h         |  6 +++++
 t/t0210/scrub_normal.perl |  6 +++++
 t/t0211/scrub_perf.perl   |  5 ++++
 t/t0212/parse_events.perl |  5 +++-
 trace2.c                  | 13 ++++++++++
 trace2.h                  | 12 ++++++++-
 trace2/tr2_tgt.h          |  3 +++
 trace2/tr2_tgt_event.c    | 21 ++++++++++++++++
 trace2/tr2_tgt_normal.c   | 19 ++++++++++++++
 trace2/tr2_tgt_perf.c     | 16 ++++++++++++
 13 files changed, 163 insertions(+), 2 deletions(-)
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
index 0000000000..523600673f
--- /dev/null
+++ b/compat/procinfo.c
@@ -0,0 +1,53 @@
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
+	if (!strbuf_read_file(&out, procfs_path.buf, 0))
+	{
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
+	if (reason == TRACE2_PROCESS_INFO_STARTUP)
+	{
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

