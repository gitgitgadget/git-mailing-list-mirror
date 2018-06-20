Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377711F403
	for <e@80x24.org>; Wed, 20 Jun 2018 20:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbeFTUFg (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 16:05:36 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43373 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932654AbeFTUFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 16:05:34 -0400
Received: by mail-oi0-f68.google.com with SMTP id t133-v6so734601oif.10
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I1Kcc6+RkpYU570pTxGQVyueyGF3X6y+PS5nF3IbNbU=;
        b=qvX8Pfr0oldpjtRc3Cnh/P8qspddxqJNP0gPtq2bfWSNlsC4ZjGTD0D80LQNdJwuqV
         cR4ZM3fitXNK+QfEaxrou28sV04Ndi26WrCn7QLSBRuaL9aScoiYlNPPngGTqF+8y8QG
         ARAW2kF2uEwyBqfN3dAo5xDB+QtW5B6diG3TUIyeSuAbzWrsz23RgYHOFHqWiCJ7HWgQ
         oWbA3Zd5sLMkPJOz7gjmiyHrM6mIJ6Ee2AQw4fm5ooBk0Ly46Q6TqLFps4PZpm7N4Mc4
         IBXZ1JFdVltFSJhdhzYPOmFrfQfe1cep2CISpjgy7ddyNheq9vV7XKemn+GJXNxyD1r3
         JZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1Kcc6+RkpYU570pTxGQVyueyGF3X6y+PS5nF3IbNbU=;
        b=VjaH3Sbt2Dg2mUpdOXwHkn8cNc/Zp2scH5d4i0itwC4PBnanv6MEUekc5yny8L9nAr
         UluxpXTF0/zRm0txylz7Pohu57ElZQzQs3SoHan4W7R5GxXCwqi6eeNOTVOO1eFtQDNy
         /XMNeArgkbJjWUPtSod8COY/KjobHuZBGJuZLQtVhSdjoD9w3XrUpnoKDqY4U1eya0CB
         LOGxGnOdEJ0nUVUQZqDkdtoNr+D6ZEKTT424vFVLiYOMtpCvQbL9Z0Lvnx645jRYp+P+
         QvShwunlSNUsrxFkEEo21U56GgCcjoGkxjfYXkYypwwc8vlIjtQHCoHCHtD9D/jXHW9M
         YWOQ==
X-Gm-Message-State: APt69E0s61Cz59tyRMRnGGFJObz6RrLGhqJI7iLsXlG+uvLM33mJdJ1r
        5SoP8C+RjTkqndkuT5cmN9WwUwKQUcc=
X-Google-Smtp-Source: ADUXVKIDXalOngqs6GVvs6xz/jb0A1wIkBT/da0YySCjaz78CcMefLuVU6cFKIrV1kRzTz84IhnSGQ==
X-Received: by 2002:aca:d607:: with SMTP id n7-v6mr12926758oig.109.1529525133409;
        Wed, 20 Jun 2018 13:05:33 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2412757oti.35.2018.06.20.13.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:05:31 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:05:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <cover.1529524852.git.me@ttaylorr.com>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is a re-roll of my series to add --column to 'git-grep(1)'. Since
last time, not much has changed other than the following:

  - Fix a typo where 'col', 'icol' were spelled as 'match', 'imatch'
    [1].

  - Disable short-circuiting OR when --column is given [2].

  - Disable early-return in match_line() when multiple patterns are
    given and --column is, too [3].

  - Add some more tests in t7810.

Thanks again for your kind and through review; hopefully this re-roll
should be OK to queue as-is.


Thanks,
Taylor

[1]: https://public-inbox.org/git/xmqqwouuvi0e.fsf@gitster-ct.c.googlers.com/
[2]: https://public-inbox.org/git/20180619174452.GA47272@syl.attlocal.net/
[3]: https://public-inbox.org/git/80b9a0b1-3849-7097-fe1a-dd80835d62ae@web.de/

Taylor Blau (7):
  Documentation/config.txt: camel-case lineNumber for consistency
  grep.c: expose {,inverted} match column in match_line()
  grep.[ch]: extend grep_opt to allow showing matched column
  grep.c: display column number of first match
  builtin/grep.c: add '--column' option to 'git-grep(1)'
  grep.c: add configuration variables to show matched option
  contrib/git-jump/git-jump: jump to exact location

 Documentation/config.txt   |   7 ++-
 Documentation/git-grep.txt |   9 ++-
 builtin/grep.c             |   1 +
 contrib/git-jump/README    |  12 +++-
 contrib/git-jump/git-jump  |   2 +-
 grep.c                     | 126 ++++++++++++++++++++++++++++---------
 grep.h                     |   2 +
 t/t7810-grep.sh            |  84 +++++++++++++++++++++++++
 8 files changed, 210 insertions(+), 33 deletions(-)

Inter-diff (since v1):

diff --git a/grep.c b/grep.c
index 8ffa94c791..08d3df2855 100644
--- a/grep.c
+++ b/grep.c
@@ -1257,8 +1257,8 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	return hit;
 }

