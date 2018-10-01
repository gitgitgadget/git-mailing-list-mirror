Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8871F458
	for <e@80x24.org>; Mon,  1 Oct 2018 13:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeJAUYL (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 16:24:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40923 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeJAUYK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 16:24:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so8081130qkd.7
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZFs2cWfXY5Vkei9co775BZu9f2tKUVs33fE5K6Cv+k=;
        b=jWZ9/9oJouBOeYcNDZPyGbUoUfAyQmm1A4EE8eRgKsc/1BRDrhDl3HTdnY7w5L+KX8
         hd4un/T/pySMuJ9wyToeK3Vj7v46olcR0ZGA0C/EDr2MndGVkjWkSyoTPg7F2FOdc3hF
         U6gJfqVFIzKr+OyShVJ63Bdku/L1jrqzgr1KPEzTPMShvI+Haifu53HFOKDY1ktp1XUI
         PDnKs6TldrWnDzPb09bjIelJnq8uDO+ieoNmaQsh6pK9tPLv22oXDYwbInFxZuNRmeOs
         mnGJuiUF/nJsmHdEvXNB8CNnk36yovY+YH6/S3tXwV2mYx5E3Li5/yEp1Bx17XzHSVNz
         Jlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZFs2cWfXY5Vkei9co775BZu9f2tKUVs33fE5K6Cv+k=;
        b=IEPnZPxU3/SFAVsuG6vv0dd2Gxin/C5yD8b2pSyICAHSb5Zanuwrm7+xMxRrNHqzpx
         CXjwIOAwDNph7Y1APmiSLPqMe2t6E+tXSJhhAuDIYk4nFF6k2KxrcvJWEuVL2yUPSvxr
         IMzNijrXROhFqzx/fVqq01mCQYBE1741xHtt8/muEW25/BeFJnur/O1FBFOvfq2wEv/9
         VKHnhNmXbV6zNBIwDVPrmcKinOanSr88eZIvsP1JD92Fe1DIVybai/Qqw2beIBTN96Ik
         gT3OMO2I4phCwlPD43EcR+faHThRHroy6J9X1LVoNTV1E2/Q/g3RVBm6ut16lUneOVM6
         bu1w==
X-Gm-Message-State: ABuFfogC/NW2bq0xBmlvx4emTzHZCOP2cIOixC//Sd5A4/pMj8TxG6a9
        UYkS1C2Eeb+R/e1oZ48FC1DXEYKM6sI=
X-Google-Smtp-Source: ACcGV62biq9a2TTLHpp0XiJrjbtneNQzlhHO0AWMCcuj47/exeIDWbU+z1CBfRp51doqL7V+S354iA==
X-Received: by 2002:a37:4653:: with SMTP id t80-v6mr7998845qka.314.1538401576324;
        Mon, 01 Oct 2018 06:46:16 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f129-v6sm6763435qkb.40.2018.10.01.06.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:46:15 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v7 4/7] config: add new index.threads config setting
Date:   Mon,  1 Oct 2018 09:45:53 -0400
Message-Id: <20181001134556.33232-5-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181001134556.33232-1-peartben@gmail.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
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

Signed-off-by: Ben Peart <peartben@gmail.com>
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

