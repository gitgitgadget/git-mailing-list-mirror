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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC15C48BE5
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D61361287
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 18:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFLSpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 14:45:18 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37855 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLSpS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 14:45:18 -0400
Received: by mail-pl1-f172.google.com with SMTP id h12so4476744plf.4
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Nc0Z1x6WHDBzwo6jWloYVtfBI2Io9UjU37HB+erpig=;
        b=eO1OkNlogPaotNLl+zunwz8ZNFzEmSyblKcFwygWADhY0njHgrVuB95KkeawDXNDva
         /4p1sYP9zVPUpvL/s9W0K5pqtZS9m4WGR2PwU6LFxlO8ENmByG28/pVOoL/s1Add2xqq
         jUoQqlnaYxDn0dY8KcyovNrI3vaTVHU3TM48vQyBcE5aEWEHKkYQy0cOod4+d273wT9Q
         segUnPhaqJrFsXbzMBMM5uuYy2rPLVIomPtR34Ts4bme+RLjIEdxmMU7WMLhirlRfrC6
         ftyyt6ea1YqIZFQQqufFnXuuwL8Z+sXAcolnzI+ctNslZP6dJItHACyZWrGTFTks/Kji
         yrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Nc0Z1x6WHDBzwo6jWloYVtfBI2Io9UjU37HB+erpig=;
        b=XFiDWuj4/l7sfC22rwwrLqGxYwDVgYbYC/2EHNGLzoLpyc2iMNUV/EqJmNCzxUjqSo
         ajhPRapDiQJhX6h6lF+ljHGXl9Mnr14ZZu80zaMqcR4ekstaCKICgw6xuAttJfdLTkNC
         NE0iQ16ncnMockyV3frruxRmFgV9W2FVDKWM0wK9I3hUfUFTF7nVAgo1foeg0J/JtAGA
         1fNC8/tYHrEtL4MWcKtPELQjUAn7EEz4b/FusckMox8g4GAoqpt65pwJH9f/WF4HdnKl
         qTXMBkpPp0Kx8fmt0hs4ApH8EVGCMpjxXT2P7whjO7CSUF0TUNDtjw+hCs6XoYfnXiAz
         db4w==
X-Gm-Message-State: AOAM530Rap9ozdg0YqKCB5IbckO8AMPanedxzreEM4b/FjqYpsRq+UXa
        AkmO/yjdkl8s/HG81qZvCmqpgrSXjng=
X-Google-Smtp-Source: ABdhPJx+WU4Me1u7EBfOJ1xBX8q8g1jfCHA8j0zagl94nJ/fJBiCz+upiYwzdbALVlciAYkfYV+IuA==
X-Received: by 2002:a17:90b:3147:: with SMTP id ip7mr10622404pjb.8.1623523327484;
        Sat, 12 Jun 2021 11:42:07 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id h24sm8437748pfn.180.2021.06.12.11.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 11:42:06 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH resend] graph: improve grammar of "invalid color" error message
Date:   Sat, 12 Jun 2021 12:41:44 -0600
Message-Id: <20210612184144.6894-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without the "d", it sounds like a command, not an error, and is liable
to be translated incorrectly.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
Resending to make sure that this patch isn't forgotten.
---
 graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index c128ad0cce..e3828eb8f2 100644
--- a/graph.c
+++ b/graph.c
@@ -95,7 +95,7 @@ static void parse_graph_colors_config(struct strvec *colors, const char *string)
 		if (!color_parse_mem(start, comma - start, color))
 			strvec_push(colors, color);
 		else
-			warning(_("ignore invalid color '%.*s' in log.graphColors"),
+			warning(_("ignored invalid color '%.*s' in log.graphColors"),
 				(int)(comma - start), start);
 		start = comma + 1;
 	}
-- 
2.31.1

