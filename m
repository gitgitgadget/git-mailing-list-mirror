Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510411F462
	for <e@80x24.org>; Sun, 28 Jul 2019 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfG1UHa (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 16:07:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45317 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 16:07:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so26878994pfq.12
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evRuYE59yAU8+x5jb/VcugvLxrYWiYhmp8ukI8OjWZQ=;
        b=azjj8FzKQ/4u9KrmU9/jfjuPWliWrYsET5uPOk4jcgzlUjjx3wsvU1HuASSjZW3VNH
         X5aNivhqdGioM+0gt2HSqpf5nx99e580cXnm2R9AvB5aMW8XbCxyQs/bwYzAx5DT48Gf
         bpcbXhuIWGH6lDQLn3XGu/TQvg2mJ9IMVgNFkin5LMwI4Lg2ZzRJy9UUx610KuJOs8Zf
         0oJT/c/Qr8bLqlHQp7nOqvTJt+xzh4vAMWZodJFalnvLxFP1a9LnZckgc/8uSfdUZZr1
         at7W4A+J914rvHpfMT4oSsn7vU0/LIDILzJ7zzkQJExKsdRNDkE/wcmOU8A4FMIqqnZn
         YeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evRuYE59yAU8+x5jb/VcugvLxrYWiYhmp8ukI8OjWZQ=;
        b=OD/Dp4hb8arkyEDNk+FESPanXgBvvS8OS6IxTeuH2q5p965o89BwQKjImqF9Sou8bD
         eY83aBZ+O5M5s0IL6VpufDthDQAg1mnoDqauN84fjciBGM4pbzUeBaPZ7z926gjsN/ur
         hLYTZ9hlZbrjGQmSNWUO45mgcHDhb4pNkMQrDvQxiVYhHD6k4KxNGQn6mQou5ALSiESo
         5ni4DZD7aenNQ4Pm8fSBrtH2DcCOhphPQ31b7AJbrQGSXE+VzxQPSQj+TrzfZkOIg+lo
         4aMQKVmfuLIxaxwydBN9OWOGNGhSwb/AcpDDcMz62ipdls3k2G0iZrlk2gwCUCgQE6fO
         hoiw==
X-Gm-Message-State: APjAAAXNRTZr22QWVoTiSN4GzfAq4zajINV0Y5JwjooXA50jYVrJX3tD
        WL+AbrpDWNKRswnOn4maGYDFneu5mPQ=
X-Google-Smtp-Source: APXvYqzC+n5n+B5z2BJm23+43KesdYixH3QrB7LPK6PwVd4be1iKOiaT1W5UTJ1w4/t3Y8qqkgujNg==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr101353184pgm.21.1564344448237;
        Sun, 28 Jul 2019 13:07:28 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z4sm92603491pfg.166.2019.07.28.13.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 13:07:27 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 1/5] verify-tag: drop signal.h include
Date:   Sun, 28 Jul 2019 13:07:20 -0700
Message-Id: <20190728200724.35630-2-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190728200724.35630-1-carenas@gmail.com>
References: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
 <20190728200724.35630-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

There's no reason verify-tag.c needs to include signal.h. It's already
in git-compat-util.h, which we properly include as the first header.
And there doesn't seem to be a particular reason for this include; it's
just an artifact from the file creation in 2ae68fcb78 (Make verify-tag a
builtin., 2007-07-27).

Likewise verify-commit.c has the same issue, probably because it was
created using verify-tag as a template in d07b00b7f3 (verify-commit:
scriptable commit signature verification, 2014-06-23).

These includes are probably just redundant, and not hurting anything by
circumventing the order that git-compat-util.h tries to impose, since
we'll always have loaded git-compat-util by the time we get to these. So
this is just a cleanup, and shouldn't fix or break any platforms.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/verify-commit.c | 1 -
 builtin/verify-tag.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 7772c07ed7..4e93914e59 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -12,7 +12,6 @@
 #include "repository.h"
 #include "commit.h"
 #include "run-command.h"
-#include <signal.h>
 #include "parse-options.h"
 #include "gpg-interface.h"
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 6fa04b751a..f45136a06b 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -10,7 +10,6 @@
 #include "builtin.h"
 #include "tag.h"
 #include "run-command.h"
-#include <signal.h>
 #include "parse-options.h"
 #include "gpg-interface.h"
 #include "ref-filter.h"
-- 
2.22.0

