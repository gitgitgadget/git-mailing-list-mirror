Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59501F406
	for <e@80x24.org>; Sat, 12 May 2018 03:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeELDVP (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:21:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37941 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeELDVO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:21:14 -0400
Received: by mail-pg0-f66.google.com with SMTP id n9-v6so3181565pgq.5
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11oOEvMyHKym1uKyVHh/ae0ShdXc05ywgzYFMYiwOG4=;
        b=kD2lgaVNClsO8CYCCPvVCJr3QTAWeTYvh8VW+M0B8Ye4vu21sf0VYAbZXBhR866Z8x
         luYLy2qgTpEht65nQ/ZKrj2uLLKTlOM3d6moXUa2wn7gAys8c24tgkHxSM/7r9tHzllx
         K4oBe5Ev7/cXPLqwYUp+Qtbj8w8gUumx1/9rehnqfl+Zg30tWFPj1cRadGtSQiPt6h57
         Qk2CX6zWzXnC1hkEbVWtmQ9PbsJbGYGH84MDTrDV1IWVr0kGwl6yDsfyBL3YrcEBD3e4
         fPzVt3rsrkKgD5ZEYjg5hEvKBNSrw4HSgag1Sx9nUs5WwQ1jcotcmpTsGJQRZ2Ocrqdg
         LZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11oOEvMyHKym1uKyVHh/ae0ShdXc05ywgzYFMYiwOG4=;
        b=JWNcvmd4bt3YrrgQHxiQMwazvHSw616QKEsBJrh+jDrXJiNtgx8OlI6xhXvmeTrSF8
         q8O2yb/syzWf9mhaI7IruFIp0uQ5YdZuycOfH+Eqovzc0sb6RzFH8HRGWtbB/Ttk7WrS
         XMNh7jPOJnVhkCCbucYE4SqxXLtvdkFJUZ0hoSp7OXY3bSYQsyJ5wjdKXv8aFn+r3wSl
         4GPjDvzDbe6af6Q8KG3Z5sT3tmPz+dSQzEHbYT3/RQpWtnXBgjdDKyzk6y7lxrcC1GEs
         xlOWggcazhx3WX4fKMxx0JOyv7cuO8ODQ9sllGApsYrj1etbiOpSBzxHrK7m2Ls8W2S3
         JVWA==
X-Gm-Message-State: ALKqPweYqX22wpG5/8alV6tpOkdbTSrtH8DF435qi94tUaMG+XKLrHBb
        OkB3AbVAdwdhSEEptG9ZX5hCArc85kY=
X-Google-Smtp-Source: AB8JxZrxKWc4COBDVp3qkXuqmhGFlB3CF5R3pGmWUuIXmbTqtPL7kAGXDYZiGBlpbbZgGv3+PH6VVA==
X-Received: by 2002:a65:608c:: with SMTP id t12-v6mr1328404pgu.182.1526095273306;
        Fri, 11 May 2018 20:21:13 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id v186-v6sm7883835pfb.45.2018.05.11.20.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:21:12 -0700 (PDT)
Date:   Fri, 11 May 2018 20:21:11 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH v2 2/2] builtin/grep.c: teach '-o', '--only-matching' to
 'git-grep'
Message-ID: <8258dac743a137196a6c43b2317248c5c079c115.1526094978.git.me@ttaylorr.com>
References: <cover.1525492696.git.me@ttaylorr.com>
 <cover.1526094978.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526094978.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach GNU grep(1)'s '-o' ('--only-matching') to 'git-grep'. This option
prints only the matching components of each line. It writes multiple
lines if more than one match exists on a given line.

For example:

  $ /git grep -on --column git -- README.md | head -3
  README.md:15:56:git
  README.md:18:20:git
  README.md:19:16:git

By using show_line_header(), 'git grep --only-matching' correctly
respects the '--heading' option:

  $ git grep -on --column --heading git -- README.md | head -4
  README.md
  15:56:git
  18:20:git
  19:16:git

We mirror GNU grep's behavior when given -A, -B, or -C with
--only-matching, by displaying only the matching portion(s) of a line,
ignoring contextual line(s), but displaying '--' (context separator)
line(s).

