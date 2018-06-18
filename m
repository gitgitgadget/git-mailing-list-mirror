Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB4F1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937039AbeFRXnS (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:43:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35607 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937005AbeFRXnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:43:17 -0400
Received: by mail-oi0-f68.google.com with SMTP id e8-v6so16507198oii.2
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/QvMGnkkNbor9FanGdi5QxW3VxN9aUMNaVu61GFVY4=;
        b=zKOL5shlhvf+/0eu+ihudCzaDuQK/1Xhl9K29zakotGkzM8UGUxb0umDuTjs8JYY9K
         hW6dE0bw7H7ivhMesHjpvFyln+SEU9ufPkVxBLFWms3tb4PGisXClaLsxrJY52PzJXc3
         QR0DuKNPSk2CFrWWQYAaQ8otSzDm0zCExHKKWiZd+HGfh8esN6hWYOEZCXCZo1aMTOn0
         07DfIQXe4jQ9IKJha7QwV5VuPhkRRvqsaN9NW3vbad/KlB2tP7ifg+N8ioNlT8Ii9hxB
         rJgJJRRfdm2sXwQhrkw7jb6cv+4yIj3eMnzQMvSSshxqIwJ+FPllACSskfyE8uImR9Ei
         nb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/QvMGnkkNbor9FanGdi5QxW3VxN9aUMNaVu61GFVY4=;
        b=VCDPJsZoicaiH9DxLG7UrYJVc0VptBXjms3+/gGtaVUJPqo2OBbFPe7aYNg562O4xb
         ODqea+YeM8lPddZ4SVcYxeKqufCHsmaKgKDhowHBPE4vsm5EuN7yymlIvXb+OzGv/eQQ
         jNNH5QScFOLdGZFA20t+1BBWBng9miPDGswun6TLrY50+8o3TsF1OacHh9kVnIoaR0TK
         W4V8HGF/bAxUouTpxiHs39hwSBuFOHLuTaBizPbt5ig3jb+drB+kyQcLusIxM/aGqi76
         Ol1958koHLv0+/pHO2IJ4GbLaGY6SJEX7WxFKIwg5jjERyxzypg5Hh06SYpt0JP9oaDu
         JTnQ==
X-Gm-Message-State: APt69E1BzKzSGl9Z5+FJpVaXsyVVXTmGDwJ9oDZae0nb1jfE65c90kns
        kA7/A+ga+9mOEVePw+Rr2cxDddx/q2Y=
X-Google-Smtp-Source: ADUXVKLQ/+qZRzxTXLVHSs8ZFfvyrSTH3fqN/X8GK8dobQjQ6UuBbwY9EUHe3dAJMWROfgmcuLwt/w==
X-Received: by 2002:aca:590a:: with SMTP id n10-v6mr8700467oib.18.1529365396760;
        Mon, 18 Jun 2018 16:43:16 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id q45-v6sm8122486otg.56.2018.06.18.16.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 16:43:15 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:43:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 4/7] grep.c: display column number of first match
Message-ID: <df2d08efc1fb717a564157fb760ff71becb658dd.1529365072.git.me@ttaylorr.com>
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

To prepare for 'git grep' learning '--column', teach grep.c's
show_line() how to show the column of the first match on non-context
lines.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 33f8572e6d..9f5b00a471 100644
--- a/grep.c
+++ b/grep.c
@@ -1381,7 +1381,7 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 }
 
 static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, char sign)
+		      const char *name, unsigned lno, unsigned cno, char sign)
 {
 	int rest = eol - bol;
 	const char *match_color, *line_color = NULL;
@@ -1416,6 +1416,17 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_lineno);
 		output_sep(opt, sign);
 	}
+	/*
+	 * Treat 'cno' as the 1-indexed offset from the start of a non-context
+	 * line to its first match. Otherwise, 'cno' is 0 indicating that we are
+	 * being called with a context line.
+	 */
+	if (opt->columnnum && cno) {
+		char buf[32];
+		xsnprintf(buf, sizeof(buf), "%d", cno);
+		output_color(opt, buf, strlen(buf), opt->color_columnno);
+		output_sep(opt, sign);
+	}
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
@@ -1521,7 +1532,7 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 			break;
 
 		if (match_funcname(opt, gs, bol, eol)) {
-			show_line(opt, bol, eol, gs->name, lno, '=');
+			show_line(opt, bol, eol, gs->name, lno, 0, '=');
 			break;
 		}
 	}
@@ -1586,7 +1597,7 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 
 		while (*eol != '\n')
 			eol++;
-		show_line(opt, bol, eol, gs->name, cur, sign);
+		show_line(opt, bol, eol, gs->name, cur, 0, sign);
 		bol = eol + 1;
 		cur++;
 	}
@@ -1785,6 +1796,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	while (left) {
 		char *eol, ch;
 		int hit;
+		ssize_t cno;
 		ssize_t col = -1, icol = -1;
 
 		/*
@@ -1850,7 +1862,15 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				show_pre_context(opt, gs, bol, eol, lno);
 			else if (opt->funcname)
 				show_funcname_line(opt, gs, bol, lno);
-			show_line(opt, bol, eol, gs->name, lno, ':');
+			cno = opt->invert ? icol : col;
+			if (cno < 0) {
+				/*
+				 * A negative cno means that there was no match.
+				 * Clamp to the beginning of the line.
+				 */
+				cno = 0;
+			}
+			show_line(opt, bol, eol, gs->name, lno, cno + 1, ':');
 			last_hit = lno;
 			if (opt->funcbody)
 				show_function = 1;
@@ -1879,7 +1899,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
-			show_line(opt, bol, eol, gs->name, lno, '-');
+			show_line(opt, bol, eol, gs->name, lno, col + 1, '-');
 		}
 
 	next_line:
-- 
2.17.0.582.gccdcbd54c

