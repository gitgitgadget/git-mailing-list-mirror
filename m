Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8233E1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfKFJUx (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37789 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbfKFJUx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so12174974pgu.4
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDhDKW2E7dMpVGKylbt8c+EiRHbEaCKSfM3/y/DtivI=;
        b=Pfpp8OsFJdeMm9MXsMJtJoh+mYZ02fccMUjcbCc8rBOlqnF0bBUTD0rbEzxYK286Zv
         VhpL/UeRtkOMCQaWEJfJGEQIn4dROZ051GtnzACr4HR+GDh2QQxLIaLVN/wDQDzWQSpz
         xgW15IjP4D6y9b2+/yyldPTrcCmMxSG/x1LcmDpS3aJ+W/ysNGZWO1Qumsd0O6bV9pie
         7ap63yqowEMrYxzg8kJhwh5VbsrXfqS8k8SA/I7oZfPkQqXipVwr/wYokHoCq/mddf80
         FgYpU/pWycC442HTT2bJW0MU8F0aO/CYVPcOttydomu2vHzT2dESNTaI0FIO7w9bLWEI
         /ASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDhDKW2E7dMpVGKylbt8c+EiRHbEaCKSfM3/y/DtivI=;
        b=RA57rsz1J1jm3/u80SazE2MU90ovCz9iD2yixzkmEobO/IQGxAd9LWphoziyCD6EnB
         09cy+TS3O+3913TYXi0gUhUKDbP/KZzznTvOJdeAJ2HSv5WMBFNyFriEca9gCAolAreo
         nYdkMFcyNw3JVJF0/RvFkdb2ybqC50m1eJ97u6W7foU5kVdjvSZ/+bcMIISFH0g8nsZF
         mSHZiTA3Tvh1sHi7PF3fwrbLNjYK4WmOM4EPxmikjpwYFQdxmFzQNKPt/Uo1DDr6y3Pk
         p+wJVrhdF4rG+tGHtZE2dwUui9C5R4T1fSe2yz2Byk/3JpZs02rK/a4722Wkbu/NS6d8
         CLow==
X-Gm-Message-State: APjAAAWoCpSBf78WOwnvthdz/g2vRc2I7oGZqpNdc4lttcqaNmKpCNKp
        x5wYTT9IgVChx6cTQa0tu+83ECyl
X-Google-Smtp-Source: APXvYqz0HEULwd5X4VamtVlIN7rOoH+UShp+Q0iWIwWNxZ7EHF0XtuLI8ulEZoF44R+GwD3D3v0rmA==
X-Received: by 2002:a17:90a:2947:: with SMTP id x7mr2416807pjf.136.1573032052379;
        Wed, 06 Nov 2019 01:20:52 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:51 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v3 7/8] sequencer: reencode old merge-commit message
Date:   Wed,  6 Nov 2019 16:20:05 +0700
Message-Id: <7f0df0f685544ab828a7f6569d5e50a975c423d3.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <cover.1573031848.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During rebasing, old merge's message (encoded in old encoding)
will be used as message for new merge commit (created by rebase).

In case of the value of i18n.commitencoding has been changed after the
old merge time. We will receive an usable message for this new merge.

Correct it.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 833a928929..d735d09f98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3374,7 +3374,8 @@ static int do_merge(struct repository *r,
 	}
 
 	if (commit) {
-		const char *message = get_commit_buffer(commit, NULL);
+		const char *encoding = get_commit_output_encoding();
+		const char *message = logmsg_reencode(commit, NULL, encoding);
 		const char *body;
 		int len;
 
-- 
2.24.0.4.g6a51fdd29c

