Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4D61F597
	for <e@80x24.org>; Mon, 25 Jun 2018 21:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbeFYV0F (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 17:26:05 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39051 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeFYV0D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 17:26:03 -0400
Received: by mail-oi0-f67.google.com with SMTP id 18-v6so4438640oiq.6
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i0WaY+vl354+gu7tZtoPYibpqb4mNdCRJwsRbrpaTeE=;
        b=T4LmmxHjtXVwLytVI8oNfNyMYMQa9QlZH13lbHxrAOdLRHfhXcrNZ8RhKq6o/wbLe6
         cI9HaymU/2mfN2dtKdSZbxDbAnEgNigC+vsWXWV6a4WOwsbSFlRovaTDBcpx4xcx/vYD
         oKToJipYjzH8jiQrVaSTEjEt9ieFbcUCHA7/Ipv4chimfdXU7W0FQD6HZVNXz5TuoE+4
         47Ok0pBm5CyRmPSOp4O2VIQonJkqvL35QfD79mgJpEo4qz7153005jhY2W7PVaoUCbTj
         kXH5QLwkVYSr5wqw3p7sujMszG9yVxTQhIfHGZlvzcM+iu1A0gsgtGizIPr5SyGUYCbo
         qtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i0WaY+vl354+gu7tZtoPYibpqb4mNdCRJwsRbrpaTeE=;
        b=Re8bi6goqXwkhwM61SpmFf6e0ghI8KawtsBtnVg5nPxRPqghFRTP1o5ZexwWth19kV
         0vQUzn/BcUvHFQViQaBsvTP+RLP+7J8xSqbEAT1dejZEAL0KRHJIit3Q05/hVfWhOHBJ
         pvJghtpBGCHTCxitoWlwfgkGae2aaOkISYexqxCvs8oSWQfO3dNzfyox+856RQ5mqkue
         ZL+zedTbdKDodUyRTSVJenqaN8kWu+hxH5SBOU6Ogb2GoGUVmnG+aqqfoOSrShK1VuPt
         dpSZJUxAVPu3PDpgOY/oDjWkvy84PPFCcN77w7NorAUWVbWZXJgsOAJdnOzy3PYToNQM
         mkWw==
X-Gm-Message-State: APt69E3/3TfqUUI/JAODA4S2cjDB/R4hcYFAJiEOc0ZgK6mhfZI/iphC
        W0XTtw7aBr4RlkYaPF/FIS8WZFmRnrU=
X-Google-Smtp-Source: ADUXVKLQPcZ3m0AB+ZW06sHVDbZldi8OHs44cu/0RHZEmBCPVr8R/TpWvt6U758aBL0aQXeeRyc4LA==
X-Received: by 2002:aca:ec0c:: with SMTP id k12-v6mr6529762oih.227.1529961962410;
        Mon, 25 Jun 2018 14:26:02 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id g79-v6sm2956853oic.15.2018.06.25.14.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 14:26:01 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:26:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 2/2] grep.c: teach 'git grep --only-matching'
Message-ID: <f156bd7c897359926ec407e805ecb0630a8b12da.1529961706.git.me@ttaylorr.com>
References: <cover.1529961706.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529961706.git.me@ttaylorr.com>
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
 grep.c          | 48 +++++++++++++++++++++++++++++++++---------------
 grep.h          |  1 +
 t/t7810-grep.sh | 15 +++++++++++++++
 4 files changed, 55 insertions(+), 15 deletions(-)

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
index 4ff8a73043..48cca6723e 100644
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
@@ -1462,39 +1464,55 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
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
