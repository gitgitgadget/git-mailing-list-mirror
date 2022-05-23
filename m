Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D7EC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiEWUND (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiEWUMz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:12:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9211B996A2
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u27so22072225wru.8
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8V1FoXCb86xqZ2XOaLWrGr4avTXqor6TX1WNeRZ9avw=;
        b=XUCwwYRcXD6F2Bv7KjcTGFFWAi1ljgTZlCmYYQI/P6MnnoXbfjX7LocF7r6F6r0tKT
         vvdkIm51IpCgBpyYtg0pvb/pjkZGeO8/TwL16Arv5imguQN5EWxzmXEui6+cOAWoe9eZ
         cQlfWisM79d7HlOPdwcLp3KINJJY4bmgr0vq6hHT5AYTkLCxM0nplftIBpO5iY6KGwt1
         r21NAS2hKygNyaR/Mr1faBVX+W7cpvHfy1A7x3hIxTj3r34eUJSCYB1r4+COj/1bln9i
         UYon+puhULL4wk61kasLH9rjuD4d2A+Niyn//IGXMMZQcNZCGtbRO/Vw8PvEHAKmQ2mS
         QmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8V1FoXCb86xqZ2XOaLWrGr4avTXqor6TX1WNeRZ9avw=;
        b=cVZHJ8s3Dh33bOe7kSr64HsCOsadtSc3OGG1bSjmyDKiEWv/5FiSpalYgQrT4iRCng
         nZRdjPlmfM8hR+CWQIceoXJeP0NbEwT4EEOdPIxqzsNxRbxhFBX+ObQCODMd8/OSXP5I
         WD4PLlCvZv6l61oLBo8PF2iDcEO0Ylw/w2JS+6IoHR64rGQTCxTVlju4L1vWva4MMjNR
         1U+c4zAje2XggAXpbuotIvQkitXAcT1YzTfylnzF6KVH5gfPVUnkr5awtGnbW8y6Nqrh
         cfvMglgnQew1n4n0/7VJ1kbddyCOokgZldsW2aiLcRpJkKMqQI97z4t1NY0ekEip3888
         iS3A==
X-Gm-Message-State: AOAM533RjyVVcESpst9CQOG5nsGe5w96rbSZuzuGno2naJe2TNT4fxL1
        F9FmbTbqYoshYqc2OVQiHJ4uzxtZKxo=
X-Google-Smtp-Source: ABdhPJwX1t+/7PFNdN0nWIPEO5XoYx52LaQGvU0e0+Xecl6zWCRGt3Dht3VPaLfgcCpxth/oYFj0bw==
X-Received: by 2002:a5d:6d8f:0:b0:20c:7fb7:d59c with SMTP id l15-20020a5d6d8f000000b0020c7fb7d59cmr21545110wrs.77.1653336771878;
        Mon, 23 May 2022 13:12:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b0039750c39fc5sm490376wmr.3.2022.05.23.13.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:12:50 -0700 (PDT)
Message-Id: <4bca494bb22365fd9ccc59f6470c5124f74caf84.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:18 +0000
Subject: [PATCH v7 03/30] t/helper/fsmonitor-client: create stress test
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

