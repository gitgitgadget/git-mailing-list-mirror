Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAA1200B9
	for <e@80x24.org>; Sat,  5 May 2018 04:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbeEEEDT (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 00:03:19 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42679 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeEEEDR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 00:03:17 -0400
Received: by mail-pg0-f67.google.com with SMTP id p9-v6so13773321pgc.9
        for <git@vger.kernel.org>; Fri, 04 May 2018 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rO6q46DOl94jMru1PKOmrsE0Ky7sNKcDprtAD86Txq0=;
        b=1iTZuPk2W287OlWxxabZK7uxtHZPFKhXCkRTcB1TImQc+g68QXE4G1vuIe9W29A/cU
         KsBdi3pa3rpT1zoLrHN6aWdUNeO+Slaz6HIZCk5Hpya0deRiLv2w//WxrcYIeGdM0gRg
         sPye0NlXdcqYNh5fScyCB/MPmeMTBg1ycP5FOZ4vSl9qFzdP8ov/TdCDeC53GaqQ/SH7
         TKqmpc6l4ZnfTrK/ivuKyhPd3vfB0HL06Q3d4qqzAcIYxfB4l+acBpJqgqo3YUep9qJG
         gVf2Jh8XSRMnpppdYYfYmOH8UmZK6sdlSXgSJNZn4ySSye6wLNdmZmhrreFgyTBsOKsH
         U3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rO6q46DOl94jMru1PKOmrsE0Ky7sNKcDprtAD86Txq0=;
        b=UfmKgEqxDaWYh4NVNuD4VAElz9JT/i+/imsQaFy7I+S84tO1lrqZkiIoXppqxo7ZDZ
         xlB5yUNNbc52TtGQKBvogO3a6z4EZdY5qGd2LfPBWkWxjE4zxPftnDJCdIhrOOZxAA/6
         OTe6Rd9wapiZSBtYykDQ+t7KYtqA0E8Av4sT1m75oHZ7i59ZNHQnY35a5AztuwtgORcE
         38mGzmsufUxLP2Lf6+ZQtxssZIC0jvPXTKNZZ0aF34Zx+hXD4WKv3tJTjlFFkNZc64dT
         TpU+Ja4+w5w2tSEN21pC1FghdCqfC4Rw87IMSDCPPJOcLhKkqxN1axauz2iOKPCy1pil
         MLqA==
X-Gm-Message-State: ALQs6tAaYbZHV426XC4pKCQ/Qo8y8jTBQaFfPmHuSdJkAf/87VPuxZWB
        unS5ejM6TloxKFoRlS/OPWBDYAjq1uU=
X-Google-Smtp-Source: AB8JxZoZXaBX3CHM+NDc6Y7WIM6WcyEagBYs0OBWVHP/y7Km+UvSnYu2K3UiKhku7DPqKCgJfJMQLQ==
X-Received: by 2002:a65:4b02:: with SMTP id r2-v6mr23910356pgq.82.1525492995917;
        Fri, 04 May 2018 21:03:15 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id j74sm36250784pfk.25.2018.05.04.21.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 21:03:14 -0700 (PDT)
Date:   Fri, 4 May 2018 21:03:14 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 2/2] builtin/grep.c: teach '-o', '--only-matching' to
 'git-grep'
Message-ID: <c8b527c5de3b0e5422d2c1afb91d454d1e46fff4.1525492696.git.me@ttaylorr.com>
References: <cover.1525492696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525492696.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach GNU grep(1)'s '-o' ('--only-matching') to 'git-grep'. This option
prints only the matching components of each line. It writes multiple
lines if more than one match exists on a given line.

For example:

  $ git grep -on --column --heading git -- README.md | head -3
  README.md
  15:56:git
  18:20:git

By using show_line_header(), 'git grep --only-matching' correctly
respects the '--header' option:

  $ git grep -on --column --heading git -- README.md | head -4
  README.md
  15:56:git
  18:20:git
  19:16:git

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-grep.txt |  6 +++++-
 builtin/grep.c             |  1 +
 grep.c                     | 23 ++++++++++++++++++++---
 grep.h                     |  1 +
 t/t7810-grep.sh            | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index d451cd8883..9754923041 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
 	   [--color[=<when>] | --no-color]
