Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F196C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B77B20731
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JltYkhaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgELVoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgELVoe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 17:44:34 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD23EC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 14:44:33 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dt19so4033757qvb.5
        for <git@vger.kernel.org>; Tue, 12 May 2020 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3ukbjKTcqFReYJQeapc6Akxqxjwl3vl07j0HRYghJhE=;
        b=JltYkhaGR9gJYllZ+ZMTbmTIg2gU2rQh3xlvCc7fZ+SHoCY2v/5l/j/0bm0M2lsKM0
         RpFpFTJhjlKaM1XfETxRi5lWBnAGs5IBToBmuGi2PFKstTdrOLDEDzHmrtPqXoIYbYVm
         ccbKMKypqyJ0vww62M2s5eGTCmnyqvYtHr05rbIf2J7idu2ap5uLIrDMFicQZx9boyGE
         XVwoSxMmuAnIbQgQ/xhGxc9nJSUSwfxtxfkAmdRhYnInz7/NZZM1Nu/q+8AoN/iWneYZ
         ModxEYykkB9fZ7WGBz2UrT6cYZpZdzOFVwG0cTw8jSGI1KsaSj8N7XlES2AkBP96azjn
         2TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3ukbjKTcqFReYJQeapc6Akxqxjwl3vl07j0HRYghJhE=;
        b=EB5tX/6V1TyW5DgUSGMQbKKjc11pvRKEg+NyUHKBZZ9pKw63QOyec144UetL3SsTjo
         Y8QCDdw9QkjfJ0S1M+EUpGHHLhSBwcnmOS8uA+w1hnXKH6ZBUwLBHlNQhYYz0j5FQYIk
         Vs15u6RUOLUuY329QufGBB1cnlad54zH+1lx3ZKuMgYGtiq1ub9Xmqul2dvC3E+so/Ot
         vXpJgYqJuLU1qhijC0ccVcMthnK/Moa47NJPisQPQO1as0mUZ9DxD4Gz40m5KlKRGRvH
         IFL8GUYU94xLVRAgS/lgxFvLhjrdXTa7Wal/rss44IjACNmQHoeh5E6XVOyQDR71W+6N
         sVYA==
X-Gm-Message-State: AOAM5329ktQ+jgKtjDMDPuBVf9zy10sKxww4YmQ8wqM2O7gByW+9X1oG
        CbpLuiCxGg2mVhi6KVXR7zTjZ4pLOsPc14yCFFZQeiTVeJycMCGQ7ZFLVj8t2KTI7k2BrSQG3/x
        KihloRp/XLI3w0xaPNUTfervIWU8RGiS4WgywQX9v3ChZAOl1JUpOS3Pt2vpbflGkCeql4XFvUQ
        ==
X-Google-Smtp-Source: ABdhPJx8vGdc4Q8ExDYmnc67yiEnhezHxtEtGM4/Ln4S0705QVznBg6xHAh2qNSjsHxrdcGRaKjVlA379Nzh+ujA+g8=
X-Received: by 2002:ad4:52ec:: with SMTP id p12mr7598293qvu.65.1589319872919;
 Tue, 12 May 2020 14:44:32 -0700 (PDT)
Date:   Tue, 12 May 2020 14:44:20 -0700
Message-Id: <20200512214420.36329-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] trace2: log progress time and throughput
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than teaching only one operation, like 'git fetch', how to write
down throughput to traces, we can learn about a wide range of user
operations that may seem slow by adding tooling to the progress library
itself. Operations which display progress are likely to be slow-running
and the kind of thing we want to monitor for performance anyways. By
showing object counts and data transfer size, we should be able to
make some derived measurements to ensure operations are scaling the way
we expect.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
One note: by putting trace collection into the progress library, we end
up with data events which have titles like "Receiving objects" - not
very machine-parseable. An alternative might be to ask for a
machine-readable title in the progress struct, but I didn't think it was
worth the code churn. However, I don't have experience with processing
the trace data after it's been collected, so if this is a bigger problem
than I think, please say so and I'll figure something out.

CI run here, although it failed on the same error Junio noted today[1]:
https://github.com/nasamuffin/git/runs/668457062

 - Emily

[1]: https://lore.kernel.org/git/xmqqtv0kc2q1.fsf@gitster.c.googlers.com

 progress.c                  | 17 +++++++++++++++++
 t/t0500-progress-display.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/progress.c b/progress.c
index 75633e9c5e..6d2dcff0b6 100644
--- a/progress.c
+++ b/progress.c
@@ -265,6 +265,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
 	set_progress_signal();
+	trace2_region_enter("progress", title, the_repository);
 	return progress;
 }
 
@@ -320,6 +321,22 @@ void stop_progress(struct progress **p_progress)
 {
 	finish_if_sparse(*p_progress);
 
+	if (p_progress && *p_progress) {
+		trace2_data_intmax("progress", the_repository, "total_objects",
+				   (*p_progress)->total);
+
+		if ((*p_progress)->throughput)
+			trace2_data_intmax("progress", the_repository,
+					   "total_bytes",
+					   (*p_progress)->throughput->curr_total);
+	}
+
+	trace2_region_leave("progress",
+			    p_progress && *p_progress
+				? (*p_progress)->title
+				: NULL,
+			    the_repository);
+
 	stop_progress_msg(p_progress, _("done"));
 }
 
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index d2d088d9a0..1ed1df351c 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -283,4 +283,30 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	test_i18ncmp expect out
 '
 
+test_expect_success 'progress generates traces' '
+	cat >in <<-\EOF &&
+	throughput 102400 1000
+	update
+	progress 10
+	throughput 204800 2000
+	update
+	progress 20
+	throughput 307200 3000
+	update
+	progress 30
+	throughput 409600 4000
+	update
+	progress 40
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
+		"Working hard" <in 2>stderr &&
+
+	# t0212/parse_events.perl intentionally omits regions and data.
+	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
+	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
+	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
+	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
+'
+
 test_done
-- 
2.26.2.645.ge9eca65c58-goog

