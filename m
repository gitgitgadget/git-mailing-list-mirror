Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709741F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeACATV (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:21 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:45499 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeACATT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:19 -0500
Received: by mail-it0-f66.google.com with SMTP id z6so41288iti.4
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qeh3N67auV+wgc374vMB1RV+IureH6GNCXbUdmkuXxo=;
        b=qaW1skdpMCUbghPNrF8Bc/5tUeOzx2a4xlnE0tTE/iOsslES9eK4JDPEf7i0QxmZLw
         MWb6oT/Jb87PElpvzgIksAGjaKPQZ+HuI3kbFzV0BIR780gWNfvCuFSckOBQs0stvAdp
         sH31glEW8cMSgdPA29U+p+NNzqb5f+Ssd9f+lHmXG6VFBobW/O298727nkX3xlwCLKhd
         Mx3AsxH3yAiu4RcXzrqNtZYnXhD3faJ210V2KUbHMZ20K3Nr25n/9zGoS+6TFndPC9/5
         go4WqMiTXjFKeZMVz7Wla7U7tP6P377DrUxIPORtS7LNajKG/bXXcofZDIk7XZ1Bcm2m
         O+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qeh3N67auV+wgc374vMB1RV+IureH6GNCXbUdmkuXxo=;
        b=lzc0jGdKhXdytp/LEGjeXTlndRRJ+qiuxboofL6eMleavcns0LrbboR5MSm5Xx8NLr
         eCHvxllPOdt+4zuVKgtGn2dGAfw6yrICVlqQPPXkPKB0bMw7sIMJQEACH3qrDZTQpr8y
         D7fICxxlaBVVVxIg54Qwt4aboOJgUmRg5cTgJiYP6qopG2W08cb9Jgj0M5YwJrN1bEnA
         /GfNCRvoLIC0SyyqMc/pgkOsNqinaK6Ki5sCChfxGOGeKU/CX8ZBgekbgE5udOVjiaIJ
         LaXgqoTkbENZvAcz6TvPAj4mdhTapZShip4rwzZbnJM+TSFuxzP+r9hYlZYkS1Npbuvh
         lBNA==
X-Gm-Message-State: AKGB3mLbUs6E6Uy49f9J8PnuvIQS0fERxOFy+XaSDCDHicw/l1GrkAXz
        rObb9aK0jWgtZMsPaAw3XmOV/RW4bPE=
X-Google-Smtp-Source: ACJfBotTVXVIxmE+KbOpv2WZ8+gd92Xjqq/sTa427mRoouqeotXwa4r0DMwG9hZxM1zTmU6T5+pDGw==
X-Received: by 10.36.228.15 with SMTP id o15mr23095ith.46.1514938758321;
        Tue, 02 Jan 2018 16:19:18 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:17 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 25/26] remote-curl: create copy of the service name
Date:   Tue,  2 Jan 2018 16:18:27 -0800
Message-Id: <20180103001828.205012-26-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make a copy of the service name being requested instead of relying on
the buffer pointed to by the passed in 'const char *' to remain
unchanged.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index dae8a4a48..4086aa733 100644
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
2.15.1.620.gb9897f4670-goog

