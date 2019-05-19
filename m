Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413991F461
	for <e@80x24.org>; Sun, 19 May 2019 17:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfESRoz (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 13:44:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43836 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfESRoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 13:44:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so11971736wro.10
        for <git@vger.kernel.org>; Sun, 19 May 2019 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eX1HtZql7D2Qq9Y4PkDQH3K8OiGKCq7jwPU3kGpIAeI=;
        b=kHwHRQslCsEOaQZObZwrKcogE5GpBgCfwO9ZcblghuBNVWBvuKXtK8v07+vWonQzuQ
         oZlH8OzR2UzZhEysKamDugMybVyfT2diWhtfDvq2IzULVBJ36vAm61d2vogku+aWOvJo
         i5Zn9NwAam3wvtYiDh0SlN+h91yxgOH2FXcKPp/fAvFTkjwtmH8oBKosKrwuzebNGuOy
         SlGWQzzvDSbc6Kkp8M1JdPR6xVsIAdAs+Ha283k5GQxWbTCTM4exjyA+mHE58jkyStwV
         ucRhWv0jEnRE8DS+UUwhMzrv+nmbmhTnUulXTnhHfLzjtSeO3fyuEeKOIdytI+PIQCMx
         uPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eX1HtZql7D2Qq9Y4PkDQH3K8OiGKCq7jwPU3kGpIAeI=;
        b=UchNKL2O8jnTCIYMMrxbNg/0B8EEwoST6m8kHFgf0iqG3jnGz27smZfQHJe5qHI/KU
         X9RR2kKN0Pc7Yayvl6H67TFQJNmghWj/45/O7qbAkKPbRUZKAvTypRsRt5pbKaE/aRIU
         Z6ta9EIRpT+YLdRZHnfUZ5bCVtM4fX5bVfYQMtF8+k8djLRzHfqQiFltvhesWefXs7e0
         4028t4zZWmxUMKWYZ7nG9sbD4UqPONk9siJfJhfd8n1jq0s2M8sgIWMUsettudBxtKrF
         rtcsmYUBR8NX8y2ZWap84ptIznOQUOQ7ofoUDnAJP8wbXlo/Yl5Fav084/pXCLg4Q++b
         ZdMA==
X-Gm-Message-State: APjAAAUeri4QbMH5QZQsm1erUzpBmBge3uY0h1JTWzSDHkyRM0dwP2bS
        oCd5WR9B01sRKeQHiCmmjdItsZUB
X-Google-Smtp-Source: APXvYqweMqnCar12t2XNapXAhE9CQF3Pz3wkc5krpHfXoL2BlwKU862E5FoLYUM2y7Wgl8z7bn5vPA==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr24423838wrm.153.1558276993246;
        Sun, 19 May 2019 07:43:13 -0700 (PDT)
Received: from localhost.localdomain (x4db573a6.dyn.telefonica.de. [77.181.115.166])
        by smtp.gmail.com with ESMTPSA id z21sm1782343wmf.25.2019.05.19.07.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 07:43:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] trace2: rename environment variables to GIT_TRACE2*
Date:   Sun, 19 May 2019 16:43:08 +0200
Message-Id: <20190519144309.9597-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.424.g15834b9bb1
In-Reply-To: <20190510211502.GS14763@szeder.dev>
References: <20190510211502.GS14763@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For an environment variable that is supposed to be set by users, the
GIT_TR2* env vars are just too unclear, inconsistent, and ugly.

Most of the established GIT_* environment variables don't use
abbreviations, and in case of the few that do (GIT_DIR,
GIT_COMMON_DIR, GIT_DIFF_OPTS) it's quite obvious what the
abbreviations (DIR and OPTS) stand for.  But what does TR stand for?
Track, traditional, trailer, transaction, transfer, transformation,
transition, translation, transplant, transport, traversal, tree,
trigger, truncate, trust, or ...?!

The trace2 facility, as the '2' suffix in its name suggests, is
supposed to eventually supercede Git's original trace facility.  It's
reasonable to expect that the corresponding environment variables
follow suit, and after the original GIT_TRACE variables they are
called GIT_TRACE2; there is no such thing is 'GIT_TR'.

