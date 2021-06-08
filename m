Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062C5C48BCD
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0488613B9
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhFHTEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:04:04 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:37799 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhFHTB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 15:01:58 -0400
Received: by mail-yb1-f201.google.com with SMTP id g9-20020a25ae490000b029052f9e5b7d3fso27960024ybe.4
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=VGw1EBav9pzF/Uv2MtV5Zky9niq44hr2EBBBO2aYAvE=;
        b=Ue4Jypxt2OJvjhCmE6e7e5fOZvMu/0VMoRyCAHsjbjAvlREi+IUFyK07yOppR2mjDl
         fGTxVJWMDVcJW5N5TAanW0Lvh9MRi6Aud83ENyJJS+LrOJbiJDRhsXKj7jJBTA0YSYDf
         zI5DZkr8lqHr3P94eu5GZVSfCTah5v2kvTZAxluspbqnio4W4iPewOW0nt/gOkD8t9MM
         j/VX/so4etsFADK40Rv+YkpHhzsmFxoLXltBvHSsInH9Zz5uMLJ3kBo1W6X/tFkPwTzr
         Tahys5qVRrsvQ/r4YIm0Ut/1orGCmmvaC6V1Wg8BQqh00pCGfEfMNufansG081VxSZrS
         AD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=VGw1EBav9pzF/Uv2MtV5Zky9niq44hr2EBBBO2aYAvE=;
        b=qwEj0+LuVR5Zeg+/0kTx1RUFfV7eIvx32HNCAnHH2ek7pxTl93lc2w2Cma/dF/6OFe
         VBaB50kIEW7NQCY7nKQHxa/O1dXkeiH/LfQx5USD7yhHR4hMraz4SJ8z0dm/yUqJvlkb
         bgkBdcmQsu5a5S4TCUeulCAzKrbe6o6uEKJv6KtTU4HoP0C/1eDHUTQyF80aaaNHKeqm
         jcU90HC4GocnLS3HwlbFfAzbm7M4Sh06BXS3LT2w86x8g4gEl9M3BM5Zx64fgPT30Lfk
         mFg02KS92xzPr8Rr1wjfcyuJVexrU7tTxScXwsHEPMzBpCHcOcSLFVCNSK/rTVw4VwDe
         9L4g==
X-Gm-Message-State: AOAM532QtLEU5phXHCPAGF+C0/nwIjWg/B1JausKWY4p9wXDZ4vM5u4E
        j7ov5d4fZma5XK+ItyXJX4R4BC6RsgWMumQ5+eZq1zeL66KSmSloWBBW7KT6OugQDVOjwzc85n5
        /XJmr6n+94A5NHkvF/ne18s7eNiUg/VpVEBqKEJ9DCga4owpoLk5MAuJH2FfMvpsxUkklGjA71A
        ==
X-Google-Smtp-Source: ABdhPJylYiPSCLSeHdd6gDSGr8B4lYezeEWJFdI//9R9/FmHfwPqku8FkHQc+1bSuL7cYr9JDgQvzzmJ2+Rdjep2u0I=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
 (user=emilyshaffer job=sendgmr) by 2002:a25:f50e:: with SMTP id
 a14mr32843377ybe.172.1623178738818; Tue, 08 Jun 2021 11:58:58 -0700 (PDT)
Date:   Tue,  8 Jun 2021 11:58:55 -0700
In-Reply-To: <20210524201007.115124-1-emilyshaffer@google.com>
Message-Id: <20210608185855.668050-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v4] tr2: log parent process name
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

