Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF695C2D0EE
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56C6206DB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKjWquDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgC3AcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:32:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56135 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgC3Abu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id r16so202102wmg.5
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PUWgDqsQeya0TY0pdscfoyT+DdJ805syn68daWmskcQ=;
        b=qKjWquDJiAoritAJf5wL9facJiRNJVwPE4l0kPAvFG208+uDNdxBX3dtGc1dyNAi0y
         9qBwmavYfJJsTiS+EfFnK0pVd1/TY10xouZJhfWbRZ8d9EydqBQwnqOpuG6S7JoYipBV
         dCb9Gwf4IPmOMu2KZve0w7IKgFu4WTzyRBhsVkQpDVmLsuvLa0JJZK45KSHC5jBtTzHE
         pWue/rLxytCpAH7SkzZHls43na++lr9URsZf8V8QVDDOzOPJb9i6AmsmMZVntKJUDya0
         58mjxZa4F2Q7vctROLT2xT+a+qyJ/RrGdFFeY4qC5GcQLih2HP2tYaNRoifmsoAqywdp
         IGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PUWgDqsQeya0TY0pdscfoyT+DdJ805syn68daWmskcQ=;
        b=D3mrzmvOWp2OnvW7LXDToQ/4aMeFxLzCVjigvNPx4diANKGHpSPk3ZMNWhXykHtVOY
         mSkHjvDWJdsTO8DVQDUta+1s0bNyvRcOjeNdtbnVYVL8Ac11mzxL4xMp4B/On0JsnMsB
         NWgD9d3vxiWrzXdBIOn5hJ/3F5EPVUU7C8IZMATlGDwzlrGXzMVj+/UIOmg5Ao8tuXB/
         V371QoGj8OCBoUw7+gI/9daLF5GDjR3ycjlbxkvi+uvdcpgBu7LzPtLUS/H4v2iBPCee
         j1M+MqEOtaYyNffARhekZ/Qs96q4sae/Eqz0dBRdNkpw1MAcNt5WBszCjWPDlyzZqFrD
         BrDQ==
X-Gm-Message-State: ANhLgQ2Z6niyU0cqxRGqg0CAvnrsSc4SM7KfayKfxGCOTTSq0ssDsJo4
        DRADwWInhO0TcujEmURAzIyuKe6L
X-Google-Smtp-Source: ADFU+vufGen2VVbmPwIIp1RR0GimRqde8Y9iZgP7LSrnuA4Vvj8cd588ELsB4xbP1Vn7YWOAY0tp8g==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr8298181wmk.27.1585528308218;
        Sun, 29 Mar 2020 17:31:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm19965436wrm.6.2020.03.29.17.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:47 -0700 (PDT)
Message-Id: <55824cda89c1dca7756c8c2d831d6e115f4a9ddb.1585528298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:31 +0000
Subject: [PATCH v3 09/16] diff: skip batch object download when possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

When computing changed-path Bloom filters or performing a name-only
diff, we do not need the blob contents before completing the diff
values. Thus, we do not need to download a pack containing the blobs
we do not have on-disk before completing our diff calculation.

This prevents downloading every blob in a partial clone when computing
changed path Bloom filters. It also prevents over-aggressive downloads
during "git log --raw" commands.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c | 1 +
 diff.c  | 8 +++++++-
 diff.h  | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index a16eee92331..dbcf594baec 100644
--- a/bloom.c
+++ b/bloom.c
@@ -142,6 +142,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
+	diffopt.detect_rename = 0;
 	diffopt.max_changes = max_changes;
 	diff_setup_done(&diffopt);
 
diff --git a/diff.c b/diff.c
index 1010d806f50..63376adb011 100644
--- a/diff.c
+++ b/diff.c
@@ -4633,6 +4633,10 @@ void diff_setup_done(struct diff_options *options)
 	if (!options->use_color || external_diff())
 		options->color_moved = 0;
 
+	if (!(options->output_format & ~(DIFF_FORMAT_NAME | DIFF_FORMAT_RAW)) &&
+	    !options->detect_rename)
+			options->skip_batch_download_objects = 1;
+
 	FREE_AND_NULL(options->parseopts);
 }
 
@@ -6507,7 +6511,9 @@ static void add_if_missing(struct repository *r,
 
 void diffcore_std(struct diff_options *options)
 {
-	if (options->repo == the_repository && has_promisor_remote()) {
+	if (!options->skip_batch_download_objects &&
+	    options->repo == the_repository &&
+		has_promisor_remote()) {
 		/*
 		 * Prefetch the diff pairs that are about to be flushed.
 		 */
diff --git a/diff.h b/diff.h
index 9443dc1b003..e9f104309c4 100644
--- a/diff.h
+++ b/diff.h
@@ -281,6 +281,7 @@ struct diff_options {
 	int show_rename_progress;
 	int dirstat_permille;
 	int setup;
+	int skip_batch_download_objects;
 
 	/* Number of hexdigits to abbreviate raw format output to. */
 	int abbrev;
-- 
gitgitgadget

