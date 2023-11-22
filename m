Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koRMsAZl"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3911F
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32df66c691dso39153f8f.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680721; x=1701285521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwi6GU9IrhbxpVTf408ITlx8/kBTgmpFzT72lxcYK4E=;
        b=koRMsAZlJTrPfOAPfteoGSUwa80zS7TaOD0W70u6zHLdkK53F1su5th0ABcDej5/3S
         cI4gWo2hYyh6ctfNvDL2yxNWx58vmZVTroQGlWipfQBe5oQegKYRoi5prAZ5MqSgh++B
         +5rWNTxusTbCVqvhUpEuxR6D+IvaPs/IuioMktQroiMkVvkooSsmBqpMUoIValRszRHf
         +OgXMTItrqj8pVruAjpbR/3aNlkylYZyEnNCJ8RFnhWdEijye11HcjOE7cku9DXVHw0e
         VUWcnu0rbQzAHFUnDGD4dB2Xly+F1JTYt5s27IkGG95rcIsVzS6Um9Epja0te7h7aP6E
         WrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680721; x=1701285521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwi6GU9IrhbxpVTf408ITlx8/kBTgmpFzT72lxcYK4E=;
        b=OMdFa50xRY42uzg9UQCxiDBciGRPLO8i/A65w0XqzJAp8H7fiYFQum1KanNE6IDN+v
         wHIcOrZgDAAjWRZSWAoqDIuLCx5r4x9EbhY06i3xNsi4dJcGB72I71locff18pS3AXfy
         lGb++uauJoNIkZOLfFStYFgxYb63yFJHKcycX46OMqCItFYPC215ryE1exm20WFrsCo6
         smGmIsvsIJbG2paZkDiz/daEwDpdDzAOhjzJItgNep9fDuWXGlb2PBCsJoYuJXjGeWaI
         OsdsDS20iEbiW42MkbzmXtJse6CsWEO6d/nKxgG1g9sPYZ/4x+Q50eAI2Q/BJeAwFt2S
         d5bA==
X-Gm-Message-State: AOJu0YwQqClxFrVqDWWsZSEuD879Qqq4yTO6XNC1npFSQytkrnCxesni
	sXSgQVEWVbj7UclDRuy9CQbtEuvGbvo=
X-Google-Smtp-Source: AGHT+IG0EAJzURPebhq2mLBcmZge5GAFpmyynneWQqBgIEc6C7noPhiit541lh29K4KZJmJjhQ545A==
X-Received: by 2002:a5d:468d:0:b0:332:c9f5:e5e6 with SMTP id u13-20020a5d468d000000b00332c9f5e5e6mr2294848wrq.17.1700680721352;
        Wed, 22 Nov 2023 11:18:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dh10-20020a0560000a8a00b0032d8eecf901sm150856wrb.3.2023.11.22.11.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:18:41 -0800 (PST)
Message-ID: <9bfd00c5ecb26a25589c59a0282fce26f948b6a9.1700680717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
References: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Nov 2023 19:18:37 +0000
Subject: [PATCH 4/4] t0212: test URL redacting in EVENT format
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

In the added tests cases, skip testing the `GIT_TRACE2_REDACT=0` case
because we would need to exactly model the full JSON event stream like
we did in the preceding basic tests and I do not think it is worth it.

Furthermore, the Trace2 routines print the same content in normal, perf,
or event format, and in t0210 and t0211 we already tested the basic
functionality, so no need to repeat it here.

In this test, we use the test-helper to unit test each of the event
messages where URLs can appear and confirm that they are redacted in
each event.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/helper/test-trace2.c  | 55 +++++++++++++++++++++++++++++++++++++++++
 t/t0212-trace2-event.sh | 40 ++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index d5ca0046c89..1adac29a575 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -412,6 +412,56 @@ static int ut_201counter(int argc, const char **argv)
 	return 0;
 }
 
+static int ut_300redact_start(int argc, const char **argv)
+{
+	if (!argc)
+		die("expect <argv...>");
+
+	trace2_cmd_start(argv);
+
+	return 0;
+}
+
+static int ut_301redact_child_start(int argc, const char **argv)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	int k;
+
+	if (!argc)
+		die("expect <argv...>");
+
+	for (k = 0; argv[k]; k++)
+		strvec_push(&cmd.args, argv[k]);
+
+	trace2_child_start(&cmd);
+
+	strvec_clear(&cmd.args);
+
+	return 0;
+}
+
+static int ut_302redact_exec(int argc, const char **argv)
+{
+	if (!argc)
+		die("expect <exe> <argv...>");
+
+	trace2_exec(argv[0], &argv[1]);
+
+	return 0;
+}
+
+static int ut_303redact_def_param(int argc, const char **argv)
+{
+	struct key_value_info kvi = KVI_INIT;
+
+	if (argc < 2)
+		die("expect <key> <value>");
+
+	trace2_def_param(argv[0], argv[1], &kvi);
+
+	return 0;
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -438,6 +488,11 @@ static struct unit_test ut_table[] = {
 
 	{ ut_200counter,  "200counter", "<v1> [<v2> [<v3> [...]]]" },
 	{ ut_201counter,  "201counter", "<v1> <v2> <threads>" },
+
+	{ ut_300redact_start,       "300redact_start",       "<argv...>" },
+	{ ut_301redact_child_start, "301redact_child_start", "<argv...>" },
+	{ ut_302redact_exec,        "302redact_exec",        "<exe> <argv...>" },
+	{ ut_303redact_def_param,   "303redact_def_param",   "<key> <value>" },
 };
 /* clang-format on */
 
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 6d3374ff773..147643d5826 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -323,4 +323,44 @@ test_expect_success 'discard traces when there are too many files' '
 	head -n2 trace_target_dir/git-trace2-discard | tail -n1 | grep \"event\":\"too_many_files\"
 '
 
+# In the following "...redact..." tests, skip testing the GIT_TRACE2_REDACT=0
+# case because we would need to exactly model the full JSON event stream like
+# we did in the basic tests above and I do not think it is worth it.
+
+test_expect_success 'unsafe URLs are redacted by default in cmd_start events' '
+	test_when_finished \
+		"rm -r trace.event" &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+		test-tool trace2 300redact_start git clone https://user:pwd@example.com/ clone2 &&
+	! grep user:pwd trace.event
+'
+
+test_expect_success 'unsafe URLs are redacted by default in child_start events' '
+	test_when_finished \
+		"rm -r trace.event" &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+		test-tool trace2 301redact_child_start git clone https://user:pwd@example.com/ clone2 &&
+	! grep user:pwd trace.event
+'
+
+test_expect_success 'unsafe URLs are redacted by default in exec events' '
+	test_when_finished \
+		"rm -r trace.event" &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+		test-tool trace2 302redact_exec git clone https://user:pwd@example.com/ clone2 &&
+	! grep user:pwd trace.event
+'
+
+test_expect_success 'unsafe URLs are redacted by default in def_param events' '
+	test_when_finished \
+		"rm -r trace.event" &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+		test-tool trace2 303redact_def_param url https://user:pwd@example.com/ &&
+	! grep user:pwd trace.event
+'
+
 test_done
-- 
gitgitgadget
