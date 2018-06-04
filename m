Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32C71F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeFDOoV (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:44:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41099 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDOoU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:44:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so2922890wrq.8
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zliaOFa8MGeCgUKyUOvUwamoeII0dHb2OoPxgkPJbII=;
        b=oWeGCEhCUVsRWgMRhBGZ9oZzY1ettU0/2dMhoJRSNbQYhErJc2t5qMsSAemN5vPqdU
         X7Dh2u8kgsOkG0gnKcw26jN/BejoVuOMGr2gl4LkqBwIZ9ngx8tMd1qcWz/EZJ4YqlZd
         ErQab5RdwsCO2CNhXW3PTxdm4dMcybok2oY9DvhjaMFftSbuAIsLkraGkv+JLOxJUMuP
         1GT61E532F08fFTQXbmytI0iFwlQzoAX4QylF+qebk0smu1phMq1SJ3lduGl1+GaL1r+
         6qXdwWXAcbU1oZn5xiJbvJts3O4PBqmaR3msQfR8qIl8sUiy/CbJW9G+omElSBko/Us4
         xpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zliaOFa8MGeCgUKyUOvUwamoeII0dHb2OoPxgkPJbII=;
        b=VdREij9Dj9rrUBR3CL8i/GzAGmRRYcz7ftX+DR9TlU3vHXV1bllCjiPqv4wDjZTaTy
         xHk4Tj8v/eF9XCnP0rQx/UH7Co5wGUaOUbgpQIe9e2NeqB0cQSs2BDwR2DgDKeGnincl
         0ZNZUyxDxWvle82b6EC43kiyTXIi1uSPn3Kr+XGooydqR50eE4oCCGMWNLJBE9QWTMM1
         MPeQo9jZEI+Z38VVIDIUR1C5U29+1HxaciA05e/rn21khEoWeVdh8TyhE8yTGIj1Voky
         JeowNI3sroXPc1kICaohBfxj8gDItWstlq3cQ4gOm7FmbiDypNLrIFPJdhaap4gCVYYm
         tl5Q==
X-Gm-Message-State: APt69E1fFCi0Ld/0qVmkLRQS5ow+i7vYSOXUDe0t0TWv07BUlg7qoBIy
        scLlg6xLo5B6WeyRAFz5VlR4vgR+
X-Google-Smtp-Source: ADUXVKJfNQ6yXmBicdr0M2AACe79Wz7Y6micnShlhdjsfA94llfZty6zP6pedNWCO3/mvqmdVPAyoA==
X-Received: by 2002:a1c:f513:: with SMTP id t19-v6mr9712397wmh.50.1528123459428;
        Mon, 04 Jun 2018 07:44:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id n56-v6sm49781756wrn.72.2018.06.04.07.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Jun 2018 07:44:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] refspec: initalize `refspec_item` in `valid_fetch_refspec()`
Date:   Mon,  4 Jun 2018 16:43:05 +0200
Message-Id: <20180604144305.29909-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.43.gb85e7bcbff
In-Reply-To: <CAN0heSr6dPa+--Mut0+3Zgy-mWF0d2762vKU=d08CKhR8BnKmA@mail.gmail.com>
References: <CAN0heSr6dPa+--Mut0+3Zgy-mWF0d2762vKU=d08CKhR8BnKmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We allocate a `struct refspec_item` on the stack without initializing
it. In particular, its `dst` and `src` members will contain some random
data from the stack. When we later call `refspec_item_clear()`, it will
call `free()` on those pointers. So if the call to `parse_refspec()` did
not assign to them, we will be freeing some random "pointers". This is
undefined behavior.

To the best of my understanding, this cannot currently be triggered by
user-provided data. And for what it's worth, the test-suite does not
trigger this with SANITIZE=address. It can be provoked by calling
`valid_fetch_refspec(":*")`.

Zero the struct, as is done in other users of `struct refspec_item`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I found some time to look into this. It does not seem to be a
user-visible bug, so not particularly critical.

 refspec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index ada7854f7a..7dd7e361e5 100644
--- a/refspec.c
+++ b/refspec.c
@@ -189,7 +189,10 @@ void refspec_clear(struct refspec *rs)
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
 	struct refspec_item refspec;
-	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
+	int ret;
+
+	memset(&refspec, 0, sizeof(refspec));
+	ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
 	refspec_item_clear(&refspec);
 	return ret;
 }
-- 
2.18.0.rc0.43.gb85e7bcbff

