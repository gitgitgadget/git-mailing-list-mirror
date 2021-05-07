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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5363FC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 00:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DE961059
	for <git@archiver.kernel.org>; Fri,  7 May 2021 00:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhEGAaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 20:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhEGAaO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 20:30:14 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F15C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 17:29:15 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h4-20020ac858440000b029019d657b9f21so4660269qth.9
        for <git@vger.kernel.org>; Thu, 06 May 2021 17:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Z6TV9hnun1Py3vRr/+2czRyRNNAqodILPA/Zmm8Y+LM=;
        b=nFPOJSe7jYpwAmKakLTFIBPK1fACzrUJIoKr9KLfGPxRLcek/q5eS3xPhuUEyQG9va
         xJQ7XMkB1rVOrDcZNuAU1+PrraiLCJm9KxH+owAboB0UfEW8pivONwPvaoYtcZvnb1AP
         blQQRHMFrtHKFCnnCGPwQbuniXLKBB/Kk+weo/sGR7maHx48c584RKuAzlGdFQiNrnai
         ygu0IlBidXb2Pi88monIA7V9sqYiJyy6D+Q5TB3QKcl36ilYreE58ZD1nIvZE++di2aa
         bcaBbyBA0WxJNERHPa/Wcw0eckgWwDvZcZBOfnlfsYlE8eTsk3TgtC+mY08wrTdmxdou
         P02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Z6TV9hnun1Py3vRr/+2czRyRNNAqodILPA/Zmm8Y+LM=;
        b=DgcTGZPS1I9qPbwvCvUt7V7Tn+axhlBEu51EY19jm/sByI9OMo62j/L3BWVtvqs0Z/
         /SuQISxhG+pFrvDhc84yu0daPnQUteftvARZaPxE2tXzIGOpZ8PkMy9lk8nPBvYXPbPC
         Wuc/mhNubCfnFuomAzWWXCzf4qurv2rYnCqcXR7/L0MwGZqHBH1KdKvlUGk67J4esOTB
         91gVYBDX5iZ/W4qsRMqOcLQXQ8D+R4tjcvUzcro2S8g+/WXaAJ4fy3GdG4XZgOU88Lsy
         YUMhWw6BxmZm/ZC+yE6M8UGFF/LamFk6mxkRy74HZ4hvmWiRSueLOwYSslyIKKrokB1u
         JjhA==
X-Gm-Message-State: AOAM533vGczm9VwLGg6ReUSo0Z3M9psr+VcauLn5TLhHSyEh/UvanogR
        vOv8+qQ7p7OQKNhsYc0UEX9LG1YmAH6kqV+ZRuzrvNHyEHAf4++MfOcm7AO2Wt1UVdSeIiWWW6A
        y7BZAGR0Pm/KGp/e10iNkIEt1dYYcYDC9xolYHNLLeh+tByb9DaoMOWZy9PARKmOpy4R29nwFzA
        ==
X-Google-Smtp-Source: ABdhPJwTvP5DxuyHaDP3pAgrV0cW+6KLjDML96X7mH2p3Rfrzl2/dvXH9n0zFWWwao+gJPW0SpQprSWrSknKffickcE=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:d0e9:239c:84a2:f593])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:46a9:: with SMTP id
 br9mr7376884qvb.35.1620347354452; Thu, 06 May 2021 17:29:14 -0700 (PDT)
Date:   Thu,  6 May 2021 17:29:08 -0700
Message-Id: <20210507002908.1495061-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] tr2: log parent process name
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be useful to tell who invoked Git - was it invoked manually by a
user via CLI or script? By an IDE? Knowing where the Git invocation came
from can help with debugging to isolate where the problem came from.

Unfortunately, there's no cross-platform reliable way to gather the name
of the parent process. If procfs is present, we can use that; otherwise
we will need to discover the name another way. However, the process ID
should be sufficient regardless of platform.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
We briefly discussed hiding this behind a config, internally. However, I
wanted to include the parent name alongside the cmd_start event, which
happens very early (maybe before config gathering?).

Maybe it's better to log the parent_name as its own event, since it
shouldn't change over the lifetime of the process?

procfs is very non-portable, though - I think this won't even work on
MacOS. So I'm curious if anybody has better suggestions for how to do
this.

 - Emily

 Makefile                  |  1 +
 compat/procinfo.c         | 19 +++++++++++++++++++
 git-compat-util.h         |  6 ++++++
 t/t0212-trace2-event.sh   |  8 ++++++++
 t/t0212/parse_events.perl |  1 +
 trace2/tr2_tgt_event.c    |  3 +++
 6 files changed, 38 insertions(+)
 create mode 100644 compat/procinfo.c

diff --git a/Makefile b/Makefile
index 93664d6714..19f5189c6f 100644
--- a/Makefile
+++ b/Makefile
@@ -855,6 +855,7 @@ LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
 LIB_OBJS += commit.o
 LIB_OBJS += compat/obstack.o
+LIB_OBJS += compat/procinfo.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
 LIB_OBJS += connect.o
