Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E8601F453
	for <e@80x24.org>; Tue, 23 Oct 2018 05:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJWNeT (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 09:34:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36047 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJWNeT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 09:34:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id l6-v6so74368pgp.3
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGz7yy3jTGV3sytmpajU0JXj+ppbmGB9uk9c8kQS5to=;
        b=XqY7/3pS3kFjLr2GLkAaM05DnL4CUArtDqEaQ5I7VrywntQOl1ATkQSYDcm07DNje3
         Nb3pFS7BX7LcPSW+EPGNaGhOVDPQaxzqNKiDdIbpD9rKBryQ/BkZQwVX/aw4iiBQpS2N
         byEYSYzHcqW2NW3BzuLsz3hAM5zJIO5SfsiW7c/KFN/DeJEIUwy5c7hfe3WNVH8+t4ls
         IC5MgvU/eucTecz5CP82SARfxQGJMaFZ3t/ifJOnUY0f8KXlDz7R5ctYR6fzZGkdU+oX
         3OU8KQCo+2z0waRbR5luQveW2Gb4hgjD9MsQysz/nkHktSqs8gcPj4oD7p/LDEVEFOb7
         gCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wGz7yy3jTGV3sytmpajU0JXj+ppbmGB9uk9c8kQS5to=;
        b=lA7t3XtXm6aaftgJ5Ca0zGa4lNqAx2hViyGAAN5QGeKNVIoxJ+bOJxzIsD0ZS/lorO
         +d1h5g5BDfQf7uZdMcn3lC+MmFlxtKa5SCfrZWYiXnDdL+TvMpUsBd3U++hnZ1mW++mc
         hnQP6tuLMuaUorHx0Ye0xCR0aW0asVhaZSa0YAFq5bPYDXr87FCoN4MeAh8kZGYishJs
         KopXf9oWkdyMaA+Cd5GDNQn3XRYEcS48H4SOJ2w21zj0UaSHdceTkQmIQxYw1lZzDM3d
         VPyI7N3cMjW2jxwnpWWnpMubbtDClAXopPNoclpe8o+o87J2hUepqXDbRCKQ/zL5sYGy
         Akbg==
X-Gm-Message-State: ABuFfoiEm/nPZ/k8u6JDrhiD5DSqjXFtQUwYtPIk07kDhdib+9u3iVqJ
        fWjLDO0z5BieCtmgMkWQvCV+/NRqPAA=
X-Google-Smtp-Source: ACcGV60c+dt0StO5YogtE3fwptCU5vwagvrgqvlSNOm9yJ7BKFDToyxZ5rup+S1nYYzRLZw8wtwsUA==
X-Received: by 2002:a63:6883:: with SMTP id d125-v6mr45614925pgc.451.1540271555259;
        Mon, 22 Oct 2018 22:12:35 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id q25-v6sm264594pfk.154.2018.10.22.22.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 22:12:34 -0700 (PDT)
From:   carlo <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, carlo <carenas@gmail.com>
Subject: [PATCH] compat: make sure git_mmap is not expected to write
Date:   Mon, 22 Oct 2018 22:12:16 -0700
Message-Id: <20181023051216.64266-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

in f48000fc ("Yank writing-back support from gitfakemmap.", 2005-10-08)
support for writting back changes was removed but the specific prot
flag that would be used was not checked for)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index 7f662fef7b..14d31010df 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -4,7 +4,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 {
 	size_t n = 0;
 
-	if (start != NULL || !(flags & MAP_PRIVATE))
+	if (start != NULL || flags != MAP_PRIVATE || prot != PROT_READ)
 		die("Invalid usage of mmap when built with NO_MMAP");
 
 	start = xmalloc(length);
-- 
2.19.1

