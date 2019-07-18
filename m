Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACBEE1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 19:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391116AbfGRTGJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 15:06:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35688 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbfGRTGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 15:06:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so6999258pgr.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PbaKQr7Ljt5B74y63NGQ7Ds9EGU+IxbhlHcxkhYMMUk=;
        b=V+NhhWZf2yC2nnZwwDTqr76yaaYfEiB+1rp6qpmImSaeA0QZqeLC5AD8CVBgEnxO29
         nDdgRRPFI9IzoGXb0T0yCFsVsM5httI+Rid0JtSHj+uFiXSsgNDJP3d+lFf0XBXPcYpV
         vh9jneILSBTUUsQqzwtifmA6JXNrgDcFBwM/aAVCTgx8/VVrmK1egu4HhXiOpnH8M560
         F46oFwK+KO1Je0j0oFdzJW0cxJd4VO1zjo6yROgmRc3g5sz6HPS6vUBT2TKTN4pB/Lw3
         NWVQRrAYSRXAPFJsTVmEcF24ZpVY33ID0jWbxBklhf+xvFL2S/7eoL3vtcdFh61GKh08
         SHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PbaKQr7Ljt5B74y63NGQ7Ds9EGU+IxbhlHcxkhYMMUk=;
        b=CNU4L6PV55HyI4d5IA3DfLznSzf1+lJLR5qhIKhQMhU45YP62L/Fb/FeSZf4ucRMsm
         ra1UXBOEe3RYa2HuoqkVMVTuBvYet6ZhGyi5vKNvS3Lezru/WRI3DJtJm/8/ejm/6rVh
         o3sCA47v94s1y7XfMPxKVJx7yvHHpKGwjjFpsh2OoH4ZpE+bcWFEnaDCCl9awOUNTZXO
         lJbfwyUm/0moai6/0A4oqyqW/Mjfzv60D+ym8BXX8YWB96Sldq+AkbttUIsAz7tQwWDl
         aNIoMUHQwFky9w6o6mUwIKkSZ5VmUlPWVM0FemZvb2ghH+bYJKDzlx0HBgKkZ97EvqN2
         bpBA==
X-Gm-Message-State: APjAAAUwy5c6mwytXfwBk839bKC8e1MHclB1zlCTg/gzkUHGfD7VvrEH
        3+FJfXxh+KrAIQS5QPSTb+A=
X-Google-Smtp-Source: APXvYqwmFDbsUXcXOpCsSKTYfNdsWHqFdT6TZNuGC/5M6vqFVVRhHYJ1brYnsKYQo+n4vobGGHfkDA==
X-Received: by 2002:a17:90a:9301:: with SMTP id p1mr52665570pjo.22.1563476768644;
        Thu, 18 Jul 2019 12:06:08 -0700 (PDT)
Received: from ar135.iitr.local ([27.63.78.254])
        by smtp.gmail.com with ESMTPSA id f88sm28237555pjg.5.2019.07.18.12.06.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 12:06:07 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Rohit <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: [GSoC][PATCH v2 1/2] sequencer: add NULL checks under read_author_script
Date:   Fri, 19 Jul 2019 00:33:13 +0530
Message-Id: <20190718190314.20549-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718190314.20549-1-rohit.ashiwal265@gmail.com>
References: <20190712185357.21211-1-rohit.ashiwal265@gmail.com>
 <20190718190314.20549-1-rohit.ashiwal265@gmail.com>
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

