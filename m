Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2727B208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeHHSNu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:13:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36860 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHSNt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:13:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id k15-v6so1504152edr.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Uxa2zV4P3rLr3eRr1EkqKqJHpG633ElRM3EL2hjshk=;
        b=T+pfIFaKTjyTmAPb29RvlaGIfjf4sxRkZIz3JbKMuOFBPQk42WBLUdnGvk7xZYMyy3
         8vEdeF1c6DWevw4urZR21ry2j78adx8MXs7T+Yf4V3wp2BNEQe30qF+rg3RoYSnJjIeI
         ZUIZYa1Q7ywVjanSO8A2enifW6FGZpkYsRNDOIt9yfjI06mMLEZ7X6gkE5MP8bkGcW0M
         N2xGyAV5/7JZC0zREalYjVN3Tpns3mSKp5KJlQ8iJ+9R2wDW0cecO8c1T6rTma/H/mm5
         TrWuUIoAGWWRpZriOjB/KK2r0v1zU6XW32BxmpKL6wPJc4lGlKDey3laHwpz57hXdHy/
         pwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Uxa2zV4P3rLr3eRr1EkqKqJHpG633ElRM3EL2hjshk=;
        b=jMEph55nOvFSIh7N26MO2YXQCBpdfY4ZiV++i08qkmR9GIj3eyb3U4HuEu7+crwcie
         uNXDQCh794nv5gbqbD6jk0/Qs1lBOk0onVL48bMNHGb2U3sCCGoKjYXsREK6KQdbBWVs
         mMDPQY3/lEyKPIuzOXccf8BtFcmYo7a/RdrGJQRV1OlerLyRAgF3AbKQ2BCbsk2slIhH
         KYQ/OuO1fQsf1hFf+M2xCNdcq+HLgE5XheDKADY2uyW499CEa0loxhCAcMCr1LhNGX9y
         7nCLI2OVy0ZToQAiAmItO4gVtXRvNrJCW3/i1i24qLTOwfSTK7rse4uL8LPkBtBCGTVs
         7iTQ==
X-Gm-Message-State: AOUpUlHI6xVe9Xx/2U9JLujT6We4haqwC89ZvXvb+ldgN0y//Bvaf1aN
        Y8PM/Esdcr9PcBb9tclR1TuseogM
X-Google-Smtp-Source: AA+uWPynxZ3wVD0DAWc8y40N/AbKFdAk+pJl9YuWdfWVTbcG+8eFH2xAUds9OSUMT9OMWJwbYWrEXQ==
X-Received: by 2002:a50:b7db:: with SMTP id i27-v6mr4009265ede.284.1533743612005;
        Wed, 08 Aug 2018 08:53:32 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id j23-v6sm2564430edh.29.2018.08.08.08.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:53:31 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 1/1] rebase: default to using the builtin rebase
Date:   Wed,  8 Aug 2018 21:38:02 +0545
Message-Id: <20180808155302.23814-2-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808155302.23814-1-predatoramigo@gmail.com>
References: <20180808155302.23814-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the builtin rebase is feature-complete, we should use it by
default. Let's keep the legacy scripted version around for the time
being; Once the builtin rebase is well-tested enough, we can remove
`git-legacy-rebase.sh`.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4e69458161..c8d632b6f4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -54,7 +54,7 @@ static int use_builtin_rebase(void)
 	cp.git_cmd = 1;
 	if (capture_command(&cp, &out, 6)) {
 		strbuf_release(&out);
-		return 0;
+		return 1;
 	}
 
 	strbuf_trim(&out);
-- 
2.18.0