diff --git a/compat/procinfo.c b/compat/procinfo.c
new file mode 100644
index 0000000000..7f4c8dd284
--- /dev/null
+++ b/compat/procinfo.c
@@ -0,0 +1,19 @@
+#include "git-compat-util.h"
+
+#include "strbuf.h"
+
+char *get_process_name(int pid)
+{
+	struct strbuf procfs_path = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	/* try to use procfs if it's present. */
+	strbuf_addf(&procfs_path, "/proc/%d/cmdline", pid);
+	if (strbuf_read_file(&out, procfs_path.buf, 0) > 0)
+	{
+		strbuf_release(&procfs_path);
+		return strbuf_detach(&out, NULL);
+	}
+
+	/* NEEDSWORK: add non-procfs implementations here. */
+	return NULL;
+}
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
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 1529155cf0..3a2a8a5b5f 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -61,6 +61,7 @@ test_expect_success JSON_PP 'event stream, error event' '
 	|    "exit_code":0,
 	|    "hierarchy":"trace2",
 	|    "name":"trace2",
+	|    "parent_name":"/bin/sh",
 	|    "version":"$V"
 	|  }
 	|};
@@ -115,6 +116,7 @@ test_expect_success JSON_PP 'event stream, return code 0' '
 	|    "exit_code":0,
 	|    "hierarchy":"trace2",
 	|    "name":"trace2",
+	|    "parent_name":"/bin/sh",
 	|    "version":"$V"
 	|  },
 	|  "_SID0_/_SID1_":{
@@ -143,6 +145,7 @@ test_expect_success JSON_PP 'event stream, return code 0' '
 	|    "exit_code":0,
 	|    "hierarchy":"trace2/trace2",
 	|    "name":"trace2",
+	|    "parent_name":"test-tool",
 	|    "version":"$V"
 	|  },
 	|  "_SID0_/_SID1_/_SID2_":{
@@ -155,6 +158,7 @@ test_expect_success JSON_PP 'event stream, return code 0' '
 	|    "exit_code":0,
 	|    "hierarchy":"trace2/trace2/trace2",
 	|    "name":"trace2",
+	|    "parent_name":"$TEST_DIRECTORY/../t/helper//test-tool",
 	|    "version":"$V"
 	|  }
 	|};
@@ -192,6 +196,7 @@ test_expect_success JSON_PP 'event stream, list config' '
 	|        "value":"hello world"
 	|      }
 	|    ],
+	|    "parent_name":"/bin/sh",
 	|    "version":"$V"
 	|  }
 	|};
@@ -229,6 +234,7 @@ test_expect_success JSON_PP 'event stream, list env vars' '
 	|        "value":"hello world"
 	|      }
 	|    ],
+	|    "parent_name":"/bin/sh",
 	|    "version":"$V"
 	|  }
 	|};
@@ -263,6 +269,7 @@ test_expect_success JSON_PP 'basic trace2_data' '
 	|    "exit_code":0,
 	|    "hierarchy":"trace2",
 	|    "name":"trace2",
+	|    "parent_name":"/bin/sh",
 	|    "version":"$V"
 	|  }
 	|};
@@ -295,6 +302,7 @@ test_expect_success JSON_PP 'using global config, event stream, error event' '
 	|    "exit_code":0,
 	|    "hierarchy":"trace2",
 	|    "name":"trace2",
+	|    "parent_name":"/bin/sh",
 	|    "version":"$V"
 	|  }
 	|};
diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
index 6584bb5634..dd8b1be844 100644
--- a/t/t0212/parse_events.perl
+++ b/t/t0212/parse_events.perl
@@ -99,6 +99,7 @@
     }
 
     elsif ($event eq 'start') {
+	$processes->{$sid}->{'parent_name'} = $line->{'parent_name'};
 	$processes->{$sid}->{'argv'} = $line->{'argv'};
 	$processes->{$sid}->{'argv'}[0] = "_EXE_";
     }
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 6353e8ad91..d258d5807c 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -145,10 +145,12 @@ static void fn_start_fl(const char *file, int line,
 	const char *event_name = "start";
 	struct json_writer jw = JSON_WRITER_INIT;
 	double t_abs = (double)us_elapsed_absolute / 1000000.0;
+	char *parent_name = get_process_name(getppid());
 
 	jw_object_begin(&jw, 0);
 	event_fmt_prepare(event_name, file, line, NULL, &jw);
 	jw_object_double(&jw, "t_abs", 6, t_abs);
+	jw_object_string(&jw, "parent_name", parent_name ? parent_name : NULL );
 	jw_object_inline_begin_array(&jw, "argv");
 	jw_array_argv(&jw, argv);
 	jw_end(&jw);
@@ -156,6 +158,7 @@ static void fn_start_fl(const char *file, int line,
 
 	tr2_dst_write_line(&tr2dst_event, &jw.json);
 	jw_release(&jw);
+	free(parent_name);
 }
 
 static void fn_exit_fl(const char *file, int line, uint64_t us_elapsed_absolute,
-- 
2.31.1.607.g51e8a6a459-goog

