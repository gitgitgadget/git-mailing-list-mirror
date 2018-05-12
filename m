Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53C71F406
	for <e@80x24.org>; Sat, 12 May 2018 03:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeELDLV (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:11:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36592 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeELDLT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:11:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id v24-v6so4284595plo.3
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zklwoLUjuxGF8v4LXO17T2t+7vzi32OZwUYLO1hyT8Q=;
        b=rUe4iYNAByywH0ff77ptiI/LTnCSzzAaVbYxCrBWLhE7ygVQqvhTEWIO8VqQuNy/3r
         qMbM2jvZmLXsJ6q646Xkc87JQJSZEkO07h6ncp9AuP73zxqbo+zbhzj7K/Gu86CngqTk
         VAEmqud/Latrho+pC9R71WLU057wOtcXsXhCzK45nq2E8ZH8Fe5eJ4w9gF096UfFe2uP
         y5Kvd2CFfQj/X8jliKj4s4R5JMFT1EG8+5y2JOzFRO1UKV1C4tp0KOuNaKMROeFyqOkY
         BnNB9kW1reZ2WUQKWkuYMIdG82knH3wAqXWYUuI363BQYqTgKxOj0hjdAiIm+MczZTtW
         2ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zklwoLUjuxGF8v4LXO17T2t+7vzi32OZwUYLO1hyT8Q=;
        b=ADPom9VmRIPcUMRq4NR3ajVH03XeLXJ8zTC0zDjTrAv7LI2ttpGn39+/nn0sEp1lWm
         Xzzzh0zXf3vbqrKy0UpiII7iBqpdJ/h0x8FEDCK1NkpmPZ4TdsazFWisBv7KE+NQKK20
         35yM0khtMhcpguhhWHNBZdOFwmbUabd8HtgppA/RngM5jb3OgHahHK96NwRls+PhB/HZ
         MikbsSQRP05zFZiTx915EUxcizpL85B1s4mcazqvzhvbcdV6gAx6A/PM0hRx7Rsz82k+
         7BK1DgWlJj3kwzHOVWoW+11ikSnW9YXTgjF2L1NkXyXXy4ZolNI7Wf+ZP180dU7DSon5
         lmCQ==
X-Gm-Message-State: ALKqPwelamw8Gs/CHdwbCn0AXCdYDa107nD5MHONlO+QJV6gifYNJw8F
        heLUq7u3IP87cRCsQpNGwRvihw6/HZw=
X-Google-Smtp-Source: AB8JxZph1b5K+Uw+UNnP/pOHUQbZXwhVFpxRcwfG7Huv5ag7tCU+ok34UNFjtlOpYohZ2BoRPOJsmg==
X-Received: by 2002:a17:902:3a5:: with SMTP id d34-v6mr725819pld.103.1526094677921;
        Fri, 11 May 2018 20:11:17 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id t190-v6sm395331pgb.36.2018.05.11.20.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:11:16 -0700 (PDT)
Date:   Fri, 11 May 2018 20:11:15 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net, phillip.wood@talktalk.net
Subject: [PATCH v6 6/7] grep.c: add configuration variables to show matched
 option
Message-ID: <dfd8be62befbbe173faa0d4992b08e82964209c2.1526094383.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1526094383.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526094383.git.me@ttaylorr.com>
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
index cec4665df5..c48a578cb1 100644
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
index 7396b49a2d..5ba1b05526 100644
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