All trace2-specific config variables are, very sensibly, in the
'trace2' section, not in 'tr2'.

OTOH, we don't gain anything at all by omitting the last three
characters of "trace" from the names of these environment variables.

So let's rename all GIT_TR2* environment variables to GIT_TRACE2*,
before they make their way into a stable release.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

 Documentation/config/trace2.txt        | 18 +++++-----
 Documentation/git.txt                  | 14 ++++----
 Documentation/technical/api-trace2.txt | 46 +++++++++++++-------------
 t/t0001-init.sh                        |  2 +-
 t/t0210-trace2-normal.sh               | 24 +++++++-------
 t/t0211-trace2-perf.sh                 | 20 +++++------
 t/t0212-trace2-event.sh                | 16 ++++-----
 t/t0212/parse_events.perl              |  2 +-
 trace2.h                               |  2 +-
 trace2/tr2_cmd_name.c                  |  2 +-
 trace2/tr2_sid.c                       |  2 +-
 trace2/tr2_sysenv.c                    | 20 +++++------
 trace2/tr2_sysenv.h                    |  2 +-
 13 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
index a5f409c1c1..2edbfb02fe 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -4,17 +4,17 @@ command line arguments are not respected.
 
 trace2.normalTarget::
 	This variable controls the normal target destination.
-	It may be overridden by the `GIT_TR2` environment variable.
+	It may be overridden by the `GIT_TRACE2` environment variable.
 	The following table shows possible values.
 
 trace2.perfTarget::
 	This variable controls the performance target destination.
-	It may be overridden by the `GIT_TR2_PERF` environment variable.
+	It may be overridden by the `GIT_TRACE2_PERF` environment variable.
 	The following table shows possible values.
 
 trace2.eventTarget::
 	This variable controls the event target destination.
-	It may be overridden by the `GIT_TR2_EVENT` environment variable.
+	It may be overridden by the `GIT_TRACE2_EVENT` environment variable.
 	The following table shows possible values.
 +
 include::../trace2-target-values.txt[]
@@ -22,22 +22,22 @@ include::../trace2-target-values.txt[]
 trace2.normalBrief::
 	Boolean.  When true `time`, `filename`, and `line` fields are
 	omitted from normal output.  May be overridden by the
-	`GIT_TR2_BRIEF` environment variable.  Defaults to false.
+	`GIT_TRACE2_BRIEF` environment variable.  Defaults to false.
 
 trace2.perfBrief::
 	Boolean.  When true `time`, `filename`, and `line` fields are
 	omitted from PERF output.  May be overridden by the
-	`GIT_TR2_PERF_BRIEF` environment variable.  Defaults to false.
+	`GIT_TRACE2_PERF_BRIEF` environment variable.  Defaults to false.
 
 trace2.eventBrief::
 	Boolean.  When true `time`, `filename`, and `line` fields are
 	omitted from event output.  May be overridden by the
-	`GIT_TR2_EVENT_BRIEF` environment variable.  Defaults to false.
+	`GIT_TRACE2_EVENT_BRIEF` environment variable.  Defaults to false.
 
 trace2.eventNesting::
 	Integer.  Specifies desired depth of nested regions in the
 	event output.  Regions deeper than this value will be
-	omitted.  May be overridden by the `GIT_TR2_EVENT_NESTING`
+	omitted.  May be overridden by the `GIT_TRACE2_EVENT_NESTING`
 	environment variable.  Defaults to 2.
 
 trace2.configParams::
@@ -45,7 +45,7 @@ trace2.configParams::
 	settings that should be recorded in the trace2 output.
 	For example, `core.*,remote.*.url` would cause the trace2
 	output to contain events listing each configured remote.
-	May be overridden by the `GIT_TR2_CONFIG_PARAMS` environment
+	May be overridden by the `GIT_TRACE2_CONFIG_PARAMS` environment
 	variable.  Unset by default.
 
 trace2.destinationDebug::
