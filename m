Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D3CC433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiCXQyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352162AbiCXQxF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD10AF1E5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2928320wmb.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8V1FoXCb86xqZ2XOaLWrGr4avTXqor6TX1WNeRZ9avw=;
        b=qazqeaHJnnHFiM84XlBeB8sYWscstshi2ra7cDmNWoPD5YRLFYodv0hOXzkUC2EKvP
         bf1WAt/6tBibgX7ywGYxhdkjwDdxRuhqJOsbWi/geix+9VZxWiwUVEEcpGUinQ7WDERM
         6SN7qyh97aXQp+uVSXHOouxX4XQAdLmiMeJAxd+eBiMZ3h/+KSStZ1U2JvW12zL00vk/
         ONduAAxdYR9KQRAMlBubmgbCYhmmBLn34HK731paw1Q8hh4986WnJZnCHWiaJvWbUz4H
         r0YXOAVrE694j3Rq1YI4bap/mj778aYQt1/v2TEFG/M5BVTsK93O+WKv6i39GdUVaaNg
         Ui/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8V1FoXCb86xqZ2XOaLWrGr4avTXqor6TX1WNeRZ9avw=;
        b=FFU5lIAV9V8jowUCaQrBsXc4PREGsZdJf9E+ZdFOuC7f6zysdyvmd4zLBXtpQXveda
         4Y37DRwo6XHl6NEbS1p4olGT+uiQcuoUGpqfnLemxV1qKDpJXKxHseJKg4Rp1V+lcgYn
         yuMq3F/pzXDN5PpKrmBC0hVv2FMS1mlURA5TEJeRvUPCxspntp4ggTOomlQT+goVwqij
         AYTSD7lF6ZwooJKN8TZc58ijXJnZJ0cUTSB5Nkee6lc00VgQEUd54+kUX63E/grf62lK
         7o0X7vOS2WSTDPRGbiVtfJ4q+OFuArQE6y4EhYPxkNrwzpxZIgdH30xzWh0Rg1c1Gq1b
         yzvg==
X-Gm-Message-State: AOAM532GQG3+2Q66X/qsA1EQOR1bqNhl09sL6MHc+MQMy/khNC4DSJjv
        BLeJ6Ta++5S/0XiFZyyTp6E6OCYsW9s=
X-Google-Smtp-Source: ABdhPJx+Uz00lZkaqjwlf4d1rrS2IXS5xXL8c38m3eTHnE6cK6QHCFYzEmlMGwmztKnLP29o0pLkaA==
X-Received: by 2002:a7b:c0d3:0:b0:38c:a3fe:5d62 with SMTP id s19-20020a7bc0d3000000b0038ca3fe5d62mr14952777wmh.110.1648140686290;
        Thu, 24 Mar 2022 09:51:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b0038cb98076d6sm2827818wmg.10.2022.03.24.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:25 -0700 (PDT)
Message-Id: <4db2370d046875a83ec0c249c2349df61b7ecc3c.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:50:56 +0000
Subject: [PATCH v4 03/27] t/helper/fsmonitor-client: create stress test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a stress test to hammer on the fsmonitor daemon.
Create a client-side thread pool of n threads and have
each of them make m requests as fast as they can.

We do not currently inspect the contents of the response.
We're only interested in placing a heavy request load on
the daemon.

This test is useful for interactive testing and various
experimentation.  For example, to place additional load
on the daemon while another test is running.  We currently
do not have a test script that actually uses this helper.
We might add such a test in the future.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-fsmonitor-client.c | 106 +++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 3062c8a3c2b..54a4856c48c 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -7,6 +7,8 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "fsmonitor-ipc.h"
+#include "thread-utils.h"
+#include "trace2.h"
 
 #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
 int cmd__fsmonitor_client(int argc, const char **argv)
@@ -79,20 +81,121 @@ static int do_send_flush(void)
 	return 0;
 }
 
