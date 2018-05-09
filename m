Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0BD31F424
	for <e@80x24.org>; Wed,  9 May 2018 02:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933599AbeEICN4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 22:13:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40556 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933558AbeEICNl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 22:13:41 -0400
Received: by mail-pg0-f66.google.com with SMTP id l2-v6so21961209pgc.7
        for <git@vger.kernel.org>; Tue, 08 May 2018 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aJu4G6pz7dTilB1D0E/I5saseH7qr8M4oEPDfEzXunU=;
        b=DVkWntg0wztdZ3CuNNrEFqYGUYaW/gYjt9R6goh1HHBsm7pJa9HoZXV2+rGiYrc1yM
         P97u99mmCqOHa6lJnrFYTcNlDR1nG2g4xW0RUEOh+d8MMQKgivWZAp1gphbnRDswAy8U
         +2Vn/+g8RHhl9Qr6CufsKckfHp7yt0zIcZFB5Z/MCdfyvpuljNJwFhYXxmSjF1sP4BS1
         LPjE4saRdSFLhoP75nBWjZbrp787hb8bxkaU50QxCseQSn8uyRLZdjARBb2LErvM0OYO
         IuEqEmBWBJNbr6itanzcgYYq9UVGTaxhXcukgY05xh8jbMZCKxfPjTBCF/SMoKY41yxC
         S1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJu4G6pz7dTilB1D0E/I5saseH7qr8M4oEPDfEzXunU=;
        b=dBJMIMRc4SeveJCd5stRaTjCSn9lWqAAkSp4gJWBgikHtqCYtYYBH6+MLT/TiAexrW
         jh4YCu2ziMR8fxBr2O8u7y9KJfnrOMuqWx1B+CXYMUaGdi6OCoe97hvZHTGfSjHHQhfZ
         EuGB/y3rTzepBGbbhDU7a3TY8iYwMc1yC13ZOZvozXrQfQmuCYcCgKzcp2grdYH0l9dd
         eaKly0x8Pfr0VnEjIkurEz9MG9/a2tSUUuROAM4bVSjDbbnNGXTTCvA2NM0ktjLRp+vd
         Wnc2mGPwcoeUsgO55F9TN3RwsyVFifHVfeujSeUHVyAOil06GnkZpZ7K3UxFaFaXX9OD
         JR8w==
X-Gm-Message-State: ALQs6tCfRK7lZHn6PA60vo6G5BBh58jRd0H+eJLsgiT9+cXbrn4rbGkY
        gKHR517q/zgVcXb4HdHtlSYx7Azo37I0lw==
X-Google-Smtp-Source: AB8JxZrb9sQ6LIViCHmMWMFkuZB6m7YSK3UIHtKQSv2UdqIE/VwakXudaFKoGkNKG0z/yDgFw7cN8A==
X-Received: by 2002:a63:b94a:: with SMTP id v10-v6mr34554766pgo.372.1525832020464;
        Tue, 08 May 2018 19:13:40 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:d537:72d4:95b0:7812])
        by smtp.gmail.com with ESMTPSA id e8sm28124730pfd.168.2018.05.08.19.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 19:13:39 -0700 (PDT)
Date:   Tue, 8 May 2018 19:13:38 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        phillip.wood@talktalk.net, sunshine@sunshineco.com
Subject: [PATCH v5 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
Message-ID: <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
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

Teach 'git-grep(1)' a new option, '--column', to show the column
number of the first match on a non-context line. This makes it possible
to teach 'contrib/git-jump/git-jump' how to seek to the first matching
position of a grep match in your editor, and allows similar additional
scripting capabilities.

For example:

  $ git grep -n --column foo | head -n3
  .clang-format:51:14:# myFunction(foo, bar, baz);
  .clang-format:64:7:# int foo();
  .clang-format:75:8:# void foo()

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-grep.txt |  6 +++++-
 builtin/grep.c             |  4 ++++
 grep.c                     |  3 +++
 t/t7810-grep.sh            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 18b494731f..75f1561112 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
-	   [-F | --fixed-strings] [-n | --line-number]
+	   [-F | --fixed-strings] [-n | --line-number] [--column]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
@@ -169,6 +169,10 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.
 
+--column::
+	Prefix the 1-indexed byte-offset of the first match on non-context lines. This
+	option is incompatible with '--invert-match', and extended expressions.
+
 -l::
 --files-with-matches::
 --name-only::
diff --git a/builtin/grep.c b/builtin/grep.c
index 5f32d2ce84..f9f516dfc4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -829,6 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
+		OPT_BOOL(0, "column", &opt.columnnum, N_("show column number of first match")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
@@ -1111,6 +1112,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_objects(&opt, &pathspec, the_repository, &list);
 	}
 
+	if (opt.columnnum && opt.invert)
+		die(_("--column and --invert-match cannot be combined"));
+
 	if (num_threads)
 		hit |= wait_all();
 	if (hit && show_in_pager)
diff --git a/grep.c b/grep.c
index f3fe416791..f4228c23ac 100644
--- a/grep.c
+++ b/grep.c
@@ -995,6 +995,9 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 	else if (!opt->extended && !opt->debug)
 		return;
 
+	if (opt->columnnum && opt->extended)
+		die(_("--column and extended expressions cannot be combined"));
+
 	p = opt->pattern_list;
 	if (p)
 		opt->pattern_expression = compile_pattern_expr(&p);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1797f632a3..aa56b21ed9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,6 +99,28 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep -w $L (with --column)" '
+		{
+			echo ${HC}file:5:foo mmap bar
+			echo ${HC}file:14:foo_mmap bar mmap
+			echo ${HC}file:5:foo mmap bar_mmap
+			echo ${HC}file:14:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "grep -w $L (with --line-number, --column)" '
+		{
+			echo ${HC}file:1:5:foo mmap bar
+			echo ${HC}file:3:14:foo_mmap bar mmap
+			echo ${HC}file:4:5:foo mmap bar_mmap
+			echo ${HC}file:5:14:foo_mmap bar mmap baz
+		} >expected &&
+		git grep -n --column -w -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L" '
 		{
 			echo ${HC}file:1:foo mmap bar
@@ -1590,4 +1612,14 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep does not allow --column, --invert-match' '
+	test_must_fail git grep --column --invert-match pat 2>err &&
+	test_i18ngrep "\-\-column and \-\-invert-match cannot be combined" err
+'
+
+test_expect_success 'grep does not allow --column, extended' '
+	test_must_fail git grep --column --not -e pat 2>err &&
+	test_i18ngrep "\-\-column and extended expressions cannot be combined" err
+'
+
 test_done
-- 
2.17.0