@@ -53,4 +53,4 @@ trace2.destinationDebug::
 	trace target destination cannot be opened for writing.
 	By default, these errors are suppressed and tracing is
 	silently disabled.  May be overridden by the
-	`GIT_TR2_DST_DEBUG` environment variable.
+	`GIT_TRACE2_DST_DEBUG` environment variable.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 72adfcc5e2..fcf81e3acf 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -660,23 +660,23 @@ of clones and fetches.
 	When a curl trace is enabled (see `GIT_TRACE_CURL` above), do not dump
 	data (that is, only dump info lines and headers).
 
-`GIT_TR2`::
+`GIT_TRACE2`::
 	Enables more detailed trace messages from the "trace2" library.
-	Output from `GIT_TR2` is a simple text-based format for human
+	Output from `GIT_TRACE2` is a simple text-based format for human
 	readability.
 +
-The `GIT_TR2` variables can take many values. Any value available to
-the `GIT_TRACE` variables is also available to `GIT_TR2`. The `GIT_TR2`
+The `GIT_TRACE2` variables can take many values. Any value available to
+the `GIT_TRACE` variables is also available to `GIT_TRACE2`. The `GIT_TRACE2`
 variables can also specify a Unix Domain Socket. See
 link:technical/api-trace2.html[Trace2 documentation] for full details.
 
-`GIT_TR2_EVENT`::
+`GIT_TRACE2_EVENT`::
 	This setting writes a JSON-based format that is suited for machine
 	interpretation. See link:technical/api-trace2.html[Trace2 documentation]
 	for full details.
 
-`GIT_TR2_PERF`::
-	In addition to the text-based messages available in `GIT_TR2`, this
+`GIT_TRACE2_PERF`::
+	In addition to the text-based messages available in `GIT_TRACE2`, this
 	setting writes a column-based format for understanding nesting
 	regions. See link:technical/api-trace2.html[Trace2 documentation]
 	for full details.
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 9e585b8e79..23c3cc7a37 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -23,7 +23,7 @@ formats in the future.  This might be used to define a binary format,
 for example.
 
 Trace2 is controlled using `trace2.*` config values in the system and
-global config files and `GIT_TR2*` environment variables.  Trace2 does
+global config files and `GIT_TRACE2*` environment variables.  Trace2 does
 not read from repo local or worktree config files or respect `-c`
 command line config settings.
 
@@ -42,7 +42,7 @@ config setting.
 For example
 
 ------------
-$ export GIT_TR2=~/log.normal
+$ export GIT_TRACE2=~/log.normal
 $ git version
 git version 2.20.1.155.g426c96fcdb
 ------------
@@ -71,13 +71,13 @@ $ cat ~/log.normal
 The performance format target (PERF) is a column-based format to
 replace GIT_TRACE_PERFORMANCE and is suitable for development and
 testing, possibly to complement tools like gprof.  This format is
-enabled with the `GIT_TR2_PERF` environment variable or the
+enabled with the `GIT_TRACE2_PERF` environment variable or the
 `trace2.perfTarget` system or global config setting.
 
 For example
 
 ------------
-$ export GIT_TR2_PERF=~/log.perf
+$ export GIT_TRACE2_PERF=~/log.perf
 $ git version
 git version 2.20.1.155.g426c96fcdb
 ------------
@@ -104,14 +104,14 @@ $ cat ~/log.perf
 === The Event Format Target
 
 The event format target is a JSON-based format of event data suitable
-for telemetry analysis.  This format is enabled with the `GIT_TR2_EVENT`
+for telemetry analysis.  This format is enabled with the `GIT_TRACE2_EVENT`
 environment variable or the `trace2.eventTarget` system or global config
 setting.
 
 For example
 
 ------------
-$ export GIT_TR2_EVENT=~/log.event
+$ export GIT_TRACE2_EVENT=~/log.event
 $ git version
 git version 2.20.1.155.g426c96fcdb
 ------------
@@ -273,7 +273,7 @@ significantly affects program performance or behavior, such as
 	Emits a "def_param" messages for "important" configuration
 	settings.
 +
