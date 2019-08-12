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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2739F1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfHLTqS (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:46:18 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34977 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:46:18 -0400
Received: by mail-pg1-f180.google.com with SMTP id n4so8276209pgv.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9w8S4fXcsJ2KKO8Ai/5ozBpHXdZdUtqAvrTrr0R4Lk=;
        b=RoHEjpFT1F6GRJzRscyVagQq/jzIgQ4fEf7yJLQ1FuO9MgXjzuz8b5dFgvkXo2mFgU
         6hyciQ/L0Xl3BO8Auveh+0S8+4HPLsWRjWUrdWdV+WKK1I7WsRVuhcmgCXXe0Xpoxkdc
         M9mtsgXExYmAh1/32Szq387fJJDvjOQ7Oue8KrctBvlpsFpRuxCM/pVWePrlkwI4GAN7
         Y5IshPXk9SNVdM+YRdFu74ZpZwTO4tK80Ro7ZmHYd7N7S6vt95UzOASw0y1i3OEa79m4
         ZXR0SNwnNRSpZ8T/I5gKJjmexVHZ+PDsJ+LYEPez0+w9N4du/S98tOqH8Gg7VsC5V+Rm
         bZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9w8S4fXcsJ2KKO8Ai/5ozBpHXdZdUtqAvrTrr0R4Lk=;
        b=LpioksIJ5dnbMmjUurPBpg/UHti544B8/Lyi+fYoAtIXlAGfEq/GF9ZF4PNgznuEvs
         FDX+AZ4JP9zXjVa9+7fCP8e4jKXct54c0hjuoJ+wkLa7S1ad0mG7WPUNZDuMKY/MnvCU
         EwU+cdQeaPwJdUDHNKJ817Nl/9rgYIQ7nY5vf8CFzOCt9FZUsSpccCTHuG1V5p6jAwNx
         RasLVte6NfP+aCoQ1pAH154e9jfne2WErITrRxTJDMFhTR9AWezu/t0bEyIX0qLkR8ZM
         9BF1ci7+l4f3LAXrGneBagQxNe03zM18/xpavt3QRxBdGhE3P7FRzHzQSFN21P2gij1m
         w2WA==
X-Gm-Message-State: APjAAAUBpxIk0Dn1wEy7YbPh8CNDRvQOEkFd3NI+EJC8dVjMkgUxE1mo
        SRcl+j0F54PAGq5v7DLSSmU=
X-Google-Smtp-Source: APXvYqwviBEqgtCYt6IDqtOcKKNIoLSLpwDqDKYZhuYPlMcA4ACeHBbM0SQEbA1c/R2oKjZIONs0qQ==
X-Received: by 2002:a63:1d2:: with SMTP id 201mr32431857pgb.307.1565639177024;
        Mon, 12 Aug 2019 12:46:17 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.228])
        by smtp.gmail.com with ESMTPSA id j187sm13275947pfg.178.2019.08.12.12.46.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:46:16 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 2/6] sequencer: add NULL checks under read_author_script
Date:   Tue, 13 Aug 2019 01:12:56 +0530
Message-Id: <20190812194301.5655-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
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
index 34ebf8ed94..30d77c2682 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -824,9 +824,19 @@ int read_author_script(const char *path, char **name, char **email, char **date,
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

