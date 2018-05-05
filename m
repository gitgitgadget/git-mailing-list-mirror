Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D211200B9
	for <e@80x24.org>; Sat,  5 May 2018 02:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeEECnL (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 22:43:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44492 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeEECnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 22:43:08 -0400
Received: by mail-pf0-f193.google.com with SMTP id q22so18779283pff.11
        for <git@vger.kernel.org>; Fri, 04 May 2018 19:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ujfVIKBqV138rzi1xA1bthqoRZge062l45l/J1vn1rs=;
        b=tqwnJLQIyzusIHhJV0Lii0BBI6ByEDcX2S+oe/zOchZPso6uHHmu3c75VPFfO7OH2L
         3W3EEZe3m43hZzkp2Tg0Z7vbLv0nPRHwVHyFI5JSHk6NXIxlR4/bf1enfZiYsB5uoAOL
         k9JlJjEp9D+LrGXDDLtRkPPTuYB/SXdaJpXIcgsYdOJH69GZp9RwXaRunw63p94OJtiy
         Rszlyw38TmqbxqY3Xsq+rU6fqT9JMvbdwzsuJINLBV3S44qFxGmgjrcsKPtREYNFo+XL
         vaa7m0iwJnFIaM2j+S/ZdIYog+ZDYrHdoXlHF1Eci7l8MHDpJX5R+jrFJCXS89mkdMAe
         wYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ujfVIKBqV138rzi1xA1bthqoRZge062l45l/J1vn1rs=;
        b=G9QedUtzHkH5Ii0tQmPej7M1uMMbYeo5KSOsHkdJtsD7mZVD0U4UQRUTQg/VihtB3J
         GSprpXg8coW9/hJ6I2KOFZqFaJlX5fiY1ZuhyU0Gpb/stb1JGE0OGHNuVmKQqjjuPD4G
         Y3P34ljeuSdtouNoksL5gMksJjOtegVJL+M8W/8c6GS9dPejuUxjFLjrNv9Q8vg0oaQ9
         Ry9qW4UOMHat9cIRomcsHRAu3xdgfDArU+gJEXHf8YJcA3svvj7UQjDzdU1r/Fd6yo7+
         6RW/XjjSUu1j/9C/SI/gd8MtMpbKCUf2m94Gc8++wlE/e4W7HAyTPkxPNx7HuPik9mi+
         S8kg==
X-Gm-Message-State: ALQs6tD6+SU1x3uIosAFq1sIvQb/bheHA8HMxfExSNt9IDYBXFiDaZ93
        nS59uhyPvLZiVcDoTyr7tJQFx0Q0ZTPxmA==
X-Google-Smtp-Source: AB8JxZqyI1dgYZ1k8gGGJKbTDa85tcemAmMQZ/Y2gQDLdna+ui/CYd4fJAC/tgZ3W5QMexBu51aHiA==
X-Received: by 2002:a65:4a46:: with SMTP id a6-v6mr1853649pgu.227.1525488186883;
        Fri, 04 May 2018 19:43:06 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id x186-v6sm27779397pgb.6.2018.05.04.19.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:43:05 -0700 (PDT)
Date:   Fri, 4 May 2018 19:43:04 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 6/7] grep.c: add configuration variables to show matched
 option
Message-ID: <81c686385848056723883b9ef031b9dc5393f9f6.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525488108.git.me@ttaylorr.com>
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
index 5409a24399..d451cd8883 100644
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
index f3fe416791..37bb39a4a8 100644
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

