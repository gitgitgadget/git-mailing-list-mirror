Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB14B1F424
	for <e@80x24.org>; Wed,  9 May 2018 02:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933572AbeEICNq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 22:13:46 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42385 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbeEICNn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 22:13:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id u6-v6so3339656pls.9
        for <git@vger.kernel.org>; Tue, 08 May 2018 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bva/wbvpF30dWnYIfEQw4CxlZ4e+agqKZtpoaNMwtPI=;
        b=pRoAKKaf0MLJrj8w4aGMBAdBBDT3zfXVmI1ayRRQG0hU9IOmbj7z/b4JJwFpfFx74H
         o6/RZgvOJOSBEMwgRoKmi2s15gGL57AsueEEKqD5l9KbEi0t6+ICRXrD/3ySGwBUbgJs
         qweU+AV+BcxjvBjaFigPIGpA14BPpG+HzkVtYFszr46UD4CjnaYGoXk3OL9ZViRIxYp0
         ePjjPCsXRxY92eSIKcBqAntKy1P76iPy9/bB4vLYx86+NbHuUpLW37zNHAQhbXWModVb
         omVg7IyOsM4BiF2Vb5Y5432xtj57CK6IQoeN+P6BYZ2XHaqPQjJGZcpxfcWBzZ9MNNnX
         q5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bva/wbvpF30dWnYIfEQw4CxlZ4e+agqKZtpoaNMwtPI=;
        b=lAaDZfLnepqvCKr7pPapnhrZfkY+UUOHOHO0C24ntqTD/2zo6EzZdgHmAP+nObxzOA
         pH1UMo88wT01Qqd/jqezNNApA0Mw00/12GxOUSpuzGVU0EkCyfvKsUDFnpvqEwD4U46s
         jFp2YkH45eomI33fAOgua1I436vAtlrIyRXq5u2R1xmPpiJhRCW2lsZe22jRU5bYrZyQ
         fRYDW/S1NXxDM47y1S8cIzp1JIIGVc9gqwqE/1kyspaqOkavXz1MPcs1tQyCJoi81wG5
         0NrsgQIu5lalnocAjJAk2DoLPhosWO+e3bUs8OJ6Vi16F2rbeuEYyOhjKS0BvZUWMwGV
         Bn1g==
X-Gm-Message-State: ALQs6tAaE7boltafwZU5WfIx8PmWhFQWqQ2dBcE6SbM9ro5iDOUHIsAY
        JwIfX1ws6yJBBxGbnE9GAr5J70MBoLjyHg==
X-Google-Smtp-Source: AB8JxZqM5ySKz9tGqWjz4AIEV5ijmXlXB7V7hCY6k7qMtYDEugnI0pu+I1hKwFaG0z5Iv7RM2RIy2w==
X-Received: by 2002:a17:902:6006:: with SMTP id r6-v6mr42774472plj.70.1525832022727;
        Tue, 08 May 2018 19:13:42 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:d537:72d4:95b0:7812])
        by smtp.gmail.com with ESMTPSA id u131-v6sm41345045pgc.8.2018.05.08.19.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 19:13:41 -0700 (PDT)
Date:   Tue, 8 May 2018 19:13:40 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        phillip.wood@talktalk.net, sunshine@sunshineco.com
Subject: [PATCH v5 6/7] grep.c: add configuration variables to show matched
 option
Message-ID: <1b187e77c26a075878d6fc561ad289a0408f797e.1525831201.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525831201.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To support git-grep(1)'s new option, '--column', document and teach
grep.c how to interpret relevant configuration options, similar to those
associated with '--line-number'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt   | 5 +++++
 Documentation/git-grep.txt | 3 +++
 grep.c                     | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e8d969f52..b3c861c5c3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1159,6 +1159,8 @@ color.grep.<slot>::
 	function name lines (when using `-p`)
 `lineNumber`;;
 	line number prefix (when using `-n`)
+`column`;;
+	column number prefix (when using `--column`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
 `matchContext`;;
@@ -1708,6 +1710,9 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.column::
+	If set to true, enable the `--column` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 75f1561112..dc8f76ce99 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -44,6 +44,9 @@ CONFIGURATION
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.column::
+	If set to true, enable the `--column` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
diff --git a/grep.c b/grep.c
index f4228c23ac..5d904810ad 100644
--- a/grep.c
+++ b/grep.c
@@ -96,6 +96,10 @@ int grep_config(const char *var, const char *value, void *cb)
 		opt->linenum = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "grep.column")) {
+		opt->columnnum = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp(var, "grep.fullname")) {
 		opt->relative = !git_config_bool(var, value);
@@ -112,6 +116,8 @@ int grep_config(const char *var, const char *value, void *cb)
 		color = opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color = opt->color_lineno;
+	else if (!strcmp(var, "color.grep.column"))
+		color = opt->color_columnno;
 	else if (!strcmp(var, "color.grep.matchcontext"))
 		color = opt->color_match_context;
 	else if (!strcmp(var, "color.grep.matchselected"))
-- 
2.17.0

