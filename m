Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250111F453
	for <e@80x24.org>; Sat, 27 Oct 2018 17:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeJ1CML (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 22:12:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39232 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1CMK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 22:12:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id a28-v6so989234ljd.6
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t07LjXaIVGSwXKRFYZianmEQvgudAPAVe9JpwwNL98U=;
        b=V2Q/WkjR7zExT03WuU/vjr8xmU/hjvmeb7QQM2E1sOUCjQsIdzWfEjMHY/3EgyL6eH
         vQpsd8KZZvgRBfhs9bmAO84/HdvUP/o8EUdfoKOb1eLBPP+nAN0UmoYIItTARJC7kLJw
         /xt2E1KO6iQKzM+43DskUgFDDh2BT5X7/2Wo1gOK4kOOh5QP245xqzG3LDEtwxCr+5JK
         6CYu+4QgihFa3N2ft4G7UsC0Q3/fcHmKt8rLji509fwhHgljECZVHmiM0mUgVnt2vc3N
         BZyxpCTLWThfPw84tyYwXxnDa4k40ymOwbQYbQcphY+fqCSByyDrb3h2AL/hbiuoQckV
         Ljng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t07LjXaIVGSwXKRFYZianmEQvgudAPAVe9JpwwNL98U=;
        b=oORy21Tjp/a3V+cokyYqnfiVDKj+5jcD1ndjA3tGp0J4Y7XIG8V3tGyeO1sWXHp70S
         zO05y3wQRAvGaDYbtbJ9qON1WzcKeD4g9YNtfPoFwTuu+3HUSkSpZ03VO0IHFWc0by7i
         hodPle5biFzpgRMUrXas6bp68YpyBJghpE/gTgFC4TX1PRACqqG2FyRF5aQ+RbMGruop
         6MgyDoWyTuXKn2tkvCML6+QJJIvpS7KiyTwFXZ/W5UqIwR+w5aYzr4zw7Fv3oSHEKEI0
         Qllwa/LLzEuctGyTY49htUddAtF7Tt3cSZWVp+gZBBAb9BfACTh/l4KJT11BiDYDp3Xa
         kiHg==
X-Gm-Message-State: AGRZ1gKxmGZGNhWqjc+ruzgScole0Rde5lPIvlpQTod3keYHj2MJVuSr
        hRKfZtyOVv548r/JUyOqxkvOiWfn
X-Google-Smtp-Source: AJdET5ejd30732ImYKOrqT1BxWtk5XfClcVtAYgbeej58vFgfx/o1mVzMdzbC2uVMjxjKuZ3TAFOWw==
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr5759635lja.60.1540661428354;
        Sat, 27 Oct 2018 10:30:28 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i185-v6sm2333517lfg.89.2018.10.27.10.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:30:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v2 10/10] read-cache.c: initialize copy_len to shut up gcc 8
Date:   Sat, 27 Oct 2018 19:30:08 +0200
Message-Id: <20181027173008.18852-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027173008.18852-1-pclouds@gmail.com>
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
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
index ba870bc3fd..4307b9a7bf 100644
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
2.19.1.647.g708186aaf9

