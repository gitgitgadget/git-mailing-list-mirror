Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934A4CE7AB7
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjIVTu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjIVTuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:50:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1522A1A3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3226cc3e324so1763974f8f.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412247; x=1696017047; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QYVVdHrPAWl2KKMbyC9DOr1zeJak0o0M7WgUlM5b6c=;
        b=lNeAeV5WYF/PhqL8M2+1bH8AtYyxpC3fM/4hGfg3lYD7YE23W/Zj+gFwk/dFewIvAl
         qRqGSpDlnvTwnNSR1WeVsqbB1qlaVTpb2FazDF7njJnwsloXje5qqOGtAT0SPBT1LvRr
         qmFPLtz4tfBbA8G3UlkACvy3vzgFdW42qn7oUKGxgkGsmuM9X4uplAekxGLcWUwcba9F
         Ue18HOBM9/SQGQR97WNZPdEy9WWyx8ahJn+bQjN5dGJmAot+VT0ELM1zKOOntGN/wzpL
         z+HUNwaElA2cWYTL/mbO3Z/rfBpX7c6ugJjwLXaUAW6xdkDrYr/8G1ndi97+SbYoc8Mw
         eKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412247; x=1696017047;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QYVVdHrPAWl2KKMbyC9DOr1zeJak0o0M7WgUlM5b6c=;
        b=Y0OEE+h28iG9Tz8fW/1M6b1jP9uP8F2Bv895TN+E+AJOpYpTYSSDnewy7Qpb6HxG+W
         dwaTNjDjPMcVLdu/St8Rq7yHWT9VdekRQdMj4piEmXJVhtLbn3Q7I/A0Y5z4a729j7UQ
         RI40Gvr7EF2gbxwQJB0NJmGK3WyK+JZCNlyPcNvF/A1LlmojP/MShiltVQUHQqi6cOhz
         G42pJ1ZwxijG7iJ6D0JRQRTSqVo/+WOpRzFmfgA+EK8t+t6DTBcyCPy5joJAhl2/7bfv
         AQyi+cSeEX08UjkYIWHHxklMRk9a4OkVU1vBA0hizYnoMaz6W+nXIYP+g1vDSq8kOBc2
         y5fg==
X-Gm-Message-State: AOJu0YyFTmIw5fmbsHaCmg8fB8j/BqzHPgAzMJuZ17ZvphE9p9u3KbvA
        0nM51+UijplkpTSm10ydy3A2+Z915ns=
X-Google-Smtp-Source: AGHT+IGCxOAKpZzv6NfeHxCNesJXZ+OeInK5MdUDE6xOKtWc0RPPASLzkviSZ/0YCBjcceGZC932ug==
X-Received: by 2002:adf:ef83:0:b0:317:f714:3be6 with SMTP id d3-20020adfef83000000b00317f7143be6mr481523wro.61.1695412247244;
        Fri, 22 Sep 2023 12:50:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d21-20020adfa355000000b0031c5dda3aedsm2958220wrb.95.2023.09.22.12.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:47 -0700 (PDT)
Message-ID: <4f116d2550f6cf218477560a9e25dbe4c384a2a6.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:37 +0000
Subject: [PATCH v3 1/9] trailer: separate public from internal portion of
 trailer_iterator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The fields here are not meant to be used by downstream callers, so put
them behind an anonymous struct named as "internal" to warn against
their use. This follows the pattern in 576de3d956 (unpack_trees: start
splitting internal fields from public API, 2023-02-27).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 10 +++++-----
 trailer.h |  6 ++++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index f408f9b058d..de4bdece847 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1220,14 +1220,14 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	opts.no_divider = 1;
-	trailer_info_get(&iter->info, msg, &opts);
-	iter->cur = 0;
+	trailer_info_get(&iter->internal.info, msg, &opts);
+	iter->internal.cur = 0;
 }
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	while (iter->cur < iter->info.trailer_nr) {
-		char *trailer = iter->info.trailers[iter->cur++];
+	while (iter->internal.cur < iter->internal.info.trailer_nr) {
+		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
 		int separator_pos = find_separator(trailer, separators);
 
 		if (separator_pos < 1)
@@ -1245,7 +1245,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(&iter->info);
+	trailer_info_release(&iter->internal.info);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index 795d2fccfd9..ab2cd017567 100644
--- a/trailer.h
+++ b/trailer.h
@@ -119,8 +119,10 @@ struct trailer_iterator {
 	struct strbuf val;
 
 	/* private */
-	struct trailer_info info;
-	size_t cur;
+	struct {
+		struct trailer_info info;
+		size_t cur;
+	} internal;
 };
 
 /*
-- 
gitgitgadget

