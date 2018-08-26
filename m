Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0666B1F428
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeHZNpm (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33523 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbeHZNpl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so10019492ljj.0
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKedY5BvHRin7j1lOQoJR9RnLEWVjrYkYDs8kMON0Mg=;
        b=ijb+xV8qIAmQ2hdVWAaE5xILVGCW0Hh1yVILIDTL8FXrw+SNs3QAB9xaAjW94TKOwN
         crZ6dT4uYfCgvd0j8fJ3bZRbKa46AAGJq8PDKWrmx6UcCAP5dDPBsXEBdMG5gs1F7MrY
         UjbyexyTLXC1IJkFCVqTzIs2kCbd7uGaENTcrR0qJ4Q1tjw77BcnIG7DSuaXD5WBfxrq
         3XIBj5LIzG3LwyyaMck7hwUzRqK2BquaehfTMi2qpLN71/PIFrl6MlEvUzk9A+ifzWge
         eD2Hq2HoRgvwik0XNZePfvq7JCZf8x6/0ZgyXByGPLpo0HWhjN9CyGnoCPtlDxj2I/nC
         INVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKedY5BvHRin7j1lOQoJR9RnLEWVjrYkYDs8kMON0Mg=;
        b=KU61dgT3L6rtyoubz+LWwhQ+j4Iim8Rt/4uBJGHQRbIL9AuF1wDLwgBZizGCg0LyMv
         A9cbZdEu8JH794JMgbJMnH02ytyRMvxa/MYTmTPddCs5hjwHrflyevG62vGEbLbJwUu2
         p0FfUhBPKxhEA8ppVmLHILEs/6TeM5ksIO+CUqOT0dvLEgEnYA394zC8vx12l4bfmyNX
         ls+w3fcilbrU2jAifrHfurmMDv7a0cL/qwT14UO+dqbCfQONZxVllArFCvrRLyyC2kbT
         7BRoebJLu/WTJOKnKoW+YskkS2c+4Xyne+MWXXmDwomtXwIBStKln+MlxZsCiM7ltqs+
         WGlg==
X-Gm-Message-State: APzg51AClxneJVJqpiPwJV0WS0hNoEk7c1/gGIRztU3cV/uNWFFu3bGm
        t5QKoYZFHPeyYz5abCPrw01PI3FP
X-Google-Smtp-Source: ANB0VdZBx5ZwD/31IKcJ6dosH/IFlYU+DRjQ8HgAdc5ks6Hzb174wxFzUKNyMoWyEhja+SoDAG6KnQ==
X-Received: by 2002:a2e:870b:: with SMTP id m11-v6mr6027350lji.2.1535277814305;
        Sun, 26 Aug 2018 03:03:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/21] line-range.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:09 +0200
Message-Id: <20180826100314.5137-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
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
index 7ee9e17d95..b1f3ca6735 100644
--- a/line-log.c
+++ b/line-log.c
@@ -574,7 +574,7 @@ parse_lines(struct repository *repo, struct commit *commit,
 		long begin = 0, end = 0;
 		long anchor;
 
-		name_part = skip_range_arg(item->string);
+		name_part = skip_range_arg(item->string, repo->index);
 		if (!name_part || *name_part != ':' || !name_part[1])
 			die("-L argument not 'start,end:file' or ':funcname:file': %s",
 			    item->string);
@@ -599,7 +599,7 @@ parse_lines(struct repository *repo, struct commit *commit,
 
 		if (parse_range_arg(range_part, nth_line, &cb_data,
 				    lines, anchor, &begin, &end,
-				    full_name))
+				    full_name, repo->index))
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

