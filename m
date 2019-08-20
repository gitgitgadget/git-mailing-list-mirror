Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECD01F461
	for <e@80x24.org>; Tue, 20 Aug 2019 03:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfHTDqB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 23:46:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37480 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfHTDqA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 23:46:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id 129so2482633pfa.4
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0macs/hK1yBjHdgz7dovt+Yjxve+3ei57QlSdsS9Ew=;
        b=scJVsP+Z4CWk49a5fCbKNzfa5oEW/8UA7+LR3mDTaRLs7bxV36615u7zAIYlQiD9os
         M/NvfIpJOlNqpEr5yC1iYBrZ3VU658bVSkcIrE5Yd0mzPAs4WfkYIzvdROyUBnOtQ9iw
         q1kM7+REjctxTf2X5esLVa4CbdDG0hRBBgeciF1ajb+UKooo7CaxVsdEnD5VBEjhNZhv
         BMW9E3NR+fG+sscDLFMFWtpSL2vUDOjHOX2kSYuXnsab9hi2lRTem1K4uOtMXPkwEN+I
         XAOzRZNdpHmkGBuOsJ9PJY/UTgae6PAsR+NpeoviuwwIAI95VjpN0jgoyBRpwQaIpVZW
         EU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0macs/hK1yBjHdgz7dovt+Yjxve+3ei57QlSdsS9Ew=;
        b=YzD68aIuW2l42I4s4s8RxjWw4VvvHRAWh5TMdX5iehDeZZgi39JICWru7R5HtwNKyf
         mVYpomQmzq3cA5ALTgGS2w8vitHwI77oFEy+jsCRrrmfUnnTQG5V5o18lns1UNfGF8ce
         kIDvCD9i9WMv/e5UoT+oNGct9Fh31bGwf9DN5PcjZzKAeP6fXbbrbofIHS2KIm2vu+8J
         aQD2o145iO+C0TP4uQj2jEf6capt06TJSQoYYO2v14QcMfTldhFrF+G3sIwPLHMJTk1a
         BO8NaUhTSulrpDDq+NbtxRBbaakh7685omCJK0k/EeepkA3Epj64b4jibk8BSJnZaXGB
         tKUQ==
X-Gm-Message-State: APjAAAV/KXlC3mXz+rXXoCRZqle6w0ghiHRbb59V9mCN+P6/Im8NAR9I
        WGf+tRS0lzZtDFQNzMmEfiO5jCX3XhM=
X-Google-Smtp-Source: APXvYqwB1E97mC0rh8iB157fi5rpGf0OtXSXb83Zbf4Lsj6GFL9SFLoWTzg1tBdKFciqPGMFe/RW4Q==
X-Received: by 2002:aa7:9293:: with SMTP id j19mr28692026pfa.90.1566272760054;
        Mon, 19 Aug 2019 20:46:00 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id v67sm30115686pfb.45.2019.08.19.20.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:45:59 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v3 4/6] sequencer: rename amend_author to author_to_rename
Date:   Tue, 20 Aug 2019 09:15:33 +0530
Message-Id: <20190820034536.13071-5-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of amend_author was to free() the malloc()'d string
obtained from get_author() while amending a commit. But we can
also use the variable to free() the author at our convenience.
Rename it to convey this meaning.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 29b67bc1ae..8f7b984333 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1424,7 +1424,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1445,7 +1445,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1534,7 +1534,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.21.0

