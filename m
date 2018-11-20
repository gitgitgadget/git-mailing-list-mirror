Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8EA1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 06:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbeKTQjs (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:39:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44435 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbeKTQjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:39:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so457654plq.11
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 22:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AiXYsn7ACzT9CmqR9XDYyAlUWi1R2eSflKxOlx0UgeQ=;
        b=Q5solX1lufHghId7dYm92pj3vzwnYQ1d/vgIUnshtud9eTuKFc65TvFP6rJDzMDkSI
         0nIQCrQxNxnAyYQHywsxr95jlnm9dKHYrFLlbqF1ActVL+NJcwIuvozvkvVpZti20Hg4
         vnoYICsg38p8kD/Tjl/4TyuS1l9PWAl0ZAPuk4k/9ruNGT66WWDzS083bUz+C1e1WMX/
         RSL4BMdplN7EpD11/CpAW9w4G/vYH7xYoO3lQJrmiWh7kAFsPm6tr65tcKMv+c0OTfkh
         oLwmWtUzLoXohmatEVcwu88CGWR3f9Ddhf6IsyC74K7J3LXRylH392H1XalUPI8LrfN5
         5/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AiXYsn7ACzT9CmqR9XDYyAlUWi1R2eSflKxOlx0UgeQ=;
        b=tDmsH+5FLakn95ArvPVytvSEoxEBhCemhp8GAd3jWSlO69FkDMHRxchhs73Ps3VK2M
         LNUlfeW8oYxB3hyiEeVH2a5oGIJ5lUktFsGHin37q+PPmd/Kfvtl/J3eDlZJd6Ngmqyc
         B1lUK5tkGKkzeSRqAYy69Jqnlo8MFlLexn/aIpiDdhlviI3OZjurSLBCXQAssG7IEkn+
         1dWyWurGt5Fuc7PgT8Hj6ppzaHA70Bf/VQtwCx1RLdDALWnEdCobOVN9L7OklRkLG21D
         PauISkXmk50GxsjYcCgE5hsHFwPk/iVNTwWKwDYWIWVm40bCh0CCzYYhrxU2nkGM9RO/
         NtkQ==
X-Gm-Message-State: AA+aEWYjw2IgfRhk2QjD8cRAAUyf+AZ+fO09GpU06HbXSR/Vk1TQxVYO
        j6Z9MpMjPG747l4o32WrriE=
X-Google-Smtp-Source: AFSGD/WDccefAIajEUHmWo5Y5OJreRwFP9RecAGOJE2OmYXPZcP11OElMd6Wa8bzIkVPEpAwQM5d3g==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10mr875888plb.266.1542694344122;
        Mon, 19 Nov 2018 22:12:24 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id x26sm21703410pfn.50.2018.11.19.22.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 22:12:23 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:12:22 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: [PATCH 2/5] ieot: default to not writing IEOT section
Message-ID: <20181120061221.GC144753@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120060920.GA144753@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with EOIE, popular versions of Git do not support the new IEOT
extension yet.  When accessing a Git repository written by a more
modern version of Git, they correctly ignore the unrecognized section,
but in the process they loudly warn

	ignoring IEOT extension

resulting in confusion for users.  Introduce the index extension more
gently by not writing it yet in this first version with support for
it.  Soon, once sufficiently many users are running a modern version
of Git, we can flip the default so users benefit from this index
extension by default.

Introduce a '[index] recordOffsetTable' configuration variable to
control whether the new index extension is written.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As with patch 1/5, no change from v1 other than rebasing.

 Documentation/config/index.txt |  7 +++++++
 read-cache.c                   | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index 8e138aba7a..de44183235 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -5,6 +5,13 @@ index.recordEndOfIndexEntries::
 	reading the index using Git versions before 2.20. Defaults to
 	'false'.
 
+index.recordOffsetTable::
+	Specifies whether the index file should include an "Index Entry
+	Offset Table" section. This reduces index load time on
+	multiprocessor machines but produces a message "ignoring IEOT
+	extension" when reading the index using Git versions before 2.20.
+	Defaults to 'false'.
+
 index.threads::
 	Specifies the number of threads to spawn when loading the index.
 	This is meant to reduce index load time on multiprocessor machines.
diff --git a/read-cache.c b/read-cache.c
index 1e9c772603..f3d5638d9e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2698,6 +2698,15 @@ static int record_eoie(void)
 	return 0;
 }
 
+static int record_ieot(void)
+{
+	int val;
+
+	if (!git_config_get_bool("index.recordoffsettable", &val))
+		return val;
+	return 0;
+}
+
 /*
  * On success, `tempfile` is closed. If it is the temporary file
  * of a `struct lock_file`, we will therefore effectively perform
@@ -2761,7 +2770,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	else
 		nr_threads = 1;
 
-	if (nr_threads != 1) {
+	if (nr_threads != 1 && record_ieot()) {
 		int ieot_blocks, cpus;
 
 		/*
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

