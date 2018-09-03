Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B151F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeICWby (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46113 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeICWbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id e23-v6so996794lfc.13
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkErIJVHJ634nLVnYNhvcvS+Q0gi126eVyuHWW6SqyI=;
        b=RiBGQQuNhxVzXOh4kqPEIqXzaEk7ZF+u8YiKoIGPpaDKPLXLKoDXvEDmIgmYWg43xC
         xoTHOYpsSQO2i0IEcOmghcjujzSdDlXImwmLtkPh1zQaSZnmU3VV9l92s+r7G/xin25M
         XADOvPYA8EiA11az3/Wy7Eo+wGtYWpWSrLpgXrMoyBCJc1CEihsu2+9Ux4bt9vsa8c+Y
         bebCAaB7PV0MqheeF+OYtfKEevKuHwjuFPTfLR3J/av+ufubZkAvidpVxUdSXyqA7qZB
         KG2SmCxoSJEVSaNaguuYTVVQfR3ziJHzuGs/tnLSJG6hsUkdJ7/0Im0Rc43rzaQqRRQy
         qUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkErIJVHJ634nLVnYNhvcvS+Q0gi126eVyuHWW6SqyI=;
        b=oU16xPQhaDLrAcfZ3amGnHKIp5+8dKiPP7THTIKdQLZM4X6R5c8zMkO0piaWZq42W4
         5mSIwv/oe4NKepxwvE5NWgsfj1gtwUzkvbupGbtuD+8glTdrRATmJ14jZlpqAotTInZT
         2B5g/nWeE4OF/m9KC5tZGjkqBMHsASvkpFZYxppono09uno3bMn9wBQ8cdcMhz6CaQqN
         dk3kozDiwCyh8qtbyrI3JUjNX9DzZO/S04+GvawJziklBdJRQipTfOqtNqT8EnGaMIFY
         NxUBSryAxm68PKoOiQbVD08qzzBwQkGe7QSqyMCnCoHm7qRs4CIpRpv8BeCoPG0UMdsZ
         HJgA==
X-Gm-Message-State: APzg51BNBBvS1sWEYlBoevXcuNQtZsAh6n0NTav/Z6nlhT8jb6F77k2V
        UsfDrThNMrS+TI6gQi8whXk+u8IU
X-Google-Smtp-Source: ANB0VdamExE4R9V+7yHnwLwz4kJiZKfMIfUEFAAxfhhRMGDUP07xV1FsuuxuDKsf/MnZrVCrHQ7HdQ==
X-Received: by 2002:a19:c94a:: with SMTP id z71-v6mr17937300lff.34.1535998232401;
        Mon, 03 Sep 2018 11:10:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 18/24] line-range.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:26 +0200
Message-Id: <20180903180932.32260-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/blame.c |  2 +-
 line-log.c      |  4 ++--
 line-range.c    | 22 ++++++++++++++--------
 line-range.h    |  6 ++++--
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index c2da673ac8..97632828db 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1001,7 +1001,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		long bottom, top;
 		if (parse_range_arg(range_list.items[range_i].string,
 				    nth_line_cb, &sb, lno, anchor,
-				    &bottom, &top, sb.path))
+				    &bottom, &top, sb.path, &the_index))
 			usage(blame_usage);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
diff --git a/line-log.c b/line-log.c
index 35adf199a5..d1d429d738 100644
--- a/line-log.c
+++ b/line-log.c
@@ -574,7 +574,7 @@ parse_lines(struct repository *r, struct commit *commit,
 		long begin = 0, end = 0;
 		long anchor;
 
-		name_part = skip_range_arg(item->string);
+		name_part = skip_range_arg(item->string, r->index);
 		if (!name_part || *name_part != ':' || !name_part[1])
 			die("-L argument not 'start,end:file' or ':funcname:file': %s",
 			    item->string);
@@ -599,7 +599,7 @@ parse_lines(struct repository *r, struct commit *commit,
 
 		if (parse_range_arg(range_part, nth_line, &cb_data,
 				    lines, anchor, &begin, &end,
-				    full_name))
+				    full_name, r->index))
 			die("malformed -L argument '%s'", range_part);
 		if ((!lines && (begin || end)) || lines < begin)
 			die("file %s has only %lu lines", name_part, lines);