-The environment variable `GIT_TR2_CONFIG_PARAMS` or the `trace2.configParams`
+The environment variable `GIT_TRACE2_CONFIG_PARAMS` or the `trace2.configParams`
 config value can be set to a
 list of patterns of important configuration settings, for example:
 `core.*,remote.*.url`.  This function will iterate over all config
@@ -465,7 +465,7 @@ Events are written as lines of the form:
 Note that this may contain embedded LF or CRLF characters that are
 not escaped, so the event may spill across multiple lines.
 
-If `GIT_TR2_BRIEF` or `trace2.normalBrief` is true, the `time`, `filename`,
+If `GIT_TRACE2_BRIEF` or `trace2.normalBrief` is true, the `time`, `filename`,
 and `line` fields are omitted.
 
 This target is intended to be more of a summary (like GIT_TRACE) and
@@ -533,7 +533,7 @@ This field is in anticipation of in-proc submodules in the future.
 15:33:33.532712 wt-status.c:2331                  | d0 | main                     | region_leave | r1  |  0.127568 |  0.001504 | status     | label:print
 ------------
 
-If `GIT_TR2_PERF_BRIEF` or `trace2.perfBrief` is true, the `time`, `file`,
+If `GIT_TRACE2_PERF_BRIEF` or `trace2.perfBrief` is true, the `time`, `file`,
 and `line` fields are omitted.
 
 ------------
@@ -598,7 +598,7 @@ The following key/value pairs are common to all events:
 `"repo":<repo-id>`::
 	when present, is the integer repo-id as described previously.
 
-If `GIT_TR2_EVENT_BRIEF` or `trace2.eventBrief` is true, the `file`
+If `GIT_TRACE2_EVENT_BRIEF` or `trace2.eventBrief` is true, the `file`
 and `line` fields are omitted from all events and the `time` field is
 only present on the "start" and "atexit" events.
 
@@ -911,7 +911,7 @@ visited.
 The `category` field may be used in a future enhancement to
 do category-based filtering.
 +
-`GIT_TR2_EVENT_NESTING` or `trace2.eventNesting` can be used to
+`GIT_TRACE2_EVENT_NESTING` or `trace2.eventNesting` can be used to
 filter deeply nested regions and data events.  It defaults to "2".
 
 `"region_leave"`::
@@ -1039,8 +1039,8 @@ rev-list, and gc.  This example also shows that fetch took
 5.199 seconds and of that 4.932 was in ssh.
 +
 ----------------
-$ export GIT_TR2_BRIEF=1
-$ export GIT_TR2=~/log.normal
+$ export GIT_TRACE2_BRIEF=1
+$ export GIT_TRACE2=~/log.normal
 $ git fetch origin
 ...
 ----------------
@@ -1075,8 +1075,8 @@ its name as "gc", it also reports the hierarchy as "fetch/gc".
 indented for clarity.)
 +
 ----------------
-$ export GIT_TR2_BRIEF=1
-$ export GIT_TR2=~/log.normal
+$ export GIT_TRACE2_BRIEF=1
+$ export GIT_TRACE2=~/log.normal
 $ git fetch origin
 ...
 ----------------
@@ -1134,8 +1134,8 @@ In this example, scanning for untracked files ran from +0.012568 to
 +0.027149 (since the process started) and took 0.014581 seconds.
 +
 ----------------
-$ export GIT_TR2_PERF_BRIEF=1
-$ export GIT_TR2_PERF=~/log.perf
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
 $ git status
 ...
 
@@ -1180,8 +1180,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 We can further investigate the time spent scanning for untracked files.
 +
 ----------------
-$ export GIT_TR2_PERF_BRIEF=1
-$ export GIT_TR2_PERF=~/log.perf
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
 $ git status
 ...
 $ cat ~/log.perf
