Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 649021F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeHMS6V (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44699 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeHMS6V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so12977871ljq.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7q1/KtdIT0hi/Ob5UHxHAqJd1aQ/PbOhBb9lJG1vb8=;
        b=oA3lbcFFgMceGLdXdprBo9E96HDszlKU3GKvk2aEzBNUKlO7OZxs2+6tvjqilt9l+o
         kN2/jVj96iR/LLBHs8swzV9f9AyYENbn8an/jAmSdjL23rjkcFcQ8F5VDJrcB2BHybot
         aQuuDL2nd05nyJbjK8fnhIvbnwqGyTJC9qkXBOeogvzncmchhiWWWzxAaAhfYRoxQCVI
         OzYRBpOUO8Gjg0q1arA3HzLylg4KzqrJwZuHfaCoaRNRRBVunrw5n2nR1qvoMbwpFSqx
         0Dukq7+c8jnuw1HjVqaXo5iy+QWKxgz3inhx8/BjGRdhj5cafwGfEk4rLC6NWKSolP/L
         fYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7q1/KtdIT0hi/Ob5UHxHAqJd1aQ/PbOhBb9lJG1vb8=;
        b=silG5+qVZVEvHJVDXIaTNicemKlSvu0wPn8MRUoc7p2VTGOwC7Hd1F08d+1Sp2+yrK
         cXhECRrYdfkQvwvKHUE7+D3ZYQKDx6myczau0g5DVjoCQcxW7o2t+fU2kBk+6maP4am5
         eiWEZDcU920oASaA/ksbzF5hvlEXxuqvJlQ9HuPRd7/Zv6MVzIWz7FSLKXN/SBfKKo+R
         /yTgJG9I05G1fCFtL9bpcitxttAJM4BYQHX7Qc8KBL76UH7VNofUEhc7yudepWa2Mpvl
         /o9Qmnjnk8uqoQS734DctXESnVzP+P8uC9x+d0qmGuHhYmsUxDncp4ag2II9xKl7BvtS
         5okQ==
X-Gm-Message-State: AOUpUlG+VnP3XSbezNRC/dIKikxc4ualx3H26tr4+JFTaps4NHHzYmDt
        +khDlr+Oj0UlTJ9uAzJ6EJQ2Shpw
X-Google-Smtp-Source: AA+uWPwmAQ1NT+SNoeVhFVPyKifTSkfJWM/+IQPON4rl7J0JNSDquf6u5fUW2eHc36DDBOwrOuJ2ig==
X-Received: by 2002:a2e:504d:: with SMTP id v13-v6mr12293839ljd.84.1534176926161;
        Mon, 13 Aug 2018 09:15:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/24] preload-index.c: use the right index instead of the_index
Date:   Mon, 13 Aug 2018 18:14:23 +0200
Message-Id: <20180813161441.16824-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 preload-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/preload-index.c b/preload-index.c
index d61d7662d5..71cd2437a3 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -58,7 +58,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce->ce_flags & CE_FSMONITOR_VALID)
 			continue;
-		if (!ce_path_match(&the_index, ce, &p->pathspec, NULL))
+		if (!ce_path_match(index, ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
 			continue;
-- 
2.18.0.1004.g6639190530

