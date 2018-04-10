Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A57F1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeDJSjW (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:39:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50601 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbeDJSjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:39:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id t67so28300953wmt.0
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=04u2p3KgZQ88F+wROGmwsrOVN1Wytgo59ArH6XX3SPE=;
        b=cUs5NUQmDvRLzGHaZrwZK7K9/Clya/tWPiI92QUfg4RGudOlpYvc1G4h31KmYdFKjH
         fIddj5/KxrMRist2iY1yJyZqiGB33AjnuV5XlAbx9ymOm3v6u8FXWGy30Iu4LAORZtbO
         gJBvIEYlst+b0JCFOp3QUpaC3HpA2Jywspbi/UVEImScYicQzgGI6HgQCCVMrlmXA1/R
         4rB+lQTolWJ3FQquZltn3bAIt3VaKev5C9hBfmEgRVMsIcSy3KtJvK3Meu+cO/eXn8jX
         4vCHgTUyYQ2fXitnTgxYHuvklPr8ZXMqxmdoqFqqDKKwU35XEvzt0pME5tjoBsZEq6XW
         Sl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=04u2p3KgZQ88F+wROGmwsrOVN1Wytgo59ArH6XX3SPE=;
        b=hyjCxgGr7M7+mQND6gjuGBHf4KM6qrIx3mS/jMySdczerk7nuPk4EZ/iWugUUN3D0g
         LuidvR0lpgExCsQzg62m2rGA+/sPrRA390ISLR4MWDQh2bqP6K51I/6AUaS2YIfqUgvI
         KiYqegWg4qjjyFmIzWksguuCw4s9XEFK0OD0AiQUTgV9Atzyt5CyWCMZjV3Y5rV7Avca
         EzMotzW89kDuR5CO/s5itLVPIvl3bhaho8j/eN5cDQECw3AX9guhZDDYySzAmtCVG8le
         wGzsGNh/7qyJ6zMcNjtv/+buBB3uNeRaqGTNdAj3OG8DFIREjismPdtfyqtitHbbjE49
         sGUg==
X-Gm-Message-State: ALQs6tAlHRxeksI9jsz0pTjSITZbWVvasZyRi0oLEl/4fSMocoLHsCN7
        +Q1wB0G1B5TmHziaUZkk378FTQ==
X-Google-Smtp-Source: AIpwx49QLVXXLyuTGRcpQTcW7WafPk2cj+ZqJaN2/scz46rlWyVN/4mDpCT2TNHfWyVBT10Xm8uo2g==
X-Received: by 10.28.122.15 with SMTP id v15mr390149wmc.91.1523385555117;
        Tue, 10 Apr 2018 11:39:15 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:91e0:5390:d305:a939])
        by smtp.gmail.com with ESMTPSA id z12sm2456108wrg.20.2018.04.10.11.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Apr 2018 11:39:14 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Wong <e@80x24.org>, Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 5/6] git-svn: commit-diff does not support --add-author-from
Date:   Tue, 10 Apr 2018 20:39:01 +0200
Message-Id: <20180410183901.11859-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-svn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 636e09048e..11aefadf7a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -700,7 +700,7 @@ creating the branch or tag.
 config key: svn.useLogAuthor
 
 --add-author-from::
-	When committing to svn from Git (as part of 'commit-diff', 'set-tree' or 'dcommit'
+	When committing to svn from Git (as part of 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by:` line, append a `From:` line based on the
 	Git commit's author string.  If you use this, then `--use-log-author`
-- 
2.16.2

