Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F112E1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755812AbeDXFH4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:07:56 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37143 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755724AbeDXFHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:07:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id a13so5510263pgu.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NdVMZVjMEqliGic61FpTp8a743C9nKbX4afU7DsAmRY=;
        b=Fpe/YwUrDUdZizFPxGEhktkggzeNshkih4so2M/If7CDDmmrgX4kx8QGkfzIEcsG6l
         JYcRvwaiNpGYDgLGjO+H5xPYErglVTx6EdeWfrlzeVilUMox9HRkWNnZXgvcWMxXCYN9
         PSvgkSaErd9FsrwOj9ywa7eNpCSugyPWbv0YKRNAnpuNISbhKy9bgnXatuWVkTdKYr8A
         X7uzwLRQMfHmlR3oAHLzAGoBXY0HkkmckK6xwI4UQmk6BeHYjhrGwcRkEXQIAkJhrOt0
         2RMDKiHqGooeFj4otyWkp+u4p7hJusVAwoD9m4wSuv2dS12iUaq3K3zNi2eFJxMBSY1J
         mAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NdVMZVjMEqliGic61FpTp8a743C9nKbX4afU7DsAmRY=;
        b=a7kkx9KjT+4DQlZFRISGbidVbSo2c25wuurQsfuDSLKXarqOaIkQYzI8tozx8+N2x0
         6+vldrUVA4gO1JnNM3B5B+RBX5HtB03kj7CbmPj6QszUf2q6OlePEclS1jxZP4AhwyYN
         iZZAw3boadVDyrmUa1B1F3bcS2A/NVWouSw0ahGmNxhLqL9oqeto8RNxV732Fx48RmlM
         CbeGQrd9FZIW3wyc12Rasddl/UU8uqeUbI2CeMBs4dZL/JZBZaxHVUv9DckPEUWgMxlm
         B6bR8zSm14gxEEfJZSNEMMwB3rc8AyhQZm+Bk5SInZve05kHlxkTxftYLG6ygz1Lg84T
         WalA==
X-Gm-Message-State: ALQs6tDnbehinpd7ck6VKe9EzK+HhIVnwQ5XAeiXf8+jnEzZsE0cCUgo
        BU6jrR9EfIBdf7w88sTGmuNaRSP0BjJiQA==
X-Google-Smtp-Source: AIpwx49mzmHSUIrPJ0KDcWaA+b2WIc0y6Y+RfpkA+so7ySG+uGDltzS/MPSWnt3NWPLD1wVTF0J6Fg==
X-Received: by 10.167.128.207 with SMTP id a15mr22299513pfn.116.1524546470700;
        Mon, 23 Apr 2018 22:07:50 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id 131sm12799540pfa.103.2018.04.23.22.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 22:07:49 -0700 (PDT)
Date:   Mon, 23 Apr 2018 22:07:48 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 6/7] grep.c: add configuration variables to show matched
 option
Message-ID: <a5cd76f715d270bd60152d42892443ab8a518ee8.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524545768.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524545768.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To support git-grep(1)'s new option, '--column-number', document and
teach grep.c how to interpret relevant configuration options, similar to
those associated with '--line-number'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt   | 5 +++++
 Documentation/git-grep.txt | 3 +++
 grep.c                     | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6e8d969f52..8a2893d1e1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1159,6 +1159,8 @@ color.grep.<slot>::
 	function name lines (when using `-p`)
 `lineNumber`;;
 	line number prefix (when using `-n`)
+`columnNumber`;;
+	column number prefix (when using `--column-number`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
 `matchContext`;;
@@ -1708,6 +1710,9 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.columnNumber::
+	If set to true, enable the `--column-number` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 51dcfa5093..c5c4d712e6 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -44,6 +44,9 @@ CONFIGURATION
 grep.lineNumber::
 	If set to true, enable `-n` option by default.
 
+grep.columnNumber::
+	If set to true, enable the `--column-number` option by default.
+
 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
diff --git a/grep.c b/grep.c
index d58d940afb..7284dec155 100644
--- a/grep.c
+++ b/grep.c
@@ -96,6 +96,10 @@ int grep_config(const char *var, const char *value, void *cb)
 		opt->linenum = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "grep.columnnumber")) {
+		opt->columnnum = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp(var, "grep.fullname")) {
 		opt->relative = !git_config_bool(var, value);
@@ -112,6 +116,8 @@ int grep_config(const char *var, const char *value, void *cb)
 		color = opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color = opt->color_lineno;
+	else if (!strcmp(var, "color.grep.columnnumber"))
+		color = opt->color_columnno;
 	else if (!strcmp(var, "color.grep.matchcontext"))
 		color = opt->color_match_context;
 	else if (!strcmp(var, "color.grep.matchselected"))
-- 
2.17.0

