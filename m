Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084FD1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeKCR7y (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35171 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeKCR7y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so2879396lfi.2
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/0KAxyqB/aKIJtaarDb/9ksbM8gHld0fkv9bregI0Y=;
        b=niJ4PtJ3RF2l8v7ikHPekXuYymgLkqaTnXvHXDzGONvoScZj/WzOw2NvT32njSw6yX
         BPVgqEOSmRmh0LVlY2Y5fJDmABPwuxldJkaS+TVINPlt9HMQ08BVkhpOPSDJMJ/rUG1h
         ZZVId/gtpV3vVVbICHY7zq8/ZLPpQdHkTzxtCw4C4vDDcGsX1ZGGGkRhYNiYN+YOtCcv
         1pVOh9Tig453S6Nn6yTidKUpf9raWQuLhrO01cH9fmCoTLQmF90C9l/RcLoClFNho2sJ
         sHkbhCm32YQUpEw8VKGLhLKRn8kUl9s0L7XDaMM2OQ/+ZozHs3PSJvQEaarZq1k3kIhV
         h84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/0KAxyqB/aKIJtaarDb/9ksbM8gHld0fkv9bregI0Y=;
        b=hjDGIRMDTRwQnbNRrR8ufZLiJ+pgbB5T1Qol+NyjrdGuryIZdxstcB29DyYG5y9r0/
         5jtMtFh/CQjf7Pitmq7sSOZ1HQfvwHnI7/koXqQfzb5FREXqvF1vS+uhLU1mmrDm6xiJ
         CwanzYund8hLylvadce1evQyZfsn56Fcac6NK0IwvnDPts6Two8eEcFFn0yCLZbcnZ17
         tA3N3KilcJgxZLqXroFjQRO9JoiIsEYgoSC74iCMGCYXfXCOyNzmHB147lmIYlQMGR8m
         vg/3s8iIdfa2Kp1an69ZZjbk7NZQSBiYfmllgV/GC0s0rhzDEFkY5CAdho+zaCfzYtfy
         6JRw==
X-Gm-Message-State: AGRZ1gK7yiGsejCWMrfRjtpVzE+hAl5v3ykYM2O0nDQdpvbjno8RNCG+
        ePLbEUtdtB33BRziaoGbYTk=
X-Google-Smtp-Source: AJdET5cxoyC03J1v9jCKykY+qOdWDDqX/ycvDkfiTU4nL76d/3FBnwPUiX+AhmkoiSxe5xy9xJhTgg==
X-Received: by 2002:a19:5186:: with SMTP id g6mr8297969lfl.143.1541234956923;
        Sat, 03 Nov 2018 01:49:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 13/14] read-cache.c: initialize copy_len to shut up gcc 8
Date:   Sat,  3 Nov 2018 09:48:49 +0100
Message-Id: <20181103084850.9584-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported that when building with NO_PTHREADS=1,
-Wmaybe-uninitialized is triggered. Just initialize the variable from
the beginning to shut the compiler up (because this warning is enabled
in config.dev)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 00cd416816..c510f598b1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1746,7 +1746,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 	size_t len;
 	const char *name;
 	unsigned int flags;
-	size_t copy_len;
+	size_t copy_len = 0;
 	/*
 	 * Adjacent cache entries tend to share the leading paths, so it makes
 	 * sense to only store the differences in later entries.  In the v4
@@ -1786,8 +1786,6 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 				die(_("malformed name field in the index, near path '%s'"),
 					previous_ce->name);
 			copy_len = previous_len - strip_len;
-		} else {
-			copy_len = 0;
 		}
 		name = (const char *)cp;
 	}
-- 
2.19.1.1005.gac84295441

