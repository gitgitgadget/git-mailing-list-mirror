Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2891F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeI0CJe (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:09:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43851 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeI0CJd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:09:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id l16-v6so215387qtq.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xJn8qwab5K3lfhvxcZJA90PuF+dlIK6yO6YmbehqDM=;
        b=M0Ir3GfB3pnJj7HD45Q7w7TZGOMoOfOPm1eajDGCwO4mku2YpoIfMcSOWHarSiGD4e
         n41l8mlIeGAJkdizFywTRDdl+emfcyneAQguhDtFI4/SZ9hDpQiri2BojVX8oceknBlV
         pwMQhmJlHjzDauxfecsYzapNMLV3vP4zmfywPMzb268pYsuAfZUgs7smcIl/NDy9G0Hs
         pjFoZuxzOX1iI7hjvDvARpmFI8FyANCuQIl6ypRge8mxQvl0lfJCRECvTOJ6TfSNuje2
         3PW5J0QlsKQcqPBJP5zGvR5p9an/ej+a6KibqlRBUloNsk/E/wcEhWuiwK2uJWGzmYuL
         dLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xJn8qwab5K3lfhvxcZJA90PuF+dlIK6yO6YmbehqDM=;
        b=JXnIlzGUNmdu7DAkCsKXJ7x7uKef6dm6kbZ8LecqeLino+FXspBzwWwpGeAFqnlJXb
         OkHDG055mlxrYFRVSVhkWe2gPNYFbY7nf22YEcdRhtBsEzlSvQ8GqJcxh3iP2Rww0XAQ
         Ls30DpTuBHc+yOtXCHHH0H2ogvgHahTzidkgUmBL3+fLnxTAYS6NT5bmjwanVTjsfrfA
         E9aXV0D/4y1sgCxBLknYORxLIHa2Ed4dnHdMeuMYWroPDApuzMBjM8hYjHIH8A4v+cVN
         Yd1/j8uehCU7KciTK87mgQZRb2Mhfrl1PFV93P+NOA8Z7E4vj6jwbqpiXwRF+CtBTpZp
         M/5Q==
X-Gm-Message-State: ABuFfog02IXW7ulPNlVFfTQrnPXkXFdAKYxsykzzjBGMEvAQssXznSJk
        Ls0CmHo307QUORzKqg57JgUUZaCBGco=
X-Google-Smtp-Source: ACcGV63SiCIdskNWoJu3flkhL09zVaLzRMblyL2TRE76fTl6fz6yBWj90j/z8Ay48WgUKRMMlA1CHA==
X-Received: by 2002:a0c:eb8d:: with SMTP id x13-v6mr5505573qvo.200.1537991698507;
        Wed, 26 Sep 2018 12:54:58 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 23-v6sm3314922qkn.11.2018.09.26.12.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:54:57 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v6 4/7] config: add new index.threads config setting
Date:   Wed, 26 Sep 2018 15:54:39 -0400
Message-Id: <20180926195442.1380-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20180926195442.1380-1-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for a new index.threads config setting which will be used to
control the threading code in do_read_index().  A value of 0 will tell the
index code to automatically determine the correct number of threads to use.
A value of 1 will make the code single threaded.  A value greater than 1
will set the maximum number of threads to use.

For testing purposes, this setting can be overwritten by setting the
GIT_TEST_INDEX_THREADS=<n> environment variable to a value greater than 0.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Documentation/config.txt |  7 +++++++
 config.c                 | 18 ++++++++++++++++++
 config.h                 |  1 +
 t/README                 |  5 +++++
 t/t1700-split-index.sh   |  1 +
 5 files changed, 32 insertions(+)

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
index aa33ac4f26..0fcecf4500 100644
--- a/t/README
+++ b/t/README
@@ -332,6 +332,11 @@ This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed
 as they currently hard code SHA values for the index which are no longer
 valid due to the addition of the EOIE extension.
 
+GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
+of the index for the whole test suite by bypassing the default number of
+cache entries and thread minimums. Settting this to 1 will make the
+index loading single threaded.
+
 Naming Tests
 ------------
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 1f168378c8..ab205954cf 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -8,6 +8,7 @@ test_description='split index mode tests'
 sane_unset GIT_TEST_SPLIT_INDEX
 sane_unset GIT_FSMONITOR_TEST
 GIT_TEST_DISABLE_EOIE=true; export GIT_TEST_DISABLE_EOIE
+GIT_TEST_INDEX_THREADS=1; export GIT_TEST_INDEX_THREADS
 
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
-- 
2.18.0.windows.1