-static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
-			   enum grep_context ctx, ssize_t *col,
+static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x, char *bol,
+			   char *eol, enum grep_context ctx, ssize_t *col,
 			   ssize_t *icol, int collect_hits)
 {
 	int h = 0;
@@ -1280,29 +1280,36 @@ static int match_expr_eval(struct grep_expr *x, char *bol, char *eol,
 		break;
 	case GREP_NODE_NOT:
 		/*
-		 * Upon visiting a GREP_NODE_NOT, imatch and match become
-		 * swapped.
+		 * Upon visiting a GREP_NODE_NOT, col and icol become swapped.
 		 */
-		h = !match_expr_eval(x->u.unary, bol, eol, ctx, icol, col, 0);
+		h = !match_expr_eval(opt, x->u.unary, bol, eol, ctx, icol, col,
+				     0);
 		break;
 	case GREP_NODE_AND:
-		if (!match_expr_eval(x->u.binary.left, bol, eol, ctx, col,
+		if (!match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
 				     icol, 0))
 			return 0;
-		h = match_expr_eval(x->u.binary.right, bol, eol, ctx, col,
+		h = match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
 				    icol, 0);
 		break;
 	case GREP_NODE_OR:
-		if (!collect_hits)
-			return (match_expr_eval(x->u.binary.left, bol, eol, ctx,
-						col, icol, 0) ||
-				match_expr_eval(x->u.binary.right, bol, eol,
-						ctx, col, icol, 0));
-		h = match_expr_eval(x->u.binary.left, bol, eol, ctx, col,
+		if (!(collect_hits || opt->columnnum)) {
+			/*
+			 * Don't short-circuit OR when given --column (or
+			 * collecting hits) to ensure we don't skip a later
+			 * child that would produce an earlier match.
+			 */
+			return (match_expr_eval(opt, x->u.binary.left, bol, eol,
+						ctx, col, icol, 0) ||
+				match_expr_eval(opt, x->u.binary.right, bol,
+						eol, ctx, col, icol, 0));
+		}
+		h = match_expr_eval(opt, x->u.binary.left, bol, eol, ctx, col,
 				    icol, 0);
-		x->u.binary.left->hit |= h;
-		h |= match_expr_eval(x->u.binary.right, bol, eol, ctx, col,
-				     icol, 1);
+		if (collect_hits)
+			x->u.binary.left->hit |= h;
+		h |= match_expr_eval(opt, x->u.binary.right, bol, eol, ctx, col,
+				     icol, collect_hits);
 		break;
 	default:
 		die("Unexpected node type (internal error) %d", x->node);
@@ -1317,7 +1324,7 @@ static int match_expr(struct grep_opt *opt, char *bol, char *eol,
 		      ssize_t *icol, int collect_hits)
 {
 	struct grep_expr *x = opt->pattern_expression;
-	return match_expr_eval(x, bol, eol, ctx, col, icol, collect_hits);
+	return match_expr_eval(opt, x, bol, eol, ctx, col, icol, collect_hits);
 }

 static int match_line(struct grep_opt *opt, char *bol, char *eol,
@@ -1325,6 +1332,7 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 		      enum grep_context ctx, int collect_hits)
 {
 	struct grep_pat *p;
+	int hit = 0;

 	if (opt->extended)
 		return match_expr(opt, bol, eol, ctx, col, icol,
@@ -1334,11 +1342,21 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
 	for (p = opt->pattern_list; p; p = p->next) {
 		regmatch_t tmp;
 		if (match_one_pattern(p, bol, eol, ctx, &tmp, 0)) {
-			*col = tmp.rm_so;
-			return 1;
+			hit |= 1;
+			if (!opt->columnnum) {
+				/*
+				 * Without --column, any single match on a line
+				 * is enough to know that it needs to be
+				 * printed. With --column, scan _all_ patterns
+				 * to find the earliest.
+				 */
+				break;
+			}
+			if (*col < 0 || tmp.rm_so < *col)
+				*col = tmp.rm_so;
 		}
 	}
-	return 0;
+	return hit;
 }

 static int match_next_pattern(struct grep_pat *p, char *bol, char *eol,
@@ -1387,7 +1405,7 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 }

 static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, unsigned cno, char sign)
+		      const char *name, unsigned lno, ssize_t cno, char sign)
 {
 	int rest = eol - bol;
 	const char *match_color, *line_color = NULL;
@@ -1429,7 +1447,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	 */
 	if (opt->columnnum && cno) {
 		char buf[32];
-		xsnprintf(buf, sizeof(buf), "%d", cno);
+		xsnprintf(buf, sizeof(buf), "%zu", cno);
 		output_color(opt, buf, strlen(buf), opt->color_columnno);
 		output_sep(opt, sign);
 	}
@@ -1871,8 +1889,11 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			cno = opt->invert ? icol : col;
 			if (cno < 0) {
 				/*
-				 * A negative cno means that there was no match.
-				 * Clamp to the beginning of the line.
+				 * A negative cno indicates that there was no
+				 * match on the line. We are thus inverted and
+				 * being asked to show all lines that _don't_
+				 * match a given expression. Therefore, set cno
+				 * to 0 to suggest the whole line matches.
 				 */
 				cno = 0;
 			}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index daaf7b4c44..bf0b572dab 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -139,6 +139,15 @@ do
 		test_cmp expected actual
 	'

+	test_expect_success "grep $L (with --column, double-negation)" '
+		{
+			echo ${HC}file:1:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column --not \( --not -e foo --or --not -e baz \) $H -- file \
+			>actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L (with --column, -C)" '
 		{
 			echo ${HC}file:5:foo mmap bar
@@ -162,6 +171,18 @@ do
 		test_cmp expected actual
 	'

+	test_expect_success "grep -w $L (with non-extended patterns, --column)" '
+		{
+			echo ${HC}file:5:foo mmap bar
+			echo ${HC}file:10:foo_mmap bar
+			echo ${HC}file:10:foo_mmap bar mmap
+			echo ${HC}file:5:foo mmap bar_mmap
+			echo ${HC}file:10:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column -w -e bar -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L" '
 		{
 			echo ${HC}file:1:foo mmap bar
--
2.17.0.582.gccdcbd54c
