Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F46C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5322312D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbhASHoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbhASHoP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:44:15 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC827C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:43:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so12489466pgj.4
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVwqRHiCPVOdFvi8BGeDd6ox9vceEwe8HnBQfQjgJgU=;
        b=SaLBOSwSABrXT3CSCMXZBxTHXD0FUSbja6XNuO5EUZO62YCGG+6O+fvYl6HmkFf6w8
         qOPG2vjGvUj1BmWswuy6UM8eFJm9J8wzVwjsAh/5VBlneb7is+8SvZYxsnAvI/1tFB0i
         wBzIHWUFxYJFHdKPqeN3NAWOfQTYxfpDgW6ndQsFdU0rqvH91qVvU2SR/JooXMhEL4pg
         7yYxkMnsILBCVyNVPo2xW7rP4kwfDG/ZE1PkhFfd1RqHhOf4Jw/an99PiwowErcaOCdg
         UI+PwyHVZUQN1b24asEVFANSnKJCk4LRBZ7B846vsLAcFdmRzIRnzD2ve05aZIDBQlX3
         xyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVwqRHiCPVOdFvi8BGeDd6ox9vceEwe8HnBQfQjgJgU=;
        b=HRlUZaCK/9iC/ZdKwY3ESrDlzWA45TPronWto/9oJIrBW9Ln4Ud+mKYajCz8551+rK
         PzhF3OhS05tr9jILr7/kPvNTRxc2Bg/zX+3aPV4464jJI5ntVMxQkftKOz6KmjeoMSBt
         6L8wILmbgvA5DWelYsKPOmtBbTDGEdCTZod3+U1LtdPOG4nHfojHaZYq6qkg+Cp00/8f
         KowgfBMTH8p4/vVTMClHU9p8deOwr0E6hj7WxYxRXPQVOt+2OsgKLYTBL8U9cGMQB4XR
         m/5oNuYE50mWs8Sq2qqoSEIy9Uwet3QXTiXTd15G5vYu5fTLa/I4K/0s4XbZ5/znHRzY
         XaYQ==
X-Gm-Message-State: AOAM533RQyoEOIBxijdW7c89WZKbxvgjAFpKGE/Vn0SJ+B0jzW8Da2Bi
        H9NCMwzn+L7tEgRVfREwOKOnR8v6GfGXJg==
X-Google-Smtp-Source: ABdhPJwPBOvVGPxtno38ug6V5HBbvZnQKyKyIhxAcPGQD0sl3GevYJln4lZ9iLOi/VQ7XvXtgvuLLQ==
X-Received: by 2002:aa7:86cc:0:b029:1b8:c490:13e6 with SMTP id h12-20020aa786cc0000b02901b8c49013e6mr3151685pfo.78.1611042207095;
        Mon, 18 Jan 2021 23:43:27 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:43:26 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 1/9] rebase -i: only write fixup-message when it's needed
Date:   Tue, 19 Jan 2021 13:10:56 +0530
Message-Id: <20210119074102.21598-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
commands, there's no point in writing it for squash commands as it is
immediately deleted.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8909a46770..a59e0c84af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1757,11 +1757,10 @@ static int update_squash_messages(struct repository *r,
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
-		if (write_message(body, strlen(body),
-				  rebase_path_fixup_msg(), 0)) {
+		if (command == TODO_FIXUP && write_message(body, strlen(body),
+							rebase_path_fixup_msg(), 0) < 0) {
 			unuse_commit_buffer(head_commit, head_message);
-			return error(_("cannot write '%s'"),
-				     rebase_path_fixup_msg());
+			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-- 
2.29.0.rc1