+struct hammer_thread_data
+{
+	pthread_t pthread_id;
+	int thread_nr;
+
+	int nr_requests;
+	const char *token;
+
+	int sum_successful;
+	int sum_errors;
+};
+
+static void *hammer_thread_proc(void *_hammer_thread_data)
+{
+	struct hammer_thread_data *data = _hammer_thread_data;
+	struct strbuf answer = STRBUF_INIT;
+	int k;
+	int ret;
+
+	trace2_thread_start("hammer");
+
+	for (k = 0; k < data->nr_requests; k++) {
+		strbuf_reset(&answer);
+
+		ret = fsmonitor_ipc__send_query(data->token, &answer);
+		if (ret < 0)
+			data->sum_errors++;
+		else
+			data->sum_successful++;
+	}
+
+	strbuf_release(&answer);
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * Start a pool of client threads that will each send a series of
+ * commands to the daemon.
+ *
+ * The goal is to overload the daemon with a sustained series of
+ * concurrent requests.
+ */
+static int do_hammer(const char *token, int nr_threads, int nr_requests)
+{
+	struct hammer_thread_data *data = NULL;
+	int k;
+	int sum_join_errors = 0;
+	int sum_commands = 0;
+	int sum_errors = 0;
+
+	if (!token || !*token)
+		token = get_token_from_index();
+	if (nr_threads < 1)
+		nr_threads = 1;
+	if (nr_requests < 1)
+		nr_requests = 1;
+
+	CALLOC_ARRAY(data, nr_threads);
+
+	for (k = 0; k < nr_threads; k++) {
+		struct hammer_thread_data *p = &data[k];
+		p->thread_nr = k;
+		p->nr_requests = nr_requests;
+		p->token = token;
+
+		if (pthread_create(&p->pthread_id, NULL, hammer_thread_proc, p)) {
+			warning("failed to create thread[%d] skipping remainder", k);
+			nr_threads = k;
+			break;
+		}
+	}
+
+	for (k = 0; k < nr_threads; k++) {
+		struct hammer_thread_data *p = &data[k];
+
+		if (pthread_join(p->pthread_id, NULL))
+			sum_join_errors++;
+		sum_commands += p->sum_successful;
+		sum_errors += p->sum_errors;
+	}
+
+	fprintf(stderr, "HAMMER: [threads %d][requests %d] [ok %d][err %d][join %d]\n",
+		nr_threads, nr_requests, sum_commands, sum_errors, sum_join_errors);
+
+	free(data);
+
+	/*
+	 * Return an error if any of the _send_query requests failed.
+	 * We don't care about thread create/join errors.
+	 */
+	return sum_errors > 0;
+}
+
 int cmd__fsmonitor_client(int argc, const char **argv)
 {
 	const char *subcmd;
 	const char *token = NULL;
+	int nr_threads = 1;
+	int nr_requests = 1;
 
 	const char * const fsmonitor_client_usage[] = {
 		"test-tool fsmonitor-client query [<token>]",
 		"test-tool fsmonitor-client flush",
+		"test-tool fsmonitor-client hammer [<token>] [<threads>] [<requests>]",
 		NULL,
 	};
 
 	struct option options[] = {
 		OPT_STRING(0, "token", &token, "token",
 			   "command token to send to the server"),
+
+		OPT_INTEGER(0, "threads", &nr_threads, "number of client threads"),
+		OPT_INTEGER(0, "requests", &nr_requests, "number of requests per thread"),
+
 		OPT_END()
 	};
 
@@ -111,6 +214,9 @@ int cmd__fsmonitor_client(int argc, const char **argv)
 	if (!strcmp(subcmd, "flush"))
 		return !!do_send_flush();
 
+	if (!strcmp(subcmd, "hammer"))
+		return !!do_hammer(token, nr_threads, nr_requests);
+
 	die("Unhandled subcommand: '%s'", subcmd);
 }
 #endif
-- 
gitgitgadget

