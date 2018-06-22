Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A46101F516
	for <e@80x24.org>; Fri, 22 Jun 2018 15:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933972AbeFVPtz (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 11:49:55 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43372 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933762AbeFVPty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 11:49:54 -0400
Received: by mail-oi0-f66.google.com with SMTP id t133-v6so6513497oif.10
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g5Fi5Q9y5dHkCl9/TbGatIbWvA2CGgTd0oXWzEWjlHQ=;
        b=oWy8UXsQJjXU8wHXcBMpDfiZPPI0j8RMmFdM2xo6bJpHS9A5OWJj+NKhihgJKi0ASG
         MPcPIkuqkiID6DgcVUAjpe3K+UVLVRx4NkNsBTFdGvTxr3lQnm0k9ArysDdE+Ii8oxlL
         bXzPJSmPDLlaXo99i6T9hace6mPgzrEbukcFuTV1XZGtyMJQmxX2tpzAcsey5OAmUS+J
         iH879snoD3xapT8w8ALVzmBx5NQ/JOkbqNCs3/hdQUJPqfYQLn2hFmL0ktEn/Dgy2urU
         ArcYq5w/BZAx83fsDiQCtPrCNlLzaIU8A2fKwxzrlilsdYT80LgtBHE1BQJi9qmcJYqh
         69lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g5Fi5Q9y5dHkCl9/TbGatIbWvA2CGgTd0oXWzEWjlHQ=;
        b=uN5XcSHXPBuqL/0gAM+3Y6zJb4JJVRMHHTFiDOxX6JZHWrp4PpTE/qfq+CnUk5bgv0
         9PiBJixFm5AygcpTJ0gSZbBC2zO9Dv8TvNYDMA942mLrIbxr25C9TRyZsxJqTVp7uJTO
         hE2b6xS4ZzO0/KcnadoS7DnVvHQRHHlLMnSa+AllJ0/ojjiY5X7UGK62xUTrrUIcuDVa
         RjE8qKz9ZWB8l16WWmNNI62OBf+bdO4ePnOLsr3ZBRseM5sStGGq6WxWoJ0m5Tck8gwW
         PQ/672y4t3/iDAdO345OZViQQz1oo1OgprSprcrS9BNzZooamV0m3vHmq4UZH8zAX129
         +vwg==
X-Gm-Message-State: APt69E2gIC6qRxMUEIY0f6f1Ta23PcTxeg0yD8HU+fsiG+XBvvSlcyZJ
        Nk56Y7u14usEkU0fiHWFOE9aL8ZhFXo=
X-Google-Smtp-Source: ADUXVKL52F5oyHIpLb+ecX0/5OlmzrP3LxYKrvH+U3yKhoBxGPts3q7Ie7Q7UFyADXN/D4YpV+MsjQ==
X-Received: by 2002:aca:3f57:: with SMTP id m84-v6mr1077032oia.280.1529682593563;
        Fri, 22 Jun 2018 08:49:53 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id t4-v6sm5314417otf.8.2018.06.22.08.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:49:52 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:49:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 6/7] grep.c: add configuration variables to show matched
 option
Message-ID: <63ad350585a265995b1f16d854c4f1d1df83dd24.1529682173.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529682173.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529682173.git.me@ttaylorr.com>
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
index 83fe32a6a0..992673fe7e 100644
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
2.18.0

