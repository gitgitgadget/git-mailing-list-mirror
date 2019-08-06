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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B53B1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbfHFRj7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:39:59 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33268 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387734AbfHFRj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:39:57 -0400
Received: by mail-pg1-f176.google.com with SMTP id n190so1151417pgn.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PbaKQr7Ljt5B74y63NGQ7Ds9EGU+IxbhlHcxkhYMMUk=;
        b=sjlSteoFh9dM9Rw0E8xhkpArUgnMNpuRyF6rH5aTIEq2oX41dZWs2UCOcV76BZEqjc
         pfRDY3hfpksIeb/sSF/XTbKdKGncEXChAY4pcMPuN4LBLo39ULjGUdpF5xIlw47TnEyw
         vLHHyCVtvQgxkng1R+2YdP1GrILSAeiuN0ZqFSOGIDk04oKb8VHKS4B2RsP4EIa5WHnz
         JWhOdNckror46/G7JY92bxxjISUPGa7xFIWZZ8PtUhf9Pz4NYIH468KbxVjdn7yf1QuR
         TzQIl5H8X7H8FJ/kZvzyBFfQ/V5/wZtUjf/jWB3Pt5tKFuzQ3GUXVvlnf0o8i36NP0US
         u3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PbaKQr7Ljt5B74y63NGQ7Ds9EGU+IxbhlHcxkhYMMUk=;
        b=EZvtvM0Y3/f6VlyVWxwFQlZsY67+P3oo5NvX9Filrla+GTNnWSzbGOHCnnuuznFGOw
         r20WM7Ut/pNQhGnwtdov4eL0R92DyKIEnGieFqG0m2UbWFeZp/IW9GCW1W11W3+v3ayR
         fHkcwH+7QCjyAA5NT4gFv2HTNlbTjLTT0S6ROt+0Y9uqZRLrk3qwUGE0I+9uoQ18XWbb
         fFfniF01mGM0t1/Mt+EYhMBlKBRwMD4M6jA8+qAD3/CX2oxfL9tExGFDvITgD0xgMlVS
         irOyQiLogEAcuTdInQuCUi7KbNK0oN45jD/qoPm6gDXoUKIgOjUiB880R/+Npb/lzz+S
         oTlw==
X-Gm-Message-State: APjAAAV2JXst111SguVbAczXRe/RE1TN9wWxwwR065D44zHS3iG23k0Y
        cMXdZNFkBHGuHhsHFgbrZnk=
X-Google-Smtp-Source: APXvYqzd9XnkgR5fLbPUdYRnGlipp7zufdyqClIRVdBVpTquac7x4bW0wZVJGKjv0BUwsbqBTNJOHg==
X-Received: by 2002:a17:90a:bd8c:: with SMTP id z12mr4429268pjr.60.1565113196971;
        Tue, 06 Aug 2019 10:39:56 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.217])
        by smtp.gmail.com with ESMTPSA id z20sm139757104pfk.72.2019.08.06.10.39.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:39:56 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCHl 2/6] sequencer: add NULL checks under read_author_script
Date:   Tue,  6 Aug 2019 23:06:34 +0530
Message-Id: <20190806173638.17510-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_author_script reads name, email and author date from the author
script. However, it does not check if the arguments are NULL. Adding
NULL checks will allow us to selectively get the required value, for
example:

    char *date;
    if (read_author_script(_path_, NULL, NULL, &date, _int_))
	    die(_("failed to read author date"));
    /* needs to be free()'d */
    return date;

Add NULL checks for better control over the information retrieved.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..a2d7b0925e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -821,9 +821,19 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		error(_("missing 'GIT_AUTHOR_DATE'"));
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
-	*name = kv.items[name_i].util;
-	*email = kv.items[email_i].util;
-	*date = kv.items[date_i].util;
+
+	if (name)
+		*name = kv.items[name_i].util;
+	else
+		free(kv.items[name_i].util);
+	if (email)
+		*email = kv.items[email_i].util;
+	else
+		free(kv.items[email_i].util);
+	if (date)
+		*date = kv.items[date_i].util;
+	else
+		free(kv.items[date_i].util);
 	retval = 0;
 finish:
 	string_list_clear(&kv, !!retval);
-- 
2.21.0

