Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB49E1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932273AbeBGBOa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:30 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:36407 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBGBO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:26 -0500
Received: by mail-ot0-f202.google.com with SMTP id g9so2164132otc.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=p96gjuA9cyaqjqNznzr1EvNbGzeIZmSzN2fz+eduiQc=;
        b=XXADkd4jTK52I5KX1szM7xtPpGuJPtDaRKqCtD6LoDJs6/n7wuRF5pFpHGvvxqVcb6
         kzepd74M7vSIIjPmUU1FU+MHJ0hJQPl2J6KwA6BhU+Lmk0g78As/Y8kBPSVC95hv8Lkc
         ksP8PaGiHolSKe6DU2SGdi8uRdRpj4whYguxKs3Vy2Cp74rltP96BJlurw1Ol0fvR0+a
         Q5k1tlrlqkXOi22dH22HUWvyrmAJCV3nOC5Jwc7ZM66Y3loLqGaiEWpmwTKYMYOkBkUn
         OEAvSKoEfBg2Ejy8YuP9ai3GS32vImN5MlEOIfAp+UdEsudpOX0mVP5QShuZRWoeXyXm
         NhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=p96gjuA9cyaqjqNznzr1EvNbGzeIZmSzN2fz+eduiQc=;
        b=iGQiKom+u5RVKQMlhPVqqgLRVxIOYNAFm7fPQ82adkDrPVVVqPbzdMtFnVt67i+tnB
         Xipi9cPFhaPM7Ug4WYjT3/TckS67EWHLtsDMd1cB7HcXWX3SCLv6OrZ3nXfW9pwR3gV2
         zVbA3df49I9V3Ex3aoZajYFwAn3xOHqi8wOL2AOicemp2kEoqpXsfwRk0b+z9eW6ODw4
         4DdXmYcLH37s+MSEqK2XN4YWX9JKBGYuLmNeiToF2IAoAGkRMy7bpXcfZrvZxdzZynL5
         3jGaMbbOZi3AZoYAUTZl6wipul5FrFzuiwb9vii5zpohZ6Epd/6dpXh7Txgy734vZoXU
         hjnQ==
X-Gm-Message-State: APf1xPCcQNt1s5O/2WvwG8pIaxrbEyVhl4cquD91Lb7btuMrBNmHZVMa
        lhGqNp6fH1dsTGKUMSyhWchMmECox/0o8ylnjD4wQIHZM0RmO71kI6p0w4YElysCnAoUquSmeRe
        y8uYOnbpurLiTxxRmRbAxyYhT3XOK7Yf0/1z8HhvvkN13UE4R43kD/lcz8g==
X-Google-Smtp-Source: AH8x227dnJ9lp6apDbrB8qC3SNUwFdREaC/k4LWEqCwiTZwMf4D2508+WZegypEoU/aVGLfH2ZE2inQLdgg=
MIME-Version: 1.0
X-Received: by 10.157.9.217 with SMTP id 25mr2146797otz.98.1517966066058; Tue,
 06 Feb 2018 17:14:26 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:07 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-31-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 30/35] remote-curl: create copy of the service name
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
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
2.16.0.rc1.238.g530d649a79-goog

