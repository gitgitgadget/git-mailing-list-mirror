Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFFF1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJJXWn (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 19:22:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35758 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJJXWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 19:22:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id v19-v6so6251649qtg.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aBPf2za6nKHCvpeqqCz4bJrAxFunCwTylZ9S/Zn8TFE=;
        b=L7ZqnYdXyqpI9PNL3hLldtGacxhVRhTr0CvQo3E5qjcDvkVWnVdhaCv0PrQd2NQxXJ
         rhGakVnhvauMrupjc/g+Srsa3efMvjQgzT2btgJ5ADDbrOUqnVg3FeFFqatlBX6uy2tk
         EV85ZCgvH26B+j4Z71EgzWLUXU7leZFD5i/8wzZ0JD6szaLBFfYlEu29McS5AAigQm4i
         Qfha89PCPgB0Jq+z/nFvPZYZ1pxgsRs5EKR/67Cyx3+R4V3jz+Sl7vn24C2T81t7a9h/
         5J72QiiskyuIq4QX1jQ8UZm2jloCeM+9uCQLMs588niLy6U5wCIZM3qlRJHk86oV56xa
         wyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aBPf2za6nKHCvpeqqCz4bJrAxFunCwTylZ9S/Zn8TFE=;
        b=cHT81nt6hVeYw75mAgJL2Ic1uLKowrtixDTDRm+AHbRbypwpCrFggyuWwXNdWWyCsl
         AMdM0dNhRUPslTeA3Eds9HZs+UTy9bqkDKf6b8AbWoOpe/mcMwnXaFrkG/acQZSq5xX9
         LvQIIYHq3u9Nu45z1BzmJEzNCUYxzV3z0y/sGr4B/gfAdhCgsaxW9QGvNfWrl3ZOHu3y
         QpCpKykwEbIdQzr2ACsLJzfRFo7Qveen/ONA19kTITO/keQdlRWujh3aCVLtnKx66Cb7
         kB8HiUHmrRkMK2zHJQY65X5XzYIqKksIauZzbR3vAoS9erd1YPyEN52hyDQJoW9sjtNy
         UnWQ==
X-Gm-Message-State: ABuFfogVqu/42hVWj9hoadgyKk4TP8zdT6xddaqK/6XVAIQsEAJ3+S7t
        o/yxUe3ZlDihkeEaHAUA8dr0VGdBrVo=
X-Google-Smtp-Source: ACcGV62NLKL86uGPtdqrM5KmTryhQDhBHQNjCwuRLb2K0m1diWNjq8WIz89HGFezqESHnSbWIbMYww==
X-Received: by 2002:a0c:ec4f:: with SMTP id n15mr13858227qvq.91.1539187194513;
        Wed, 10 Oct 2018 08:59:54 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d89-v6sm13704920qkj.29.2018.10.10.08.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:59:53 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v8 4/7] config: add new index.threads config setting
Date:   Wed, 10 Oct 2018 11:59:35 -0400
Message-Id: <20181010155938.20996-5-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181010155938.20996-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Add support for a new index.threads config setting which will be used to
control the threading code in do_read_index().  A value of 0 will tell the
index code to automatically determine the correct number of threads to use.
A value of 1 will make the code single threaded.  A value greater than 1
will set the maximum number of threads to use.

For testing purposes, this setting can be overwritten by setting the
GIT_TEST_INDEX_THREADS=<n> environment variable to a value greater than 0.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt |  7 +++++++
 config.c                 | 18 ++++++++++++++++++
 config.h                 |  1 +
 t/README                 |  5 +++++
 t/t1700-split-index.sh   |  5 +++++
 5 files changed, 36 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ad0f4510c3..8fd973b76b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2413,6 +2413,13 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+index.threads::
+	Specifies the number of threads to spawn when loading the index.
+	This is meant to reduce index load time on multiprocessor machines.
+	Specifying 0 or 'true' will cause Git to auto-detect the number of
+	CPU's and set the number of threads accordingly. Specifying 1 or
+	'false' will disable multithreading. Defaults to 'true'.
+
 index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
diff --git a/config.c b/config.c
index 3461993f0a..2ee29f6f86 100644
--- a/config.c
+++ b/config.c
@@ -2289,6 +2289,24 @@ int git_config_get_fsmonitor(void)
 	return 0;
 }
 
+int git_config_get_index_threads(void)
+{
+	int is_bool, val = 0;
+
+	val = git_env_ulong("GIT_TEST_INDEX_THREADS", 0);
+	if (val)
+		return val;
+
+	if (!git_config_get_bool_or_int("index.threads", &is_bool, &val)) {
+		if (is_bool)
+			return val ? 0 : 1;
+		else
+			return val;
+	}
+
+	return 0; /* auto */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
diff --git a/config.h b/config.h
index ab46e0165d..a06027e69b 100644
--- a/config.h
+++ b/config.h
@@ -250,6 +250,7 @@ extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 extern int git_config_get_fsmonitor(void);
+extern int git_config_get_index_threads(void);
 
 /* This dies if the configured or default date is in the future */
 extern int git_config_get_expiry(const char *key, const char **output);
diff --git a/t/README b/t/README
index 3ea6c85460..8f5c0620ea 100644
--- a/t/README
+++ b/t/README
@@ -327,6 +327,11 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
 be written after every 'git commit' command, and overrides the
 'core.commitGraph' setting to true.
 
+GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
+of the index for the whole test suite by bypassing the default number of
+cache entries and thread minimums. Setting this to 1 will make the
+index loading single threaded.
+
 Naming Tests
 ------------
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 8e17f8e7a0..ef9349bd70 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -6,7 +6,12 @@ test_description='split index mode tests'
 
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
+
+# Testing a hard coded SHA against an index with an extension
+# that can vary from run to run is problematic so we disable
+# those extensions.
 sane_unset GIT_FSMONITOR_TEST
+sane_unset GIT_TEST_INDEX_THREADS
 
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
-- 
2.18.0.windows.1