diff --git a/line-range.c b/line-range.c
index 7fa0d8bba5..9b50583dc0 100644
--- a/line-range.c
+++ b/line-range.c
@@ -163,9 +163,10 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
 	}
 }
 
-static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_cb,
-					void *cb_data, long lines, long anchor, long *begin, long *end,
-					const char *path)
+static const char *parse_range_funcname(
+	const char *arg, nth_line_fn_t nth_line_cb,
+	void *cb_data, long lines, long anchor, long *begin, long *end,
+	const char *path, struct index_state *istate)
 {
 	char *pattern;
 	const char *term;
@@ -198,7 +199,7 @@ static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_
 	anchor--; /* input is in human terms */
 	start = nth_line_cb(cb_data, anchor);
 
-	drv = userdiff_find_by_path(&the_index, path);
+	drv = userdiff_find_by_path(istate, path);
 	if (drv && drv->funcname.pattern) {
 		const struct userdiff_funcname *pe = &drv->funcname;
 		xecfg = xcalloc(1, sizeof(*xecfg));
@@ -244,7 +245,8 @@ static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_
 
 int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 		    void *cb_data, long lines, long anchor,
-		    long *begin, long *end, const char *path)
+		    long *begin, long *end,
+		    const char *path, struct index_state *istate)
 {
 	*begin = *end = 0;
 
@@ -254,7 +256,9 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 		anchor = lines + 1;
 
 	if (*arg == ':' || (*arg == '^' && *(arg + 1) == ':')) {
-		arg = parse_range_funcname(arg, nth_line_cb, cb_data, lines, anchor, begin, end, path);
+		arg = parse_range_funcname(arg, nth_line_cb, cb_data,
+					   lines, anchor, begin, end,
+					   path, istate);
 		if (!arg || *arg)
 			return -1;
 		return 0;
@@ -275,10 +279,12 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 	return 0;
 }
 
-const char *skip_range_arg(const char *arg)
+const char *skip_range_arg(const char *arg, struct index_state *istate)
 {
 	if (*arg == ':' || (*arg == '^' && *(arg + 1) == ':'))
-		return parse_range_funcname(arg, NULL, NULL, 0, 0, NULL, NULL, NULL);
+		return parse_range_funcname(arg, NULL, NULL,
+					    0, 0, NULL, NULL,
+					    NULL, istate);
 
 	arg = parse_loc(arg, NULL, NULL, 0, -1, NULL);
 
diff --git a/line-range.h b/line-range.h
index d3c54e45aa..e69bf7c017 100644
--- a/line-range.h
+++ b/line-range.h
@@ -1,6 +1,8 @@
 #ifndef LINE_RANGE_H
 #define LINE_RANGE_H
 
+struct index_state;
+
 /*
  * Parse one item in an -L begin,end option w.r.t. the notional file
  * object 'cb_data' consisting of 'lines' lines.
@@ -23,7 +25,7 @@ int parse_range_arg(const char *arg,
 		    nth_line_fn_t nth_line_cb,
 		    void *cb_data, long lines, long anchor,
 		    long *begin, long *end,
-		    const char *path);
+		    const char *path, struct index_state *istate);
 
 /*
  * Scan past a range argument that could be parsed by
@@ -34,6 +36,6 @@ int parse_range_arg(const char *arg,
  * NULL in case the argument is obviously malformed.
  */
 
-const char *skip_range_arg(const char *arg);
+const char *skip_range_arg(const char *arg, struct index_state *istate);
 
 #endif /* LINE_RANGE_H */
-- 
2.19.0.rc0.337.ge906d732e7

