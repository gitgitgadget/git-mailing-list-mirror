Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFB6C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiBKU5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353546AbiBKU4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DE3D55
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k1so17171895wrd.8
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/v6Wn1lhWY+rSkfBaE1lYsf+YQmLlESv7zTQOqYhXLE=;
        b=BBU4DMWToteC6GtfA/d6QQLJvzrbRdhM9wAEiWj/jwn7GfKkkpQXVU9zzvXj1Cu51g
         DxAN+tfQ/NWoUgYjTiMK7S+hND3IWMyNC908YVpmZKYnbYbuubnSmaxrmNpk+nq5WHOC
         0YkBoqr+Yk9CZs7Cd70GSOwbV6EFUUmW9sVxHSGixG44yp5SdImd0Eoo645ox6rrP9nw
         cEEWspzqAWkByZfe2ON/6A4iNXVRhF5p082gD+mvO+ljTP33w/OYNT4NKVfZ9fHWGuEy
         FVpxQzi1zmaGoez8MPy0grbp6TwfLE+fDSAPV5GL5Cad+yMgF/YQ0HmpFY4/bY4Voxux
         s71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/v6Wn1lhWY+rSkfBaE1lYsf+YQmLlESv7zTQOqYhXLE=;
        b=g/N3GOXO7WIZPppKWhvvIl9iMH/FasiRq9kwZaLQrG4YRCd/xhEzTPXszLYRQmYwSW
         qJeO1zGL+YlmHOdbP99BXxjao7x5G0pX8k1SrF+D/0Ab5PBFMPCdB+/EUabMGOsNtUuA
         Y+b/fSazmwkwFvyQlZsZWxovAygwUkXiUa3zHEh6tf50+VciCTe3CA3OqQG0vYsidF/c
         KtI5auZ9XjMA7wuW7h9BXeNtFFoz/efpRwLgNB4h/8xb/EmkOZJkQYMSC/jn+1/1GQU1
         gqZk8wQxcf8J/Q4yHoIaPuSMONFDmn1amiSP0rP1DolXGess7rnvE7FfLWpVHHwXTm/U
         +aPg==
X-Gm-Message-State: AOAM533j62fjKzjrgiD1ZIyV2HhRxGzO/oy3AXoa5TUboRK7aDexHX06
        qBSYsnIJKpVaMlcRNcTDagTGoqGL6k0=
X-Google-Smtp-Source: ABdhPJyhC2IVWOvzdqYhhXwcKEvcmpyBlr9O/cFU4WDJkqRBU4etTS8JYNrybS7LY67kFjWLotgztw==
X-Received: by 2002:adf:ea0d:: with SMTP id q13mr762363wrm.191.1644612991577;
        Fri, 11 Feb 2022 12:56:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm4755025wmk.38.2022.02.11.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:31 -0800 (PST)
Message-Id: <72979c35ceb1a4a3d95412834ddff002aaac9b16.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:02 +0000
Subject: [PATCH v5 13/30] fsmonitor--daemon: define token-ids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach fsmonitor--daemon to create token-ids and define the
overall token naming scheme.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 116 +++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 1618f1aa27f..2997c2cba8c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -93,6 +93,120 @@ static int do_as_client__status(void)
 	}
 }
 
