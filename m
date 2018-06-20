Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5CEF1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeFTUFw (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:05:52 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40814 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932958AbeFTUFu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:50 -0400
Received: by mail-ot0-f193.google.com with SMTP id w9-v6so918798otj.7
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7DEUT9VhLF6C5hwf7tHAu/EjyjuUzjMVK8E2gODrH2Q=;
        b=tN9LLMUAYDw2WfSf8bqhtKsEI/eRxHCVHBqqjN8ovqre5vQmRZlhtQE7mOLjtZN/yT
         vUNt1hf+CSd+z5ynl0Z1yCWPRhVMq+muRdEJdRteYWm4TbWkvAk4mvQWxMriHakYNK8T
         MsyacrDcgbejb+dVW+VDWFIvySOPfpVJrgFs2VOU/SW2JATdK+rb4flmhEgit4qfj+TF
         NLOhAmDm2VaMWT+SHGs9T93WWs9Qdg5niEFFDNOBLR78PmYKDj2GEcPHMXGuxT1ci+Si
         VbnkYEq6FM0w53w9MXuGZ//OX6BmFJXxVLi7STLeiUqjMHdw2OYKGIvDyruCGI+okzik
         Htpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7DEUT9VhLF6C5hwf7tHAu/EjyjuUzjMVK8E2gODrH2Q=;
        b=IAt8Fdd/OszCipiq+pshpOHvzU57vYE7y6ANpp/3/M0olaR1TMcTB/8LLf2o7Z5QST
         R80LLwo0Rt7+56vS6M38WP208t1CHClfzElAmYpAjYCDMUJolVuZCBrc7tzBO4PQ0/Wk
         srnOdizfpmpS/SPy7uzIyHMQlofffNoHW8z5K8tZSmUoScCuJk10fcV53sLQTue9qp6w
         gQbKoGhRC1m2/WToq1RCOoCmnNJT+77I/69OlwJgoUZJjP0NhMXZ6ugy6eqeQqxwTmaq
         rVyT/AKYL3UNX1ghGOqsEpXzwH1CuG5vmOhXN0Q69rhR873FO6To1VTeJ9oT14cDDLcc
         IvUQ==
X-Gm-Message-State: APt69E011PIL37Aht5qMi7F7oFKWPMijZFGX2iMtAjk4gfqxug1+Q73R
        zo6FADUGZQ785AL0rBDVCaRtienFaFw=
X-Google-Smtp-Source: ADUXVKI3P/aJ2W48kesWsepJsgH8eurgaWZOpkw4GOz8EyXokrOlIJc+ebJtfM/a6o/pyN4Q3C1PZg==
X-Received: by 2002:a9d:1553:: with SMTP id z19-v6mr12983700otz.135.1529525149281;
        Wed, 20 Jun 2018 13:05:49 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id w39-v6sm2529692otd.13.2018.06.20.13.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:05:48 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:05:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 6/7] grep.c: add configuration variables to show matched
 option
Message-ID: <13e39136f0e12aac72f300a3a088c0663b83ce8e.1529524852.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529524852.git.me@ttaylorr.com>
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
index 58fde4daea..e4cbed3078 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1183,6 +1183,8 @@ color.grep.<slot>::
 	function name lines (when using `-p`)
 `lineNumber`;;
 	line number prefix (when using `-n`)
+`column`;;
+	column number prefix (when using `--column`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
 `matchContext`;;
@@ -1797,6 +1799,9 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.column::
+	If set to true, enable the `--column` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 31dc0392a6..0de3493b80 100644
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
index d353d5d976..08d3df2855 100644
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
2.17.0.582.gccdcbd54c

