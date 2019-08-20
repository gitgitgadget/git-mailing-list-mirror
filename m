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
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D241F461
	for <e@80x24.org>; Tue, 20 Aug 2019 03:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfHTDpx (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 23:45:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43628 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfHTDpx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 23:45:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so2008165pld.10
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9w8S4fXcsJ2KKO8Ai/5ozBpHXdZdUtqAvrTrr0R4Lk=;
        b=YAZn6nSIsyYA25spKDRM60quGI9wHpRElA03Hh7EU8MuWji8gQeb89A43Z3x2rEVXY
         RMW3ofWcgiViXIVOsevvoSz/vi2ejRauHQS9SomrU+gYGURdS0Un5c1eAhFvGwhq8G3m
         4p/Bo7yVm6dOC+r8NO/8649EpDEeVYFtaKvIMvZ/oy3jRChOQYi0uma9BcH0iAUK3HfB
         Io5nnS12erAO3VbpWVo9FhUUcVvqvWGB4kB69NnI1qxcXD/XH3pG/r6b0sx9faC2pQjv
         mpSrlL1ziCy7uridzoOrVaMWXLklzz3hx1RE1L8S/FQ4yp3iwOJs0KVMsLlZrC2yuv9G
         oMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9w8S4fXcsJ2KKO8Ai/5ozBpHXdZdUtqAvrTrr0R4Lk=;
        b=t5l3gdb6HSopVHaPKGQ2p88g814cXRaOqeij5A4ycx4pGw94JGGjFMUcCOvn5h4Jx9
         Z/O7AYJy67gxw8hnZ9oPdEW3G+lDf9MxjkNZOGTAgKhcfwU90OG8hkZPbDTsGDbCiVce
         WFbMyZ/SPKFM74UB5sfnmDWRZY8qEsqdJCHkKJcTn70DuDpc4AxJwq2vW6dklSil45fh
         ig7s2bLNscyWoUvMOYl2pa9pGiqcECCz9GgT3mN2WNfrIRaXMiJl1M+qKI0aN93skhAO
         D3SFri2wbmGbx0Dg5WWz/kqzh4SnlIQOsshu6w94TkzrCuo+/l3AH6Tf0i/6pVui9pLb
         n1iA==
X-Gm-Message-State: APjAAAVJamD7mbhG764pni96sSXGJZxPtvzAlN1aFDnBRUh2y3WbkUa8
        3UznPgYZpDD6gt1UFwD59aY=
X-Google-Smtp-Source: APXvYqw0vy9VYofbejn4w24bL1RALNJRFIXZ0flPD6JYZkuwr56dyqT6aTQBefgEg0pKwOUGoSE+cA==
X-Received: by 2002:a17:902:788b:: with SMTP id q11mr26002665pll.308.1566272752766;
        Mon, 19 Aug 2019 20:45:52 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id v67sm30115686pfb.45.2019.08.19.20.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:45:52 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v3 2/6] sequencer: add NULL checks under read_author_script
Date:   Tue, 20 Aug 2019 09:15:31 +0530
Message-Id: <20190820034536.13071-3-rohit.ashiwal265@gmail.com>
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