-	   [--break] [--heading] [-p | --show-function]
+	   [--break] [--heading] [-o | --only-matching] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
 	   [--threads <num>]
@@ -221,6 +221,10 @@ providing this option will cause it to die.
 	Show the filename above the matches in that file instead of
 	at the start of each shown line.
 
+--o::
+--only-matching::
+	Show only the matching part of the lines.
+
 -p::
 --show-function::
 	Show the preceding line that contains the function name of
diff --git a/builtin/grep.c b/builtin/grep.c
index 5c83f17759..5028bf96cf 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -851,6 +851,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("print empty line between matches from different files")),
 		OPT_BOOL(0, "heading", &opt.heading,
 			N_("show filename only once above matches from same file")),
+		OPT_BOOL('o', "only-matching", &opt.only_matching, N_("show only matches")),
 		OPT_GROUP(""),
 		OPT_CALLBACK('C', "context", &opt, N_("n"),
 			N_("show <n> context lines before and after matches"),
diff --git a/grep.c b/grep.c
index 89dd719e4d..da3f8e6266 100644
--- a/grep.c
+++ b/grep.c
@@ -1422,11 +1422,13 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		}
 	}
 	show_line_header(opt, name, lno, cno, sign);
-	if (opt->color) {
+	if (opt->color || opt->only_matching) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
 		int ch = *eol;
 		int eflags = 0;
+		int first = 1;
+		int offset = 1;
 
 		if (sign == ':')
 			match_color = opt->color_match_selected;
@@ -1443,16 +1445,31 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			if (match.rm_so == match.rm_eo)
 				break;
 
-			output_color(opt, bol, match.rm_so, line_color);
+			if (!opt->only_matching)
+				output_color(opt, bol, match.rm_so, line_color);
+			else if (!first) {
+				/*
+				 * We are given --only-matching, and this is not
+				 * the first match on a line. Reprint the
+				 * newline and header before showing another
+				 * match.
+				 */
+				opt->output(opt, "\n", 1);
+				show_line_header(opt, name, lno,
+					offset+match.rm_so, sign);
+			}
 			output_color(opt, bol + match.rm_so,
 				     match.rm_eo - match.rm_so, match_color);
+			offset += match.rm_eo;
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
+			first = 0;
 		}
 		*eol = ch;
 	}
-	output_color(opt, bol, rest, line_color);
+	if (!opt->only_matching)
+		output_color(opt, bol, rest, line_color);
 	opt->output(opt, "\n", 1);
 }
 
diff --git a/grep.h b/grep.h
index 08a0b391c5..24c1460100 100644
--- a/grep.h
+++ b/grep.h
@@ -126,6 +126,7 @@ struct grep_opt {
 	const char *prefix;
 	int prefix_length;
 	regex_t regexp;
+	int only_matching;
 	int linenum;
 	int columnnum;
 	int invert;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index a03c3416e7..ef7f4ce725 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1420,6 +1420,39 @@ test_expect_success 'grep --heading' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+file:1:5:mmap
+file:2:5:mmap
+file:3:5:mmap
+file:3:14:mmap
+file:4:5:mmap
+file:4:14:mmap
+file:5:5:mmap
+file:5:14:mmap
+EOF
+
+test_expect_success 'grep --only-matching' '
+	git grep --only-matching --line-number --column mmap file >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+file
+1:5:mmap
+2:5:mmap
+3:5:mmap
+3:14:mmap
+4:5:mmap
+4:14:mmap
+5:5:mmap
+5:14:mmap
+EOF
+
+test_expect_success 'grep --only-matching --heading' '
+	git grep --only-matching --heading --line-number --column mmap file >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 <BOLD;GREEN>hello.c<RESET>
 4:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)
-- 
2.17.0
