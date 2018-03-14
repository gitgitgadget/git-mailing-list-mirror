Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA601FAE3
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeCNSd3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:29 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:39996 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeCNSdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:25 -0400
Received: by mail-qk0-f202.google.com with SMTP id z83so2686174qka.7
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pFPOgahYYmTpR0zYbEtapinckxWZTE+QUb6F4N5+RDs=;
        b=m8U6FLNTGoJcQKVPauDyWrB1LSo/ijLwUPHfl8Yzw1fxtdzZEp8wsIUMm2qGjjBvGf
         3mhDXmtRqWj9bGxGYIklXY6/z25RKHe0rlk5rw5kIHytQTvmA9TZgz3EV57Vq8FM5iL0
         aRHOGFm/dNjTnby19qv5xi7PVq0dtg5l6fvWsex+a9LCxp+WmYrSe+jYEPtILd5nTJDd
         MaKd8Kbbkjl0sx8XCT+b9flTi8A8gQwKMkywpXAFK/c/lj0wlfs7igZRljXby9zcnvpK
         nRARk/RWJIIiYA4HI+zatlnGK74+oTrMgSPHZPsSYjUVGQ7UOtVnCxU96a+XT+iGohoI
         xC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pFPOgahYYmTpR0zYbEtapinckxWZTE+QUb6F4N5+RDs=;
        b=ce11AlnE1n5At8usxEZQCSmPH6Eyl8Z7V5mnX0gwp/QWfv2/JIoFI0lAcvynMf4Ac2
         FsQTxnB2iDK6p4lZwkJVcWmy4av7DD6waCmMVy5/JP2E1NuJ1JDBjkHUG3ViZjaxHV/7
         ayGysuiv46dI6HOUqI1Gz0WyTsmpm10+dM5YZ1AggegBC+FtgaKpzYA1kk8ppCRqY1Ir
         /fTNynV+5clKG/SovfkzNQpMZRfFAHDBN9rloW5mgCw5whAAGaYfYwdeCthc5dA1ndIF
         8M4jjVudhQAVo2C7mBaDb3h9vMx+hCWy5uTahdv47hsXmeqGnLfKUpdFGog2wto4fgnw
         v1NQ==
X-Gm-Message-State: AElRT7HiD+DDLQBnp1uxbKVWixF4T3CrNpTTSOrViEf4q7vFWEzJpF3D
        4Ut7gde5lTd6GT2Kay/taq3njgrDDQmGG6sTYsyAC9yc5kfC4yVhmZ6M/koRGbdCM/PoLhJVzNR
        s2b/FMsg0YVMKQcpbM+gZ67KGa9n3u6+7dg806POxiozihgBwv6f4CItY5w==
X-Google-Smtp-Source: AG47ELukoh0j7zo/wsUg3kR1J+6cJdULNXh7EIJua/xTx822eXo+O3S9KGY0/Xnn0435MO/Xvz6WfikV46E=
MIME-Version: 1.0
X-Received: by 10.200.20.154 with SMTP id l26mr3588496qtj.26.1521052404735;
 Wed, 14 Mar 2018 11:33:24 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:06 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-30-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 29/35] remote-curl: create copy of the service name
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make a copy of the service name being requested instead of relying on
the buffer pointed to by the passed in 'const char *' to remain
unchanged.

Currently, all service names are string constants, but a subsequent
patch will introduce service names from external sources.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index dae8a4a48d..4086aa733b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -165,7 +165,7 @@ static int set_option(const char *name, const char *value)
 }
 
 struct discovery {
-	const char *service;
+	char *service;
 	char *buf_alloc;
 	char *buf;
 	size_t len;
@@ -257,6 +257,7 @@ static void free_discovery(struct discovery *d)
 		free(d->shallow.oid);
 		free(d->buf_alloc);
 		free_refs(d->refs);
+		free(d->service);
 		free(d);
 	}
 }
@@ -343,7 +344,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		warning(_("redirecting to %s"), url.buf);
 
 	last= xcalloc(1, sizeof(*last_discovery));
-	last->service = service;
+	last->service = xstrdup(service);
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-- 
2.16.2.804.g6dcf76e118-goog

