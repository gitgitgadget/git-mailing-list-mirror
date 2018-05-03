Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E19200B9
	for <e@80x24.org>; Thu,  3 May 2018 18:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeECStI (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:49:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35956 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECStG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:49:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id n10-v6so643853wmc.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L3pmWgOODhAsEd5i1sBWaHsJ7gbGsqaeoSZa4KdlsBk=;
        b=SwBfhckqZC6yFnaIoihl80F453wIRzTDQPK0XC3lLF4ZDo6MEQ4x5NBha/9HfrEaF0
         JWDnvs3u709Y3WRjWt6sto8M+uqqeK+eQZPeN5Zw3L1S6Qtlby9DBeZYjBbtzil2XpPO
         qW9SDnAZC1nN/wQqgAAUoTHyzIoub1WT0wuCmdjyDW2S0EU34+CsNMhElR9nisrK0Tbp
         QrCr/E4L/Ahad+IFLhCHSfQXIrdkz9CxwBuJfVNdrC6G/0Y5A7jqhFI0K9ud58S2432d
         amqMc1uNZfJWDjcPf5vNNSvjj0wAoirHDw6lrL4gl7NbvAhI+dm0bd1VgaK8DwzpqE+J
         wW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L3pmWgOODhAsEd5i1sBWaHsJ7gbGsqaeoSZa4KdlsBk=;
        b=ltlJfLS0TaKAIdsF8XEpAt/ecGvGYafEPo3WIf6lzZjGFNxUAILRNf7pGV1OD62kMW
         MHkpu+7lRBJxKizhdNvfPDbkEC0q+4XFxHc5lePAmVOINOqfErIp29SNUKG5gyaYqVbe
         jttO3DW95XwKwDT+gWmFpukDs1mLrd8VW6JotdwkcXii5XwBn56yiGrT6VjCdrqxnQEe
         SwU9Wi/sT8dkT8LDCWqwps55+2J+LilT1RI2AfuVQs3uAoLhHHc2MKfh1u7Gg2F3dOU6
         k6yrtWEtigU+9lzC0al04Yaj+GNGXT+clh21OWSpUf5D/zxuS84U14xO/E1xJJU6NQ2R
         /XGg==
X-Gm-Message-State: ALQs6tB74Uz5y0gyzb5F7l3h8N4Vf3fMHF3nINdhVVJI7fjytMMiZDxn
        7pjMml63FJpzbVh1QUAyEI949Zpt
X-Google-Smtp-Source: AB8JxZoZuBDairvF++oh+76UjclwfVsswbzCNRkCbFEjGjeeuyKlv+LyUpb1fNb4nkAJa+u0MujOTA==
X-Received: by 10.28.216.13 with SMTP id p13mr14940337wmg.32.1525373344691;
        Thu, 03 May 2018 11:49:04 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:a521:6b31:5c87:9e4b])
        by smtp.gmail.com with ESMTPSA id f83-v6sm198322wmh.32.2018.05.03.11.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 May 2018 11:49:04 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 5/7] git-svn: remove ''--add-author-from' for 'commit-diff'
Date:   Thu,  3 May 2018 20:48:28 +0200
Message-Id: <20180503184830.11889-6-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180503184830.11889-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
 <20180503184830.11889-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subcommand 'commit-diff' does not support the option
'--add-author-from'.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/git-svn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index d59379ee23..e9615951d2 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -707,7 +707,7 @@ creating the branch or tag.
 config key: svn.useLogAuthor
 
 --add-author-from::
-	When committing to svn from Git (as part of 'commit-diff', 'set-tree' or 'dcommit'
+	When committing to svn from Git (as part of 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by:` line, append a `From:` line based on the
 	Git commit's author string.  If you use this, then `--use-log-author`
-- 
2.16.2

