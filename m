Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11099EEB580
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 06:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjIIGQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 02:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjIIGQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 02:16:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED281BEA
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 23:16:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so31121915e9.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694240180; x=1694844980; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QYVVdHrPAWl2KKMbyC9DOr1zeJak0o0M7WgUlM5b6c=;
        b=X+fXcxZY/krVyh+BPh+XDtx7pPMaD8R6J6hQvo1M2MEcCcZasYokcvtByLXGgQr2Kj
         oCfXe0DvuQ4aITsJAMkZmaO+Svg29A6BXuH9Bu//Mb3zXLeLI/J0IXk6CXVDqE9viA8V
         MV1Pjhp0vDid7Vyp3d5DPZ3vAHpUhoLJ2Zgqq30B2TCvbI2tZS1cvdwMTkwCIJcIHjaP
         M6qjVBJ6I3jg57ju+ZwoDFW1lM0fpfw6dIzgn8+Ov7IFuqkftfz97p6LRb9mGJ5PlWkc
         h+eDga/ViuQYPbyPSRcA3BI7LA6WvDP48K9e/AARLVsyICZZsmJmBNxnD6Sl+KWj3oov
         ljLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694240180; x=1694844980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QYVVdHrPAWl2KKMbyC9DOr1zeJak0o0M7WgUlM5b6c=;
        b=mC4wdFFfQiaymgqQnNoJIqavFk/I67w+tlO7f7Lo/t+ydhYLi0MXen+AgPt1i+YZhb
         +UMcgtbFeNOpt5nLf8Dtens2il6zDrCFNqfRxw33vkOEYimxk36mqq8I3KI1WsACRo6Z
         YO4KKZU49Ls1X3FQ+0JMff9LsbXO0y1AaFz+AJ/EA7FmsM10Pgw/ESmnHuPuV4fYWzbV
         tE1nz6KGDgJ9j2hezBzbO+ts9J0t8ADHD0+b1ZJHShCzS1oNHOB5ACW6Y4d5JT+cHsms
         EnHNLip+vakbr+zU3fDqiYYDL61f2iYP8dxMRqj+FJNtcepoYPL98/gzGNl06OQtive4
         CY8Q==
X-Gm-Message-State: AOJu0YzIwjyMvAlL+8EQfKfqlV+ki8H77EUXQnDeTXueWoA8zVfCdwtR
        XL7JdtVsBrIEI73e8gWS9nHQvL0wOXo=
X-Google-Smtp-Source: AGHT+IFwNjYkJTadWXiDpnxx3rTpIIzZCq5u7d/FHmznAYjVR3+LaUQa3ADQKhU48jkZ44QvZeeQiQ==
X-Received: by 2002:a1c:4b03:0:b0:401:264b:5df7 with SMTP id y3-20020a1c4b03000000b00401264b5df7mr3821786wma.35.1694240179461;
        Fri, 08 Sep 2023 23:16:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a7bcd07000000b00401c595fcc7sm6899922wmj.11.2023.09.08.23.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:16:19 -0700 (PDT)
Message-ID: <4f116d2550f6cf218477560a9e25dbe4c384a2a6.1694240177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Sep 2023 06:16:12 +0000
Subject: [PATCH v2 1/6] trailer: separate public from internal portion of
 trailer_iterator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
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