Git for Windows also gathers information about more than one generation
of parent. In Linux further ancestry info can be gathered with procfs,
but it's unwieldy to do so. In the interest of later moving Git for
Windows ancestry logging to the 'cmd_ancestry' event, and in the
interest of later adding more ancestry to the Linux implementation - or
of adding this functionality to other platforms which have an easier
time walking the process tree - let's make 'cmd_ancestry' accept an
array of parentage.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v3:
    
    Junio and Randall suggested ditching "get_process_name(ppid)" as the API to
    implement on various platforms, and I liked the suggestion a lot. So instead,
    I added "get_ancestry_names(strvec *names)".
    
     - Using a strvec instead of a char** makes cleanup easier, since strvec takes
       care of counting the number of strings in the array for us. Otherwise we'd
       need to include size as a return or out-param in get_ancestry_names(), and
       that's what the util class is for, right? :)
     - I made get_ancestry_names() static instead of putting it into
       git-compat-util.h. I think I had put get_process_name() into that header to
       facilitate non-procfs implementations, but compat/procinfo.c doesn't seem to
       me to indicate "procfs only", and if we do need to implement
       get_process_name() somewhere else, it'll be pretty easy to move it.
     - I added a description of "cmd_ancestry" to
       Documentation/technical/api-trace2.txt. I didn't see any user-facing docs to
       update (for example, "git grep cmd_path" produces only that one doc file).
    
    Thanks, all.
    
     - Emily

 Documentation/technical/api-trace2.txt | 14 ++++++
 Makefile                               |  5 +++
 compat/procinfo.c                      | 61 ++++++++++++++++++++++++++
 config.mak.uname                       |  1 +
 t/t0210/scrub_normal.perl              |  6 +++
 t/t0211/scrub_perf.perl                |  5 +++
 t/t0212/parse_events.perl              |  5 ++-
 trace2.c                               | 13 ++++++
 trace2.h                               | 12 ++++-
 trace2/tr2_tgt.h                       |  3 ++
 trace2/tr2_tgt_event.c                 | 21 +++++++++
 trace2/tr2_tgt_normal.c                | 19 ++++++++
 trace2/tr2_tgt_perf.c                  | 16 +++++++
 13 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 compat/procinfo.c

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 3f52f981a2..8a0b360a0e 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -493,6 +493,20 @@ about specific error arguments.
 }
 ------------
 
+`"cmd_ancestry"`::
+	This event contains the text command name for the parent (and earlier
+	generations of parents) of the current process, in an array ordered from
+	nearest parent to furthest great-grandparent. It may not be implemented
+	on all platforms.
++
+------------
+{
+	"event":"cmd_ancestry",
+	...
+	"ancestry":["bash","tmux: server","systemd"]
+}
+------------
+
 `"cmd_name"`::
 	This event contains the command name for this git process
 	and the hierarchy of commands from parent git processes.
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
index 0000000000..9417c3aa54
--- /dev/null
+++ b/compat/procinfo.c
@@ -0,0 +1,61 @@
+#include "cache.h"
+
+#include "strbuf.h"
+#include "strvec.h"
+#include "trace2.h"
+
+static void get_ancestry_names(struct strvec *names)
+{
+#ifdef HAVE_PROCFS_LINUX
+	/*
+	 * NEEDSWORK: We could gather the entire pstree into an array to match
+	 * functionality with compat/win32/trace2_win32_process_info.c.
+	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
+	 * gather the immediate parent name which is readily accessible from
+	 * /proc/$(getppid())/comm.
+	 */
+	struct strbuf procfs_path = STRBUF_INIT;
+	struct strbuf name = STRBUF_INIT;
+
+	/* try to use procfs if it's present. */
+	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
+	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
+		strbuf_release(&procfs_path);
+		strvec_push(names, strbuf_detach(&name, NULL));
+	}
+
+	return;
+#endif
+	/* NEEDSWORK: add non-procfs-linux implementations here */
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
+		struct strvec names = STRVEC_INIT;
+
+		get_ancestry_names(&names);
+
+		if (names.nr == 0) {
+			strvec_clear(&names);
+			return;
+		}
+
+		trace2_cmd_ancestry(names.v);
+
+		strvec_clear(&names);
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
2.32.0.rc1.229.g3e70b5a671-goog

