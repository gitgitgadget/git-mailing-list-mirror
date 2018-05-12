Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF871F406
	for <e@80x24.org>; Sat, 12 May 2018 03:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbeELDVM (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:21:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36156 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeELDVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:21:11 -0400
Received: by mail-pl0-f65.google.com with SMTP id v24-v6so4293666plo.3
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qAeET0XFBF0NFJ+3b5HtJwszp5opKJZYZqi2kTWVviY=;
        b=iBc0Jvvkq4NkgdNRHNHBaQenBQERUw9/u81aHpegEQHNqhT2Cwo6UN19QiYmwizype
         2hfCTIrKv0Fih1LKqABDlK8aoA7M6Ot2BR1lx7PV2UPCfMTpd05Pckuf/4s6NXHD2i5L
         ISPGMbUMpMSDnuOPE8fITGWtHHUhnknIEvddg4WCXnu5N90ZOsVRo0vYV+ZXOKDVi7hX
         P8xWktZSq6GQqh3Af9Fd6bmHzmZooP+p4SzlrEtXvNGy9aCW/loMp4j+asnQOzHWro6i
         d5LBDHikgrKXVgjrwMdmvT0CkR3sGRucHZlKzdamjf/xEXuGgHBmx/q9xU4Upd84ECF/
         Qfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qAeET0XFBF0NFJ+3b5HtJwszp5opKJZYZqi2kTWVviY=;
        b=DYIwrFWrRW1QqdMIRGhbnlK30hMRMr5kUoaYhkIwxgjSB2kC3y8rEJa/BmLzlcsqYG
         YLaMasYra/yWjc4QLBSDBXO5I1ebB+m+4CH+ZAu6MVQ1CXJDIRRKWt0I29AvbAwbxhVi
         9Grsxm0GhGVBQXzDjZ+8t6MHG8CJlxKNWvDI1OCakYdx1NrQ/x1cHrz+quY2ESDAwkgt
         kwjBjnw1U+1tpvOs9sTgyRhNaD7bciz6OSIflQ7SQDpHua7hbcb8in6TfHb4kT0UdcUF
         cW/c61tC7ovvHw3+yiDbrPvnvBwoYSSBc+SayRUG5W3LXAtTaJvqK/JumBjqR9NFk+JN
         cXyw==
X-Gm-Message-State: ALKqPwcyRq5sJ2I93b7hE2ZvOhQzC/nVK+OwTUme24crg/Ht0mQq1pOY
        8LHmZ15vdMsbrdEWjW6UIY2w0U/99Cw=
X-Google-Smtp-Source: AB8JxZrAbkFJ8xOD0z3Xb9W13M0NWDO/Ecx5ALDT6kovzXmPH9xRsIh8xx7o2COHjJ4leXQCTeIDQw==
X-Received: by 2002:a17:902:8602:: with SMTP id f2-v6mr734037plo.5.1526095269973;
        Fri, 11 May 2018 20:21:09 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id e15-v6sm6993875pgt.50.2018.05.11.20.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:21:08 -0700 (PDT)
Date:   Fri, 11 May 2018 20:21:07 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com
Subject: [PATCH v2 1/2] grep.c: extract show_line_header()
Message-ID: <54b447cf2e5230a1e040fb4094f6108c071e2ce3.1526094978.git.me@ttaylorr.com>
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

Teach 'git-grep(1)' how to print a line header multiple times from
show_line() in preparation for it learning '--only-matching'.

show_line_header() comprises the code in show_line() executed in order
to produce a line header. It is a one-for-one extraction of the existing
implementation.

For now, show_line_header() provides no benefit over the change before
this patch. The following patch will conditionally call
show_line_header() multiple times per invocation to show_line(), which
is the desired benefit of this change.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/grep.c b/grep.c
index 5ba1b05526..36bf7cf08d 100644
--- a/grep.c
+++ b/grep.c
@@ -1369,26 +1369,9 @@ static int next_match(struct grep_opt *opt, char *bol, char *eol,
 	return hit;
 }
 
-static void show_line(struct grep_opt *opt, char *bol, char *eol,
-		      const char *name, unsigned lno, unsigned cno, char sign)
+static void show_line_header(struct grep_opt *opt, const char *name,
+                             unsigned lno, unsigned cno, char sign)
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
@@ -1417,6 +1400,29 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_columnno);
 		output_sep(opt, sign);
 	}
+}
+
+static void show_line(struct grep_opt *opt, char *bol, char *eol,
+		      const char *name, unsigned lno, unsigned cno, char sign)
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
2.17.0

