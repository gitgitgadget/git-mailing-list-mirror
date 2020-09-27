Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A569C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7E22389F
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkl1R0Qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgI0NQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0NQI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:16:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7078C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 77so8027533lfj.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Is63qXrgEioUL+Hsy1MzTxoyErJDjmHx/ZVlOmLE17w=;
        b=lkl1R0QyYQDQNFeeLMNzIaA8B195HxtvoFEm6fHk/GJqElRv9oe3xoHZUeqinSCr+e
         gPdml4XSXhLEenb1KlSK1Iij8et9bDpdfmsf1CKSm+Q8s4SkSs+9gc9GU3qg0WQNbOF8
         3uWJ3LghoJZv9FxIenyqC+/bJEfokS3XPqouFge/mBIlN5zAgcMwHMZ2wcWiOo7kcXvN
         ZaArt2WYJYTM8sM9AkliK9s9qRbS4v+AlE4eqpV+eAIabAL7TjENH29kdzWYlzgkJB1M
         8LsSLk0xQrgfPEAM4N/ElUckEBVq9eSUrE4dej+xyjGcg8FqCJPBsPz19Dp1t2nx+h/W
         LMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Is63qXrgEioUL+Hsy1MzTxoyErJDjmHx/ZVlOmLE17w=;
        b=ai3sLp+yL5cHfwnnKn9mPZAIkhNEb2TVGd453aAUCng5CiM0RhNZh9sgRopD0QGz8D
         qddAjd9S7pNnhNrXsjRIrRCveyurFY+6a2IYwN790OGfXfbL8ksqsUSFITjHPF9oq9/k
         zWGgEbzSuazLjKdH9mLq0gfchza1iYqQJuB7Bk2nq3rV+X4i/CPMZVtRK06EY/ZjzLFn
         3f14lRiDWqs9Ax4fLEj6mrAH+w505ffGT8vl8ZEXie1KfYLmtmEn+/OHdAo7UJRnJK4s
         VmLapwNupIUOYR03olWTLOohGLhQCOGIkbcy8JDt2QwgXeIOOTTIrFzVrOlYsyduZApA
         QzMQ==
X-Gm-Message-State: AOAM5316hM2SbF+UhrTq3ZjY5Auy4/x7U7ZH04KCsJIZsDCdckzTlZOK
        RMJngWXFtSO3G72YOuOuwppXS5mfC1c=
X-Google-Smtp-Source: ABdhPJxVZSU32Oy2Txv2jY0FzPy+dzfm08XCc/4B73BNSkRdjchEcBSStvq4UKJxIVYfSZVXoocAeA==
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr2735605lfg.552.1601212566077;
        Sun, 27 Sep 2020 06:16:06 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o8sm2487616lfa.44.2020.09.27.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:16:05 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/7] wt-status: replace sha1 mentions with oid
Date:   Sun, 27 Sep 2020 15:15:41 +0200
Message-Id: <734ea28effdcb8650ab5e6ac2aa5398400faf1c5.1600281351.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1600281350.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`abbrev_sha1_in_line()` uses a `struct object_id oid` and should be
fully prepared to handle non-SHA1 object ids. Rename it to
`abbrev_oid_in_line()`.

A few comments in `wt_status_get_detached_from()` mention "sha1". The
variable they refer to was renamed in e86ab2c1cd ("wt-status: convert to
struct object_id", 2017-02-21). Update the comments to reference "oid"
instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 wt-status.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c560cbe860..59be457015 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1232,7 +1232,7 @@ static int split_commit_in_progress(struct wt_status *s)
  * The function assumes that the line does not contain useless spaces
  * before or after the command.
  */
-static void abbrev_sha1_in_line(struct strbuf *line)
+static void abbrev_oid_in_line(struct strbuf *line)
 {
 	struct strbuf **split;
 	int i;
@@ -1282,7 +1282,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		strbuf_trim(&line);
 		if (!line.len)
 			continue;
-		abbrev_sha1_in_line(&line);
+		abbrev_oid_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
 	fclose(f);
@@ -1575,9 +1575,9 @@ static void wt_status_get_detached_from(struct repository *r,
 	}
 
 	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
-	    /* sha1 is a commit? match without further lookup */
+	    /* oid is a commit? match without further lookup */
 	    (oideq(&cb.noid, &oid) ||
-	     /* perhaps sha1 is a tag, try to dereference to a commit */
+	     /* perhaps oid is a tag, try to dereference to a commit */
 	     ((commit = lookup_commit_reference_gently(r, &oid, 1)) != NULL &&
 	      oideq(&cb.noid, &commit->object.oid)))) {
 		const char *from = ref;
-- 
2.28.0.277.g9b3c35fffd

