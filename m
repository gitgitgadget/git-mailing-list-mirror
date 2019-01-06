Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7F9211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 15:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfAFPrB (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 10:47:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45665 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfAFPrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 10:47:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so35707822edb.12
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 07:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CixAtOx4hrsKxD5+D+NeC1NXBvTPPG/T1rMDn8cOGpM=;
        b=FcZ/3WYTECle9yPpGvbC+syDARYDQ76Skgvsrggd7xFk38A7Dsmui5dGLsYw/puGop
         X3upAEEDoNqBju59Kf9MyKZKh4MIiajdQ7G4c6ZNLHQlowiSmztyYcnlRU5drGa8FfZd
         BLbA1wZyivPP9HpFwOAfMvBzztCAGGDVMC9HhlLaI/pEraUPiJ4cQOug3598Bu0qllmu
         Emmsvni8ZDSrayL0kctEpLwFdP9QMskCqBk7H/HfC1nclTfOIi6wmkXAX39PRnLH3x8F
         aV8+bw6mijZeS+1BJ9lbJQAA8hg5MZcjs8hq92QJxN8Ay9Lm20QOypYtrBBwKesFOyeu
         12IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CixAtOx4hrsKxD5+D+NeC1NXBvTPPG/T1rMDn8cOGpM=;
        b=TR+wmEwIrNW1XSSq6qwXwNnR5TAJBVlCQrV51s8mKIcyjrWCMEvhbcOrPA6jc8tPRN
         YoonYGr3QA07kbrddUwaS93EjYxGMQNqYBH7a5flLE365ZmirrnuMYlx6uTyO9/HkWKZ
         ugt5NB/yeWW8aQvGvT9xC6uMkF5fJXmzKe2A1ouxWScS8lOZe/Vtq7UX94Jfac00K7Ps
         t99k6xiRIFiDa7/5+w0Ob5rxfdHM3GUOpZ12gXF2Dd32LcQrNzI0kpZEAVe2DTTA6zVE
         RSUhw0edJxB601XgYIDGuSeXRiyM6tcv9eTphrDfR3jI3g+HxgtlRKIDa/UYGCA/6d9z
         DwGw==
X-Gm-Message-State: AJcUukeWf5pS3n18sfepAhnoNU6om9r4wgKUYUeD9qAEZ2Thbn0tmohf
        ZaWVJOuGmVT8k+oxK24/H0f4adO9
X-Google-Smtp-Source: ALg8bN6F7xOZ+DcuYVWIQdwRrrHzL/zB3tpKLh3Z7a4l9e+7O2fS73IYB9ZVGgaIb/UguemGgQSwqg==
X-Received: by 2002:a17:906:f108:: with SMTP id gv8-v6mr27354817ejb.173.1546789618821;
        Sun, 06 Jan 2019 07:46:58 -0800 (PST)
Received: from localhost.localdomain (5.84.115.78.rev.sfr.net. [78.115.84.5])
        by smtp.gmail.com with ESMTPSA id u7-v6sm16666616ejb.65.2019.01.06.07.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 07:46:57 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] helper/test-ref-store: fix "new-sha1" vs "old-sha1" typo
Date:   Sun,  6 Jan 2019 16:46:37 +0100
Message-Id: <20190106154637.10815-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.26.gc246996f60
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like it is a copy-paste error  made in 80f2a6097c
(t/helper: add test-ref-store to test ref-store functions,
2017-03-26) to pass "old-sha1" instead of "new-sha1" to
notnull() when we get the new sha1 argument from
const char **argv.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/helper/test-ref-store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index e9e0541276..799fc00aa1 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -233,7 +233,7 @@ static int cmd_update_ref(struct ref_store *refs, const char **argv)
 {
 	const char *msg = notnull(*argv++, "msg");
 	const char *refname = notnull(*argv++, "refname");
-	const char *new_sha1_buf = notnull(*argv++, "old-sha1");
+	const char *new_sha1_buf = notnull(*argv++, "new-sha1");
 	const char *old_sha1_buf = notnull(*argv++, "old-sha1");
 	unsigned int flags = arg_flags(*argv++, "flags");
 	struct object_id old_oid;
-- 
2.20.1.26.gc246996f60

