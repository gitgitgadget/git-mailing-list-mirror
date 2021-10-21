Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0028DC4332F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC46D6120F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJUO2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhJUO1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1694C061227
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r10so1139841wra.12
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OT4wk9P2uUf/lbNctyV/RDTLgCDHNMc8joLfeeBdOks=;
        b=X19GtMrsz46NpN6vMQmVoO2FVxaALbadUfJxSCbKKxJ9vfoAETUakjZu5ItVc9lZng
         FVfp2Ha0Jvj170IPw/fz/dpXl/D2PQmbeHPgVjyt7qdbYfvLhtMgwwfPqeRSGeB5+nrx
         FQtb2mXT2AJedWoncNA9Jx0gaWPVsWnrZLUFO35fxEO5MhWQ90ZD82ooXNvBxd75XSWp
         4O3uQWKMabY5ja+wX88k0JuGPiCrgkjAcBmyX5hlVtNJJUHAyoFpHr2i8hfqtaJfTICt
         yvBHhEUS6QBoM2gWPE2OmlIliLYH52geFtDhv0O6PKiFZT3Ijooyl0ow2RNPrTq3DW1Y
         muGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OT4wk9P2uUf/lbNctyV/RDTLgCDHNMc8joLfeeBdOks=;
        b=4Ah+Df/PRLfctqrV1Wp65ThtWh/A1G7lx0i+pb7j06+lugJLSAs8W6SZhs7zoePN4D
         xl0W9KuyIbeCbaY/S4Vn37XzmoJRgKXxjMM8npCsd/tNOkcwLlhoynefNHDBYuz7ahTa
         Je0qoB07LtE4qTquxFvJPhKIgwhVsTY7oPGJf9eKyXXTEFT/i8Tye8HgMAd9i7HNNg4Z
         WFkEbroJm902IN4G+NtjfLbuDM7ehm84pBnR5COMCzH0/sGCmn0tBDsxiFrsFlGsrcyS
         SCeqTo+dh3PNh2zbg0/01P/GDl9yGnwCh9w9OszUXt4h446BJF5336EfQC3p+h0WkH/r
         82bQ==
X-Gm-Message-State: AOAM533sVXc8GhU8nNBi1ACtlO7przjHNObYmqGKqhvbF2Ny4ve2tz0Y
        POSrlqiDi4Tl/QALAofUBTkZ0wvuLuo=
X-Google-Smtp-Source: ABdhPJymKTOQPJorPxp3y/IpSRteEhbflQlE5nxDpH3y65eXOSgQrpYSKMm2IPhwFT6GjuWy75E0ug==
X-Received: by 2002:adf:f812:: with SMTP id s18mr7451931wrp.347.1634826326608;
        Thu, 21 Oct 2021 07:25:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm2062180wmc.37.2021.10.21.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:26 -0700 (PDT)
Message-Id: <54710a4830dc317797430da1ce210c5fb48d7198.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:25:06 +0000
Subject: [PATCH v4 26/29] fsmonitor--daemon: periodically truncate list of
 modified files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to periodically truncate the list of
modified files to save some memory.

Clients will ask for the set of changes relative to a token that they
found in the FSMN index extension in the index.  (This token is like a
point in time, but different).  Clients will then update the index to
contain the response token (so that subsequent commands will be
relative to this new token).

Therefore, the daemon can gradually truncate the in-memory list of
changed paths as they become obsolete (older than the previous token).
Since we may have multiple clients making concurrent requests with a
skew of tokens and clients may be racing to the talk to the daemon,
we lazily truncate the list.

We introduce a 5 minute delay and truncate batches 5 minutes after
they are considered obsolete.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 4c88171e06c..962b24569e1 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -299,6 +299,75 @@ static void fsmonitor_batch__combine(struct fsmonitor_batch *batch_dest,
 			batch_src->interned_paths[k];
 }
 
+/*
+ * To keep the batch list from growing unbounded in response to filesystem
+ * activity, we try to truncate old batches from the end of the list as
+ * they become irrelevant.
+ *
+ * We assume that the .git/index will be updated with the most recent token
+ * any time the index is updated.  And future commands will only ask for
+ * recent changes *since* that new token.  So as tokens advance into the
+ * future, older batch items will never be requested/needed.  So we can
+ * truncate them without loss of functionality.
+ *
+ * However, multiple commands may be talking to the daemon concurrently
+ * or perform a slow command, so a little "token skew" is possible.
+ * Therefore, we want this to be a little bit lazy and have a generous
+ * delay.
+ *
+ * The current reader thread walked backwards in time from `token->batch_head`
+ * back to `batch_marker` somewhere in the middle of the batch list.
+ *
+ * Let's walk backwards in time from that marker an arbitrary delay
+ * and truncate the list there.  Note that these timestamps are completely
+ * artificial (based on when we pinned the batch item) and not on any
+ * filesystem activity.
+ *
+ * Return the obsolete portion of the list after we have removed it from
+ * the official list so that the caller can free it after leaving the lock.
+ */
+#define MY_TIME_DELAY_SECONDS (5 * 60) /* seconds */
+
+static struct fsmonitor_batch *with_lock__truncate_old_batches(
+	struct fsmonitor_daemon_state *state,
+	const struct fsmonitor_batch *batch_marker)
+{
+	/* assert current thread holding state->main_lock */
+
+	const struct fsmonitor_batch *batch;
+	struct fsmonitor_batch *remainder;
+
+	if (!batch_marker)
+		return NULL;
+
+	trace_printf_key(&trace_fsmonitor, "Truncate: mark (%"PRIu64",%"PRIu64")",
+			 batch_marker->batch_seq_nr,
+			 (uint64_t)batch_marker->pinned_time);
+
+	for (batch = batch_marker; batch; batch = batch->next) {
+		time_t t;
+
+		if (!batch->pinned_time) /* an overflow batch */
+			continue;
+
+		t = batch->pinned_time + MY_TIME_DELAY_SECONDS;
+		if (t > batch_marker->pinned_time) /* too close to marker */
+			continue;
+
+		goto truncate_past_here;
+	}
+
+	return NULL;
+
+truncate_past_here:
+	state->current_token_data->batch_tail = (struct fsmonitor_batch *)batch;
+
+	remainder = ((struct fsmonitor_batch *)batch)->next;
+	((struct fsmonitor_batch *)batch)->next = NULL;
+
+	return remainder;
+}
+
 static void fsmonitor_free_token_data(struct fsmonitor_token_data *token)
 {
 	if (!token)
@@ -412,6 +481,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const char *p;
 	const struct fsmonitor_batch *batch_head;
 	const struct fsmonitor_batch *batch;
+	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
 	kh_str_t *shown;
 	int hash_ret;
@@ -641,11 +711,29 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 			 * that work.
 			 */
 			fsmonitor_free_token_data(token_data);
+		} else if (batch) {
+			/*
+			 * We are holding the lock and are the only
+			 * reader of the ref-counted portion of the
+			 * list, so we get the honor of seeing if the
+			 * list can be truncated to save memory.
+			 *
+			 * The main loop did not walk to the end of the
+			 * list, so this batch is the first item in the
+			 * batch-list that is older than the requested
+			 * end-point sequence number.  See if the tail
+			 * end of the list is obsolete.
+			 */
+			remainder = with_lock__truncate_old_batches(state,
+								    batch);
 		}
 	}
 
 	pthread_mutex_unlock(&state->main_lock);
 
+	if (remainder)
+		fsmonitor_batch__free_list(remainder);
+
 	trace2_data_intmax("fsmonitor", the_repository, "response/length", total_response_len);
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
-- 
gitgitgadget

