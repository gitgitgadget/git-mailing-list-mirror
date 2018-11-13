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
	by dcvr.yhbt.net (Postfix) with ESMTP id 042DC1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 00:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKMKfQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 05:35:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35915 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 05:35:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id d13-v6so5123328pfo.3
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 16:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0rprTkyxA1WUy4p+2Urn5JlrcSrhko0rI3k8xPhmqR4=;
        b=qnZU1GjY3R4py9g4iWSOs/yqC88VK+s2vM7cDVSJyIpy+5Lhn1fJnTFVAvINdVRb1B
         uPlQnN438PzXW23WYHAqW8jdJEaLRksIyfYWA5kW0etl0BEyYh8IBjEUA3Fqe2cCL8yr
         hDXuGCg2Dso5J1hT4ApjARIUDf39IHbnfa2xDhZyfzzrWNXn1pB0G7sVV93LzgLuyYh9
         lc6dH9RiPQpnTiPeCelHeCWUMKsjx5gyaxGZKs4ZwxjLelw2dE2rRAyW4ykqjvrq/J8M
         pzyNPV3xcEhPvycuEWwxS1hKY+jnOMdg5nAxWzRm80rmiwX5ovPfiir8o07yZFBHrBFQ
         Fq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rprTkyxA1WUy4p+2Urn5JlrcSrhko0rI3k8xPhmqR4=;
        b=BRtkQRVQdxI1U8SibIwY1ZqxiGJBzqEqIQ5pRruu67fM6vZK9tfHwc2Djjt9c+Wj6s
         0k60gN+jtRXB4wXYeFRJATN8K3AhzDIUqe/hNWNOwbMRWOMYNTQjkRXESfr8gpgTZAja
         c37nLQQluNXWFE4iOYTh1twFJWcr+ZEdKNz/7JzfYLF8rC2Wc13wCEQ360Dxo+hr4DR2
         lkffRCUIqilj8FXuQZ6IWE+HZjuUUymthBJHGzFi5ZxEgD/7+gxnwg3YpzkspzoQ0bGo
         4VD2Yks9T9McjPIXKQkjMUxNYFqZ6BQILlZipPfRKKLOGYaGUNyNEIA3dmJcAvJw7JVH
         dZBw==
X-Gm-Message-State: AGRZ1gKjSLgNkl233DZuCfe4i+0RZ/KvFrnr4PPQu0cUAsTA+Ml1dfyy
        fmWLE5H8VhIZR7DLHCQ8S5/vtyKZ
X-Google-Smtp-Source: AJdET5dbA/75y3ncPOfA+fELzhK8wQLBQ2VFwdAsvPuiacrfRqNhtPnYiD/DGS+6mcC/yhschMjLZw==
X-Received: by 2002:a65:6684:: with SMTP id b4mr2771160pgw.55.1542069580627;
        Mon, 12 Nov 2018 16:39:40 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id g7-v6sm19023472pfo.139.2018.11.12.16.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:39:40 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:39:38 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH 2/3] ieot: default to not writing IEOT section
Message-ID: <20181113003938.GC170017@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113003817.GA170017@google.com>
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
 Documentation/config.txt |  7 +++++++
 read-cache.c             | 11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d702379db4..cc66fb7de3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2195,6 +2195,13 @@ index.recordEndOfIndexEntries::
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
index 4bfe93c4c2..290bd54708 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2707,6 +2707,15 @@ static int record_eoie(void)
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
@@ -2767,7 +2776,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 #ifndef NO_PTHREADS
 	nr_threads = git_config_get_index_threads();
-	if (nr_threads != 1) {
+	if (nr_threads != 1 && record_ieot()) {
 		int ieot_blocks, cpus;
 
 		/*
-- 
2.19.1.930.g4563a0d9d0