Notably: when show_line() is called on a line that contains _multiple_
matches, we keep track of a relative offset from the beginning of the
line and increment 'cno' in subsequent calls to show_line_header() when
the expression is not extended. In the extended case, we do not do this,
because the column of the first match is undefined, thus relative
offsets are meaningless.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-grep.txt |  6 +++-
 builtin/grep.c             |  1 +
 grep.c                     | 34 +++++++++++++++++--
 grep.h                     |  1 +
 t/t7810-grep.sh            | 69 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c48a578cb1..5c09abec4a 100644
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
@@ -223,6 +223,10 @@ providing this option will cause it to die.
 	Show the filename above the matches in that file instead of
 	at the start of each shown line.
 
+--o::
+--only-matching::
+	Prints only the matching part of the lines.
+
 -p::
 --show-function::
 	Show the preceding line that contains the function name of
diff --git a/builtin/grep.c b/builtin/grep.c
index f9f516dfc4..0507ac335a 100644
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
index 36bf7cf08d..9297fde643 100644
--- a/grep.c
+++ b/grep.c
@@ -1422,12 +1422,24 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			opt->output(opt, "\n", 1);
 		}
 	}
+	if (opt->only_matching && sign != ':') {
+		/*
+		 * If we're given '--only-matching' and the line is a contextual
+		 * one (i.e., we're given '-A', '-B', or '-C'), mark the line as
+		 * shown (to advance opt->last_shown), but do not show it (since
+		 * we are given '--only-matching').
+		 */
+		opt->last_shown = lno;
+		return;
+	}
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
@@ -1444,16 +1456,32 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			if (match.rm_so == match.rm_eo)
 				break;
 
-			output_color(opt, bol, match.rm_so, line_color);
+			if (!opt->only_matching) {
+				output_color(opt, bol, match.rm_so, line_color);
+			} else if (!first) {
+				/*
+				 * We are given --only-matching, and this is not
+				 * the first match on a line. Reprint the
+				 * newline and header before showing another
+				 * match.
+				 */
+				opt->output(opt, "\n", 1);
+				show_line_header(opt, name, lno,
+					opt->extended ? 0 : offset+match.rm_so,
+					sign);
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
index 491b2e044a..6251ae678a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1432,6 +1432,75 @@ test_expect_success 'grep --heading' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep --only-matching' '
+	cat >expected <<-\EOF &&
+	file:1:5:mmap
+	file:2:5:mmap
+	file:3:5:mmap
+	file:3:14:mmap
+	file:4:5:mmap
+	file:4:14:mmap
+	file:5:5:mmap
+	file:5:14:mmap
+	EOF
+	git grep --only-matching --line-number --column mmap file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --only-matching --column (unsupported)' '
+	cat >expected <<-\EOF &&
+	file:mmap
+	file:mmap
+	file:mmap
+	file:mmap
+	file:mmap
+	file:mmap
+	file:mmap
+	file:mmap
+	EOF
+	git grep --only-matching --column --not --not -e mmap -- file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --only-matching -C' '
+	cat >expected <<-\EOF &&
+	hello.ps1:function
+	hello.ps1:function
+	--
+	hello.ps1:function
+	EOF
+	git grep --only-matching -C1 function hello.ps1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --only-matching --heading' '
+	cat >expected <<-\EOF &&
+	file
+	1:5:mmap
+	2:5:mmap
+	3:5:mmap
+	3:14:mmap
+	4:5:mmap
+	4:14:mmap
+	5:5:mmap
+	5:14:mmap
+	EOF
+	git grep --only-matching --heading --line-number --column mmap file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --only-matching -i' '
+	cat >expected <<-\EOF &&
+	hello_world:1:1:Hello
+	hello_world:2:1:HeLLo
+	hello_world:3:1:Hello
+	hello_world:4:1:HeLLo
+	EOF
+	git grep --only-matching --line-number --column \
+		-i hello hello_world >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 <BOLD;GREEN>hello.c<RESET>
 4:int main(int argc, const <BLACK;BYELLOW>char<RESET> **argv)
-- 
2.17.0
