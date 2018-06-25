Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6361F516
	for <e@80x24.org>; Mon, 25 Jun 2018 21:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeFYV0C (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 17:26:02 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40293 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeFYV0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 17:26:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id f79-v6so13942152oib.7
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPnWLlaaxQHcg1P6E71V5VYxO28KUnrEX+UXLKPQ2Qo=;
        b=J6IhGCMXWAYhwh5De7KrqjoAczsmqH387E5ewUxxx2J06GXAR/VlAXRjwSz/PrOj0+
         sIZdlc7VjbqG4LY6G5cxJhUht8CafbHNctCrSimKYipRnkmK7a60ARivKzlBue3wo2Xg
         OXeUkNZabh1t9BQC5kRD1xl3wj703wVolQ7hYGa/5zFNRmHXJnk0KmT8GlktBfYtXwpm
         O3o08wp7kFugnERmnTeHKNjEMaJWcym3atjmxvubjVhyO4451WraCSayf7S1uSUmwzf2
         3y0HdFNF+2pw1AWqy/A7HNOHg+qbU93YWznsmf19LbsqXtGPGJLWWo2IoeHaf3tSdT8Q
         aR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPnWLlaaxQHcg1P6E71V5VYxO28KUnrEX+UXLKPQ2Qo=;
        b=D8Kn0MwmlY4Q+TQcK/t5VMM6Dqn+vAYOOz/un60c8PolJxxBOLMh4EsAqgSXxl4OSC
         JkQP9Vwfz8xy6wP9lxr7lMKaNBXSbJSgj/idZggCJV7EU3fW/jxHd4cmpD0/ria/vr29
         QY3DUVeuWYISLLo9Yrug1r96PezuMFLymuIGj30lARKdmm/r8iFgeDrJ3wipCJjYQbd7
         9TDnjd1igp4HFoGVcI1KTvIb/aXutFwc35i4xmxbEU7TA4mfshuHhG/RWF80haSC4yqe
         z8n6UsHrDQAo4B1TijXKq70nj8d7ndYDLiCV4vs8wIxdyQFiTiNG27W+3JcR7cqtrHDq
         a98w==
X-Gm-Message-State: APt69E0Qi5DYsXlSJKs0cHJNilu7DX9q7Iu9KuA8J/n1gutHJbExBN1T
        f6O7hlOHlYrtAfysYyYFmwPoKSeMwB0=
X-Google-Smtp-Source: ADUXVKKZXkMaJPrD93ovVSGBdkrOho3kW+c/NW5guzkFq6XJBmLw071WQgV3+UFon4JG6ShSBJWEag==
X-Received: by 2002:aca:a902:: with SMTP id s2-v6mr8214638oie.72.1529961958930;
        Mon, 25 Jun 2018 14:25:58 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id u5-v6sm616739otc.1.2018.06.25.14.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 14:25:57 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:25:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 1/2] grep.c: extract show_line_header()
Message-ID: <62e19e5583e30117b6754be5de5582a07c9e78dc.1529961706.git.me@ttaylorr.com>
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

The grep code invokes show_line() to display the contents of a matched
or context line in its output. Part of this execution is to print a line
header that includes information such as the kind, the line- and
column-number and etc. of that match.

To prepare for the addition of an option to print only the matching
component(s) of a non-context line, we must prepare for the possibility
that a single line may contain multiple matching parts, and thus will
need multiple headers printed for a single line.

Extracting show_line_header allows us to do just that. In the subsequent
commit, it will be used within the colorization loop to print out only
the matching parts of a line, optionally with LFs delimiting
sub-matches.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/grep.c b/grep.c
index 992673fe7e..4ff8a73043 100644
--- a/grep.c
+++ b/grep.c
@@ -1410,26 +1410,9 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 	return hit;
 }

-static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, ssize_t cno, char sign)
+static void show_line_header(struct grep_opt *opt, const char *name,
+			     unsigned lno, ssize_t cno, char sign)
 {
-	int rest = eol - bol;
-	const char *match_color, *line_color = NULL;
-
-	if (opt->file_break && opt->last_shown == 0) {
-		if (opt->show_hunk_mark)
-			opt->output(opt, "\n", 1);
-	} else if (opt->pre_context || opt->post_context || opt->funcbody) {
-		if (opt->last_shown == 0) {
-			if (opt->show_hunk_mark) {
-				output_color(opt, "--", 2, opt->color_sep);
-				opt->output(opt, "\n", 1);
-			}
-		} else if (lno > opt->last_shown + 1) {
-			output_color(opt, "--", 2, opt->color_sep);
-			opt->output(opt, "\n", 1);
-		}
-	}
 	if (opt->heading && opt->last_shown == 0) {
 		output_color(opt, name, strlen(name), opt->color_filename);
 		opt->output(opt, "\n", 1);
@@ -1457,6 +1440,29 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_columnno);
 		output_sep(opt, sign);
 	}
+}
+
+static void show_line(struct grep_opt *opt, char *bol, char *eol,
+		      const char *name, unsigned lno, ssize_t cno, char sign)
+{
+	int rest = eol - bol;
+	const char *match_color, *line_color = NULL;
+
+	if (opt->file_break && opt->last_shown == 0) {
+		if (opt->show_hunk_mark)
+			opt->output(opt, "\n", 1);
+	} else if (opt->pre_context || opt->post_context || opt->funcbody) {
+		if (opt->last_shown == 0) {
+			if (opt->show_hunk_mark) {
+				output_color(opt, "--", 2, opt->color_sep);
+				opt->output(opt, "\n", 1);
+			}
+		} else if (lno > opt->last_shown + 1) {
+			output_color(opt, "--", 2, opt->color_sep);
+			opt->output(opt, "\n", 1);
+		}
+	}
+	show_line_header(opt, name, lno, cno, sign);
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
--
2.18.0