@@ -1236,8 +1236,8 @@ int read_index_from(struct index_state *istate, const char *path,
 This example shows that the index contained 3552 entries.
 +
 ----------------
-$ export GIT_TR2_PERF_BRIEF=1
-$ export GIT_TR2_PERF=~/log.perf
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
 $ git status
 ...
 $ cat ~/log.perf
@@ -1310,8 +1310,8 @@ Data events are tagged with the active thread name.  They are used
 to report the per-thread parameters.
 +
 ----------------
-$ export GIT_TR2_PERF_BRIEF=1
-$ export GIT_TR2_PERF=~/log.perf
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
 $ git status
 ...
 $ cat ~/log.perf
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 1f462204ea..77a224aafb 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -93,7 +93,7 @@ test_expect_success 'No extra GIT_* on alias scripts' '
 		sed -n \
 			-e "/^GIT_PREFIX=/d" \
 			-e "/^GIT_TEXTDOMAINDIR=/d" \
-			-e "/^GIT_TR2_PARENT/d" \
+			-e "/^GIT_TRACE2_PARENT/d" \
 			-e "/^GIT_/s/=.*//p" |
 		sort
 	EOF
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 71194a3623..ce7574edb1 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -4,9 +4,9 @@ test_description='test trace2 facility (normal target)'
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
-sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-sane_unset GIT_TR2_BRIEF
-sane_unset GIT_TR2_CONFIG_PARAMS
+sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
+sane_unset GIT_TRACE2_BRIEF
+sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 # Add t/helper directory to PATH so that we can use a relative
 # path to run nested instances of test-tool.exe (see 004child).
@@ -27,12 +27,12 @@ V=$(git version | sed -e 's/^git version //') && export V
 # to whatever filtering that target decides to do).
 # This script tests the normal target in isolation.
 #
-# Defer setting GIT_TR2 until the actual command line we want to test
+# Defer setting GIT_TRACE2 until the actual command line we want to test
 # because hidden git and test-tool commands run by the test harness
 # can contaminate our output.
 
 # Enable "brief" feature which turns off "<clock> <file>:<line> " prefix.
-GIT_TR2_BRIEF=1 && export GIT_TR2_BRIEF
+GIT_TRACE2_BRIEF=1 && export GIT_TRACE2_BRIEF
 
 # Basic tests of the trace2 normal stream.  Since this stream is used
 # primarily with printf-style debugging/tracing, we do limited testing
@@ -54,7 +54,7 @@ GIT_TR2_BRIEF=1 && export GIT_TR2_BRIEF
 
 test_expect_success 'normal stream, return code 0' '
 	test_when_finished "rm trace.normal actual expect" &&
-	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 001return 0 &&
+	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
@@ -68,7 +68,7 @@ test_expect_success 'normal stream, return code 0' '
 
 test_expect_success 'normal stream, return code 1' '
 	test_when_finished "rm trace.normal actual expect" &&
-	test_must_fail env GIT_TR2="$(pwd)/trace.normal" test-tool trace2 001return 1 &&
+	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 001return 1 &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
@@ -83,7 +83,7 @@ test_expect_success 'normal stream, return code 1' '
 test_expect_success 'automatic filename' '
 	test_when_finished "rm -r traces actual expect" &&
 	mkdir traces &&
-	GIT_TR2="$(pwd)/traces" test-tool trace2 001return 0 &&
+	GIT_TRACE2="$(pwd)/traces" test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/*)" >actual &&
 	cat >expect <<-EOF &&
 		version $V
@@ -101,7 +101,7 @@ test_expect_success 'automatic filename' '
 
 test_expect_success 'normal stream, exit code 0' '
 	test_when_finished "rm trace.normal actual expect" &&
-	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 002exit 0 &&
+	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 002exit 0 &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
@@ -115,7 +115,7 @@ test_expect_success 'normal stream, exit code 0' '
 
 test_expect_success 'normal stream, exit code 1' '
 	test_when_finished "rm trace.normal actual expect" &&
-	test_must_fail env GIT_TR2="$(pwd)/trace.normal" test-tool trace2 002exit 1 &&
+	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 002exit 1 &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
@@ -133,7 +133,7 @@ test_expect_success 'normal stream, exit code 1' '
 
 test_expect_success 'normal stream, error event' '
 	test_when_finished "rm trace.normal actual expect" &&
-	GIT_TR2="$(pwd)/trace.normal" test-tool trace2 003error "hello world" "this is a test" &&
+	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 003error "hello world" "this is a test" &&
 	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
@@ -147,7 +147,7 @@ test_expect_success 'normal stream, error event' '
 	test_cmp expect actual
 '
 
-sane_unset GIT_TR2_BRIEF
+sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
 # from the global config.
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index b501e867af..2c3ad6e8c1 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -4,9 +4,9 @@ test_description='test trace2 facility (perf target)'
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
-sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-sane_unset GIT_TR2_PERF_BRIEF
-sane_unset GIT_TR2_CONFIG_PARAMS
+sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
+sane_unset GIT_TRACE2_PERF_BRIEF
+sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 # Add t/helper directory to PATH so that we can use a relative
 # path to run nested instances of test-tool.exe (see 004child).
@@ -27,13 +27,13 @@ V=$(git version | sed -e 's/^git version //') && export V
 # to whatever filtering that target decides to do).
 # Test each target independently.
 #
-# Defer setting GIT_TR2_PERF until the actual command we want to
+# Defer setting GIT_TRACE2_PERF until the actual command we want to
 # test because hidden git and test-tool commands in the test
 # harness can contaminate our output.
 
 # Enable "brief" feature which turns off the prefix:
 #     "<clock> <file>:<line> | <nr_parents> | "
-GIT_TR2_PERF_BRIEF=1 && export GIT_TR2_PERF_BRIEF
+GIT_TRACE2_PERF_BRIEF=1 && export GIT_TRACE2_PERF_BRIEF
 
 # Repeat some of the t0210 tests using the perf target stream instead of
 # the normal stream.
@@ -46,7 +46,7 @@ GIT_TR2_PERF_BRIEF=1 && export GIT_TR2_PERF_BRIEF
 
 test_expect_success 'perf stream, return code 0' '
 	test_when_finished "rm trace.perf actual expect" &&
-	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 0 &&
+	GIT_TRACE2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
 		d0|main|version|||||$V
@@ -60,7 +60,7 @@ test_expect_success 'perf stream, return code 0' '
 
 test_expect_success 'perf stream, return code 1' '
 	test_when_finished "rm trace.perf actual expect" &&
-	test_must_fail env GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 1 &&
+	test_must_fail env GIT_TRACE2_PERF="$(pwd)/trace.perf" test-tool trace2 001return 1 &&
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
 		d0|main|version|||||$V
@@ -78,7 +78,7 @@ test_expect_success 'perf stream, return code 1' '
 
 test_expect_success 'perf stream, error event' '
 	test_when_finished "rm trace.perf actual expect" &&
-	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 003error "hello world" "this is a test" &&
+	GIT_TRACE2_PERF="$(pwd)/trace.perf" test-tool trace2 003error "hello world" "this is a test" &&
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
 		d0|main|version|||||$V
@@ -124,7 +124,7 @@ test_expect_success 'perf stream, error event' '
 
 test_expect_success 'perf stream, child processes' '
 	test_when_finished "rm trace.perf actual expect" &&
-	GIT_TR2_PERF="$(pwd)/trace.perf" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
+	GIT_TRACE2_PERF="$(pwd)/trace.perf" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
 	cat >expect <<-EOF &&
 		d0|main|version|||||$V
@@ -150,7 +150,7 @@ test_expect_success 'perf stream, child processes' '
 	test_cmp expect actual
 '
 
-sane_unset GIT_TR2_PERF_BRIEF
+sane_unset GIT_TRACE2_PERF_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
 # from the global config.
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 59adae8123..ff5b9cc729 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -4,9 +4,9 @@ test_description='test trace2 facility'
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
-sane_unset GIT_TR2 GIT_TR2_PERF GIT_TR2_EVENT
-sane_unset GIT_TR2_BARE
-sane_unset GIT_TR2_CONFIG_PARAMS
+sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
+sane_unset GIT_TRACE2_BARE
+sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 perl -MJSON::PP -e 0 >/dev/null 2>&1 && test_set_prereq JSON_PP
 
@@ -29,7 +29,7 @@ V=$(git version | sed -e 's/^git version //') && export V
 # to whatever filtering that target decides to do).
 # Test each target independently.
 #
-# Defer setting GIT_TR2_PERF until the actual command we want to
+# Defer setting GIT_TRACE2_PERF until the actual command we want to
 # test because hidden git and test-tool commands in the test
 # harness can contaminate our output.
 
@@ -42,7 +42,7 @@ V=$(git version | sed -e 's/^git version //') && export V
 
 test_expect_success JSON_PP 'event stream, error event' '
 	test_when_finished "rm trace.event actual expect" &&
-	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 003error "hello world" "this is a test" &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool trace2 003error "hello world" "this is a test" &&
 	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
 	sed -e "s/^|//" >expect <<-EOF &&
 	|VAR1 = {
@@ -79,7 +79,7 @@ test_expect_success JSON_PP 'event stream, error event' '
 
 test_expect_success JSON_PP 'event stream, return code 0' '
 	test_when_finished "rm trace.event actual expect" &&
-	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool trace2 004child test-tool trace2 004child test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
 	sed -e "s/^|//" >expect <<-EOF &&
 	|VAR1 = {
@@ -168,7 +168,7 @@ test_expect_success JSON_PP 'event stream, list config' '
 	test_when_finished "rm trace.event actual expect" &&
 	git config --local t0212.abc 1 &&
 	git config --local t0212.def "hello world" &&
-	GIT_TR2_EVENT="$(pwd)/trace.event" GIT_TR2_CONFIG_PARAMS="t0212.*" test-tool trace2 001return 0 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" GIT_TRACE2_CONFIG_PARAMS="t0212.*" test-tool trace2 001return 0 &&
 	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
 	sed -e "s/^|//" >expect <<-EOF &&
 	|VAR1 = {
@@ -201,7 +201,7 @@ test_expect_success JSON_PP 'event stream, list config' '
 
 test_expect_success JSON_PP 'basic trace2_data' '
 	test_when_finished "rm trace.event actual expect" &&
-	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 006data test_category k1 v1 test_category k2 v2 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool trace2 006data test_category k1 v1 test_category k2 v2 &&
 	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&
 	sed -e "s/^|//" >expect <<-EOF &&
 	|VAR1 = {
diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
index a2776ba216..6584bb5634 100644
--- a/t/t0212/parse_events.perl
+++ b/t/t0212/parse_events.perl
@@ -26,7 +26,7 @@
 
 # The version of the trace2 event target format that we understand.
 # This is reported in the 'version' event in the 'evt' field.
-# It comes from the GIT_TR2_EVENT_VERSION macro in trace2/tr2_tgt_event.c
+# It comes from the GIT_TRACE2_EVENT_VERSION macro in trace2/tr2_tgt_event.c
 my $evt_version = '1';
 
 my $show_children = 1;
diff --git a/trace2.h b/trace2.h
index f189ef5984..050bf3c8c1 100644
--- a/trace2.h
+++ b/trace2.h
@@ -130,7 +130,7 @@ void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
  * list of patterns configured important.  For example:
  *     git config --system trace2.configParams 'core.*,remote.*.url'
  * or:
- *     GIT_TR2_CONFIG_PARAMS=core.*,remote.*.url"
+ *     GIT_TRACE2_CONFIG_PARAMS=core.*,remote.*.url"
  *
  * Note: this routine does a read-only iteration on the config data
  * (using read_early_config()), so it must not be called until enough
diff --git a/trace2/tr2_cmd_name.c b/trace2/tr2_cmd_name.c
index e999592b4c..dd313204f5 100644
--- a/trace2/tr2_cmd_name.c
+++ b/trace2/tr2_cmd_name.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "trace2/tr2_cmd_name.h"
 
-#define TR2_ENVVAR_PARENT_NAME "GIT_TR2_PARENT_NAME"
+#define TR2_ENVVAR_PARENT_NAME "GIT_TRACE2_PARENT_NAME"
 
 static struct strbuf tr2cmdname_hierarchy = STRBUF_INIT;
 
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 5047095478..6948fd4108 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -2,7 +2,7 @@
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
 
-#define TR2_ENVVAR_PARENT_SID "GIT_TR2_PARENT_SID"
+#define TR2_ENVVAR_PARENT_SID "GIT_TRACE2_PARENT_SID"
 
 static struct strbuf tr2sid_buf = STRBUF_INIT;
 static int tr2sid_nr_git_parents;
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 9025b86303..5958cfc424 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -21,33 +21,33 @@ struct tr2_sysenv_entry {
  * The strings in this table are constant and must match the published
  * config and environment variable names as described in the documentation.
  *
- * We do not define entries for the GIT_TR2_PARENT_* environment
+ * We do not define entries for the GIT_TRACE2_PARENT_* environment
  * variables because they are transient and used to pass information
  * from parent to child git processes, rather than settings.
  */
 /* clang-format off */
 static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
-	[TR2_SYSENV_CFG_PARAM]     = { "GIT_TR2_CONFIG_PARAMS",
+	[TR2_SYSENV_CFG_PARAM]     = { "GIT_TRACE2_CONFIG_PARAMS",
 				       "trace2.configparams" },
 
-	[TR2_SYSENV_DST_DEBUG]     = { "GIT_TR2_DST_DEBUG",
+	[TR2_SYSENV_DST_DEBUG]     = { "GIT_TRACE2_DST_DEBUG",
 				       "trace2.destinationdebug" },
 
-	[TR2_SYSENV_NORMAL]        = { "GIT_TR2",
+	[TR2_SYSENV_NORMAL]        = { "GIT_TRACE2",
 				       "trace2.normaltarget" },
-	[TR2_SYSENV_NORMAL_BRIEF]  = { "GIT_TR2_BRIEF",
+	[TR2_SYSENV_NORMAL_BRIEF]  = { "GIT_TRACE2_BRIEF",
 				       "trace2.normalbrief" },
 
-	[TR2_SYSENV_EVENT]         = { "GIT_TR2_EVENT",
+	[TR2_SYSENV_EVENT]         = { "GIT_TRACE2_EVENT",
 				       "trace2.eventtarget" },
-	[TR2_SYSENV_EVENT_BRIEF]   = { "GIT_TR2_EVENT_BRIEF",
+	[TR2_SYSENV_EVENT_BRIEF]   = { "GIT_TRACE2_EVENT_BRIEF",
 				       "trace2.eventbrief" },
-	[TR2_SYSENV_EVENT_NESTING] = { "GIT_TR2_EVENT_NESTING",
+	[TR2_SYSENV_EVENT_NESTING] = { "GIT_TRACE2_EVENT_NESTING",
 				       "trace2.eventnesting" },
 
-	[TR2_SYSENV_PERF]          = { "GIT_TR2_PERF",
+	[TR2_SYSENV_PERF]          = { "GIT_TRACE2_PERF",
 				       "trace2.perftarget" },
-	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TR2_PERF_BRIEF",
+	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TRACE2_PERF_BRIEF",
 				       "trace2.perfbrief" },
 };
 /* clang-format on */
diff --git a/trace2/tr2_sysenv.h b/trace2/tr2_sysenv.h
index 369b20bd87..8dd82a7a56 100644
--- a/trace2/tr2_sysenv.h
+++ b/trace2/tr2_sysenv.h
@@ -7,7 +7,7 @@
  *
  * Note that this set does not contain any of the transient
  * environment variables used to pass information from parent
- * to child git processes, such "GIT_TR2_PARENT_SID".
+ * to child git processes, such "GIT_TRACE2_PARENT_SID".
  */
 enum tr2_sysenv_variable {
 	TR2_SYSENV_CFG_PARAM = 0,
-- 
2.22.0.rc1.424.g15834b9bb1

