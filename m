Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085D01F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfBJN1K (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39989 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfBJN1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so11785324wmc.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkM/ZGhDfJV4zUlu5bubd7IXS+rOC3pRapW96j2EDb8=;
        b=tzDTFMm3M1FerlkDahgOzfqDukS72DlCW3ReIeOB0IbwS3lUH9/AswlJl0hKlILGj6
         H/RVsJITyXMQ+EszLs4nkIzCJVY0Y2g5kvxjn9E4vYAw4F47TdPRxx4tnX+GcClKics+
         NWoULtaMdrbjIn+HmNFG3+FfURyydVssWXP2xRgcInN687KnZijxi5Db0hJr18TGSEA9
         RkaL0tm4hh489y59pKPUVDLxRnPZOpp9ncDAS/CWus9QNC89cPV1mM00MaRqxId5Xq52
         1d6LqZ2Sjtznv+/aY2vAMY+GvIAtA+4LJEvTRQi4lHQXXIkC5nepCQDrBiy9zjk64f9f
         SaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkM/ZGhDfJV4zUlu5bubd7IXS+rOC3pRapW96j2EDb8=;
        b=BJfRd0ev23JDmw9lMZ85hZI4RO7oh8ms9bHxsxNL39xLxVajm92JtNhAMMDLipasyt
         6sbDMWY4Xk5nZ1s6nNrsOnA2JB/0PlkRDbDoGVwwlAnXJ9oxb9YsSd9qOSfPzykiJydv
         JDjDEFu5q5pXSNsRopAhS0w3EPviRZqoe1VqqXvbb2yrxS7P5Lx75VoDQNIhQoY2mFRx
         KbAcYSYhnoBIwO1315M3ZVTvstsiXxoPVun030Wz7aAW76Okp/6/1colo4NIPKUJOxs0
         t3yQr7Zr7Fc8Y+KXbsRZoWofJrbOg2f/BeZDOwahuCEkuBXzrHvk990JWGLxpa/06wsY
         HZqA==
X-Gm-Message-State: AHQUAuZw5rGIRZVRW4qHw12D3NyN7xbUM82mKl45VyuIUnVwh9aDoQGs
        gjSSgw0jPA1Kx/4v37fjkyl9IDm1
X-Google-Smtp-Source: AHgI3IYReiFRWSTjDgVuOgbH2PYfS0JEfTEX5TxD+yAiYL4nMXmtwxRIiHDYGvCOaq3PYYvKd2kRIQ==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr5807196wrp.44.1549805227122;
        Sun, 10 Feb 2019 05:27:07 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:06 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 01/16] sequencer: changes in parse_insn_buffer()
Date:   Sun, 10 Feb 2019 14:26:33 +0100
Message-Id: <20190210132648.12821-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This clears the number of items of a todo_list before parsing it to
allow to parse the same list multiple times without issues.  As its
items are not dynamically allocated, or don’t need to allocate memory,
no additionnal memory management is required here.

Furthermore, if a line is invalid, the type of the corresponding
command is set to a garbage value, and its argument is defined properly.
This will allow to recreate the text of a todo list from its commands,
even if one of them is incorrect.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v6.

 sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index b68bca0bef..d605199a54 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2141,6 +2141,8 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 	char *p = buf, *next_p;
 	int i, res = 0, fixup_okay = file_exists(rebase_path_done());
 
+	todo_list->current = todo_list->nr = 0;
+
 	for (i = 1; *p; i++, p = next_p) {
 		char *eol = strchrnul(p, '\n');
 
@@ -2154,7 +2156,10 @@ static int parse_insn_buffer(struct repository *r, char *buf,
 		if (parse_insn_line(r, item, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
-			item->command = TODO_NOOP;
+			item->command = TODO_COMMENT + 1;
+			item->arg = p;
+			item->arg_len = (int)(eol - p);
+			item->commit = NULL;
 		}
 
 		if (fixup_okay)
-- 
2.20.1

