Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D601F516
	for <e@80x24.org>; Mon,  2 Jul 2018 20:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeGBUJG (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 16:09:06 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45586 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeGBUJF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 16:09:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id m2-v6so10787923oim.12
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cMWho9ciqwYcazs2YSKUTw30RXH3CMwooKDHfV/pGPE=;
        b=WEjLlo0psCZvrFuzFC1oTkl/P+j6cPbNjHI1qJcRA5Lt67LSh8sqYgonKuw6Ahkrzd
         9fCU9LrGUoh94P0NCgWXAJ/oT3h5jaWGuShhsrwSTDjtgbgbs9XpsFDDLeLh6EFNn25W
         MWJIiXM5u8X38rInqFY1OeYf3e56giqbRnONfAuy0rB1IcHvYDdbhrsSgtxjIG2x5Zny
         5Xk1csfowuUKa6PXh6yeC/stwhDsU1MUOQf0rMqIVquwJhg+/WP9Pr4Mdhx+0tvd+bGV
         6iTfvH1eTv/QMUybmGPX8SLasEx6kqSpfv80fuZOluLhMTERcdXBRVw3zO86Pm7gqzJM
         osyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cMWho9ciqwYcazs2YSKUTw30RXH3CMwooKDHfV/pGPE=;
        b=WWMjJMex/LvqufSPZBzONB95JMTqWCHxPuPt6YL1PbY+QhbrF3MNUksK3gnQAMJFYy
         kJANxshiAaM11gkBUphWj3R0w5fx/Wub22abOVGa7+Uo5KSf8ZxwN0ne/d8sYJhSamcg
         Q4bB8ht0iiKi1aTEYdT/5AM+jj6eeE5cqjfcx3dv+eK/i2F0Bp+8LOR7Ni6B8rUWmFQc
         0UknLoP09O16Ui2RitYHMFfA9vvkquRJCTEDGxLYuOiJY1tBF+AA3B7ipNmDMsoJDWgI
         nd/RB/JkUWuPS+NKCz+OALh8KYaPVKNtT1cUHoEFVkPTr60fzzI2HCSBSBDVahUzlk1X
         gqTA==
X-Gm-Message-State: APt69E0Jgr9b2Gixx1v2Merm1QRCvHlcqiiIaAupkhVAkqTg3YOKxVVA
        lcWcV1vB9b8eHTtv2uFduVgfUhlNPqQ=
X-Google-Smtp-Source: AAOMgpeSytsqAyzieEPnInz9Bzr2vg8Uz9/obDXSLMRbBPsK7ljePxzQsmpM/Pljvd70gLmGKVRx/g==
X-Received: by 2002:aca:3f87:: with SMTP id m129-v6mr18523301oia.58.1530562143875;
        Mon, 02 Jul 2018 13:09:03 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id k47-v6sm13372578otb.50.2018.07.02.13.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:09:02 -0700 (PDT)
Date:   Mon, 2 Jul 2018 15:09:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 2/2] grep.c: teach 'git grep --only-matching'
Message-ID: <dbd762f164d1fb906d15a1d3077dcb305d7298d7.1530562110.git.me@ttaylorr.com>
References: <cover.1529961706.git.me@ttaylorr.com>
 <cover.1530562110.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530562110.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git grep --only-matching', a new option to only print the
matching part(s) of a line.