+/*
+ * Requests to and from a FSMonitor Protocol V2 provider use an opaque
+ * "token" as a virtual timestamp.  Clients can request a summary of all
+ * created/deleted/modified files relative to a token.  In the response,
+ * clients receive a new token for the next (relative) request.
+ *
+ *
+ * Token Format
+ * ============
+ *
+ * The contents of the token are private and provider-specific.
+ *
+ * For the built-in fsmonitor--daemon, we define a token as follows:
+ *
+ *     "builtin" ":" <token_id> ":" <sequence_nr>
+ *
+ * The "builtin" prefix is used as a namespace to avoid conflicts
+ * with other providers (such as Watchman).
+ *
+ * The <token_id> is an arbitrary OPAQUE string, such as a GUID,
+ * UUID, or {timestamp,pid}.  It is used to group all filesystem
+ * events that happened while the daemon was monitoring (and in-sync
+ * with the filesystem).
+ *
+ *     Unlike FSMonitor Protocol V1, it is not defined as a timestamp
+ *     and does not define less-than/greater-than relationships.
+ *     (There are too many race conditions to rely on file system
+ *     event timestamps.)
+ *
+ * The <sequence_nr> is a simple integer incremented whenever the
+ * daemon needs to make its state public.  For example, if 1000 file
+ * system events come in, but no clients have requested the data,
+ * the daemon can continue to accumulate file changes in the same
+ * bin and does not need to advance the sequence number.  However,
+ * as soon as a client does arrive, the daemon needs to start a new
+ * bin and increment the sequence number.
+ *
+ *     The sequence number serves as the boundary between 2 sets
+ *     of bins -- the older ones that the client has already seen
+ *     and the newer ones that it hasn't.
+ *
+ * When a new <token_id> is created, the <sequence_nr> is reset to
+ * zero.
+ *
+ *
+ * About Token Ids
+ * ===============
+ *
+ * A new token_id is created:
+ *
+ * [1] each time the daemon is started.
+ *
+ * [2] any time that the daemon must re-sync with the filesystem
+ *     (such as when the kernel drops or we miss events on a very
+ *     active volume).
+ *
+ * [3] in response to a client "flush" command (for dropped event
+ *     testing).
+ *
+ * When a new token_id is created, the daemon is free to discard all
+ * cached filesystem events associated with any previous token_ids.
+ * Events associated with a non-current token_id will never be sent
+ * to a client.  A token_id change implicitly means that the daemon
+ * has gap in its event history.
+ *
+ * Therefore, clients that present a token with a stale (non-current)
+ * token_id will always be given a trivial response.
+ */
+struct fsmonitor_token_data {
+	struct strbuf token_id;
+	struct fsmonitor_batch *batch_head;
+	struct fsmonitor_batch *batch_tail;
+	uint64_t client_ref_count;
+};
+
+static struct fsmonitor_token_data *fsmonitor_new_token_data(void)
+{
+	static int test_env_value = -1;
+	static uint64_t flush_count = 0;
+	struct fsmonitor_token_data *token;
+
+	CALLOC_ARRAY(token, 1);
+
+	strbuf_init(&token->token_id, 0);
+	token->batch_head = NULL;
+	token->batch_tail = NULL;
+	token->client_ref_count = 0;
+
+	if (test_env_value < 0)
+		test_env_value = git_env_bool("GIT_TEST_FSMONITOR_TOKEN", 0);
+
+	if (!test_env_value) {
+		struct timeval tv;
+		struct tm tm;
+		time_t secs;
+
+		gettimeofday(&tv, NULL);
+		secs = tv.tv_sec;
+		gmtime_r(&secs, &tm);
+
+		strbuf_addf(&token->token_id,
+			    "%"PRIu64".%d.%4d%02d%02dT%02d%02d%02d.%06ldZ",
+			    flush_count++,
+			    getpid(),
+			    tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+			    tm.tm_hour, tm.tm_min, tm.tm_sec,
+			    (long)tv.tv_usec);
+	} else {
+		strbuf_addf(&token->token_id, "test_%08x", test_env_value++);
+	}
+
+	return token;
+}
+
 static ipc_server_application_cb handle_client;
 
 static int handle_client(void *data,
@@ -285,7 +399,7 @@ static int fsmonitor_run_daemon(void)
 
 	pthread_mutex_init(&state.main_lock, NULL);
 	state.error_code = 0;
-	state.current_token_data = NULL;
+	state.current_token_data = fsmonitor_new_token_data();
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
 	strbuf_init(&state.path_worktree_watch, 0);
-- 
gitgitgadget

