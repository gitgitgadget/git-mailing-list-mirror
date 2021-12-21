Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A004BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbhLUSGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240822AbhLUSF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC80FC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso94111wmf.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qk7OWItTzY/zhzBFtJSYFhrqUkHOCMHIT24pu++hZiw=;
        b=DPLdGnZfTFvpYHjshzBqvWpnK1wFU9Nx5b5PDnAS4Esg39KVuvZHWNzs4hXf61RKfM
         rmAs7vhBaDu+xKz03BY4O3Ay2dwSzlDfLLkcygwTMW+jn1ChymDY//nJQT96/vB+osdm
         srdLVOWRALhjATjtk3zKEQg0f5gDK4e8WvjWxiK9veWhVu9urW+cJDi97fZJvNSuo4HO
         OJEZdBHC77BFsMwo7Y6Owk9UNP0BXxnF8XJDhgpnkNiwbAp2+lZG7sNBlepi91gR1RC3
         DBGjy4xUW8k9iOykzBjKE9+klhjhFn+5hvF5i7YptHGEWIdX3u+yJKT5Hh00GpB1HszC
         yrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qk7OWItTzY/zhzBFtJSYFhrqUkHOCMHIT24pu++hZiw=;
        b=svI8pe3DmNeEpAlU0rP8hFDrLs+sAQdSTt5sPorBK2rCIykLpxomEEKV3xLOf/VlZu
         ziOuoMlSvMILINuAOQDJ3P8ln7cF09swNNzaYt8pAx5L5WhoNzYmBNRxCPzM6605g3+x
         Hs72lHxtlVJP44IaU3KirH1OSLGD0HL1Z28BqO3FWWDusxtu+u+DFr4Rn9lFy18BoxTo
         I21hRmwvUsKVJPgaeH/4v1z7AsVtOcYTmt5awGSFRPF/IdQ0BXhpl9ZDew6VSreACA0m
         hymm4xrw9SLl7rLxNDA3r0CsAWbB91aEwQvt4asusO/2saTEuyemRDDlaw0S2ZzMH9vP
         TGNQ==
X-Gm-Message-State: AOAM532r5po/YnqmKxnnJgXilA1CF50kWiSKSqRLzVRE60srMMBkl5NN
        X7Cdn72jimnZpXNkQ0XJDv+fg22WtHU=
X-Google-Smtp-Source: ABdhPJwPTSumNO0ytv+0j7dPCLeSLszyles1bgBN6p2pKPBRsOIIULUbLJn0iuKlhZhoKnPX47LnTg==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr3801763wmj.169.1640109954427;
        Tue, 21 Dec 2021 10:05:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n41sm1267020wms.32.2021.12.21.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:54 -0800 (PST)
Message-Id: <15600df925fb06ecf2c12afecd514f551a1bf7c2.1640109948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:45 +0000
Subject: [PATCH 6/9] diff: add ability to insert additional headers for paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In support of a remerge-diff ability we will add in a few commits, we
want to be able to provide additional headers to show along with a diff.
Add the plumbing necessary to enable this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c | 34 +++++++++++++++++++++++++++++++++-
 diff.h |  1 +
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 861282db1c3..a9490b9b2ba 100644
--- a/diff.c
+++ b/diff.c
@@ -27,6 +27,7 @@
 #include "help.h"
 #include "promisor-remote.h"
 #include "dir.h"
+#include "strmap.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -3406,6 +3407,33 @@ struct userdiff_driver *get_textconv(struct repository *r,
 	return userdiff_get_textconv(r, one->driver);
 }
 
+static struct strbuf* additional_headers(struct diff_options *o,
+					 const char *path)
+{
+	if (!o->additional_path_headers)
+		return NULL;
+	return strmap_get(o->additional_path_headers, path);
+}
+
+static void add_formatted_headers(struct strbuf *msg,
+				  struct strbuf *more_headers,
+				  const char *line_prefix,
+				  const char *meta,
+				  const char *reset)
+{
+	char *next, *newline;
+
+	next = more_headers->buf;
+	while ((newline = strchr(next, '\n'))) {
+		*newline = '\0';
+		strbuf_addf(msg, "%s%s%s%s\n", line_prefix, meta, next, reset);
+		*newline = '\n';
+		next = newline + 1;
+	}
+	if (*next)
+		strbuf_addf(msg, "%s%s%s%s\n", line_prefix, meta, next, reset);
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -4328,9 +4356,13 @@ static void fill_metainfo(struct strbuf *msg,
 	const char *set = diff_get_color(use_color, DIFF_METAINFO);
 	const char *reset = diff_get_color(use_color, DIFF_RESET);
 	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf *more_headers = NULL;
 
 	*must_show_header = 1;
 	strbuf_init(msg, PATH_MAX * 2 + 300);
+	if ((more_headers = additional_headers(o, name)))
+		add_formatted_headers(msg, more_headers,
+				      line_prefix, set, reset);
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
 		strbuf_addf(msg, "%s%ssimilarity index %d%%",
@@ -5852,7 +5884,7 @@ int diff_unmodified_pair(struct diff_filepair *p)
 
 static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
-	if (diff_unmodified_pair(p))
+	if (diff_unmodified_pair(p) && !additional_headers(o, p->one->path))
 		return;
 
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
diff --git a/diff.h b/diff.h
index 8ba85c5e605..289badf5643 100644
--- a/diff.h
+++ b/diff.h
@@ -395,6 +395,7 @@ struct diff_options {
 
 	struct repository *repo;
 	struct option *parseopts;
+	struct strmap *additional_path_headers;
 
 	int no_free;
 };
-- 
gitgitgadget

