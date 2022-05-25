Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E72C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiEYPBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbiEYPBC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D8BAEE37
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so3519628wmz.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8V1FoXCb86xqZ2XOaLWrGr4avTXqor6TX1WNeRZ9avw=;
        b=BLchjQjw4Z71g7sehYdFQETuJoxcWAWS+RbHxaHy7FHGgb5IGAhUvIgXMU4IZEOOA4
         pOS7MDPAFB2TjaCpNoeuKhCEKTeOljpw8MnKzYoEx5DcawlvbQdMjjGnHspotLOX1pzU
         WjlaewJV9y25lgJaw+9reSy1t5m4QcBpu6O8Em0bu38MrQr3IJAtVdEUwwWy8Wlr2LXx
         OB5qD3cfgJatnnuAvIJuq5SvfxcYVpSwv+QkqWisQ1i5/DtBsIbFV9HZJ0+Pk9i5K83w
         GRwpQR8tMlCcpOmNPCB6bSvaqeZXHTAu/s+D5EDkozv6u8uIWu7zobX7BCypfhyt2QM0
         Dd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8V1FoXCb86xqZ2XOaLWrGr4avTXqor6TX1WNeRZ9avw=;
        b=vyXFNrd8neI0sx5Twfv1NK83F6TKMdgULH2ZlWSiZau6MO6ZcHTt64YPQ4rUWPvYbH
         lhsqmho5xogRHnjCWML+uwaPHWCkr0lo32By+tRYmkoFuCbOWSivYPJFB3zbqOht1bwS
         cNCRdIbVwXq6+jCnaSab4Zn2JJWbXF1KW8am2PpwyxvcnTy7RbLhV6vQFP9nI1QFUyCF
         T52/PXISEisTbX1Np2dNL6h8YwgBkkhopcIpB1wEN6RvGo8PMrTfz7qeVsBTHXFs7WwC
         TpbpVP6LeHg2trpiT5GOOsLrJ3SWgrB/PU+9YGqWrw8gcksGgITRcBM0MvFt5im+LtxR
         oAQQ==
X-Gm-Message-State: AOAM532EZmGPiF9a6VEUOKyeExxkyuqu7oxbqI2U9JSqz+cJrEshL/K4
        5byook7miktIxZdcfh9H6zxBtGc/iZ0=
X-Google-Smtp-Source: ABdhPJwkvHuQAZNY0g8liD7Xxy7q9ld1KdU5Wnn1UObXTaAvfH+L9HZszs6xkjc4KxTuLZCdrOzI0w==
X-Received: by 2002:a1c:7912:0:b0:397:41e9:872d with SMTP id l18-20020a1c7912000000b0039741e9872dmr8574504wme.184.1653490859543;
        Wed, 25 May 2022 08:00:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c350300b0039456fb80b3sm266832wmq.43.2022.05.25.08.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:00:58 -0700 (PDT)
Message-Id: <4bca494bb22365fd9ccc59f6470c5124f74caf84.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:25 +0000
Subject: [PATCH v8 03/30] t/helper/fsmonitor-client: create stress test
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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