For instance, a line containing the following (taken from README.md:27):

  (`man gitcvs-migration` or `git help cvs-migration` if git is

Is printed as follows:

  $ git grep -no -e git -- README.md | grep ":27"
  README.md:27:7:git
  README.md:27:16:git
  README.md:27:38:git

The patch works mostly as one would expect, with the exception of a few
considerations that are worth mentioning here.

Like GNU grep, this patch ignores --only-matching when --invert (-v) is
given. There is a sensible answer here, but parity with the behavior of
other tools is preferred.

Because a line might contain more than one match, there are special
considerations pertaining to when to print line headers, newlines, and
how to increment the match column offset. The line header and newlines
are handled as a special case within the main loop to avoid polluting
the surrounding code with conditionals that have large blocks.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/grep.c  |  6 ++++++
 grep.c          | 51 +++++++++++++++++++++++++++++++++----------------
 grep.h          |  1 +
 t/t7810-grep.sh | 15 +++++++++++++++
 4 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 61bcaf6e58..228b83990f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -843,6 +843,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F('z', "null", &opt.null_following_name,
 			   N_("print NUL after filenames"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL('o', "only-matching", &opt.only_matching,
+			N_("show only matching parts of a line")),
 		OPT_BOOL('c', "count", &opt.count,
 			N_("show the number of matches instead of matching lines")),
 		OPT__COLOR(&opt.color, N_("highlight matches")),
@@ -962,6 +964,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!opt.pattern_list)
 		die(_("no pattern given."));
 
+	/* --only-matching has no effect with --invert. */
+	if (opt.invert)
+		opt.only_matching = 0;
+
 	/*
 	 * We have to find "--" in a separate pass, because its presence
 	 * influences how we will parse arguments that come before it.
diff --git a/grep.c b/grep.c
index 4ff8a73043..49a744f96b 100644
--- a/grep.c
+++ b/grep.c
@@ -51,6 +51,7 @@ void init_grep_defaults(void)
 	color_set(opt->color_match_selected, GIT_COLOR_BOLD_RED);
 	color_set(opt->color_selected, "");
 	color_set(opt->color_sep, GIT_COLOR_CYAN);
+	opt->only_matching = 0;
 	opt->color = -1;
 	opt->output = std_output;
 }
@@ -158,6 +159,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->pattern_tail = &opt->pattern_list;
 	opt->header_tail = &opt->header_list;
 
+	opt->only_matching = def->only_matching;
 	opt->color = def->color;
 	opt->extended_regexp_option = def->extended_regexp_option;
 	opt->pattern_type_option = def->pattern_type_option;
@@ -1446,7 +1448,8 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		      const char *name, unsigned lno, ssize_t cno, char sign)
 {
 	int rest = eol - bol;
-	const char *match_color, *line_color = NULL;
+	const char *match_color = NULL;
+	const char *line_color = NULL;
 
 	if (opt->file_break && opt->last_shown == 0) {
 		if (opt->show_hunk_mark)
@@ -1462,39 +1465,55 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 			opt->output(opt, "\n", 1);
 		}
 	}
-	show_line_header(opt, name, lno, cno, sign);
-	if (opt->color) {
+	if (!opt->only_matching) {
+		/*
+		 * In case the line we're being called with contains more than
+		 * one match, leave printing each header to the loop below.
+		 */
+		show_line_header(opt, name, lno, cno, sign);
+	}
+	if (opt->color || opt->only_matching) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
 		int ch = *eol;
 		int eflags = 0;
 
-		if (sign == ':')
-			match_color = opt->color_match_selected;
-		else
-			match_color = opt->color_match_context;
-		if (sign == ':')
-			line_color = opt->color_selected;
-		else if (sign == '-')
-			line_color = opt->color_context;
-		else if (sign == '=')
-			line_color = opt->color_function;
+		if (opt->color) {
+			if (sign == ':')
+				match_color = opt->color_match_selected;
+			else
+				match_color = opt->color_match_context;
+			if (sign == ':')
+				line_color = opt->color_selected;
+			else if (sign == '-')
+				line_color = opt->color_context;
+			else if (sign == '=')
+				line_color = opt->color_function;
+		}
 		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			if (match.rm_so == match.rm_eo)
 				break;
 
-			output_color(opt, bol, match.rm_so, line_color);
+			if (opt->only_matching)
+				show_line_header(opt, name, lno, cno, sign);
+			else
+				output_color(opt, bol, match.rm_so, line_color);
 			output_color(opt, bol + match.rm_so,
 				     match.rm_eo - match.rm_so, match_color);
+			if (opt->only_matching)
+				opt->output(opt, "\n", 1);
 			bol += match.rm_eo;
+			cno += match.rm_eo;
 			rest -= match.rm_eo;
 			eflags = REG_NOTBOL;
 		}
 		*eol = ch;
 	}
-	output_color(opt, bol, rest, line_color);
-	opt->output(opt, "\n", 1);
+	if (!opt->only_matching) {
+		output_color(opt, bol, rest, line_color);
+		opt->output(opt, "\n", 1);
+	}
 }
 
 #ifndef NO_PTHREADS
diff --git a/grep.h b/grep.h
index 08a0b391c5..4d474d8ec4 100644
--- a/grep.h
+++ b/grep.h
@@ -150,6 +150,7 @@ struct grep_opt {
 	int relative;
 	int pathname;
 	int null_following_name;
+	int only_matching;
 	int color;
 	int max_depth;
 	int funcname;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 9312c8daf5..d8c232dbf4 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -262,6 +262,21 @@ do
 		fi
 	'
 
+	test_expect_success "grep $L (with --column, --only-matching)" '
+		{
+			echo ${HC}file:1:5:mmap
+			echo ${HC}file:2:5:mmap
+			echo ${HC}file:3:5:mmap
+			echo ${HC}file:3:13:mmap
+			echo ${HC}file:4:5:mmap
+			echo ${HC}file:4:13:mmap
+			echo ${HC}file:5:5:mmap
+			echo ${HC}file:5:13:mmap
+		} >expected &&
+		git grep --column -n -o -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L (t-1)" '
 		echo "${HC}t/t:1:test" >expected &&
 		git grep -n -e test $H >actual &&
-- 
2.18.0
