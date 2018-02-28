Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8772C1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965035AbeB1XYi (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:38 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:44475 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964933AbeB1XYg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:36 -0500
Received: by mail-yb0-f202.google.com with SMTP id t18-v6so2372793ybb.11
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=59CMT2PcXKc92mwvdi32NyIw2ppYZTYVpKRotxiTnCA=;
        b=i6U5IEGAkLABWE2YLSrgANKnlzdfpj90lz2E2lU7J9alAeg42z2R4ICMvv72r9MyIZ
         n3fly9W0Ops/BtieAi07aFy4MGS+td4KpzZ1bCjd8ykANNdahg78DckIFCB8FG1UFjB+
         aZw5QjuSUJchPpCeBzWyZP5OslFQLPJN+bKxY7OI0eN0vZzpRmR0QQSA2XX8JTLm33c0
         BmGcybjnKYjnP1MnhUyp1nyRoKB1A+LBCzb6iYFS3yT860DVF+TiUPWOX9JLWt1CA3Xz
         Tq9fytG+tw17YFjvHjxZhz1Pr09MiCdTlMsptSrQzufRnBWMm3p9BaqhLGs5Iw1vP4TK
         UVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=59CMT2PcXKc92mwvdi32NyIw2ppYZTYVpKRotxiTnCA=;
        b=USn/nmGI5cGquHsQJJlfcKNO75nqU91ogCDhePTe/AUGYqrKVAZ1ZX9/tPJoqPZUJT
         YkuSDsOQqlDz5GtaT5+L1zGyN+GfFPu6fkItkLOrsl0ednC7Snyp0BOtTvrYHLejrQwV
         udsdN2l+zM7lHBiVGs8+Xau1OVGTX80sT5msvVJfoGDORKfa5MRxU7tMkg1+aHMZVjJQ
         o5FzYe/oriA0z8mpYtz/dxsZ6/1y8cuorcG8m7SW1e38I7ZfcIJwLQxH7H/zu/V4BQFY
         JbBFLXYcYY5cs09bR31f/OmQztOvI6UQqrvLc2fasTD46n8hIQu2uIhCUAD8IQWjb3bX
         spWQ==
X-Gm-Message-State: APf1xPAt2ZElc/LyKVd8eyjOWO5+GGdmqjHBh26gCPqUC49fMa89Pcc5
        1B0CcLljQNZDmsZinOWHy4N27gTS8uh6pQXxEHfLWH8iwoc7pgMv2NHmmZ5+K9dsheSbmAllgDb
        sqZj/6nrXoCo9vD7u4HTGlreRls6TznFuiN0cC2lAjKthPP+JtkroK82CrQ==
X-Google-Smtp-Source: AG47ELun7rRmkQUXcuWwbm6dRx6R85wPfRWJKwJawLcFQzeHZ+xPprm3wrJm9ObrJe/klKu+5SLMVYur4ag=
MIME-Version: 1.0
X-Received: by 2002:a25:bad0:: with SMTP id a16-v6mr6652592ybk.72.1519860275324;
 Wed, 28 Feb 2018 15:24:35 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:46 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-30-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 29/35] remote-curl: create copy of the service name
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
2.16.2.395.g2e18187dfd-goog

